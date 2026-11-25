/*
		Server: Hunger Games
		Author: Private200
*/

#define MAX_LOOT 5000

new Iterator:HGLoot<MAX_LOOT>;

enum lootinfo {
    loot_id,
	Float:loot_Location[3],
	loot_Model
}
new LootInfo[MAX_LOOT][lootinfo];

#define MAX_INV_ITEMS 6

new Iterator:InvItems[MAX_PLAYERS]<MAX_INV_ITEMS>;

enum invinfo {
	inv_id,
	quantity,
	iModel
}
new InventoryInfo[MAX_PLAYERS][MAX_INV_ITEMS][invinfo];

enum iteminfo {
	index_id,
	itemName[36],
	itemModel,
	Float:RotX,
	Float:RotY,
	Float:RotZ
}
new ItemData[][iteminfo] =
{
	{0, "Bandage", 11748, 0.0, 0.0, 0.0},
	{1, "M4", 2035, 0.0, 0.0, 0.0},
	{2, "Sniper", 2036, 0.0, 0.0, 0.0},
	{3, "Medkit", 11738, 0.0, 0.0, 0.0},
	{4, "Armor", 1242, 90.0, 0.0, 0.0},
	{5, "Pizza", 2814, 0.0, 0.0, 0.0},
	{6, "Colt", 346, 90.0, 0.0, 0.0},
	{7, "Shotgun", 349, 90.0, 0.0, 0.0}
};

new invMenuData[MAX_PLAYERS][MAX_INV_ITEMS];

//======================================//

enum spawndata {
	Float:SpawnX,
	Float:SpawnY,
	Float:SpawnZ
}

new Map1PlayerSpawn[][spawndata] =
{
    {254.988418, -3737.504638, 5.906355},
	{258.292602, -3737.409667, 5.941791},
	{261.289703, -3735.249023, 5.896087},
	{262.591918, -3738.346435, 6.274275},
	{262.687469, -3741.677978, 6.742187},
	{260.010375, -3740.886718, 6.742187},
	{256.902252, -3742.097900, 6.742187},
	{259.921936, -3743.435546, 6.742187},
	{243.924163, -3703.468261, 8.443162},
	{246.979965, -3702.164794, 8.437500},
	{249.728500, -3701.053466, 8.437500},
	{251.854461, -3703.974121, 8.443162},
	{244.281723, -3706.614257, 8.443162},
	{247.938308, -3705.504150, 8.443162}
};

