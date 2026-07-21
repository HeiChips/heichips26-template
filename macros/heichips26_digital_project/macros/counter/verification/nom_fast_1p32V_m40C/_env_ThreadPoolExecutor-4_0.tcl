set ::env(STEP_ID) OpenROAD.STAPostPNR
set ::env(TECH_LEF) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lef/sg13cmos5l_tech.lef
set ::env(MACRO_LEFS) ""
set ::env(STD_CELL_LIBRARY) sg13cmos5l_stdcell
set ::env(PAD_CELL_LIBRARY) sg13cmos5l_io
set ::env(VDD_PIN) VPWR
set ::env(GND_PIN) VGND
set ::env(TECH_LEFS) "\"nom_*\" /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lef/sg13cmos5l_tech.lef \"min_*\" /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lef/sg13cmos5l_tech.lef \"max_*\" /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lef/sg13cmos5l_tech.lef"
set ::env(PRIMARY_GDSII_STREAMOUT_TOOL) klayout
set ::env(DEFAULT_CORNER) nom_typ_1p20V_25C
set ::env(STA_CORNERS) "nom_fast_1p32V_m40C nom_slow_1p08V_125C nom_typ_1p20V_25C"
set ::env(RT_MIN_LAYER) Metal2
set ::env(RT_MAX_LAYER) Metal4
set ::env(SCL_GROUND_PINS) VSS
set ::env(SCL_POWER_PINS) VDD
set ::env(TRISTATE_CELLS) "\"sg13cmos5l_ebufn_*\" \"sg13cmos5l_einvn_*\""
set ::env(FILL_CELLS) "sg13cmos5l_fill_1 sg13cmos5l_fill_2"
set ::env(DECAP_CELLS) "\"sg13cmos5l_decap_*\""
set ::env(CELL_LIBS) "nom_typ_1p20V_25C \"/home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lib/sg13cmos5l_stdcell_typ_1p20V_25C.lib /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/lib/sg13cmos5l_io_typ_1p2V_3p3V_25C.lib\" nom_fast_1p32V_m40C \"/home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lib/sg13cmos5l_stdcell_fast_1p32V_m40C.lib /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/lib/sg13cmos5l_io_fast_1p32V_3p6V_m40C.lib\" nom_slow_1p08V_125C \"/home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lib/sg13cmos5l_stdcell_slow_1p08V_125C.lib /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/lib/sg13cmos5l_io_slow_1p08V_3p0V_125C.lib\""
set ::env(CELL_LEFS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/lef/sg13cmos5l_stdcell.lef
set ::env(CELL_GDS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/gds/sg13cmos5l_stdcell.gds
set ::env(CELL_VERILOG_MODELS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/verilog/sg13cmos5l_stdcell.v
set ::env(CELL_SPICE_MODELS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/spice/sg13cmos5l_stdcell.spice
set ::env(CELL_CDLS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_stdcell/cdl/sg13cmos5l_stdcell.cdl
set ::env(SYNTH_EXCLUDED_CELL_FILE) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.tech/librelane/sg13cmos5l_stdcell/synth_exclude.cells
set ::env(PNR_EXCLUDED_CELL_FILE) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.tech/librelane/sg13cmos5l_stdcell/pnr_exclude.cells
set ::env(OUTPUT_CAP_LOAD) 6.0
set ::env(MAX_FANOUT_CONSTRAINT) 10
set ::env(CLOCK_UNCERTAINTY_CONSTRAINT) 0.25
set ::env(CLOCK_TRANSITION_CONSTRAINT) 0.15
set ::env(TIME_DERATING_CONSTRAINT) 5
set ::env(IO_DELAY_CONSTRAINT) 20
set ::env(SYNTH_DRIVING_CELL) sg13cmos5l_buf_4/X
set ::env(SYNTH_TIEHI_CELL) sg13cmos5l_tiehi/L_HI
set ::env(SYNTH_TIELO_CELL) sg13cmos5l_tielo/L_LO
set ::env(SYNTH_BUFFER_CELL) sg13cmos5l_buf_1/A/X
set ::env(PLACE_SITE) CoreSite
set ::env(CELL_PAD_EXCLUDE) "\"sg13cmos5l_fill_*\" \"sg13cmos5l_decap_*\""
set ::env(DIODE_CELL) sg13cmos5l_antennanp
set ::env(DESIGN_NAME) counter
set ::env(CLOCK_PERIOD) 20
set ::env(CLOCK_PORT) clock_i
set ::env(DIE_AREA) "0 0 80 80"
set ::env(FALLBACK_SDC) /nix/store/qa5pnbaj1sd11vflhm132q9qh8xbkhb5-python3-3.13.13-env/lib/python3.13/site-packages/librelane/scripts/base.sdc
set ::env(PAD_LIBS) ""
set ::env(PAD_LEFS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/lef/sg13cmos5l_io.lef
set ::env(PAD_GDS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/gds/sg13cmos5l_io.gds
set ::env(PAD_VERILOG_MODELS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/verilog/sg13cmos5l_io.v
set ::env(PAD_SPICE_MODELS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/spice/sg13cmos5l_io.spi
set ::env(PAD_CDLS) /home/leo/Repositories/heichips26/heichips26-template/IHP-Open-PDK/ihp-sg13cmos5l/libs.ref/sg13cmos5l_io/cdl/sg13cmos5l_io.cdl
set ::env(PAD_CORNER) sg13cmos5l_Corner
set ::env(PAD_FILLERS) "sg13cmos5l_Filler10000 sg13cmos5l_Filler4000 sg13cmos5l_Filler2000 sg13cmos5l_Filler1000 sg13cmos5l_Filler400 sg13cmos5l_Filler200"
set ::env(PAD_SITE_NAME) sg13cmos5l_ioSite
set ::env(PAD_CORNER_SITE_NAME) sg13cmos5l_cornerSite
set ::env(PAD_BONDPAD_NAME) bondpad_70x70
set ::env(PAD_BONDPAD_WIDTH) 70
set ::env(PAD_BONDPAD_HEIGHT) 70
set ::env(PAD_BONDPAD_OFFSETS) "\"sg13cmos5l_IOPad*\" \"5.0 -70.0\""
set ::env(PAD_EDGE_SPACING) 140
set ::env(PAD_ROTATION_HORIZONTAL) R0
set ::env(PAD_ROTATION_VERTICAL) R0
set ::env(PAD_ROTATION_CORNER) R0
set ::env(SET_RC_VERBOSE) 0
set ::env(LAYERS_RC) ""
set ::env(PDN_CONNECT_MACROS_TO_GRID) 1
set ::env(PDN_ENABLE_GLOBAL_CONNECTIONS) 1
set ::env(DEDUPLICATE_CORNERS) 0
set ::env(STA_MACRO_PRIORITIZE_NL) 1
set ::env(CURRENT_NL) /home/leo/Repositories/heichips26/heichips26-template/macros/heichips26_digital_project/macros/counter/flow/librelane/runs/RUN_2026-07-21_12-10-52/52-openroad-fillinsertion/counter.nl.v
set ::env(CURRENT_SPEF) "\"nom_*\" /home/leo/Repositories/heichips26/heichips26-template/macros/heichips26_digital_project/macros/counter/flow/librelane/runs/RUN_2026-07-21_12-10-52/54-openroad-rcx/nom/counter.nom.spef"
set ::env(CURRENT_ODB) /home/leo/Repositories/heichips26/heichips26-template/macros/heichips26_digital_project/macros/counter/flow/librelane/runs/RUN_2026-07-21_12-10-52/53-odb-cellfrequencytables/counter.odb
set ::env(SAVE_SDC) /home/leo/Repositories/heichips26/heichips26-template/macros/heichips26_digital_project/macros/counter/flow/librelane/runs/RUN_2026-07-21_12-10-52/55-openroad-stapostpnr/counter.sdc
set ::env(OPENLANE_SDC_IDEAL_CLOCKS) 0
