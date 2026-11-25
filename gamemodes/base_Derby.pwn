// Server Derby Script


// Derby Defines
#define DERBY_POS_M1             		4520.9189, -1753.6084, 56.1358
#define DERBY_CAMPOS_M1                 4453.8774, -1642.1117, 36.6551
#define DERBY_CAMLA_M1                  4454.6743, -1642.7051, 36.2001
#define DERBY_FALLOVER_M1               (1)

#define DERBY_POS_M2					-3948.2632, 951.8198, 78.4012
#define DERBY_CAMPOS_M2                 -4031.8118, 985.9628, 73.5483
#define DERBY_CAMLA_M2                  -4030.9736, 985.4224, 73.2184
#define DERBY_FALLOVER_M2     			(20)

#define DERBY_POS_M3              		4028.5825, -1909.2007, 56.6765
#define DERBY_CAMPOS_M3                 4090.4087, -1995.4886, 50.2633
#define DERBY_CAMLA_M3                  4089.7327, -1994.7545, 49.7484
#define DERBY_FALLOVER_M3               (1)

#define DERBY_POS_M4              		2876.0093, -3530.1829, 24.4397
#define DERBY_CAMPOS_M4                 2800.4382, -3449.5762, 39.5314
#define DERBY_CAMLA_M4                  2801.1716, -3450.2600, 38.9760
#define DERBY_FALLOVER_M4               (1)

#define DERBY_POS_M5              		3749.7786, -69.5137, 34.7968
#define DERBY_CAMPOS_M5                 3917.3489, -53.3306, 18.7947
#define DERBY_CAMLA_M5                 	3916.3560, -53.4894, 18.5597
#define DERBY_FALLOVER_M5               (1)

#define DERBY_POS_M6              		4463.1001,-3039.4541,64.0850
#define DERBY_CAMPOS_M6                 4499.177734, -3117.914306, 68.163162
#define DERBY_CAMLA_M6                 	4496.385742, -3114.088623, 66.560409
#define DERBY_FALLOVER_M6               (28)

#define DERBY_POS_M7            		395.1932,5334.7422,36.4002
#define DERBY_CAMPOS_M7                 490.494384, 5335.783691, 39.094772
#define DERBY_CAMLA_M7                  485.917968, 5335.807128, 37.080879
#define DERBY_FALLOVER_M7               (8)

#define DERBY_POS_M8            		-3344.7795,-3520.8469,35.5849
#define DERBY_CAMPOS_M8                 -3233.295654, -3631.928710, 43.468898
#define DERBY_CAMLA_M8                  -3236.821533, -3628.960693, 41.529773
#define DERBY_FALLOVER_M8               (6)

#define DERBY_POS_M9            		-1092.25, -7076.03, 48.35
#define DERBY_CAMPOS_M9                 -1099.7087, -7073.3540, 44.2707
#define DERBY_CAMLA_M9                  -1100.4696, -7072.6895, 43.9257
#define DERBY_FALLOVER_M9               (1)

#define DERBY_POS_M10                   -3311.07544, -4316.29492, 125.06580
#define DERBY_CAMPOS_M10                -3474.9255, -4392.3989, 130.5992
#define DERBY_CAMLA_M10                 -3474.2910, -4391.6348, 130.2891
#define DERBY_FALLOVER_M10               (68)

#define DERBY_POS_M11                   -3311.07544, -4316.29492, 125.06580
#define DERBY_CAMPOS_M11                3878.81, 572.71, 96.12
#define DERBY_CAMLA_M11                 3878.21, 571.83, 96.02
#define DERBY_FALLOVER_M11              (1)

#define MAX_DERBY_PLAYERS  				(20)
#define DERBY_WORLD                     (5050)
#define DERBY_TIME      				(110000)
#define DERBY_VOTING_TIME     			(17000)
#define DEFAULT_DERBY_TIME              (115)
#define DERBY_FALLOVER_CHECK_TIME   	(700)

// Derby Data
enum e_derby_map1_data
{
	Float:m1sX,
	Float:m1sY,
	Float:m1sZ,
	Float:m1sA,
	bool:m1sUsed
}
enum e_derby_map2_data
{
	Float:m2sX,
	Float:m2sY,
	Float:m2sZ,
	Float:m2sA,
	bool:m2sUsed
}
enum e_derby_map3_data
{
	Float:m3sX,
	Float:m3sY,
	Float:m3sZ,
	Float:m3sA,
	bool:m3sUsed
}
enum e_derby_map4_data
{
	Float:m4sX,
	Float:m4sY,
	Float:m4sZ,
	Float:m4sA,
	bool:m4sUsed
}
enum e_derby_map5_data
{
	Float:m5sX,
	Float:m5sY,
	Float:m5sZ,
	Float:m5sA,
	bool:m5sUsed
}
enum e_derby_map6_data
{
	Float:m6sX,
	Float:m6sY,
	Float:m6sZ,
	Float:m6sA,
	bool:m6sUsed
}
enum e_derby_map7_data
{
	Float:m7sX,
	Float:m7sY,
	Float:m7sZ,
	Float:m7sA,
	bool:m7sUsed
}
enum e_derby_map8_data
{
	Float:m8sX,
	Float:m8sY,
	Float:m8sZ,
	Float:m8sA,
	bool:m8sUsed
}

