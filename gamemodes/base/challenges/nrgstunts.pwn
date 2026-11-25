#include <YSI\y_hooks>

#define MAX_NRGCHALLENGES 65
#define NRG_CHALLENGE_WORLD 120
enum NRGstuntsInfo
{
    ID,
    completed,
    nrgattempts
    
    
};
new NRGstuntsPlayerInfo[MAX_PLAYERS][MAX_NRGCHALLENGES][NRGstuntsInfo];

enum NRGstuntsInfo2
{
	nrgid,
	Float:nrgstartx,
	Float:nrgstarty,
	Float:nrgstartz,
	Float:nrgendx,
	Float:nrgendy,
	Float:nrgendz,
	nrgEndCheckPoint,
	Float:nrgangle,
	nrgdiff

}
new nrgchallengeid[MAX_PLAYERS];
new NRGstunts[MAX_NRGCHALLENGES][NRGstuntsInfo2];
new inNRGStruntCP[MAX_PLAYERS];
new NRGStuntEndTimer[MAX_PLAYERS];




hook OnGameModeInit()
{
	addNRGStunt(0,830.4725,-1816.9821,11.8579,87.3838,587.9782,-1758.5516,19.0457,CHALLENGE_EASY);
	addNRGStunt(1,2218.1919,1202.8822,10.3963,85.0567,1994.0387,1216.2078,17.6440,CHALLENGE_EASY);
	addNRGStunt(2,1838.7964,1460.5427,11.7183,266.1111,2116.1843,1484.7515,23.6992,CHALLENGE_EASY);
	addNRGStunt(3,1919.1924,2009.9796,10.2846,198.3310,1960.0483,1944.5227,22.7903,CHALLENGE_MED);
	addNRGStunt(4,1999.5573,2035.8479,10.3948,268.2027,2161.4207,2049.9419,17.6509,CHALLENGE_EASY);
	addNRGStunt(5,2338.9626,1966.6339,10.2571,281.5413,2474.2839,2022.1881,15.6512,CHALLENGE_EASY);
	addNRGStunt(6,2378.2905,1959.5461,11.2303,187.5464,2391.9619,1824.2551,19.3121,CHALLENGE_MED);
	addNRGStunt(7,2342.8186,1888.2865,10.3339,0.3850,2350.5391,2281.3894,27.0953,CHALLENGE_HARD);
	addNRGStunt(8,2199.4412,2354.3252,10.3881,98.8380,2034.4873,2314.0750,17.4442,CHALLENGE_EASY);
	addNRGStunt(9,2071.4956,2431.7000,60.3934,270.7874,2254.1367,2435.8909,38.2567,CHALLENGE_EASY);
	addNRGStunt(10,1952.1699,2199.2729,10.3764,268.6681,2166.9170,2216.6101,24.4957,CHALLENGE_EASY);
	addNRGStunt(11,2014.2601,902.0602,10.3955,97.8675,1777.7303,889.6344,26.4401,CHALLENGE_MED);
	addNRGStunt(12,1808.6340,-1289.9449,13.1900,87.8037,1435.9463,-1302.6060,34.8420,CHALLENGE_HARD);
	addNRGStunt(13,1970.6865,-1424.8083,13.1227,92.3236,1829.2667,-1433.0203,35.4921,CHALLENGE_EASY);
	addNRGStunt(14,2074.8840,-1343.7592,23.3938,89.3515,1805.9839,-1346.9221,27.0379,CHALLENGE_MED);
	addNRGStunt(15,-2267.9246,-102.5308,34.8835,270.6255,-2235.3667,-111.6166,46.8507,CHALLENGE_HARD);
	addNRGStunt(16,2543.4150,-1723.2930,13.1150,155.3370,2486.6406,-1893.8499,25.1263,CHALLENGE_EASY);
	addNRGStunt(17,-1509.6239,1232.4849,6.8046,180.9184,-1497.4142,589.1249,41.8341,CHALLENGE_HARD);
	addNRGStunt(18,1533.6500,-1584.2800,13.1186,179.2610,1550.8210,-1706.4670,27.9617,CHALLENGE_MED);
	addNRGStunt(19,1858.9713,940.9495,10.3886,269.5654,2104.9038,954.1406,15.3109,CHALLENGE_EASY);
	addNRGStunt(20,1865.0953,941.6677,10.2457,275.0878,2114.8103,920.3574,16.6335,CHALLENGE_EASY);
	addNRGStunt(21,2275.2061,1376.4530,10.2446,100.3930,1935.9142,1356.9789,15.3984,CHALLENGE_EASY);
	addNRGStunt(22,2158.7371,2279.7781,10.2337,87.0760,1859.7821,2301.7778,14.3482,CHALLENGE_EASY);
	addNRGStunt(23,2838.3350,1510.8850,10.4685,172.8816,2798.1367,1249.5603,22.4445,CHALLENGE_HARD);
	addNRGStunt(24,2491.0459,1368.5311,10.2614,274.2958,2749.6484,1403.6879,23.6441,CHALLENGE_MED);
	addNRGStunt(25,-2005.1930,-288.2944,34.8921,13.8200,-2038.8859,-49.8217,46.8618,CHALLENGE_EASY);
	addNRGStunt(26,-2005.8990,37.5574,32.3764,180.9570,-2026.6833,-110.3211,38.4854,CHALLENGE_EASY);
	addNRGStunt(27,-2323.2788,725.9100,46.7227,89.7025,-2564.8020,737.3138,44.5861,CHALLENGE_EASY);
	addNRGStunt(28,-2130.7305,929.6780,79.5756,0.0552,-2132.6726,1192.6194,73.9622,CHALLENGE_HARD);
	addNRGStunt(29,-1869.6564,-760.7438 ,31.5843 ,169.7412,-1946.6376,-1115.8463,46.9202,CHALLENGE_EASY);
	addNRGStunt(30,-1761.0244,286.1948,7.6106,319.6453,-1676.2450,419.2202,12.0150,CHALLENGE_EASY);
	addNRGStunt(31,-2034.1788,238.1617,34.4374,85.9860,-2160.2925,245.6647,46.0101,CHALLENGE_MED);
	addNRGStunt(32,-2006.5033,927.5399,44.8699,0.2582,-2000.3103,1114.7589,65.2530,CHALLENGE_EASY);
	addNRGStunt(33,-2168.7324,19.5906,34.7327,291.1140,-2039.7854,81.9815,41.4287,CHALLENGE_MED);
	addNRGStunt(34,-2228.1099,160.2481,34.8938,94.7750,-2583.0920,182.1942,19.9180,CHALLENGE_MED);
	addNRGStunt(35,-2140.9541,-796.7785,31.5898,239.1820,-1955.7222,-897.0085,41.3726,CHALLENGE_EASY);
	addNRGStunt(36,-1869.6564,-760.7438,31.5843,169.7412,-1936.9327,-1067.6135,47.3498,CHALLENGE_HARD);
	addNRGStunt(37,1807.2872,-2461.6069,13.1289,81.9658,1605.2719,-2412.2539,24.2860,CHALLENGE_EASY); 
	addNRGStunt(37,2846.3953,-982.5873,19.6954,172.2572,2817.7209,-1168.6548,32.2443,CHALLENGE_EASY); 
	addNRGStunt(38,2807.2898,-1426.7874,39.6216,187.0527,2797.0422,-1512.0675,32.5648,CHALLENGE_MED); 
	addNRGStunt(39,1790.6293,-1494.4689,8.2280,266.9136,2076.5676,-1563.4515,17.3608,CHALLENGE_EASY); 
	addNRGStunt(40,2211.4817,-1999.1366,12.9003,355.1632,2241.8123,-1793.2333,21.1936,CHALLENGE_EASY); 
	addNRGStunt(41,2024.3549,-1945.5533,13.1212,272.4854,2186.6943,-1949.0199,19.6394,CHALLENGE_EASY); 
	addNRGStunt(42,1722.9077,-1957.2780,13.0931,273.0231,2006.7389,-1971.7791,22.5954,CHALLENGE_EASY); 
	addNRGStunt(43,1722.9077,-1957.2780,13.0931,273.0231,1998.8436,-2000.4360,19.5679,CHALLENGE_EASY); 
	addNRGStunt(44,1696.9886,-1662.7740,13.1210,180.1161,1706.8604,-2019.9349,20.1386,CHALLENGE_MED); 
	addNRGStunt(45,1776.7743,-1961.5460,13.6750,90.0520,1703.1438,-1960.5236,18.8251,CHALLENGE_MED); 
	addNRGStunt(46,2250.7837,-2626.4490,13.1294,359.2354,2241.3025,-2385.6504,28.1285,CHALLENGE_MED); 
	addNRGStunt(47,2360.7373,2425.8638,10.3933,7.4434,2343.7466,2543.6948,15.4421,CHALLENGE_EASY); 
	addNRGStunt(48,2260.8613,2505.8735,10.3863,69.6790,2210.8396,2537.5654,15.8033,CHALLENGE_MED); 
	addNRGStunt(49,2133.4365,2455.6399,10.2325,88.5992,1923.9935,2457.7451,20.3938,CHALLENGE_EASY); 
	addNRGStunt(50,1510.4423,2068.5046,10.3951,0.9398,1510.9205,2333.0459,18.3362,CHALLENGE_EASY); 
	addNRGStunt(51,1149.5392,-1580.1672,12.8349,179.7761,1139.6670,-1765.2325,28.6608,CHALLENGE_MED); 
	addNRGStunt(52,-1494.0742,663.8149,6.7482,1.2840,-1527.5214,1023.5031,24.8962,CHALLENGE_HARD);
	addNRGStunt(53,-2017.7751,728.0365,44.9138,352.9392,-1965.0438,958.1284,50.5202,CHALLENGE_MED);
	addNRGStunt(54,-2607.8005,1087.7462,58.4807,331.0570,-2531.6299,1207.5160,48.6053,CHALLENGE_EASY);
	addNRGStunt(55,-2214.3857,531.4081,81.8973,279.2740,-2120.9280,539.1083,78.7330,CHALLENGE_EASY);
	addNRGStunt(56,-2140.0059,329.8030,34.8858,264.6500,-1959.3770,297.4403,47.2888,CHALLENGE_MED);
	addNRGStunt(57,2430.2334,2416.8113,10.2958,96.6916,2160.6128,2384.6101,23.1647,CHALLENGE_MED);
	addNRGStunt(58,1835.9883,2175.7004,10.2481,89.0107,1472.9274,2170.1863,23.6650,CHALLENGE_MED);
	addNRGStunt(59,1709.6730,-1559.0972,13.1096,171.0910,1655.8763,-1797.8538,27.9051,CHALLENGE_MED);
	addNRGStunt(60,1617.8149,-1646.8223,28.2785,105.0838,1569.2130,-1720.4711,27.9091,CHALLENGE_MED);
	addNRGStunt(61,1357.3140,-1724.9404,13.1229,3.3756,1406.3145,-1289.5431,33.0136,CHALLENGE_MED);
	addNRGStunt(62,1.9102,-152.0997,0.1904,229.4591,98.8743,-288.8987,14.2055,CHALLENGE_EASY);
	addNRGStunt(63,651.6652,-410.9501,16.3466,168.3882,625.5540,-566.1376,25.7167,CHALLENGE_MED);
	addNRGStunt(64,642.3585,-412.1730,15.9075,182.7410,656.8101,-570.9582,21.7215,CHALLENGE_MED);













}
function addNRGStunt(id222,Float:startX,Float:startY,Float:startZ,Float:startAngle1,Float:endX,Float:endY,Float:endZ,NRGDif)
{
	NRGstunts[id222][nrgid] = id222;
	NRGstunts[id222][nrgstartx] = startX; 
	NRGstunts[id222][nrgstarty] = startY;
	NRGstunts[id222][nrgstartz] = startZ;
	NRGstunts[id222][nrgendx] = endX; 
	NRGstunts[id222][nrgendy] = endY;
	NRGstunts[id222][nrgendz] = endZ;
	NRGstunts[id222][nrgangle] = startAngle1;
	NRGstunts[id222][nrgdiff] = NRGDif;
	NRGstunts[id222][nrgEndCheckPoint] = CreateDynamicCP(endX, endY, endZ, 2, NRG_CHALLENGE_WORLD, -1, -1, 3000);
	return 1;
}

