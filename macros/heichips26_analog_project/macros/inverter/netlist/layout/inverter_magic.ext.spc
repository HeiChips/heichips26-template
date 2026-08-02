* NGSPICE file created from inverter.ext - technology: ihp-sg13cmos5l

.subckt inverter vin VDD VSS vout
X0 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X1 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X2 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X3 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X4 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X5 VSS VSS VSS VSS sg13_lv_nmos ad=0.34p pd=2.68u as=91.0671p ps=0.17886m w=1u l=1u
X6 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X7 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X8 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X9 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X10 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X11 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X12 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X13 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X14 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X15 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X16 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X17 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X18 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X19 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X20 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X21 VDD VDD VDD VDD sg13_lv_pmos ad=2.04p pd=12.68u as=0.14199n ps=0.28418m w=6u l=1u
X22 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X23 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X24 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X25 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X26 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X27 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X28 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X29 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X30 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X31 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X32 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X33 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X34 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X35 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X36 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X37 VDD VDD VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=0 ps=0 w=6u l=1u
X38 VDD vin vout VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X39 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X40 vout vin VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X41 vout vin VDD VDD sg13_lv_pmos ad=1.14p pd=6.38u as=1.14p ps=6.38u w=6u l=1u
X42 VSS vin vout VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0.19p ps=1.38u w=1u l=1u
X43 VSS VSS VSS VSS sg13_lv_nmos ad=0.19p pd=1.38u as=0 ps=0 w=1u l=1u
.ends

