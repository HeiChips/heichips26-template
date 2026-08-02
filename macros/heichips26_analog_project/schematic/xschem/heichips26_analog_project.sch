v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 1710 -1280 {}
P 4 5 1720 -1280 2120 -1280 2120 -500 1720 -500 1720 -1280 {fill = false
dash = 16}
T {HeiChips 2026 - Analog Project} 830 -1700 0 0 1 1 {}
T {Decoupling} 1730 -1270 0 0 0.4 0.4 {}
N 1200 -800 1200 -780 {lab=VAPWR}
N 1200 -700 1200 -680 {lab=VGND}
N 1200 -1080 1200 -1060 {lab=VAPWR}
N 1200 -980 1200 -960 {lab=VGND}
N 1080 -740 1140 -740 {lab=analog_0}
N 1080 -1020 1140 -1020 {lab=ui_in[0]}
N 1280 -1020 1340 -1020 {lab=analog_2}
N 1280 -740 1340 -740 {lab=analog_1}
N 1920 -800 1920 -760 {lab=VAPWR}
N 1860 -720 1890 -720 {lab=VGND}
N 1860 -720 1860 -620 {lab=VGND}
N 1920 -620 1980 -620 {lab=VGND}
N 1980 -720 1980 -620 {lab=VGND}
N 1950 -720 1980 -720 {lab=VGND}
N 1920 -620 1920 -580 {lab=VGND}
N 1920 -720 1920 -620 {lab=VGND}
N 1860 -620 1920 -620 {lab=VGND}
N 500 -1320 540 -1320 {lab=clk}
N 500 -1300 540 -1300 {lab=ena}
N 500 -1340 540 -1340 {lab=rst_n}
N 500 -1260 540 -1260 {lab=uio_in[7]}
N 500 -1240 540 -1240 {lab=uio_in[6]}
N 500 -1220 540 -1220 {lab=uio_in[5]}
N 500 -1200 540 -1200 {lab=uio_in[4]}
N 500 -1180 540 -1180 {lab=uio_in[3]}
N 500 -1160 540 -1160 {lab=uio_in[2]}
N 500 -1140 540 -1140 {lab=uio_in[1]}
N 500 -1120 540 -1120 {lab=uio_in[0]}
N 500 -1080 540 -1080 {lab=ui_in[7]}
N 500 -1060 540 -1060 {lab=ui_in[6]}
N 500 -1040 540 -1040 {lab=ui_in[5]}
N 500 -1020 540 -1020 {lab=ui_in[4]}
N 500 -1000 540 -1000 {lab=ui_in[3]}
N 500 -980 540 -980 {lab=ui_in[2]}
N 500 -960 540 -960 {lab=ui_in[1]}
N 500 -940 540 -940 {lab=ui_in[0]}
N 500 -900 540 -900 {lab=uio_oe[7]}
N 500 -880 540 -880 {lab=uio_oe[6]}
N 500 -860 540 -860 {lab=uio_oe[5]}
N 500 -840 540 -840 {lab=uio_oe[4]}
N 500 -820 540 -820 {lab=uio_oe[3]}
N 500 -800 540 -800 {lab=uio_oe[2]}
N 500 -780 540 -780 {lab=uio_oe[1]}
N 500 -760 540 -760 {lab=uio_oe[0]}
N 500 -720 540 -720 {lab=uio_out[7]}
N 500 -700 540 -700 {lab=uio_out[6]}
N 500 -680 540 -680 {lab=uio_out[5]}
N 500 -660 540 -660 {lab=uio_out[4]}
N 500 -640 540 -640 {lab=uio_out[3]}
N 500 -620 540 -620 {lab=uio_out[2]}
N 500 -600 540 -600 {lab=uio_out[1]}
N 500 -580 540 -580 {lab=uio_out[0]}
N 500 -540 540 -540 {lab=uo_out[7]}
N 500 -520 540 -520 {lab=uo_out[6]}
N 500 -500 540 -500 {lab=uo_out[5]}
N 500 -480 540 -480 {lab=uo_out[4]}
N 500 -460 540 -460 {lab=uo_out[3]}
N 500 -440 540 -440 {lab=uo_out[2]}
N 500 -420 540 -420 {lab=uo_out[1]}
N 500 -400 540 -400 {lab=uo_out[0]}
N 500 -1400 540 -1400 {lab=VAPWR}
N 500 -1380 540 -1380 {lab=VGND}
N 500 -1420 540 -1420 {lab=VPWR}
N 500 -360 540 -360 {lab=analog_2}
N 500 -340 540 -340 {lab=analog_1}
N 500 -320 540 -320 {lab=analog_0}
N 1920 -1180 1920 -1140 {lab=VPWR}
N 1860 -1100 1890 -1100 {lab=VGND}
N 1860 -1100 1860 -1000 {lab=VGND}
N 1920 -1000 1980 -1000 {lab=VGND}
N 1980 -1100 1980 -1000 {lab=VGND}
N 1950 -1100 1980 -1100 {lab=VGND}
N 1920 -1000 1920 -960 {lab=VGND}
N 1920 -1100 1920 -1000 {lab=VGND}
N 1860 -1000 1920 -1000 {lab=VGND}
C {title-3.sym} 0 0 0 0 {name=l1 author="Simon Dorrer" rev=1.0 lock=true}
C {inverter.sym} 1200 -740 0 0 {name=x3}
C {inverter.sym} 1200 -1020 0 0 {name=x4}
C {lab_pin.sym} 1920 -800 1 0 {name=p25 sig_type=std_logic lab=VAPWR}
C {lab_pin.sym} 1920 -580 3 0 {name=p26 sig_type=std_logic lab=VGND}
C {devices/ipin.sym} 500 -1340 2 1 {name=p30 lab=rst_n}
C {devices/ipin.sym} 500 -1320 2 1 {name=p31 lab=clk}
C {devices/ipin.sym} 500 -1300 2 1 {name=p32 lab=ena}
C {devices/ipin.sym} 500 -1260 2 1 {name=p33 lab=uio_in[7]}
C {conn_3x1.sym} 560 -1320 0 1 {name=c3 footprint=connector(3,1)}
C {conn_8x1.sym} 560 -1240 0 1 {name=c4 footprint=connector(8,1)}
C {devices/ipin.sym} 500 -1080 2 1 {name=p8 lab=ui_in[7]}
C {conn_8x1.sym} 560 -1060 0 1 {name=c5 footprint=connector(8,1)}
C {devices/opin.sym} 500 -900 2 0 {name=p18 lab=uio_oe[7]}
C {devices/opin.sym} 500 -880 2 0 {name=p27 lab=uio_oe[6]}
C {devices/opin.sym} 500 -860 2 0 {name=p28 lab=uio_oe[5]}
C {devices/opin.sym} 500 -840 2 0 {name=p29 lab=uio_oe[4]}
C {devices/opin.sym} 500 -820 2 0 {name=p41 lab=uio_oe[3]}
C {devices/opin.sym} 500 -800 2 0 {name=p42 lab=uio_oe[2]}
C {devices/opin.sym} 500 -780 2 0 {name=p43 lab=uio_oe[1]}
C {devices/opin.sym} 500 -760 2 0 {name=p44 lab=uio_oe[0]}
C {conn_8x1.sym} 560 -880 0 1 {name=c6 footprint=connector(8,1)}
C {devices/opin.sym} 500 -720 2 0 {name=p45 lab=uio_out[7]}
C {devices/opin.sym} 500 -700 2 0 {name=p46 lab=uio_out[6]}
C {devices/opin.sym} 500 -680 2 0 {name=p47 lab=uio_out[5]}
C {devices/opin.sym} 500 -660 2 0 {name=p48 lab=uio_out[4]}
C {devices/opin.sym} 500 -640 2 0 {name=p49 lab=uio_out[3]}
C {devices/opin.sym} 500 -620 2 0 {name=p50 lab=uio_out[2]}
C {devices/opin.sym} 500 -600 2 0 {name=p51 lab=uio_out[1]}
C {devices/opin.sym} 500 -580 2 0 {name=p52 lab=uio_out[0]}
C {conn_8x1.sym} 560 -700 0 1 {name=c7 footprint=connector(8,1)}
C {devices/opin.sym} 500 -540 2 0 {name=p53 lab=uo_out[7]}
C {devices/opin.sym} 500 -520 2 0 {name=p54 lab=uo_out[6]}
C {devices/opin.sym} 500 -500 2 0 {name=p55 lab=uo_out[5]}
C {devices/opin.sym} 500 -480 2 0 {name=p56 lab=uo_out[4]}
C {devices/opin.sym} 500 -460 2 0 {name=p57 lab=uo_out[3]}
C {devices/opin.sym} 500 -440 2 0 {name=p58 lab=uo_out[2]}
C {devices/opin.sym} 500 -420 2 0 {name=p59 lab=uo_out[1]}
C {devices/opin.sym} 500 -400 2 0 {name=p60 lab=uo_out[0]}
C {conn_8x1.sym} 560 -520 0 1 {name=c8 footprint=connector(8,1)}
C {conn_3x1.sym} 560 -1400 0 1 {name=c9 footprint=connector(3,1)}
C {devices/iopin.sym} 500 -1420 2 0 {name=p61 lab=VPWR}
C {devices/iopin.sym} 500 -1380 2 0 {name=p62 lab=VGND}
C {devices/iopin.sym} 500 -1400 2 0 {name=p63 lab=VAPWR}
C {devices/ipin.sym} 500 -1060 2 1 {name=p9 lab=ui_in[6]}
C {devices/ipin.sym} 500 -1040 2 1 {name=p12 lab=ui_in[5]}
C {devices/ipin.sym} 500 -1020 2 1 {name=p13 lab=ui_in[4]}
C {devices/ipin.sym} 500 -1000 2 1 {name=p14 lab=ui_in[3]}
C {devices/ipin.sym} 500 -980 2 1 {name=p15 lab=ui_in[2]}
C {devices/ipin.sym} 500 -960 2 1 {name=p16 lab=ui_in[1]}
C {devices/ipin.sym} 500 -940 2 1 {name=p17 lab=ui_in[0]}
C {devices/ipin.sym} 500 -1240 2 1 {name=p34 lab=uio_in[6]}
C {devices/ipin.sym} 500 -1220 2 1 {name=p35 lab=uio_in[5]}
C {devices/ipin.sym} 500 -1200 2 1 {name=p36 lab=uio_in[4]}
C {devices/ipin.sym} 500 -1180 2 1 {name=p37 lab=uio_in[3]}
C {devices/ipin.sym} 500 -1160 2 1 {name=p38 lab=uio_in[2]}
C {devices/ipin.sym} 500 -1140 2 1 {name=p39 lab=uio_in[1]}
C {devices/ipin.sym} 500 -1120 2 1 {name=p40 lab=uio_in[0]}
C {conn_3x1.sym} 560 -340 0 1 {name=c10 footprint=connector(3,1)}
C {devices/iopin.sym} 500 -360 2 0 {name=p64 lab=analog_2}
C {devices/iopin.sym} 500 -340 2 0 {name=p65 lab=analog_1}
C {devices/iopin.sym} 500 -320 2 0 {name=p66 lab=analog_0}
C {lab_pin.sym} 1920 -1180 1 0 {name=p3 sig_type=std_logic lab=VPWR}
C {lab_pin.sym} 1920 -960 3 0 {name=p4 sig_type=std_logic lab=VGND}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 1920 -1120 1 0 {name=M1
l=10.0u
w=10.0u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13cmos5l_pr/sg13_lv_pmos.sym} 1920 -740 1 0 {name=M2
l=10.0u
w=10.0u
ng=1
m=1
mm_ok=1
model=sg13_lv_pmos
spiceprefix=X
}
C {lab_pin.sym} 1200 -1080 1 0 {name=p1 sig_type=std_logic lab=VAPWR}
C {lab_pin.sym} 1200 -800 1 0 {name=p5 sig_type=std_logic lab=VAPWR}
C {lab_pin.sym} 1200 -960 3 0 {name=p11 sig_type=std_logic lab=VGND}
C {lab_pin.sym} 1200 -680 3 0 {name=p19 sig_type=std_logic lab=VGND}
C {lab_pin.sym} 1080 -1020 0 0 {name=p2 sig_type=std_logic lab=ui_in[0]}
C {lab_pin.sym} 1340 -1020 0 1 {name=p6 sig_type=std_logic lab=analog_2}
C {lab_pin.sym} 1080 -740 0 0 {name=p7 sig_type=std_logic lab=analog_0}
C {lab_pin.sym} 1340 -740 0 1 {name=p10 sig_type=std_logic lab=analog_1}