function PutPlayerInNrgStunt(playerid,nrgstuntid)
{

 
	NRGstuntsPlayerInfo[playerid][nrgstuntid][nrgattempts] +=1;
	if(IsPlayerInNRGStunt(playerid))
	{
		KillTimer(NRGStuntEndTimer[playerid]);
		GameTextForPlayer(playerid, "", 0, 3);
		DisableRemoteVehicleCollisions(playerid, true);
		new tt[20];
		format(tt,sizeof(tt),"NRG Stunt %i",nrgstuntid);
		UpdateChallengeTextDraws(playerid,tt,NRGstunts[nrgstuntid][nrgdiff],NRGstuntsPlayerInfo[playerid][nrgstuntid][nrgattempts],NRGstuntsPlayerInfo[playerid][nrgstuntid][completed]);

	}
	else{
		new tt[20];
		format(tt,sizeof(tt),"NRG Stunt %i",nrgstuntid);
		CreateChallengeTextdraws(playerid,tt,NRGstunts[nrgstuntid][nrgdiff],NRGstuntsPlayerInfo[playerid][nrgstuntid][nrgattempts],NRGstuntsPlayerInfo[playerid][nrgstuntid][completed]);
	}

	nrgchallengeid[playerid] = nrgstuntid;

	TextDrawHideForPlayer(playerid, blackBackground);
	SetPlayerHealth(playerid, Float: 0x7F800000);
	ResetPlayerWeapons(playerid);
	SetPlayerVirtualWorldEx(playerid, NRG_CHALLENGE_WORLD);
	
	SetPlayerPos(playerid, NRGstunts[nrgstuntid][nrgstartx],  NRGstunts[nrgstuntid][nrgstarty],  NRGstunts[nrgstuntid][nrgstartz]);
	if(PVeh[playerid] != INVALID_VEHICLE_ID)
	{
		DestroyVehicle(PVeh[playerid]);
		PVeh[playerid] = INVALID_VEHICLE_ID;
	}
	PVeh[playerid] = CreateVehicle(522, NRGstunts[nrgstuntid][nrgstartx],  NRGstunts[nrgstuntid][nrgstarty],  NRGstunts[nrgstuntid][nrgstartz],NRGstunts[nrgstuntid][nrgangle], random(256), random(256), -1);
	SetVehicleZAngle(PVeh[playerid], NRGstunts[nrgstuntid][nrgangle]);
    LinkVehicleToInterior(PVeh[playerid], GetPlayerInterior(playerid));
    SetVehicleVirtualWorld(PVeh[playerid], GetPlayerVirtualWorld(playerid));
    PutPlayerInVehicle(playerid, PVeh[playerid], 0);
  
    TogglePlayerAllDynamicCPs(playerid, 0);
    TogglePlayerDynamicCP(playerid, NRGstunts[nrgstuntid][nrgEndCheckPoint], 1);

	inNRGStruntCP[playerid] = 0;


	return 1;
}