new Map1LootSpawn[][spawndata] =
{
/*    {227.743026, -3634.387207, 1.073141},
	{221.678298, -3627.955810, 1.388967},
	{217.008560, -3634.894042, 0.789808},
	{228.183135, -3627.248779, 1.102484},
	{229.164031, -3632.474121, 0.866033},
	{222.638229, -3637.121826, 1.646185},
	{220.043365, -3687.313476, 1.360906},
	{227.215408, -3694.366943, 0.928221},
	{219.598327, -3698.871582, 1.428289},
	{272.438629, -3807.614746, 0.957014},
	{278.738250, -3812.117919, 1.546079},
	{316.567413, -3879.411621, 1.571554},
	{431.953918, -3831.025146, 1.120931},
	{437.618255, -3825.451904, 1.610685},
	{536.266418, -3804.222412, 0.775488},
	{546.885009, -3803.736328, 1.128446},
	{537.370849, -3815.899902, 0.478895},
	{554.812561, -3590.120605, 1.114630},
	{547.870361, -3580.036132, 1.159788},
	{397.597869, -3629.515625, 10.649234},
	{397.889923, -3634.403808, 10.649234},
	{394.625610, -3640.051269, 8.056600},
	{404.975311, -3635.231201, 7.388098},
	{453.768585, -3643.441650, 6.404928},
	{458.159851, -3638.793457, 6.994429},
	{455.863952, -3633.641113, 5.875891},
	{396.886810, -3633.301269, 10.649234},
	{402.935455, -3631.454833, 7.783545},
	{397.875885, -3640.298095, 8.496740},
	{401.870513, -3641.326171, 7.774595},
	{403.246551, -3716.390136, 7.454042},
	{415.166473, -3723.075927, 6.417398},
	{410.816497, -3713.353271, 7.051157},
	{403.446441, -3714.484130, 7.423388},
	{344.916717, -3722.421142, 6.752794},
	{339.034576, -3714.962158, 7.594828},
	{333.633972, -3720.889892, 7.292292},
	{438.916564, -3673.631347, 5.973867},
	{446.545806, -3678.626953, 6.797300},
	{449.335083, -3674.806640, 8.393960},
	{448.001708, -3671.667236, 8.977722},
	{456.838592, -3673.168701, 6.081305},
	{471.161743, -3672.374023, 0.483061},
	{475.718505, -3667.678222, 1.151815},
	{482.616485, -3671.871582, 1.423864},
	{480.554107, -3683.689697, 1.106809},
	{254.672515, -3720.845703, 4.960937},
	{252.342620, -3721.349853, 4.960937},
	{252.344345, -3719.139160, 4.960937},
	{251.142410, -3723.888183, 4.960937},
	{254.016159, -3725.009521, 4.960937},
	{257.749053, -3724.223388, 4.960937},
	{258.765869, -3726.962890, 4.960937},
	{256.440704, -3727.470703, 4.960937},
	{253.829284, -3728.113769, 4.960937},
	{251.131378, -3727.072021, 4.960937},
	{253.179214, -3730.785400, 4.960937},
	{256.570831, -3730.621826, 4.982780},
	{259.923431, -3731.385986, 5.748252},
	{256.380432, -3733.759033, 5.787847},
	{253.546478, -3732.434326, 5.604526},
	{253.382034, -3712.879150, 5.992187},
	{249.930038, -3711.085449, 5.997252},
	{249.919708, -3707.892333, 5.997252},
	{247.880783, -3714.014160, 5.997252},
	{249.347229, -3719.019042, 5.923027},
	{386.1616, -3765.0461, 2.3150}, 
	{371.9522, -3728.2249, 2.351}, 
	{380.9519, -3721.8430, 2.7072}, 
	{377.0089, -3719.3391, 2.7142}, 
	{372.0375, -3719.6956, 2.7142}, 
	{369.9525, -3715.6550, 2.7142}, 
	{372.2749, -3708.2754, 2.7142}, 
	{375.8297, -3705.0208, 2.7142}, 
	{375.4810, -3700.4136, 2.7142}, 
	{366.5472, -3683.6187, 2.7550}, 
	{358.3878, -3688.7009, 2.7443}, 
	{347.7781, -3681.9072, 2.7443}, 
	{336.0223, -3690.8811, 2.7291}, 
	{321.6624, -3685.6479, 2.7550}, 
	{312.4903, -3698.3335, 2.7550}, 
	{298.8354, -3688.6968, 2.7550}, 
	{299.3337, -3658.3765, 2.7550}, 
	{318.4700, -3642.5261, 2.7550}, 
	{326.8033, -3629.7581, 2.7550}, 
	{357.8907, -3593.1965, 3.225}, 
	{234.2972, -3577.6182, 2.0711}, 
	{228.4882, -3574.1758, 3.3636}, 
	{253.8260, -3588.9629, 5.0180}, 
	{244.2617, -3583.0557, 3.0250}, 
	{496.9651, -3757.1045, 3.6098}, 
	{539.9117, -3684.4380, 2.2057}, 
	{542.6047, -3674.2119, 2.4773}, 
	{533.7906, -3675.3083, 1.3678}, 
	{490.1628, -3624.1804, 2.1226}, 
	{481.7349, -3610.7058, 3.3460}, 
	{471.8993, -3608.3616, 2.9380}, 
	{451.6005, -3601.7402, 2.7550}, 
	{445.6433, -3589.1072, 2.4787}, 
	{458.8460, -3588.5325, 3.3724}, 
	{434.3551, -3580.9915, 3.212}, 
	{420.8471, -3587.7939, 2.7550}, 
	{387.1631, -3632.9841, 7.9153}, 
	{392.8398, -3647.8054, 7.4705}, 
	{373.6484, -3587.0239, 2.2778}, 
	{354.8531, -3612.9670, 2.7550}, 
	{337.9671, -3598.1772, 3.0002}, 
	{269.4014, -3605.9495, 1.8229}, 
	{280.6978, -3596.4231, 1.7537}, 
	{275.7326, -3593.6650, 2.5988}, 
	{268.6595, -3597.8408, 9.8629}, 
	{260.8314, -3589.8159, 7.1231}, 
	{248.7357, -3589.0488, 4.2366}, 
	{243.6224, -3578.0103, 3.5348}, 
	{229.6969, -3570.9160, 3.2608}, 
	{225.8687, -3576.3877, 3.1644}, 
	{281.8509, -3681.3774, 3.1207}, 
	{283.2872, -3691.8440, 2.5787}, 
	{247.4164, -3703.4878, 9.2932}, 
	{260.9391, -3747.0098, 7.5922}, 
	{278.0595, -3818.2878, 2.0203}, 
	{313.9225, -3886.4812, 2.1219}, 
	{377.2139, -3833.9333, 6.8422}, 
	{384.3545, -3827.5820, 6.8422}, 
	{383.7180, -3823.4060, 9.2932}, 
	{390.3986, -3826.1021, 9.2875}, 
	{366.5594, -3842.0767, 5.8109}, 
	{365.5992, -3849.2141, 6.6674}, 
	{354.4518, -3853.3567, 7.5922}, 
	{367.8470, -3836.2637, 5.8158}, 
	{435.7233, -3836.9431, 2.6003}, 
	{502.1825, -3884.4924, 2.3770}, 
	{503.3336, -3878.7158, 2.4732}, 
	{506.9113, -3879.4321, 2.1521}, 
	{493.3663, -3874.0276, 1.3341}, 
	{588.3975, -3744.2810, 6.3693}, 
	{589.8702, -3750.3794, 8.6363}, 
	{584.2178, -3748.7009, 5.1394}, 
	{570.2040, -3754.3591, 5.3621}, 
	{563.4735, -3749.3945, 3.2280}, 
	{556.6292, -3749.0273, 3.6511}, 
	{548.3616, -3755.0188, 6.3752}, 
	{545.0010, -3679.6406, 2.278}, 
	{541.2827, -3674.1030, 2.2814}, 
	{534.7454, -3679.9216, 1.3904}, 
	{549.8577, -3585.2151, 2.3545}, 
	{458.6276, -3525.9612, 2.4244}, 
	{464.8297, -3520.7310, 1.8552}, 
	{457.2269, -3515.8652, 2.0952}, 
	{374.8782, -3446.8147, 2.5172}, 
	{379.3327, -3440.4309, 2.0554}, 
	{372.2932, -3440.5349, 2.0602}, 
	{383.9768, -3436.2678, 1.3463}, 
	{413.4508, -3429.1934, 7.5922}, 
	{418.2528, -3434.8845, 7.5922}, 
	{422.3164, -3441.1982, 6.6227}, 
	{428.8043, -3442.0291, 5.8109}, 
	{424.9827, -3447.6309, 5.8109}, 
	{432.9299, -3450.1167, 5.8109}, 
	{437.3069, -3453.1245, 6.8472}, 
	{439.4084, -3459.6658, 6.8422}, 
	{443.2608, -3465.4917, 9.2875}, 
	{341.5589, -3467.3193, 9.2875}, 
	{337.0734, -3471.8276, 9.2932}, 
	{347.3670, -3478.6721, 6.8473}, 
	{356.8459, -3476.0654, 5.8109}, 
	{352.2761, -3479.2695, 5.8109}, 
	{360.8287, -3485.1008, 5.8109}, 
	{366.3855, -3488.5581, 6.6956}, 
	{374.3614, -3489.0859, 7.5922}, 
	{391.0918, -3544.8203, 2.4576}, 
	{373.1731, -3580.8274, 8.8790}, 
	{366.6085, -3589.3389, 9.3928}, 
	{346.0367, -3594.6323, 15.8044}, 
	{348.7345, -3589.3755, 13.2893}, 
	{344.4142, -3610.6956, 2.7550}, 
	{335.9490, -3623.8987, 2.7499}, 
	{326.0439, -3645.0835, 2.7550}, 
	{309.5011, -3647.5977, 2.7550}, 
	{305.9670, -3663.8926, 2.7550}, 
	{291.0532, -3681.6160, 2.5485}, 
	{291.7394, -3700.6108, 2.7550}, 
	{305.4611, -3713.0947, 2.7550}, 
	{302.3256, -3732.0894, 2.7550}, 
	{311.6432, -3739.8577, 2.7550}, 
	{345.0374, -3754.0388, 2.7550}, 
	{332.6487, -3753.8916, 2.7550}, 
	{346.1090, -3765.2363, 2.7550}, 
	{362.2051, -3767.6299, 2.7550}, 
	{370.1964, -3762.9316, 2.7550}, 
	{381.4496, -3761.3372, 2.7550}, 
	{377.7806, -3750.1543, 2.7550}, 
	{383.7393, -3742.3123, 2.7550}, 
	{381.1212, -3727.7217, 2.6586}, 
	{372.5022, -3716.4294, 2.7142}, 
	{373.4955, -3702.9880, 2.7142}, 
	{363.6749, -3695.9216, 2.7142}, 
	{357.4693, -3692.4341, 2.7443}, 
	{348.3729, -3682.8628, 2.7443}, 
	{335.6893, -3680.4458, 2.6398}, 
	{339.6760, -3676.0649, 6.9137}, 
	{322.4680, -3677.5537, 5.3090}, 
	{333.1093, -3656.6963, 6.2869}, 
	{318.8489, -3660.1602, 6.7635}, 
	{318.6707, -3656.8125, 5.9914}, 
	{314.5343, -3738.4263, 2.7550}, 
	{345.7751, -3764.3057, 2.7550}, 
	{362.9409, -3759.6167, 2.7550}, 
	{407.0284, -3764.1628, 2.7550}, 
	{420.0728, -3751.0686, 2.7550}, 
	{438.5305, -3750.6433, 2.7550}, 
	{487.9265, -3733.5979, 2.7550}, 
	{497.7646, -3731.8760, 2.7550}, 
	{507.8864, -3696.2485, 2.7550}, 
	{498.5094, -3685.1299, 2.7550}, 
	{501.7493, -3671.8987, 2.7550}, 
	{495.0392, -3642.5427, 2.2639}, 
	{478.3953, -3631.9167, 2.7550}, 
	{467.4694, -3615.5015, 2.7550}, 
	{466.1991, -3602.5425, 2.755}, 
	{445.9732, -3597.1367, 2.7550}, 
	{429.5627, -3587.2581, 2.7550}, 
	{397.3990, -3590.2351, 2.7550}, 
	{389.4677, -3600.8782, 2.7550}, 
	{371.5013, -3648.8606, 2.6247}, 
	{383.0798, -3664.1606, 2.7550}, 
	{379.7046, -3678.7439, 2.7550}, 
	{388.2493, -3684.0017, 2.7550}, 
	{371.6196, -3684.0852, 2.7550}, 
	{371.6196, -3684.0852, 2.7550}, 
	{367.1739, -3707.0168, 2.7142}, 
	{378.0290, -3711.7229, 2.7142}, 
	{377.3118, -3734.8257, 2.7550}, 
	{376.6765, -3745.8074, 2.7550}, 
	{388.2703, -3752.9592, 2.7550}, 
	{360.6793, -3758.1206, 2.7550}, 
	{346.8628, -3764.1328, 2.7386}, 
	{319.6788, -3778.2407, 4.5774}, 
	{349.5184, -3760.5183, 2.7550}, 
	{358.9454, -3683.3403, 2.7443}, 
	{350.0300, -3688.6062, 2.7443}, 
	{335.9604, -3686.7915, 2.7012}, 
	{316.1605, -3695.5166, 2.7550}, 
	{301.6490, -3692.1541, 2.7550}, 
	{331.9665, -3659.4761, 7.0485}, 
	{330.2824, -3674.8887, 8.8091}, 
	{341.0899, -3675.0356, 7.4569}, 
	{344.1033, -3660.5442, 8.0270}, 
	{357.8704, -3652.8596, 3.6145}, 
	{357.7839, -3656.0583, 2.6040}, 
	{367.9756, -3644.2451, 2.7550}, 
	{370.8218, -3629.7754, 25.7014}, 
	{379.6492, -3634.7366, 15.7416}, 
	{381.3032, -3617.4846, 6.531}, 
	{397.8864, -3618.5571, 3.6948}, 
	{398.7184, -3657.1536, 24.3828}, 
	{401.9142, -3648.8157, 15.6677}, 
	{355.6950, -3680.6687, 1.6778}, 
	{336.8860, -3738.0034, 20.0793}, 
	{337.7620, -3730.3091, 12.7696}, 
	{331.7997, -3715.1172, 13.4562}, 
	{324.3028, -3710.9707, 21.5291}, 
	{349.4001, -3710.4851, 16.6052}, 
	{353.2748, -3725.4429, 15.6091}, 
	{352.0322, -3733.8379, 5.4049}, 
	{411.6288, -3757.7468, 2.7550}, 
	{453.9529, -3747.9031, 2.7550}, 
	{496.0210, -3738.3245, 2.7550}, 
	{496.4474, -3721.2048, 2.393}, 
	{481.6312, -3677.6877, 2.3564}, 
	{493.1933, -3641.7744, 2.4617}, 
	{478.0558, -3626.6328, 2.7550}, 
	{469.0331, -3610.7222, 2.7550}, 
	{444.8567, -3596.0459, 2.7550}, 
	{443.6067, -3679.8218, 8.9002}, 
	{443.5982, -3673.4502, 8.8157}, 
	{457.4128, -3684.6157, 6.5732}, 
	{480.7626, -3679.4480, 2.4755}, 
	{507.2021, -3684.6057, 2.7550}, 
	{502.2721, -3695.7393, 2.7550}, 
	{509.3053, -3715.9810, 2.6879}, 
	{477.9951, -3742.8110, 2.7550}, 
	{336.2209, -3626.1711, 2.7550}, 
	{455.0219, -3601.3938, 2.7550}, 
	{475.5385, -3614.0396, 2.7550}, 
	{480.9629, -3636.4441, 2.7550}, 
	{500.7833, -3652.2119, 2.7550}, 
	{498.6227, -3683.9631, 2.7550}, 
	{459.0959, -3715.0117, 2.7550}, 
	{433.2215, -3686.4688, 2.7550}, 
	{429.9857, -3690.4253, 2.7550}, 
	{425.7397, -3679.3054, 2.7550}, 
	{387.7811, -3692.4795, 2.7550}, 
	{371.1341, -3682.9231, 2.7550}, 
	{332.5193, -3693.0872, 2.7550}, 
	{333.7249, -3671.7385, 7.3962}, 
	{343.7843, -3677.8562, 5.2119}, 
	{356.5546, -3651.5496, 3.1776}, 
	{453.3550, -3580.4172, 14.4109}, 
	{458.2354, -3582.1428, 12.6377}, 
	{460.8819, -3593.3574, 10.7260}, 
	{465.6680, -3597.3203, 9.1232}, 
	{475.1904, -3599.8406, 15.5267}, 
	{473.8530, -3606.4900, 7.4266}, 
	{496.4486, -3624.7297, 9.5629}, 
	{498.7713, -3629.1255, 8.3415}, 
	{501.8078, -3621.7236, 10.2957}, 
	{485.2376, -3763.0757, 13.2883}, 
	{491.3748, -3757.9077, 15.8135}, 
	{474.3969, -3765.6262, 14.5620}, 
	{472.0433, -3771.8484, 13.1918}, 
	{458.7031, -3761.8137, 1.0717}, 
	{460.7053, -3772.3757, 9.9519}, 
	{453.6121, -3774.3206, 7.2728}, 
	{405.1352, -3784.1062, 14.2179}, 
	{396.5193, -3780.8547, 12.3266}*/
	{500.677001, -3699.090332, 1.905000},
	{485.539672, -3711.242675, 1.905000},
	{549.135375, -3755.062500, 5.580741},
	{557.507629, -3755.175292, 5.061301},
	{575.031799, -3746.991699, 3.207796},
	{579.655639, -3751.970458, 5.238943},
	{429.769866, -3689.917724, 1.905000},
	{588.359130, -3746.598632, 6.352481},
	{424.999145, -3659.342529, 1.905000},
	{424.060424, -3606.918945, 1.905000},
	{543.942138, -3688.175537, 0.887335},
	{407.814666, -3687.060791, 1.894250},
	{535.247436, -3677.461669, 0.595381},
	{547.424560, -3673.717529, 1.109709},
	{374.286529, -3687.373046, 1.905000},
	{625.811950, -3729.986083, 0.590856},
	{638.229553, -3729.198974, 1.296125},
	{635.889465, -3741.849121, 1.491484},
	{505.747558, -3726.158935, 1.186342},
	{698.866394, -3667.443603, 1.468183},
	{477.696746, -3743.127197, 1.905000},
	{350.096405, -3762.767822, 1.905000},
	{705.795471, -3653.701171, 1.087782},
	{693.430725, -3655.620361, 0.723875},
	{477.174072, -3760.546142, 2.489268},
	{442.895568, -3745.978515, 1.905000},
	{554.207702, -3589.395019, 1.246343},
	{311.497100, -3732.043701, 1.905000},
	{542.877685, -3586.708496, 0.495642},
	{549.099365, -3577.696289, 1.380178},
	{411.100097, -3764.366943, 1.905000},
	{464.411224, -3522.848144, 1.045088},
	{453.449737, -3525.386474, 0.805525},
	{293.243927, -3670.780761, 1.905000},
	{460.679534, -3513.412109, 1.723348},
	{369.379302, -3779.014892, 8.975679},
	{396.959320, -3641.344970, 8.415777},
	{405.569885, -3631.333007, 7.350500},
	{383.517852, -3783.999755, 13.418158},
	{390.670562, -3629.911865, 7.559835},
	{358.766021, -3653.180908, 2.576811},
	{343.025726, -3661.419433, 7.273518},
	{322.152557, -3660.510009, 5.282196},
	{324.587341, -3670.646728, 4.460094},
	{329.877532, -3674.720458, 7.916866},
	{505.319274, -3667.506347, 1.905000},
	{332.543182, -3714.892822, 6.916826},
	{344.498016, -3722.466552, 6.800768},
	{485.180450, -3640.679931, 1.905000},
	{344.860260, -3715.762695, 6.728357},
	{352.693328, -3718.995361, 5.798876},
	{352.376770, -3732.774169, 4.568880},
	{481.605285, -3610.959960, 2.445038},
	{349.875732, -3732.312011, 3.252783},
	{334.572662, -3733.015869, 1.695249},
	{454.200775, -3604.069335, 1.905000},
	{349.971832, -3762.867919, 1.905000},
	{448.114105, -3586.416015, 1.945134},
	{425.539123, -3594.624755, 1.905000},
	{254.001571, -3720.438232, 4.960937},
	{256.212097, -3723.392578, 4.960937},
	{251.422714, -3724.318603, 4.960937},
	{249.023132, -3722.135253, 4.960937},
	{387.532531, -3593.629150, 1.905000},
	{252.120849, -3726.301513, 4.960937},
	{255.613388, -3729.883300, 4.960937},
	{258.835632, -3728.220458, 4.960937},
	{260.310791, -3732.028076, 5.772289},
	{256.055419, -3734.003906, 5.792340},
	{253.095718, -3732.636718, 5.636201},
	{252.609893, -3723.722656, 4.960937},
	{249.681350, -3711.141601, 5.997252},
	{253.776412, -3712.918457, 5.997252},
	{248.986450, -3716.484863, 5.992187},
	{252.784805, -3716.169189, 5.992187},
	{259.918579, -3735.327880, 5.882859},
	{256.834564, -3737.159912, 5.915202},
	{268.518829, -3768.748291, 9.217666},
	{283.261657, -3806.395996, 0.881552},
	{274.909973, -3813.821777, 1.399145},
	{272.136383, -3802.666259, 1.047865},
	{278.604125, -3801.120117, 1.293508},
	{309.852966, -3879.787353, 0.749182},
	{321.254852, -3878.617431, 1.198782},
	{316.020904, -3890.914306, 1.636747},
	{443.505859, -3678.982666, 8.041942},
	{448.886199, -3678.467285, 8.804718},
	{448.785491, -3673.977783, 8.640292},
	{455.232696, -3672.594238, 6.354193},
	{446.911682, -3688.515380, 6.649076},
	{453.413085, -3690.826904, 5.409323},
	{435.645172, -3667.364257, 3.089228},
	{456.873962, -3655.633789, 5.789564},
	{457.555236, -3646.619140, 7.000868},
	{458.338012, -3636.328369, 7.007925},
	{446.491149, -3636.944335, 5.701467},
	{461.715026, -3653.757324, 5.732519},
	{467.815521, -3651.002197, 5.559118},
	{471.955230, -3667.010986, 0.713316},
	{481.936706, -3669.496582, 1.568724},
	{483.381195, -3679.244628, 1.179266},
	{474.039031, -3681.752685, 0.773268}

};
//======================================//