enum e_derby_map9_data
{
	Float:m9sX,
	Float:m9sY,
	Float:m9sZ,
	Float:m9sA,
	bool:m9sUsed
}

enum e_derby_map10_data
{
	Float:m10sX,
	Float:m10sY,
	Float:m10sZ,
	Float:m10sA,
	bool:m10sUsed
}

enum e_derby_map11_data
{
	Float:m11sX,
	Float:m11sY,
	Float:m11sZ,
	Float:m11sA,
	bool:m11sUsed
}

new Derby_Map1Spawns[MAX_DERBY_PLAYERS][e_derby_map1_data] =
{
	{4564.8662, -1780.7690, 3.4892, 113.5751, false},
	{4537.0317, -1773.2226, 3.5079, 17.6972, false},
	{4532.4731, -1730.4630, 3.5094, 1.5997, false},
	{4528.1772, -1693.3404, 3.5067, 9.8237, false},
	{4509.5317, -1651.5343, 3.5063, 36.9094, false},
	{4476.1191, -1650.5437, 3.5087, 183.0121, false},
	{4478.9091, -1687.5764, 3.5100, 183.2693, false},
	{4479.6303, -1734.8458, 3.5113, 179.2202, false},
	{4496.7563, -1803.1461, 3.5070, 302.3572, false},
	{4553.0380, -1734.8894, 3.5056, 270.5491, false},
	{4539.4926, -1761.5322, 18.3019, 7.2416, false},
	{4525.7851, -1701.7504, 18.2979, 7.8820, false},
	{4496.1748, -1657.7183, 18.3030, 129.2133, false},
	{4543.4536, -1796.9326, 18.3018, 187.9175, false},
	{4505.9531, -1744.8052, 3.5002, 269.9085, false},
	{4515.0185, -1760.6062, 3.5032, 216.3052, false},
	{4565.7241, -1689.1856, 3.4987, 59.0123, false},
	{4540.9121, -1656.6251, 3.5087, 1.8054, false},
	{4558.3378, -1645.2890, 3.4925, 145.0575, false},
	{4507.0502, -1796.4394, 3.5054, 120.5433, false}
};

new Derby_Map2Spawns[MAX_DERBY_PLAYERS][e_derby_map2_data] =
{
	{-3957.3640, 969.7915, 65.6281, 235.3673, false},
	{-3942.8943, 938.6829, 65.6085, 359.7384, false},
	{-3905.7332, 922.6584, 52.5285, 268.2442, false},
	{-3878.5010, 922.4542, 52.5285, 91.23260, false},
	{-3862.9128, 927.0121, 52.5081, 323.7048, false},
	{-3846.5625, 931.5337, 52.5081, 36.39880, false},
	{-3847.0959, 946.5208, 52.5281, 71.17910, false},
	{-3862.3210, 960.0160, 52.5281, 244.1173, false},
	{-3845.7188, 989.4063, 52.5285, 272.0277, false},
	{-3886.8899, 989.3755, 52.5285, 89.35270, false},
	{-3890.9119, 969.2299, 52.5285, 177.0868, false},
	{-3893.9905, 949.9914, 52.5285, 131.3398, false},
	{-3912.6133, 948.6409, 52.5285, 91.54600, false},
	{-3934.2073, 961.6917, 52.5085, 1.931900, false},
	{-3929.2332, 975.3268, 40.8805, 268.2678, false},
	{-3941.8633, 957.9515, 36.3281, 39.84560, false},
	{-3974.4358, 959.5692, 36.3285, 118.8063, false},
	{-4013.4832, 925.3674, 52.5285, 356.6052, false},
	{-4011.8496, 954.6926, 52.5285, 268.5577, false},
	{-3993.0066, 978.3261, 52.5085, 107.5262, false}
};

new Derby_Map3Spawns[MAX_DERBY_PLAYERS][e_derby_map3_data] =
{
	{3960.6386, -1944.5787, 18.4141, 358.5083, false},
	{3980.8674, -1929.7977, 18.4195, 268.1833, false},
	{4022.4838, -1930.0488, 18.4187, 269.7169, false},
	{4045.8247, -1907.4794, 18.4188, 357.8791, false},
	{4030.3295, -1887.8428, 18.4189, 91.7818, false},
	{4016.0778, -1865.5898, 18.4192, 358.0066, false},
	{4035.0522, -1852.3995, 18.4187, 274.9741, false},
	{4061.4140, -1861.6960, 18.4195, 182.9152, false},
	{4021.7668, -1860.1213, 2.3192, 358.7831, false},
	{4010.0903, -1839.4732, 2.3187, 89.5712, false},
	{4000.9663, -1855.6241, 2.3181, 179.8362, false},
	{4000.9157, -1889.3894, 2.3193, 179.4432, false},
	{4002.6320, -1934.3292, 2.3212, 270.4774, false},
	{4055.7233, -1934.5892, 2.3187, 269.3928, false},
	{4078.1877, -1958.6982, 11.8245, 181.6002, false},
	{4075.5852, -1981.8278, 18.5128, 90.4912, false},
	{3970.4362, -1887.3116, 34.5187, 269.4546, false},
	{4055.2961, -1839.7485, 2.3198, 269.8952, false},
	{3987.2399, -1877.1705, 2.3187, 29.7201, false},
	{3949.7727, -1876.2434, 2.3193, 120.9179, false}
};