function stopnrgcam(playerid)
{
	SetCameraBehindPlayer(playerid); //to prevent some bugs
	TogglePlayerSpectating(playerid, 0);
	NRGstuntsPlayerInfo[playerid][nrgchallengeid[playerid]][nrgattempts] -=1;
	SetPlayerVirtualWorldEx(playerid, NRG_CHALLENGE_WORLD);
	SetTimerEx("PutPlayerInNrgStunt", 1000, false, "ii", playerid,nrgchallengeid[playerid]);
	return 1;
}
CMD:nrgstunts(playerid, params[])
{
	new LongString[2048];
    for(new i; i < 51; i++)
    {
    	if(NRGstuntsPlayerInfo[playerid][i][completed] == 0)
    		format(LongString,sizeof(LongString),"%s\n%s {FF0000}Stunt %i",LongString,ChallengeDifficulty(NRGstunts[i][nrgdiff]),i);
    	else
    		format(LongString,sizeof(LongString),"%s\n%s {00FF00}Stunt %i",LongString,ChallengeDifficulty(NRGstunts[i][nrgdiff]),i);
    }
    format(LongString,sizeof(LongString),"%s\nNext page",LongString);
	ShowPlayerDialog(playerid, DIALOG_NRGSTUNTS, DIALOG_STYLE_LIST, "NRG Stunts",LongString, "Select", "Close");
	
	return 1;
}
CMD:viewcheckpoint(playerid, params[])
{

	TogglePlayerSpectating(playerid, 1);
	InterpolatePlayerCamera(playerid,NRGstunts[nrgchallengeid[playerid]][nrgstartx],NRGstunts[nrgchallengeid[playerid]][nrgstarty],NRGstunts[nrgchallengeid[playerid]][nrgstartz]+30,
		NRGstunts[nrgchallengeid[playerid]][nrgstartx],NRGstunts[nrgchallengeid[playerid]][nrgstarty],NRGstunts[nrgchallengeid[playerid]][nrgstartz],
		NRGstunts[nrgchallengeid[playerid]][nrgendx],NRGstunts[nrgchallengeid[playerid]][nrgendy],NRGstunts[nrgchallengeid[playerid]][nrgendz]+30,
		NRGstunts[nrgchallengeid[playerid]][nrgendx],NRGstunts[nrgchallengeid[playerid]][nrgendy],NRGstunts[nrgchallengeid[playerid]][nrgendz], 3000);
	SetTimerEx("stopnrgcam", 6000, false, "i", playerid);
	
	
	return 1;
}

function OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_NRGSTUNTS:
		{
			if(response)
			{
				if(listitem == 51)
				{
					new LongString[2048];
				    for(new i = 50; i < MAX_NRGCHALLENGES; i++)
				    {
				    	if(NRGstuntsPlayerInfo[playerid][i][completed] == 0)
				    		format(LongString,sizeof(LongString),"%s\n%s {FF0000}Stunt %i",LongString,ChallengeDifficulty(NRGstunts[i][nrgdiff]),i);
				    	else
				    		format(LongString,sizeof(LongString),"%s\n%s {00FF00}Stunt %i",LongString,ChallengeDifficulty(NRGstunts[i][nrgdiff]),i);
				    }
				   // format(LongString,sizeof(LongString),"%s\nNext page",LongString);
					return ShowPlayerDialog(playerid, DIALOG_NRGSTUNTS2, DIALOG_STYLE_LIST, "NRG Stunts",LongString, "Select", "Close");
				}
				//SpawnPlayer(playerid);
				LeaveWorld(playerid, false);
				SetTimerEx("PutPlayerInNrgStunt",500,false,"ii",playerid,listitem);
				inLobby[playerid] = false;
				CancelSelectTextDraw(playerid);
			}
			if(!response && inLobby[playerid] == true)
				PutInlobby(playerid,1);
			

		}

		case DIALOG_NRGSTUNTS2:
		{
			if(response)
			{

				//SpawnPlayer(playerid);
				LeaveWorld(playerid, false);
				SetTimerEx("PutPlayerInNrgStunt",500,false,"ii",playerid,listitem+50);
				inLobby[playerid] = false;
				CancelSelectTextDraw(playerid);
			}
			if(!response && inLobby[playerid] == true)
				PutInlobby(playerid,1);
			

		}
	}
	return 1;
}

