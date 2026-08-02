# -*- coding: utf-8 -*-
# SPDX-FileCopyrightText: 2026 The HeiChips Contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
# Author: Simon Dorrer
# Description: Transient plots for the analog project macro based on ngspice exports.
# Created: 06.05.2026
# Last Modified: 02.08.2026
# ============================================

# Imports
import os
import numpy as np
import matplotlib.pyplot as plt
import ngspice2python as ng
from pathlib import Path
# ============================================

# Plotting Configuration
# ============================================
# Interactive mode stays off: the plt.show() at the end of main() then blocks in the GUI
# event loop, which is what draws the windows in the first place. With plt.ion() the call
# returns immediately and nothing pumps that loop afterwards, so no window ever appears.
plt.close("all")

# Matplotlib Settings
# %matplotlib qt
# %matplotlib inline

# Pure Matplotlib text rendering (no external LaTeX dependency)
plt.rcParams.update({
    "text.usetex": False,
    "mathtext.fontset": "cm",
    "font.family": "serif",
    "font.size": 14,
})
# =========================================================================

def main():
    # Resolve data and output paths relative to this script
    script_dir = Path(__file__).resolve().parent
    data_dir = script_dir / "data"
    figures_dir = script_dir / "figures"
    figures_dir.mkdir(parents=True, exist_ok=True)

    # ------------------------------------------------------------------
    # 1. Load ngspice transient simulation data
    # ------------------------------------------------------------------
    ngspice_file = data_dir / "heichips26_analog_project_tb_tran.txt"

    time = ng.loadngspicecol(str(ngspice_file), "time")
    uio_in_0 = ng.loadngspicecol(str(ngspice_file), "v(uio_in_0)")
    analog_0 = ng.loadngspicecol(str(ngspice_file), "v(analog_0)")
    analog_1 = ng.loadngspicecol(str(ngspice_file), "v(analog_1)")
    analog_2 = ng.loadngspicecol(str(ngspice_file), "v(analog_2)")

    # Display-friendly axis scale
    time_ms = time * 1e3

    # ------------------------------------------------------------------
    # 2. Transient Plot (Voltages over Time)
    # ------------------------------------------------------------------
    uio_in_0_color = '#0c5da5'
    analog_0_color = '#ff6b35'
    analog_1_color = '#2f855a'
    analog_2_color = '#805ad5'

    fig1, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8), sharex=True)
    fig1.suptitle('HeiChips26 Analog Project - Transient Response')

    ax1.plot(time_ms, uio_in_0, color=uio_in_0_color, linewidth=2.4, label=r'$V_\mathrm{uio\_in\_0}$')
    ax1.plot(time_ms, analog_2, color=analog_2_color, linewidth=2.0, linestyle='--', label=r'$V_\mathrm{analog\_2}$')
    ax1.set_ylabel(r'$V$ (V)')
    ax1.grid(visible=True, which='major', linestyle='--', alpha=0.45)
    ax1.legend(loc='best')

    ax2.plot(time_ms, analog_1, color=analog_1_color, linewidth=2.0, label=r'$V_\mathrm{analog\_1}$')
    ax2.plot(time_ms, analog_0, color=analog_0_color, linewidth=2.0, linestyle='--', label=r'$V_\mathrm{analog\_0}$')
    ax2.set_xlabel(r'$t$ (ms)')
    ax2.set_ylabel(r'$V$ (V)')
    ax2.grid(visible=True, which='major', linestyle='--', alpha=0.45)
    ax2.legend(loc='best')

    plt.tight_layout()

    # ------------------------------------------------------------------
    # 3. Export transient figures and CSV
    # ------------------------------------------------------------------
    fig1.savefig(str(figures_dir / "heichips26_analog_project_tb_tran.svg"), bbox_inches='tight')
    fig1.savefig(str(figures_dir / "heichips26_analog_project_tb_tran.pdf"), bbox_inches='tight')
    np.savetxt(str(figures_dir / "heichips26_analog_project_tb_tran.csv"),
               np.column_stack((time_ms, uio_in_0, analog_0, analog_1, analog_2)), comments="",
               header="time_ms,uio_in_0,analog_0,analog_1,analog_2", delimiter=",")

    # ------------------------------------------------------------------
    # 4. Open the plot window (blocks until it is closed)
    # ------------------------------------------------------------------
    # Only open the interactive window when requested (sim-view-xschem sets
    # SHOW_PLOTS=1); batch/headless runs just save the figures and exit.
    if os.environ.get("SHOW_PLOTS"):
        plt.show()
    # ============================================

# Main Execution
if __name__ == '__main__':
    main()
# =========================================================================