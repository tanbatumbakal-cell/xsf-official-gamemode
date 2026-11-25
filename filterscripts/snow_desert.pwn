/*  snow_desert.pwn
 *
 *  (c) Copyright 2015-2016, Emilijo "Correlli" Lovrich
 *
 *  Credits: - Incognito for streamer plugin.
*/

#include "a_samp"
#include "streamer"

/*

	snow:			17944, "lngblok_lae2", "white64bumpy"
					3914, "snow", "mp_snow"

	sand:			16102, "des_cen", "sandgrnd128"
					6281, "santamonicalaw2", "sandnew_law"
					16086, "des_refinery", "des_ripplsand"

	grass:			9530, "sandy_sfw", "Grass_128HV"

	water:			3947, "rczero_track", "waterclear256"

	colored:		8839, "vgsecarshow", "lightblue2_32"
					1676, "wshxrefpump", "black64"

*/

stock AddSnowObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new
			object = CreateDynamicObject(modelid, (x + 0.15), (y + 0.3), (z + 0.15), rx, ry, rz, .streamdistance = 300.0);
	for(new a = 0; a < 30; a++)
		SetDynamicObjectMaterial(object, a, 17944, "lngblok_lae2", "white64bumpy");
	return object;
}

stock AddSnowObjects()
{
	AddSnowObject(16149, -175.98438, 1361.79688, 40.96875, 0.0, 0.0, 0.0);
	AddSnowObject(16026, -138.29688, 1283.39063, 21.92188, 0.0, 0.0, 0.0);
	AddSnowObject(16147, -190.31250, 1565.30469, 42.46094, 0.0, 0.0, 0.0);
	AddSnowObject(16141, -166.05470, 1395.78906, 12.71090, 0.0, 0.0, 150.5);
	AddSnowObject(16114, -164.52344, 1484.16406, 20.81250, 0.0, 0.0, 0.0);
	AddSnowObject(16110, -167.27344, 1507.70313, 26.80469, 0.0, 0.0, 0.0);
	AddSnowObject(16116, -207.67188, 1585.81250, 15.76563, 0.0, 0.0, 0.0);
	AddSnowObject(16117, -235.47656, 1603.49219, 32.58594, 0.0, 0.0, 0.0);
	AddSnowObject(16113, -285.98438, 1644.30469, 23.59375, 0.0, 0.0, 0.0);
	AddSnowObject(16148, -352.28125, 1577.53906, 52.26563, 0.0, 0.0, 0.0);
	AddSnowObject(16207, -271.53906, 1740.46875, 57.78906, 0.0, 0.0, 0.0);
	AddSnowObject(16115, -236.59375, 1702.45313, 32.70313, 0.0, 0.0, 0.0);
	AddSnowObject(16118, -132.39844, 1632.65625, 12.71094, 0.0, 0.0, 0.0);
	AddSnowObject(16208, -36.53125, 1721.21875, 26.19531, 0.0, 0.0, 0.0);
	AddSnowObject(16230, -7.14844, 1540.70313, 19.08594, 0.0, 0.0, 0.0);
	AddSnowObject(16235, 26.84375, 1312.51563, 14.52344, 0.0, 0.0, 0.0);
	AddSnowObject(16231, 228.44531, 1526.74219, 19.93750, 0.0, 0.0, 0.0);
	AddSnowObject(16209, 205.49219, 1730.35156, 17.82813, 0.0, 0.0, 0.0);
	AddSnowObject(16210, 362.71094, 1730.35156, 25.99219, 0.0, 0.0, 0.0);
	AddSnowObject(16391, 239.29688, 1367.99219, 11.83594, 0.0, 0.0, 0.0);
	AddSnowObject(16236, 252.25000, 1318.59375, 13.70313, 0.0, 0.0, 0.0);
	AddSnowObject(16394, 238.27344, 1452.93750, 11.83594, 0.0, 0.0, 0.0);
	AddSnowObject(16232, 445.21875, 1555.75000, 19.08594, 0.0, 0.0, 0.0);
	AddSnowObject(16102, 504.57813, 1742.17969, 22.42188, 0.0, 0.0, 0.0);
	AddSnowObject(16191, 619.89844, 1724.10156, 7.92969, 0.0, 0.0, 0.0);
	AddSnowObject(16233, 643.88281, 1591.89063, 10.26563, 0.0, 0.0, 0.0);
	AddSnowObject(16237, 441.97656, 1327.25781, 11.83594, 0.0, 0.0, 0.0);
	AddSnowObject(16250, 643.46875, 1456.92188, 9.22656, 0.0, 0.0, 0.0);
	AddSnowObject(16238, 632.37500, 1324.80469, 11.95313, 0.0, 0.0, 0.0);
	AddSnowObject(16027, 72.43750, 1276.50781, 19.52344, 0.0, 0.0, 0.0);
	AddSnowObject(16028, 297.85156, 1230.46875, 19.76563, 0.0, 0.0, 0.0);
	AddSnowObject(16030, 687.88281, 1399.62500, 10.13281, 0.0, 0.0, 0.0);
	AddSnowObject(16029, 522.38281, 1255.19531, 14.25000, 0.0, 0.0, 0.0);
	AddSnowObject(16031, 740.44531, 1605.37500, 7.36719, 0.0, 0.0, 0.0);
	AddSnowObject(16032, 740.59375, 1776.18750, 4.88281, 0.0, 0.0, 0.0);
	AddSnowObject(16257, 647.81250, 1910.30469, 19.64063, 0.0, 0.0, 0.0);
	AddSnowObject(16205, 547.48438, 1932.75781, 39.39063, 0.0, 0.0, 0.0);
	AddSnowObject(16204, 406.17188, 1931.14844, 35.84375, 0.0, 0.0, 0.0);
	AddSnowObject(16259, 312.08594, 2081.41406, 18.85156, 0.0, 0.0, 0.0);
	AddSnowObject(16203, 199.34375, 1943.78906, 18.20313, 0.0, 0.0, 0.0);
	AddSnowObject(16202, -21.45313, 1991.37500, 21.32031, 0.0, 0.0, 0.0);
	AddSnowObject(16197, 94.54688, 2165.42188, 70.01563, 0.0, 0.0, 0.0);
	AddSnowObject(16261, -25.39844, 1868.17969, 20.00781, 0.0, 0.0, 0.0);
	AddSnowObject(16198, 311.26563, 2210.24219, 29.39844, 0.0, 0.0, 0.0);
	AddSnowObject(16199, 515.26563, 2158.71875, 38.62500, 0.0, 0.0, 0.0);
	AddSnowObject(16184, 464.75781, 2396.21094, 30.77344, 0.0, 0.0, 0.0);
	AddSnowObject(16260, 491.13281, 2321.42188, 33.60938, 0.0, 0.0, 0.0);
	AddSnowObject(16194, 362.64063, 2320.02344, 32.15625, 0.0, 0.0, 0.0);
	AddSnowObject(16256, 234.99219, 2341.82031, 19.39063, 0.0, 0.0, 0.0);
	AddSnowObject(16183, 230.13281, 2483.68750, 15.47656, 0.0, 0.0, 0.0);
	AddSnowObject(16684, 329.89844, 2504.26563, 15.57031, 0.0, 0.0, 0.0);
	AddSnowObject(16196, -120.58594, 2152.22656, 61.39844, 0.0, 0.0, 0.0);
	AddSnowObject(16201, -253.88281, 1922.98438, 72.71094, 0.0, 0.0, 0.0);
	AddSnowObject(16195, -343.53906, 2152.71875, 77.52344, 0.0, 0.0, 0.0);
	AddSnowObject(16120, -273.17969, 2058.21875, 25.10938, 0.0, 0.0, 0.0);
	AddSnowObject(16122, -240.12500, 2128.28906, 19.36719, 0.0, 0.0, 0.0);
	AddSnowObject(16124, -269.17969, 1967.20313, 50.89844, 0.0, 0.0, 0.0);
	AddSnowObject(16258, -35.63281, 2263.59375, 72.82813, 0.0, 0.0, 0.0);
	AddSnowObject(16192, -264.98438, 2387.00781, 64.81250, 0.0, 0.0, 0.0);
	AddSnowObject(16125, -184.52344, 2300.14844, 42.05469, 0.0, 0.0, 0.0);
	AddSnowObject(16200, -487.60156, 1929.90625, 66.99219, 0.0, 0.0, 0.0);
	AddSnowObject(16097, -462.17969, 2081.82813, 65.69531, 0.0, 0.0, 0.0);
	AddSnowObject(11540, -615.28906, 2028.55469, 31.33594, 0.0, 0.0, 0.0);
	AddSnowObject(16170, -430.39844, 2215.65625, 25.27344, 0.0, 0.0, 0.0);
	AddSnowObject(16168, -417.50781, 2378.78906, 74.56250, 0.0, 0.0, 0.0);
	AddSnowObject(16167, -580.24219, 2365.39844, 79.67969, 0.0, 0.0, 0.0);
	AddSnowObject(16206, -497.42969, 1747.59375, 66.99219, 0.0, 0.0, 0.0);
	AddSnowObject(16133, -452.22656, 1833.27344, 67.41406, 0.0, 0.0, 0.0);
	AddSnowObject(16112, -385.86719, 1703.25000, 32.03125, 0.0, 0.0, 0.0);
	AddSnowObject(16119, -338.29688, 1920.96875, 41.42188, 0.0, 0.0, 0.0);
	AddSnowObject(16121, -125.51563, 1904.18750, 13.89063, 0.0, 0.0, 0.0);
	AddSnowObject(16134, -226.14844, 1896.81250, 39.60156, 0.0, 0.0, 0.0);
	AddSnowObject(16111, -264.53125, 1842.71875, 46.65625, 0.0, 0.0, 0.0);
	AddSnowObject(16109, -344.06250, 1398.69531, 49.83594, 0.0, 0.0, 0.0);
	AddSnowObject(16142, -268.82031, 1335.65625, 55.30469, 0.0, 0.0, 0.0);
	AddSnowObject(16212, -377.35156, 1302.90625, 3.12500, 0.0, 0.0, 0.0);
	AddSnowObject(16025, -329.95313, 1249.98438, 28.26563, 0.0, 0.0, 0.0);
	AddSnowObject(16264, -303.46875, 1281.34375, 37.64844, 0.0, 0.0, 0.0);
	AddSnowObject(16139, -372.44531, 1495.96094, 61.90625, 0.0, 0.0, 0.0);
	AddSnowObject(16262, -459.99219, 1481.05469, 5.0, 0.0, 0.0, 0.0);
	AddSnowObject(16145, -362.46881, 1314.65625, 29.42190, 0.0, 0.0, 154.5);
	AddSnowObject(16140, -422.50781, 1554.95313, 34.42188, 0.0, 0.0, 0.0);
	AddSnowObject(16211, -468.93750, 1606.82813, 30.94531, 0.0, 0.0, 0.0);
	AddSnowObject(11539, -794.82813, 2025.43750, 31.33594, 0.0, 0.0, 0.0);
	AddSnowObject(16694, -775.76563, 2331.03906, 125.25781, 0.0, 0.0, 0.0);
	AddSnowObject(16169, -792.21875, 2260.64844, 77.46094, 0.0, 0.0, 0.0);
	AddSnowObject(16693, -810.30469, 2433.96094, 115.91406, 0.0, 0.0, 0.0);
	AddSnowObject(16166, -701.40625, 2427.20313, 116.49219, 0.0, 0.0, 0.0);
	AddSnowObject(16254, -587.67188, 2466.59375, 62.97656, 0.0, 0.0, 0.0);
	AddSnowObject(16131, -581.81250, 2389.36719, 67.37500, 0.0, 0.0, 0.0);
	AddSnowObject(16130, -481.03906, 2410.92969, 55.96094, 0.0, 0.0, 0.0);
	AddSnowObject(16123, -405.39063, 2372.91406, 41.83594, 0.0, 0.0, 0.0);
	AddSnowObject(16253, -459.83594, 2567.81250, 78.83594, 0.0, 0.0, 0.0);
	AddSnowObject(16104, -453.14063, 2524.85938, 48.54688, 0.0, 0.0, 0.0);
	AddSnowObject(16165, -223.84375, 2538.21094, 34.85938, 0.0, 0.0, 0.0);
	AddSnowObject(16182, 10.22656, 2402.72656, 15.24219, 0.0, 0.0, 0.0);
	AddSnowObject(16128, -189.30469, 2428.04688, 26.17969, 0.0, 0.0, 0.0);
	AddSnowObject(16193, -113.21094, 2389.83594, 31.63281, 0.0, 0.0, 0.0);
	AddSnowObject(16685, 32.98438, 2503.58594, 15.50781, 0.0, 0.0, 0.0);
	AddSnowObject(16756, 63.0, 2417.28906, 16.01563, 0.0, 0.0, 0.0);
	AddSnowObject(16757, 30.24219, 2564.07813, 16.91406, 0.0, 0.0, 0.0);
	AddSnowObject(16177, 200.39063, 2646.27344, 41.65625, 0.0, 0.0, 0.0);
	AddSnowObject(16176, -17.22656, 2619.50781, 47.92969, 0.0, 0.0, 0.0);
	AddSnowObject(16178, 407.16406, 2622.96875, 48.88281, 0.0, 0.0, 0.0);
	AddSnowObject(16179, 616.91406, 2615.28906, 48.71875, 0.0, 0.0, 0.0);
	AddSnowObject(16675, 302.21875, 2693.57031, 19.21875, 0.0, 0.0, 0.0);
	AddSnowObject(16189, 666.89063, 1982.0, 19.75000, 0.0, 0.0, 0.0);
	AddSnowObject(16187, 642.21875, 2152.03906, 23.70313, 0.0, 0.0, 0.0);
	AddSnowObject(16033, 739.88281, 1882.86719, 4.42969, 0.0, 0.0, 0.0);
	AddSnowObject(16034, 738.54688, 2041.92969, 9.19531, 0.0, 0.0, 0.0);
	AddSnowObject(16185, 647.97656, 2391.20313, 29.10938, 0.0, 0.0, 0.0);
	AddSnowObject(16035, 731.75781, 2290.65625, 16.51563, 0.0, 0.0, 0.0);
	AddSnowObject(16180, 785.63281, 2622.11719, 44.81250, 0.0, 0.0, 0.0);
	AddSnowObject(16036, 776.63281, 2544.50000, 19.50781, 0.0, 0.0, 0.0);
	AddSnowObject(16186, 804.39063, 2412.08594, 19.60156, 0.0, 0.0, 0.0);
	AddSnowObject(16181, 915.33594, 2626.71094, 29.47656, 0.0, 0.0, 0.0);
	AddSnowObject(16255, 502.61719, 2776.37500, 93.77344, 0.0, 0.0, 0.0);
	AddSnowObject(16174, 722.07031, 2868.12500, 61.56250, 0.0, 0.0, 0.0);
	AddSnowObject(16175, 893.64844, 2866.17969, 25.83594, 0.0, 0.0, 0.0);
	AddSnowObject(16173, 499.10156, 2904.28125, 64.67969, 0.0, 0.0, 0.0);
	AddSnowObject(16172, 267.29688, 2867.21875, 58.39844, 0.0, 0.0, 0.0);
	AddSnowObject(16171, 24.90625, 2868.53906, 49.46875, 0.0, 0.0, 0.0);
	AddSnowObject(16161, -129.22656, 2834.71875, 51.42969, 0.0, 0.0, 0.0);
	AddSnowObject(16397, -224.27344, 2680.17188, 45.58594, 0.0, 0.0, 0.0);
	AddSnowObject(16160, -275.61719, 2855.75000, 59.58594, 0.0, 0.0, 0.0);
	AddSnowObject(16251, -513.10156, 2796.94531, 84.78906, 0.0, 0.0, 0.0);
	AddSnowObject(16159, -512.82031, 2919.71094, 54.98438, 0.0, 0.0, 0.0);
	AddSnowObject(16164, -448.02344, 2682.94531, 60.30469, 0.0, 0.0, 0.0);
	AddSnowObject(16163, -670.53906, 2639.98438, 98.01563, 0.0, 0.0, 0.0);
	AddSnowObject(16158, -759.53906, 2860.71094, 44.05469, 0.0, 0.0, 0.0);
	AddSnowObject(16692, -696.43750, 2488.89844, 85.63281, 0.0, 0.0, 0.0);
	AddSnowObject(16667, -882.71875, 2685.18750, 40.60156, 0.0, 0.0, 0.0);
	return true;
}

main() { }

public OnGameModeInit()
{
	SetGameModeText("Blank Script");

	AddPlayerClass(59, -110.85, 1702.66, 19.86, 180.0, 0, 0, 0, 0, 0, 0);

	AddSnowObjects();
	return true;
}

public OnGameModeExit()
{
	return true;
}

public OnPlayerRequestClass(playerid, classid)
{
	return true;
}

public OnPlayerConnect(playerid)
{
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	return true;
}

public OnPlayerSpawn(playerid)
{
	return true;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return true;
}

public OnVehicleSpawn(vehicleid)
{
	return true;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return true;
}

public OnPlayerText(playerid, text[])
{
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return false;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return true;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return true;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return true;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return true;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return true;
}

public OnRconCommand(cmd[])
{
	return true;
}

public OnPlayerRequestSpawn(playerid)
{
	return true;
}

public OnObjectMoved(objectid)
{
	return true;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return true;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return true;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return true;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return true;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return true;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return true;
}

public OnPlayerExitedMenu(playerid)
{
	return true;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return true;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return true;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return true;
}

public OnPlayerUpdate(playerid)
{
	return true;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return true;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return true;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return true;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return true;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return true;
}
