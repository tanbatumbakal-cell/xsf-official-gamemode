

#include <fader>


#if ((__Pawn & 0x0F) >= 0x0A) || ((__Pawn & 0xF0) >= 0xA0)
    #pragma warning push
    #pragma warning disable 207
    #pragma disablerecursion
    #pragma warning pop
    #pragma warning disable 238
#endif



#define MAX_INVENTORY_SLOTS 	15
#define MAX_ITENS_WORLD 		500
#define TIMER_ITEM_WORLD        60*10
#define DIALOG_TAKEINV 459
#define DIALOG_TAKECARE 460
#define PUBG_INVITE 461

#define PUBG_WORLD 69
#define REDUCETIME 1000
#define TIME_TO_RESTRICT 70
#define INVALID_STREAMER_ID (0)
#define COLOR_INVISIBLE 0xFF000000

//pubg enumas and other
new Text:Restrict_TD;
#define PUBG_WORLD 69
#define REDUCETIME 1000
#define TIME_TO_RESTRICT 70
#define MAX_DITEMS 200000
#define PUBGgame 10
#define randomEx(%1,%2) (random(%2-%1)+%1)
#define MAX_CARE_PACKAGES 50
#define CAREPACKRESPAWN 1200000
#define FADE_FROM_COLOR \
	((0xA30000FF & ~0xFF) | 25)

#define FADE_TO_COLOR \
	((0xA30000FF & ~0xFF) | 150)
	
forward PUBG_OnPlayerDeath(playerid,killerid,reason);
forward PUBG_OnPlayerClickPTextDraw(playerid, PlayerText:playertextid);
forward PUBG_OnPlayerEnterDynamicArea(playerid, areaid);
forward PUBG_OnPlayerLeaveDynamicArea(playerid, areaid);
forward PUBG_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
forward PUBG_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
forward PUBG_OnGameModeInit();
forward PUBG_OnPlayerDisconnect(playerid,reason);
forward PUBG_OnGameModeExit();
forward PUBG_OnPlayerConnect(playerid);
forward PUBG_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);


new const reductionTimerCountdown[] =
{
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000,
	70000
};
new const Float:reductionNumbers[sizeof reductionTimerCountdown][3] =
{
	{10.0, 10.0, 10.0},
	{9.5, 9.5, 9.5},
	{8.5, 8.5, 8.5},
	{7.5, 7.5, 7.5},
	{6.5, 6.5, 6.5},
	{5.5, 5.5, 5.5},
	{4.5, 4.5, 4.5},
	{3.5, 3.5, 3.5},
	{2.5, 2.5, 2.5},
	{2.0, 2.0, 2.0},
	{2.0, 2.0, 2.0},
	{2.0, 2.0, 2.0},
	{2.0, 2.0, 2.0},
	{2.0, 2.0, 2.0}
};

enum SpawnEnum
{
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:Useless
};
new Float:cPSpawn1[4][SpawnEnum] =
{
	{1031.9677,311.6164,26.1711,315.1931}, // 1
	{1227.7328,-59.7986,35.0633,200.1988}, // 1
	{1478.4004,267.0559,18.9576,82.3842}, // 1
	{1242.3781,469.4615,18.8438,69.8508} // 1
};
new Float:cPSpawn2[4][SpawnEnum] =
{
	{1120.3950,363.1091,29.6516,206.1519}, // 2
	{1396.8774,87.3226,25.8915,104.9441}, // 2
	{1053.5303,195.0095,33.8538,355.5898}, // 2
	{1175.9717,399.3810,25.3788,187.9548} // 2
};
new Float:cPSpawn3[4][SpawnEnum] =
{
	{1214.1254,77.3804,24.7231,314.8093}, // 3
	{1296.6992,382.5444,19.5625,65.7303}, // 3
	{1150.0548,285.5803,19.4031,107.0907}, // 3
	{1307.7434,114.9790,20.8766,309.8193} // 3
};
new Float:cPSpawn4[4][SpawnEnum] =
{
	{1326.7748,318.2519,19.5469,241.1985}, // 4
	{1194.1831,127.0434,22.6869,220.8317}, // 4
	{1176.2087,303.0365,18.5109,331.7528}, // 4
	{1307.7798,139.8826,20.3437,186.6781} // 4
};
new Float:cPSpawn5[4][SpawnEnum] =
{
	{1207.4519,185.3215,20.5098,325.4625}, // 5
	{1263.8025,289.1771,19.5547,224.2783}, // 5
	{1203.0089,244.6762,24.5555,340.1893}, // 5
	{1317.6309,220.0524,25.0223,69.8034} // 5
};
new Float:cPSpawn6[3][SpawnEnum] =
{
	{1267.4065,205.3597,19.4140,193.5479}, // 6
	{1237.0253,243.0219,19.4063,334.2126}, // 6
	{1237.5100,214.5439,19.4063,152.1642} // 6
};
new Float:SpawnInfo[][SpawnEnum] =
{
	{1357.3989,452.3988,307.2825,189.2086},
	{1412.6719,385.4903,307.2825,225.2422},
	{1477.7145,257.9554,307.2825,123.4080},
	{1492.7244,170.9798,307.2825,208.3221},
	{1467.8174,118.9138,307.2825,35.0471},
	{1438.8573,58.5962,307.2825,181.6885},
	{1417.5406,17.3805,307.6086,133.1214},
	{1406.0266,88.6497,307.6086,321.0998},
	{1318.1799,-21.1319,308.1595,114.3213},
	{1245.6605,-41.3541,308.1595,96.4611},
	{1230.2788,-4.1045,308.1595,10.9203},
	{1184.6837,-18.1405,308.1595,114.3213},
	{1145.4677,3.3083,308.1595,40.0606},
	{1084.8503,31.4548,308.1595,30.0339},
	{1092.4528,98.7927,308.1595,346.7934},
	{1027.4546,98.4653,308.1595,20.3204},
	{1007.0707,174.7861,308.1595,12.8004},
	{989.4210,217.6127,308.1595,25.0205},
	{1043.4961,253.5159,308.1595,296.9730},
	{1051.2101,317.8210,308.1595,25.6472},
	{1090.6857,405.4625,308.1595,329.8733},
	{1118.1367,370.9434,308.1595,207.6721},
	{1192.6224,455.4110,308.1595,318.2797},
	{1231.6432,444.9737,308.1595,253.1058},
	{1251.8607,472.0023,308.1595,329.5598},
	{1278.0172,475.6191,308.1595,270.6526},
	{1338.1527,468.5648,308.1595,260.9392},
	{1379.7285,433.1948,308.1595,226.7855},
	{1432.0562,394.7720,308.1595,235.5589},
	{1463.6798,350.9040,308.1595,210.1787},
	{1431.3962,318.8194,308.1595,119.9379},
	{1502.4048,245.2643,308.1595,197.0186},
	{1512.9061,206.1788,308.1595,190.1252},
	{1478.4823,186.5041,308.1595,112.7311},
	{1478.6449,147.6831,308.1595,192.3186},
	{1479.6320,108.9082,309.0826,143.4381},
	{1447.8220,87.0074,309.0826,118.0579},
	{1417.6150,93.9989,309.0826,49.4372},
	{1390.6244,21.4605,309.0826,187.1848},
	{1353.2374,-18.9427,309.0826,105.5244}
};

////////////
enum cPack {
	bool:CarePackageUsed,
	bool:CarePackageLanded,
	bool:PlaneMoveStage,
	Float:CarePackageRotation,
	CarePackagePlane,
	CarePackageFlare,
	CarePackageParachute,
	CarePackageBox,
//	CarePackageStuff,
	Float:CarePackageLand[3],
	Text3D:CarePackageText,
	CarePackageInterior,
	CarePackageWorld,
}

new pCarePackage[MAX_CARE_PACKAGES][cPack];
new Iterator:CarePackages<MAX_CARE_PACKAGES>;
new CarePackageDespawnTimer[MAX_CARE_PACKAGES];
new PackageSlots[MAX_CARE_PACKAGES][5];
enum pvaras
{
	inPUBG,
	pKills,
}

new eInfo[MAX_PLAYERS][pvaras];
enum iENUM
{
	Float:ItemX,
	Float:ItemY,
 	Float:ItemZ,
 	Float:Useless
};
new Float:gRandomSpawns11[][4] =
{
    {-2659.5703,4062.0190,7.4125,87.1817}, // pubg
	{-2671.3687,4062.1189,7.4125,90.9417}, // pubg
	{-2689.9932,4062.2605,7.4125,88.7484}, // pubg
	{-2696.2427,4054.4333,7.4125,272.9901}, // pubg
	{-2682.1917,4054.1902,7.4125,268.2900}, // pubg
	{-2664.4998,4053.7551,7.4125,268.6034}, // pubg
	{-2660.3987,4069.6121,7.4125,92.8451}, // pubg
	{-2673.0156,4069.2278,7.4125,91.5918}, // pubg
	{-2690.0325,4069.3804,7.4125,89.3984}, // pubg
	{-2703.0728,4062.3979,7.4125,269.2535}, // pubg
	{-2636.0503,4061.6450,7.4125,90.0485} // pubg
};
new Float:ItemInfo[31][iENUM] =
{
	{1311.044921 , 329.098388 , 19.914062 , 10.0},
	{1357.736206 , 329.402740 , 20.554687 , 10.0},
	{1383.668090 , 434.491546 , 20.052534 , 10.0},
	{1412.653808 , 412.765411 , 20.508386 , 10.0},
	{1450.568847 , 373.812866 , 19.096780 , 10.0},
	{1473.638549 , 345.289062 , 18.841670 , 10.0},
	{1416.330078 , 296.241699 , 19.554687 , 10.0},
	{1387.381469 , 295.036468 , 23.055511 , 10.0},
	{1304.567016 , 416.439056 , 19.561342 , 10.0},
	{1242.791748 , 444.400421 , 18.855480 , 10.0},
	{1158.220214 , 419.406616 , 29.310995 , 10.0},
	{1085.837768 , 414.508758 , 28.183017 , 10.0},
	{1085.646972 , 302.585449 , 23.247097 , 10.0},
	{1017.210571 , 268.608154 , 30.229619 , 10.0},
	{1034.613281 , 178.538284 , 32.208286 , 10.0},
	{1055.221923 , 66.965003 , 60.073932 , 10.0},
	{1128.568237 , -2.566592 , 62.670673 , 10.0},
	{1162.868774 , 78.292175 , 36.548034 , 10.0},
	{1203.578735 , -16.798883 , 36.951332 , 10.0},
	{1256.250732 , 24.709115 , 25.619739 , 10.0},
	{1366.277832 , 35.710350 , 30.684261 , 10.0},
	{1468.524047 , 86.004577 , 29.701295 , 10.0},
	{1380.288818 , 139.637268 , 21.377643 , 10.0},
	{1468.640258 , 162.516510 , 28.381380 , 10.0},
	{1529.885375 , 255.112045 , 16.441589 , 10.0},
	{1418.423217 , 220.632690 , 19.561782 , 10.0},
	{1406.708984 , 227.903778 , 24.002670 , 10.0},
	{1368.675659 , 254.640014 , 19.566932 , 10.0},
	{1324.497436 , 286.692413 , 20.045194 , 10.0},
	{1321.157348 , 282.201599 , 27.847461 , 10.0},
	{1311.040527 , 254.622451 , 26.742618 , 10.0}
};
new Float:TableInfo[12][iENUM] =
{
	{-2678.9128,4038.4836,7.8072,349.7343},
	{-2678.7605,4034.7297,7.3748,175.5194},
	{-2672.4109,4034.6169,7.4269,269.5202},
	{-2672.1418,4038.2556,7.8072,353.4944},
	{-2665.7070,4038.0942,7.8072,262.6269},
	{-2665.6714,4034.2063,7.4836,4.1244},
	{-2660.0073,4033.8245,7.3811,268.5569},
	{-2659.6243,4037.9470,7.8072,350.3377},
	{-2653.1504,4037.7668,7.8072,261.6636},
	{-2653.0872,4033.6941,7.4064,299.2640},
	{-2646.0725,4037.7219,7.8072,356.2912},
	{-2645.9985,4033.4407,7.3040,258.1935}
};
new Float:WItemInfo[30][iENUM] =
{
	{1302.332153 , 220.569290 , 19.554687 , 10.0},
	{1300.399291 , 141.651977 , 20.395816 , 10.0},
	{1246.063354 , 203.489089 , 19.645431 , 10.0},
	{1199.111206 , 141.028274 , 20.547721 , 10.0},
	{1147.894531 , 227.393371 , 25.034244 , 10.0},
	{1257.802612 , 293.464263 , 19.757812 , 10.0},
	{1293.801879 , 306.012481 , 27.555507 , 10.0},
	{1238.804809 , 309.989776 , 24.757812 , 10.0},
	{1237.775756 , 374.384002 , 19.554687 , 10.0},
	{1471.783447 , 222.348342 , 19.380233 , 10.0},
	{1367.117675 , 194.175796 , 19.554687 , 10.0},
	{1352.198120 , 191.066253 , 24.227144 , 10.0},
	{1321.263427 , 82.158401 , 22.088483 , 10.0},
	{1101.869995 , 148.350723 , 31.827272 , 10.0},
	{1097.816284 , 236.123947 , 30.554229 , 10.0},
	{1026.886962 , 374.732208 , 21.818023 , 10.0},
	{1150.746582 , 342.256591 , 24.924287 , 10.0},
	{1203.455566 , 273.989532 , 19.554687 , 10.0},
	{1347.147094 , 471.189941 , 20.218570 , 10.0},
	{1373.602294 , 377.219482 , 19.757812 , 10.0},
	{1290.531127 , 483.555328 , 19.882812 , 10.0},
	{1176.652954 , 488.880340 , 18.984279 , 10.0},
	{1115.453369 , 457.404266 , 30.455421 , 10.0},
	{1157.981445 , 301.104583 , 18.430492 , 10.0},
	{1331.451782 , 371.042205 , 19.554687 , 10.0},
	{1474.597900 , 285.354400 , 18.977256 , 10.0},
	{1325.922851 , 246.336410 , 19.561452 , 10.0},
	{1277.491210 , 306.207183 , 19.554687 , 10.0},
	{1253.731201 , 299.762634 , 28.755514 , 10.0},
	{1280.966308 , 268.161041 , 23.762454 , 10.0}
};
new Float:RareItemInfo[13][iENUM] =
{
	{1358.045776 , 350.257293 , 29.303558 , 10.0},
	{1035.183959 , 165.515289 , 39.878036 , 10.0},
	{1377.180541 , 247.266250 , 28.226562 , 10.0},
	{1272.107299 , 295.151184 , 20.656307 , 10.0},
	{1089.017333 , 350.860015 , 24.265691 , 10.0},
	{1321.459228 , 61.169357 , 22.281272 , 10.0},
	{1203.725830 , 146.458648 , 20.480041 , 10.0},
	{1263.301025 , 241.905364 , 31.107307 , 10.0},
	{1212.064086 , 400.572814 , 23.737924 , 10.0},
	{1428.757568 , 358.197631 , 22.234115 , 10.0},
	{1439.760620 , 150.565170 , 22.384119 , 10.0},
	{1323.067382 , 162.259033 , 20.602977 , 10.0},
	{1380.556030 , 295.938079 , 22.555511 , 10.0}
};
forward HideRestrictTD();
forward ReduceCircle();
forward IslandTime();
new reductionTimer = -1;
new reductionIndex;
new secondsPast;
enum PUBGInfo
{
//	Circle,
	pRange,
	Reduce,
	Start,
	Players,
	Time,
	CircleA,
	Island,
	CTime,
	GasON,
	TotalJoined,
	GasPart,
	Seconds,
	Minutes,
}

new PUBG[PUBGInfo];
new Float:redField[4];
new redForcefield[4] = {-1, -1, -1, -1};
new redAreaid = INVALID_STREAMER_ID;

new Float:whiteField[4];
new whiteForcefield[4] = {-1, -1, -1, -1};
new whiteAreaid = INVALID_STREAMER_ID;

new Text:bloodFaderTextDraw = Text:INVALID_TEXT_DRAW;
new bool:leftRedArea[MAX_PLAYERS];

new Text:announcementTextDraw;
new Text:countDownTextDraw;


enum enum_Itens
{
	items_id,
 	item_tipo,
  	Item_Model,
 	item_nome[24],
	item_limite,
	bool:item_canbedropped,
	Float:item_previewrot[4],
	item_description[200]
}
enum
{
	ITEM_TYPE_WEAPON,
	ITEM_TYPE_HELMET,
	ITEM_TYPE_NORMAL,
	ITEM_TYPE_BODY,
	ITEM_TYPE_AMMO,
	ITEM_TYPE_BACKPACK,
	ITEM_TYPE_MELEEWEAPON
}

enum enum_pInventory
{
	invSlot[MAX_INVENTORY_SLOTS],
	invSelectedSlot,
	invSlotAmount[MAX_INVENTORY_SLOTS],
	Float:invArmourStatus[MAX_INVENTORY_SLOTS]
}

enum enum_pCharacter
{
	charSlot[7],
	charSelectedSlot,
	Float:charArmourStatus
}

enum enum_Player
{
	bool:inInventory,
	bool:MessageInventory,
	MessageInventoryTimer,
	Language
}