new Derby_Map4Spawns[MAX_DERBY_PLAYERS][e_derby_map4_data] =
{
	{2877.0895, -3516.3852, 3.8995, 3.6558, false},
	{2876.3090, -3489.0278, 3.7439, 359.1965, false},
	{2862.3476, -3455.2319, 3.7448, 87.9087, false},
	{2822.9160, -3455.1120, 3.7435, 90.5475, false},
	{2810.1420, -3470.2883, 3.7450, 184.3539, false},
	{2811.4875, -3500.8076, 3.7440, 181.9071, false},
	{2837.4123, -3532.7248, 3.7446, 273.5574, false},
	{2914.0532, -3521.1247, 3.7449, 276.6305, false},
	{2939.2919, -3483.3242, 3.7434, 359.0291, false},
	{2810.0517, -3533.5646, 3.6433, 179.0697, false},
	{2806.7663, -3556.5236, 3.6172, 163.5164, false},
	{2823.8247, -3620.4379, 3.6288, 196.9598, false},
	{2874.1066, -3651.7585, 3.6459, 292.5925, false},
	{2897.0979, -3629.5671, 3.6586, 303.1914, false},
	{2929.5373, -3612.1718, 4.0115, 298.3864, false},
	{2931.2968, -3570.4431, 4.4742, 55.9420, false},
	{2903.1877, -3607.6376, 3.7671, 26.7458, false},
	{2922.8671, -3455.3676, 3.7374, 269.1679, false},
	{2940.0532, -3483.3977, 3.7377, 179.7474, false},
	{2906.5222, -3545.7534, 4.8501, 43.4955, false}
};

new Derby_Map5Spawns[MAX_DERBY_PLAYERS][e_derby_map5_data] =
{
	{3873.0828,-75.0219,2.3334,84.3515, false},
	{3872.4290,-55.6568,2.3383,112.0350, false},
	{3867.7134,-42.0787,2.3380,138.8138, false},
	{3853.3616,-29.6537,2.3480,154.4953, false},
	{3843.4478,-21.2739,2.3483,145.6348, false},
	{3825.0579,-17.4116,2.3482,188.3425, false},
	{3798.9045,-36.7079,2.3488,239.5291, false},
	{3782.3035,-51.6286,2.3867,257.4987, false},
	{3782.2983,-66.7195,2.3882,267.7532, false},
	{3782.0959,-91.3813,2.3687,296.6480, false},
	{3794.5774,-106.9509,2.3785,222.5016, false},
	{3811.3721,-116.6408,2.3781,249.0273, false},
	{3825.9817,-130.9541,2.3697,1.4488, false},
	{3844.4924,-124.6570,2.3294,29.5070, false},
	{3856.8303,-123.1470,2.3281,42.7229, false},
	{3875.8503,-97.7704,2.3264,61.1305, false},
	{3880.7490,-84.9508,2.3166,39.3552, false},
	{3850.8860,-74.6005,2.3381,77.7126, false},
	{3822.9360,-91.4808,2.3782,123.4223, false},
	{3812.7500,-73.1342,2.3881,0.9317, false}
};

new Derby_Map6Spawns[MAX_DERBY_PLAYERS][e_derby_map6_data] =
{
	{4442.7002000,-3101.1999500,39.5000000,50.0000000, false},
	{4471.2998000,-3075.8000500,39.5000000,357.9990000, false},
	{4413.6001000,-3072.8999000,39.5000000,357.9950000, false},
	{4427.5000000,-3025.3000500,41.3000000,299.9950000, false},
	{4431.2002000,-3015.3999000,31.3000000,357.9930000, false},
	{4468.6001000,-2994.3000500,31.3000000,91.9930000, false},
	{4474.0000000,-3032.8999000,31.3000000,91.9890000, false},
	{4472.7998000,-3069.5000000,31.3000000,47.9890000, false},
	{4403.0000000,-3038.3000500,31.3000000,277.9880000, false},
	{4400.6001000,-2993.1001000,47.8000000,267.9880000, false},
	{4400.2002000,-2950.1999500,41.1000000,267.9840000, false},
	{4474.1001000,-2952.1001000,41.1000000,177.9840000, false},
	{4467.1001000,-2991.6999500,47.6000000,269.9840000, false},
	{4492.2002000,-2993.1999500,47.6000000,181.9840000, false},
	{4514.7998000,-3007.5000000,47.6000000,181.9830000, false},
	{4514.6001000,-3049.6999500,47.6000000,87.9780000, false},
	{4446.2998000,-3047.3999000,31.3000000,53.9900000, false},
	{4491.0000000,-3037.5000000,47.8000000,87.9870000, false},
	{4441.0000000,-3005.6001000,43.1000000,37.9840000, false},
	{4474.8999000,-3000.6999500,31.3000000,181.9890000, false}
};