new mode_Started = 0,
	mode_Players = 0,
	mode_Time = 60,
	current_Map = 1,
	mode_Time_Passed = 0,
	mode_Alive = 0;

ResetModeSettings() 
{
	mode_Started = 0;
	current_Map = 1;
	mode_Alive = 0;
	mode_Time = -20;
	mode_Time_Passed = 0;
	DestroyLoot();
	//mode_Time = 60;
	
	/* CHANGE MAP EVERY ROUND WITH THIS FUNCTION */
	
	/*
	if(current_Map < highets map number) {
	    current_Map = 1;
	}
	else current_Map++;
	*/

	if(mode_Players == 0) SetTimer("StartRound", 60*1000, false);
	else StartRound();
	return 1;
}

function StartRound()
{
	new string[128];
	mode_Time = 60;
	format(string, sizeof string, "{FF0000}[HUNGER GAMES] A new round starts in 60 seconds! Join now! - /hungergames");
	SendClientMessageToAll(-1, string);
	SpawnLoot(1);
	return 1;
}

//======================================//

stock ResetPlayerInventoryX(playerid) {
	foreach(new i : InvItems[playerid]) {
		InventoryInfo[playerid][i][quantity] = 0;
		InventoryInfo[playerid][i][iModel] = -1;
	}
	Iter_Clear(InvItems[playerid]);
	return 1;
}