enum enum_ItensWorld
{
	bool:world_active,
	world_itemid,
	world_model,
	world_amount,
	world_object,
	world_timer,
	Text3D:world_3dtext,
	Float:world_armourstatus,
	Float:world_position[3],

}
new ItemToTake[MAX_PLAYERS][MAX_ITENS_WORLD];
new PackageToTake[MAX_PLAYERS][10];
new TakenCarePackage[MAX_PLAYERS];
new Itens[][enum_Itens] =
{
	{0, 	ITEM_TYPE_NORMAL,		19382, 		"None", 				0,			false,		{0.0,0.0,0.0,0.0}, 								"N/A"},
	{1, 	ITEM_TYPE_HELMET, 		18645, 		"Helmet I",	 			1,			true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Protect's you from headshot"},
	{2, 	ITEM_TYPE_WEAPON, 		348, 		"Deagle", 				1, 			true,		{0.000000, -30.00000, 0.000000, 1.200000}, 		"High caliber pistol."}, // ~n~~n~~g~Headshot habilitado.
	{3, 	ITEM_TYPE_WEAPON, 		356, 		"M4", 					1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Longe range rifle~n~with medium accuracy."},
	{4, 	ITEM_TYPE_NORMAL, 		2358, 		"None", 				200, 		true,		{0.000000, 0.000000, 0.000000, 2.000000}, 		"Ammunition for all firearms."},
	{5, 	ITEM_TYPE_WEAPON, 		344, 		"Molotov", 				5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Homemade incendiary weapon."},
	{6, 	ITEM_TYPE_BODY, 		19142, 		"Armor II", 			1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"A vest that'll give you 50 armor."},
	{7, 	ITEM_TYPE_BACKPACK, 	3026, 		"Average Backpack",		1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Backpack that increases your inventory ~n~."},
	{8, 	ITEM_TYPE_BACKPACK, 	19559, 		"Large Backpack",		1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Backpack that increases your inventory ~n~"},
    {9, 	ITEM_TYPE_WEAPON, 		355, 		"AK-47", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Long-range rifle ~n~with medium accuracy."},
    {10, 	ITEM_TYPE_WEAPON, 		349, 		"Shotgun", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Short-range shotgun ~n~ with a great firepower."},
    {11, 	ITEM_TYPE_MELEEWEAPON,	335, 		"Knife", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Melee weapon."},
    {12, 	ITEM_TYPE_MELEEWEAPON,	334, 		"Night Stick", 			1, 			true,		{0.000000, -30.00000, 0.000000, 1.500000}, 		"Melee weapon"},
    {13, 	ITEM_TYPE_WEAPON, 		352, 		"UZI", 					1, 			true,		{0.000000, -30.00000, 0.000000, 1.200000}, 		"Two handed micro machine gun."},
    {14, 	ITEM_TYPE_WEAPON, 		347, 		"Silenced 9mm", 		1, 			true,		{0.000000, -30.00000, 0.000000, 1.200000}, 		"A Pistol with silencer"},
    {15, 	ITEM_TYPE_WEAPON, 		353, 		"MP5", 					1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Micro machine gun."},
    {16, 	ITEM_TYPE_WEAPON, 		358, 		"Sniper", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Long-range rifle"},
    {17, 	ITEM_TYPE_WEAPON, 		342, 		"Grenade", 				5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Powerful explosive."},
    {18, 	ITEM_TYPE_NORMAL, 		11738, 		"Medkit", 				5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"A Firt aid kit that completely ~n~recover your health."},
    {19, 	ITEM_TYPE_WEAPON, 		350, 		"Sawed Off", 			1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Short-barreled shotgun ~n~ with a great damage."},
    {20, 	ITEM_TYPE_WEAPON, 		351, 		"Combat Shotgun", 		1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Used for offensive purposes~n~ Famous because of ~r~BUCKSHOTS."},
    {21, 	ITEM_TYPE_WEAPON, 		357, 		"Country Rifle", 		1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Long barrel rifle, ~n~ Perfect for Longe range shots."},
    {22, 	ITEM_TYPE_WEAPON, 		346, 		"Colt 47", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Famous pistol of World War II, ~n~ Two handed weapon."},
    {23, 	ITEM_TYPE_WEAPON, 		343, 		"Smoke Grenade", 		5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Throwable weapon."},
	{24, 	ITEM_TYPE_BODY, 		1242, 		"Armor I", 				1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"A vest that'll give you 25 armor."},
	{25, 	ITEM_TYPE_BODY, 		19515, 		"Armor III", 			1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"A vest that'll give you 100 armor."},
	{26, 	ITEM_TYPE_HELMET, 		19584, 		"Helmet II",	 		1,			true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Protect's you from headshot"},
	{27, 	ITEM_TYPE_HELMET, 		19141, 		"Helmet III",	 		1,			true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Protect's you from headshot"},
 	{28, 	ITEM_TYPE_NORMAL, 		11736, 		"Medical Sachette", 	5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"A medical sachette use for Quick healing,~n~Will give you +40 health"},
    {29, 	ITEM_TYPE_NORMAL, 		11747, 		"Bandage", 				5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Material used to bind up a wound~n~Will give you +10 health"},
    {30, 	ITEM_TYPE_NORMAL, 		19581, 		"Pan", 					5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"A pan that'll be attached to your back"},
	{31, 	ITEM_TYPE_AMMO, 		2358, 		"7.62mm Ammo", 			200, 		true,		{0.000000, 0.000000, 0.000000, 2.000000}, 		"Ammunition box for Assault Rifles."},
	{32, 	ITEM_TYPE_AMMO, 		2040, 		".300 Magnum Ammo", 	200, 		true,		{0.000000, 0.000000, 0.000000, 2.000000}, 		"Ammunition box for Rifles."},
	{33, 	ITEM_TYPE_AMMO, 		2043, 		"12 Gauge", 			200, 		true,		{0.000000, 0.000000, 0.000000, 2.000000}, 		"Ammunition box for Shotguns."},
	{34, 	ITEM_TYPE_AMMO, 		3016, 		".45 ACP Ammo", 		200, 		true,		{0.000000, 0.000000, 0.000000, 2.000000}, 		"Ammunition box for SMG's."},
	{35, 	ITEM_TYPE_AMMO, 		19995, 		"Pistol Ammo", 			200, 		true,		{0.000000, 0.000000, 0.000000, 2.000000}, 		"Ammunition box for Pistols."}
};
//-------------------------------------------------------------------//
//************************* -Variables- *****************************//
//-------------------------------------------------------------------//

new pInventory[MAX_PLAYERS][enum_pInventory];
new pCharacter[MAX_PLAYERS][enum_pCharacter];
new pPlayer[MAX_PLAYERS][enum_Player];
new ItensWorld[MAX_ITENS_WORLD][enum_ItensWorld];
new String[256];
new LastItemID;

//-------------------------------------------------------------------//
//************************* -TextDraws- *****************************//
//-------------------------------------------------------------------//
new PlayerText:inventario_index[MAX_PLAYERS][15];
new PlayerText:inventario_skin[MAX_PLAYERS];
new PlayerText:inventario_textos[MAX_PLAYERS][11];
new PlayerText:inventario_description[MAX_PLAYERS][4];
new PlayerText:inventario_personagemindex[MAX_PLAYERS][7];
new PlayerText:inventario_mensagem[MAX_PLAYERS];

new Text:inventario_usar;
//new Text:PUBG_NAME[3];
new Text:inventario_split[2];
new Text:inventario_drop[2];
new Text:inventario_close[2];
new Text:inventario_backgrounds[5];
new Text:inventario_remover;
new Text:Start_TD;
new Text:PUBG_TD[3];
new PlayerText:PKILLS[MAX_PLAYERS];
new PlayerText:PUBG_DIED[MAX_PLAYERS][14];
forward @TimerOneSecond();
forward HideMessageInventory(playerid);
//forward Float:GetPlayerArmourEx(playerid);

public PUBG_OnGameModeInit()
{
	PUBG[Seconds] = 60;
	PUBG[Minutes] = 19;
	LoadTextDraws();
	PUBG_TD[0] = TextDrawCreate(589.428344, 1.413357, "Alive");
	TextDrawLetterSize(PUBG_TD[0], 0.270094, 1.378134);
	TextDrawTextSize(PUBG_TD[0], 624.000000, 0.000000);
	TextDrawAlignment(PUBG_TD[0], 1);
	TextDrawColor(PUBG_TD[0], 183);
	TextDrawUseBox(PUBG_TD[0], 1);
	TextDrawBoxColor(PUBG_TD[0], -2139062114);
	TextDrawSetShadow(PUBG_TD[0], 0);
	TextDrawSetOutline(PUBG_TD[0], 0);
	TextDrawBackgroundColor(PUBG_TD[0], 164);
	TextDrawFont(PUBG_TD[0], 2);
	TextDrawSetProportional(PUBG_TD[0], 1);
	TextDrawSetShadow(PUBG_TD[0], 0);
	PUBG_TD[1] = TextDrawCreate(569.037658, 1.460008, "02");
	TextDrawLetterSize(PUBG_TD[1], 0.329522, 1.433598);
	TextDrawTextSize(PUBG_TD[1], 586.400146, 0.000000);
	TextDrawAlignment(PUBG_TD[1], 1);
	TextDrawColor(PUBG_TD[1], -1);
	TextDrawUseBox(PUBG_TD[1], 1);
	TextDrawBoxColor(PUBG_TD[1], 255);
	TextDrawSetShadow(PUBG_TD[1], 0);
	TextDrawSetOutline(PUBG_TD[1], 0);
	TextDrawBackgroundColor(PUBG_TD[1], 255);
	TextDrawFont(PUBG_TD[1], 2);
	TextDrawSetProportional(PUBG_TD[1], 1);
	TextDrawSetShadow(PUBG_TD[1], 0);

	PUBG_TD[2] = TextDrawCreate(525.865661, 2.040024, "KILLED");
	TextDrawLetterSize(PUBG_TD[2], 0.270094, 1.378134);
	TextDrawTextSize(PUBG_TD[2], 563.000000, 0.000000);
	TextDrawAlignment(PUBG_TD[2], 1);
	TextDrawColor(PUBG_TD[2], 218);
	TextDrawUseBox(PUBG_TD[2], 1);
	TextDrawBoxColor(PUBG_TD[2], -2139062124);
	TextDrawSetShadow(PUBG_TD[2], 0);
	TextDrawSetOutline(PUBG_TD[2], 0);
	TextDrawBackgroundColor(PUBG_TD[2], 164);
	TextDrawFont(PUBG_TD[2], 2);
	TextDrawSetProportional(PUBG_TD[2], 1);
	TextDrawSetShadow(PUBG_TD[2], 0);
	CreateDynamicObject(18751, -2712.24170, 4187.17773, -12.27238,   0.00000, 0.00000, 0.00000);
	//CreateDynamicObject(8355, -2685.54761, 4062.21777, 6.41250,   0.00000, 0.00000, 269.28009);
	CreateObject(8355, -2685.54761, 4062.21777, 6.41250,   0.00000, 0.00000, 269.28009);
	CreateDynamicObject(19539, -2723.73560, 4042.80420, 6.42960,   0.00000, 5.86000, -90.71992);
	CreateDynamicObject(19539, -2661.26733, 4041.98657, 6.42960,   0.00000, 5.86000, -90.71992);
	CreateDynamicObject(19539, -2647.95337, 4041.80811, 6.42507,   0.00000, 5.86000, -90.71992);
	CreateDynamicObject(17030, -2613.25049, 4069.13550, -11.39472,   0.00000, 0.00000, -42.48000);
	CreateDynamicObject(17030, -2607.56738, 4068.93628, -11.39472,   0.00000, 0.00000, -21.66000);
	CreateDynamicObject(17030, -2615.35620, 4030.05493, -11.39472,   0.00000, 0.00000, -46.79999);
	CreateDynamicObject(17030, -2608.14819, 4031.33008, -11.39472,   0.00000, 0.00000, -239.09998);
	CreateDynamicObject(17030, -2758.91821, 4039.75122, -12.43033,   0.00000, 0.00000, -35.45999);
	CreateDynamicObject(17030, -2758.30273, 4072.74341, -10.73355,   0.00000, 0.00000, -35.45999);
	CreateDynamicObject(17030, -2765.92041, 4041.83325, -11.37234,   0.00000, 0.00000, -35.45999);
	CreateDynamicObject(17030, -2765.79321, 4064.95581, -10.05484,   0.00000, 0.00000, -35.45999);
	CreateDynamicObject(1683, -2721.41187, 4061.96460, 3.58634,   -4.20001, -21.30011, 184.13985);
	CreateDynamicObject(1683, -2723.36230, 4061.02051, 9.69648,   7.73999, 21.17996, 178.55986);
	CreateDynamicObject(849, -2731.88135, 4059.61597, 6.68881,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(849, -2730.13477, 4060.55591, 6.68881,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(849, -2733.19336, 4060.18677, 6.68881,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(849, -2733.64844, 4059.26270, 6.68881,   0.00000, 0.00000, -47.10000);
	CreateDynamicObject(19922, -2672.15503, 4038.33008, 6.01816,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2665.52710, 4038.10596, 6.01816,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2659.50513, 4038.00342, 6.01816,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2652.90381, 4037.82715, 6.01816,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2645.89917, 4037.76709, 6.01816,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2678.69775, 4038.45020, 6.01816,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2678.97803, 4034.72778, 5.58569,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2672.23511, 4034.56738, 5.63788,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2665.82739, 4034.26294, 5.69449,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2659.76538, 4034.04224, 5.59202,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2652.98389, 4033.76367, 5.61735,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(19922, -2645.95923, 4033.52441, 5.51495,   0.00000, 0.00000, -2.70000);
	CreateDynamicObject(671, -2621.01074, 4037.57104, 6.06363,   0.00000, 0.00000, 2.70000);
	CreateDynamicObject(672, -2646.78394, 4025.20947, 5.69076,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2631.22192, 4029.21191, 5.63605,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2636.98291, 4036.01025, 6.67767,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2656.83838, 4025.37085, 5.59831,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2664.96631, 4029.90210, 5.94171,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2742.89575, 4029.83789, 5.54764,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2732.81030, 4023.11353, 5.17492,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2713.87866, 4026.01660, 4.92998,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2684.76001, 4020.76587, 4.08869,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2694.57056, 4032.13647, 5.62219,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2680.80493, 4027.31836, 5.46274,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2735.21973, 4033.44629, 4.74981,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(671, -2705.26416, 4034.76904, 5.48104,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(671, -2719.73438, 4033.50171, 5.48104,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(671, -2674.26416, 4030.54346, 5.48104,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(671, -2649.84229, 4031.31738, 4.80940,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8886, -2709.37549, 4119.08301, 9.86829,   0.00000, 0.00000, 40.98001);
	CreateDynamicObject(8886, -2704.82324, 4114.36963, 6.37818,   0.00000, 0.00000, 40.98001);
	CreateDynamicObject(2934, -2701.95898, 4123.51074, 7.55897,   0.00000, 0.00000, 9.12000);
	CreateDynamicObject(2934, -2697.17871, 4116.04395, 7.92732,   0.00000, 0.00000, -17.21999);
	CreateDynamicObject(2934, -2716.93457, 4111.38281, 7.97783,   0.00000, 0.00000, -140.45995);
	CreateDynamicObject(17030, -2734.94653, 4165.33740, 5.71774,   0.00000, 0.00000, 58.80002);
	CreateDynamicObject(17030, -2604.67627, 4138.11133, 7.38973,   0.00000, 0.00000, 147.77997);
	CreateDynamicObject(17030, -2690.22510, 4169.02100, 6.01800,   0.00000, 0.00000, -303.60001);
	CreateDynamicObject(17030, -2643.12329, 4170.11133, 5.31635,   0.00000, 0.00000, -308.93994);
	CreateDynamicObject(17030, -2601.96216, 4098.41455, 7.38973,   0.00000, 0.00000, 147.77997);
	CreateDynamicObject(17030, -2758.56030, 4148.33740, 7.46726,   0.00000, 0.00000, -47.81997);
	CreateDynamicObject(17030, -2761.00708, 4110.46875, 3.76271,   0.00000, 0.00000, -47.81997);
	CreateDynamicObject(17030, -2604.85840, 4086.16748, -0.02901,   0.00000, 0.00000, 147.77997);
	CreateDynamicObject(6295, -2640.55518, 4136.11084, 29.45396,   0.00000, 0.00000, 131.34003);
	CreateDynamicObject(12937, -2673.89844, 4141.67236, 9.10257,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19530, -2724.03760, 4142.28467, 6.59625,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19530, -2599.08667, 4142.10547, 6.59625,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2724.92407, 4142.11084, 5.08002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2703.96436, 4145.71045, 5.08002,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2658.67163, 4153.65283, 5.67586,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2628.90308, 4105.37695, 6.67006,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2731.83911, 4125.76855, 6.86198,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2693.82129, 4134.62500, 6.82617,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2660.28662, 4139.27637, 7.10419,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2713.59277, 4137.18652, 6.58956,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2630.61646, 4128.06982, 6.86198,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -2629.91187, 4114.35107, 7.49487,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2658.67163, 4153.65283, 5.67586,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(733, -2679.73242, 4153.43506, 5.08002,   0.00000, 0.00000, 0.00000);
	return 1;
}
public PUBG_OnGameModeExit()
{
    KillTimer(PUBG[Reduce]);
	return 1;
}
public PUBG_OnPlayerConnect(playerid)
{
	ResetPUBG(playerid);

    for(new i = 0; i < 10; i++)
   	RemovePlayerAttachedObject(playerid, i);

    pInventory[playerid][invSelectedSlot] = -1;
    pCharacter[playerid][charSelectedSlot] = -1;
    pPlayer[playerid][Language] = 2;

   	LoadPlayerTextDraws(playerid);
    eInfo[playerid][inPUBG] = 0;
    eInfo[playerid][pKills] = 0;
	return 1;
}
public PUBG_OnPlayerDisconnect(playerid,reason)
{
	if(pPlayer[playerid][MessageInventory])
	    KillTimer(pPlayer[playerid][MessageInventoryTimer]);

    ResetPUBG(playerid);
    if(eInfo[playerid][inPUBG] == 1)
    {
        LeavePUBG(playerid);
    }
	return 1;
}

public PUBG_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(eInfo[playerid][inPUBG] == 1)
	{
		new bool:valid_shot = true;
	 	new ammu_slot = GetAmmuSlot(playerid,weaponid);
		if(ammu_slot == -1)
		{
	 		for(new s = 3; s < 7; s ++)
			if(Itens[pCharacter[playerid][charSlot][s]][item_tipo] != ITEM_TYPE_MELEEWEAPON)
			if(pCharacter[playerid][charSlot][s] != 0)
			{
				AddItem(playerid, pCharacter[playerid][charSlot][s], 1);
				RemoveItemFromCharacter(playerid, s);
			}
			return false;
		}
		pInventory[playerid][invSlotAmount][GetAmmuSlot(playerid,weaponid)] --;
		SetPlayerAmmo(playerid, weaponid, GetAmmu(playerid,weaponid));
		if(GetAmmu(playerid,weaponid) <= 0)
		for(new s = 3; s < 7; s ++)
		{
			if(Itens[pCharacter[playerid][charSlot][s]][item_tipo] != ITEM_TYPE_MELEEWEAPON)
 			if(weaponid == GetWeaponIDFromModel(Itens[pCharacter[playerid][charSlot][s]][Item_Model]))
			{
 				AddItem(playerid, pCharacter[playerid][charSlot][s], 1);
				RemoveItemFromCharacter(playerid, s);
				valid_shot = false;
			}
		}
		if(pInventory[playerid][invSlotAmount][ammu_slot] <= 0) RemoveItemFromInventory(playerid, ammu_slot);
		if(valid_shot == false) return false;
	}
	return 1;
}

CMD:pubgplayers(playerid, params[])
{
	new string[125];
	if(PUBG[Start] == 0) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E"There is no PUBG Event going on");
	new count = 0;
	for(new i = 0; i < MAX_PLAYERS; i++ && IsPlayerConnected(i))
	{
		if(eInfo[i][inPUBG] == 1)
		{
			count++;
		    format(string,sizeof(string),"{AFAFAF}%d. %s(%d)" , count , GetName(i), i);
		    SendClientMessage(playerid,-1,string);
		}
	}
	format(string,sizeof(string),"{AFAFAF}Total players: %d" , count);
	SendClientMessage(playerid,-1,string);
    return 1;
}

CMD:leavepubg(playerid,params[])
{
	if(eInfo[playerid][inPUBG] == 0) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" You are not in a event");
	LeavePUBG(playerid);
    return 1;
}


CMD:pubg(playerid)
{
	if(eInfo[playerid][inPUBG] == 1) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" You are already in a PUBG event");
	if(PUBG[Start] == 2) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" The PUBG event has already started!");
	if(PUBG[Start] == 0) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E"There is no PUBG Event going on!");
	if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] == 13) return Error(playerid, "Leave the CnR minigame before joining a DM! "RED_E"/leave.");
	if(doingStunt[playerid] != 0) return Error(playerid, "Teleport out of this stunt area before joining a DM!");
    if(GOD[playerid] == 1) SetPVarInt(playerid, "HadGod", 1);
	SavePlayerPosition(playerid);
	ResetPlayerWeapons(playerid);
	InDM[playerid] = 49;
	IsInHouse{playerid} = 0;
	doingStunt[playerid] = 0;
	GodModeLabel(playerid, false);
	SetPlayerHealth(playerid, 100.0);
	eInfo[playerid][inPUBG] = 1;
	eInfo[playerid][pKills] = 0;
 	JoinPUBG(playerid);
 	RemovePUBGItems(playerid);
	SetPVarInt(playerid, "toysDisabled", 0);
	RemoveItems(playerid);
	SetPVarInt(playerid, "oldColor", GetPlayerColor(playerid));
	foreach(new ii : Player)
	{
	    SetPlayerColor(playerid,0xFFFFFF00);
		SetPlayerMarkerForPlayer(ii,playerid,0xFFFFFF00);
	}
	GodModeLabel(playerid, false);
	canUseKey[playerid] = false;
	TextDrawHideForPlayer(playerid, Server_TD[0]);
	TextDrawHideForPlayer(playerid, Server_TD[1]);
	TextDrawHideForPlayer(playerid, Server_TD[2]);
	TextDrawHideForPlayer(playerid, Server_TD[3]);
	TextDrawHideForPlayer(playerid, Server_TD[4]);
	TextDrawHideForPlayer(playerid, Server_TD[5]);
	TextDrawHideForPlayer(playerid, Server_TD[6]);
    return 1;
}
CMD:pchat(playerid, params[])
{
	if(eInfo[playerid][inPUBG] == 0) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" You are not in a PUBG event");
	if(sscanf(params, "s[128]",params)) return SendClientMessage(playerid, -1, "[USAGE] /pchat [text]");
	new text[126];
	format(text,128,"{e2a234}[PUBG-CHAT]: {FFFFFF}%s(%d): %s" , GetName(playerid) , playerid , params);
	SendClientMessageToPUBG(-1,text);
    return 1;
}

CMD:endpubg(playerid, params[])
{
	if(pAdmin[playerid] < 1)
		if(!IsPlayerAdmin(playerid))
			return Error(playerid, "You are not authorized to use this command!");
	if(PUBG[Start] == 0) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E"There isn't any PUBG Event going on");
	SendClientMessageToAll(-1,"{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: PUBG Event has been ended by an administrator");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(eInfo[i][inPUBG] == 1)
		{
			KickFromPUBG(i);
		}
	}
	EndEvent(1);
    return 1;
}

CMD:startpubg(playerid, params[])
{
	if(pAdmin[playerid] < 1)
		if(!IsPlayerAdmin(playerid))
			return Error(playerid, "You are not authorized to use this command!");
	if(PUBG[Start] == 2) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" PUBG Event has already started");
	if(PUBG[Start] == 1) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" There is already a PUBG Event started");
	if(EventGoingOn == 1) return Error(playerid, "There is an event going on now, if you want to force end it, use: /endevent.");
	if(EventGoingOn == 2) return Error(playerid, "There is a derby going on now, if you want to force end it, use: /endderby.");
	if(EventGoingOn >= 3) return Error(playerid, "There is an event going on now.");
	if(CSEvent == true) return Error(playerid, "There is a event going on now.");
	if(EventDialogPlayer) return Error(playerid, "Someone is currently starting an event.");
	SendClientMessageToAll(-1,"{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: The PUBG has been started, type /pubg to participate [Min 4 players]");
	if(!pHidden[playerid]) format(str, sizeof(str), "{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: This PUBG Event was started by %s(%i)!", pName[playerid], playerid);
	else format(str, sizeof(str), "{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: This PUBG Event was started by an administrator.");
	SendClientMessageToAll(-1,str);
	StartPUBG();
	if(pHidden[playerid] == 0) format(line, sizeof(line), ""WHITEP_E"%s(%i) has started a "LG_E"PUBG Event!\n\n"LB2_E"Event starts in 30 seconds, click on 'join' to join the event.\nOtherwise click 'Cancel' to ignore this dialog.\n\n"WHITE_E"Would you like to join the event?", pName[playerid], playerid);
	else format(line, sizeof(line), ""WHITEP_E"PUBG Event has been started by an Administrator!\n\n"LB2_E"Event starts in 30 seconds, click on 'join' to join the event.\nOtherwise click 'Cancel' to ignore this dialog.\n\n"WHITE_E"Would you like to join the event?");
	foreach(new ii : Player)
	{
		if(canUseKey[ii] == true && pSpawned[ii] == 1 && doingStunt[ii] == 0 && pSpectating[ii] == -1 && cAFK[ii] < 30 && pEventDialog[playerid] && pJail[ii] == 0)
		{
			if(GetPVarInt(ii, "BadSports")) continue;
			ShowPlayerDialog(ii, PUBG_INVITE, DIALOG_STYLE_MSGBOX, ""LB2_E"EVENT - "WHITE_E"PUBG", line, "Join", "Cancel");
		}
	}
			
    return 1;
}

CMD:spawnpackage(playerid, params[])
{
	if(pAdmin[playerid] < 3)
		if(!IsPlayerAdmin(playerid))
			return Error(playerid, "You are not authorized to use this command!");
	if(PUBG[Start] == 0) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" There isn't any PUBG event started");
	if(PUBG[Start] == 1) return SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" You can't create it here.");
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z);
	CreateCarePackageForPlayer(Float:X,Float:Y,Float:Z);
    return 1;
}

CMD:pubghelp(playerid, params[])
{
	new string[1400];
	strcat(string, ""LRED_E"PUBG Info\n"WHITE_E"- The Zone in PUBG Minigame shrinks every 70 seconds\n- You need to stay in the safe zone or else you'll loose your health\n\n\
	"LRED_E"Care Package in PUBG\n"WHITE_E"-The Care Package spawns randomly inside the safe zone\n-Care Package contains rare items.\n\n"LRED_E"PUBG Keys\n"WHITE_E"- To access your inventory press ' Y ' key\n- To pickup an item use ' LEFT ALT ' key\
	\n\n"LRED_E"Ammunations in PUBG\n"WHITE_E"- Pistol Ammo - Used for pistols\n- .45 ACP Ammo - Used for SMGs\n12 Gauge Ammo - Used for shotguns\n- 7.62mm - Used for Assault Rifles\n.300 Magnum - Used for Rifles\n\
	\n"LRED_E"PUBG Commands\n"WHITE_E"- /pubgplayers - To check Alive players in PUBG\n- /PChat - To chat with other PUBG players");
	

/*	strcat(string, "{FF0000}* Game Info\n\n");
	strcat(string, "{FFFFFF}The PUBG zone will shrink every 70 seconds,.\n");
	strcat(string, "{FFFFFF}You need to stay away from it, Or you'll loose hp\n");
	strcat(string, "{FF0000}* Care Package Info\n\n");
	strcat(string, "{FFFFFF}The care package are spawned randomly, Dropped by a plane in the battle field\n");
	strcat(string, "{FFFFFF}Care package contains rare items, Loot them and get the Chicken Dinner\n");
	strcat(string, "{FF0000}* Keys Info\n\n");
	strcat(string, "{FFFFFF}- You can access your inventory using ' Y ' key.\n");
	strcat(string, "{FFFFFF}- You can pick an Item by pressing Left ALT.\n");
	strcat(string, "{FFFFFF}*Ammmunation types.\n\n");
	strcat(string, "{FFFFFF}- Pistol Ammo   - Used for pistols\n");
	strcat(string, "{FFFFFF}- .45 ACP Ammo  - Used for SMGs\n");
	strcat(string, "{FFFFFF}- 12 Gauge Ammo - Used for all shotguns\n");
	strcat(string, "{FFFFFF}- 7.62mm Ammo   - Used for all Assault Rifles\n");
	strcat(string, "{FFFFFF}- .300 Magnum   - Used for Sniper rifle and Country rifle\n\n");
	strcat(string, ""grey1"- You can always use /pubgplayers to check PUBG players..\n");*/
	ShowPlayerDialog(playerid, NO_DIALOG , DIALOG_STYLE_MSGBOX, ""ORANGE_E"Server: "WHITE_E"PUBG Help", string, "Okay", "");
    return 1;
}

CMD:giveitem(playerid, params[])
{
	if(pAdmin[playerid] < 3)
		if(!IsPlayerAdmin(playerid))
			return Error(playerid, "You are not authorized to use this command!");
	new id, item, amount;
	if(sscanf(params, "uii", id, item, amount)) return SendClientMessage(playerid, -1, "/giveitem <playerid> <item id> <quantity>");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "{FF0000}ERROR: "GREY2_E"Player not connected.");
	if(IsItemInInventory(id, item, amount)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: "GREY2_E"Player already has that item.");
	if(IsInventoryFull(playerid)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: "GREY2_E"Player inventory is full !.");
	if(item == 24)
	{
		AddItem(id, item, amount , 25.0);
	}
	if(item == 6)
	{
		AddItem(id, item, amount , 50.0);
	}
	if(item == 25)
	{
		AddItem(id, item, amount , 97.0);
	}
	if(item != 24 && item != 25 && item != 6)
	{
		AddItem(id, item, amount);
	}
	format(String, sizeof(String), ""RED_E"[Server] "YELLOW_E" You've given item id (%d) to %s(%d), Quantity(%d)", item, GetName(id), amount);
	SendClientMessage(playerid, -1, String);
	return true;
}

Translate(language, text_PT[], text_EN[])
{
    new string[256];

    if(language == 1)
        format(string, sizeof(string), text_PT);
    else if(language == 2)
        format(string, sizeof(string), text_EN);

    return string;
}
ConvertToGameText(in[])
{
    new string[256];
    for(new i = 0; in[i]; ++i)
    {
        string[i] = in[i];
        switch(string[i])
        {
            case 0xC0 .. 0xC3: string[i] -= 0x40;
            case 0xC7 .. 0xC9: string[i] -= 0x42;
            case 0xD2 .. 0xD5: string[i] -= 0x44;
            case 0xD9 .. 0xDC: string[i] -= 0x47;
            case 0xE0 .. 0xE3: string[i] -= 0x49;
            case 0xE7 .. 0xEF: string[i] -= 0x4B;
            case 0xF2 .. 0xF5: string[i] -= 0x4D;
            case 0xF9 .. 0xFC: string[i] -= 0x50;
            case 0xC4, 0xE4: string[i] = 0x83;
            case 0xC6, 0xE6: string[i] = 0x84;
            case 0xD6, 0xF6: string[i] = 0x91;
            case 0xD1, 0xF1: string[i] = 0xEC;
            case 0xDF: string[i] = 0x96;
            case 0xBF: string[i] = 0xAF;
        }
    }
    return string;
}

SendClientMessageToPUBG(color,text[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(eInfo[i][inPUBG] == 1)
	    {
			SendClientMessage(i, color , text);
		}
	}
}
CheckForPlayers()
{
	if(PUBG[Players] <= 0)
	{
	    EndEvent(0);
	}
}
EndEvent(type)
{
	reductionIndex = 0;
	PUBG[Seconds] = 60;
	PUBG[Minutes] = 19;
    GangZoneDestroy(redForcefield[0]);
    GangZoneDestroy(redForcefield[1]);
    GangZoneDestroy(redForcefield[2]);
    GangZoneDestroy(redForcefield[3]);
    GangZoneDestroy(whiteForcefield[0]);
    GangZoneDestroy(whiteForcefield[1]);
    GangZoneDestroy(whiteForcefield[2]);
    GangZoneDestroy(whiteForcefield[3]);

	ForceField_Exit();
    PUBG[GasON] = 0;
    PUBG[GasPart] = 0;
	PUBG[Time] = 30;
	PUBG[pRange] = 280;
	KillTimer(PUBG[Reduce]);
	KillTimer(PUBG[Reduce]);
	KillTimer(PUBG[Island]);
	PUBG[Start] = 0;
	PUBG[Players] = 0;
	PUBG[TotalJoined] = 0;
	PUBG[CTime] = 0;
	if(type == 0)
	{
	    SendClientMessageToAll(-1,"{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: The event has been ended !");
	}
}

StartPUBG()
{
	TextDrawSetString(InfoTD2, "~y~PUBG ~w~Event has started! To join type: ~r~/pubg");
	TextDrawShowForAll(InfoTD2);
	SetTimer("HideInfoTD", 4000, false);
	//TextDrawHideForAll(PUBG_NAME[0]);
	PUBG[Seconds] = 0;
	PUBG[Minutes] = 0;
	PUBG[GasPart] = 0;
	PUBG[GasON] = 0;
	PUBG[Start] = 1;
	PUBG[pRange] = 280;
	PUBG[Time] = 30;
	PUBG[TotalJoined] = 0;
	KillTimer(PUBG[Reduce]);
	KillTimer(PUBG[Island]);
	PUBG[Island] = SetTimer("IslandTime", 1000 , true);
	for(new i = 0; i < MAX_CARE_PACKAGES; i++) // MAX_ITENS_WORLD
    {
 		DestroyPackage(i);
    }
   	for(new i = 0; i < MAX_ITENS_WORLD; i++) // MAX_ITENS_WORLD
    {
        if(ItensWorld[i][world_active]) DeleteItemWorld(i);
    }
   	for(new i = 0; i < 12; i++)
    {
   		new rand[] = {2,3,9,10,13,14,15,21,22};
   		new size = sizeof(rand);
   		new randn = random(size);
   		new itemid = rand[randn];
     	DropItem2(TableInfo[i][ItemX], TableInfo[i][ItemY], TableInfo[i][ItemZ], itemid, 1 );
		DropItem2(TableInfo[i][ItemX]+1, TableInfo[i][ItemY], TableInfo[i][ItemZ], GetTypeFromID(GetWeaponIDFromModel(Itens[itemid][Item_Model])) , randomEx(15,30));
	}
	for(new i = 0; i < 31; i++) // MAX_ITENS_WORLD
    {
//   		DeleteItemWorld(i);
//    	new itemid = randomEx(1,23);
   		new rand[] = {1,24,7,11,12,28,29,29,28,30,31,32,33,34,35};
   		new size = sizeof(rand);
   		new randn = random(size);
   		new itemid = rand[randn];
// 1 - helmet , 4 Ammunition , 6 Armor , 7 average and 8 Large backpack , 12 Night stick

 		if(itemid == 24)
		{
			DropItem(ItemInfo[i][ItemX], ItemInfo[i][ItemY], ItemInfo[i][ItemZ], itemid, 1 , 25);
		}
		if(itemid == 4)
		{
			DropItem(ItemInfo[i][ItemX], ItemInfo[i][ItemY], ItemInfo[i][ItemZ], itemid, randomEx(25,75));
		}
 		if(Itens[itemid][item_tipo] == ITEM_TYPE_AMMO && itemid != 24 && itemid != 4 && itemid != 32)
     	{
			DropItem(ItemInfo[i][ItemX], ItemInfo[i][ItemY], ItemInfo[i][ItemZ], itemid , randomEx(30,60));
		}
 		if(Itens[itemid][item_tipo] == ITEM_TYPE_AMMO && itemid != 24 && itemid != 4 && itemid == 32)
     	{
			DropItem(ItemInfo[i][ItemX], ItemInfo[i][ItemY], ItemInfo[i][ItemZ], itemid , randomEx(10,30));
		}
		if(itemid != 24 && itemid !=4 && Itens[itemid][item_tipo] != ITEM_TYPE_AMMO)
		{
 			DropItem(ItemInfo[i][ItemX], ItemInfo[i][ItemY], ItemInfo[i][ItemZ], itemid, 1 );
 		}
	}
	for(new i = 0; i < 30; i++) // MAX_ITENS_WORLD
    {
   		new rand[] = {2,3,5,9,10,13,14,15,17,21,20,22,23};
   		new size = sizeof(rand);
   		new randn = random(size);
   		new itemid = rand[randn];
     	DropItem(WItemInfo[i][ItemX], WItemInfo[i][ItemY], WItemInfo[i][ItemZ], itemid, 1 );
		if(itemid != 5 && itemid != 17 && itemid != 23)
		{
			DropItem(WItemInfo[i][ItemX]+1, WItemInfo[i][ItemY], WItemInfo[i][ItemZ], GetTypeFromID(GetWeaponIDFromModel(Itens[itemid][Item_Model])) , randomEx(20,50));
		}
	}
	for(new i = 0; i < 13; i++) // MAX_ITENS_WORLD
    {
   		new rand[] = {6,16,18,19,8,26};
   		new size = sizeof(rand);
   		new randn = random(size);
   		new itemid = rand[randn];
		if(itemid == 6)
		{
			DropItem(ItemInfo[i][ItemX], ItemInfo[i][ItemY], ItemInfo[i][ItemZ], itemid, 1 , 50);
		}
		else if(Itens[itemid][item_tipo] == ITEM_TYPE_WEAPON && itemid != 32)
		{
		    DropItem(RareItemInfo[i][ItemX]+1, RareItemInfo[i][ItemY], RareItemInfo[i][ItemZ], GetTypeFromID(GetWeaponIDFromModel(Itens[itemid][Item_Model])), randomEx(20,30));
		}
 		else if(Itens[itemid][item_tipo] == ITEM_TYPE_WEAPON && itemid == 32)
		{
		    DropItem(RareItemInfo[i][ItemX]+1, RareItemInfo[i][ItemY], RareItemInfo[i][ItemZ], GetTypeFromID(GetWeaponIDFromModel(Itens[itemid][Item_Model])), randomEx(10,30));
		}
		if(itemid != 6)
		{
			DropItem(RareItemInfo[i][ItemX], RareItemInfo[i][ItemY], RareItemInfo[i][ItemZ], itemid, 1 );

		}
	}
	return 1;
}
public IslandTime()
{
	PUBG[Time]--;
	CountPlayers();
	new string[50];
	format(string,50,"Starting in ~n~%d", PUBG[Time]);
	TextDrawSetString(Start_TD,string);
	ShowStartTD();
	if(PUBG[Time] <= 0)
	{
		if(PUBG[Players] < 4)
		{
		    EndEvent(1);
		    SendClientMessageToAll(-1,"{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: PUBG canceled due to lack of players! [Min 4 players]");
  			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(eInfo[i][inPUBG] == 1)
			    {
		    		KickFromPUBG(i);
				}
			}
		    KillTimer(PUBG[Island]);
		    return 1;
		}
    	for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(eInfo[i][inPUBG] == 1)
		    {
		        SetPlayerHealth(i,100.0);
   				RemovePUBGItems(i);
   				SetPlayerHealth(i,100.0);
	    		StartForPlayersPUBG(i);
	    		SetPlayerHealth(i,100.0);
    			GivePlayerWeapon(i,46,1);
    			SetPlayerHealth(i,100.0);
			}
		}
		HideStartTD();
		PUBG[CTime] = TIME_TO_RESTRICT;
		PUBG[Start] = 2;
		PUBG[TotalJoined] = PUBG[Players];
     	KillTimer(PUBG[Island]);
     	ForceField_Init(1006, 16, 1600, 543 , 1067, 77, 1542, 481);
	}
	return 1;

}
JoinPUBG(playerid)
{
	SendClientMessage(playerid,-1,"{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: New in PUBG? Check /pubghelp");
	eInfo[playerid][inPUBG] = 1;
	new rand = random(sizeof(gRandomSpawns11));
	SetPlayerPos(playerid, gRandomSpawns11[rand][0], gRandomSpawns11[rand][1], gRandomSpawns11[rand][2]);
	SetPlayerFacingAngle(playerid, gRandomSpawns11[rand][3]);
	//////////////////////////////////////

	PUBG[Players]++;
	SetPlayerVirtualWorld(playerid,PUBG_WORLD+1);
	SetPlayerInterior(playerid,0);
	SetPlayerHealth(playerid,99999);
	ShowPUBGTDs(playerid);
}
StartForPlayersPUBG(playerid)
{
    eInfo[playerid][inPUBG] = 1;
    eInfo[playerid][pKills] = 0;
    new Random = random(sizeof(SpawnInfo));
	SetPlayerPos(playerid, SpawnInfo[Random][PosX], SpawnInfo[Random][PosY],SpawnInfo[Random][PosZ]);
	GivePlayerWeapon(playerid, 46, 1);
	SetPlayerVirtualWorld(playerid,PUBG_WORLD);
	SetPlayerHealth(playerid,100.0);
}
KickFromPUBG(playerid)
{
	HIDEPUBGTDs(playerid);
	eInfo[playerid][pKills] = 0;
	eInfo[playerid][inPUBG] = 0;
	TextDrawHideForPlayer(playerid,Start_TD);
	TextDrawHideForPlayer(playerid,Restrict_TD);
	SetPlayerVirtualWorld(playerid,0);
	InDM[playerid] = 0;
	SetPlayerPosOnSpawn(playerid);
	SetPlayerColor(playerid,GetPVarInt(playerid, "oldColor"));
	foreach(new ii : Player)
	{
		SetPlayerMarkerForPlayer(ii,playerid,GetPVarInt(playerid, "oldColor"));
	}
	RemovePUBGItems(playerid,1);
	if(GetPVarInt(playerid, "toysDisabled") == 0)
	{
 		AttachPlayerToys(playerid);
	}
	TextDrawShowForPlayer(playerid, Server_TD[0]);
	TextDrawShowForPlayer(playerid, Server_TD[1]);
	TextDrawShowForPlayer(playerid, Server_TD[2]);
	TextDrawShowForPlayer(playerid, Server_TD[3]);
	TextDrawShowForPlayer(playerid, Server_TD[4]);
	TextDrawShowForPlayer(playerid, Server_TD[5]);
	TextDrawShowForPlayer(playerid, Server_TD[6]);
}
LeavePUBG(playerid)
{
	TextDrawShowForPlayer(playerid, Server_TD[0]);
	TextDrawShowForPlayer(playerid, Server_TD[1]);
	TextDrawShowForPlayer(playerid, Server_TD[2]);
	TextDrawShowForPlayer(playerid, Server_TD[3]);
	TextDrawShowForPlayer(playerid, Server_TD[4]);
	TextDrawShowForPlayer(playerid, Server_TD[5]);
	TextDrawShowForPlayer(playerid, Server_TD[6]);
    GodModeLabel(playerid, true);
	canUseKey[playerid] = true;
	SetPlayerColor(playerid,GetPVarInt(playerid, "oldColor"));
	foreach(new ii : Player)
	{
		SetPlayerMarkerForPlayer(ii,playerid,GetPVarInt(playerid, "oldColor"));
	}
	//SendClientMessage(playerid,-1,""RED_E"[Server] "YELLOW_E"You")
	InDM[playerid] = 0;
	SetPlayerPosOnSpawn(playerid);
 	new winner = -1;
 	HIDEPUBGTDs(playerid);
	PUBG[Players]--;
	eInfo[playerid][pKills] = 0;
	TextDrawHideForPlayer(playerid,Start_TD);
	TextDrawHideForPlayer(playerid,Restrict_TD);
	SetPlayerVirtualWorld(playerid,0);

	if(eInfo[playerid][inPUBG] == 1 && PUBG[Start] == 2)
	{
 	   	CheckForPlayers();
	    eInfo[playerid][inPUBG] = 0;
		if(PUBG[Players] == 1)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
  			  	if(IsPlayerConnected(i))
				{
				   	if(eInfo[i][inPUBG] == 1)
    				{
       				 	winner = i;
		        		//printf("%d 3 " , winner);
      					break;
					}
    			}
			}
			if(winner != -1) KillTimer(PUBG[Reduce]);
			{
			    new Reward;
				switch(PUBG[Players])
				{
					case 1: Reward = 50000;
					case 2: Reward = 30000;
					case 3: Reward = 20000;
					case 4: Reward = 10000;
					case 5: Reward = 10000;
					case 6: Reward = 0;
					case 7: Reward = 0;
					case 8..10: Reward = 0;
					default: Reward = 0;
				}
			 	Reward += (eInfo[playerid][pKills]*3000);
				new string[124];
				format(string,sizeof(string),"{F0F0F0}[{FF000F}PUBG{F0F0F0}] {15D4ED}%s(%d) won the PUBG! {FFE600}Prize: $%s , 10 score and 10 cookies!" , GetName(winner),winner,ToCurrency(Reward));
				SendClientMessageToAll(-1,string);
				UpdateGroupScore(pGroupID[winner], 4);
				SHOWDIEDTDs(winner , 1);
				PUBG_Wins[winner]++;
				SpawnPlayer(winner);
				RemovePUBGItems(winner,1);
			   	if(GetPVarInt(winner, "toysDisabled") == 0)
				{
				    AttachPlayerToys(winner);
				}


				LeavePUBG(winner);
				GivePlayerCash(winner,Reward);
				GivePlayerScore(winner,10);
				GivePlayerCookie(winner, 10);
				GangZoneHideForPlayer(winner,redForcefield[0]);
				GangZoneHideForPlayer(winner,redForcefield[1]);
				GangZoneHideForPlayer(winner,redForcefield[2]);
				GangZoneHideForPlayer(winner,redForcefield[3]);
				GangZoneHideForPlayer(winner,whiteForcefield[0]);
				GangZoneHideForPlayer(winner,whiteForcefield[1]);
				GangZoneHideForPlayer(winner,whiteForcefield[2]);
				GangZoneHideForPlayer(winner,whiteForcefield[3]);
				EndEvent(1);
				DropAll(winner);
				eInfo[winner][inPUBG] = 0;
				TextDrawHideForPlayer(winner,Start_TD);
				TextDrawHideForPlayer(winner,Restrict_TD);
				SetPlayerVirtualWorld(winner,0);
	
			}
		}
 	}
	DropAll(playerid);
	eInfo[playerid][inPUBG] = 0;
	TextDrawHideForPlayer(playerid,Start_TD);
	TextDrawHideForPlayer(playerid,Restrict_TD);
	SetPlayerVirtualWorld(playerid,0);
	GangZoneHideForPlayer(winner,redForcefield[0]);
	GangZoneHideForPlayer(winner,redForcefield[1]);
	GangZoneHideForPlayer(winner,redForcefield[2]);
	GangZoneHideForPlayer(winner,redForcefield[3]);
	GangZoneHideForPlayer(winner,whiteForcefield[0]);
	GangZoneHideForPlayer(winner,whiteForcefield[1]);
	GangZoneHideForPlayer(winner,whiteForcefield[2]);
	GangZoneHideForPlayer(winner,whiteForcefield[3]);
	RemovePUBGItems(playerid,1);
	if(GetPVarInt(playerid, "toysDisabled") == 0)
	{
 		AttachPlayerToys(playerid);
	}
}
CreateCarePackageForPlayer(Float:X,Float:Y,Float:Z) {
	new carepackid;
	for(new i = 0; i < MAX_CARE_PACKAGES; i++) {
	    if(pCarePackage[i][CarePackageUsed] == false) {
	        carepackid = i;
	        break;
	    }
	    if( i == MAX_CARE_PACKAGES-1) {
			return 0;
	    }
	}
	Iter_Add(CarePackages,carepackid);
	new angle = random(360);
	pCarePackage[carepackid][CarePackageUsed] = true;
	pCarePackage[carepackid][PlaneMoveStage] = false;
	pCarePackage[carepackid][CarePackageFlare] = CreateDynamicObject(18728,X,Y,Z-2,0,0,0,PUBG_WORLD,-1,-1,250,250);
	pCarePackage[carepackid][CarePackageLand][0] = X;
    pCarePackage[carepackid][CarePackageLand][1] = Y;
    pCarePackage[carepackid][CarePackageLand][2] = Z-1.5; // -1.5
    pCarePackage[carepackid][CarePackageRotation] = angle;
    new rand = random(6);
    switch(rand)
    {
    	case 0:
	    {
		    PackageSlots[carepackid][0] = 16; // sniper
		    PackageSlots[carepackid][1] = 18; // medkit
		    PackageSlots[carepackid][2] = 19; /// sawed off
		    PackageSlots[carepackid][3] = 33;  //sawed ammu
		    PackageSlots[carepackid][4] = 32; // ammu
		}
     	case 1:
	    {
		    PackageSlots[carepackid][0] = 3; // M4
		    PackageSlots[carepackid][1] = 18; // medkit
		    PackageSlots[carepackid][2] = 31;/// m4 ammo
		    PackageSlots[carepackid][3] = 7; //average backpack
		    PackageSlots[carepackid][4] = 25; // armor
		}
     	case 2:
	    {
		    PackageSlots[carepackid][0] = 32; // helmet III
		    PackageSlots[carepackid][1] = 18; // medkit
		    PackageSlots[carepackid][2] = 20;/// night stick
		    PackageSlots[carepackid][3] = 7; //average backpack
		    PackageSlots[carepackid][4] = 33; // sawed ammu
		}
     	case 3:
	    {
		    PackageSlots[carepackid][0] = 9; // ak
		    PackageSlots[carepackid][1] = 18; // medkit
		    PackageSlots[carepackid][2] = 24;/// armor I
		    PackageSlots[carepackid][3] = 27; //helmet III
		    PackageSlots[carepackid][4] = 31; // assault ammo
		}
     	case 4:
	    {
		    PackageSlots[carepackid][0] = 32; // rifle ammo
		    PackageSlots[carepackid][1] = 21; // deagle
		    PackageSlots[carepackid][2] = 18;/// medkit
		    PackageSlots[carepackid][3] = 25; //armor III
		    PackageSlots[carepackid][4] = 7; // backpack I
		}
      	case 5:
	    {
		    PackageSlots[carepackid][0] = 32; // rifle ammo
		    PackageSlots[carepackid][1] = 16; // sniper
		    PackageSlots[carepackid][2] = 29;/// bandage
		    PackageSlots[carepackid][3] = 26; //level II
		    PackageSlots[carepackid][4] = 8; // backpack III
		}
       	case 6:
	    {
		    PackageSlots[carepackid][0] = 15; // mp5
		    PackageSlots[carepackid][1] = 34; // mp5 ammo
		    PackageSlots[carepackid][2] = 29;/// bandage
		    PackageSlots[carepackid][3] = 26; //level II
		    PackageSlots[carepackid][4] = 8; // backpack III
		}
       	case 7:
	    {
		    PackageSlots[carepackid][0] = 3; // AK
		    PackageSlots[carepackid][1] = 9; // M4
		    PackageSlots[carepackid][2] = 31;/// ASSAULT AMMO
		    PackageSlots[carepackid][3] = 27; //level III armor
		    PackageSlots[carepackid][4] = 31; // ammo III
		}
	}
    pCarePackage[carepackid][CarePackageInterior] = -1;
    pCarePackage[carepackid][CarePackageWorld] = PUBG_WORLD;
    GetXYFromPosWithAngle(X,Y,angle,300); // 14553
    pCarePackage[carepackid][CarePackagePlane] = CreateDynamicObject(14553,X,Y,Z+50,11.9,0,-angle,PUBG_WORLD,-1,-1,500,500);
    MoveDynamicObject(pCarePackage[carepackid][CarePackagePlane], pCarePackage[carepackid][CarePackageLand][0], pCarePackage[carepackid][CarePackageLand][1], pCarePackage[carepackid][CarePackageLand][2]+100, 30, 11.9, 0, -angle);
	foreach(new b : Player) Streamer_Update(b);
	pCarePackage[carepackid][CarePackageLanded] = false;
	return 1;
}

forward DespawnCarePackage(i);
public DespawnCarePackage(i) {
    DestroyDynamicObject(pCarePackage[i][CarePackageBox]);
    Delete3DTextLabel(pCarePackage[i][CarePackageText]);
    pCarePackage[i][CarePackageBox] = -1;
	pCarePackage[i][CarePackageUsed] = false;
	pCarePackage[i][CarePackageLanded] = false;
	if(IsValidDynamicObject(pCarePackage[i][CarePackagePlane])) DestroyDynamicObject(pCarePackage[i][CarePackagePlane]);
	Iter_Remove(CarePackages,i);
	return 1;
}

GetXYFromPosWithAngle(&Float:x, &Float:y,Float:a,Float:distance) {
    x += (distance * floatsin(a, degrees));
    y += (distance * floatcos(a, degrees));
}
ShowPackage(playerid,cid)
{
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
    new pstr[500], listitems[1024], adm=0;
    for(new i = 0; i < 5; i++)
    {
        if(PackageSlots[cid][i] != 0)
        {
            PackageToTake[playerid][adm] = i;
            adm++;
		    format(pstr, sizeof(pstr), "%s\n", Itens[PackageSlots[cid][i]][item_nome]);
		    strcat(listitems,pstr);

		}
	}
	TakenCarePackage[playerid] = cid;
    if(adm == 0) return SendClientMessage(playerid,-1,"{FF0000}[CARE-PACKAGE] "GREY2_E"This care package is empty now");
    ShowPlayerDialog(playerid,DIALOG_TAKECARE,DIALOG_STYLE_LIST,"{FF0000}Care Package",listitems,"Take","Quit");
    return 1;
}
DestroyPackage(i)
{
	KillTimer(CarePackageDespawnTimer[i]);
	DestroyDynamicObject(pCarePackage[i][CarePackageBox]);
	DestroyDynamicObject(pCarePackage[i][CarePackageFlare]);
 	pCarePackage[i][CarePackageFlare] = -1;
 	Delete3DTextLabel(pCarePackage[i][CarePackageText]);
 	pCarePackage[i][CarePackageBox] = -1;
	pCarePackage[i][CarePackageUsed] = false;
	pCarePackage[i][CarePackageLanded] = false;
	if(IsValidDynamicObject(pCarePackage[i][CarePackagePlane])) DestroyDynamicObject(pCarePackage[i][CarePackagePlane]);
	Iter_Remove(CarePackages,i);
	return 1;
}
ShowRestrictTD()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(eInfo[i][inPUBG] == 1)
	    {
			TextDrawShowForPlayer(i,Restrict_TD);
			SetTimer("HideRestrictTD", 2000 , false);
		}
	}
}
ShowRestrictTD2()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(eInfo[i][inPUBG] == 1)
	    {
			TextDrawShowForPlayer(i,Restrict_TD);
			SetTimer("HideRestrictTD", 5000 , false);
		}
	}
}
Equipment(playerid)
{
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
    new estr[600], listitems[1024], adm=0;
    strcat(listitems,"Name\tQuantity\n");
    for(new i = 0; i < MAX_ITENS_WORLD; i++)
    {
    	if(ItensWorld[i][world_active])
     	{
	        if(IsPlayerInRangeOfPoint(playerid, 2.0 , ItensWorld[i][world_position][0], ItensWorld[i][world_position][1], ItensWorld[i][world_position][2]))
	        {
            	ItemToTake[playerid][adm] = i;
	            adm ++;
	            format(estr, sizeof(estr), "%s\t%d\n", Itens[ItensWorld[i][world_itemid]][item_nome] , ItensWorld[i][world_amount]);
	            strcat(listitems,estr);
			}
        }
    }
    if(adm == 0) return 1;
    ShowPlayerDialog(playerid,DIALOG_TAKEINV,DIALOG_STYLE_TABLIST_HEADERS,"Take Item",listitems,"Take","Quit");
    return 1;
}
public HideRestrictTD()
{
	TextDrawHideForAll(Restrict_TD);
}
ShowPUBGTDs(playerid)
{
	TextDrawShowForPlayer(playerid,PUBG_TD[0]);
	TextDrawShowForPlayer(playerid,PUBG_TD[1]);
	TextDrawShowForPlayer(playerid,PUBG_TD[2]);
	PlayerTextDrawShow(playerid,PKILLS[playerid]);
	PlayerTextDrawSetString(playerid,PKILLS[playerid],"00");
}
HIDEPUBGTDs(playerid)
{
	TextDrawHideForPlayer(playerid,PUBG_TD[0]);
	TextDrawHideForPlayer(playerid,PUBG_TD[1]);
	TextDrawHideForPlayer(playerid,PUBG_TD[2]);
	PlayerTextDrawHide(playerid,PKILLS[playerid]);
}
SHOWDIEDTDs(playerid , winner)
{
	new rp = 10;
	switch(PUBG[Players])
	{
	    case 1: rp = 150;
	    case 2: rp = 100;
	    case 3: rp = 75;
	    case 4: rp = 50;
	    case 5: rp = 35;
	    case 6: rp = 20;
	    case 7: rp = 15;
	    case 8..10: rp = 10;
	    default: rp = 5;
	}
	foreach(new ii : Player)
	{
		ShowPlayerNameTagForPlayer(ii, playerid, true);
	}
	new string[512];

	for(new i = 0; i < 14; i++)
	{
		PlayerTextDrawShow(playerid,PUBG_DIED[playerid][i]);
	}
	format(string,sizeof(string),"%s" , GetName(playerid)); // name
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][1],string);

	if(winner == 1)
	{
		PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][2],"WINNER_WINNER_CHICKEN_DINNER!");
	}
	format(string,sizeof(string),"RANK %d" , PUBG[Players]);
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][3],string);

	format(string,sizeof(string),"KILL %d" , eInfo[playerid][pKills]);
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][4],string);

	format(string,sizeof(string),"REWARD GP ~y~%d",PUBG[Players]*50+eInfo[playerid][pKills]*50);
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][6],string);

	format(string,sizeof(string),"RANK_POINTS %d" , rp);
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][10],string);

	format(string,sizeof(string),"KILL_POINTS %d" , eInfo[playerid][pKills]*30);
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][11],string);

	format(string,sizeof(string),"#%d/" , PUBG[Players]);
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][12],string);
	format(string,sizeof(string),"%d" , PUBG[TotalJoined]);
	PlayerTextDrawSetString(playerid,PUBG_DIED[playerid][13],string);
	SetTimerEx("HIDEDIEDTDs", 6000 , false, "d", playerid);

	PUBG_KP[playerid]+=eInfo[playerid][pKills]*30;
	PUBG_RP[playerid]+=rp;
	mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE `players` SET `pubg_rankpoints`=%i WHERE `name` = '%e'",rp, pName[playerid]);
	MySQL_updateQuery(query);
}
forward HIDEDIEDTDs(playerid);
public HIDEDIEDTDs(playerid)
{
	for(new i = 0; i < 14; i++)
	{
		PlayerTextDrawHide(playerid,PUBG_DIED[playerid][i]);
	}
	TextDrawShowForPlayer(playerid, Server_TD[0]);
	TextDrawShowForPlayer(playerid, Server_TD[1]);
	TextDrawShowForPlayer(playerid, Server_TD[2]);
	TextDrawShowForPlayer(playerid, Server_TD[3]);
	TextDrawShowForPlayer(playerid, Server_TD[4]);
	TextDrawShowForPlayer(playerid, Server_TD[5]);
	TextDrawShowForPlayer(playerid, Server_TD[6]);
}
ShowStartTD()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(eInfo[i][inPUBG] == 1)
	    {
			TextDrawShowForPlayer(i,Start_TD);
		}
	}
}
HideStartTD()
{
	TextDrawHideForAll(Start_TD);
}
CountPlayers()
{
	new string[40];
	format(string,sizeof(string),"%d" , PUBG[Players]);
	if(PUBG[Players] < 10)
	{
	    format(string,sizeof(string),"0%d" , PUBG[Players]);
	}
	TextDrawSetString(PUBG_TD[1],string);
}