new Derby_Map7Spawns[MAX_DERBY_PLAYERS][e_derby_map7_data] =
{
	{370.5317, 5334.2036, 21.5007, 90.0000, false},
	{329.1581, 5268.3613, 10.0410, -45.0000, false},
	{471.6571, 5268.3271, 10.0410, 0.0000, false},
	{331.5957, 5257.8633, 10.0410, -90.0000, false},
	{459.8723, 5257.9766, 10.0410, 90.0000, false},
	{461.1842, 5268.4790, 10.0410, 45.0000, false},
	{318.8594, 5270.2227, 10.0410, 0.0000, false},
	{318.7415, 5398.4912, 10.0410, 180.0000, false},
	{328.9519, 5400.3428, 10.0410, 225.0000, false},
	{331.2196, 5410.5142, 10.0410, -90.0000, false},
	{471.6585, 5399.7070, 10.0410, 180.0000, false},
	{458.5728, 5410.6563, 10.0410, 90.0000, false},
	{461.5033, 5400.9453, 10.0410, 135.0000, false},
	{395.5331, 5361.3579, 21.5007, 359.3239, false},
	{395.5331, 5361.3579, 21.5007, 359.3239, false},
	{395.5331, 5361.3579, 21.5007, 359.3239, false},
	{395.2986, 5308.9771, 21.5007, -180.0000, false},
	{376.8490, 5352.4053, 10.1472, 45.0000, false},
	{420.8829, 5334.2803, 21.5007, -90.0000, false},
	{413.6491, 5315.7949, 10.1472, -135.0000, false}
};

new Derby_Map8Spawns[MAX_DERBY_PLAYERS][e_derby_map8_data] =
{
	{-3320.7000000,-3527.3000000,17.1000000,183.5000000, false},
	{-3299.1001000,-3502.7000000,17.1000000,273.4990000, false},
	{-3359.2000000,-3538.8000000,17.1000000,188.2490000, false},
	{-3300.7000000,-3571.1001000,17.1000000,230.2450000, false},
	{-3271.5000000,-3544.1001000,17.1000000,47.4900000, false},
	{-3239.8000000,-3541.3999000,7.5000000,2.4880000, false},
	{-3268.8999000,-3623.7000000,7.5000000,93.4830000, false},
	{-3381.3000000,-3629.5000000,7.5000000,93.4830000, false},
	{-3400.6001000,-3560.3000000,7.5000000,3.483000, false},
	{-3404.8000000,-3477.1001000,7.5000000,3.4830000, false},
	{-3351.3000000,-3466.3999000,7.5000000,273.4830000, false},
	{-3258.7000000,-3461.5000000,7.5000000,273.4830000, false},
	{-3338.3999000,-3504.5000000,7.5000000,217.4830000, false},
	{-3363.1001000,-3530.5000000,7.5000000,249.4800000, false},
	{-3346.5000000,-3592.0000000,7.5000000,322.9800000, false},
	{-3293.5000000,-3600.3999000,7.5000000,254.9760000, false},
	{-3256.0000000,-3575.0000000,7.5000000,218.9710000, false},
	{-3310.3000000,-3486.6001000,7.5000000,140.9680000, false},
	{-3282.6001000,-3566.5000000,7.5000000,53.7280000, false},
	{-3371.2000000,-3584.3000000,7.5000000,27.7230000, false}
};

new Derby_Map9Spawns[MAX_DERBY_PLAYERS][e_derby_map9_data] =
{
	{-1205.8975,-6990.2710,2.9295,0.4864, false},
	{-1246.2958,-6988.4375,2.9285,179.6206, false},
	{-1130.2155,-6993.6616,2.9475,359.8913, false},
	{-1154.9211,-6976.2568,2.9225,89.4437, false},
	{-1155.3003,-7011.4004,2.9425,269.6188, false},
	{-1226.3182,-7011.4570,2.9298,269.5659, false},
	{-1228.4279,-6976.1685,2.9297,269.4926, false},
	{-1221.0669,-6988.4077,2.9258,230.0812, false},
	{-1188.4913,-6992.8652,2.9095,298.0439, false},
	{-1155.0547,-6998.4116,2.9095,225.2211, false},
	{-1239.2794,-6934.4907,20.0015,269.6857, false},
	{-1135.5115,-6934.4302,20.0015,89.7794, false},
	{-1188.0435,-6956.0596,19.9992,0.0876, false},
	{-1196.2938,-6952.1372,19.9992,179.9747, false},
	{-1179.9395,-6951.0942,19.9993,180.1309, false},
	{-1163.9479,-7010.3101,19.9785,182.2384, false},
	{-1186.4352,-6987.5767,19.9935,90.0521, false},
	{-1211.7365,-7008.9395,19.9685,176.9368, false},
	{-1242.7676,-7053.2573,20.0035,269.5764, false},
	{-1136.3071,-7053.2534,20.0036,89.8447, false}
};

new Derby_Map10Spawns[MAX_DERBY_PLAYERS][e_derby_map10_data] =
{
	{-3270.0679,-4115.5981,70.5957,358.3180, false},
	{-3245.0649,-4070.7097,70.5883,267.6064, false},
	{-3270.6628,-4192.9058,70.6007,177.7605, false},
	{-3217.3337,-4248.9834,70.5900,267.2293, false},
	{-3147.7168,-4210.8608,70.5873,358.6406, false},
	{-3144.0237,-4103.7144,70.5903,88.7192, false},
	{-3333.0425,-4003.1411,70.5915,178.4265, false},
	{-3335.9521,-4104.9170,70.6001,177.6367, false},
	{-3362.6228,-4124.1724,70.5875,84.6086, false},
	{-3434.7969,-4129.0024,79.8132,178.2191, false},
	{-3425.9224,-4059.0178,98.4462,267.4641, false},
	{-3194.8994,-4069.5674,98.4382,178.0273, false},
	{-3381.0752,-4182.0034,70.6006,267.3749, false},
	{-3441.9966,-4314.9341,79.8166,176.4980, false},
	{-3467.5894,-4345.9531,79.7304,266.6804, false},
	{-3367.9451,-4352.3315,79.7943,266.9169, false},
	{-3324.8689,-4354.2944,79.8374,267.2542, false},
	{-3200.9712,-4360.0161,98.8503,359.4301, false},
	{-3349.7166,-4061.2856,98.4389,86.1022, false},
	{-3340.2192,-4225.6089,70.5955,179.1717, false}
};

