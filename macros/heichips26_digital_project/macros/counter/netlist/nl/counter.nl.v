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
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net1;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net2;
 wire net3;
 wire net;

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
 sg13cmos5l_decap_4 FILLER_11_102 ();
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
 sg13cmos5l_decap_8 FILLER_11_63 ();
 sg13cmos5l_decap_8 FILLER_11_7 ();
 sg13cmos5l_fill_2 FILLER_11_70 ();
 sg13cmos5l_decap_8 FILLER_11_81 ();
 sg13cmos5l_decap_8 FILLER_11_88 ();
 sg13cmos5l_decap_8 FILLER_11_95 ();
 sg13cmos5l_decap_8 FILLER_12_0 ();
 sg13cmos5l_decap_8 FILLER_12_123 ();
 sg13cmos5l_decap_8 FILLER_12_130 ();
 sg13cmos5l_decap_8 FILLER_12_137 ();
 sg13cmos5l_decap_4 FILLER_12_144 ();
 sg13cmos5l_fill_2 FILLER_12_148 ();
 sg13cmos5l_decap_8 FILLER_12_17 ();
 sg13cmos5l_decap_8 FILLER_12_24 ();
 sg13cmos5l_decap_4 FILLER_12_31 ();
 sg13cmos5l_fill_1 FILLER_12_35 ();
 sg13cmos5l_fill_2 FILLER_12_67 ();
 sg13cmos5l_fill_2 FILLER_12_7 ();
 sg13cmos5l_fill_1 FILLER_12_9 ();
 sg13cmos5l_decap_4 FILLER_13_0 ();
 sg13cmos5l_decap_8 FILLER_13_101 ();
 sg13cmos5l_fill_2 FILLER_13_108 ();
 sg13cmos5l_fill_1 FILLER_13_110 ();
 sg13cmos5l_decap_8 FILLER_13_121 ();
 sg13cmos5l_decap_4 FILLER_13_128 ();
 sg13cmos5l_fill_1 FILLER_13_132 ();
 sg13cmos5l_decap_8 FILLER_13_137 ();
 sg13cmos5l_decap_4 FILLER_13_144 ();
 sg13cmos5l_fill_2 FILLER_13_148 ();
 sg13cmos5l_decap_8 FILLER_13_17 ();
 sg13cmos5l_decap_4 FILLER_13_24 ();
 sg13cmos5l_fill_1 FILLER_13_28 ();
 sg13cmos5l_fill_1 FILLER_13_4 ();
 sg13cmos5l_decap_8 FILLER_13_56 ();
 sg13cmos5l_decap_4 FILLER_13_63 ();
 sg13cmos5l_fill_1 FILLER_13_67 ();
 sg13cmos5l_decap_8 FILLER_13_80 ();
 sg13cmos5l_decap_8 FILLER_13_87 ();
 sg13cmos5l_decap_8 FILLER_13_94 ();
 sg13cmos5l_decap_8 FILLER_14_0 ();
 sg13cmos5l_fill_2 FILLER_14_102 ();
 sg13cmos5l_fill_1 FILLER_14_104 ();
 sg13cmos5l_decap_8 FILLER_14_117 ();
 sg13cmos5l_decap_8 FILLER_14_124 ();
 sg13cmos5l_decap_8 FILLER_14_131 ();
 sg13cmos5l_decap_8 FILLER_14_138 ();
 sg13cmos5l_decap_8 FILLER_14_14 ();
 sg13cmos5l_decap_4 FILLER_14_145 ();
 sg13cmos5l_fill_1 FILLER_14_149 ();
 sg13cmos5l_decap_8 FILLER_14_21 ();
 sg13cmos5l_decap_8 FILLER_14_28 ();
 sg13cmos5l_decap_4 FILLER_14_35 ();
 sg13cmos5l_decap_8 FILLER_14_51 ();
 sg13cmos5l_decap_8 FILLER_14_58 ();
 sg13cmos5l_decap_4 FILLER_14_65 ();
 sg13cmos5l_fill_1 FILLER_14_69 ();
 sg13cmos5l_decap_8 FILLER_14_7 ();
 sg13cmos5l_decap_8 FILLER_14_74 ();
 sg13cmos5l_decap_8 FILLER_14_81 ();
 sg13cmos5l_decap_8 FILLER_14_88 ();
 sg13cmos5l_decap_8 FILLER_14_95 ();
 sg13cmos5l_decap_8 FILLER_15_0 ();
 sg13cmos5l_fill_1 FILLER_15_11 ();
 sg13cmos5l_decap_8 FILLER_15_123 ();
 sg13cmos5l_decap_8 FILLER_15_130 ();
 sg13cmos5l_decap_8 FILLER_15_137 ();
 sg13cmos5l_decap_4 FILLER_15_144 ();
 sg13cmos5l_fill_2 FILLER_15_148 ();
 sg13cmos5l_decap_8 FILLER_15_16 ();
 sg13cmos5l_decap_4 FILLER_15_23 ();
 sg13cmos5l_fill_2 FILLER_15_27 ();
 sg13cmos5l_decap_8 FILLER_15_56 ();
 sg13cmos5l_decap_8 FILLER_15_63 ();
 sg13cmos5l_decap_4 FILLER_15_7 ();
 sg13cmos5l_decap_4 FILLER_15_70 ();
 sg13cmos5l_decap_8 FILLER_15_85 ();
 sg13cmos5l_decap_4 FILLER_15_92 ();
 sg13cmos5l_fill_2 FILLER_16_107 ();
 sg13cmos5l_decap_8 FILLER_16_121 ();
 sg13cmos5l_decap_8 FILLER_16_128 ();
 sg13cmos5l_decap_8 FILLER_16_135 ();
 sg13cmos5l_decap_8 FILLER_16_142 ();
 sg13cmos5l_fill_1 FILLER_16_149 ();
 sg13cmos5l_decap_8 FILLER_16_19 ();
 sg13cmos5l_decap_4 FILLER_16_26 ();
 sg13cmos5l_fill_2 FILLER_16_4 ();
 sg13cmos5l_fill_1 FILLER_16_6 ();
 sg13cmos5l_fill_2 FILLER_16_71 ();
 sg13cmos5l_decap_8 FILLER_17_0 ();
 sg13cmos5l_decap_8 FILLER_17_103 ();
 sg13cmos5l_fill_1 FILLER_17_11 ();
 sg13cmos5l_decap_4 FILLER_17_115 ();
 sg13cmos5l_decap_8 FILLER_17_123 ();
 sg13cmos5l_decap_8 FILLER_17_130 ();
 sg13cmos5l_decap_8 FILLER_17_137 ();
 sg13cmos5l_decap_4 FILLER_17_144 ();
 sg13cmos5l_fill_2 FILLER_17_148 ();
 sg13cmos5l_decap_8 FILLER_17_16 ();
 sg13cmos5l_decap_4 FILLER_17_23 ();
 sg13cmos5l_fill_2 FILLER_17_27 ();
 sg13cmos5l_fill_2 FILLER_17_42 ();
 sg13cmos5l_fill_1 FILLER_17_48 ();
 sg13cmos5l_decap_8 FILLER_17_53 ();
 sg13cmos5l_decap_8 FILLER_17_60 ();
 sg13cmos5l_decap_8 FILLER_17_67 ();
 sg13cmos5l_decap_4 FILLER_17_7 ();
 sg13cmos5l_fill_1 FILLER_17_74 ();
 sg13cmos5l_decap_8 FILLER_17_89 ();
 sg13cmos5l_decap_8 FILLER_17_96 ();
 sg13cmos5l_decap_4 FILLER_18_0 ();
 sg13cmos5l_fill_2 FILLER_18_103 ();
 sg13cmos5l_decap_8 FILLER_18_109 ();
 sg13cmos5l_fill_2 FILLER_18_116 ();
 sg13cmos5l_fill_1 FILLER_18_118 ();
 sg13cmos5l_decap_8 FILLER_18_123 ();
 sg13cmos5l_decap_8 FILLER_18_130 ();
 sg13cmos5l_decap_8 FILLER_18_137 ();
 sg13cmos5l_fill_1 FILLER_18_144 ();
 sg13cmos5l_fill_1 FILLER_18_149 ();
 sg13cmos5l_decap_4 FILLER_18_16 ();
 sg13cmos5l_fill_2 FILLER_18_20 ();
 sg13cmos5l_decap_8 FILLER_18_26 ();
 sg13cmos5l_decap_8 FILLER_18_33 ();
 sg13cmos5l_fill_1 FILLER_18_4 ();
 sg13cmos5l_decap_4 FILLER_18_40 ();
 sg13cmos5l_fill_1 FILLER_18_44 ();
 sg13cmos5l_decap_8 FILLER_18_49 ();
 sg13cmos5l_decap_8 FILLER_18_56 ();
 sg13cmos5l_fill_2 FILLER_18_63 ();
 sg13cmos5l_decap_8 FILLER_18_69 ();
 sg13cmos5l_decap_8 FILLER_18_76 ();
 sg13cmos5l_fill_2 FILLER_18_83 ();
 sg13cmos5l_decap_8 FILLER_18_89 ();
 sg13cmos5l_decap_8 FILLER_18_9 ();
 sg13cmos5l_decap_8 FILLER_18_96 ();
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
    .A(net3));
 sg13cmos5l_xnor2_1 _39_ (.Y(_09_),
    .A(net2),
    .B(net4));
 sg13cmos5l_nor2_1 _40_ (.A(_08_),
    .B(_09_),
    .Y(_00_));
 sg13cmos5l_nand2_1 _41_ (.Y(_10_),
    .A(net2),
    .B(net4));
 sg13cmos5l_xor2_1 _42_ (.B(_10_),
    .A(net5),
    .X(_11_));
 sg13cmos5l_nor2_1 _43_ (.A(_08_),
    .B(_11_),
    .Y(_01_));
 sg13cmos5l_nand3_1 _44_ (.B(net5),
    .C(net4),
    .A(net2),
    .Y(_12_));
 sg13cmos5l_buf_4 _45_ (.X(_13_),
    .A(_12_));
 sg13cmos5l_xor2_1 _46_ (.B(_13_),
    .A(net6),
    .X(_14_));
 sg13cmos5l_nor2_1 _47_ (.A(_08_),
    .B(_14_),
    .Y(_02_));
 sg13cmos5l_nand4_1 _48_ (.B(net6),
    .C(net5),
    .A(net2),
    .Y(_15_),
    .D(net4));
 sg13cmos5l_xor2_1 _49_ (.B(_15_),
    .A(net7),
    .X(_16_));
 sg13cmos5l_nor2_1 _50_ (.A(_08_),
    .B(_16_),
    .Y(_03_));
 sg13cmos5l_nand2_1 _51_ (.Y(_17_),
    .A(net7),
    .B(net6));
 sg13cmos5l_o21ai_1 _52_ (.B1(net8),
    .Y(_18_),
    .A1(_13_),
    .A2(_17_));
 sg13cmos5l_or3_1 _53_ (.A(net8),
    .B(_13_),
    .C(_17_),
    .X(_19_));
 sg13cmos5l_a21oi_1 _54_ (.A1(_18_),
    .A2(_19_),
    .Y(_04_),
    .B1(_08_));
 sg13cmos5l_nand3_1 _55_ (.B(net7),
    .C(net6),
    .A(net8),
    .Y(_20_));
 sg13cmos5l_o21ai_1 _56_ (.B1(net9),
    .Y(_21_),
    .A1(_13_),
    .A2(_20_));
 sg13cmos5l_or3_1 _57_ (.A(net9),
    .B(_13_),
    .C(_20_),
    .X(_22_));
 sg13cmos5l_a21oi_1 _58_ (.A1(_21_),
    .A2(_22_),
    .Y(_05_),
    .B1(_08_));
 sg13cmos5l_nand4_1 _59_ (.B(net8),
    .C(net7),
    .A(net9),
    .Y(_23_),
    .D(net6));
 sg13cmos5l_o21ai_1 _60_ (.B1(net10),
    .Y(_24_),
    .A1(_13_),
    .A2(_23_));
 sg13cmos5l_or3_1 _61_ (.A(net10),
    .B(_13_),
    .C(_23_),
    .X(_25_));
 sg13cmos5l_a21oi_1 _62_ (.A1(_24_),
    .A2(_25_),
    .Y(_06_),
    .B1(_08_));
 sg13cmos5l_and2_1 _63_ (.A(net11),
    .B(net3),
    .X(_26_));
 sg13cmos5l_nor2b_1 _64_ (.A(net11),
    .B_N(net3),
    .Y(_27_));
 sg13cmos5l_inv_1 _65_ (.Y(_28_),
    .A(net10));
 sg13cmos5l_nor3_2 _66_ (.A(_28_),
    .B(_13_),
    .C(_23_),
    .Y(_29_));
 sg13cmos5l_mux2_1 _67_ (.A0(_26_),
    .A1(_27_),
    .S(_29_),
    .X(_07_));
 sg13cmos5l_dfrbpq_1 _68_ (.RESET_B(net18),
    .D(_00_),
    .Q(net4),
    .CLK(net1));
 sg13cmos5l_tiehi _68__19 (.L_HI(net18));
 sg13cmos5l_dfrbpq_1 _69_ (.RESET_B(net17),
    .D(_01_),
    .Q(net5),
    .CLK(net1));
 sg13cmos5l_tiehi _69__18 (.L_HI(net17));
 sg13cmos5l_dfrbpq_1 _70_ (.RESET_B(net15),
    .D(_02_),
    .Q(net6),
    .CLK(net1));
 sg13cmos5l_tiehi _70__16 (.L_HI(net15));
 sg13cmos5l_dfrbpq_1 _71_ (.RESET_B(net13),
    .D(_03_),
    .Q(net7),
    .CLK(net1));
 sg13cmos5l_tiehi _71__14 (.L_HI(net13));
 sg13cmos5l_dfrbpq_1 _72_ (.RESET_B(net),
    .D(_04_),
    .Q(net8),
    .CLK(net1));
 sg13cmos5l_tiehi _72__12 (.L_HI(net));
 sg13cmos5l_dfrbpq_1 _73_ (.RESET_B(net16),
    .D(_05_),
    .Q(net9),
    .CLK(net1));
 sg13cmos5l_tiehi _73__17 (.L_HI(net16));
 sg13cmos5l_dfrbpq_1 _74_ (.RESET_B(net12),
    .D(_06_),
    .Q(net10),
    .CLK(net1));
 sg13cmos5l_tiehi _74__13 (.L_HI(net12));
 sg13cmos5l_dfrbpq_1 _75_ (.RESET_B(net14),
    .D(_07_),
    .Q(net11),
    .CLK(net1));
 sg13cmos5l_tiehi _75__15 (.L_HI(net14));
 sg13cmos5l_buf_1 input1 (.A(clk_i),
    .X(net1));
 sg13cmos5l_buf_1 input2 (.A(enable_i),
    .X(net2));
 sg13cmos5l_buf_1 input3 (.A(rst_ni),
    .X(net3));
 sg13cmos5l_buf_1 output10 (.A(net10),
    .X(count_o[6]));
 sg13cmos5l_buf_1 output11 (.A(net11),
    .X(count_o[7]));
 sg13cmos5l_buf_1 output4 (.A(net4),
    .X(count_o[0]));
 sg13cmos5l_buf_1 output5 (.A(net5),
    .X(count_o[1]));
 sg13cmos5l_buf_1 output6 (.A(net6),
    .X(count_o[2]));
 sg13cmos5l_buf_1 output7 (.A(net7),
    .X(count_o[3]));
 sg13cmos5l_buf_1 output8 (.A(net8),
    .X(count_o[4]));
 sg13cmos5l_buf_1 output9 (.A(net9),
    .X(count_o[5]));
endmodule