public PUBG_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(eInfo[playerid][inPUBG] == 1)
	{
		if(newkeys & KEY_YES)
		{
			if(!pPlayer[playerid][inInventory])
			ShowPUBGInventory(playerid);
		}
		if(newkeys & KEY_WALK) Equipment(playerid);
		if (newkeys & KEY_SECONDARY_ATTACK)
		{
			foreach(new i : CarePackages)
			{
				if(pCarePackage[i][CarePackageUsed] == true && pCarePackage[i][CarePackageLanded] == true)
				{
					if(IsPlayerInRangeOfPoint(playerid,2,pCarePackage[i][CarePackageLand][0], pCarePackage[i][CarePackageLand][1], pCarePackage[i][CarePackageLand][2]))
					{
						ShowPackage(playerid,i);
						break;
					}
				}
			}
		}
	}
	return 1;
}
public PUBG_OnPlayerClickPTextDraw(playerid, PlayerText:playertextid)
{
    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
    	if(playertextid == inventario_index[playerid][i])
    	{
    	    if(pInventory[playerid][invSlot][i] == 0)
    	        break;

    	    if(pInventory[playerid][invSelectedSlot] == i)
    	    {
    	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);
    	        pInventory[playerid][invSelectedSlot] = -1;
    	        PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
				PlayerTextDrawShow(playerid, inventario_index[playerid][i]);

				for(new a = 0; a < 4; a++)
		    		PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

                TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);

               	TextDrawHideForPlayer(playerid, inventario_usar);
				TextDrawHideForPlayer(playerid, inventario_split[0]);
				TextDrawHideForPlayer(playerid, inventario_split[1]);
				TextDrawHideForPlayer(playerid, inventario_drop[0]);
				TextDrawHideForPlayer(playerid, inventario_drop[1]);

				PlayerTextDrawHide(playerid, inventario_textos[playerid][9]);

				break;
			}
			else if(pInventory[playerid][invSelectedSlot] != -1)
			{
    	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][pInventory[playerid][invSelectedSlot]], 96);
    	        PlayerTextDrawHide(playerid, inventario_index[playerid][pInventory[playerid][invSelectedSlot]]);
				PlayerTextDrawShow(playerid, inventario_index[playerid][pInventory[playerid][invSelectedSlot]]);
			}

            PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 0xFFFFFF50);

			PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
			PlayerTextDrawShow(playerid, inventario_index[playerid][i]);


			PlayerTextDrawSetPreviewModel(playerid, inventario_description[playerid][0], Itens[pInventory[playerid][invSlot][i]][Item_Model]);
            PlayerTextDrawSetPreviewRot(playerid, inventario_description[playerid][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
            PlayerTextDrawShow(playerid, inventario_description[playerid][0]);

			PlayerTextDrawSetString(playerid, inventario_description[playerid][1], ConvertToGameText(Itens[pInventory[playerid][invSlot][i]][item_nome]));
			PlayerTextDrawSetString(playerid, inventario_description[playerid][2], ConvertToGameText(Itens[pInventory[playerid][invSlot][i]][item_description]));

			if(Itens[pInventory[playerid][invSlot][i]][item_tipo] == ITEM_TYPE_BODY)
			    format(String, sizeof(String), "%s: %.1f", Translate(pPlayer[playerid][Language], "Durabilidade", "Durability"), pInventory[playerid][invArmourStatus][i]);
			else if(pInventory[playerid][invSlotAmount][i] > 1)
				format(String, sizeof(String), "%s: %d", Translate(pPlayer[playerid][Language], "Quantidade", "Amount"), pInventory[playerid][invSlotAmount][i]);
			else
				String = " ";

			PlayerTextDrawSetString(playerid, inventario_description[playerid][3], String);

			if(pInventory[playerid][invSelectedSlot] == -1)
			{
	            TextDrawShowForPlayer(playerid, inventario_usar);
			    TextDrawShowForPlayer(playerid, inventario_split[0]);
			    TextDrawShowForPlayer(playerid, inventario_split[1]);
			    TextDrawShowForPlayer(playerid, inventario_drop[0]);
			    TextDrawShowForPlayer(playerid, inventario_drop[1]);
			    PlayerTextDrawShow(playerid, inventario_textos[playerid][9]);

			    for(new a = 0; a < 4; a++)
    				PlayerTextDrawShow(playerid, inventario_description[playerid][a]);

                TextDrawShowForPlayer(playerid, inventario_backgrounds[4]);
			}

		    pInventory[playerid][invSelectedSlot] = i;
			break;
    	}

    for(new i = 0; i < 7; i++)
    	if(playertextid == inventario_personagemindex[playerid][i])
		{
		    if(pCharacter[playerid][charSlot][i] == 0)
    	        break;

		    if(pCharacter[playerid][charSelectedSlot] == i)
    	    {
    	        PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][i], 96);
    	        PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][i]);
				PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][i]);
    	        pCharacter[playerid][charSelectedSlot] = -1;

				PlayerTextDrawHide(playerid, inventario_textos[playerid][10]);
				TextDrawHideForPlayer(playerid, inventario_remover);
				break;
    	    }
    	    else if(pCharacter[playerid][charSelectedSlot] != -1)
    	    {
    	        new char_slot = pCharacter[playerid][charSelectedSlot];
    	        PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][char_slot], 96);
    	        PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][char_slot]);
				PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][char_slot]);
    	    }

		    PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][i], 0xFFFFFF50);
			PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][i]);
			PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][i]);

			if(pCharacter[playerid][charSelectedSlot] == -1)
			{
				PlayerTextDrawShow(playerid, inventario_textos[playerid][10]);
				TextDrawShowForPlayer(playerid, inventario_remover);
			}

			pCharacter[playerid][charSelectedSlot] = i;
			break;
		}

	return 1;
}
public PUBG_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == PUBG_INVITE)
	{
		if(response)
		{
			if(PUBG[Start] == 0) return Error(playerid, "There is no PUBG Event going on!");
			if(PUBG[Start] == 2) return Error(playerid, "PUBG event is already started!");
			cmd_pubg(playerid);
		}
	}
 	if(dialogid == DIALOG_TAKEINV)
    {
        new i = ItemToTake[playerid][listitem];
        if(response)
        {
        	new bool:sucess = false;
        	if(!ItensWorld[i][world_active]) return SendClientMessage(playerid,-1,"{FF0000}[Server]{FFFFFF} There was a problem taking that item,");
	        if(!IsPlayerInRangeOfPoint(playerid, 5.0 , ItensWorld[i][world_position][0], ItensWorld[i][world_position][1], ItensWorld[i][world_position][2])) return SendClientMessage(playerid,-1,"{FF0000}[Server]{FFFFFF} There was a problem taking that item,");
			if(!IsInventoryFull(playerid))
   			{
      			AddItem(playerid, ItensWorld[i][world_itemid], ItensWorld[i][world_amount], ItensWorld[i][world_armourstatus]);
         		DeleteItemWorld(i);
           		sucess = true;
			}
			if(!sucess)
   			for(new a = 0; a < GetSlotsInventory(playerid); a ++)
			if(pInventory[playerid][invSlot][a] == ItensWorld[i][world_itemid])
   			if(Itens[ItensWorld[i][world_itemid]][item_limite] >= ItensWorld[i][world_amount]+pInventory[playerid][invSlotAmount][a])
			{
   				AddItem(playerid, ItensWorld[i][world_itemid], ItensWorld[i][world_amount], ItensWorld[i][world_armourstatus]);
   				DeleteItemWorld(i);
   				sucess = true;
				return 1;
			}
			if(!sucess)
			ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Seu inventário está cheio.",
			"~r~ERROR: ~w~Your inventory is full."));
  			Equipment(playerid);
			return 1;
		}
        return 1;
	}
 	if(dialogid == DIALOG_TAKECARE)
    {
        if(response)
        {
        	new bool:sucess = false;
        	new i = PackageToTake[playerid][listitem];
			new b = TakenCarePackage[playerid];
  			if(PackageSlots[b][i] == 0) return SendClientMessage(playerid,-1,"{FF0000}[Server]{FFFFFF} There was a problem taking that item,");
			if(!IsInventoryFull(playerid))
   			{
   			    if(PackageSlots[b][i] == 4)
   			    {
      				AddItem(playerid, PackageSlots[b][i], randomEx(50,70));
				}
				else if(PackageSlots[b][i] == 6)
   			    {
      				AddItem(playerid, PackageSlots[b][i], 1,50);
				}
				else if(PackageSlots[b][i] == 24)
   			    {
      				AddItem(playerid, PackageSlots[b][i], 1,25);
				}
				else if(PackageSlots[b][i] == 25)
   			    {
      				AddItem(playerid, PackageSlots[b][i], 1,97);
				}
				else if(PackageSlots[b][i] != 4 && PackageSlots[b][i] != 6 && PackageSlots[b][i] != 24 && PackageSlots[b][i] != 25 && Itens[PackageSlots[b][i]][item_tipo] != ITEM_TYPE_AMMO)
				{
				    AddItem(playerid, PackageSlots[b][i], 1);
				}
				else if(Itens[PackageSlots[b][i]][item_tipo] == ITEM_TYPE_AMMO)
				{
				    AddItem(playerid, PackageSlots[b][i], randomEx(20,40));
				}
           		sucess = true;
           		PackageSlots[b][i] = 0;
			}
			if(!sucess)
   			for(new a = 0; a < GetSlotsInventory(playerid); a ++)
			if(pInventory[playerid][invSlot][a] == PackageSlots[b][i])
   			if(Itens[PackageSlots[b][i]][item_limite] >= 1+pInventory[playerid][invSlotAmount][a])
			{
   			    if(PackageSlots[b][i] == 4)
   			    {
      				AddItem(playerid, PackageSlots[b][i], randomEx(50,70));
				}
				else if(PackageSlots[b][i] == 6)
   			    {
      				AddItem(playerid, PackageSlots[b][i], 1,50);
				}
				else if(PackageSlots[b][i] == 24)
   			    {
      				AddItem(playerid, PackageSlots[b][i], 1,25);
				}
				else if(PackageSlots[b][i] == 25)
   			    {
      				AddItem(playerid, PackageSlots[b][i], 1,97);
				}
				if(PackageSlots[b][i] != 4 && PackageSlots[b][i] != 6 && PackageSlots[b][i] != 24 && PackageSlots[b][i] != 25)
				{
				    AddItem(playerid, PackageSlots[b][i], 1);
				}
   				sucess = true;
   				PackageSlots[b][i] = 0;
				return 1;
			}
			if(!sucess)
			ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Seu inventário está cheio.",
			"~r~ERROR: ~w~Your inventory is full."));
  			if(PackageSlots[b][0] == 0 && PackageSlots[b][1] == 0 && PackageSlots[b][2] == 0 && PackageSlots[b][3] == 0 && PackageSlots[b][4] == 0)
			{
				return DestroyPackage(b);
			}
  			ShowPackage(playerid,b);
		}
	}
	return 1;
}
public OnDynamicObjectMoved(objectid)
{
	foreach(new i : CarePackages) {
	    if(objectid == pCarePackage[i][CarePackagePlane]) {
	        if(pCarePackage[i][PlaneMoveStage] == false) {
	            pCarePackage[i][PlaneMoveStage] = true;
	            new Float:X,Float:Y,Float:Z,Float:PlaneFlyPos[2];
	            GetDynamicObjectPos(objectid, X, Y, Z);
             	PlaneFlyPos[0] = pCarePackage[i][CarePackageLand][0];
             	PlaneFlyPos[1] = pCarePackage[i][CarePackageLand][1];
             	GetXYFromPosWithAngle(PlaneFlyPos[0],PlaneFlyPos[1],pCarePackage[i][CarePackageRotation]+180,300);
				MoveDynamicObject(pCarePackage[i][CarePackagePlane], PlaneFlyPos[0], PlaneFlyPos[1], pCarePackage[i][CarePackageLand][2]+75, 30, 11.9, 0, -pCarePackage[i][CarePackageRotation]);
                //CarePackageParachute
                pCarePackage[i][CarePackageParachute] = CreateDynamicObject(2903,X,Y,Z,0,0,random(360),pCarePackage[i][CarePackageWorld],pCarePackage[i][CarePackageInterior],-1,200,200);
                MoveDynamicObject(pCarePackage[i][CarePackageParachute], pCarePackage[i][CarePackageLand][0], pCarePackage[i][CarePackageLand][1], pCarePackage[i][CarePackageLand][2], 15, 0, 0, random(360));
            	foreach(new b : Player) Streamer_Update(b);
				break;
	        } else if(pCarePackage[i][PlaneMoveStage] == true) {
	            DestroyDynamicObject(pCarePackage[i][CarePackagePlane]);
	            pCarePackage[i][CarePackagePlane] = -1;
         		foreach(new b : Player) Streamer_Update(b);
	            break;
	        }
	    } else if(objectid == pCarePackage[i][CarePackageParachute]) {
	        pCarePackage[i][CarePackageBox] = CreateDynamicObject(2975,pCarePackage[i][CarePackageLand][0], pCarePackage[i][CarePackageLand][1], pCarePackage[i][CarePackageLand][2]+0.7,0,0,random(360),PUBG_WORLD,-1,-1,200,200);
            new string[128];
            pCarePackage[i][CarePackageLanded] = true;
            format(string,128,"{FFAF00}[{F3FF02}CARE PACKAGE{FFAF00}]\n{FFFFFF}PRESS ENTER");
            pCarePackage[i][CarePackageText] = Create3DTextLabel(string, 0x008080FF, pCarePackage[i][CarePackageLand][0], pCarePackage[i][CarePackageLand][1], pCarePackage[i][CarePackageLand][2]+1, 40.0, pCarePackage[i][CarePackageWorld], 0);
            CarePackageDespawnTimer[i] = SetTimerEx("DespawnCarePackage",CAREPACKRESPAWN,false,"i",i);
			DestroyDynamicObject(objectid);
   			DestroyDynamicObject(pCarePackage[i][CarePackageFlare]);
			pCarePackage[i][CarePackageFlare] = CreateDynamicObject(18728,pCarePackage[i][CarePackageLand][0], pCarePackage[i][CarePackageLand][1], pCarePackage[i][CarePackageLand][2]+1.1,0,0,0,PUBG_WORLD,-1,-1,250,250);
	        pCarePackage[i][CarePackageParachute] = -1;
        	foreach(new b : Player) Streamer_Update(b);
	        break;
	    }
	}

	return 1;
}
public PUBG_OnPlayerEnterDynamicArea(playerid, areaid)
{
	if (areaid == redAreaid)
	{
	    if (leftRedArea[playerid])
	    {
		    if (GetPlayerState(playerid) != PLAYER_STATE_WASTED)
		    {
		    	GameTextForPlayer(playerid, "~w~You are in safe zone!", 1000 , 3);

		        TextDrawColor(bloodFaderTextDraw, 0);
		        TextDrawHideForPlayer(playerid, bloodFaderTextDraw);
		        TextDrawStopBoxFadeForPlayer(playerid, bloodFaderTextDraw);
		        leftRedArea[playerid] = false;
			}
	    }
	}
	return 1;
}
public PUBG_OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(PUBG[Start] != 0 && eInfo[playerid][inPUBG] == 1 && GetPlayerWeapon(playerid) != 46)
	{
		if (areaid == redAreaid)
		{
		    if (GetPlayerState(playerid) != PLAYER_STATE_WASTED)
		    {
			    GameTextForPlayer(playerid, "~r~You will lose health out off Blue zone!", 1000, 3);
			    TextDrawFadeBoxForPlayer(playerid, bloodFaderTextDraw, FADE_FROM_COLOR, FADE_TO_COLOR);
			    leftRedArea[playerid] = true;
			}
		}
		return 1;
	}

	return 1;
}

