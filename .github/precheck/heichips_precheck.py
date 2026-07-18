#!/usr/bin/env python3

# Copyright (c) 2025 Leo Moser <leo.moser@pm.me>
# SPDX-License-Identifier: Apache-2.0

import os
import re
import sys
import yaml
import shutil
import pathlib
import hashlib
import argparse

from typing import List, Type, Tuple, Optional, Literal

from librelane.common import Path, get_script_dir, mkdirp
from librelane.logging import info, err, warn
from librelane.config import Variable
from librelane.state import DesignFormat, State
from librelane.flows.sequential import SequentialFlow
from librelane.steps import (
    KLayout,
    Checker,
    Magic,
    Misc,
    Step,
    ViewsUpdate,
    MetricsUpdate,
    StepError,
    StepException,
)
from librelane.steps.klayout import KLayoutStep
from librelane.steps.checker import MetricChecker
from librelane.flows.flow import FlowError

ws_config_vars = [
    Variable(
        "HC_SLOT",
        Literal["small", "large", "tiny"],
        "The slot size of the design.",
    ),
    Variable(
        "HC_SUMMARY",
        str,
        "The project summary. This is a hack...",
    ),
]


@Step.factory.register()
class ReadLayout(KLayoutStep):
    """
    Reads in a layout and converts it to GDS.
    """

    id = "KLayout.ReadLayout"
    name = "Read the Layout"

    inputs = []
    outputs = [DesignFormat.GDS]

    config_vars = [
        Variable(
            "KLAYOUT_READ_LAYOUT",
            Path,
            "Path to the layout that is read in.",
        ),
    ]

    def run(self, state_in: State, **kwargs) -> Tuple[ViewsUpdate, MetricsUpdate]:
        metrics_updates: MetricsUpdate = {}
        views_updates: ViewsUpdate = {}

        input_view = self.config["KLAYOUT_READ_LAYOUT"]
        assert isinstance(input_view, Path)

        output_view = os.path.join(
            self.step_dir,
            f"{self.config['DESIGN_NAME']}.{DesignFormat.GDS.extension}",
        )

        self.run_pya_script(
            [
                sys.executable,
                os.path.join(
                    os.path.dirname(__file__),
                    "scripts",
                    "klayout",
                    "read_write.py",
                ),
                os.path.abspath(input_view),
                os.path.abspath(output_view),
            ]
        )

        views_updates[DesignFormat.GDS] = Path(output_view)

        return views_updates, metrics_updates


@Step.factory.register()
class CheckTopLevel(KLayoutStep):
    """
    Checks that the top-level cell equals DESIGN_NAME.
    """

    id = "KLayout.CheckTopLevel"
    name = "Check Top-Level Name"

    inputs = [DesignFormat.GDS]
    outputs = []

    def run(self, state_in: State, **kwargs) -> Tuple[ViewsUpdate, MetricsUpdate]:
        metrics_updates: MetricsUpdate = {}
        views_updates: ViewsUpdate = {}

        input_view = state_in[DesignFormat.GDS]
        assert isinstance(input_view, Path)

        self.run_pya_script(
            [
                sys.executable,
                os.path.join(
                    os.path.dirname(__file__),
                    "scripts",
                    "klayout",
                    "check_top.py",
                ),
                os.path.abspath(input_view),
                "--top",
                self.config["DESIGN_NAME"],
            ]
        )

        return views_updates, metrics_updates


@Step.factory.register()
class CheckSize(KLayoutStep):
    """
    Checks that the origin is at 0, 0 and the dimensions match the selected slot size.
    """

    id = "KLayout.CheckSize"
    name = "Check Slot Size"

    inputs = [DesignFormat.GDS]
    outputs = []

    config_vars = ws_config_vars

    def run(self, state_in: State, **kwargs) -> Tuple[ViewsUpdate, MetricsUpdate]:
        metrics_updates: MetricsUpdate = {}
        views_updates: ViewsUpdate = {}

        input_view = state_in[DesignFormat.GDS]
        assert isinstance(input_view, Path)

        self.run_pya_script(
            [
                sys.executable,
                os.path.join(
                    os.path.dirname(__file__),
                    "scripts",
                    "klayout",
                    "check_size.py",
                ),
                os.path.abspath(input_view),
                "--slot",
                self.config["HC_SLOT"],
            ]
        )

        return views_updates, metrics_updates