stock ShowInventory(playerid) {
    if(GetPVarInt(playerid, "ParticipatingHG") == 1) {
    
		new res = 0, invString[1024];
		strcat(invString, "Quantity\tItem name\n", sizeof invString);
		
		foreach(new i : InvItems[playerid]) {
			new tempString[128];
		    invMenuData[playerid][res] = InventoryInfo[playerid][i][inv_id];
		    format(tempString, sizeof tempString, "%i\t%s\n", InventoryInfo[playerid][i][quantity], ItemNameFromModel(InventoryInfo[playerid][i][iModel]));
			strcat(invString, tempString, sizeof invString);
		    res++;
		}
		
		if(res>0) ShowPlayerDialog(playerid, 9674, DIALOG_STYLE_TABLIST_HEADERS, "Inventory", invString, "Use", "Close");
	}
	return 1;
}

stock RemoveInventoryItem(playerid, itemid)
{
	foreach(new i : InvItems[playerid]) {
	    if(InventoryInfo[playerid][i][inv_id] == itemid) {
	        if(InventoryInfo[playerid][i][quantity] >= 1) {
	            InventoryInfo[playerid][i][quantity] -= 1;
			}
			if(InventoryInfo[playerid][i][quantity] == 0) {
			    Iter_Remove(InvItems[playerid], i);
			}
			break;
		}
	}
	return 1;
}

