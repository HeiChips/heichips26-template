# Copyright (c) 2025 Leo Moser <leo.moser@pm.me>
# SPDX-License-Identifier: Apache-2.0

import sys
import pya
import click

slot_sizes = {
    "small": (500, 200),
    "large": (500, 415),
    "tiny": (200, 200),
}


@click.command()
@click.argument(
    "input",
    type=click.Path(exists=True, file_okay=True, dir_okay=False),
)
@click.option(
    "--slot",
    type=str,
)
def check_top(
    input: str,
    slot: str,
):
    ly = pya.Layout()
    ly.read(input)

    # Check origin
    if ly.top_cell().dbbox().p1 != pya.DPoint(0, 0):
        print("[Error]: Layout origin is not at (0, 0)")
        sys.exit(-1)

    # Check dbu
    if ly.dbu != 0.001:
        print("[Error]: Database unit (dbu) is not 0.001um.")
        sys.exit(-1)


    # layer, required/forbidden, message
    layers = [
        # Forbidden
        {"layer": pya.LayerInfo(8, 22, "Metal1.filler"), "forbidden": True, "required": False, "message": "Please don't fill your design. It will be filled at a later step."},
        {"layer": pya.LayerInfo(8, 22, "Metal2.filler"), "forbidden": True, "required": False, "message": "Please don't fill your design. It will be filled at a later step."},
        {"layer": pya.LayerInfo(8, 22, "Metal3.filler"), "forbidden": True, "required": False, "message": "Please don't fill your design. It will be filled at a later step."},
        {"layer": pya.LayerInfo(8, 22, "Metal4.filler"), "forbidden": True, "required": False, "message": "Please don't fill your design. It will be filled at a later step."},
        {"layer": pya.LayerInfo(8, 22, "Metal5.filler"), "forbidden": True, "required": False, "message": "Please don't fill your design. It will be filled at a later step."},
        {"layer": pya.LayerInfo(8, 22, "TopMetal1.filler"), "forbidden": True, "required": False, "message": "Please don't fill your design. It will be filled at a later step."},
        {"layer": pya.LayerInfo(8, 22, "TopMetal2.filler"), "forbidden": True, "required": False, "message": "Please don't fill your design. It will be filled at a later step."},
        
        {"layer": pya.LayerInfo(67, 0, "Metal5.drawing"), "forbidden": True, "required": False, "message": "This layer is forbidden for ihp-sg13cmos5l."},
        {"layer": pya.LayerInfo(134, 0, "TopMetal2.drawing"), "forbidden": True, "required": False, "message": "This layer is forbidden for ihp-sg13cmos5l."},
        
        {"layer": pya.LayerInfo(66, 0, "Via4.drawing"), "forbidden": True, "required": False, "message": "This layer is forbidden for ihp-sg13cmos5l."},
        {"layer": pya.LayerInfo(133, 0, "TopVia2.drawing"), "forbidden": True, "required": False, "message": "This layer is forbidden for ihp-sg13cmos5l."},
        
        {"layer": pya.LayerInfo(125, 0, "TopVia1.drawing"), "forbidden": True, "required": False, "message": "Your design can only use layers up to Metal4."},
        {"layer": pya.LayerInfo(126, 0, "TopMetal1.drawing"), "forbidden": True, "required": False, "message": "Your design can only use layers up to Metal4."},
        
        # Required
        {"layer": pya.LayerInfo(189, 4, "prBoundary.boundary"), "forbidden": False, "required": True, "message": "Your design requires this layer as boundary."},
    ]
    
    error = False
    for layer_dict in layers:
        layer, forbidden, required, message = layer_dict.values()

        region = pya.Region(ly.top_cell().begin_shapes_rec(ly.layer(layer)))
        
        if forbidden and region.count() > 0:
            print(f"[Error]: {layer.name}: {message}")
            error = True

        if required and region.count() == 0:
            print(f"[Error]: {layer.name}: {message}")
            error = True

    if error:
        sys.exit(-1)

    # Check layout size
    layout_width = ly.top_cell().dbbox().width()
    layout_height = ly.top_cell().dbbox().height()

    print("Layout size:")
    print(f"layout width:  {layout_width}")
    print(f"layout height: {layout_height}")

    print("Expected slot size:")
    print(f"slot width:  {slot_sizes[slot][0]}")
    print(f"slot height: {slot_sizes[slot][1]}")

    if layout_width != slot_sizes[slot][0] or layout_height != slot_sizes[slot][1]:
        print(f"[Error]: Layout size does not match slot size {slot}.")
        sys.exit(-1)

    print(f"Layout dimension matches the selected slot size {slot}.")
    sys.exit(0)


if __name__ == "__main__":
    check_top()
