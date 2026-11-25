#include <YSI\y_hooks>	


#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

// * CONSTANTES * //
#define DIALOG_TOPCBUG 874


new isCbug[MAX_PLAYERS+1];
new bool:cbugIsShooting[MAX_PLAYERS+1] = false;
new Float:cbugTickTime[2][MAX_PLAYERS+1];

stock setupCbugChallenge(playerid)
{
 	SetTimerEx("FuncPart2", 1000, 0, "i", playerid);
}

forward FuncPart2(playerid);
public FuncPart2(playerid)
{
 
    cbugIsShooting[playerid] = false;
    ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 24, 7);
}


hook OnPlayerConnect(playerid)
{
    isCbug[playerid] = 0;
    return 1;
}

hook OnPlayerDisconnect(playerid)
{
    isCbug[playerid] = 0;
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(isCbug[playerid] == 1) isCbug[playerid] = 0;
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(isCbug[playerid] == 1)
	{
		if(GetPlayerWeapon(playerid) == 24)
		{
		    if(GetPlayerAmmo(playerid) == 7 && PRESSED(KEY_FIRE))
			{
			    cbugTickTime[0][playerid] = GetTickCount();
                cbugIsShooting[playerid] = true;
			}
			else if(RELEASED(KEY_FIRE))
			{
			    if(GetPlayerAmmo(playerid) == 0)
			    {
			    	cbugTickTime[1][playerid] = GetTickCount();
					new Float:cbugtime =  (cbugTickTime[1][playerid]-cbugTickTime[0][playerid])/1000;
					cbugIsShooting[playerid] = false;
					
		
					mysql_format(g_SQL_handle,query,sizeof(query),"INSERT INTO cbugtimes (`regid`,`ms`,`time`,`holder`) VALUES (%i,%f,%i,'%e') ON DUPLICATE KEY UPDATE  `time`=IF(ms >%f,%i,time), `ms`=IF(ms > %f,%f,ms)",
					pRegID[playerid],cbugtime,gettime(),pName[playerid],cbugtime,gettime(),cbugtime,cbugtime);
			    	
			    	mysql_query(g_SQL_handle, query);
			    	
			    	new isNewBestTime = cache_affected_rows();
			    	format(query,sizeof(query),"SELECT * FROM cbugtimes WHERE ms <= %f",cbugtime);
					
			    	mysql_query(g_SQL_handle, query);
			    	new cbugrank = MySQL_rowCount();
					if(isNewBestTime)
						format(str, sizeof(str), "{FFFFFF}You have set a new personal cbugtime record:"YELLOW_E" %0.4f(rank:%i)!", cbugtime,MySQL_rowCount()+1);
					else
						format(str, sizeof(str), "{FFFFFF}You have set a new cbugtime:"YELLOW_E" %0.4f(rank:%i)!", cbugtime,MySQL_rowCount()+1);	
					
					SendClientMessage(playerid, COLOR_YELLOW, str);
					if(isNewBestTime)
					{
						if(cbugrank+1 <=3)
						{
							print("in dis fucking loop");
							format(str, sizeof(str),"{FF0000}[CBUG]{FFFFFF}%s has set the %s time "YELLOW_E"(%0.4f seconds) {FFFFFF}in the /cbug challenge!", 
								pName[playerid],getRank(MySQL_rowCount()+1),cbugtime);
							SendClientMessageToAll(COLOR_LIME, str);
						}
					}
					setupCbugChallenge(playerid);
				}
			}
			
		}
	}
	return 1;
}
stock getRank(rankToGet)
{
	new rank[5];
	switch(rankToGet)
	{

		
		case 1: strcat(rank, "1st");
		case 2: strcat(rank, "2nd");
		case 3: strcat(rank, "3rd");
		case 4: strcat(rank, "4th");
		case 5: strcat(rank, "5th");
		case 6: strcat(rank, "6th");
		case 7: strcat(rank, "7th");
		case 8: strcat(rank, "8th");
		case 9: strcat(rank, "9th");
		case 10:strcat(rank, "10th");
		case 11:strcat(rank, "11th");
		case 12:strcat(rank, "12th");
		case 13:strcat(rank, "13th");
		case 14:strcat(rank, "14th");
		case 15:strcat(rank, "15th");
		case 16:strcat(rank, "16th");
		case 17:strcat(rank, "17th");
		case 18:strcat(rank, "18th");
		case 19:strcat(rank, "19th");
		case 20:strcat(rank, "20th");
	}
	return  rank;
}
// * COMANDOS * //
CMD:cbug(playerid, params[])
{

	if(pLogged[playerid] == false)return Error(playerid, "You must be registered to use this command! (/register)");
	if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] == 13) return Error(playerid, "Leave the CnR minigame before joining a DM! "RED_E"/leave.");
	if(doingStunt[playerid] != 0) return Error(playerid, "Teleport out of this stunt area before joining a DM!");
	if(isCbug[playerid] == 1) return Error(playerid, "You are already in the CBug Arena!");
	
	SavePlayerPosition(playerid);
	isCbug[playerid] = 1;
	SetPlayerPos(playerid, 1351.6174+random(2), 2183.8823+random(2), 11.0234);
	SetPlayerVirtualWorld(playerid,14432);
	SetPlayerInterior(playerid,0);
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 24, 7);
	SetPlayerHealth(playerid, 9999999.0);
    return 1;
}



CMD:topcbug(playerid, params[])
{
	format(query, sizeof(query), "SELECT * from cbugtimes ORDER BY ms ASC LIMIT 15");
	mysql_function_query(g_SQL_handle, query, true, "OnPlayerRequestCbugTop", "i", playerid);
	return 1;
}

forward OnPlayerRequestCbugTop(playerid);
public OnPlayerRequestCbugTop(playerid)
{
	new longline[900];
	for(new i = 0, r = cache_num_rows(); i < r; i++)	
	{
		new tempholder[80],Float:ms;
	
		cache_get_field_content(i, "holder", tempholder, g_SQL_handle, 80);
		

		ms = cache_get_field_content_float(i, "ms");


		format(longline, sizeof(longline), "%s {FFFFFF}#%i "YELLOW_E"%s : {FFFFFF}%0.4f Seconds\n", longline,(i+1),tempholder,ms);
						
	}
	ShowPlayerDialog(playerid, DIALOG_TOPCBUG, 0, "Top 15 CBug-Times", longline, "OK", "");

	return 1;


}