stock SpawnLoot(map)
{
	new lootSp = 0;
	if(map == 1)
	{
	    for(new i = 0; i < sizeof Map1LootSpawn; i++)
		{
 /*       	new chance = random(3);
	        if(chance == 1 || chance == 2)
			{*/
				new itemid = random(7);
				new freeID = Iter_Free(HGLoot);

				LootInfo[freeID][loot_Location][0] = Map1LootSpawn[i][SpawnX];
				LootInfo[freeID][loot_Location][1] = Map1LootSpawn[i][SpawnY];
				LootInfo[freeID][loot_Location][2] = Map1LootSpawn[i][SpawnZ];
				LootInfo[freeID][loot_Model] = ItemData[itemid][itemModel];

				LootInfo[freeID][loot_id] = CreateObject(LootInfo[freeID][loot_Model],
				LootInfo[freeID][loot_Location][0],
				LootInfo[freeID][loot_Location][1],
				LootInfo[freeID][loot_Location][2],
				ItemData[itemid][RotX],
				ItemData[itemid][RotY],
				ItemData[itemid][RotZ]);

				Iter_Add(HGLoot, freeID);
				lootSp++;
			//}
		}
	}
	printf("%i loot spawned for map %i", lootSp, map);
	return 1;
}

stock DestroyLoot()
{
	foreach(new i : HGLoot) {
	    DestroyObject(LootInfo[i][loot_id]);
	}
	Iter_Clear(HGLoot);
	print("Loot destroyed");
	return 1;
}