new Derby_Map11Spawns[MAX_DERBY_PLAYERS][e_derby_map11_data] =
{
	{3694.9543, 612.8575, 23.5928, 269.4675, false}, 
	{3845.3071, 612.9099, 23.6118, 89.4352, false}, 
	{3805.0447, 691.4250, 23.6120, 87.6217, false},  
	{3769.8025, 713.6404, 23.6165, 0.1191, false},  
	{3734.4124, 728.8326, 39.9907, 180.5859, false},  
	{3735.0767, 659.8724, 39.9884, 180.4349, false},  
	{3794.6697, 644.9975, 23.5928, 357.8531, false},  
	{3756.4666, 730.8192, 23.5945, 91.8659, false},  
	{3719.3057, 731.0910, 23.5981, 90.3232, false},  
	{3688.6934, 729.3035, 23.6177, 179.3553, false},  
	{3690.2412, 691.7149, 23.6142, 273.2990, false},  
	{3850.2302, 690.7667, 7.1634, 0.2200, false},  
	{3846.1641, 768.7518, 7.1661, 91.3886, false},  
	{3810.4353, 767.1506, 7.1577, 181.8914, false},  
	{3794.7368, 663.8834, 23.6219, 180.6731, false},  
	{3756.9336, 767.4632, 23.6171, 271.0825, false},  
	{3744.3054, 750.3256, 23.5953, 178.3748, false},  
	{3729.1501, 719.3428, 23.5353, 145.5827, false},  
	{3705.8279, 716.2933, 23.5498, 213.2486, false},  
	{3850.5205, 632.7531, 23.6153, 0.0102, false}  
};

ShowPlayerDerbyTextdraws(playerid)
{
	TextDrawHideForPlayer(playerid, TeleTD);
	TextDrawShowForPlayer(playerid, DerbyTD1);
	TextDrawShowForPlayer(playerid, DerbyTD2);
}

HidePlayerDerbyTextdraws(playerid)
{
	TextDrawShowForPlayer(playerid, TeleTD);
	TextDrawHideForPlayer(playerid, DerbyTD1);
	TextDrawHideForPlayer(playerid, DerbyTD2);
}

// Derby Voting
new Iterator:DerbyVoters<MAX_PLAYERS>;
new bool:DerbyWinner[MAX_PLAYERS];
new DerbyMapVotes[11],
	CurrentDerbyMap;

// Derby Globals
new	tDerbyTimer = -1,
	tDerbyVoting = -1,
	tDerbyFallOver = -1,
	bDerbyPlayers = 0,
	bool:IsDerbyRunning,
	DerbyGameTime = DEFAULT_DERBY_TIME,
	CurrentDerbyPlayers = 0;

			
CMD:derby(playerid)
{
	if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't join the derby while in a DM!");
		return true;
	}
	if(doingStunt[playerid] != 0 && doingStunt[playerid] != 19)
	{
		Error(playerid, "You can't join derby from this area, type /leave.");
		return true;
	}

	if(doingStunt[playerid] == 19) return cmd_leave(playerid);
	if(CurrentDerbyPlayers >= MAX_DERBY_PLAYERS) return SendClientMessage(playerid, COLOR_WHITEP, ""RED_E"Server: "WHITEP_E"Sorry, the derby has reached its max players!");

	SavePlayerPosition(playerid);
	
	if(IsDerbyRunning)
	{
		SendClientMessage(playerid, COLOR_WHITEP, ""DERBY" The derby is currently in progress, you will join on the next round.");
		InfoTD_MSG(playerid, 20000, "~w~Derby in progress, wait for the next round!");
	}
	else
	{
		// Load the Derby
		ShowDerbyVotingDialog(playerid);
		SendClientMessage(playerid, COLOR_WHITEP, ""DERBY" You have joined the derby! Vote for a map below.");
		SendClientMessage(playerid, COLOR_WHITEP, ""DERBY" Type /leave to leave this minigame.");
		InfoTD_MSG(playerid, 8000, "~w~Vote for a map and wait till the derby starts!");
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
		RemovePlayerFromVehicle(playerid);
		OnPlayerExitVehicle(playerid, GetPlayerVehicleID(playerid));
	}

	ShowPlayerDerbyTextdraws(playerid);
	CurrentDerbyPlayers++;
	UpdateDMText();
	SetPlayerInterior(playerid, 0);
	SetPlayerDerbyStaticMeshes(playerid);
	GodModeLabel(playerid, false);
	HidePlayerMSGBox(playerid);
	doingStunt[playerid] = 19;
	DerbyWinner[playerid] = false;
	UpdateMinigameBox(playerid, 2, "/Derby");
	if(CurrentDerbyPlayers == 1) {
		new tmp_str[128];
		format(tmp_str, sizeof(tmp_str), ""DERBY" {FFFFFF}%s has joined the derby and is feeling lonely, join them using /derby!", pName[playerid]);
		foreach(new i : Player) {
			if(MessagesNotices[playerid]) 
				SendClientMessage(i, COLOR_GREY, tmp_str);
		}
	}
	if(GetPVarInt(playerid, "HideObjects") == 1)
	{
		DeletePVar(playerid, "HideObjects");
		Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, 1);
	}
	return 1;
}

