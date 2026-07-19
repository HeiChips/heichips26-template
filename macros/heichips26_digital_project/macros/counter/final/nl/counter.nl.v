module counter (clock_i,
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
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
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
 wire net11;
 wire net;
 wire clknet_1_0__leaf_clock_i;
 wire clknet_1_1__leaf_clock_i;
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
 wire net35;
 wire net36;

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
 sg13cmos5l_decap_8 FILLER_11_101 ();
 sg13cmos5l_decap_8 FILLER_11_108 ();
 sg13cmos5l_decap_8 FILLER_11_115 ();
 sg13cmos5l_decap_8 FILLER_11_122 ();
 sg13cmos5l_decap_8 FILLER_11_129 ();
 sg13cmos5l_decap_8 FILLER_11_136 ();
 sg13cmos5l_decap_8 FILLER_11_143 ();
 sg13cmos5l_decap_8 FILLER_11_18 ();
 sg13cmos5l_decap_8 FILLER_11_25 ();
 sg13cmos5l_fill_2 FILLER_11_32 ();
 sg13cmos5l_decap_8 FILLER_11_43 ();
 sg13cmos5l_decap_8 FILLER_11_50 ();
 sg13cmos5l_decap_8 FILLER_11_57 ();
 sg13cmos5l_decap_8 FILLER_11_64 ();
 sg13cmos5l_decap_8 FILLER_11_7 ();
 sg13cmos5l_decap_8 FILLER_11_71 ();
 sg13cmos5l_decap_8 FILLER_11_78 ();
 sg13cmos5l_decap_8 FILLER_11_85 ();
 sg13cmos5l_decap_4 FILLER_11_92 ();
 sg13cmos5l_decap_4 FILLER_12_0 ();
 sg13cmos5l_decap_8 FILLER_12_116 ();
 sg13cmos5l_decap_8 FILLER_12_123 ();
 sg13cmos5l_decap_8 FILLER_12_130 ();
 sg13cmos5l_decap_8 FILLER_12_137 ();
 sg13cmos5l_decap_4 FILLER_12_144 ();
 sg13cmos5l_fill_2 FILLER_12_148 ();
 sg13cmos5l_decap_8 FILLER_12_17 ();
 sg13cmos5l_decap_4 FILLER_12_24 ();
 sg13cmos5l_fill_1 FILLER_12_28 ();
 sg13cmos5l_decap_8 FILLER_12_60 ();
 sg13cmos5l_decap_8 FILLER_12_67 ();
 sg13cmos5l_decap_8 FILLER_12_74 ();
 sg13cmos5l_fill_2 FILLER_12_81 ();
 sg13cmos5l_fill_1 FILLER_12_83 ();
 sg13cmos5l_decap_8 FILLER_13_0 ();
 sg13cmos5l_fill_2 FILLER_13_101 ();
 sg13cmos5l_fill_1 FILLER_13_103 ();
 sg13cmos5l_decap_8 FILLER_13_120 ();
 sg13cmos5l_decap_4 FILLER_13_127 ();
 sg13cmos5l_fill_2 FILLER_13_131 ();
 sg13cmos5l_decap_8 FILLER_13_138 ();
 sg13cmos5l_decap_8 FILLER_13_14 ();
 sg13cmos5l_decap_4 FILLER_13_145 ();
 sg13cmos5l_fill_1 FILLER_13_149 ();
 sg13cmos5l_decap_8 FILLER_13_21 ();
 sg13cmos5l_decap_8 FILLER_13_28 ();
 sg13cmos5l_decap_8 FILLER_13_35 ();
 sg13cmos5l_decap_4 FILLER_13_42 ();
 sg13cmos5l_decap_8 FILLER_13_7 ();
 sg13cmos5l_fill_2 FILLER_13_78 ();
 sg13cmos5l_decap_8 FILLER_14_0 ();
 sg13cmos5l_decap_8 FILLER_14_123 ();
 sg13cmos5l_fill_2 FILLER_14_130 ();
 sg13cmos5l_fill_1 FILLER_14_132 ();
 sg13cmos5l_decap_4 FILLER_14_146 ();
 sg13cmos5l_decap_8 FILLER_14_19 ();
 sg13cmos5l_fill_2 FILLER_14_26 ();
 sg13cmos5l_fill_1 FILLER_14_28 ();
 sg13cmos5l_decap_8 FILLER_14_35 ();
 sg13cmos5l_decap_4 FILLER_14_63 ();
 sg13cmos5l_fill_1 FILLER_14_67 ();
 sg13cmos5l_decap_8 FILLER_14_7 ();
 sg13cmos5l_decap_4 FILLER_14_77 ();
 sg13cmos5l_fill_2 FILLER_14_81 ();
 sg13cmos5l_decap_8 FILLER_15_0 ();
 sg13cmos5l_decap_8 FILLER_15_123 ();
 sg13cmos5l_fill_2 FILLER_15_130 ();
 sg13cmos5l_fill_1 FILLER_15_132 ();
 sg13cmos5l_decap_8 FILLER_15_142 ();
 sg13cmos5l_fill_1 FILLER_15_149 ();
 sg13cmos5l_decap_8 FILLER_15_18 ();
 sg13cmos5l_decap_4 FILLER_15_25 ();
 sg13cmos5l_decap_4 FILLER_15_56 ();
 sg13cmos5l_fill_1 FILLER_15_60 ();
 sg13cmos5l_decap_8 FILLER_15_64 ();
 sg13cmos5l_fill_2 FILLER_15_7 ();
 sg13cmos5l_fill_2 FILLER_15_71 ();
 sg13cmos5l_fill_1 FILLER_15_9 ();
 sg13cmos5l_fill_2 FILLER_15_93 ();
 sg13cmos5l_fill_1 FILLER_15_95 ();
 sg13cmos5l_decap_4 FILLER_16_0 ();
 sg13cmos5l_decap_8 FILLER_16_123 ();
 sg13cmos5l_fill_2 FILLER_16_130 ();
 sg13cmos5l_fill_1 FILLER_16_132 ();
 sg13cmos5l_decap_8 FILLER_16_137 ();
 sg13cmos5l_decap_4 FILLER_16_144 ();
 sg13cmos5l_fill_2 FILLER_16_148 ();
 sg13cmos5l_decap_8 FILLER_16_18 ();
 sg13cmos5l_decap_4 FILLER_16_25 ();
 sg13cmos5l_fill_2 FILLER_16_61 ();
 sg13cmos5l_fill_1 FILLER_16_63 ();
 sg13cmos5l_decap_4 FILLER_16_90 ();
 sg13cmos5l_fill_2 FILLER_16_94 ();
 sg13cmos5l_fill_2 FILLER_17_0 ();
 sg13cmos5l_fill_1 FILLER_17_115 ();
 sg13cmos5l_decap_8 FILLER_17_123 ();
 sg13cmos5l_fill_2 FILLER_17_130 ();
 sg13cmos5l_fill_1 FILLER_17_132 ();
 sg13cmos5l_decap_8 FILLER_17_142 ();
 sg13cmos5l_fill_1 FILLER_17_149 ();
 sg13cmos5l_decap_8 FILLER_17_19 ();
 sg13cmos5l_fill_1 FILLER_17_2 ();
 sg13cmos5l_decap_4 FILLER_17_26 ();
 sg13cmos5l_fill_1 FILLER_17_30 ();
 sg13cmos5l_fill_2 FILLER_17_44 ();
 sg13cmos5l_fill_1 FILLER_17_46 ();
 sg13cmos5l_decap_4 FILLER_18_0 ();
 sg13cmos5l_decap_8 FILLER_18_123 ();
 sg13cmos5l_fill_2 FILLER_18_130 ();
 sg13cmos5l_fill_1 FILLER_18_132 ();
 sg13cmos5l_decap_8 FILLER_18_137 ();
 sg13cmos5l_fill_1 FILLER_18_144 ();
 sg13cmos5l_fill_1 FILLER_18_149 ();
 sg13cmos5l_decap_4 FILLER_18_16 ();
 sg13cmos5l_fill_2 FILLER_18_20 ();
 sg13cmos5l_decap_4 FILLER_18_26 ();
 sg13cmos5l_fill_1 FILLER_18_30 ();
 sg13cmos5l_fill_1 FILLER_18_4 ();
 sg13cmos5l_decap_4 FILLER_18_40 ();
 sg13cmos5l_fill_1 FILLER_18_44 ();
 sg13cmos5l_decap_8 FILLER_18_49 ();
 sg13cmos5l_decap_8 FILLER_18_56 ();
 sg13cmos5l_fill_2 FILLER_18_63 ();
 sg13cmos5l_decap_4 FILLER_18_73 ();
 sg13cmos5l_fill_1 FILLER_18_77 ();
 sg13cmos5l_fill_2 FILLER_18_82 ();
 sg13cmos5l_fill_1 FILLER_18_84 ();
 sg13cmos5l_fill_2 FILLER_18_89 ();
 sg13cmos5l_decap_8 FILLER_18_9 ();
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
 sg13cmos5l_inv_1 _37_ (.Y(_08_),
    .A(net6));
 sg13cmos5l_nand4_1 _38_ (.B(net5),
    .C(net4),
    .A(net1),
    .Y(_09_),
    .D(net3));
 sg13cmos5l_buf_4 _39_ (.X(_10_),
    .A(_09_));
 sg13cmos5l_o21ai_1 _40_ (.B1(net28),
    .Y(_11_),
    .A1(_08_),
    .A2(net11));
 sg13cmos5l_or3_1 _41_ (.A(_08_),
    .B(net28),
    .C(net11),
    .X(_12_));
 sg13cmos5l_inv_1 _42_ (.Y(_13_),
    .A(net2));
 sg13cmos5l_a21oi_1 _43_ (.A1(net29),
    .A2(_12_),
    .Y(_00_),
    .B1(_13_));
 sg13cmos5l_nand2_1 _44_ (.Y(_14_),
    .A(net6),
    .B(net7));
 sg13cmos5l_o21ai_1 _45_ (.B1(net22),
    .Y(_15_),
    .A1(net11),
    .A2(_14_));
 sg13cmos5l_or3_1 _46_ (.A(net22),
    .B(net11),
    .C(_14_),
    .X(_16_));
 sg13cmos5l_a21oi_1 _47_ (.A1(net23),
    .A2(_16_),
    .Y(_01_),
    .B1(_13_));
 sg13cmos5l_nand3_1 _48_ (.B(net22),
    .C(net7),
    .A(net6),
    .Y(_17_));
 sg13cmos5l_o21ai_1 _49_ (.B1(net25),
    .Y(_18_),
    .A1(net11),
    .A2(_17_));
 sg13cmos5l_or3_1 _50_ (.A(net25),
    .B(net11),
    .C(_17_),
    .X(_19_));
 sg13cmos5l_a21oi_1 _51_ (.A1(net26),
    .A2(_19_),
    .Y(_02_),
    .B1(_13_));
 sg13cmos5l_nand4_1 _52_ (.B(net9),
    .C(net8),
    .A(net6),
    .Y(_20_),
    .D(net7));
 sg13cmos5l_o21ai_1 _53_ (.B1(net19),
    .Y(_21_),
    .A1(net11),
    .A2(_20_));
 sg13cmos5l_or3_1 _54_ (.A(net19),
    .B(_10_),
    .C(_20_),
    .X(_22_));
 sg13cmos5l_a21oi_1 _55_ (.A1(net20),
    .A2(_22_),
    .Y(_03_),
    .B1(_13_));
 sg13cmos5l_xor2_1 _56_ (.B(net35),
    .A(net1),
    .X(_23_));
 sg13cmos5l_and2_1 _57_ (.A(net2),
    .B(_23_),
    .X(_04_));
 sg13cmos5l_nand2_1 _58_ (.Y(_24_),
    .A(net1),
    .B(net3));
 sg13cmos5l_xnor2_1 _59_ (.Y(_25_),
    .A(net33),
    .B(_24_));
 sg13cmos5l_and2_1 _60_ (.A(net2),
    .B(net34),
    .X(_05_));
 sg13cmos5l_nand3_1 _61_ (.B(net4),
    .C(net3),
    .A(net1),
    .Y(_26_));
 sg13cmos5l_xnor2_1 _62_ (.Y(_27_),
    .A(net31),
    .B(_26_));
 sg13cmos5l_and2_1 _63_ (.A(net2),
    .B(net32),
    .X(_06_));
 sg13cmos5l_xnor2_1 _64_ (.Y(_28_),
    .A(net36),
    .B(net11));
 sg13cmos5l_and2_1 _65_ (.A(net2),
    .B(_28_),
    .X(_07_));
 sg13cmos5l_dfrbpq_1 _66_ (.RESET_B(net12),
    .D(net27),
    .Q(net9),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _66__13 (.L_HI(net12));
 sg13cmos5l_dfrbpq_1 _67_ (.RESET_B(net18),
    .D(net21),
    .Q(net10),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _67__19 (.L_HI(net18));
 sg13cmos5l_dfrbpq_1 _68_ (.RESET_B(net16),
    .D(_04_),
    .Q(net3),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _68__17 (.L_HI(net16));
 sg13cmos5l_dfrbpq_1 _69_ (.RESET_B(net13),
    .D(_05_),
    .Q(net4),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _69__14 (.L_HI(net13));
 sg13cmos5l_dfrbpq_1 _70_ (.RESET_B(net17),
    .D(_06_),
    .Q(net5),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _70__18 (.L_HI(net17));
 sg13cmos5l_dfrbpq_1 _71_ (.RESET_B(net),
    .D(_07_),
    .Q(net6),
    .CLK(clknet_1_0__leaf_clock_i));
 sg13cmos5l_tiehi _71__12 (.L_HI(net));
 sg13cmos5l_dfrbpq_1 _72_ (.RESET_B(net15),
    .D(net30),
    .Q(net7),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _72__16 (.L_HI(net15));
 sg13cmos5l_dfrbpq_1 _73_ (.RESET_B(net14),
    .D(net24),
    .Q(net8),
    .CLK(clknet_1_1__leaf_clock_i));
 sg13cmos5l_tiehi _73__15 (.L_HI(net14));
 sg13cmos5l_buf_8 clkbuf_0_clock_i (.A(clock_i),
    .X(clknet_0_clock_i));
 sg13cmos5l_buf_8 clkbuf_1_0__f_clock_i (.A(clknet_0_clock_i),
    .X(clknet_1_0__leaf_clock_i));
 sg13cmos5l_buf_8 clkbuf_1_1__f_clock_i (.A(clknet_0_clock_i),
    .X(clknet_1_1__leaf_clock_i));
 sg13cmos5l_buf_1 fanout11 (.A(_10_),
    .X(net11));
 sg13cmos5l_dlygate4sd3_1 hold20 (.A(net10),
    .X(net19));
 sg13cmos5l_dlygate4sd3_1 hold21 (.A(_21_),
    .X(net20));
 sg13cmos5l_dlygate4sd3_1 hold22 (.A(_03_),
    .X(net21));
 sg13cmos5l_dlygate4sd3_1 hold23 (.A(net8),
    .X(net22));
 sg13cmos5l_dlygate4sd3_1 hold24 (.A(_15_),
    .X(net23));
 sg13cmos5l_dlygate4sd3_1 hold25 (.A(_01_),
    .X(net24));
 sg13cmos5l_dlygate4sd3_1 hold26 (.A(net9),
    .X(net25));
 sg13cmos5l_dlygate4sd3_1 hold27 (.A(_18_),
    .X(net26));
 sg13cmos5l_dlygate4sd3_1 hold28 (.A(_02_),
    .X(net27));
 sg13cmos5l_dlygate4sd3_1 hold29 (.A(net7),
    .X(net28));
 sg13cmos5l_dlygate4sd3_1 hold30 (.A(_11_),
    .X(net29));
 sg13cmos5l_dlygate4sd3_1 hold31 (.A(_00_),
    .X(net30));
 sg13cmos5l_dlygate4sd3_1 hold32 (.A(net5),
    .X(net31));
 sg13cmos5l_dlygate4sd3_1 hold33 (.A(_27_),
    .X(net32));
 sg13cmos5l_dlygate4sd3_1 hold34 (.A(net4),
    .X(net33));
 sg13cmos5l_dlygate4sd3_1 hold35 (.A(_25_),
    .X(net34));
 sg13cmos5l_dlygate4sd3_1 hold36 (.A(net3),
    .X(net35));
 sg13cmos5l_dlygate4sd3_1 hold37 (.A(net6),
    .X(net36));
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