stock GivePlayerModelItem(playerid, tempModel, item_quantity) {
    new freeID = Iter_Free(InvItems[playerid]);

	if(freeID==-1) return SendClientMessage(playerid, -1, "{FF0000}You cannot carry anymore items.");

	new itemCount = GetInventoryItems(playerid);
	if(itemCount <= 6) {
		new haveItem = 0;
		foreach(new i : InvItems[playerid]) {
		    if(InventoryInfo[playerid][i][iModel] == tempModel) {
		        InventoryInfo[playerid][i][quantity] += item_quantity;
		        haveItem = 1;
			}
		}

		if(haveItem == 0) {
		    Iter_Add(InvItems[playerid], freeID);
		    InventoryInfo[playerid][freeID][inv_id] = freeID;
		    InventoryInfo[playerid][freeID][quantity] = item_quantity;
		    InventoryInfo[playerid][freeID][iModel] = tempModel;
	    }
    }
    else SendClientMessage(playerid, -1, "{FF0000}Your inventory is already full.");
	return 1;
}

stock GivePlayerItem(playerid, item_index, item_quantity) {
    new freeID = Iter_Free(InvItems[playerid]), tempModel;

	for(new i = 0; i < sizeof(ItemData); i++) {
	    if(ItemData[i][index_id] == item_index) {
	        tempModel = ItemData[i][itemModel];
	        break;
		}
	}

	new haveItem = 0;
	foreach(new i : InvItems[playerid]) {
	    if(InventoryInfo[playerid][i][iModel] == tempModel) {
	        InventoryInfo[playerid][i][quantity] += item_quantity;
	        haveItem = 1;
		}
	}

	if(haveItem == 0) {
	    Iter_Add(InvItems[playerid], freeID);
	    InventoryInfo[playerid][freeID][inv_id] = freeID;
	    InventoryInfo[playerid][freeID][quantity] = item_quantity;
	    InventoryInfo[playerid][freeID][iModel] = tempModel;
    }
	return 1;
}

stock ItemNameFromModel(modelid) {
	new xtempName[36];
	for(new i = 0; i < sizeof ItemData; i++) {
	    if(ItemData[i][itemModel] == modelid) {
	        format(xtempName, sizeof xtempName, ItemData[i][itemName]);
	        break;
		}
	}
	return xtempName;
}

stock ItemIDFromPlayerInventory(playerid, xid) {
	new modelid;
	foreach(new i : InvItems[playerid]) {
	    if(InventoryInfo[playerid][i][inv_id] == xid) {
	        modelid = InventoryInfo[playerid][i][iModel];
	        break;
		}
	}
	for(new i = 0; i < sizeof ItemData; i++) {
	    if(ItemData[i][itemModel] == modelid) {
	        return ItemData[i][index_id];
		}
	}
	return -1;
}

stock Spacer(playerid)
{
    SendClientMessage(playerid, -1, "{1abf3b}__________________________________________");
}

stock GetAlivePlayerID()
{
	foreach(new i : Player) {
	    if(GetPVarInt(i, "ParticipatingHG") == 1) {
	        if(GetPVarInt(i, "HGDead") == 0) {
	        	return i;
			}
		}
	}
	return INVALID_PLAYER_ID;
}

stock GetInventoryItems(playerid) {
	new count = 0;
	foreach(new i : InvItems[playerid]) {
	    count += InventoryInfo[playerid][i][quantity];
	}
	return count;
}