function CompleteNRGStunt(playerid,i)
{
	new nrgname[32];
	NRGstuntsPlayerInfo[playerid][i][completed] +=1;
		
	PlayerPlaySound(playerid, 1058,0,0,0);
	GetPlayerName(playerid, nrgname, sizeof(nrgname));
	foreach(Player,j)
	{
		if(IsPlayerInNRGStunt(j) && j != playerid)
			SendClientMessageEx(j, -1, ""LBLUE"[NRGSTUNT]: "TEXT"%s Has completed NRG Stunt %i %i times after %i attempts!", nrgname, i,NRGstuntsPlayerInfo[playerid][i][completed],NRGstuntsPlayerInfo[playerid][i][nrgattempts]);
			
	}
	new message[300];
	format(message, sizeof(message), "12[NRGSTUNT]: 1%s Has completed NRG Stunt %i %i times after %i attempts!", nrgname, i,NRGstuntsPlayerInfo[playerid][i][completed],NRGstuntsPlayerInfo[playerid][i][nrgattempts]);
	IRC_GroupSay(groupID, IRC_CHANNEL, message);
	IRC_GroupSay(groupIDA, IRC_ADMIN_CHANNEL, message);

	switch(NRGstunts[i][nrgdiff])
    {
    	case 1:
    	{
			T_GivePlayerScore(playerid, 1);
			T_GivePlayerMoney(playerid, 500);
			SendClientMessageEx(playerid, -1, ""LBLUE"[NRGSTUNT]: "TEXT"Congratulations you have finished NRG stunt %i +1 Score and $500", i);
    	}
    	case 2:
    	{
			T_GivePlayerScore(playerid, 2);
			T_GivePlayerMoney(playerid, 1500);
			SendClientMessageEx(playerid, -1, ""LBLUE"[NRGSTUNT]: "TEXT"Congratulations you have finished NRG stunt %i +2 Score and $1500", i);
    	}
    	case 3:
    	{
			T_GivePlayerScore(playerid, 3);
			T_GivePlayerMoney(playerid, 3000);
			SendClientMessageEx(playerid, -1, ""LBLUE"[NRGSTUNT]: "TEXT"Congratulations you have finished NRG stunt %i +3 Score and $3000", i);
    	}


	}

	new Query[512];
	mysql_format(mysql, Query,sizeof(Query),"INSERT INTO users_nrgstunts (UserID,NrgStuntID,Attempts,Finishes) VALUES (%i,%i,%i,%i) ON DUPLICATE KEY UPDATE Attempts = %i,Finishes = %i ",PlayerInfo[playerid][User_ID],i,NRGstuntsPlayerInfo[playerid][i][nrgattempts],NRGstuntsPlayerInfo[playerid][i][completed],NRGstuntsPlayerInfo[playerid][i][nrgattempts],NRGstuntsPlayerInfo[playerid][i][completed]);
    mysql_tquery(mysql, Query);
    printf("%s",Query);

	
	if(i+1 == MAX_NRGCHALLENGES)
		PutPlayerInNrgStunt(playerid,0);
	else
		PutPlayerInNrgStunt(playerid,i+1);

}

hook OnPlayerKeyStateChange( playerid, newkeys, oldkeys )
{
	if(IsPlayerInNRGStunt(playerid))
		if(PRESSED( KEY_ANALOG_LEFT )) // num4
			PutPlayerInNrgStunt(playerid,nrgchallengeid[playerid]);
		
	return 1;
}