function StartDerbyMap1()
{
	CurrentDerbyMap = 1;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Sport Car Madness) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Sport Car Madness) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap2()
{
	CurrentDerbyMap = 2;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Skyscraper) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Skyscraper) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap3()
{
	CurrentDerbyMap = 3;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Rocky Roads) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Rocky Roads) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap4()
{
	CurrentDerbyMap = 4;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Tropical Roads) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Tropical Roads) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap5()
{
	CurrentDerbyMap = 5;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Mine Madness) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Mine Madness) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap6()
{
	CurrentDerbyMap = 6;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Egypt) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Egypt) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap7()
{
	CurrentDerbyMap = 7;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Ramp Tower) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Ramp Tower) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap8()
{
	CurrentDerbyMap = 8;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Waterfall) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Waterfall Tower) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap9()
{
	CurrentDerbyMap = 9;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Sports Car Madness 2) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Sports Car Madness 2) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap10()
{
	CurrentDerbyMap = 10;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (Flatline Park) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (Flatline Park) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}
function StartDerbyMap11()
{
	CurrentDerbyMap = 11;
	ClearDerbyVotes();
	format(str, sizeof(str), ""DERBY" Derby (WaterFall 2) has started with %d players!", bDerbyPlayers);
	SendDerbyMessage(COLOR_WHITEP, str);
	format(str, sizeof(str), "2,9DERBY7,0 Derby (WaterFall 2) has started with %d players.", bDerbyPlayers);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

RemoveFromDerby(playerid)
{
	doingStunt[playerid] = 0;
	canUseKey[playerid] = true;
	CurrentDerbyPlayers--;
	UpdateDMText();
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	LoadPlayerPosition(playerid);
	GodModeLabel(playerid, true);
	ShowPlayerMSGBox(playerid);
	TextDrawHideForPlayer(playerid, derbyCT);
	HidePlayerDerbyTextdraws(playerid);
	InfoTD_MSG(playerid, 1000, " ");
	if(pSpawnVehicle[playerid] != -1)
	{
		DestroyVehicle(pSpawnVehicle[playerid]);
		pSpawnVehicle[playerid] = -1;
	}
	if(!IsDerbyRunning)
	{
		if(CurrentDerbyPlayers < 2)
		{
			CheckDerby();
		}
		return 1;
	}
	else if(IsDerbyRunning && DerbyWinner[playerid])
	{
		bDerbyPlayers--;
		DerbyWinner[playerid] = false;

		if(bDerbyPlayers == 1 || bDerbyPlayers <= 0)
		{
			CheckDerby();
		}
	}
	return 1;
}

function CheckDerby()
{
	IsDerbyRunning = false;
	DerbyGameTime = DEFAULT_DERBY_TIME;
	KillTimer(tDerbyTimer);
	KillTimer(tDerbyFallOver);
	ClearDerbySpawns();
	ClearDerbyVotes();
	ExecDerbyVotingTimer();

	if(bDerbyPlayers > 1 || bDerbyPlayers <= 0)
	{
		foreach(new ii : Player)
		{
			if(doingStunt[ii] == 19)
			{
				RemovePlayerFromVehicle(ii);
				if(pSpawnVehicle[ii] != -1)
				{
					DestroyVehicle(pSpawnVehicle[ii]);
					pSpawnVehicle[ii] = -1;
				}
				SetPlayerVirtualWorld(ii, DERBY_WORLD);
				SetPlayerDerbyStaticMeshes(ii);
				TogglePlayerControllable(ii, false);
				ShowDerbyVotingDialog(ii);
				InfoTD_MSG(ii, 8000, "~w~Vote for a map and wait till the derby starts!");
			}
		}
		if(bDerbyPlayers != 0) SendClientMessageToAll(COLOR_WHITEP, ""DERBY" No winners this round! New round starting.. join using /derby!");
	}
	else if(bDerbyPlayers == 1)
	{
		foreach(new ii : Player)
		{
			if(doingStunt[ii] == 19)
			{
				if(DerbyWinner[ii])
				{
					DerbyWinner[ii] = false;
					format(str,sizeof(str),""DERBY" %s(%i) has won the derby! {E8D04C}Prize: $8,000, 2 score and 1 cookie!", pName[ii], ii);
					SendClientMessageToAll(COLOR_WHITEP, str);
					UpdateGroupScore(pGroupID[ii], 2);
					GameTextForPlayer(ii, "~g~~h~~h~You won!", 3000, 3);
					SendClientMessage(ii, COLOR_WHITEP, ""DERBY" You have won the derby!");
					InfoTD_MSG(ii, 4500, "~g~~h~~h~You have won the derby minigame!~n~~w~+~g~$~w~8000~w~ +2 score and +1 cookie!");
					GivePlayerCash(ii, 8000);
					GivePlayerScore(ii, 2);
					GivePlayerCookie(ii, 1);
					pDerbys[ii]++;
			
					format(query, sizeof(query), "UPDATE players SET derby_wins=derby_wins+1 WHERE reg_id=%d", pRegID[ii]);
					MySQL_updateQuery(query);
					if(pGroupID[ii] != -1)
					{
						UpdateGroupScore(pGroupID[ii], 1);
					}
					if(pDerbys[ii] >= 50)
					{
						if(pAch23[ii] == 0)
						{
							pAch23[ii] = 1;
							format(query, sizeof(query), "UPDATE achievements SET a23=1 WHERE reg_id=%d", pRegID[ii]);
							MySQL_updateQuery(query);
							GivePlayerAchievement(ii, "Derby Pro", "Congrats you have won 50 derbys!~n~~y~+$100000 and 5 score!~n~~w~Type /ach to view your achievements.");
						}
					}
				}
				if(pSpawnVehicle[ii] != -1)
				{
					DestroyVehicle(pSpawnVehicle[ii]);
					pSpawnVehicle[ii] = -1;
				}
				TogglePlayerControllable(ii, false);
				SetPlayerDerbyStaticMeshes(ii);
				ShowDerbyVotingDialog(ii);
			}
		}
	}
	bDerbyPlayers = 0;
	CurrentDerbyPlayers = 0;
	foreach(new ii : Player)
	{
		if(doingStunt[ii] == 19)
		{
			CurrentDerbyPlayers++;
		}
	}
	UpdateDMText();
	return 1;
}

function DerbyFallOver()
{
	new CURRENT_FALLOVER;
	switch(CurrentDerbyMap)
	{
		case 1: CURRENT_FALLOVER = DERBY_FALLOVER_M1;
		case 2: CURRENT_FALLOVER = DERBY_FALLOVER_M2;
		case 3: CURRENT_FALLOVER = DERBY_FALLOVER_M3;
		case 4: CURRENT_FALLOVER = DERBY_FALLOVER_M4;
		case 5: CURRENT_FALLOVER = DERBY_FALLOVER_M5;
		case 6: CURRENT_FALLOVER = DERBY_FALLOVER_M6;
		case 7: CURRENT_FALLOVER = DERBY_FALLOVER_M7;
		case 8: CURRENT_FALLOVER = DERBY_FALLOVER_M8;
		case 9: CURRENT_FALLOVER = DERBY_FALLOVER_M9;
		case 10: CURRENT_FALLOVER = DERBY_FALLOVER_M10;
		case 11: CURRENT_FALLOVER = DERBY_FALLOVER_M11;
	}
	
	foreach(new ii : Player)
	{
		if(doingStunt[ii] == 19 && DerbyWinner[ii])
		{
			if(GetPlayerPos(ii, POS[0], POS[1], POS[2]))
			{
				if(POS[2] <= CURRENT_FALLOVER)
				{
					format(str, sizeof(str), ""DERBY" %s(%d) has fell off the map!", pName[ii], ii);
					SendDerbyMessage(COLOR_WHITEP, str);
					bDerbyPlayers--;
					if(pSpawnVehicle[ii] != -1)
					{
						DestroyVehicle(pSpawnVehicle[ii]);
						pSpawnVehicle[ii] = -1;
					}
					
					DerbyWinner[ii] = false;
					SetPlayerDerbyStaticMeshes(ii);
					if((bDerbyPlayers == 1 || bDerbyPlayers == 0) && (IsDerbyRunning))
					{
						CheckDerby();
					}
				}
			}
		}
	}
}

function ClearDerbyVotes()
{
	for(new i = 0; i < 11; i++)
	{
		DerbyMapVotes[i] = 0;
	}
	Iter_Clear(DerbyVoters);
	return 1;
}

function ExecDerbyVotingTimer()
{
	if(IsDerbyRunning == false)
	{
		KillTimer(tDerbyVoting);
		tDerbyVoting = SetTimer("DerbyVoting", DERBY_VOTING_TIME, false);
	}
	return 1;
}

function ExecDerbyTimer()
{
	KillTimer(tDerbyTimer);
	tDerbyTimer = SetTimer("CheckDerby", DERBY_TIME, false);
	return 1;
}

function ClearDerbySpawns()
{
	for(new i = 0; i < sizeof(Derby_Map1Spawns); i++)
	{
		Derby_Map1Spawns[i][m1sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map2Spawns); i++)
	{
		Derby_Map2Spawns[i][m2sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map3Spawns); i++)
	{
		Derby_Map3Spawns[i][m3sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map4Spawns); i++)
	{
		Derby_Map4Spawns[i][m4sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map5Spawns); i++)
	{
		Derby_Map5Spawns[i][m5sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map6Spawns); i++)
	{
		Derby_Map6Spawns[i][m6sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map7Spawns); i++)
	{
		Derby_Map7Spawns[i][m7sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map8Spawns); i++)
	{
		Derby_Map8Spawns[i][m8sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map9Spawns); i++)
	{
		Derby_Map9Spawns[i][m9sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map10Spawns); i++)
	{
		Derby_Map10Spawns[i][m10sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map11Spawns); i++)
	{
		Derby_Map11Spawns[i][m11sUsed] = false;
	}
	return 1;
}

function SetPlayerDerbyStaticMeshes(playerid)
{
	SetPlayerVirtualWorld(playerid, DERBY_WORLD);
	SetPlayerHealth(playerid, 1000);
	DeletePVar(playerid, "UsingAnim");
	ClearAnimations(playerid);
	switch(CurrentDerbyMap)
	{
		case 1:
		{
			SetPlayerPos(playerid, DERBY_POS_M1);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M1);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M1);
		}
		case 2:
		{
			SetPlayerPos(playerid, DERBY_POS_M2);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M2);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M2);
		}
		case 3:
		{
			SetPlayerPos(playerid, DERBY_POS_M3);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M3);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M3);
		}
		case 4:
		{
			SetPlayerPos(playerid, DERBY_POS_M4);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M4);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M4);
		}
		case 5:
		{
			SetPlayerPos(playerid, DERBY_POS_M5);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M5);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M5);
		}
		case 6:
		{
			SetPlayerPos(playerid, DERBY_POS_M6);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M6);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M6);
		}
		case 7:
		{
			SetPlayerPos(playerid, DERBY_POS_M7);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M7);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M7);
		}
		case 8:
		{
			SetPlayerPos(playerid, DERBY_POS_M8);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M8);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M8);
		}
		case 9:
		{
			SetPlayerPos(playerid, DERBY_POS_M9);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M9);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M9);
		}
		case 10:
		{
			SetPlayerPos(playerid, DERBY_POS_M10);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M10);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M10);
		}
		case 11:
		{
			SetPlayerPos(playerid, DERBY_POS_M11);
			SetPlayerCameraPos(playerid, DERBY_CAMPOS_M11);
			SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M11);
		}

	}
	TogglePlayerControllable(playerid, false);
}

