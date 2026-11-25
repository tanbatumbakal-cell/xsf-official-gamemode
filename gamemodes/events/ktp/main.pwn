/*
	Server - xTreme Stunt Freeroam (c) 2017
	Kill the president event.
	Author: Xeon

	Event name: Kill the president
	Weapons allowed: Yes
	Player weapons: Combat, Sniper, M4, Deagle, Grenades
	Event manager weapon: No
	Map: San Andreas -> Las venturas
	Vehicles: Yes (4 Seats)
	Player vehicle: Sultan (Presidents team), Rancher (Killer team) 
  
*/

const 

	STARTER_PRIZE = 20000,
	KTP_WORLD = 100
;

new 
	Float:p_Pos[3],
	Float:k_Pos[3],
	IsKTP[MAX_PLAYERS],
	KTPTickCount,
	President,
	Guards[3]
;

hook OnGameModeInit()
{
	p_Pos[0] = 1501.3701;
	p_Pos[1] = 2862.2419;
	p_Pos[2] = 10.8247;

	k_Pos[0] = 1488.6240;
	k_Pos[1] = 1513.7963;
	k_Pos[2] = 10.8203;

	return 1;
}


forward OnKTPStart();
public OnKTPStart()
{
	foreach(new ii : Player)
	{
		if(IsKTP[ii] != 0)
		{
			SetCameraBehindPlayer(ii);
			if(ii == President) SetPlayerPos(ii, p_Pos[0], p_Pos[1], p_Pos[2]);
			if(ii == Guards[0] || ii == Guards[1] || ii == Guards[2]) 
			{
				new Float: x = p_Pos[0] + float(random(10));
    			new Float: y = p_Pos[1] + float(random(5));
				SetPlayerPos(ii, x, y, p_Pos[2]);
			}
			else 
			{
				new Float: x = k_Pos[0] + float(random(10));
    			new Float: y = k_Pos[1] + float(random(5));
				SetPlayerPos(ii, x, y, k_Pos[2]);
			}
			TogglePlayerControllable(ii, false);
			GodModeLabel(ii, false);
			if(GetPVarInt(ii, "HideObjects"))
			{
				DeletePVar(ii, "HideObjects");
				Streamer_ToggleItemUpdate(ii, STREAMER_TYPE_OBJECT, 1);
			}
			ResetPlayerWeapons(ii);
			SetPlayerVirtualWorld(ii, KTP_WORLD);
			GameTextForPlayer(ii, "~r~Kill the president.", 5000, 0);
			InEvent[ii] = 1;
			SetPVarInt(ii, "OldColor", GetPlayerColor(ii));
			SetPlayerColor(ii, -1);
			
			if(ii == President) SetPlayerColor(ii, 1), IsKTP[ii] = 2;
			if(ii == Guards[0] || ii == Guards[1] || ii == Guards[2]) SetPlayerColor(ii, 0x0000BBAA), IsKTP[ii] = 2;
		}
	}
	EventGoingOn = 0;
	EventStarted = true;
	KTPTickCount = GetTickCount();
	return true;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if(IsKTP[playerid])
	{
		if(playerid == President)
		{
			if(killerid != INVALID_PLAYER_ID)
			{
				SendClientMessageToAll(-1, ""RED_E"[Kill the president]: "WHITE_E"Event has been finished.");
				format(str, sizeof(str), ""RED_E"[Kill the president]: "WHITE_E"%s (ID: %d) has won the event in %d seconds.", pName[killerid], killerid, (KTPTickCount - GetTickCount()) / 1000);
				SendClientMessageToAll(-1, str);
				foreach(new ii : Player)
				{
					if(IsKTP[ii] != 0)
					{
						GodModeLabel(ii, true);
						ResetPlayerWeapons(ii);
						SetPlayerVirtualWorld(ii, 0);
						InEvent[ii] = 0;
						SetPlayerColor(ii, GetPVarInt(ii, "OldColor"));
						DeletePVar(ii, "OldColor");
						SpawnPlayer(ii);
					}
				}
				GivePlayerMoney(killerid, STARTER_PRIZE*((GetTickCount() - KTPTickCount) / 2000));
				EventStarted = false;
				KTPTickCount = 0;
				President = INVALID_PLAYER_ID;
				for(new i = 0; i < 4; i++) Guards[i] = INVALID_PLAYER_ID;
			}
			else
			{
				SpawnPlayer(playerid);
				SetPlayerPos(playerid, k_Pos[0], k_Pos[1], k_Pos[2]);
				SetPlayerVirtualWorld(playerid, KTP_WORLD);
				InEvent[playerid] = 1;
				GodModeLabel(playerid, false);
				if(GetPVarInt(playerid, "HideObjects"))
				{
					DeletePVar(playerid, "HideObjects");
					Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, 1);
				}
			}
		}
		else
		{
			GodModeLabel(playerid, true);
			ResetPlayerWeapons(playerid);
			SetPlayerVirtualWorld(playerid, 0);
			InEvent[playerid] = 0;
			SetPlayerColor(playerid, GetPVarInt(playerid, "OldColor"));
			DeletePVar(playerid, "OldColor");
			SpawnPlayer(playerid);

			new found = 0;
			foreach(new ii : Player) if(IsKTP[ii] == 11) found++;
			
			if(found == 0)
			{
				SendClientMessageToAll(-1, ""RED_E"[Kill the president]: "WHITE_E"Event has been finished.");
				format(str, sizeof(str), ""RED_E"[Kill the president]: "WHITE_E"The president escaped.", pName[killerid], killerid, (KTPTickCount - GetTickCount()) / 1000);
				SendClientMessageToAll(-1, str);
				foreach(new ii : Player)
				{
					if(IsKTP[ii] != 0)
					{
						GodModeLabel(ii, true);
						ResetPlayerWeapons(ii);
						SetPlayerVirtualWorld(ii, 0);
						InEvent[ii] = 0;
						SetPlayerColor(ii, GetPVarInt(ii, "OldColor"));
						DeletePVar(ii, "OldColor");
						SpawnPlayer(ii);
					}
				}
				EventStarted = false;
				KTPTickCount = 0;
				President = INVALID_PLAYER_ID;
				for(new i = 0; i < 4; i++) Guards[i] = INVALID_PLAYER_ID;
			}
		}
	}
	return 1;
}