public OnTextDrawFade(Text:text, forplayerid, bool:isbox, newcolor, finalcolor)
{
	if(IsPlayerInDynamicArea(forplayerid, whiteAreaid))
	{
		TextDrawColor(bloodFaderTextDraw, 0);
	   	TextDrawHideForPlayer(forplayerid, bloodFaderTextDraw);
	   	TextDrawStopBoxFadeForPlayer(forplayerid, bloodFaderTextDraw);
	   	leftRedArea[forplayerid] = false;
	}
	if(PUBG[Start] != 0 && eInfo[forplayerid][inPUBG] == 1 && !IsPlayerInDynamicArea(forplayerid, whiteAreaid))
	{
		if (text == bloodFaderTextDraw)
		{
			if (newcolor == FADE_TO_COLOR)
			{
			    new Float:health;
			    GetPlayerHealth(forplayerid, health);
			    SetPlayerHealth(forplayerid, health - 5.0);

			    GameTextForPlayer(forplayerid, "~r~You are losing health outside Blue zone!", 1000 , 3);
				TextDrawFadeBoxForPlayer(forplayerid, bloodFaderTextDraw, FADE_TO_COLOR, FADE_FROM_COLOR);
			}
			else if (newcolor == FADE_FROM_COLOR)
			{
			    new Float:health;
			    GetPlayerHealth(forplayerid, health);
			    SetPlayerHealth(forplayerid, health - 5.0);

			    GameTextForPlayer(forplayerid, "~r~You are losing health outside Blue zone!", 1000 , 3);
				TextDrawFadeBoxForPlayer(forplayerid, bloodFaderTextDraw, FADE_FROM_COLOR, FADE_TO_COLOR);
			}
		}
	}
	return 1;
}
GetName(playerid)
{
	new pname[24];
	GetPlayerName(playerid, pname, 24);
	return pname;
}
RemovePUBGItems(playerid,type = 0)
{
	if(type == 0)
	{
		ResetPlayerWeapons(playerid);
	}
	for(new i = 0; i < MAX_INVENTORY_SLOTS ; i++)
	{
        new slot = i;
		RemoveItemFromInventory(playerid, slot);
		for(new a = 0; a < 4; a++) PlayerTextDrawHide(playerid, inventario_description[playerid][a]);
		TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);
		new selected = i;
		if(selected <= 6)
		{
  			RemoveItemFromCharacter(playerid, selected);
  		}
  		SetPlayerArmour(playerid, 0.0);
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
 	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
	    if(pPlayer[playerid][inInventory])
	    	HideInventory(playerid);
	}
    else if(clickedid == inventario_close[0])
    {
        HideInventory(playerid);
    }
    else if(clickedid == inventario_usar)
    {
        if(pInventory[playerid][invSelectedSlot] == -1)
            return 0;

		new slot = pInventory[playerid][invSelectedSlot];

		pInventory[playerid][invSelectedSlot] = -1;
        UseItem(playerid, slot, Itens[pInventory[playerid][invSlot][slot]][items_id]);
		for(new a = 0; a < 4; a++) PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

		TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);

		TextDrawHideForPlayer(playerid, inventario_usar);
		TextDrawHideForPlayer(playerid, inventario_split[0]);
		TextDrawHideForPlayer(playerid, inventario_split[1]);
		TextDrawHideForPlayer(playerid, inventario_drop[0]);
		TextDrawHideForPlayer(playerid, inventario_drop[1]);

		PlayerTextDrawHide(playerid, inventario_textos[playerid][9]);
    }
    else if(clickedid == inventario_split[0])
    {
        if(pInventory[playerid][invSelectedSlot] == -1)
            return 0;

        if(IsInventoryFull(playerid))
			return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Seu inventário está cheio.",
			"~r~ERROR: ~w~Your inventory is full."));

        new slot = pInventory[playerid][invSelectedSlot];

		if(pInventory[playerid][invSlotAmount][slot] == 1)
			return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Você não pode dividir esse item.",
			"~r~ERROR: ~w~You can't divide this item."));

        SplitItem(playerid, pInventory[playerid][invSelectedSlot]);
    }
    else if(clickedid == inventario_drop[0])
    {
        if(pInventory[playerid][invSelectedSlot] == -1)
            return 0;

        new slot = pInventory[playerid][invSelectedSlot];
        new itemid = pInventory[playerid][invSlot][slot];
        new amount = pInventory[playerid][invSlotAmount][slot];
        new Float:armourstatus = pInventory[playerid][invArmourStatus][slot];
		new Float:pos[3];

		if(!Itens[itemid][item_canbedropped])
		    return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Você não pode derrubar esse item.",
			"~r~ERROR: ~w~You can't drop this item."));

		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		if(itemid == 6 || itemid == 24 || itemid == 25)
			DropItem(pos[0], pos[1], pos[2], itemid, amount, armourstatus);
		else
	    	DropItem(pos[0], pos[1], pos[2], itemid, amount);

		RemoveItemFromInventory(playerid, slot);

	   	for(new a = 0; a < 4; a++)
		   	PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

		TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);
		pInventory[playerid][invSelectedSlot] = -1;
    }
    else if(clickedid == inventario_remover)
    {
        if(pCharacter[playerid][charSelectedSlot] == -1)
            return 0;

  	    if(IsInventoryFull(playerid))
            return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Seu inventário está cheio.",
			"~r~ERROR: ~w~Your inventory is full."));

        new selected = pCharacter[playerid][charSelectedSlot];

		if(selected == 2)
        	if(GetSlotsInUse(playerid) > 5)
        	    return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
				"~r~ERRO: ~w~Esvazie seu inventário.",
				"~r~ERROR: ~w~Clean your inventory.")); // backpack loss

  		if(selected == 2)
        	if(GetSlotsInUse(playerid) >= 5)
        	    return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
				"~r~ERRO: ~w~Não tem espaço no seu inventário.",
				"~r~ERROR: ~w~You don't have space in your inventory."));

        if(selected == 1)
            AddItem(playerid, pCharacter[playerid][charSlot][selected], 1, pCharacter[playerid][charArmourStatus]);
        else if(Itens[pCharacter[playerid][charSlot][selected]][items_id] == 5 || Itens[pCharacter[playerid][charSlot][selected]][items_id] == 17 || Itens[pCharacter[playerid][charSlot][selected]][items_id] == 23)
        {
	        new weapons[13][2];

	        for (new s = 0; s <= 12; s++)
			    GetPlayerWeaponData(playerid, s, weapons[s][0], weapons[s][1]);

            AddItem(playerid, pCharacter[playerid][charSlot][selected], weapons[8][1]);
		}
        else
        	AddItem(playerid, pCharacter[playerid][charSlot][selected], 1);

        RemoveItemFromCharacter(playerid, selected);

		pCharacter[playerid][charSelectedSlot] = -1;
    }
    return 1;
}
@TimerOneSecond()
{
	PUBG[Seconds]--;
	if(PUBG[Seconds] == 0)
	{
	    PUBG[Minutes]--;
 		PUBG[Seconds] = 60;
        if(PUBG[Minutes] < 0)
        {
            PUBG[Seconds] = 0;
        }

	}
	if(PUBG[Minutes] <= 0 && PUBG[Seconds] == 0 && PUBG[Start] == 0)
	{
	 	StartPUBG();
	  	SendClientMessageToAll(-1,"{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF}: PUBG Event has been started type /pubg to join (Min 2 players) !");
	}
}