function DerbyVoting()
{
	if(CurrentDerbyPlayers < 2)
	{
		SendDerbyMessage(COLOR_WHITEP, ""DERBY" There needs to be at least 2 players to start the derby!");
		SendDerbyMessage(COLOR_WHITEP, ""DERBY" Tell players to join /derby, or type /leave to exit.");
		ClearDerbyVotes();
		ExecDerbyVotingTimer();
		foreach(new ii : Player)
		{
			if(doingStunt[ii] == 19) ShowDerbyVotingDialog(ii);
		}
		return 1;
	}

	new iTotalVotes;
	iTotalVotes = DerbyMapVotes[0] + DerbyMapVotes[1] + DerbyMapVotes[2] + DerbyMapVotes[3] + DerbyMapVotes[4] + DerbyMapVotes[5] + DerbyMapVotes[6] + DerbyMapVotes[7] + DerbyMapVotes[8] + DerbyMapVotes[9] + DerbyMapVotes[10];
	if(iTotalVotes == 0)
	{
		ExecDerbyVotingTimer();
		ClearDerbyVotes();
		SendDerbyMessage(COLOR_WHITEP, ""DERBY" There were no votes!");
		foreach(new ii : Player)
		{
			if(doingStunt[ii] == 19) ShowDerbyVotingDialog(ii);
		}
		return 1;
	}

	new highestmapvotes = -1, draw = 0;
	for(new i = 0; i < sizeof(DerbyMapVotes); i++)
	{
		if(DerbyMapVotes[i] > highestmapvotes && draw == 0)
		{
			highestmapvotes = DerbyMapVotes[i];
		}
		else if(DerbyMapVotes[i] > highestmapvotes && draw != 0)
		{
			highestmapvotes = DerbyMapVotes[i];
			draw = 0;
		}
		else if(DerbyMapVotes[i] == highestmapvotes)
		{
			draw++;
		}
	}

	if(draw >= 1)
	{
		SendDerbyMessage(COLOR_WHITEP, ""DERBY" Voting wasn't clear.. please vote again!");
		ExecDerbyVotingTimer();
		ClearDerbyVotes();
		foreach(new ii : Player)
		{
			if(doingStunt[ii] == 19) ShowDerbyVotingDialog(ii);
		}
		return 1;
	}

	if(derbyCountdown != -1)
	{
		KillTimer(derbyCountdown);
		derbyCountdown = -1;
	}
	if(highestmapvotes == DerbyMapVotes[0])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Sport Car Madness won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[1])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Skyscraper won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD2", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[2])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Rocky Roads won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD3", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[3])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Tropical Roads won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD4", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[4])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Mine Madness won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD5", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[5])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Egypt won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD6", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[6])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Ramp Tower won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD7", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[7])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Waterfall won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD8", 1000, true);
	}
    else if(highestmapvotes == DerbyMapVotes[8])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Sports Car Madness 2 won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD9", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[9])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"Flatline Park won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD10", 1000, true);
	}
	else if(highestmapvotes == DerbyMapVotes[10])
	{
		format(str, sizeof(str), ""RED_E"[VOTE] "WHITEP_E"WaterFall 2 won with %d votes. Derby starting in 5 seconds!", highestmapvotes);
		SendDerbyMessage(COLOR_WHITEP, str);
		derbycd = 5;
		derbyCountdown = SetTimer("derbyCD11", 1000, true);
	}
	return 1;
}