@Step.factory.register()
class ZeroAreaPolygons(KLayoutStep):
    """
    Find zero area polygons
    """

    id = "KLayout.ZeroAreaPolygons"
    name = "Find Zero Area Polygons"

    inputs = [DesignFormat.GDS]
    outputs = []

    def run(self, state_in: State, **kwargs) -> Tuple[ViewsUpdate, MetricsUpdate]:
        metrics_updates: MetricsUpdate = {}
        views_updates: ViewsUpdate = {}

        kwargs, env = self.extract_env(kwargs)

        input_gds = state_in[DesignFormat.GDS]
        assert isinstance(input_gds, Path)

        script = os.path.join(
            os.path.dirname(__file__),
            "scripts",
            "klayout",
            "zero_area.drc",
        )

        reports_dir = os.path.join(self.step_dir, "reports")
        mkdirp(reports_dir)
        lyrdb_report = os.path.join(reports_dir, "density.klayout.lyrdb")
        json_report = os.path.join(reports_dir, "density.klayout.json")

        info(f"Running KLayout zero area polygons check…")

        # Not a pya script
        subprocess_result = self.run_subprocess(
            [
                "klayout",
                "-b",
                "-zz",
                "-r",
                script,
                "-rd",
                f"input={os.path.abspath(input_gds)}",
                "-rd",
                f"topcell={self.config['DESIGN_NAME']}",
                "-rd",
                f"report={os.path.abspath(lyrdb_report)}",
            ],
            env=env,
        )

        subprocess_result = self.run_pya_script(
            [
                "python3",
                os.path.join(
                    get_script_dir(),
                    "klayout",
                    "xml_drc_report_to_json.py",
                ),
                f"--xml-file={os.path.abspath(lyrdb_report)}",
                f"--json-file={os.path.abspath(json_report)}",
                "--metric=klayout__zero_area_polygons__count",
            ],
            env=env,
            log_to=os.path.join(self.step_dir, "xml_drc_report_to_json.log"),
        )

        return views_updates, subprocess_result["generated_metrics"]


@Step.factory.register()
class CheckerKLayoutZeroAreaPolygons(MetricChecker):
    id = "Checker.KLayoutZeroAreaPolygons"
    name = "KLayout Zero Area Polygons Checker"
    long_name = "KLayout Zero Area Polygons Checker"
    deferred = False

    metric_name = "klayout__zero_area_polygons__count"
    metric_description = "KLayout zero area polygons count"

    error_on_var = Variable(
        "ERROR_ON_KLAYOUT_ZERO_AREA_POLYGONS",
        bool,
        "Checks for zero area polygon violations after KLayout.ZeroAreaPolygons is executed and exits the flow if any was found.",
        default=True,
    )
    config_vars = [error_on_var]


@Step.factory.register()
class Summary(Step):
    """
    Write the project summary
    """

    id = "Step.Summary"
    name = "Write the Project Summary"

    config_vars = ws_config_vars

    inputs = []
    outputs = []

    def run(self, state_in: State, **kwargs) -> Tuple[ViewsUpdate, MetricsUpdate]:
        summary = os.path.join(self.step_dir, "summary.md")
    
        with open(summary, "w") as ofile:
            ofile.write(self.config["HC_SUMMARY"])
    
        return {}, {}

# Copyright (c) 2026 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0
# This code snippet is taken from:
# https://github.com/TinyTapeout/tt-support-tools/blob/main/precheck/precheck.py
def power_pin_check(verilog: str, lef: str, uses_vapwr: bool):
    """Ensure that VPWR / VGND are present and have USE definitions,
    and that VAPWR is present if and only if 'uses_vapwr' is set."""
    verilog_s = open(verilog).read().replace("VPWR", "VDPWR")
    lef_s = open(lef).read().replace("VPWR", "VDPWR")

    # naive but good enough way to ignore comments
    verilog_s = re.sub("//.*", "", verilog_s)
    verilog_s = re.sub("/\\*.*?\\*/", "", verilog_s, flags=(re.DOTALL | re.MULTILINE))

    # this looks for a line beginning with "PIN", captures the name of the pin and the body up until its "END"
    PIN_PATTERN = re.compile(
        r"^\s*PIN (VPWR|VDPWR|VAPWR|VGND)\s*([\s\S]+?(?=^\s*END \1))",
        flags=re.MULTILINE,
    )

    for ft, s in (("Verilog", verilog_s), ("LEF", lef_s)):
        for pwr, ex in (("VGND", True), ("VDPWR", True), ("VAPWR", uses_vapwr)):
            if (pwr in s) and not ex:
                raise FlowError(f"{ft} contains {pwr}")
            if not (pwr in s) and ex:
                raise FlowError(f"{ft} doesn't contain {pwr}")

    for match in PIN_PATTERN.finditer(lef_s):
        pin, definition = match.groups()

        match pin:
            case "VPWR" | "VDPWR" | "VAPWR":
                if "USE POWER" not in definition:
                    raise FlowError(
                        f"{pin} does not have a corresponding 'USE POWER ;'"
                    )

            case "VGND":
                if "USE GROUND" not in definition:
                    raise FlowError(
                        f"{pin} does not have a corresponding 'USE GROUND ;'"
                    )

            case _:
                raise FlowError(f"unhandled {pin}")