AddItem(playerid, itemid, amount, Float:armorstatus = 97.0)
{
	new bool:sucess = false;

	for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
    {
		if(pInventory[playerid][invSlot][i] == itemid && Itens[pInventory[playerid][invSlot][i]][item_limite] > 1 && pInventory[playerid][invSlotAmount][i] != Itens[pInventory[playerid][invSlot][i]][item_limite])
        {
            new check = amount + pInventory[playerid][invSlotAmount][i];

			if(check > Itens[pInventory[playerid][invSlot][i]][item_limite])
			{
                pInventory[playerid][invSlotAmount][i] = Itens[itemid][item_limite];

                for(new a = 0; a < MAX_INVENTORY_SLOTS; a ++)
                {
                	if(pInventory[playerid][invSlot][a] == 0)
                	{
                    	pInventory[playerid][invSlot][a] = itemid;
						new resto = Itens[itemid][item_limite] - check;
                    	pInventory[playerid][invSlotAmount][a] = resto*-1;

                    	if(pPlayer[playerid][inInventory])
						{
	                    	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][a], Itens[itemid][Item_Model]);
	 						PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][a], Itens[itemid][item_previewrot][0], Itens[itemid][item_previewrot][1], Itens[itemid][item_previewrot][2], Itens[itemid][item_previewrot][3]);

							PlayerTextDrawHide(playerid, inventario_index[playerid][a]);
	            			PlayerTextDrawShow(playerid, inventario_index[playerid][a]);
						}

						break;
					}
				}
			}
			else
			{
            	pInventory[playerid][invSlotAmount][i] += amount;

            	if(pPlayer[playerid][inInventory])
				{
				    if(pInventory[playerid][invSelectedSlot] == i)
					{
						if(pInventory[playerid][invSlotAmount][i] > 1)
							format(String, sizeof(String), "%s: %d", Translate(pPlayer[playerid][Language], "Quantidade", "Amount"), pInventory[playerid][invSlotAmount][i]);
						else
							String = " ";

						PlayerTextDrawSetString(playerid, inventario_description[playerid][3], String);

					    PlayerTextDrawHide(playerid, inventario_description[playerid][3]);
					    PlayerTextDrawShow(playerid, inventario_description[playerid][3]);
					}
				}
			}

			sucess = true;
         	break;
		}
	}

	if(sucess)
	    return true;

	for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
 	{
		if(pInventory[playerid][invSlot][i] == 0)
	    {
		    pInventory[playerid][invSlot][i] = itemid;
	        pInventory[playerid][invSlotAmount][i] = amount;

        	if(itemid == 6 || itemid == 24 || itemid == 25)
			{
		 		pInventory[playerid][invArmourStatus][i] = armorstatus;
			}
	        if(pPlayer[playerid][inInventory])
			{
			    PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[itemid][Item_Model]);
				PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[itemid][item_previewrot][0], Itens[itemid][item_previewrot][1], Itens[itemid][item_previewrot][2], Itens[itemid][item_previewrot][3]);

	            PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
	            PlayerTextDrawShow(playerid, inventario_index[playerid][i]);
			}

			break;
		}
	}

	return true;
}


//----------------------------------------------------------

stock SplitItem(playerid, slot)
{
    new result = pInventory[playerid][invSlotAmount][slot]/2;

	for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
        if(pInventory[playerid][invSlot][i] == 0)
        {
            pInventory[playerid][invSlotAmount][slot] = pInventory[playerid][invSlotAmount][slot]/2;

            pInventory[playerid][invSlot][i] = pInventory[playerid][invSlot][slot];
            pInventory[playerid][invSlotAmount][i] = result;

    		PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
    		PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][Item_Model]);
 			PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
       		PlayerTextDrawShow(playerid, inventario_index[playerid][i]);

			if(pInventory[playerid][invSlotAmount][slot] > 1)
				format(String, sizeof(String), "%s: %d", Translate(pPlayer[playerid][Language], "Quantidade", "Amount"), pInventory[playerid][invSlotAmount][slot]);
			else
				String = " ";

			PlayerTextDrawSetString(playerid, inventario_description[playerid][3], String);

       		PlayerTextDrawHide(playerid, inventario_description[playerid][3]);
       		PlayerTextDrawShow(playerid, inventario_description[playerid][3]);
    		break;
        }
}

//----------------------------------------------------------

stock UseItem(playerid, slot, item)
{
	new Float:health;
	GetPlayerHealth(playerid,health);
	if(Itens[item][item_tipo] == ITEM_TYPE_HELMET)
	{
		if(pCharacter[playerid][charSlot][0] == 0)
		{
		    AddItemCharacter(playerid, 0, item);
		    RemoveItemFromInventory(playerid, slot);
		}
		else
		{
		    RemoveItemFromInventory(playerid, slot);
		    AddItem(playerid, pCharacter[playerid][charSlot][0], 1);
		    RemoveItemFromCharacter(playerid, 0);
		    AddItemCharacter(playerid, 0, item);
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_WEAPON || Itens[item][item_tipo] == ITEM_TYPE_MELEEWEAPON)
	{
  		new weaponid = GetWeaponIDFromModel(Itens[item][Item_Model]);
  		if(GetAmmu(playerid,weaponid) <= 0 && Itens[item][item_tipo] == ITEM_TYPE_WEAPON)
	    {
     		if(item != 5 && item != 17 && item != 23)
       		{
	        	pInventory[playerid][invSelectedSlot] = slot;
		        return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
				"~r~ERRO: ~w~Você não tem munição.", "~r~ERROR: ~w~You don't have ammunation."));
			}
		}
	    new weapons[13][2];

		for (new i = 0; i <= 12; i++)
		    GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);

		new weaponslot = GetWeaponSlot(weaponid);

		if(weapons[weaponslot][0] != 0 && weapons[weaponslot][1] > 0)
		{
		    pInventory[playerid][invSelectedSlot] = slot;
			return ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Não é possivel equipar duas armas do mesmo tipo.",
			"~r~ERROR: ~w~It's not possible to equip two weapons of the same kind."));
		}

	    new bool:have_slot;

	    for(new i = 3; i < 7; i ++)
	    {
	        if(pCharacter[playerid][charSlot][i] == item)
			{
			    pInventory[playerid][invSelectedSlot] = slot;
                ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
				"~r~ERRO: ~w~Não é possivel equipar duas armas iguais.",
				"~r~ERROR: ~w~It's not possible to equip two identical weapons."));
			    have_slot = true;
			    break;
			}

	    	if(pCharacter[playerid][charSlot][i] == 0)
			{
			    AddItemCharacter(playerid, i, item, pInventory[playerid][invSlotAmount][slot]);
			    RemoveItemFromInventory(playerid, slot);
		    	have_slot = true;
                break;
			}
		}

		if(!have_slot)
		{
		    pInventory[playerid][invSelectedSlot] = slot;
		    ShowMessageInventory(playerid, Translate(pPlayer[playerid][Language],
			"~r~ERRO: ~w~Não é possivel equipar mais armas.",
			"~r~ERROR: ~w~It's not possible to equip more weapons."));
		    return true;
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_BODY)
	{
	    if(pCharacter[playerid][charSlot][1] == 0)
		{
		    if(pInventory[playerid][invArmourStatus][slot] == 50 && item == 24 || pInventory[playerid][invArmourStatus][slot] == 97 && item == 24)
		    {
		    	pInventory[playerid][invArmourStatus][slot] = 25;
		    }
		    if(pInventory[playerid][invArmourStatus][slot] == 25 && item == 6 || pInventory[playerid][invArmourStatus][slot] == 97 && item == 6)
		    {
		    	pInventory[playerid][invArmourStatus][slot] = 50;
		    }
		    if(pInventory[playerid][invArmourStatus][slot] == 25 && item == 25 || pInventory[playerid][invArmourStatus][slot] == 50 && item == 25)
		    {
		    	pInventory[playerid][invArmourStatus][slot] = 97;
		    }
	    	AddItemCharacter(playerid, 1, item, 0, pInventory[playerid][invArmourStatus][slot]);
			RemoveItemFromInventory(playerid, slot);
		}
		else
		{
	    	SendClientMessage(playerid,-1,"{FF0000}ERROR: "GREY2_E" You first need to remove the Armor you are wearing");
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_BACKPACK)
	{
	    if(pCharacter[playerid][charSlot][2] == 0)
		{
		    AddItemCharacter(playerid, 2, item);
			RemoveItemFromInventory(playerid, slot);
		}
		else
		{
		    RemoveItemFromInventory(playerid, slot);
		    AddItem(playerid, pCharacter[playerid][charSlot][2], 1);
		    RemoveItemFromCharacter(playerid, 2);
		    AddItemCharacter(playerid, 2, item);
		}

		OrganizeInventory(playerid);

		for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    	PlayerTextDrawHide(playerid, inventario_index[playerid][i]);

        for(new i = 0; i < GetSlotsInventory(playerid); i++)
		{
			PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][Item_Model]);
	 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);

			PlayerTextDrawShow(playerid, inventario_index[playerid][i]);
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_AMMO)
	{
        pInventory[playerid][invSelectedSlot] = slot;
        return true;
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_NORMAL)
	{
	    if(item == 18) // Medic Kit
	    {
	        if(health >= 100.0) return SendClientMessage(playerid,-1,"{FF0000}[Server] Your health is already full");
	        SetPlayerHealth(playerid, 100.0);
	        RemoveItemFromInventory(playerid, slot, 1);
	    }
	    if(item == 28) // Medical Sachette
	    {
	        if(health >= 100.0) return SendClientMessage(playerid,-1,"{FF0000}[Server] Your health is already full");
	        SetPlayerHealth(playerid,health+40.0);
	        if(health > 100) SetPlayerHealth(playerid,100.0);
	        RemoveItemFromInventory(playerid, slot, 1);
	    }
	    if(item == 29) // Bandage
	    {
	        if(health >= 100.0) return SendClientMessage(playerid,-1,"{FF0000}[Server] Your health is already full");
	        SetPlayerHealth(playerid,health+10.0);
	        if(health > 100) SetPlayerHealth(playerid,100.0);
	        RemoveItemFromInventory(playerid, slot, 1);
	    }
	    if(item == 30) // Pan
	    {
	        RemoveItemFromInventory(playerid, slot, 1);
	        SetPlayerAttachedObject(playerid, 8, 19581, 1, -0.150999, -0.038000, 0.107000, -106.200012, 177.899993, 90.199989, 0.659000, 0.613000, 0.686000);
	    }
	}

	if(pPlayer[playerid][inInventory])
	{
	   	for(new a = 0; a < 4; a++)
		   	PlayerTextDrawShow(playerid, inventario_description[playerid][a]);

		TextDrawShowForPlayer(playerid, inventario_backgrounds[4]);

		TextDrawShowForPlayer(playerid, inventario_usar);
		TextDrawShowForPlayer(playerid, inventario_split[0]);
		TextDrawHideForPlayer(playerid, inventario_split[1]);
		TextDrawHideForPlayer(playerid, inventario_drop[0]);
		TextDrawHideForPlayer(playerid, inventario_drop[1]);
		PlayerTextDrawHide(playerid, inventario_textos[playerid][9]);
	}

	return true;
}
HelmetAttach(playerid,itemid,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
{
	if(itemid == 1) SetPlayerAttachedObject(playerid, 0, 18645, 2, x, y, z, rx, ry, rz);
	if(itemid == 26) SetPlayerAttachedObject(playerid, 0, 19584, 2, 0.094000, 0.022000, 0.162000, 85.300010, -102.000030, 0.000000, 0.679999, 0.666999, 0.577000);
    if(itemid == 27) SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.117999, 0.000000, 0.002000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.088000);
}