forward HGLoop();
public HGLoop()
{
	if(mode_Time == -20) return 1;
	new string[128], tPlayer_Count = 0, aPlayer_Count = 0;
	if(mode_Alive == 1) {
	    foreach(new i : Player) {
	        if(GetPVarInt(i, "ParticipatingHG") == 1) {
	            
	            if(GetPVarInt(i, "HGDead") == 0 && mode_Started == 1) {
	                Spacer(i);
		            format(string, sizeof string, "{FF0000}[HUNGER GAMES]{FFFFFF}: %s | Awarded: 100,000$ & 10 Score", pName[i]);
		            SendClientMessageToAll(-1, string);
		            Spacer(i);
		            SetPVarInt(i, "HGDead", 1);
		            GivePlayerCash(i, 100000);
		           	GivePlayerScore(i, 10);
		            ResetModeSettings();
		            
		            foreach(new y : Player) {
		                if(GetPVarInt(y, "HGDead") == 1 && GetPVarInt(y, "ParticipatingHG") == 1) {
		                    TogglePlayerSpectating(y, 0);
						    TogglePlayerControllable(y, 0);
						    ResetPlayerInventoryX(y);
						    new randSpawn = random(14);
						    SetPlayerPos(y, Map1PlayerSpawn[randSpawn][SpawnX], Map1PlayerSpawn[randSpawn][SpawnY], Map1PlayerSpawn[randSpawn][SpawnZ]);
						}
				    }
				    
                    ResetPlayerInventoryX(i);
		            pInfo[i][pEventsWon]++;
		            TogglePlayerSpectating(i, 0);
		            TogglePlayerControllable(i, 0);
				    SetPVarInt(i, "HGDead", 1);
				    ResetPlayerInventoryX(i);
				    new randSpawn = random(14);
				    SetPlayerPos(i, Map1PlayerSpawn[randSpawn][SpawnX], Map1PlayerSpawn[randSpawn][SpawnY], Map1PlayerSpawn[randSpawn][SpawnZ]);
		            /* Spawn the player, freeze him until the 60 secs countdown finishes */
				}
				else {
				    TogglePlayerSpectating(i, 0);
				    TogglePlayerControllable(i, 0);
				    SetPVarInt(i, "HGDead", 1);
				    ResetPlayerInventoryX(i);
				    new randSpawn = random(14);
				    SetPlayerPos(i, Map1PlayerSpawn[randSpawn][SpawnX], Map1PlayerSpawn[randSpawn][SpawnY], Map1PlayerSpawn[randSpawn][SpawnZ]);
				}
			}
		}
	}
	else if(mode_Alive == 0) {
	    if(mode_Time >= 1) {
	        mode_Time--;
		}
		else if(mode_Time <= 0) {
		    if(mode_Players <= 2) {
		        SendClientMessageToAll(-1, "{FF0000}[HUNGER GAMES] Mode cancelled due to lack of players.");
		        ResetModeSettings();
			}
		    else {
			    foreach(new i : Player) {
			        if(GetPVarInt(i, "ParticipatingHG")) {
			            ResetPlayerInventoryX(i);
						ResetPlayerWeapons(i);
						mode_Started = 1;
			            SetPVarInt(i, "HGDead", 0);
						TogglePlayerControllable(i, 1);
						SetPlayerHealth(i, 97);
						SetPlayerArmour(i, 0);
						mode_Time = 0;
						SendClientMessage(i, -1, "{FF0000}[HUNGER GAMES] {FFFFFF}MODE STARTED - GOOD LUCK!");
						new randSpawn = random(14);
   		 				SetPlayerPos(i, Map1PlayerSpawn[randSpawn][SpawnX], Map1PlayerSpawn[randSpawn][SpawnY], Map1PlayerSpawn[randSpawn][SpawnZ]);
					}
				}
			}
		}
	}
	foreach(new i : Player) {
	    if(GetPVarInt(i, "ParticipatingHG") == 1) {
	        tPlayer_Count ++;
	        if(GetPVarInt(i, "HGDead") == 0) {
				aPlayer_Count ++;
			}
			if(6 <= mode_Time <= 8)
			{
			    GameTextForPlayer(i, "~r~Game starts in:", 1000, 3);
			}
			if(1 <= mode_Time <= 5) {
			    new tmpVal[50];
			    format(tmpVal, sizeof tmpVal, "~r~%i", mode_Time);
			    GameTextForPlayer(i, tmpVal, 1000, 3);
			}
		}
	}
	if(mode_Started == 1) {
	    mode_Time_Passed++;
	    if(mode_Time_Passed >= 180) {
	        DestroyLoot();
	        SpawnLoot(current_Map);
	        mode_Time_Passed = 0;
		}
	}
	mode_Players = tPlayer_Count;
	mode_Alive = aPlayer_Count;
	return 1;
}

CMD:hgstats(playerid, params[])
{
	new string[128];
	Spacer(playerid);
	format(string, sizeof string, "{FF0000}[HUNGER GAMES] {FFFFFF} Players alive: %i | Players in total: %i | Time until start: %i", mode_Alive, mode_Players, mode_Time);
	SendClientMessage(playerid, -1, string);
	Spacer(playerid);
	return 1;
}

CMD:hg(playerid, params[]) return cmd_hungergames(playerid, params);
CMD:hungergames(playerid, params[])
{
	if(!CanPlayerTeleport(playerid)) return true;
	if(EventStarted == 1) return Error(playerid, "The event has already started, wait for the next one!");
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't join an event while in a DM! Type /leave to exit.");
		return true;
	}
	if(RaceParticipant[playerid] != 0)
	{
		Error(playerid, "You can't join an event while in a race! Type /leave to exit.");
		return true;
	}
	if(doingStunt[playerid] != 0) return Error(playerid, "Teleport out of the stunt area to join the event!");
	if(InEvent[playerid] != 0 || ParticipatingWar[playerid] == 1) return Error(playerid, "You are already in/signup for the event!");

	if(InDerby[playerid] == 1) return Error(playerid, "You are already in a derby!");
	if(mode_Time == -20) return Error(playerid, "There's no Hungergames event going on.");
	if(mode_Alive >= 2 && mode_Started == 1 && mode_Time == 0)
	{
	    SendClientMessage(playerid, -1, "{FF0000}[HUNGER GAMES] {FFFFFF}The game is on-going - you are now a spectator.");
	    SetPVarInt(playerid, "HGDead", 1);

        if(GOD[playerid]) { GOD[playerid] = false; SetPVarInt(playerid, "HadGod", 1); }
		SetPlayerVirtualWorld(playerid, 139);
		
        canUseKey[playerid] = false;

		TogglePlayerSpectating(playerid, 1);
        SetPVarInt(playerid, "ParticipatingHG", 1);
        UpdateDMText();
		new aliveID = GetAlivePlayerID();

		if(aliveID != INVALID_PLAYER_ID) {
	    	PlayerSpectatePlayer(playerid, aliveID);
	    	HG_CurrentSpectator[playerid] = aliveID;
	    }
	    UpdateMinigameBox(playerid, 1, "/hg");
	}
	else if(mode_Alive == 0 && mode_Time > 0)
	{
	    mode_Players++;
		SetPVarInt(playerid, "HGDead", 1);
		SetPVarInt(playerid, "ParticipatingHG", 1);
		SendClientMessage(playerid, -1, "{FF0000}[HUNGER GAMES] {FFFFFF}The game has not started yet - you will be unfrozen when it will (/hgstats)");
		SendClientMessage(playerid, -1, "{FF0000}[HUNGER GAMES] {FFFFFF}Tips: Pick up an item from the ground by pressing N; press Y to open the inventory.");
		SendClientMessage(playerid, -1, "{FF0000}[HUNGER GAMES] {FFFFFF}Tips: Commands of hungergames are /inv /takeitem /leavehg /hgstats /hgchat");
		new randSpawn = random(14);
		SetPlayerPos(playerid, Map1PlayerSpawn[randSpawn][SpawnX], Map1PlayerSpawn[randSpawn][SpawnY], Map1PlayerSpawn[randSpawn][SpawnZ]+0.85);
		TogglePlayerControllable(playerid, 0);
		ResetPlayerWeapons(playerid);
		SetPlayerHealth(playerid, 98);
		SetPlayerArmour(playerid, 0);
		if(GOD[playerid]) { GOD[playerid] = false; SetPVarInt(playerid, "HadGod", 1); }
		SetPlayerVirtualWorld(playerid, 139);
		ResetPlayerInventoryX(playerid);
		canUseKey[playerid] = false;
		UpdateDMText();
		UpdateMinigameBox(playerid, 1, "/hg");
	}
	return 1;
}

