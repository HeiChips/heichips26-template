module counter (clk_i,
    enable_i,
    rst_ni,
    count_o);
 input clk_i;
 input enable_i;
 input rst_ni;
 output [7:0] count_o;

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
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire clknet_0_clk_i;
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
 wire clknet_1_0__leaf_clk_i;
 wire clknet_1_1__leaf_clk_i;
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

 sg13cmos5l_decap_8 FILLER_0_0 ();
 sg13cmos5l_decap_8 FILLER_0_105 ();
 sg13cmos5l_decap_8 FILLER_0_112 ();
 sg13cmos5l_decap_8 FILLER_0_119 ();
 sg13cmos5l_decap_8 FILLER_0_126 ();
 sg13cmos5l_decap_8 FILLER_0_133 ();
 sg13cmos5l_decap_8 FILLER_0_14 ();
 sg13cmos5l_decap_8 FILLER_0_140 ();
 sg13cmos5l_fill_2 FILLER_0_147 ();
 sg13cmos5l_fill_1 FILLER_0_149 ();
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
 sg13cmos5l_decap_8 FILLER_10_102 ();
 sg13cmos5l_decap_8 FILLER_10_109 ();
 sg13cmos5l_decap_8 FILLER_10_11 ();
 sg13cmos5l_decap_8 FILLER_10_116 ();
 sg13cmos5l_decap_8 FILLER_10_123 ();
 sg13cmos5l_decap_8 FILLER_10_130 ();
 sg13cmos5l_decap_8 FILLER_10_137 ();
 sg13cmos5l_decap_4 FILLER_10_144 ();
 sg13cmos5l_fill_2 FILLER_10_148 ();
 sg13cmos5l_decap_8 FILLER_10_18 ();
 sg13cmos5l_decap_8 FILLER_10_25 ();
 sg13cmos5l_decap_8 FILLER_10_32 ();
 sg13cmos5l_decap_8 FILLER_10_39 ();
 sg13cmos5l_decap_8 FILLER_10_4 ();
 sg13cmos5l_decap_8 FILLER_10_46 ();
 sg13cmos5l_decap_8 FILLER_10_53 ();
 sg13cmos5l_decap_8 FILLER_10_60 ();
 sg13cmos5l_decap_8 FILLER_10_67 ();
 sg13cmos5l_decap_8 FILLER_10_74 ();
 sg13cmos5l_decap_8 FILLER_10_81 ();
 sg13cmos5l_decap_8 FILLER_10_88 ();
 sg13cmos5l_decap_8 FILLER_10_95 ();
 sg13cmos5l_decap_8 FILLER_11_0 ();
 sg13cmos5l_fill_2 FILLER_11_106 ();
 sg13cmos5l_decap_8 FILLER_11_118 ();
 sg13cmos5l_decap_8 FILLER_11_125 ();
 sg13cmos5l_decap_8 FILLER_11_132 ();
 sg13cmos5l_decap_8 FILLER_11_139 ();
 sg13cmos5l_decap_8 FILLER_11_14 ();
 sg13cmos5l_decap_4 FILLER_11_146 ();
 sg13cmos5l_decap_8 FILLER_11_21 ();
 sg13cmos5l_decap_8 FILLER_11_28 ();
 sg13cmos5l_decap_8 FILLER_11_35 ();
 sg13cmos5l_decap_8 FILLER_11_42 ();
 sg13cmos5l_decap_8 FILLER_11_49 ();
 sg13cmos5l_decap_8 FILLER_11_56 ();
 sg13cmos5l_decap_4 FILLER_11_63 ();
 sg13cmos5l_decap_8 FILLER_11_7 ();
 sg13cmos5l_decap_8 FILLER_11_85 ();
 sg13cmos5l_decap_8 FILLER_11_92 ();
 sg13cmos5l_decap_8 FILLER_11_99 ();
 sg13cmos5l_decap_8 FILLER_12_0 ();
 sg13cmos5l_decap_8 FILLER_12_123 ();
 sg13cmos5l_fill_2 FILLER_12_130 ();
 sg13cmos5l_fill_1 FILLER_12_132 ();
 sg13cmos5l_decap_8 FILLER_12_142 ();
 sg13cmos5l_fill_1 FILLER_12_149 ();
 sg13cmos5l_decap_8 FILLER_12_17 ();
 sg13cmos5l_decap_8 FILLER_12_24 ();
 sg13cmos5l_decap_4 FILLER_12_31 ();
 sg13cmos5l_fill_1 FILLER_12_35 ();
 sg13cmos5l_fill_2 FILLER_12_67 ();
 sg13cmos5l_fill_2 FILLER_12_7 ();
 sg13cmos5l_fill_1 FILLER_12_9 ();
 sg13cmos5l_decap_4 FILLER_13_0 ();
 sg13cmos5l_fill_1 FILLER_13_103 ();
 sg13cmos5l_decap_8 FILLER_13_123 ();
 sg13cmos5l_fill_2 FILLER_13_130 ();
 sg13cmos5l_fill_1 FILLER_13_132 ();
 sg13cmos5l_decap_8 FILLER_13_137 ();
 sg13cmos5l_decap_4 FILLER_13_144 ();
 sg13cmos5l_fill_2 FILLER_13_148 ();
 sg13cmos5l_decap_8 FILLER_13_17 ();
 sg13cmos5l_decap_4 FILLER_13_24 ();
 sg13cmos5l_fill_1 FILLER_13_28 ();
 sg13cmos5l_fill_1 FILLER_13_4 ();
 sg13cmos5l_fill_1 FILLER_13_65 ();
 sg13cmos5l_fill_1 FILLER_13_82 ();
 sg13cmos5l_decap_8 FILLER_13_92 ();
 sg13cmos5l_decap_4 FILLER_13_99 ();
 sg13cmos5l_decap_8 FILLER_14_0 ();
 sg13cmos5l_decap_8 FILLER_14_123 ();
 sg13cmos5l_decap_8 FILLER_14_130 ();
 sg13cmos5l_decap_8 FILLER_14_137 ();
 sg13cmos5l_decap_8 FILLER_14_14 ();
 sg13cmos5l_decap_4 FILLER_14_144 ();
 sg13cmos5l_fill_2 FILLER_14_148 ();
 sg13cmos5l_decap_8 FILLER_14_21 ();
 sg13cmos5l_fill_1 FILLER_14_28 ();
 sg13cmos5l_decap_8 FILLER_14_54 ();
 sg13cmos5l_fill_2 FILLER_14_61 ();
 sg13cmos5l_fill_1 FILLER_14_63 ();
 sg13cmos5l_decap_8 FILLER_14_7 ();
 sg13cmos5l_fill_2 FILLER_14_73 ();
 sg13cmos5l_fill_1 FILLER_14_75 ();
 sg13cmos5l_decap_8 FILLER_14_89 ();
 sg13cmos5l_fill_2 FILLER_14_96 ();
 sg13cmos5l_decap_8 FILLER_15_0 ();
 sg13cmos5l_decap_8 FILLER_15_123 ();
 sg13cmos5l_decap_8 FILLER_15_130 ();
 sg13cmos5l_decap_8 FILLER_15_137 ();
 sg13cmos5l_decap_4 FILLER_15_144 ();
 sg13cmos5l_fill_2 FILLER_15_148 ();
 sg13cmos5l_decap_8 FILLER_15_19 ();
 sg13cmos5l_fill_2 FILLER_15_26 ();
 sg13cmos5l_fill_1 FILLER_15_28 ();
 sg13cmos5l_fill_1 FILLER_15_56 ();
 sg13cmos5l_decap_8 FILLER_15_66 ();
 sg13cmos5l_fill_2 FILLER_15_7 ();
 sg13cmos5l_fill_1 FILLER_15_73 ();
 sg13cmos5l_decap_8 FILLER_15_85 ();
 sg13cmos5l_decap_4 FILLER_15_92 ();
 sg13cmos5l_decap_8 FILLER_16_0 ();
 sg13cmos5l_fill_1 FILLER_16_107 ();
 sg13cmos5l_decap_8 FILLER_16_122 ();
 sg13cmos5l_decap_8 FILLER_16_129 ();
 sg13cmos5l_decap_8 FILLER_16_136 ();
 sg13cmos5l_decap_8 FILLER_16_143 ();
 sg13cmos5l_decap_8 FILLER_16_19 ();
 sg13cmos5l_fill_2 FILLER_16_26 ();
 sg13cmos5l_fill_1 FILLER_16_28 ();
 sg13cmos5l_fill_1 FILLER_16_43 ();
 sg13cmos5l_fill_2 FILLER_16_71 ();
 sg13cmos5l_decap_8 FILLER_17_0 ();
 sg13cmos5l_fill_1 FILLER_17_101 ();
 sg13cmos5l_fill_1 FILLER_17_11 ();
 sg13cmos5l_decap_8 FILLER_17_123 ();
 sg13cmos5l_fill_2 FILLER_17_130 ();
 sg13cmos5l_fill_1 FILLER_17_132 ();
 sg13cmos5l_decap_8 FILLER_17_137 ();
 sg13cmos5l_decap_4 FILLER_17_144 ();
 sg13cmos5l_fill_2 FILLER_17_148 ();
 sg13cmos5l_decap_8 FILLER_17_16 ();
 sg13cmos5l_decap_4 FILLER_17_23 ();
 sg13cmos5l_fill_2 FILLER_17_27 ();
 sg13cmos5l_decap_8 FILLER_17_59 ();
 sg13cmos5l_decap_4 FILLER_17_66 ();
 sg13cmos5l_decap_4 FILLER_17_7 ();
 sg13cmos5l_fill_2 FILLER_17_70 ();
 sg13cmos5l_fill_1 FILLER_17_91 ();
 sg13cmos5l_decap_4 FILLER_18_0 ();
 sg13cmos5l_fill_1 FILLER_18_104 ();
 sg13cmos5l_fill_1 FILLER_18_109 ();
 sg13cmos5l_decap_8 FILLER_18_123 ();
 sg13cmos5l_decap_8 FILLER_18_130 ();
 sg13cmos5l_decap_8 FILLER_18_137 ();
 sg13cmos5l_fill_1 FILLER_18_144 ();
 sg13cmos5l_fill_1 FILLER_18_149 ();
 sg13cmos5l_decap_4 FILLER_18_16 ();
 sg13cmos5l_fill_2 FILLER_18_20 ();
 sg13cmos5l_decap_8 FILLER_18_26 ();
 sg13cmos5l_fill_1 FILLER_18_33 ();
 sg13cmos5l_fill_1 FILLER_18_4 ();
 sg13cmos5l_fill_2 FILLER_18_42 ();
 sg13cmos5l_decap_8 FILLER_18_52 ();
 sg13cmos5l_decap_4 FILLER_18_59 ();
 sg13cmos5l_fill_2 FILLER_18_63 ();
 sg13cmos5l_decap_8 FILLER_18_69 ();
 sg13cmos5l_decap_4 FILLER_18_76 ();
 sg13cmos5l_decap_8 FILLER_18_9 ();
 sg13cmos5l_decap_8 FILLER_18_97 ();
 sg13cmos5l_decap_8 FILLER_1_0 ();
 sg13cmos5l_decap_8 FILLER_1_105 ();
 sg13cmos5l_decap_8 FILLER_1_112 ();
 sg13cmos5l_decap_8 FILLER_1_119 ();
 sg13cmos5l_decap_8 FILLER_1_126 ();
 sg13cmos5l_decap_8 FILLER_1_133 ();
 sg13cmos5l_decap_8 FILLER_1_14 ();
 sg13cmos5l_decap_8 FILLER_1_140 ();
 sg13cmos5l_fill_2 FILLER_1_147 ();
 sg13cmos5l_fill_1 FILLER_1_149 ();
 sg13cmos5l_decap_8 FILLER_1_21 ();
 sg13cmos5l_decap_8 FILLER_1_28 ();
 sg13cmos5l_decap_8 FILLER_1_35 ();
 sg13cmos5l_decap_8 FILLER_1_42 ();
 sg13cmos5l_decap_8 FILLER_1_49 ();
 sg13cmos5l_decap_8 FILLER_1_56 ();
 sg13cmos5l_decap_8 FILLER_1_63 ();
 sg13cmos5l_decap_8 FILLER_1_7 ();
 sg13cmos5l_decap_8 FILLER_1_70 ();
 sg13cmos5l_decap_8 FILLER_1_77 ();
 sg13cmos5l_decap_8 FILLER_1_84 ();
 sg13cmos5l_decap_8 FILLER_1_91 ();
 sg13cmos5l_decap_8 FILLER_1_98 ();
 sg13cmos5l_decap_8 FILLER_2_0 ();
 sg13cmos5l_decap_8 FILLER_2_105 ();
 sg13cmos5l_decap_8 FILLER_2_112 ();
 sg13cmos5l_decap_8 FILLER_2_119 ();
 sg13cmos5l_decap_8 FILLER_2_126 ();
 sg13cmos5l_decap_8 FILLER_2_133 ();
 sg13cmos5l_decap_8 FILLER_2_14 ();
 sg13cmos5l_decap_8 FILLER_2_140 ();
 sg13cmos5l_fill_2 FILLER_2_147 ();
 sg13cmos5l_fill_1 FILLER_2_149 ();
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
 sg13cmos5l_decap_8 FILLER_3_102 ();
 sg13cmos5l_decap_8 FILLER_3_109 ();
 sg13cmos5l_decap_8 FILLER_3_11 ();
 sg13cmos5l_decap_8 FILLER_3_116 ();
 sg13cmos5l_decap_8 FILLER_3_123 ();
 sg13cmos5l_decap_8 FILLER_3_130 ();
 sg13cmos5l_decap_8 FILLER_3_137 ();
 sg13cmos5l_decap_4 FILLER_3_144 ();
 sg13cmos5l_fill_2 FILLER_3_148 ();
 sg13cmos5l_decap_8 FILLER_3_18 ();
 sg13cmos5l_decap_8 FILLER_3_25 ();
 sg13cmos5l_decap_8 FILLER_3_32 ();
 sg13cmos5l_decap_8 FILLER_3_39 ();
 sg13cmos5l_decap_8 FILLER_3_4 ();
 sg13cmos5l_decap_8 FILLER_3_46 ();
 sg13cmos5l_decap_8 FILLER_3_53 ();
 sg13cmos5l_decap_8 FILLER_3_60 ();
 sg13cmos5l_decap_8 FILLER_3_67 ();
 sg13cmos5l_decap_8 FILLER_3_74 ();
 sg13cmos5l_decap_8 FILLER_3_81 ();
 sg13cmos5l_decap_8 FILLER_3_88 ();
 sg13cmos5l_decap_8 FILLER_3_95 ();
 sg13cmos5l_decap_8 FILLER_4_0 ();
 sg13cmos5l_decap_8 FILLER_4_105 ();
 sg13cmos5l_decap_8 FILLER_4_112 ();
 sg13cmos5l_decap_8 FILLER_4_119 ();
 sg13cmos5l_decap_8 FILLER_4_126 ();
 sg13cmos5l_decap_8 FILLER_4_133 ();
 sg13cmos5l_decap_8 FILLER_4_14 ();
 sg13cmos5l_decap_8 FILLER_4_140 ();
 sg13cmos5l_fill_2 FILLER_4_147 ();
 sg13cmos5l_fill_1 FILLER_4_149 ();
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
 sg13cmos5l_decap_8 FILLER_5_119 ();
 sg13cmos5l_decap_8 FILLER_5_126 ();
 sg13cmos5l_decap_8 FILLER_5_133 ();
 sg13cmos5l_decap_8 FILLER_5_14 ();
 sg13cmos5l_decap_8 FILLER_5_140 ();
 sg13cmos5l_fill_2 FILLER_5_147 ();
 sg13cmos5l_fill_1 FILLER_5_149 ();
 sg13cmos5l_decap_8 FILLER_5_21 ();
 sg13cmos5l_decap_8 FILLER_5_28 ();
 sg13cmos5l_decap_8 FILLER_5_35 ();
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
 sg13cmos5l_decap_8 FILLER_6_119 ();
 sg13cmos5l_decap_8 FILLER_6_126 ();
 sg13cmos5l_decap_8 FILLER_6_133 ();
 sg13cmos5l_decap_8 FILLER_6_14 ();
 sg13cmos5l_decap_8 FILLER_6_140 ();
 sg13cmos5l_fill_2 FILLER_6_147 ();
 sg13cmos5l_fill_1 FILLER_6_149 ();
 sg13cmos5l_decap_8 FILLER_6_21 ();
 sg13cmos5l_decap_8 FILLER_6_28 ();
 sg13cmos5l_decap_8 FILLER_6_35 ();
 sg13cmos5l_decap_8 FILLER_6_42 ();
 sg13cmos5l_decap_8 FILLER_6_49 ();
 sg13cmos5l_decap_8 FILLER_6_56 ();
 sg13cmos5l_decap_8 FILLER_6_63 ();
 sg13cmos5l_decap_8 FILLER_6_7 ();
 sg13cmos5l_decap_8 FILLER_6_70 ();
 sg13cmos5l_decap_8 FILLER_6_77 ();
 sg13cmos5l_decap_8 FILLER_6_84 ();
 sg13cmos5l_decap_8 FILLER_6_91 ();
 sg13cmos5l_decap_8 FILLER_6_98 ();
 sg13cmos5l_decap_8 FILLER_7_0 ();
 sg13cmos5l_decap_8 FILLER_7_105 ();
 sg13cmos5l_decap_8 FILLER_7_112 ();
 sg13cmos5l_decap_8 FILLER_7_119 ();
 sg13cmos5l_decap_8 FILLER_7_126 ();
 sg13cmos5l_decap_8 FILLER_7_133 ();
 sg13cmos5l_decap_8 FILLER_7_14 ();
 sg13cmos5l_decap_8 FILLER_7_140 ();
 sg13cmos5l_fill_2 FILLER_7_147 ();
 sg13cmos5l_fill_1 FILLER_7_149 ();
 sg13cmos5l_decap_8 FILLER_7_21 ();
 sg13cmos5l_decap_8 FILLER_7_28 ();
 sg13cmos5l_decap_8 FILLER_7_35 ();
 sg13cmos5l_decap_8 FILLER_7_42 ();
 sg13cmos5l_decap_8 FILLER_7_49 ();
 sg13cmos5l_decap_8 FILLER_7_56 ();
 sg13cmos5l_decap_8 FILLER_7_63 ();
 sg13cmos5l_decap_8 FILLER_7_7 ();
 sg13cmos5l_decap_8 FILLER_7_70 ();
 sg13cmos5l_decap_8 FILLER_7_77 ();
 sg13cmos5l_decap_8 FILLER_7_84 ();
 sg13cmos5l_decap_8 FILLER_7_91 ();
 sg13cmos5l_decap_8 FILLER_7_98 ();
 sg13cmos5l_decap_8 FILLER_8_0 ();
 sg13cmos5l_decap_8 FILLER_8_105 ();
 sg13cmos5l_decap_8 FILLER_8_112 ();
 sg13cmos5l_decap_8 FILLER_8_119 ();
 sg13cmos5l_decap_8 FILLER_8_126 ();
 sg13cmos5l_decap_8 FILLER_8_133 ();
 sg13cmos5l_decap_8 FILLER_8_14 ();
 sg13cmos5l_decap_8 FILLER_8_140 ();
 sg13cmos5l_fill_2 FILLER_8_147 ();
 sg13cmos5l_fill_1 FILLER_8_149 ();
 sg13cmos5l_decap_8 FILLER_8_21 ();
 sg13cmos5l_decap_8 FILLER_8_28 ();
 sg13cmos5l_decap_8 FILLER_8_35 ();
 sg13cmos5l_decap_8 FILLER_8_42 ();
 sg13cmos5l_decap_8 FILLER_8_49 ();
 sg13cmos5l_decap_8 FILLER_8_56 ();
 sg13cmos5l_decap_8 FILLER_8_63 ();
 sg13cmos5l_decap_8 FILLER_8_7 ();
 sg13cmos5l_decap_8 FILLER_8_70 ();
 sg13cmos5l_decap_8 FILLER_8_77 ();
 sg13cmos5l_decap_8 FILLER_8_84 ();
 sg13cmos5l_decap_8 FILLER_8_91 ();
 sg13cmos5l_decap_8 FILLER_8_98 ();
 sg13cmos5l_decap_8 FILLER_9_0 ();
 sg13cmos5l_decap_8 FILLER_9_105 ();
 sg13cmos5l_decap_8 FILLER_9_112 ();
 sg13cmos5l_decap_8 FILLER_9_119 ();
 sg13cmos5l_decap_8 FILLER_9_126 ();
 sg13cmos5l_decap_8 FILLER_9_133 ();
 sg13cmos5l_decap_8 FILLER_9_14 ();
 sg13cmos5l_decap_8 FILLER_9_140 ();
 sg13cmos5l_fill_2 FILLER_9_147 ();
 sg13cmos5l_fill_1 FILLER_9_149 ();
 sg13cmos5l_decap_8 FILLER_9_21 ();
 sg13cmos5l_decap_8 FILLER_9_28 ();
 sg13cmos5l_decap_8 FILLER_9_35 ();
 sg13cmos5l_decap_8 FILLER_9_42 ();
 sg13cmos5l_decap_8 FILLER_9_49 ();
 sg13cmos5l_decap_8 FILLER_9_56 ();
 sg13cmos5l_decap_8 FILLER_9_63 ();
 sg13cmos5l_decap_8 FILLER_9_7 ();
 sg13cmos5l_decap_8 FILLER_9_70 ();
 sg13cmos5l_decap_8 FILLER_9_77 ();
 sg13cmos5l_decap_8 FILLER_9_84 ();
 sg13cmos5l_decap_8 FILLER_9_91 ();
 sg13cmos5l_decap_8 FILLER_9_98 ();
 sg13cmos5l_inv_1 _38_ (.Y(_08_),
    .A(net2));
 sg13cmos5l_xnor2_1 _39_ (.Y(_09_),
    .A(net1),
    .B(net27));
 sg13cmos5l_nor2_1 _40_ (.A(_08_),
    .B(_09_),
    .Y(_00_));
 sg13cmos5l_nand2_1 _41_ (.Y(_10_),
    .A(net1),
    .B(net27));
 sg13cmos5l_xor2_1 _42_ (.B(_10_),
    .A(net28),
    .X(_11_));
 sg13cmos5l_nor2_1 _43_ (.A(_08_),
    .B(_11_),
    .Y(_01_));
 sg13cmos5l_nand3_1 _44_ (.B(net28),
    .C(net27),
    .A(net1),
    .Y(_12_));
 sg13cmos5l_buf_4 _45_ (.X(_13_),
    .A(_12_));
 sg13cmos5l_xor2_1 _46_ (.B(_13_),
    .A(net33),
    .X(_14_));
 sg13cmos5l_nor2_1 _47_ (.A(_08_),
    .B(_14_),
    .Y(_02_));
 sg13cmos5l_nand4_1 _48_ (.B(net5),
    .C(net28),
    .A(net1),
    .Y(_15_),
    .D(net27));
 sg13cmos5l_xor2_1 _49_ (.B(_15_),
    .A(net29),
    .X(_16_));
 sg13cmos5l_nor2_1 _50_ (.A(_08_),
    .B(net30),
    .Y(_03_));
 sg13cmos5l_nand2_1 _51_ (.Y(_17_),
    .A(net6),
    .B(net5));
 sg13cmos5l_o21ai_1 _52_ (.B1(net24),
    .Y(_18_),
    .A1(_13_),
    .A2(_17_));
 sg13cmos5l_or3_1 _53_ (.A(net24),
    .B(_13_),
    .C(_17_),
    .X(_19_));
 sg13cmos5l_a21oi_1 _54_ (.A1(net25),
    .A2(_19_),
    .Y(_04_),
    .B1(_08_));
 sg13cmos5l_nand3_1 _55_ (.B(net6),
    .C(net5),
    .A(net7),
    .Y(_20_));
 sg13cmos5l_o21ai_1 _56_ (.B1(net18),
    .Y(_21_),
    .A1(_13_),
    .A2(_20_));
 sg13cmos5l_or3_1 _57_ (.A(net18),
    .B(_13_),
    .C(_20_),
    .X(_22_));
 sg13cmos5l_a21oi_1 _58_ (.A1(net19),
    .A2(_22_),
    .Y(_05_),
    .B1(_08_));
 sg13cmos5l_nand4_1 _59_ (.B(net24),
    .C(net29),
    .A(net18),
    .Y(_23_),
    .D(net5));
 sg13cmos5l_o21ai_1 _60_ (.B1(net21),
    .Y(_24_),
    .A1(_13_),
    .A2(_23_));
 sg13cmos5l_or3_1 _61_ (.A(net21),
    .B(_13_),
    .C(_23_),
    .X(_25_));
 sg13cmos5l_a21oi_1 _62_ (.A1(net22),
    .A2(_25_),
    .Y(_06_),
    .B1(_08_));
 sg13cmos5l_and2_1 _63_ (.A(net31),
    .B(net2),
    .X(_26_));
 sg13cmos5l_nor2b_1 _64_ (.A(net31),
    .B_N(net2),
    .Y(_27_));
 sg13cmos5l_inv_1 _65_ (.Y(_28_),
    .A(net21));
 sg13cmos5l_nor3_2 _66_ (.A(_28_),
    .B(_13_),
    .C(_23_),
    .Y(_29_));
 sg13cmos5l_mux2_1 _67_ (.A0(_26_),
    .A1(_27_),
    .S(_29_),
    .X(_07_));
 sg13cmos5l_dfrbpq_1 _68_ (.RESET_B(net17),
    .D(_00_),
    .Q(net3),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13cmos5l_tiehi _68__18 (.L_HI(net17));
 sg13cmos5l_dfrbpq_1 _69_ (.RESET_B(net16),
    .D(_01_),
    .Q(net4),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13cmos5l_tiehi _69__17 (.L_HI(net16));
 sg13cmos5l_dfrbpq_1 _70_ (.RESET_B(net14),
    .D(_02_),
    .Q(net5),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13cmos5l_tiehi _70__15 (.L_HI(net14));
 sg13cmos5l_dfrbpq_1 _71_ (.RESET_B(net12),
    .D(_03_),
    .Q(net6),
    .CLK(clknet_1_0__leaf_clk_i));
 sg13cmos5l_tiehi _71__13 (.L_HI(net12));
 sg13cmos5l_dfrbpq_1 _72_ (.RESET_B(net),
    .D(net26),
    .Q(net7),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13cmos5l_tiehi _72__11 (.L_HI(net));
 sg13cmos5l_dfrbpq_1 _73_ (.RESET_B(net15),
    .D(net20),
    .Q(net8),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13cmos5l_tiehi _73__16 (.L_HI(net15));
 sg13cmos5l_dfrbpq_1 _74_ (.RESET_B(net11),
    .D(net23),
    .Q(net9),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13cmos5l_tiehi _74__12 (.L_HI(net11));
 sg13cmos5l_dfrbpq_1 _75_ (.RESET_B(net13),
    .D(net32),
    .Q(net10),
    .CLK(clknet_1_1__leaf_clk_i));
 sg13cmos5l_tiehi _75__14 (.L_HI(net13));
 sg13cmos5l_buf_8 clkbuf_0_clk_i (.A(clk_i),
    .X(clknet_0_clk_i));
 sg13cmos5l_buf_8 clkbuf_1_0__f_clk_i (.A(clknet_0_clk_i),
    .X(clknet_1_0__leaf_clk_i));
 sg13cmos5l_buf_8 clkbuf_1_1__f_clk_i (.A(clknet_0_clk_i),
    .X(clknet_1_1__leaf_clk_i));
 sg13cmos5l_dlygate4sd3_1 hold19 (.A(net8),
    .X(net18));
 sg13cmos5l_dlygate4sd3_1 hold20 (.A(_21_),
    .X(net19));
 sg13cmos5l_dlygate4sd3_1 hold21 (.A(_05_),
    .X(net20));
 sg13cmos5l_dlygate4sd3_1 hold22 (.A(net9),
    .X(net21));
 sg13cmos5l_dlygate4sd3_1 hold23 (.A(_24_),
    .X(net22));
 sg13cmos5l_dlygate4sd3_1 hold24 (.A(_06_),
    .X(net23));
 sg13cmos5l_dlygate4sd3_1 hold25 (.A(net7),
    .X(net24));
 sg13cmos5l_dlygate4sd3_1 hold26 (.A(_18_),
    .X(net25));
 sg13cmos5l_dlygate4sd3_1 hold27 (.A(_04_),
    .X(net26));
 sg13cmos5l_dlygate4sd3_1 hold28 (.A(net3),
    .X(net27));
 sg13cmos5l_dlygate4sd3_1 hold29 (.A(net4),
    .X(net28));
 sg13cmos5l_dlygate4sd3_1 hold30 (.A(net6),
    .X(net29));
 sg13cmos5l_dlygate4sd3_1 hold31 (.A(_16_),
    .X(net30));
 sg13cmos5l_dlygate4sd3_1 hold32 (.A(net10),
    .X(net31));
 sg13cmos5l_dlygate4sd3_1 hold33 (.A(_07_),
    .X(net32));
 sg13cmos5l_dlygate4sd3_1 hold34 (.A(net5),
    .X(net33));
 sg13cmos5l_buf_1 input1 (.A(enable_i),
    .X(net1));
 sg13cmos5l_buf_1 input2 (.A(rst_ni),
    .X(net2));
 sg13cmos5l_buf_1 output10 (.A(net10),
    .X(count_o[7]));
 sg13cmos5l_buf_1 output3 (.A(net3),
    .X(count_o[0]));
 sg13cmos5l_buf_1 output4 (.A(net4),
    .X(count_o[1]));
 sg13cmos5l_buf_1 output5 (.A(net5),
    .X(count_o[2]));
 sg13cmos5l_buf_1 output6 (.A(net6),
    .X(count_o[3]));
 sg13cmos5l_buf_1 output7 (.A(net7),
    .X(count_o[4]));
 sg13cmos5l_buf_1 output8 (.A(net8),
    .X(count_o[5]));
 sg13cmos5l_buf_1 output9 (.A(net9),
    .X(count_o[6]));
endmodule