//----------------------------------------------------------
AddItemCharacter(playerid, slot, itemid, quantidade = 0, Float:armourstatus = 0.0)
{
	if(itemid == 1 || itemid == 26 || itemid == 27)
	{
	    switch(GetPlayerSkin(playerid))
		{
			case 0, 65, 74, 149, 208, 273:  HelmetAttach(playerid,itemid,0.070000, 0.000000, 0.000000, 88.000000, 75.000000, 0.000000);
			case 1..6, 8, 14, 16, 22, 27, 29, 33, 41..49, 82..84, 86, 87, 119, 289: HelmetAttach(playerid,itemid,0.070000, 0.000000, 0.000000, 88.000000, 77.000000, 0.000000);
			case 7, 10: HelmetAttach(playerid,itemid,0.090000, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000);
			case 9: HelmetAttach(playerid,itemid,0.059999, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000);
			case 11..13: HelmetAttach(playerid,itemid,0.070000, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000);
			case 15: HelmetAttach(playerid,itemid,0.059999, 0.000000, 0.000000, 88.000000, 82.000000, 0.000000);
			case 17..21: HelmetAttach(playerid,itemid,0.059999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 23..26, 28, 30..32, 34..39, 57, 58, 98, 99, 104..118, 120..131: HelmetAttach(playerid,itemid,0.079999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 40: HelmetAttach(playerid,itemid,0.050000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 50, 100..103, 148, 150..189, 222: HelmetAttach(playerid,itemid,0.070000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 51..54: HelmetAttach(playerid,itemid,0.100000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 55, 56, 63, 64, 66..73, 75, 76, 78..81, 133..143, 147, 190..207, 209..219, 221, 247..272, 274..288, 290..293: HelmetAttach(playerid,itemid,0.070000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 59..62: HelmetAttach(playerid,itemid,0.079999, 0.029999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 77: HelmetAttach(playerid,itemid,0.059999, 0.019999, 0.000000, 87.000000, 82.000000, 0.000000);
			case 85, 88, 89: HelmetAttach(playerid,itemid,0.070000, 0.039999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 90..97: HelmetAttach(playerid,itemid,0.050000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 132: HelmetAttach(playerid,itemid,0.000000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 144..146: HelmetAttach(playerid,itemid,0.090000, 0.000000, 0.000000, 88.000000, 82.000000, 0.000000);
			case 220: HelmetAttach(playerid,itemid,0.029999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 223, 246: HelmetAttach(playerid,itemid,0.070000, 0.050000, 0.000000, 88.000000, 82.000000, 0.000000);
			case 224..245: HelmetAttach(playerid,itemid,0.070000, 0.029999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 294: HelmetAttach(playerid,itemid,0.070000, 0.019999, 0.000000, 91.000000, 84.000000, 0.000000);
			case 295: HelmetAttach(playerid,itemid,0.050000, 0.019998, 0.000000, 86.000000, 82.000000, 0.000000);
			case 296..298: HelmetAttach(playerid,itemid,0.064999, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000);
			case 299..306: HelmetAttach(playerid,itemid,0.064998, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000);
		}
	}
	else if(Itens[itemid][item_tipo] == ITEM_TYPE_WEAPON || Itens[itemid][item_tipo] == ITEM_TYPE_MELEEWEAPON)
	{
	    new modelid = Itens[itemid][Item_Model];

	    if(itemid == 5 || itemid == 17 || itemid == 23)
	    {
	        GivePlayerWeapon(playerid, GetWeaponIDFromModel(modelid), quantidade);
		}
	    else
	    {
		 	GivePlayerWeapon(playerid, GetWeaponIDFromModel(modelid), GetAmmu(playerid,GetWeaponIDFromModel(modelid)));
		}
	}
	else if(itemid == 6 || itemid == 24 || itemid == 25)
	{
	    SetPlayerArmour(playerid, armourstatus);
	    pCharacter[playerid][charArmourStatus] = armourstatus;
	    if(itemid == 24)
	    {
	    	SetPlayerAttachedObject(playerid, 1, 1242, 1, 0.093999, 0.036999, 0.003999, 98.899848, 87.900047, -101.499977, 1.225000, 1.726999, 1.464001);
	    }
	    else
	    {
			SetPlayerAttachedObject(playerid, 1, Itens[itemid][Item_Model], 1, 0.103999,0.034999,0.001000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
		}
	}
	else if(Itens[itemid][item_tipo] == ITEM_TYPE_BACKPACK)
	{
		if(itemid == 8) SetPlayerAttachedObject(playerid, 2 , 19559, 1, 0.118999, -0.020000, 0.000000, 0.000000, 88.200004, 0.000000, 0.835000, 1.000000, 1.000000);
		if(itemid == 7) SetPlayerAttachedObject(playerid, 2, Itens[itemid][Item_Model] ,1,-0.129000,-0.078999,-0.003999,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
	}

	pCharacter[playerid][charSlot][slot] = itemid;

	PlayerPlaySound(playerid,1052,0.0,0.0,0.0);

    if(pPlayer[playerid][inInventory])
	{
	    PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][slot], Itens[itemid][Item_Model]);
		PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][slot], Itens[itemid][item_previewrot][0], Itens[itemid][item_previewrot][1], Itens[itemid][item_previewrot][2], Itens[itemid][item_previewrot][3]);

	    PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][slot]);
	   	PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][slot]);
	}
}
//----------------------------------------------------------
RemoveItemFromInventory(playerid, slot, amount = 0 , type = 0)
{

    if(amount == 0)
    {
        pInventory[playerid][invSlot][slot] = 0;
		pInventory[playerid][invSlotAmount][slot] = 0;
	}
	else
	{
	    pInventory[playerid][invSlotAmount][slot] -= amount;

	    if(pInventory[playerid][invSlotAmount][slot] == 0)
	        pInventory[playerid][invSlot][slot] = 0;

	}

	if(pPlayer[playerid][inInventory])
	{
	    PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][slot], Itens[pInventory[playerid][invSlot][slot]][Item_Model]);
 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][slot], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][0], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][1], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][2], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][3]);
        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][slot], 96);

		PlayerTextDrawHide(playerid, inventario_index[playerid][slot]);
		if(type == 0) PlayerTextDrawShow(playerid, inventario_index[playerid][slot]);
	}
}

//----------------------------------------------------------
RemoveItemFromCharacter(playerid, slot , type = 0)
{
	if(Itens[pCharacter[playerid][charSlot][slot]][item_tipo] == ITEM_TYPE_WEAPON)
	{
	    new modelid = Itens[pCharacter[playerid][charSlot][slot]][Item_Model];
	    SetPlayerAmmo(playerid, GetWeaponIDFromModel(modelid), 0);

        new itemid = Itens[pCharacter[playerid][charSlot][slot]][items_id];

        pCharacter[playerid][charSlot][slot] = 0;

	    if(itemid == 3 || itemid == 9)
	    	if(IsPlayerAttachedObjectSlotUsed(playerid, 3))
     			RemovePlayerAttachedObject(playerid, 3);

        if(itemid == 10)
	    	if(IsPlayerAttachedObjectSlotUsed(playerid, 4))
      			RemovePlayerAttachedObject(playerid, 4);

      	if(itemid == 2)
	    	if(IsPlayerAttachedObjectSlotUsed(playerid, 5))
      			RemovePlayerAttachedObject(playerid, 5);

	}
	else if(Itens[pCharacter[playerid][charSlot][slot]][item_tipo] == ITEM_TYPE_MELEEWEAPON)
	{
	    new modelid = Itens[pCharacter[playerid][charSlot][slot]][Item_Model];
	    RemovePlayerWeapon(playerid, GetWeaponIDFromModel(modelid));

	    if(IsPlayerAttachedObjectSlotUsed(playerid, 6))
      		RemovePlayerAttachedObject(playerid, 6);
	}

	if(slot == 0) // Helmet
	{
	    RemovePlayerAttachedObject(playerid, 0);
	}
	else if(slot == 1) // Armour
	{
	    RemovePlayerAttachedObject(playerid, 1);
	    SetPlayerArmour(playerid, 0);
	    pCharacter[playerid][charArmourStatus] = 0.0;
	}
	else if(slot == 2) // Backpack
	{
	    RemovePlayerAttachedObject(playerid, 2);
	    pCharacter[playerid][charSlot][slot] = 0;

	    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    	PlayerTextDrawHide(playerid, inventario_index[playerid][i]);

        for(new i = 0; i < GetSlotsInventory(playerid); i++)
		{
			PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][Item_Model]);
	 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);
		}
	}

    pCharacter[playerid][charSlot][slot] = 0;
    PlayerPlaySound(playerid,1053,0.0,0.0,0.0);

    if(pPlayer[playerid][inInventory])
	{
	    PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][slot], Itens[0][Item_Model]);
	 	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][slot], Itens[0][item_previewrot][0], Itens[0][item_previewrot][1], Itens[0][item_previewrot][2], Itens[0][item_previewrot][3]);
		PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][slot], 96);

	    PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][slot]);
	   	if(type == 0) PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][slot]);
	   	PlayerTextDrawHide(playerid, inventario_textos[playerid][10]);
		TextDrawHideForPlayer(playerid, inventario_remover);
	}
}
//----------------------------------------------------------

DropItem(Float:x, Float:y, Float:z, itemid, amount, Float:armourstatus = 0.0)
{
	if(itemid != 0)
	{
	    ItensWorld[LastItemID][world_timer] = TIMER_ITEM_WORLD;
		ItensWorld[LastItemID][world_itemid] = itemid;
		ItensWorld[LastItemID][world_model] = Itens[itemid][Item_Model];
		ItensWorld[LastItemID][world_amount] = amount;
		ItensWorld[LastItemID][world_position][0] = x;
		ItensWorld[LastItemID][world_position][1] = y;
		ItensWorld[LastItemID][world_position][2] = z;

		if(itemid == 6 || itemid == 24 || itemid == 25)
		    ItensWorld[LastItemID][world_armourstatus] = armourstatus;

	    ItensWorld[LastItemID][world_object] = CreateDynamicObject(ItensWorld[LastItemID][world_model], x, y, z-0.90, -90,0,0,PUBG_WORLD);

		if(amount > 1)
			format(String, sizeof(String), "%s (%d)", Itens[itemid][item_nome], amount);
		else
			format(String, sizeof(String), "%s", Itens[itemid][item_nome]);
    	ItensWorld[LastItemID][world_3dtext] = Create3DTextLabel(String, 0xFFFFFF99 , x, y,z-0.90, 10.0, PUBG_WORLD, 0);

		ItensWorld[LastItemID][world_active] = true;

		if(LastItemID == MAX_ITENS_WORLD-1)
			LastItemID = 0;
		else
		    LastItemID++;
	}
}
DropItem2(Float:x, Float:y, Float:z, itemid, amount, Float:armourstatus = 0.0)
{
	if(itemid != 0)
	{
	    ItensWorld[LastItemID][world_timer] = TIMER_ITEM_WORLD;
		ItensWorld[LastItemID][world_itemid] = itemid;
		ItensWorld[LastItemID][world_model] = Itens[itemid][Item_Model];
		ItensWorld[LastItemID][world_amount] = amount;
		ItensWorld[LastItemID][world_position][0] = x;
		ItensWorld[LastItemID][world_position][1] = y;
		ItensWorld[LastItemID][world_position][2] = z;

		if(itemid == 6 || itemid == 24 || itemid == 25)
		    ItensWorld[LastItemID][world_armourstatus] = armourstatus;

	    ItensWorld[LastItemID][world_object] = CreateDynamicObject(ItensWorld[LastItemID][world_model], x, y, z-0.90, -90,0,0,PUBG_WORLD+1);

		if(amount > 1)
			format(String, sizeof(String), "%s (%d)", Itens[itemid][item_nome], amount);
		else
			format(String, sizeof(String), "%s", Itens[itemid][item_nome]);
    	ItensWorld[LastItemID][world_3dtext] = Create3DTextLabel(String, 0xFFFFFF99, x, y,z-0.90, 10.0, PUBG_WORLD+1, 0);

		ItensWorld[LastItemID][world_active] = true;

		if(LastItemID == MAX_ITENS_WORLD-1)
			LastItemID = 0;
		else
		    LastItemID++;
	}
}

//----------------------------------------------------------

stock DeleteItemWorld(worlditemid)
{
    ItensWorld[worlditemid][world_active] = false;
    DestroyDynamicObject(ItensWorld[worlditemid][world_object]);
    //DestroyDynamic3DTextLabel(ItensWorld[worlditemid][world_3dtext]);
    Delete3DTextLabel(ItensWorld[worlditemid][world_3dtext]);
}

//----------------------------------------------------------

stock IsItemInInventory(playerid, itemid, amount)
{
	new bool:sucess = false;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
         if(pInventory[playerid][invSlot][i] == itemid)
            if(pInventory[playerid][invSlotAmount][i] >= amount)
                sucess = true;

	if(!sucess)
	    return false;
	else
	    return true;
}

//----------------------------------------------------------

stock GetSlotsFree(playerid)
{
	new count = 0;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 0)
            count++;

	return count;
}

//----------------------------------------------------------

stock GetSlotsInUse(playerid)
{
    new count = 0;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] != 0)
            count++;

	return count;
}

//----------------------------------------------------------

stock IsInventoryFull(playerid)
{
    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 0)
            return false;

	return true;
}

//----------------------------------------------------------

stock GetSlotsInventory(playerid)
{
    new slots;

	if(pCharacter[playerid][charSlot][2] == 0)
	    slots = 5;
	else if(pCharacter[playerid][charSlot][2] == 7)
	    slots = 10;
    else if(pCharacter[playerid][charSlot][2] == 8)
	    slots = 15;

	return slots;
}

//----------------------------------------------------------

stock GetAmmunation(playerid)
{
	new total;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 4)
			total += pInventory[playerid][invSlotAmount][i];

	return total;
}
GetAmmu(playerid,weaponid)
{
	new total;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
    {
        switch(weaponid)
        {
       		case 30,31:
			{
				if(pInventory[playerid][invSlot][i] == 31)
				total += pInventory[playerid][invSlotAmount][i];
			}
       		case 22..24:
			{
				if(pInventory[playerid][invSlot][i] == 35)
				total += pInventory[playerid][invSlotAmount][i];
			}
       		case 28,29,32:
			{
				if(pInventory[playerid][invSlot][i] == 34)
				total += pInventory[playerid][invSlotAmount][i];
			}
       		case 25..27:
			{
				if(pInventory[playerid][invSlot][i] == 33)
				total += pInventory[playerid][invSlotAmount][i];
			}
       		case 33,34:
			{
				if(pInventory[playerid][invSlot][i] == 32)
				total += pInventory[playerid][invSlotAmount][i];
			}
		}
	}
	return total;
}
GetTypeFromID(weaponid)
{
	new total;
	switch(weaponid)
 	{
	 	case 30,31: 	total = 31;
		case 22..24: 	total = 35;
		case 28,29,32: 	total = 34;
		case 25..27: 	total = 33;
		case 33,34: 	total = 32;
	}
	return total;
}
//----------------------------------------------------------

stock GetAmmunationSlot(playerid)
{
	new slot = -1;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 4)
        {
            slot = i;
            break;
		}

	return slot;
}
GetAmmuSlot(playerid,weaponid)
{
	new slot = -1;
    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
    {
        switch(weaponid)
        {
	        case 30,31:
			{
				if(pInventory[playerid][invSlot][i] == 31)
				{
	            	slot = i;
	            	break;
				}
			}
	        case 22..24:
			{
				if(pInventory[playerid][invSlot][i] == 35)
				{
	            	slot = i;
	            	break;
				}
			}
 	        case 28,29,32:
			{
				if(pInventory[playerid][invSlot][i] == 34)
				{
	            	slot = i;
	            	break;
				}
			}
 	        case 25..27:
			{
				if(pInventory[playerid][invSlot][i] == 33)
				{
	            	slot = i;
	            	break;
				}
			}
 	        case 33,34:
			{
				if(pInventory[playerid][invSlot][i] == 32)
				{
	            	slot = i;
	            	break;
				}
			}
		}
	}
	return slot;
}
//----------------------------------------------------------

stock OrganizeInventory(playerid)
{
    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    if(pInventory[playerid][invSlot][i] != 0)
		    for(new a = 0; a < MAX_INVENTORY_SLOTS; a++)
		        if(pInventory[playerid][invSlot][a] == 0)
		        {
			        pInventory[playerid][invSlot][a] = pInventory[playerid][invSlot][i];
			        pInventory[playerid][invSlotAmount][a] = pInventory[playerid][invSlotAmount][i];
                    pInventory[playerid][invArmourStatus][a] = pInventory[playerid][invArmourStatus][i];
			        pInventory[playerid][invSlot][i] = 0;
			        pInventory[playerid][invSlotAmount][i] = 0;
			        pInventory[playerid][invArmourStatus][i] = 0;
				}
}

//----------------------------------------------------------

stock GetWeaponSlot(weaponid)
{
	new slot;

	switch(weaponid)
	{
		case 0,1: slot = 0;
		case 2 .. 9: slot = 1;
		case 10 .. 15: slot = 10;
		case 16 .. 18, 39: slot = 8;
		case 22 .. 24: slot =2;
		case 25 .. 27: slot = 3;
		case 28, 29, 32: slot = 4;
		case 30, 31: slot = 5;
		case 33, 34: slot = 6;
		case 35 .. 38: slot = 7;
		case 40: slot = 12;
		case 41 .. 43: slot = 9;
		case 44 .. 46: slot = 11;
	}

	return slot;
}

//----------------------------------------------------------

ShowPUBGInventory(playerid)
{
    pPlayer[playerid][inInventory] = true;
    SelectTextDraw(playerid, 0xFFFFFFFF);

    // Globais

    TextDrawShowForPlayer(playerid, inventario_close[0]);
	TextDrawShowForPlayer(playerid, inventario_close[1]);

	for(new i = 0; i < 5; i++)
	    if(i != 4)
	    	TextDrawShowForPlayer(playerid, inventario_backgrounds[i]);

	// Player

	for(new i = 0; i < GetSlotsInventory(playerid); i++)
	{
		PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][Item_Model]);
 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);

		PlayerTextDrawShow(playerid, inventario_index[playerid][i]);
	}

	PlayerTextDrawSetString(playerid, inventario_textos[playerid][0], Translate(pPlayer[playerid][Language], "Personagem", "Character"));
	PlayerTextDrawSetString(playerid, inventario_textos[playerid][1], Translate(pPlayer[playerid][Language], ConvertToGameText("Seu Inventário"), "Your Inventory"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][2], Translate(pPlayer[playerid][Language], ConvertToGameText("Cabeça"), "Head"));
	PlayerTextDrawSetString(playerid, inventario_textos[playerid][3], Translate(pPlayer[playerid][Language], "Mochila", "Backpack"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][4], Translate(pPlayer[playerid][Language], "Corpo", "Body"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][5], Translate(pPlayer[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][6], Translate(pPlayer[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][7], Translate(pPlayer[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][8], Translate(pPlayer[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][9], Translate(pPlayer[playerid][Language], "Usar", "Use"));

	for(new i = 0; i < 11; i++)
	    if(i != 10 && i != 9)
	    	PlayerTextDrawShow(playerid, inventario_textos[playerid][i]);

	for(new i = 0; i < 7; i++)
	{
	    new char_slot = pCharacter[playerid][charSlot][i];

	    PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][i], Itens[char_slot][Item_Model]);
 		PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][i], Itens[char_slot][item_previewrot][0], Itens[char_slot][item_previewrot][1], Itens[char_slot][item_previewrot][2], Itens[char_slot][item_previewrot][3]);
        PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][i], 96);

	    PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][i]);
	}
    TextDrawShowForPlayer(playerid,inventario_backgrounds[0]);
	PlayerTextDrawSetPreviewModel(playerid, inventario_skin[playerid], GetPlayerSkin(playerid));
	PlayerTextDrawShow(playerid, inventario_skin[playerid]);
}

//----------------------------------------------------------

stock HideInventory(playerid)
{
	TextDrawHideForPlayer(playerid, inventario_usar);
	TextDrawHideForPlayer(playerid, inventario_split[0]);
	TextDrawHideForPlayer(playerid, inventario_split[1]);
	TextDrawHideForPlayer(playerid, inventario_drop[0]);
	TextDrawHideForPlayer(playerid, inventario_drop[1]);
	TextDrawHideForPlayer(playerid, inventario_close[0]);
	TextDrawHideForPlayer(playerid, inventario_close[1]);

	for(new i = 0; i < 5; i++)
	    if(i != 4)
	    	TextDrawHideForPlayer(playerid, inventario_backgrounds[i]);

    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    PlayerTextDrawHide(playerid, inventario_index[playerid][i]);

    for(new i = 0; i < 11; i++)
	    PlayerTextDrawHide(playerid, inventario_textos[playerid][i]);

	for(new i = 0; i < 7; i++)
	    PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][i]);

	PlayerTextDrawHide(playerid, inventario_skin[playerid]);
	TextDrawHideForPlayer(playerid, inventario_remover);

	TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);

	for(new a = 0; a < 4; a++)
    	PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

    pInventory[playerid][invSelectedSlot] = -1;
    pCharacter[playerid][charSelectedSlot] = -1;
    pPlayer[playerid][inInventory] = false;
    CancelSelectTextDraw(playerid);
}

//----------------------------------------------------------
public PUBG_OnPlayerDeath(playerid,killerid,reason)
{
	new string[127];
	new winner = -1;
	HIDEPUBGTDs(playerid);
	InDM[playerid] = 0;
    GodModeLabel(playerid, true);
	canUseKey[playerid] = true;
	if(eInfo[playerid][inPUBG] == 1)
	{
		SetPlayerColor(playerid,GetPVarInt(playerid, "oldColor"));
		foreach(new ii : Player)
		{
			SetPlayerMarkerForPlayer(ii,playerid,GetPVarInt(playerid, "oldColor"));
  		}
  		new score;
		switch(PUBG[Players])
		{
			case 1: score = 10;
	  		case 2: score = 8;
	   		case 3: score = 4;
		}
		new Reward;
		switch(PUBG[Players])
		{
			case 1: Reward = 50000;
			case 2: Reward = 30000;
			case 3: Reward = 20000;
			case 4: Reward = 10000;
			case 5: Reward = 10000;
			case 6: Reward = 0;
			case 7: Reward = 0;
			case 8..10: Reward = 0;
			default: Reward = 0;
		}
	 	Reward += (eInfo[playerid][pKills]*3000);
		format(string,sizeof(string),""RED_E"[Server] "YELLOW_E"You have received $%s , %d score and %d cookie(s)" , ToCurrency(Reward) , score , score);
		SendClientMessage(playerid,-1,string);
		GivePlayerCash(playerid, Reward);
		GivePlayerScore(playerid, score);
		GivePlayerCookie(playerid, score);
		if(killerid != INVALID_PLAYER_ID)
		{
			eInfo[killerid][pKills]++;
			format(string,sizeof(string),"0%d" , eInfo[killerid][pKills]);
			PlayerTextDrawSetString(killerid,PKILLS[killerid],string);
  			PUBG_Kills[killerid]++;
  			UpdateGroupScore(pGroupID[killerid], 1);
		}
		PUBG_Deaths[playerid]++;
		SHOWDIEDTDs(playerid , 0);
		PUBG[Players]--;
		CheckForPlayers();
		eInfo[playerid][inPUBG] = 0;
		eInfo[playerid][pKills] = 0;
		if(PUBG[Players] == 1)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
		    	if(IsPlayerConnected(i))
		    	{
					if(eInfo[i][inPUBG] == 1)
			    	{
				        winner = i;
						break;
					}
				}
			}
		  	switch(PUBG[Players])
			{
				case 1: Reward = 50000;
				case 2: Reward = 30000;
				case 3: Reward = 20000;
				case 4: Reward = 10000;
				case 5: Reward = 10000;
				case 6: Reward = 0;
				case 7: Reward = 0;
				case 8..10: Reward = 0;
				default: Reward = 0;
			}
		 	Reward += (eInfo[winner][pKills]*3000);
			format(string,sizeof(string),"{DBED15}[{7A7A7A}PUBG{DBED15}]{FFFFFF} {15D4ED}%s(%d) won the PUBG! {E8D04C}Prize: $%s , 10 score and 10 cookies!" , GetName(winner),winner,ToCurrency(Reward));
			SendClientMessageToAll(-1,string);
			UpdateGroupScore(pGroupID[winner], 4);
			GivePlayerCash(winner, Reward);
			GivePlayerScore(winner, 10);
			GivePlayerCookie(winner, 10);
			PUBG_Wins[winner]++;
			SHOWDIEDTDs(winner , 1);
			SpawnPlayer(winner);
			LeavePUBG(winner);
			RemovePUBGItems(winner,1);
			if(GetPVarInt(winner, "toysDisabled") == 0)
			{
		 		AttachPlayerToys(winner);
			}
			GangZoneHideForPlayer(winner,redForcefield[0]);
			GangZoneHideForPlayer(winner,redForcefield[1]);
			GangZoneHideForPlayer(winner,redForcefield[2]);
			GangZoneHideForPlayer(winner,redForcefield[3]);
			GangZoneHideForPlayer(winner,whiteForcefield[0]);
			GangZoneHideForPlayer(winner,whiteForcefield[1]);
			GangZoneHideForPlayer(winner,whiteForcefield[2]);
			GangZoneHideForPlayer(winner,whiteForcefield[3]);
			InDM[winner] = 0;
			EndEvent(1);
		}
		DropAll(playerid);
		eInfo[playerid][inPUBG] = 0;
		TextDrawHideForPlayer(playerid,Start_TD);
		TextDrawHideForPlayer(playerid,Restrict_TD);
		SetPlayerVirtualWorld(playerid,0);
		GangZoneHideForPlayer(winner,redForcefield[0]);
		GangZoneHideForPlayer(winner,redForcefield[1]);
		GangZoneHideForPlayer(winner,redForcefield[2]);
		GangZoneHideForPlayer(winner,redForcefield[3]);
		GangZoneHideForPlayer(winner,whiteForcefield[0]);
		GangZoneHideForPlayer(winner,whiteForcefield[1]);
		GangZoneHideForPlayer(winner,whiteForcefield[2]);
		GangZoneHideForPlayer(winner,whiteForcefield[3]);
		InDM[winner] = 0;
		InDM[playerid] = 0;
		SetPlayerPosOnSpawn(playerid);
		RemovePUBGItems(playerid,1);
		if(GetPVarInt(playerid, "toysDisabled") == 0)
		{
	 		AttachPlayerToys(playerid);
		}
	}
	return 1;
}
stock GetWeaponIDFromModel(modelid)
{
    new idweapon;

    switch(modelid)
	{
       	case 331: idweapon = 1; // Brass Knuckles
       	case 333: idweapon = 2; // Golf Club
       	case 334: idweapon = 3; // Nightstick
      	case 335: idweapon = 4; // Knife
       	case 336: idweapon = 5; // Baseball Bat
       	case 337: idweapon = 6; // Shovel
       	case 338: idweapon = 7; // Pool Cue
       	case 339: idweapon = 8; // Katana
       	case 341: idweapon = 9; // Chainsaw
       	case 321: idweapon = 10; // Double-ended Dildo
       	case 325: idweapon = 14; // Flowers
       	case 326: idweapon = 15; // Cane
       	case 342: idweapon = 16; // Grenade
       	case 343: idweapon = 17; // Tear Gas
       	case 344: idweapon = 18; // Molotov Cocktail
       	case 346: idweapon = 22; // 9mm
       	case 347: idweapon = 23; // Silenced 9mm
       	case 348: idweapon = 24; // Desert Eagle
       	case 349: idweapon = 25; // Shotgun
       	case 350: idweapon = 26; // Sawnoff
       	case 351: idweapon = 27; // Combat Shotgun
       	case 352: idweapon = 28; // Micro SMG/Uzi
       	case 353: idweapon = 29; // MP5
       	case 355: idweapon = 30; // AK-47
       	case 356: idweapon = 31; // M4
       	case 372: idweapon = 32; // Tec-9
       	case 357: idweapon = 33; // Country Rifle
       	case 358: idweapon = 34; // Sniper Rifle
       	case 359: idweapon = 35; // RPG
       	case 360: idweapon = 36; // HS Rocket
       	case 361: idweapon = 37; // Flamethrower
       	case 362: idweapon = 38; // Minigun
       	case 363: idweapon = 39;// Satchel Charge + Detonator
       	case 365: idweapon = 41; // Spraycan
       	case 366: idweapon = 42; // Fire Extinguisher
	}

	return idweapon;
}

