* NGSPICE file created from heichips26_analog_project.ext - technology: ihp-sg13cmos5l

.subckt heichips26_analog_project analog_0 analog_1 analog_2 clk ena rst_n ui_in[0]
+ ui_in[1] ui_in[2] ui_in[3] ui_in[4] ui_in[5] ui_in[6] ui_in[7] uio_in[0] uio_in[1]
+ uio_in[2] uio_in[3] uio_in[4] uio_in[5] uio_in[6] uio_in[7] uio_oe[0] uio_oe[1]
+ uio_oe[2] uio_oe[3] uio_oe[4] uio_oe[5] uio_oe[6] uio_oe[7] uio_out[0] uio_out[1]
+ uio_out[2] uio_out[3] uio_out[4] uio_out[5] uio_out[6] uio_out[7] uo_out[0] uo_out[1]
+ uo_out[2] uo_out[3] uo_out[4] uo_out[5] uo_out[6] uo_out[7] VAPWR VGND VPWR
X0 VAPWR VAPWR VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=0.28875n ps=0.61464m w=6u l=1u
X1 VGND VGND VGND VGND sg13_lv_nmos ad=0.34p pd=2.68u as=0.38482n ps=0.65456m w=1u l=1u
X2 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X3 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X4 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X5 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X6 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X7 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X8 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X9 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X10 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X11 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X12 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X13 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X14 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X15 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X16 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X17 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X18 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X19 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X20 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X21 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X22 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X23 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X24 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X25 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X26 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X27 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X28 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X29 VAPWR VAPWR VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=0 ps=0 w=6u l=1u
X30 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X31 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X32 VAPWR VAPWR VAPWR VAPWR sg13_lv_pmos ad=2.04p pd=12.68u as=0 ps=0 w=6u l=1u
X33 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X34 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X35 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X36 VGND VGND VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0 ps=0 w=1u l=1u
X37 VGND VPWR VGND VGND sg13_lv_pmos ad=3.4p pd=20.68u as=0 ps=0 w=10u l=10u
X38 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X39 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X40 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X41 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X42 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X43 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X44 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X45 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X46 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X47 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X48 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X49 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X50 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X51 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X52 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X53 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X54 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X55 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X56 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X57 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X58 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X59 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X60 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X61 VAPWR VAPWR VAPWR VAPWR sg13_lv_pmos ad=2.04p pd=12.68u as=0 ps=0 w=6u l=1u
X62 VGND VGND VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0 ps=0 w=1u l=1u
X63 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X64 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X65 VGND VGND VGND VGND sg13_lv_nmos ad=0.34p pd=2.68u as=0 ps=0 w=1u l=1u
X66 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X67 analog_1 analog_0 VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X68 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X69 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X70 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X71 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X72 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X73 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X74 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X75 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X76 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X77 analog_2 ui_in[0] VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X78 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X79 VAPWR analog_0 analog_1 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X80 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X81 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X82 analog_1 analog_0 VAPWR VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X83 VGND ui_in[0] analog_2 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X84 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X85 VGND VAPWR VGND VGND sg13_lv_pmos ad=3.4p pd=20.68u as=0 ps=0 w=10u l=10u
X86 VAPWR ui_in[0] analog_2 VAPWR sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X87 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X88 analog_2 ui_in[0] VGND VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X89 VGND analog_0 analog_1 VGND sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
.ends

