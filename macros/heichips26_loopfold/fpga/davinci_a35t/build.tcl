# SPDX-FileCopyrightText: 2026 Ruijue Luo and contributors
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

set script_dir [file dirname [file normalize [info script]]]
set repo_root  [file normalize [file join $script_dir ../..]]
set build_dir  [file join $script_dir build]

file mkdir $build_dir
create_project loopcache_davinci_a35t $build_dir -part xc7a35tfgg484-2 -force

add_files -fileset sources_1 [list \
    [file join $repo_root third_party/picorv32/picorv32.v] \
    [file join $repo_root macros/heichips26_loopfold/rtl/loopcache_frontend.sv] \
    [file join $repo_root macros/heichips26_loopfold/rtl/narrow_mem_bridge.sv] \
    [file join $repo_root macros/heichips26_loopfold/rtl/loopcache_soc.sv] \
    [file join $script_dir rtl/uart_tx.sv] \
    [file join $script_dir rtl/uart_reporter.sv] \
    [file join $script_dir rtl/link_bram_backend.sv] \
    [file join $script_dir rtl/davinci_top.sv] \
    [file join $repo_root firmware/loopcache_test.hex] \
]

add_files -fileset constrs_1 [file join $script_dir constraints/davinci_a35t_minimal.xdc]

set_property top davinci_top [current_fileset]
set_property file_type {Memory Initialization Files} [get_files [file join $repo_root firmware/loopcache_test.hex]]

update_compile_order -fileset sources_1

synth_design -top davinci_top -part xc7a35tfgg484-2
opt_design
place_design
route_design

report_utilization -file [file join $build_dir utilization.rpt]
report_timing_summary -file [file join $build_dir timing_summary.rpt]

write_bitstream -force [file join $build_dir loopcache_davinci_a35t.bit]