//----------------------------------------------------------

stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12];
	new plyAmmo[12];

	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);

		if(wep != weaponid)
		{
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}

	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}

//----------------------------------------------------------

//public Float:GetPlayerArmourEx(playerid)
//{
//	new Float:pColete;
//	GetPlayerArmour(playerid, pColete);
//	return Float:pColete;
//}
//----------------------------------------------------------

stock ShowMessageInventory(playerid, string[], time = 5000)
{
	if (pPlayer[playerid][MessageInventory])
	{
	    PlayerTextDrawHide(playerid, inventario_mensagem[playerid]);
	    KillTimer(pPlayer[playerid][MessageInventoryTimer]);
	}

	PlayerTextDrawSetString(playerid, inventario_mensagem[playerid], ConvertToGameText(string));
	PlayerTextDrawShow(playerid, inventario_mensagem[playerid]);

	pPlayer[playerid][MessageInventory] = true;
	pPlayer[playerid][MessageInventoryTimer] = SetTimerEx("HideMessageInventory", time, false, "d", playerid);
	return true;
}

//----------------------------------------------------------

public HideMessageInventory(playerid)
{
	if (!pPlayer[playerid][MessageInventory])
	    return 0;

	pPlayer[playerid][MessageInventory] = false;
	return PlayerTextDrawHide(playerid, inventario_mensagem[playerid]);
}
ResetPUBG(playerid)
{
    // Inventory

    for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
    {
        pInventory[playerid][invSlot][i] = 0;
        pInventory[playerid][invSlotAmount][i] = 0;
        pInventory[playerid][invArmourStatus][i] = 0;
	}
	pInventory[playerid][invSelectedSlot] = 0;

	// Character

	for(new i = 0; i < 7; i ++)
        pCharacter[playerid][charSlot][i] = 0;

	pCharacter[playerid][charArmourStatus] = 0;
	pCharacter[playerid][charSelectedSlot] = 0;


	// Player

	for(new enum_Player:i; i < enum_Player; ++i)
	    pPlayer[playerid][i] = 0;
}

LoadTextDraws()
{
    inventario_backgrounds[0] = TextDrawCreate(63.900207, 120.000030, "box");
	TextDrawLetterSize(inventario_backgrounds[0], 0.000000, 28.450004);
	TextDrawTextSize(inventario_backgrounds[0], 308.250335, 0.000000);
	TextDrawAlignment(inventario_backgrounds[0], 1);
	TextDrawColor(inventario_backgrounds[0], -1);
	TextDrawUseBox(inventario_backgrounds[0], 1);
	TextDrawBoxColor(inventario_backgrounds[0], 128);
	TextDrawSetShadow(inventario_backgrounds[0], 0);
	TextDrawSetOutline(inventario_backgrounds[0], 0);
	TextDrawBackgroundColor(inventario_backgrounds[0], 255);
	TextDrawFont(inventario_backgrounds[0], 2);
	TextDrawSetProportional(inventario_backgrounds[0], 1);
	TextDrawSetShadow(inventario_backgrounds[0], 0);

	inventario_backgrounds[1] = TextDrawCreate(313.099792, 120.000030, "box");
	TextDrawLetterSize(inventario_backgrounds[1], 0.000000, 28.450004);
	TextDrawTextSize(inventario_backgrounds[1], 578.247741, 0.000000);
	TextDrawAlignment(inventario_backgrounds[1], 1);
	TextDrawColor(inventario_backgrounds[1], -1);
	TextDrawUseBox(inventario_backgrounds[1], 1);
	TextDrawBoxColor(inventario_backgrounds[1], 128);
	TextDrawSetShadow(inventario_backgrounds[1], 0);
	TextDrawSetOutline(inventario_backgrounds[1], 0);
	TextDrawBackgroundColor(inventario_backgrounds[1], 255);
	TextDrawFont(inventario_backgrounds[1], 1);
	TextDrawSetProportional(inventario_backgrounds[1], 1);
	TextDrawSetShadow(inventario_backgrounds[1], 0);

	inventario_backgrounds[2] = TextDrawCreate(66.100158, 122.233367, "box");
	TextDrawLetterSize(inventario_backgrounds[2], 0.000000, 1.200001);
	TextDrawTextSize(inventario_backgrounds[2], 306.499542, 0.000000);
	TextDrawAlignment(inventario_backgrounds[2], 1);
	TextDrawColor(inventario_backgrounds[2], -1);
	TextDrawUseBox(inventario_backgrounds[2], 1);
	TextDrawBoxColor(inventario_backgrounds[2], 128);
	TextDrawSetShadow(inventario_backgrounds[2], 0);
	TextDrawSetOutline(inventario_backgrounds[2], 0);
	TextDrawBackgroundColor(inventario_backgrounds[2], 255);
	TextDrawFont(inventario_backgrounds[2], 1);
	TextDrawSetProportional(inventario_backgrounds[2], 1);
	TextDrawSetShadow(inventario_backgrounds[2], 0);

	inventario_backgrounds[3] = TextDrawCreate(314.599426, 122.233375, "box");
	TextDrawLetterSize(inventario_backgrounds[3], 0.000000, 1.200001);
	TextDrawTextSize(inventario_backgrounds[3], 576.602294, 0.000000);
	TextDrawAlignment(inventario_backgrounds[3], 1);
	TextDrawColor(inventario_backgrounds[3], -1);
	TextDrawUseBox(inventario_backgrounds[3], 1);
	TextDrawBoxColor(inventario_backgrounds[3], 128);
	TextDrawSetShadow(inventario_backgrounds[3], 0);
	TextDrawSetOutline(inventario_backgrounds[3], 0);
	TextDrawBackgroundColor(inventario_backgrounds[3], 255);
	TextDrawFont(inventario_backgrounds[3], 1);
	TextDrawSetProportional(inventario_backgrounds[3], 1);
	TextDrawSetShadow(inventario_backgrounds[3], 0);

	inventario_backgrounds[4] = TextDrawCreate(317.000000, 314.434112, "box");
	TextDrawLetterSize(inventario_backgrounds[4], 0.000000, 6.285005);
	TextDrawTextSize(inventario_backgrounds[4], 499.247772, 0.000000);
	TextDrawAlignment(inventario_backgrounds[4], 1);
	TextDrawColor(inventario_backgrounds[4], -1);
	TextDrawUseBox(inventario_backgrounds[4], 1);
	TextDrawBoxColor(inventario_backgrounds[4], 128);
	TextDrawSetShadow(inventario_backgrounds[4], 0);
	TextDrawSetOutline(inventario_backgrounds[4], 0);
	TextDrawBackgroundColor(inventario_backgrounds[4], 255);
	TextDrawFont(inventario_backgrounds[4], 1);
	TextDrawSetProportional(inventario_backgrounds[4], 1);
	TextDrawSetShadow(inventario_backgrounds[4], 0);

    inventario_usar = TextDrawCreate(504.388427, 312.249938, "");
	TextDrawLetterSize(inventario_usar, 0.000000, 0.000000);
	TextDrawTextSize(inventario_usar, 71.019790, 18.579967);
	TextDrawAlignment(inventario_usar, 1);
	TextDrawColor(inventario_usar, -1);
	TextDrawSetShadow(inventario_usar, 0);
	TextDrawSetOutline(inventario_usar, 0);
	TextDrawBackgroundColor(inventario_usar, 866792304);
	TextDrawFont(inventario_usar, 5);
	TextDrawSetProportional(inventario_usar, 0);
	TextDrawSetShadow(inventario_usar, 0);
	TextDrawSetPreviewModel(inventario_usar, 19382);
	TextDrawSetPreviewRot(inventario_usar, 0.000000, 0.000000, 0.000000, 1.000000);
	TextDrawSetSelectable(inventario_usar, true);

    inventario_split[0] = TextDrawCreate(504.593688, 333.316314, "");
	TextDrawLetterSize(inventario_split[0], 0.000000, 0.000000);
	TextDrawTextSize(inventario_split[0], 71.019790, 18.579967);
	TextDrawAlignment(inventario_split[0], 1);
	TextDrawColor(inventario_split[0], -1);
	TextDrawSetShadow(inventario_split[0], 0);
	TextDrawSetOutline(inventario_split[0], 0);
	TextDrawBackgroundColor(inventario_split[0], -65472);
	TextDrawFont(inventario_split[0], 5);
	TextDrawSetProportional(inventario_split[0], 0);
	TextDrawSetShadow(inventario_split[0], 0);
	TextDrawSetSelectable(inventario_split[0], true);
	TextDrawSetPreviewModel(inventario_split[0], 19382);
	TextDrawSetPreviewRot(inventario_split[0], 0.000000, 0.000000, 0.000000, 1.000000);

    inventario_drop[0] = TextDrawCreate(504.793701, 354.617614, "");
	TextDrawLetterSize(inventario_drop[0], 0.000000, 0.000000);
	TextDrawTextSize(inventario_drop[0], 71.019790, 18.579967);
	TextDrawAlignment(inventario_drop[0], 1);
	TextDrawColor(inventario_drop[0], -1);
	TextDrawSetShadow(inventario_drop[0], 0);
	TextDrawSetOutline(inventario_drop[0], 0);
	TextDrawBackgroundColor(inventario_drop[0], 0xAA333370);
	TextDrawFont(inventario_drop[0], 5);
	TextDrawSetProportional(inventario_drop[0], 0);
	TextDrawSetShadow(inventario_drop[0], 0);
	TextDrawSetSelectable(inventario_drop[0], true);
	TextDrawSetPreviewModel(inventario_drop[0], 19382);
	TextDrawSetPreviewRot(inventario_drop[0], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_remover = TextDrawCreate(149.847900, 344.867553, "");
	TextDrawLetterSize(inventario_remover, 0.000000, 0.000000);
	TextDrawTextSize(inventario_remover, 76.040008, 19.899997);
	TextDrawAlignment(inventario_remover, 1);
	TextDrawColor(inventario_remover, -1);
	TextDrawSetShadow(inventario_remover, 0);
	TextDrawSetOutline(inventario_remover, 0);
	TextDrawBackgroundColor(inventario_remover, 0xAA333370);
	TextDrawFont(inventario_remover, 5);
	TextDrawSetProportional(inventario_remover, 0);
	TextDrawSetShadow(inventario_remover, 0);
	TextDrawSetSelectable(inventario_remover, true);
	TextDrawSetPreviewModel(inventario_remover, 19382);
	TextDrawSetPreviewRot(inventario_remover, 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_split[1] = TextDrawCreate(540.294372, 334.449981, "split");
	TextDrawLetterSize(inventario_split[1], 0.400000, 1.600000);
	TextDrawAlignment(inventario_split[1], 2);
	TextDrawColor(inventario_split[1], -1);
	TextDrawSetShadow(inventario_split[1], 0);
	TextDrawSetOutline(inventario_split[1], 0);
	TextDrawBackgroundColor(inventario_split[1], 255);
	TextDrawFont(inventario_split[1], 2);
	TextDrawSetProportional(inventario_split[1], 1);
	TextDrawSetShadow(inventario_split[1], 0);
	TextDrawSetSelectable(inventario_split[1], false);

	inventario_drop[1] = TextDrawCreate(540.762878, 355.451263, "drop");
	TextDrawLetterSize(inventario_drop[1], 0.400000, 1.600000);
	TextDrawAlignment(inventario_drop[1], 2);
	TextDrawColor(inventario_drop[1], -1);
	TextDrawSetShadow(inventario_drop[1], 0);
	TextDrawSetOutline(inventario_drop[1], 0);
	TextDrawBackgroundColor(inventario_drop[1], 255);
	TextDrawFont(inventario_drop[1], 2);
	TextDrawSetProportional(inventario_drop[1], 1);
	TextDrawSetShadow(inventario_drop[1], 0);
	TextDrawSetSelectable(inventario_drop[1], false);

	inventario_close[1] = TextDrawCreate(565.100341, 119.433311, "X");
	TextDrawTextSize(inventario_close[1], 574.999511, 0.000000);
	TextDrawLetterSize(inventario_close[1], 0.400000, 1.600000);
	TextDrawAlignment(inventario_close[1], 1);
	TextDrawColor(inventario_close[1], -1);
	TextDrawSetShadow(inventario_close[1], 0);
	TextDrawSetOutline(inventario_close[1], 0);
	TextDrawBackgroundColor(inventario_close[1], 255);
	TextDrawFont(inventario_close[1], 2);
	TextDrawSetProportional(inventario_close[1], 1);
	TextDrawSetShadow(inventario_close[1], 0);
	TextDrawSetSelectable(inventario_close[1], true);

	inventario_close[0] = TextDrawCreate(564.079284, 120.583320, "");
	TextDrawLetterSize(inventario_close[0], 0.000000, 0.000000);
	TextDrawTextSize(inventario_close[0], 14.000000, 14.000000);
	TextDrawAlignment(inventario_close[0], 1);
	TextDrawColor(inventario_close[0], -1);
	TextDrawSetShadow(inventario_close[0], 0);
	TextDrawSetOutline(inventario_close[0], 0);
	TextDrawBackgroundColor(inventario_close[0], 80);
	TextDrawFont(inventario_close[0], 5);
	TextDrawSetProportional(inventario_close[0], 0);
	TextDrawSetShadow(inventario_close[0], 0);
	TextDrawSetSelectable(inventario_close[0], true);
	TextDrawSetPreviewModel(inventario_close[0], 19382);
	TextDrawSetPreviewRot(inventario_close[0], 0.000000, 0.000000, 0.000000, 1.000000);

	Restrict_TD = TextDrawCreate(319.195220, 313.980010, "restricting_The_Play_Area_In_30_Seconds!");
	TextDrawLetterSize(Restrict_TD, 0.230476, 1.988266);
	TextDrawAlignment(Restrict_TD, 2);
	TextDrawColor(Restrict_TD, -2210049);
	TextDrawSetShadow(Restrict_TD, 0);
	TextDrawSetOutline(Restrict_TD, 1);
	TextDrawBackgroundColor(Restrict_TD, 0);
	TextDrawFont(Restrict_TD, 2);
	TextDrawSetProportional(Restrict_TD, 1);
	TextDrawSetShadow(Restrict_TD, 0);

	Start_TD = TextDrawCreate(319.333251, 253.999938, "MATCH_STARTS_IN~n~40");
	TextDrawLetterSize(Start_TD, 0.358095, 1.608533);
	TextDrawAlignment(Start_TD, 2);
	TextDrawColor(Start_TD, -1962934273);
	TextDrawSetShadow(Start_TD, 0);
	TextDrawSetOutline(Start_TD, 0);
	TextDrawBackgroundColor(Start_TD, 255);
	TextDrawFont(Start_TD, 2);
	TextDrawSetProportional(Start_TD, 1);
	TextDrawSetShadow(Start_TD, 0);


	PUBG_TD[0] = TextDrawCreate(589.428344, 1.413357, "Alive");
	TextDrawLetterSize(PUBG_TD[0], 0.270094, 1.378134);
	TextDrawTextSize(PUBG_TD[0], 624.000000, 0.000000);
	TextDrawAlignment(PUBG_TD[0], 1);
	TextDrawColor(PUBG_TD[0], 183);
	TextDrawUseBox(PUBG_TD[0], 1);
	TextDrawBoxColor(PUBG_TD[0], -2139062114);
	TextDrawSetShadow(PUBG_TD[0], 0);
	TextDrawSetOutline(PUBG_TD[0], 0);
	TextDrawBackgroundColor(PUBG_TD[0], 164);
	TextDrawFont(PUBG_TD[0], 2);
	TextDrawSetProportional(PUBG_TD[0], 1);
	TextDrawSetShadow(PUBG_TD[0], 0);
	PUBG_TD[1] = TextDrawCreate(569.037658, 1.460008, "02");
	TextDrawLetterSize(PUBG_TD[1], 0.329522, 1.433598);
	TextDrawTextSize(PUBG_TD[1], 586.400146, 0.000000);
	TextDrawAlignment(PUBG_TD[1], 1);
	TextDrawColor(PUBG_TD[1], -1);
	TextDrawUseBox(PUBG_TD[1], 1);
	TextDrawBoxColor(PUBG_TD[1], 255);
	TextDrawSetShadow(PUBG_TD[1], 0);
	TextDrawSetOutline(PUBG_TD[1], 0);
	TextDrawBackgroundColor(PUBG_TD[1], 255);
	TextDrawFont(PUBG_TD[1], 2);
	TextDrawSetProportional(PUBG_TD[1], 1);
	TextDrawSetShadow(PUBG_TD[1], 0);

	PUBG_TD[2] = TextDrawCreate(525.865661, 2.040024, "KILLED");
	TextDrawLetterSize(PUBG_TD[2], 0.270094, 1.378134);
	TextDrawTextSize(PUBG_TD[2], 563.000000, 0.000000);
	TextDrawAlignment(PUBG_TD[2], 1);
	TextDrawColor(PUBG_TD[2], 218);
	TextDrawUseBox(PUBG_TD[2], 1);
	TextDrawBoxColor(PUBG_TD[2], -2139062124);
	TextDrawSetShadow(PUBG_TD[2], 0);
	TextDrawSetOutline(PUBG_TD[2], 0);
	TextDrawBackgroundColor(PUBG_TD[2], 164);
	TextDrawFont(PUBG_TD[2], 2);
	TextDrawSetProportional(PUBG_TD[2], 1);
	TextDrawSetShadow(PUBG_TD[2], 0);
}

//----------------------------------------------------------

LoadPlayerTextDraws(playerid)
{

	PUBG_DIED[playerid][0] = CreatePlayerTextDraw(playerid, -29.999980, -64.293319, "box");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][0], 0.000000, 64.285705);
	PlayerTextDrawTextSize(playerid, PUBG_DIED[playerid][0], 802.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][0], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, PUBG_DIED[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, PUBG_DIED[playerid][0], 140);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][0], 74);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][0], 0);

	PUBG_DIED[playerid][1] = CreatePlayerTextDraw(playerid, 28.423789, 95.106704, "YOUR_NAME");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][1], 0.834666, 3.140266);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][1], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][1], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][1], 0);

	PUBG_DIED[playerid][2] = CreatePlayerTextDraw(playerid, 31.604568, 124.172889, "BETTER LUCK NEXT TIME!");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][2], 0.397333, 1.706666);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][2], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][2], -3669761);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][2], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][2], 0);

	PUBG_DIED[playerid][3] = CreatePlayerTextDraw(playerid, 32.757160, 160.133361, "RANK_#2");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][3], 0.411047, 1.907199);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][3], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][3], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][3], 0);

	PUBG_DIED[playerid][4] = CreatePlayerTextDraw(playerid, 114.309593, 160.006713, "KILL_8");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][4], 0.411047, 1.907199);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][4], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][4], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][4], 0);

	PUBG_DIED[playerid][5] = CreatePlayerTextDraw(playerid, 157.243026, 169.433135, "players");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][5], 0.178285, 0.678400);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][5], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][5], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][5], 0);

	PUBG_DIED[playerid][6] = CreatePlayerTextDraw(playerid, 327.176208, 158.646789, "REWARD_~y~GP~w~_500");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][6], 0.439619, 2.103465);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][6], 3);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][6], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][6], 0);

	PUBG_DIED[playerid][7] = CreatePlayerTextDraw(playerid, 33.561901, 181.486358, "box");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][7], 0.000000, -0.307240);
	PlayerTextDrawTextSize(playerid, PUBG_DIED[playerid][7], 96.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][7], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][7], -1);
	PlayerTextDrawUseBox(playerid, PUBG_DIED[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid, PUBG_DIED[playerid][7], -2139062017);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][7], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][7], 0);

	PUBG_DIED[playerid][8] = CreatePlayerTextDraw(playerid, 115.960647, 180.986328, "box");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][8], -0.000380, -0.302973);
	PlayerTextDrawTextSize(playerid, PUBG_DIED[playerid][8], 188.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][8], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][8], -1);
	PlayerTextDrawUseBox(playerid, PUBG_DIED[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid, PUBG_DIED[playerid][8], -2139062017);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][8], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][8], 0);

	PUBG_DIED[playerid][9] = CreatePlayerTextDraw(playerid, 209.541473, 181.039611, "box");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][9], -0.000380, -0.302973);
	PlayerTextDrawTextSize(playerid, PUBG_DIED[playerid][9], 325.000000, -0.029999);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][9], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, PUBG_DIED[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, PUBG_DIED[playerid][9], -2139062017);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][9], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][9], 0);

	PUBG_DIED[playerid][10] = CreatePlayerTextDraw(playerid, 209.580932, 185.733337, "RANK_POINTS__________________________________________________________100");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][10], 0.113142, 0.652799);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][10], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][10], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][10], 0);

	PUBG_DIED[playerid][11] = CreatePlayerTextDraw(playerid, 209.580932, 193.933837, "KILL_POINTS____________________________________________________________100");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][11], 0.113142, 0.652799);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][11], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][11], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][11], 0);


	PUBG_DIED[playerid][12]= CreatePlayerTextDraw(playerid, 416.214294, 86.546722, "#22");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][12], 0.736761, 5.239468);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][12], 2);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][12], -2752370);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][12], -5963521);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][12], 0);

	PUBG_DIED[playerid][13]= CreatePlayerTextDraw(playerid, 443.904785, 102.960052, "/25");
	PlayerTextDrawLetterSize(playerid, PUBG_DIED[playerid][13], 0.600380, 2.820264);
	PlayerTextDrawAlignment(playerid, PUBG_DIED[playerid][13], 1);
	PlayerTextDrawColor(playerid, PUBG_DIED[playerid][13], 1988132992);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, PUBG_DIED[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, PUBG_DIED[playerid][13], 255);
	PlayerTextDrawFont(playerid, PUBG_DIED[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, PUBG_DIED[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, PUBG_DIED[playerid][13], 0);

	PKILLS[playerid] = CreatePlayerTextDraw(playerid, 505.656341, 1.686673, "29");
	PlayerTextDrawLetterSize(playerid, PKILLS[playerid], 0.329522, 1.433598);
	PlayerTextDrawTextSize(playerid, PKILLS[playerid], 522.900024, 0.000000);
	PlayerTextDrawAlignment(playerid, PKILLS[playerid], 1);
	PlayerTextDrawColor(playerid, PKILLS[playerid], -1);
	PlayerTextDrawUseBox(playerid, PKILLS[playerid], 1);
	PlayerTextDrawBoxColor(playerid, PKILLS[playerid], 255);
	PlayerTextDrawSetShadow(playerid, PKILLS[playerid], 0);
	PlayerTextDrawSetOutline(playerid, PKILLS[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, PKILLS[playerid], 255);
	PlayerTextDrawFont(playerid, PKILLS[playerid], 2);
	PlayerTextDrawSetProportional(playerid, PKILLS[playerid], 1);
	PlayerTextDrawSetShadow(playerid, PKILLS[playerid], 0);


    inventario_index[playerid][0] = CreatePlayerTextDraw(playerid, 315.500152, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][0], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][0], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][0], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][0], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][0], 0.000000, -30, 0.000000, 2.2);

	inventario_index[playerid][1] = CreatePlayerTextDraw(playerid, 368.803405, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][1], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][1], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][1], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][1], 0.000000, -30, 0.000000, 2.2);

    inventario_index[playerid][10] = CreatePlayerTextDraw(playerid, 315.500152, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][10], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][10], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][10], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][10], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][10], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][5] = CreatePlayerTextDraw(playerid, 315.500152, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][5], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][5], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][5], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][5], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][2] = CreatePlayerTextDraw(playerid, 422.506683, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][2], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][2], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][2], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][2], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][2], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][3] = CreatePlayerTextDraw(playerid, 475.509918, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][3], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][3], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][3], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][3], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][4] = CreatePlayerTextDraw(playerid, 528.508117, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][4], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][4], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][4], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][4], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][6] = CreatePlayerTextDraw(playerid, 368.903411, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][6], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][6], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][6], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][6], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][7] = CreatePlayerTextDraw(playerid, 422.406677, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][7], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][7], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][7], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][7], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][7], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][7], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][8] = CreatePlayerTextDraw(playerid, 476.009948, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][8], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][8], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][8], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][8], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][8], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][8], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][9] = CreatePlayerTextDraw(playerid, 528.908020, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][9], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][9], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][9], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][9], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][9], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][9], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][11] = CreatePlayerTextDraw(playerid, 369.203430, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][11], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][11], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][11], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][11], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][11], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][11], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][12] = CreatePlayerTextDraw(playerid, 422.806701, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][12] , 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][12] , 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][12] , 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][12] , -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][12] , 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][12] , 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][12], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][12], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][12], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][12], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][13] = CreatePlayerTextDraw(playerid, 476.209960, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][13], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][13], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][13], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][13], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][13], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][13], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][13], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][13], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][14] = CreatePlayerTextDraw(playerid, 529.507873, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][14], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][14], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][14], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][14], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid,inventario_index[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][14], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][14], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][14], 0.000000, 0.000000, 0.000000, 1.000000);

    inventario_skin[playerid] = CreatePlayerTextDraw(playerid, 73.300109, 138.366668, "");
	PlayerTextDrawLetterSize(playerid, inventario_skin[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_skin[playerid], 227.000000, 202.000000);
	PlayerTextDrawAlignment(playerid, inventario_skin[playerid], 1);
	PlayerTextDrawColor(playerid, inventario_skin[playerid], -1);
	PlayerTextDrawSetShadow(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_skin[playerid], 43520);
	PlayerTextDrawFont(playerid, inventario_skin[playerid], 5);
	PlayerTextDrawSetProportional(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetShadow(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventario_skin[playerid], 0.000000, 0.000000, 0.000000, 1.000000);

    inventario_textos[playerid][0] = CreatePlayerTextDraw(playerid, 68.199996, 120.716636, "personagem");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][0], 0.326999, 1.284999);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][0], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][0], 0);

	inventario_textos[playerid][1] = CreatePlayerTextDraw(playerid, 315.710540, 120.716636, ConvertToGameText("Seu inventário"));
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][1], 0.326999, 1.284999);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][1], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][1], 0);

	inventario_textos[playerid][2] = CreatePlayerTextDraw(playerid, 248.200164, 144.800033, ConvertToGameText("Cabeça"));
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][2], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][2], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][2], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][2], 0);

	inventario_textos[playerid][3] = CreatePlayerTextDraw(playerid, 247.399932, 189.833389, "mochila");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][3], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][3], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][3], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][3], 0);

	inventario_textos[playerid][4] = CreatePlayerTextDraw(playerid, 128.199707, 180.250152, "corpo");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][4], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][4], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][4], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][4], 0);

	inventario_textos[playerid][5] = CreatePlayerTextDraw(playerid, 127.499824, 232.683532, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][5], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][5], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][5], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][5], 0);

	inventario_textos[playerid][6] = CreatePlayerTextDraw(playerid, 247.099945, 236.100448, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][6], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][6], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][6], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][6], 0);

	inventario_textos[playerid][7] = CreatePlayerTextDraw(playerid, 246.600036, 285.667083, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][7], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][7], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][7], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][7], 0);

	inventario_textos[playerid][8] = CreatePlayerTextDraw(playerid, 127.800155, 284.950317, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][8], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][8], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][8], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][8], 0);

	inventario_description[playerid][0] = CreatePlayerTextDraw(playerid, 317.699981, 314.833312, "");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_description[playerid][0], 65.000000, 56.000000);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_description[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][0], -208);
	PlayerTextDrawFont(playerid, inventario_description[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, inventario_description[playerid][0], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_description[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);
    PlayerTextDrawSetSelectable(playerid, inventario_description[playerid][0], true);

	inventario_description[playerid][1] = CreatePlayerTextDraw(playerid, 388.099884, 314.099884, "CAPACETE");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][1], 0.290499, 1.226665);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_description[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][1], 255);
	PlayerTextDrawFont(playerid, inventario_description[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][1], 0);

	inventario_description[playerid][2] = CreatePlayerTextDraw(playerid, 388.699920, 330.400878, "PROTEGE_CONTRA_HEADSHOTS");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][2], 0.157499, 0.882498);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][2], 1);
	PlayerTextDrawColor(playerid, inventario_description[playerid][2], -168430192);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][2], 255);
	PlayerTextDrawFont(playerid, inventario_description[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][2], 0);

	inventario_description[playerid][3] = CreatePlayerTextDraw(playerid, 499.401489, 363.984985, "QUANTIDADE:_1");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][3], 0.157499, 0.882498);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][3], 3);
	PlayerTextDrawColor(playerid, inventario_description[playerid][3], -168430208);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][3], 255);
	PlayerTextDrawFont(playerid, inventario_description[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][3], 0);

	inventario_textos[playerid][9] = CreatePlayerTextDraw(playerid, 540.294372, 313.548706, "usar");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][9], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][9], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][9], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_textos[playerid][9], false);

    inventario_personagemindex[playerid][0] = CreatePlayerTextDraw(playerid, 231.000305, 153.250015, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][0], 33.000000, 32.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][0], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][0], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);
    PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][0], true);

	inventario_personagemindex[playerid][1] = CreatePlayerTextDraw(playerid, 110.600074, 189.283264, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][1], 33.000000, 32.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][1], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][1], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][2] = CreatePlayerTextDraw(playerid, 230.500000, 198.749984, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][2], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][2], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][2], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][2], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][2], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][3] = CreatePlayerTextDraw(playerid, 110.400032, 242.366851, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][3], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][3], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][3], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][3], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][4] = CreatePlayerTextDraw(playerid, 230.405273, 244.750305, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][4], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][4], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][4], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][4], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][5] = CreatePlayerTextDraw(playerid, 230.505279, 294.150360, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][5], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][5], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][5], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][5], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][6] = CreatePlayerTextDraw(playerid, 110.400032, 294.070007, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][6], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][6], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][6], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][6], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_textos[playerid][10] = CreatePlayerTextDraw(playerid, 187.721237, 347.616729, "REMOVE");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][10], 0.325504, 1.407498);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][10], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][10], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][10], 0);

	inventario_mensagem[playerid] = CreatePlayerTextDraw(playerid, 321.224029, 381.983398, "error_msg");
	PlayerTextDrawLetterSize(playerid, inventario_mensagem[playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, inventario_mensagem[playerid], 2);
	PlayerTextDrawColor(playerid, inventario_mensagem[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, inventario_mensagem[playerid], 0);
	PlayerTextDrawSetOutline(playerid, inventario_mensagem[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, inventario_mensagem[playerid], 255);
	PlayerTextDrawFont(playerid, inventario_mensagem[playerid], 2);
	PlayerTextDrawSetProportional(playerid, inventario_mensagem[playerid], 1);
	PlayerTextDrawSetShadow(playerid, inventario_mensagem[playerid], 0);

}
DropAll(playerid)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	{
        new slot = i;
        new itemid = pInventory[playerid][invSlot][slot];
		if(itemid != 0)
		{
	        new amount = pInventory[playerid][invSlotAmount][slot];
	        new Float:armourstatus = pInventory[playerid][invArmourStatus][slot];
			if(Itens[itemid][item_canbedropped])
			{

				if(itemid == 6 || itemid == 24 || itemid == 25)
					DropItem(pos[0], pos[1], pos[2], itemid, amount, armourstatus);
				else
			    	DropItem(pos[0], pos[1], pos[2], itemid, amount);

				RemoveItemFromInventory(playerid, slot);

			   	for(new a = 0; a < 4; a++) PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

				TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);
			}
			new selected = i;
	        if(selected == 1)
			DropItem(pos[0], pos[1], pos[2], pCharacter[playerid][charSlot][selected], 1 , pCharacter[playerid][charArmourStatus]);
	        else if(Itens[pCharacter[playerid][charSlot][selected]][items_id] == 5 || Itens[pCharacter[playerid][charSlot][selected]][items_id] == 17 || Itens[pCharacter[playerid][charSlot][selected]][items_id] == 23)
	        {
		        new weapons[13][2];
		        for (new s = 0; s <= 12; s++)
				GetPlayerWeaponData(playerid, s, weapons[s][0], weapons[s][1]);
	            DropItem(pos[0], pos[1], pos[2], pCharacter[playerid][charSlot][selected], weapons[8][1]);
			}
	        else
	       	DropItem(pos[0], pos[1], pos[2], pCharacter[playerid][charSlot][selected], 1);
	        RemoveItemFromCharacter(playerid, selected);
		}
	}
	return 1;
}