class PrecheckFlow(SequentialFlow):

    Steps: List[Type[Step]] = [
        # Read the layout (gds, gds.gz and oas)
        ReadLayout,
        # Check that exactly one top-level cell exists
        # and that it matches "DESIGN_NAME"
        CheckTopLevel,
        # Checks that the origin is at 0, 0 and the
        # dimensions match the selected slot size.
        # Check also for forbidden layers.
        CheckSize,
        # Render the layout
        KLayout.Render,
        # Check the density
        #KLayout.Density,
        #Checker.KLayoutDensity,
        # Detect zero area polygons
        ZeroAreaPolygons,
        CheckerKLayoutZeroAreaPolygons,
        # Run KLayout antenna check
        KLayout.Antenna,
        Checker.KLayoutAntenna,
        # Run magic DRC
        Magic.DRC,
        Checker.MagicDRC,
        # Run KLayout DRC (filler cells)
        KLayout.DRC,
        Checker.KLayoutDRC,
        Summary,
    ]


def main(
    config_path,
    demo,
    tag,
    last_run,
    frm,
    to,
    skip,
    with_initial_state,
):

    with open(config_path) as ifile:
        config = yaml.safe_load(ifile)
    
    info(config)
    keys = ["project-name", "top-cell", "team-members", "slot-size", "analog-pins", "short-description", "long-description", "gds-path", "lef-path"]

    for key in keys:
        if not key in config:
            err(f"Config is missing a key ({key})")
            sys.exit(1)

    # Get PDK_ROOT and PDK
    PDK_ROOT = os.getenv("PDK_ROOT", os.path.expanduser("~/.ciel/gf180mcu"))
    PDK = os.getenv("PDK", "ihp-sg13cmos5l")

    os.environ["PDK_ROOT"] = PDK_ROOT
    os.environ["PDK"] = PDK

    supported_pdk = "ihp-sg13cmos5l"
    if PDK != supported_pdk:
        err(f"Precheck is only supported for {supported_pdk}. PDK = {PDK}")
        sys.exit(1)

    info(f"PDK_ROOT = {PDK_ROOT}")
    info(f"PDK = {PDK}")

    if not config["top-cell"].startswith("heichips26_"):
        err("'top-cell' must start with 'heichips26_'.")
        sys.exit(1)

    if config["top-cell"] in ["heichips26_analog_project", "heichips26_digital_project"]:
        if demo:
            warn("Please rename the 'top-cell' of your project. It can't be one of 'heichips26_analog_project' or 'heichips26_digital_project' and must be unique (important for integration).")
        else:
            err("Please rename the 'top-cell' of your project. It can't be one of 'heichips26_analog_project' or 'heichips26_digital_project' and must be unique (important for integration).")
            sys.exit(1)

    top_cell = config["top-cell"]
    
    if not config["slot-size"] in ["small", "large", "tiny"]:
        err("'slot-size' must be one of 'small', 'large' or 'tiny'.")
        sys.exit(1)
    
    slot = config["slot-size"]
    
    if not config["analog-pins"] in [0, 1, 2, 3]:
        err("'analog-pins' must be one of 0, 1, 2 or 3.")
        sys.exit(1)

    if config["analog-pins"] > 0 and config["slot-size"] != "small":
        err("'analog-pins' can only be used with 'slot-size' small.")
        sys.exit(1)

    gds = list(pathlib.Path(config_path).parent.glob(config["gds-path"]))
    if len(gds) > 1:
        err(f"'gds-path' can only refer to a single gds. ({gds})")
        sys.exit(1)
    input_layout = gds[0]
    
    lef = list(pathlib.Path(config_path).parent.glob(config["lef-path"]))
    if len(lef) > 1:
        err(f"'lef-path' can only refer to a single lef. ({lef})")
        sys.exit(1)
    input_lef = lef[0]
    
    header = list(pathlib.Path(config_path).parent.glob(config["header-path"]))
    if len(header) > 1:
        err(f"'header-path' can only refer to a single header. ({header})")
        sys.exit(1)
    input_header = header[0]
    
    design_dir = "."

    info(f"top_cell: {top_cell}")
    info(f"slot: {slot}")
    info(f"input_layout: {input_layout}")
    info(f"input_lef: {input_lef}")
    info(f"input_header: {input_header}")
    
    try:
        power_pin_check(input_header, input_lef, uses_vapwr=False)
    except FlowError as e:
        err(f"Power pin check failed: \n{e}")
        sys.exit(1)

    # Ensure that the descriptons have been edited
    short_hash = hashlib.sha1(config['short-description'].encode()).hexdigest()
    long_hash = hashlib.sha1(config['long-description'].encode()).hexdigest()
    
    info(f"short-description hash: {short_hash}")
    info(f"long-description hash: {long_hash}")

    if short_hash == "bdd28e472f149700f2eae68572b6c6ab2b11d0a6":
        if demo:
            warn("Please edit 'short-description' of your project.")
        else:
            err("Please edit 'short-description' of your project.")
            sys.exit(1)

    if long_hash == "f1b327515f56692eb97fd39e3e9a04c16338ea84":
        if demo:
            warn("Please edit 'long-description' of your project.")
        else:
            err("Please edit 'long-description' of your project.")
            sys.exit(1)

    team = "\n".join([f"- {person}" for person in config['team-members']])

    project_summary = f"""# Project Summary for {config['project-name']}

{config['short-description']}

Top cell: {config['top-cell']}
Slot size: {config['slot-size']}
Analog pins: {config['analog-pins']}

Team members:
{team}

## Description

{config['long-description']}
    """

    flow_cfg = {
        "DESIGN_NAME": top_cell,
        "KLAYOUT_READ_LAYOUT": input_layout,
        "HC_SLOT": slot,
        "HC_SUMMARY": project_summary,
        # Do not error on magic DRC violations
        "ERROR_ON_MAGIC_DRC": False,
        # Prevent false positive DRC errors
        #"MAGIC_GDS_FLATGLOB": [
        #],
        # Image render settings
        "KLAYOUT_RENDER_RESOLUTION": 4096,
        "KLAYOUT_RENDER_OVERSAMPLING": 3,
        "KLAYOUT_PROPERTIES": os.path.join(
            os.path.dirname(__file__),
            "sg13cmos5l_render.lyp",
        ),
    }

    # Run flow
    Flow = PrecheckFlow
    flow = Flow(
        flow_cfg,
        design_dir=design_dir,
        pdk_root=PDK_ROOT,
        pdk=PDK,
    )

    try:
        # Start the flow
        flow.start(
            tag=tag,
            last_run=last_run,
            frm=frm,
            to=to,
            skip=skip,
            with_initial_state=with_initial_state,
        )
    except FlowError as e:
        err("The precheck failed with the following exception: \n{e}")
        sys.exit(1)

    info(f"Precheck successfully completed.")


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--config", help="The configuration YAML.", required=True
    )
    parser.add_argument(
        "--demo",
        action="store_true",
        help="Run the precheck in demo mode. A few errors will be downgraded to warnings.",
    )
    
    parser.add_argument(
        "--run-tag",
        help="Use a tag for the run directory instead of the timestamp.",
    )
    parser.add_argument(
        "--last-run",
        help="Use the last run as the run tag.",
    )
    parser.add_argument(
        "--from",
        help="Start from a step with this id.",
    )
    parser.add_argument(
        "--to",
        help="Stop at a step with this id.",
    )
    parser.add_argument(
        "--skip",
        nargs="+",
        help="Skip these steps.",
    )
    parser.add_argument(
        "--with-initial-state",
        help="Use this JSON file as an initial state. If this is not specified, the latest `state_out.json` of the run directory will be used. If none exist, an empty initial state is created.",
    )

    args = parser.parse_args()

    main(
        args.config,
        args.demo,
        args.run_tag,
        args.last_run,
        getattr(args, "from", None),
        args.to,
        args.skip,
        args.with_initial_state,
    )
