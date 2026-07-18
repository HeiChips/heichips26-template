module counter_top (clock_i,
    enable_i,
    reset_n_i,
    counter_value_o);
 input clock_i;
 input enable_i;
 input reset_n_i;
 output [7:0] counter_value_o;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _09_;
 wire _10_;
 wire _11_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire _18_;
 wire _19_;
 wire _20_;
 wire _21_;
 wire _22_;
 wire _23_;
 wire _24_;
 wire _25_;
 wire _26_;
 wire _27_;
 wire _28_;
 wire _29_;
 wire _30_;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire clknet_0_clock_i;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net1;
 wire net2;
 wire net;
 wire clknet_1_0__leaf_clock_i;
 wire clknet_1_1__leaf_clock_i;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net22;
 wire net23;
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net30;
 wire net31;
 wire net32;
 wire net33;
 wire net34;

 sg13cmos5l_decap_8 FILLER_0_0 ();
 sg13cmos5l_decap_8 FILLER_0_105 ();
 sg13cmos5l_decap_8 FILLER_0_112 ();
 sg13cmos5l_fill_2 FILLER_0_119 ();
 sg13cmos5l_fill_1 FILLER_0_121 ();
 sg13cmos5l_decap_8 FILLER_0_14 ();
 sg13cmos5l_decap_8 FILLER_0_21 ();
 sg13cmos5l_decap_8 FILLER_0_28 ();
 sg13cmos5l_decap_8 FILLER_0_35 ();
 sg13cmos5l_decap_8 FILLER_0_42 ();
 sg13cmos5l_decap_8 FILLER_0_49 ();
 sg13cmos5l_decap_8 FILLER_0_56 ();
 sg13cmos5l_decap_8 FILLER_0_63 ();
 sg13cmos5l_decap_8 FILLER_0_7 ();
 sg13cmos5l_decap_8 FILLER_0_70 ();
 sg13cmos5l_decap_8 FILLER_0_77 ();
 sg13cmos5l_decap_8 FILLER_0_84 ();
 sg13cmos5l_decap_8 FILLER_0_91 ();
 sg13cmos5l_decap_8 FILLER_0_98 ();
 sg13cmos5l_decap_8 FILLER_10_0 ();
 sg13cmos5l_fill_2 FILLER_10_104 ();
 sg13cmos5l_fill_1 FILLER_10_106 ();
 sg13cmos5l_decap_4 FILLER_10_117 ();
 sg13cmos5l_fill_2 FILLER_10_12 ();
 sg13cmos5l_fill_1 FILLER_10_121 ();
 sg13cmos5l_decap_8 FILLER_10_19 ();
 sg13cmos5l_fill_2 FILLER_10_26 ();
 sg13cmos5l_fill_1 FILLER_10_28 ();
 sg13cmos5l_decap_8 FILLER_10_60 ();
 sg13cmos5l_decap_8 FILLER_10_67 ();
 sg13cmos5l_fill_1 FILLER_10_7 ();
 sg13cmos5l_fill_2 FILLER_10_74 ();
 sg13cmos5l_fill_2 FILLER_11_0 ();
 sg13cmos5l_decap_8 FILLER_11_15 ();
 sg13cmos5l_decap_8 FILLER_11_22 ();
 sg13cmos5l_fill_2 FILLER_11_29 ();
 sg13cmos5l_fill_1 FILLER_11_55 ();
 sg13cmos5l_decap_8 FILLER_11_73 ();
 sg13cmos5l_decap_8 FILLER_11_80 ();
 sg13cmos5l_decap_8 FILLER_11_87 ();
 sg13cmos5l_decap_4 FILLER_11_94 ();
 sg13cmos5l_fill_1 FILLER_11_98 ();
 sg13cmos5l_decap_4 FILLER_12_0 ();
 sg13cmos5l_decap_4 FILLER_12_107 ();
 sg13cmos5l_fill_2 FILLER_12_111 ();
 sg13cmos5l_decap_8 FILLER_12_15 ();
 sg13cmos5l_decap_8 FILLER_12_22 ();
 sg13cmos5l_fill_2 FILLER_12_4 ();
 sg13cmos5l_decap_4 FILLER_12_56 ();
 sg13cmos5l_fill_2 FILLER_12_60 ();
 sg13cmos5l_fill_2 FILLER_12_76 ();
 sg13cmos5l_fill_1 FILLER_12_78 ();
 sg13cmos5l_decap_8 FILLER_12_88 ();
 sg13cmos5l_fill_2 FILLER_12_95 ();
 sg13cmos5l_fill_1 FILLER_12_97 ();
 sg13cmos5l_decap_8 FILLER_13_0 ();
 sg13cmos5l_decap_8 FILLER_13_14 ();
 sg13cmos5l_decap_8 FILLER_13_21 ();
 sg13cmos5l_decap_4 FILLER_13_28 ();
 sg13cmos5l_fill_2 FILLER_13_32 ();
 sg13cmos5l_decap_4 FILLER_13_61 ();
 sg13cmos5l_fill_2 FILLER_13_65 ();
 sg13cmos5l_decap_8 FILLER_13_7 ();
 sg13cmos5l_fill_1 FILLER_13_94 ();
 sg13cmos5l_decap_4 FILLER_14_105 ();
 sg13cmos5l_fill_2 FILLER_14_109 ();
 sg13cmos5l_fill_2 FILLER_14_115 ();
 sg13cmos5l_fill_1 FILLER_14_117 ();
 sg13cmos5l_decap_8 FILLER_14_17 ();
 sg13cmos5l_decap_8 FILLER_14_24 ();
 sg13cmos5l_decap_4 FILLER_14_35 ();
 sg13cmos5l_fill_1 FILLER_14_39 ();
 sg13cmos5l_decap_4 FILLER_14_4 ();
 sg13cmos5l_fill_2 FILLER_14_44 ();
 sg13cmos5l_fill_1 FILLER_14_46 ();
 sg13cmos5l_decap_4 FILLER_14_60 ();
 sg13cmos5l_fill_1 FILLER_14_8 ();
 sg13cmos5l_decap_8 FILLER_14_81 ();
 sg13cmos5l_fill_2 FILLER_14_88 ();
 sg13cmos5l_fill_1 FILLER_14_90 ();
 sg13cmos5l_decap_4 FILLER_14_95 ();
 sg13cmos5l_fill_2 FILLER_14_99 ();
 sg13cmos5l_decap_8 FILLER_1_102 ();
 sg13cmos5l_decap_8 FILLER_1_109 ();
 sg13cmos5l_decap_8 FILLER_1_11 ();
 sg13cmos5l_decap_4 FILLER_1_116 ();
 sg13cmos5l_fill_2 FILLER_1_120 ();
 sg13cmos5l_decap_8 FILLER_1_18 ();
 sg13cmos5l_decap_8 FILLER_1_25 ();
 sg13cmos5l_decap_8 FILLER_1_32 ();
 sg13cmos5l_decap_8 FILLER_1_39 ();
 sg13cmos5l_decap_8 FILLER_1_4 ();
 sg13cmos5l_decap_8 FILLER_1_46 ();
 sg13cmos5l_decap_8 FILLER_1_53 ();
 sg13cmos5l_decap_8 FILLER_1_60 ();
 sg13cmos5l_decap_8 FILLER_1_67 ();
 sg13cmos5l_decap_8 FILLER_1_74 ();
 sg13cmos5l_decap_8 FILLER_1_81 ();
 sg13cmos5l_decap_8 FILLER_1_88 ();
 sg13cmos5l_decap_8 FILLER_1_95 ();
 sg13cmos5l_decap_8 FILLER_2_0 ();
 sg13cmos5l_decap_8 FILLER_2_105 ();
 sg13cmos5l_decap_8 FILLER_2_112 ();
 sg13cmos5l_fill_2 FILLER_2_119 ();
 sg13cmos5l_fill_1 FILLER_2_121 ();
 sg13cmos5l_decap_8 FILLER_2_14 ();
 sg13cmos5l_decap_8 FILLER_2_21 ();
 sg13cmos5l_decap_8 FILLER_2_28 ();
 sg13cmos5l_decap_8 FILLER_2_35 ();
 sg13cmos5l_decap_8 FILLER_2_42 ();
 sg13cmos5l_decap_8 FILLER_2_49 ();
 sg13cmos5l_decap_8 FILLER_2_56 ();
 sg13cmos5l_decap_8 FILLER_2_63 ();
 sg13cmos5l_decap_8 FILLER_2_7 ();
 sg13cmos5l_decap_8 FILLER_2_70 ();
 sg13cmos5l_decap_8 FILLER_2_77 ();
 sg13cmos5l_decap_8 FILLER_2_84 ();
 sg13cmos5l_decap_8 FILLER_2_91 ();
 sg13cmos5l_decap_8 FILLER_2_98 ();
 sg13cmos5l_decap_8 FILLER_3_0 ();
 sg13cmos5l_decap_8 FILLER_3_105 ();
 sg13cmos5l_decap_8 FILLER_3_112 ();
 sg13cmos5l_fill_2 FILLER_3_119 ();
 sg13cmos5l_fill_1 FILLER_3_121 ();
 sg13cmos5l_decap_8 FILLER_3_14 ();
 sg13cmos5l_decap_8 FILLER_3_21 ();
 sg13cmos5l_decap_8 FILLER_3_28 ();
 sg13cmos5l_decap_8 FILLER_3_35 ();
 sg13cmos5l_decap_8 FILLER_3_42 ();
 sg13cmos5l_decap_8 FILLER_3_49 ();
 sg13cmos5l_decap_8 FILLER_3_56 ();
 sg13cmos5l_decap_8 FILLER_3_63 ();
 sg13cmos5l_decap_8 FILLER_3_7 ();
 sg13cmos5l_decap_8 FILLER_3_70 ();
 sg13cmos5l_decap_8 FILLER_3_77 ();
 sg13cmos5l_decap_8 FILLER_3_84 ();
 sg13cmos5l_decap_8 FILLER_3_91 ();
 sg13cmos5l_decap_8 FILLER_3_98 ();
 sg13cmos5l_decap_8 FILLER_4_0 ();
 sg13cmos5l_decap_8 FILLER_4_105 ();
 sg13cmos5l_decap_8 FILLER_4_112 ();
 sg13cmos5l_fill_2 FILLER_4_119 ();
 sg13cmos5l_fill_1 FILLER_4_121 ();
 sg13cmos5l_decap_8 FILLER_4_14 ();
 sg13cmos5l_decap_8 FILLER_4_21 ();
 sg13cmos5l_decap_8 FILLER_4_28 ();
 sg13cmos5l_decap_8 FILLER_4_35 ();
 sg13cmos5l_decap_8 FILLER_4_42 ();
 sg13cmos5l_decap_8 FILLER_4_49 ();
 sg13cmos5l_decap_8 FILLER_4_56 ();
 sg13cmos5l_decap_8 FILLER_4_63 ();
 sg13cmos5l_decap_8 FILLER_4_7 ();
 sg13cmos5l_decap_8 FILLER_4_70 ();
 sg13cmos5l_decap_8 FILLER_4_77 ();
 sg13cmos5l_decap_8 FILLER_4_84 ();
 sg13cmos5l_decap_8 FILLER_4_91 ();
 sg13cmos5l_decap_8 FILLER_4_98 ();
 sg13cmos5l_decap_8 FILLER_5_0 ();
 sg13cmos5l_decap_8 FILLER_5_105 ();
 sg13cmos5l_decap_8 FILLER_5_112 ();
 sg13cmos5l_fill_2 FILLER_5_119 ();
 sg13cmos5l_fill_1 FILLER_5_121 ();
 sg13cmos5l_decap_8 FILLER_5_14 ();
 sg13cmos5l_decap_8 FILLER_5_21 ();
 sg13cmos5l_decap_4 FILLER_5_28 ();
 sg13cmos5l_fill_1 FILLER_5_32 ();
 sg13cmos5l_decap_8 FILLER_5_42 ();
 sg13cmos5l_decap_8 FILLER_5_49 ();
 sg13cmos5l_decap_8 FILLER_5_56 ();
 sg13cmos5l_decap_8 FILLER_5_63 ();
 sg13cmos5l_decap_8 FILLER_5_7 ();
 sg13cmos5l_decap_8 FILLER_5_70 ();
 sg13cmos5l_decap_8 FILLER_5_77 ();
 sg13cmos5l_decap_8 FILLER_5_84 ();
 sg13cmos5l_decap_8 FILLER_5_91 ();
 sg13cmos5l_decap_8 FILLER_5_98 ();
 sg13cmos5l_decap_8 FILLER_6_0 ();
 sg13cmos5l_decap_8 FILLER_6_105 ();
 sg13cmos5l_decap_8 FILLER_6_112 ();
 sg13cmos5l_fill_2 FILLER_6_119 ();
 sg13cmos5l_fill_1 FILLER_6_121 ();
 sg13cmos5l_decap_8 FILLER_6_14 ();
 sg13cmos5l_decap_8 FILLER_6_21 ();
 sg13cmos5l_fill_1 FILLER_6_28 ();
 sg13cmos5l_decap_4 FILLER_6_56 ();
 sg13cmos5l_fill_1 FILLER_6_60 ();
 sg13cmos5l_decap_8 FILLER_6_7 ();
 sg13cmos5l_decap_8 FILLER_6_88 ();
 sg13cmos5l_fill_1 FILLER_6_95 ();
 sg13cmos5l_fill_2 FILLER_7_0 ();
 sg13cmos5l_decap_8 FILLER_7_19 ();
 sg13cmos5l_fill_2 FILLER_7_26 ();
 sg13cmos5l_fill_1 FILLER_7_28 ();
 sg13cmos5l_fill_2 FILLER_7_74 ();
 sg13cmos5l_decap_4 FILLER_8_104 ();
 sg13cmos5l_fill_2 FILLER_8_108 ();
 sg13cmos5l_decap_8 FILLER_8_11 ();
 sg13cmos5l_fill_2 FILLER_8_119 ();
 sg13cmos5l_fill_1 FILLER_8_121 ();
 sg13cmos5l_decap_8 FILLER_8_18 ();
 sg13cmos5l_decap_4 FILLER_8_25 ();
 sg13cmos5l_fill_2 FILLER_8_29 ();
 sg13cmos5l_decap_8 FILLER_8_4 ();
 sg13cmos5l_fill_2 FILLER_8_44 ();
 sg13cmos5l_fill_1 FILLER_8_46 ();
 sg13cmos5l_fill_1 FILLER_8_56 ();
 sg13cmos5l_decap_8 FILLER_8_78 ();
 sg13cmos5l_decap_4 FILLER_8_85 ();
 sg13cmos5l_fill_1 FILLER_8_89 ();
 sg13cmos5l_decap_8 FILLER_9_0 ();
 sg13cmos5l_decap_8 FILLER_9_100 ();
 sg13cmos5l_decap_8 FILLER_9_107 ();
 sg13cmos5l_decap_8 FILLER_9_114 ();
 sg13cmos5l_fill_1 FILLER_9_121 ();
 sg13cmos5l_decap_8 FILLER_9_14 ();
 sg13cmos5l_decap_8 FILLER_9_21 ();
 sg13cmos5l_fill_1 FILLER_9_28 ();
 sg13cmos5l_decap_8 FILLER_9_48 ();
 sg13cmos5l_fill_1 FILLER_9_55 ();
 sg13cmos5l_decap_8 FILLER_9_61 ();
 sg13cmos5l_decap_8 FILLER_9_68 ();
 sg13cmos5l_decap_8 FILLER_9_7 ();
 sg13cmos5l_decap_8 FILLER_9_75 ();
 sg13cmos5l_fill_1 FILLER_9_82 ();
 sg13cmos5l_fill_1 FILLER_9_87 ();
 sg13cmos5l_decap_8 FILLER_9_93 ();
 sg13cmos5l_inv_1 _39_ (.Y(_08_),
    .A(net2));
 sg13cmos5l_nand4_1 _40_ (.B(net1),
    .C(net4),
    .A(net5),
    .Y(_09_),
    .D(net3));
 sg13cmos5l_xor2_1 _41_ (.B(_09_),
    .A(net24),
    .X(_10_));
 sg13cmos5l_nor2_1 _42_ (.A(_08_),
    .B(net25),
    .Y(_00_));
 sg13cmos5l_nand3_1 _43_ (.B(net30),
    .C(net3),
    .A(net1),
    .Y(_11_));
 sg13cmos5l_buf_4 _44_ (.X(_12_),
    .A(_11_));
 sg13cmos5l_nand2_2 _45_ (.Y(_13_),
    .A(net5),
    .B(net24));
 sg13cmos5l_o21ai_1 _46_ (.B1(net21),
    .Y(_14_),
    .A1(_12_),
    .A2(_13_));
 sg13cmos5l_or3_1 _47_ (.A(net21),
    .B(_12_),
    .C(_13_),
    .X(_15_));
 sg13cmos5l_a21oi_1 _48_ (.A1(net22),
    .A2(_15_),
    .Y(_01_),
    .B1(_08_));
 sg13cmos5l_nand3_1 _49_ (.B(net7),
    .C(net6),
    .A(net5),
    .Y(_16_));
 sg13cmos5l_o21ai_1 _50_ (.B1(net18),
    .Y(_17_),
    .A1(_12_),
    .A2(_16_));
 sg13cmos5l_or3_1 _51_ (.A(net18),
    .B(_12_),
    .C(_16_),
    .X(_18_));
 sg13cmos5l_a21oi_1 _52_ (.A1(net19),
    .A2(_18_),
    .Y(_02_),
    .B1(_08_));
 sg13cmos5l_and2_1 _53_ (.A(net28),
    .B(net2),
    .X(_19_));
 sg13cmos5l_nor2b_1 _54_ (.A(net28),
    .B_N(net2),
    .Y(_20_));
 sg13cmos5l_nand2_1 _55_ (.Y(_21_),
    .A(net18),
    .B(net21));
 sg13cmos5l_nor3_1 _56_ (.A(_12_),
    .B(_13_),
    .C(_21_),
    .Y(_22_));
 sg13cmos5l_mux2_1 _57_ (.A0(_19_),
    .A1(_20_),
    .S(_22_),
    .X(_03_));
 sg13cmos5l_and2_1 _58_ (.A(net26),
    .B(net2),
    .X(_23_));
 sg13cmos5l_nor2b_1 _59_ (.A(net26),
    .B_N(net2),
    .Y(_24_));
 sg13cmos5l_inv_1 _60_ (.Y(_25_),
    .A(net9));
 sg13cmos5l_nor4_2 _61_ (.A(_25_),
    .B(_12_),
    .C(_13_),
    .Y(_26_),
    .D(_21_));
 sg13cmos5l_mux2_1 _62_ (.A0(_23_),
    .A1(_24_),
    .S(_26_),
    .X(_04_));
 sg13cmos5l_xor2_1 _63_ (.B(net32),
    .A(net1),
    .X(_27_));
 sg13cmos5l_and2_1 _64_ (.A(net2),
    .B(_27_),
    .X(_05_));
 sg13cmos5l_nand2_1 _65_ (.Y(_28_),
    .A(net1),
    .B(net3));
 sg13cmos5l_xnor2_1 _66_ (.Y(_29_),
    .A(net30),
    .B(_28_));
 sg13cmos5l_and2_1 _67_ (.A(net2),
    .B(net31),
    .X(_06_));
 sg13cmos5l_xnor2_1 _68_ (.Y(_30_),
    .A(net33),
    .B(_12_));
 sg13cmos5l_and2_1 _69_ (.A(net2),
    .B(net34),
    .X(_07_));
 sg13cmos5l_dfrbpq_1 _70_ (.RESET_B(net11),
    .D(net20),
    .Q(net8),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _70__12 (.L_HI(net11));
 sg13cmos5l_dfrbpq_1 _71_ (.RESET_B(net17),
    .D(net29),
    .Q(net9),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _71__18 (.L_HI(net17));
 sg13cmos5l_dfrbpq_1 _72_ (.RESET_B(net15),
    .D(net27),
    .Q(net10),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _72__16 (.L_HI(net15));
 sg13cmos5l_dfrbpq_1 _73_ (.RESET_B(net12),
    .D(_05_),
    .Q(net3),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _73__13 (.L_HI(net12));
 sg13cmos5l_dfrbpq_1 _74_ (.RESET_B(net16),
    .D(_06_),
    .Q(net4),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _74__17 (.L_HI(net16));
 sg13cmos5l_dfrbpq_1 _75_ (.RESET_B(net),
    .D(_07_),
    .Q(net5),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _75__11 (.L_HI(net));
 sg13cmos5l_dfrbpq_1 _76_ (.RESET_B(net14),
    .D(_00_),
    .Q(net6),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _76__15 (.L_HI(net14));
 sg13cmos5l_dfrbpq_1 _77_ (.RESET_B(net13),
    .D(net23),
    .Q(net7),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _77__14 (.L_HI(net13));
 sg13cmos5l_buf_8 clkbuf_0_clock_i (.A(clock_i),
    .X(clknet_0_clock_i));
 sg13cmos5l_buf_8 clkbuf_1_0__f_clock_i (.A(clknet_0_clock_i),
    .X(clknet_1_0__leaf_clock_i));
 sg13cmos5l_buf_8 clkbuf_1_1__f_clock_i (.A(clknet_0_clock_i),
    .X(clknet_1_1__leaf_clock_i));
 sg13cmos5l_dlygate4sd3_1 hold19 (.A(net8),
    .X(net18));
 sg13cmos5l_dlygate4sd3_1 hold20 (.A(_17_),
    .X(net19));
 sg13cmos5l_dlygate4sd3_1 hold21 (.A(_02_),
    .X(net20));
 sg13cmos5l_dlygate4sd3_1 hold22 (.A(net7),
    .X(net21));
 sg13cmos5l_dlygate4sd3_1 hold23 (.A(_14_),
    .X(net22));
 sg13cmos5l_dlygate4sd3_1 hold24 (.A(_01_),
    .X(net23));
 sg13cmos5l_dlygate4sd3_1 hold25 (.A(net6),
    .X(net24));
 sg13cmos5l_dlygate4sd3_1 hold26 (.A(_10_),
    .X(net25));
 sg13cmos5l_dlygate4sd3_1 hold27 (.A(net10),
    .X(net26));
 sg13cmos5l_dlygate4sd3_1 hold28 (.A(_04_),
    .X(net27));
 sg13cmos5l_dlygate4sd3_1 hold29 (.A(net9),
    .X(net28));
 sg13cmos5l_dlygate4sd3_1 hold30 (.A(_03_),
    .X(net29));
 sg13cmos5l_dlygate4sd3_1 hold31 (.A(net4),
    .X(net30));
 sg13cmos5l_dlygate4sd3_1 hold32 (.A(_29_),
    .X(net31));
 sg13cmos5l_dlygate4sd3_1 hold33 (.A(net3),
    .X(net32));
 sg13cmos5l_dlygate4sd3_1 hold34 (.A(net5),
    .X(net33));
 sg13cmos5l_dlygate4sd3_1 hold35 (.A(_30_),
    .X(net34));
 sg13cmos5l_buf_1 input1 (.A(enable_i),
    .X(net1));
 sg13cmos5l_buf_1 input2 (.A(reset_n_i),
    .X(net2));
 sg13cmos5l_buf_1 output10 (.A(net10),
    .X(counter_value_o[7]));
 sg13cmos5l_buf_1 output3 (.A(net3),
    .X(counter_value_o[0]));
 sg13cmos5l_buf_1 output4 (.A(net4),
    .X(counter_value_o[1]));
 sg13cmos5l_buf_1 output5 (.A(net5),
    .X(counter_value_o[2]));
 sg13cmos5l_buf_1 output6 (.A(net6),
    .X(counter_value_o[3]));
 sg13cmos5l_buf_1 output7 (.A(net7),
    .X(counter_value_o[4]));
 sg13cmos5l_buf_1 output8 (.A(net8),
    .X(counter_value_o[5]));
 sg13cmos5l_buf_1 output9 (.A(net9),
    .X(counter_value_o[6]));
endmodule