CreateForceField(gangzone[4], &area, color, Float:size, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	new Float:ptmp;
	if (maxx < minx)
	{
	    ptmp = maxx;
	    maxx = minx;
	    minx = ptmp;
	}
	if (maxy < miny)
	{
	    ptmp = maxy;
	    maxy = miny;
	    miny = ptmp;
	}
    GangZoneDestroy(gangzone[0]);
	GangZoneDestroy(gangzone[1]);
	GangZoneDestroy(gangzone[2]);
	GangZoneDestroy(gangzone[3]);

    size *= 3;
    gangzone[0] = GangZoneCreate((minx - size), miny, (minx + size), maxy);
	gangzone[1] = GangZoneCreate((minx - size), (maxy - size), maxx, (maxy + size));
	gangzone[2] = GangZoneCreate((maxx - size), miny, (maxx + size), maxy);
	gangzone[3] = GangZoneCreate((minx - size), (miny - size), maxx, (miny + size));



	Streamer_SetFloatData(STREAMER_TYPE_AREA, area, E_STREAMER_MIN_X, minx);
	Streamer_SetFloatData(STREAMER_TYPE_AREA, area, E_STREAMER_MIN_Y, miny);
	Streamer_SetFloatData(STREAMER_TYPE_AREA, area, E_STREAMER_MAX_X, maxx);
	Streamer_SetFloatData(STREAMER_TYPE_AREA, area, E_STREAMER_MAX_Y, maxy);
	foreach (new i : Player)
	{
	    if(eInfo[i][inPUBG] == 1 && PUBG[Start] == 2)
	    {
			GangZoneShowForPlayer(i,gangzone[0], color);
			GangZoneShowForPlayer(i,gangzone[1], color);
			GangZoneShowForPlayer(i,gangzone[2], color);
			GangZoneShowForPlayer(i,gangzone[3], color);
		    Streamer_Update(i, STREAMER_TYPE_AREA);
		}
	}
	return 1;
}

ForceField_Init(Float:red_minx, Float:red_miny, Float:red_maxx, Float:red_maxy, Float:white_minx, Float:white_miny, Float:white_maxx, Float:white_maxy)
{
    announcementTextDraw = TextDrawCreate(319.000000, 230.000000, "-");
	TextDrawAlignment(announcementTextDraw, 2);
	TextDrawBackgroundColor(announcementTextDraw, 255);
	TextDrawFont(announcementTextDraw, 2);
	TextDrawLetterSize(announcementTextDraw, 0.389999, 2.199997);
	TextDrawColor(announcementTextDraw, 297271295);
	TextDrawSetOutline(announcementTextDraw, 1);
	TextDrawSetProportional(announcementTextDraw, 1);
	TextDrawSetSelectable(announcementTextDraw, 0);

	countDownTextDraw = TextDrawCreate(42.000000, 300.000000, "Next Zone Reduction: -:-");
	TextDrawBackgroundColor(countDownTextDraw, 255);
	TextDrawFont(countDownTextDraw, 1);
	TextDrawLetterSize(countDownTextDraw, 0.280000, 1.599997);
	TextDrawColor(countDownTextDraw, -1);
	TextDrawSetOutline(countDownTextDraw, 1);
	TextDrawSetProportional(countDownTextDraw, 1);
	TextDrawSetSelectable(countDownTextDraw, 0);

    redField[0] = red_minx;
    redField[1] = red_miny;
    redField[2] = red_maxx;
    redField[3] = red_maxy;

    whiteField[0] = white_minx;
    whiteField[1] = white_miny;
    whiteField[2] = white_maxx;
    whiteField[3] = white_maxy;

    bloodFaderTextDraw = TextDrawCreate(0.0, 0.0, "~r~");
	TextDrawTextSize(bloodFaderTextDraw, 640.0, 480.0);
	TextDrawLetterSize(bloodFaderTextDraw, 0.0, 50.0);
	TextDrawUseBox(bloodFaderTextDraw, 1);

    redAreaid = CreateDynamicRectangle(redField[0], redField[1], redField[2], redField[3]);
    CreateForceField(redForcefield, redAreaid, 0x1624e2FF, 1, redField[0], redField[1], redField[2], redField[3]);

    whiteAreaid = CreateDynamicRectangle(whiteField[0], whiteField[1], whiteField[2], whiteField[3]);
    CreateForceField(whiteForcefield, whiteAreaid, 0xFFFFFFFF, 1, whiteField[0], whiteField[1], whiteField[2], whiteField[3]);

    reductionTimer = SetTimer("OnForceFieldReduce", 100, true);
    secondsPast = 0;
	return 1;
}


ForceField_Exit()
{
	TextDrawDestroy(announcementTextDraw);
	TextDrawDestroy(countDownTextDraw);

	KillTimer(reductionTimer);
	reductionTimer = - 1;

	foreach (new i : Player)
	{
	    TextDrawStopBoxFadeForPlayer(i, bloodFaderTextDraw);
	}
	TextDrawDestroy(bloodFaderTextDraw);
	bloodFaderTextDraw = Text:INVALID_TEXT_DRAW;
	DestroyDynamicArea(redAreaid);
	DestroyDynamicArea(whiteAreaid);
	return 1;
}

forward OnForceFieldReduce();
public OnForceFieldReduce()
{
	CountPlayers();
	secondsPast += 100;
	new seconds = ((reductionTimerCountdown[reductionIndex] / 1000) - (secondsPast / 1000));
	if(secondsPast == 30*1000)
	{
  		if(PUBG[GasPart] == 0)
		{
			new Random = random(sizeof(cPSpawn1));
			CreateCarePackageForPlayer(cPSpawn1[Random][PosX], cPSpawn1[Random][PosY],cPSpawn1[Random][PosZ]);
		}
 	    if(PUBG[GasPart] == 1)
		{
			new Random = random(sizeof(cPSpawn2));
			CreateCarePackageForPlayer(cPSpawn2[Random][PosX], cPSpawn2[Random][PosY],cPSpawn2[Random][PosZ]);
		}
 	    if(PUBG[GasPart] == 2)
		{
			new Random = random(sizeof(cPSpawn3));
			CreateCarePackageForPlayer(cPSpawn3[Random][PosX], cPSpawn3[Random][PosY],cPSpawn3[Random][PosZ]);
		}
 	    if(PUBG[GasPart] == 3)
		{
			new Random = random(sizeof(cPSpawn4));
			CreateCarePackageForPlayer(cPSpawn4[Random][PosX], cPSpawn4[Random][PosY],cPSpawn4[Random][PosZ]);
		}
 	    if(PUBG[GasPart] == 4)
		{
			new Random = random(sizeof(cPSpawn5));
			CreateCarePackageForPlayer(cPSpawn5[Random][PosX], cPSpawn5[Random][PosY],cPSpawn5[Random][PosZ]);
		}
	    if(PUBG[GasPart] == 5)
		{
			new Random = random(sizeof(cPSpawn6));
			CreateCarePackageForPlayer(cPSpawn6[Random][PosX], cPSpawn6[Random][PosY],cPSpawn6[Random][PosZ]);
		}
		PUBG[GasPart]++;
	}
	if(seconds == 0)
	{
		TextDrawSetString(Restrict_TD,"Restricting_the_play_area..");
		ShowRestrictTD2();
	}
	if(seconds == 10)
	{
		TextDrawSetString(Restrict_TD,"Restricting_the_play_area in 10 seconds");
		ShowRestrictTD();
	}
	if(seconds == 30)
	{
		TextDrawSetString(Restrict_TD,"Restricting_the_play_area in 30 seconds");
		ShowRestrictTD();
	}
	if(seconds == 60)
	{
		TextDrawSetString(Restrict_TD,"Restricting_the_play_area in 60 seconds");
		ShowRestrictTD();
	}
    if (secondsPast < reductionTimerCountdown[reductionIndex]) { return; }

    const updaterate = 20;

	new closed;
	new Float:diff;
	for (new i; i < 4; i++)
	{
	    if (redField[i] > whiteField[i])
	    {
	        diff = floatabs(redField[i] - whiteField[i]);
	        if (diff < 5.0)
	        {
	            redField[i] = whiteField[i];
	        }
	        else
	        {
	        	redField[i] -= diff / updaterate;
			}

	        if (redField[i] <= whiteField[i])
	        {
	            closed++;
	        }
	    }
	    else if (redField[i] < whiteField[i])
	    {
	        diff = floatabs(whiteField[i] - redField[i]);
			if (diff < 5.0)
	        {
	            redField[i] = whiteField[i];
	        }
	        else
	        {
	        	redField[i] += diff / updaterate;
			}

	        if (redField[i] >= whiteField[i])
	        {
	            closed++;
	        }
	    }
	    else
	    {
	        closed++;
	        continue;
	    }

	    CreateForceField(redForcefield, redAreaid, 0x1624e2FF, 1, redField[0], redField[1], redField[2], redField[3]);
	}

	if (closed == 4)
	{
	    diff = floatabs(whiteField[2] - whiteField[0]);
	    whiteField[0] += diff / reductionNumbers[reductionIndex][random(sizeof reductionNumbers[])];
	    whiteField[2] -= diff / reductionNumbers[reductionIndex][random(sizeof reductionNumbers[])];

		diff = floatabs(whiteField[3] - whiteField[1]);
	    whiteField[1] += diff / reductionNumbers[reductionIndex][random(sizeof reductionNumbers[])];
	    whiteField[3] -= diff / reductionNumbers[reductionIndex][random(sizeof reductionNumbers[])];

	    CreateForceField(whiteForcefield, whiteAreaid, 0xFFFFFFFF, 1, whiteField[0], whiteField[1], whiteField[2], whiteField[3]);

		KillTimer(reductionTimer);
	    if (reductionIndex == sizeof reductionTimerCountdown)
		{
		    return;
		}

        reductionIndex++;
		reductionTimer = SetTimerEx("OnForceFieldReduce", 100, true, "ii", reductionTimerCountdown[reductionIndex], reductionIndex);
		secondsPast = 0;
	}
}