forward StopPlayerAnimation(playerid);
public StopPlayerAnimation(playerid) {
	ClearAnimations(playerid, 1);
	return 1;
}

CMD:takeitem(playerid)
{
    new itemCount = GetInventoryItems(playerid);
	new res = 0;
	if(itemCount <= 6)
	{
		foreach(new i : HGLoot) {
		    if(IsPlayerInRangeOfPoint(playerid, 2, LootInfo[i][loot_Location][0], LootInfo[i][loot_Location][1], LootInfo[i][loot_Location][2])) {
		        GivePlayerModelItem(playerid, LootInfo[i][loot_Model], 1);
				Iter_Remove(HGLoot, i);
				DestroyObject(LootInfo[i][loot_id]);
				res = 1;
				break;
			}
		}
		if(res==0) SendClientMessage(playerid, -1, "{FF0000} There is no item nearby.");
		else {
		    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 1, 0, 1);
  			SetTimerEx("StopPlayerAnimation", 1500, false, "i", playerid);
		}
	}
	else SendClientMessage(playerid, -1, "{FF0000} Your inventory is already full.");
	return 1;
}

CMD:inv(playerid, params[])
{
	if(GetPVarInt(playerid, "ParticipatingHG") == 1) {
		new res = 0, invString[1024], tmpTitle[128];
		format(tmpTitle, sizeof tmpTitle, "Quantity\tItem name\t(Qnt: %i|8)\n", GetInventoryItems(playerid));
		strcat(invString, tmpTitle, sizeof invString);
		foreach(new i : InvItems[playerid]) {
			new tempString[128];
		    invMenuData[playerid][res] = InventoryInfo[playerid][i][inv_id];
		    format(tempString, sizeof tempString, "%i\t%s\n", InventoryInfo[playerid][i][quantity], ItemNameFromModel(InventoryInfo[playerid][i][iModel]));
			strcat(invString, tempString, sizeof invString);
		    res++;
		}
		if(res>0) ShowPlayerDialog(playerid, 9674, DIALOG_STYLE_TABLIST_HEADERS, "Inventory", invString, "Use", "Close");
	}
	else SendClientMessage(playerid, -1, "{FF0000} You must be in HG to use this command.");
	return 1;
}

stock HG_NearestLeftID(playerid, currentID)
{
    new cls_id = -1;
    if(currentID == 0) currentID = GetPlayerPoolSize()+1;
    for(new i = currentID -1 ;i>=0; i--)
    {
        if(i != playerid) {
	        if((GetPVarInt(i, "ParticipatingHG") == 1) && (GetPVarInt(i, "HGDead") == 0)) {
	            cls_id = i;
	            break;
			}
		}
    }
    return cls_id;
}

stock HG_NearestRightID(playerid, currentID)
{
    new cls_id = -1;
    if(currentID == GetPlayerPoolSize()) currentID = -1;
    for(new i = currentID +1, j = GetPlayerPoolSize(); i<=j; i++)
    {
        if(i != playerid) {
	        if((GetPVarInt(i, "ParticipatingHG") == 1) && (GetPVarInt(i, "HGDead") == 0)) {
	            cls_id = i;
	            break;
			}
		}
    }
    return cls_id;
}


/*

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_FIRE) 
	{
		if(GetPVarInt(playerid, "ParticipatingHG") && GetPVarInt(playerid, "HGDead") == 1 && mode_Started == 1)
		{
			new nextid = HG_NearestLeftID(playerid, HG_CurrentSpectator[playerid]);

	        HG_CurrentSpectator[playerid] = nextid;
	        if(nextid == -1)
	        {
	        	return SendClientMessage(playerid, COLOR_RED, "ERROR: There are no other players to spectate");
	        }
			PlayerSpectatePlayer(playerid, nextid);
			format(str, sizeof(str), "You are now spectating {0E9A15}%s (%d) {ffffff}in the hungergames", pName[nextid], nextid);
	       	SendClientMessage(playerid, -1, str);
		}
	}

	if(newkeys & KEY_LOOK_BEHIND)
	{
		if(GetPVarInt(playerid, "ParticipatingHG") && GetPVarInt(playerid, "HGDead") == 1 && mode_Started == 1)
		{
			new nextid = HG_NearestRightID(playerid, HG_CurrentSpectator[playerid]);
	        HG_CurrentSpectator[playerid] = nextid;
	       	if(nextid == -1)
	       	{
	       		return SendClientMessage(playerid, COLOR_RED, "ERROR: There are no other players to spectate");
	       	}
	       	format(str, sizeof(str), "You are now spectating {0E9A15}%s (%d) {ffffff}in the hungergames", pName[nextid], nextid);
	       	SendClientMessage(playerid, -1, str);
			PlayerSpectatePlayer(playerid, nextid);
		}
	}
	return 1;
}*/
