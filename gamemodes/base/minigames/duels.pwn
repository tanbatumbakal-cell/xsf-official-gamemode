/*
				Server - xTreme Stunt Freeroam (c) 2017
				Duel System
				Author: J0shES
				
				Features that are better over the old duel system:
					- Being able to choose maps! Currently there's 4 maps to choose from.
					- Being able to host _MULTIPLE_ duels, now nobody has to wait, yay!

*/
#include <YSI\y_hooks>

#define DUEL_TYPE_NONE (0)
#define DUEL_TYPE_NORMAL (1)
#define DUEL_TYPE_TEAM (2)

#define DUEL_MAP_CAGE (1)
#define DUEL_MAP_RCTRACK (2)
#define DUEL_MAP_WAREHOUSE (3)
#define DUEL_MAP_LVPD (4)
//#define DUEL_MAP_FAST (5)


new 
	InDuel[MAX_PLAYERS] = {-1, ...}, // InDuel will return the playerid that "hosted" the duel.
	DuelWeapon[MAX_PLAYERS][30] = {"NONE", ...},
	DuelWeap[MAX_PLAYERS] = {0, ...},
	DuelTimer[MAX_PLAYERS] = {-1, ...},
	DuelCountDown[MAX_PLAYERS] = {0, ...},
	DuelType[MAX_PLAYERS],
	DuelMap[MAX_PLAYERS],
	DuelMapName[MAX_PLAYERS][30] = {"NONE", ...},
	BetTimer[MAX_PLAYERS],
	CantBet[MAX_PLAYERS];

forward OpenDuelGate(playerid, player_team_mate, enemy, enemy_team_mate);
forward CloseDuelGate(player);
forward DuelCountDownTimer(hostid);
forward CloseBets(hostid);

public OpenDuelGate(playerid, player_team_mate, enemy, enemy_team_mate) {
	if(DuelType[playerid] == DUEL_TYPE_NORMAL) {
		// player_team_mate is ENEMY in this sense!
		MovePlayerObject(playerid, Streamer_GetItemInternalID(playerid, STREAMER_TYPE_OBJECT, Gate[3]), 2181.2761, -2265.2842, 919.6684, 7.5);
		MovePlayerObject(playerid, Streamer_GetItemInternalID(playerid, STREAMER_TYPE_OBJECT, Gate[4]), 2180.9387, -2224.8384, 919.6684, 7.5);
		
		MovePlayerObject(player_team_mate, Streamer_GetItemInternalID(player_team_mate, STREAMER_TYPE_OBJECT, Gate[3]), 2181.2761, -2265.2842, 919.6684, 7.5);
		MovePlayerObject(player_team_mate, Streamer_GetItemInternalID(player_team_mate, STREAMER_TYPE_OBJECT, Gate[4]), 2180.9387, -2224.8384, 919.6684, 7.5);
	}
	else if(DuelType[playerid] == DUEL_TYPE_TEAM) {
		MovePlayerObject(playerid, Streamer_GetItemInternalID(playerid, STREAMER_TYPE_OBJECT, Gate[3]), 2181.2761, -2265.2842, 919.6684, 7.5);
		MovePlayerObject(playerid, Streamer_GetItemInternalID(playerid, STREAMER_TYPE_OBJECT, Gate[4]), 2180.9387, -2224.8384, 919.6684, 7.5);
		
		MovePlayerObject(player_team_mate, Streamer_GetItemInternalID(player_team_mate, STREAMER_TYPE_OBJECT, Gate[3]), 2181.2761, -2265.2842, 919.6684, 7.5);
		MovePlayerObject(player_team_mate, Streamer_GetItemInternalID(player_team_mate, STREAMER_TYPE_OBJECT, Gate[4]), 2180.9387, -2224.8384, 919.6684, 7.5);
	
		MovePlayerObject(enemy, Streamer_GetItemInternalID(enemy, STREAMER_TYPE_OBJECT, Gate[3]), 2181.2761, -2265.2842, 919.6684, 7.5);
		MovePlayerObject(enemy, Streamer_GetItemInternalID(enemy, STREAMER_TYPE_OBJECT, Gate[4]), 2180.9387, -2224.8384, 919.6684, 7.5);
		
		MovePlayerObject(enemy_team_mate, Streamer_GetItemInternalID(enemy_team_mate, STREAMER_TYPE_OBJECT, Gate[3]), 2181.2761, -2265.2842, 919.6684, 7.5);
		MovePlayerObject(enemy_team_mate, Streamer_GetItemInternalID(enemy_team_mate, STREAMER_TYPE_OBJECT, Gate[4]), 2180.9387, -2224.8384, 919.6684, 7.5);
	}
	return 1;
}

public CloseDuelGate(player) {
	// Return gate back to Original pos.
	MoveDynamicObject(Gate[3], 2181.28, -2265.28, 924.07, 3);
	MoveDynamicObject(Gate[4], 2180.94, -2224.84, 924.07, 3);
	
	MovePlayerObject(player, Streamer_GetItemInternalID(player, STREAMER_TYPE_OBJECT, Gate[3]), 2181.28, -2265.28, 924.07, 3);
	MovePlayerObject(player, Streamer_GetItemInternalID(player, STREAMER_TYPE_OBJECT, Gate[4]), 2180.94, -2224.84, 924.07, 3);
}

public DuelCountDownTimer(hostid) {
	foreach(new i : Player) {
		if(InDuel[i] != InDuel[hostid]) continue;
		
		if(DuelCountDown[InDuel[hostid]] == 5)
		{
			GameTextForPlayer(i, " ", 500, 6);
			SetCameraBehindPlayer(i);
			PlayerTextDrawShow(i, duelCT[i]);
		}
	}
	switch(DuelCountDown[InDuel[hostid]])
	{
		case 5, 4, 3, 2, 1:
		{
			format(str, sizeof(str), "%d", DuelCountDown[InDuel[hostid]]);

			foreach(new ii : Player)
			{
				if(InDuel[ii] == InDuel[hostid])
				{
					PlayerTextDrawSetString(ii, duelCT[ii], str);
					PlayerPlaySound(ii, 1056, 0.0, 0.0, 0.0);
				}
			}
		}
		case 0:
		{
			KillTimer(DuelTimer[hostid]);
			DuelTimer[hostid] = -1;
			
			foreach(new ii : Player)
			{
				if(InDuel[ii] == InDuel[hostid])
				{
					PlayerTextDrawHide(ii, duelCT[ii]);
					TogglePlayerControllable(ii, true);
					GameTextForPlayer(ii, "~r~~h~fight!", 4000, 3);
					PlayerPlaySound(ii, 3200, 0, 0, 0);
				}
			}
		}

	}
	DuelCountDown[InDuel[hostid]] --;
	return 1;
}

public CloseBets(hostid) {
	CantBet[hostid] = true;
}

// Custom Functions
GiveDuelWeapons(playerid)
{
	ResetPlayerWeapons(playerid);
	switch(DuelWeap[playerid])
	{
		case 1:
		{
			GivePlayerWeapon(playerid, 31, 500); // M4
			GivePlayerWeapon(playerid, 24, 400); // Deagle
			GivePlayerWeapon(playerid, 29, 800); // MP5
			GivePlayerWeapon(playerid, 27, 20); // Combat
		}
		case 2:
		{
			GivePlayerWeapon(playerid, 30, 500); // AK
			GivePlayerWeapon(playerid, 24, 400); // Deagle
			GivePlayerWeapon(playerid, 32, 800); // TEC-9
			GivePlayerWeapon(playerid, 26, 20); // SawnOff
		}
		case 3:
		{
			GivePlayerWeapon(playerid, 24, 400); // Deagle
		}
		case 4:
		{
			GivePlayerWeapon(playerid, 31, 1000); // M4
		}
		case 5:
		{
			GivePlayerWeapon(playerid, 30, 1000); // AK
		}
		case 6:
		{
			GivePlayerWeapon(playerid, 26, 500); // SawnOff
		}
		case 7:
		{
			GivePlayerWeapon(playerid, 27, 500); // Combat
		}
		case 8:
		{
			GivePlayerWeapon(playerid, 25, 500); // Shotgun
		}
		case 9:
		{
			GivePlayerWeapon(playerid, 29, 1800); // MP5
		}
		case 10:
		{
			GivePlayerWeapon(playerid, 32, 1800); // TEC-9
		}
		case 11:
		{
			GivePlayerWeapon(playerid, 23, 1000); // Silenced 9mm
		}
		case 12:
		{
			GivePlayerWeapon(playerid, 34, 800); // Sniper
		}
		case 13:
		{
			GivePlayerWeapon(playerid, 9, 1); // Chainsaw
		}
		case 14:
		{
			GivePlayerWeapon(playerid, 5, 1); // Bats
		}
		case 15:
		{
			GivePlayerWeapon(playerid, 16, 200); // Nades
		}
		case 16:
		{
			SetPVarInt(playerid, "givenByAdmin", 1);
			GivePlayerWeapon(playerid, WEAPON_ROCKETLAUNCHER, 200); // RPG
		}
		case 17:
		{
			GivePlayerWeapon(playerid, WEAPON_DEAGLE, 400);
			GivePlayerWeapon(playerid, WEAPON_SNIPER, 800);
			GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 500);
			
		}
		case 18:
		{
			GivePlayerWeapon(playerid, WEAPON_SPRAYCAN, 99999);
		}
		case 19:
		{
			GivePlayerWeapon(playerid, 28, 1500);
		}
	}
}

EndDuel(playerid) {
	if(InDuel[playerid] != -1) {
		new duelid = InDuel[playerid];
		foreach(new i : Player) {
			if(InDuel[i] != -1 && InDuel[i] == duelid) {
			 	PlayerTextDrawHide(i, duelCT[i]);
				SetPlayerTeam(i, 255);
				TogglePlayerControllable(i, true);
				InDuel[i] = -1;
				ResetPlayerWeapons(i);
				InDM[i] = 0;
				GameTextForPlayer(i, "~r~Duel Cancelled!", 3500, 5);
				LoadPlayerPosition(i);
				canUseKey[i] = true;
				CloseDuelGate(i);
				if(GetPVarInt(i, "wasDoingStunt")) {
					doingStunt[i] = 2;
					DeletePVar(i, "wasDoingStunt");
				}
				
				if(DuelTimer[i] != -1) {
					KillTimer(DuelTimer[i]);
					DuelTimer[i] = -1;
				}
		
				ToggleDuelMapsForPlayer(i, DuelMap[duelid], false);
				DeletePVar(i, "duelPlayer");
				DeletePVar(i, "duelPlayer2");
				DeletePVar(i, "duelPlayer3");
				DeletePVar(i, "duelPlayer4");
				DeletePVar(i, "duelInvited");
				DeletePVar(i, "duelHostID");
			}
			if(GetPVarInt(i, "bettedDuelID") == duelid) { // Really no cleaner way of doing this
																	// Unless we want a player loop inside a player loop.
				SetPVarInt(i, "bettedDuelID", -1);
				SetPVarInt(i, "betPlayer", -1);
				DeletePVar(i, "betAmount");
			}
		}
		
	}
	return 1;
}

// Inits a normal (1v1) duel.
InitDuel(playerid, enemy) {
	SavePlayerPosition(playerid);
	SavePlayerPosition(enemy);
	InDuel[playerid] = InDuel[enemy] = playerid; // 'playerid' will be the host anyway.
	DuelType[playerid] = DuelType[enemy] = DUEL_TYPE_NORMAL;
	ClosePlayerDialog(playerid);
	ClosePlayerDialog(enemy);
	ToggleDuelMapsForPlayer(playerid, DuelMap[playerid], true);
	ToggleDuelMapsForPlayer(enemy, DuelMap[playerid], true);
	
	if(DuelTimer[playerid] != -1 || DuelTimer[enemy] != -1) {
		if(DuelTimer[playerid] != -1)
			KillTimer(DuelTimer[playerid]);
		else
			KillTimer(DuelTimer[enemy]);
		
		DuelTimer[playerid] = DuelTimer[enemy] = -1;
	}
	
	format(str, sizeof(str), ""DUEL" "LB2_E"Duel between %s(%d) and %s(%d) is starting in 5 seconds! "GREY2_E"(Weapon: %s)", pName[enemy], enemy, pName[playerid], playerid, DuelWeapon[playerid]);
	SendClientMessageToAll(COLOR_LB, str);
	
	format(str, sizeof(str), "4DUEL: 2Duel between %s(%d) and %s(%d) is starting in 5 seconds! 1Weapon: %s.", pName[enemy], enemy, pName[playerid], playerid, DuelWeapon[playerid]);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), ""DUEL" "WHITEP_E"You accepted the duel with %s(%d), duel will start in 5 seconds..", pName[enemy], enemy);
	SendClientMessage(playerid, COLOR_WHITEP, str);

	format(str, sizeof(str), ""DUEL" "WHITEP_E"%s(%d) accepted the duel with you, duel will start in 5 seconds..",pName[playerid], playerid);
	SendClientMessage(enemy, COLOR_WHITEP, str);
	
	SetPlayerArmour(playerid, 0.0);
	SetPlayerArmour(enemy, 0.0);
	
	SetPlayerTeam(playerid, 255);
	SetPlayerTeam(enemy, 255);

	if(DuelWeap[playerid] != 14)
	{
		SetPlayerHealth(playerid, 100.0);
		SetPlayerHealth(enemy, 100.0);
	}
	else
	{
		SetPlayerHealth(playerid, 10.0);
		SetPlayerHealth(enemy, 10.0);
	}
	switch(DuelMap[playerid]) {
		case DUEL_MAP_CAGE: {
			SetPlayerPosition(playerid, 2181.0696,-2269.7246,923.0041,359.2627);
			SetPlayerPosition(enemy, 2181.2922,-2220.9055,923.0041,179.6897);
		}
		case DUEL_MAP_RCTRACK: { // Yes won!
			SetPlayerPosition(playerid, -1130.8488, 1057.7079, 1346.4141, 270.2878, 10);
			SetPlayerPosition(enemy, -974.9122, 1061.2727, 1345.6769, 88.5069, 10);
		}
		case DUEL_MAP_WAREHOUSE: {
			SetPlayerPosition(playerid, 1391.5095, -1.4223, 1000.9108, 179.7137, 1);
			SetPlayerPosition(enemy, 1391.4711, -46.2894, 1000.9236, 0.1721, 1);
		}
		case DUEL_MAP_LVPD: {
			SetPlayerPosition(playerid, 301.0262,173.1855,1007.1719,82.9401, 3);
			SetPlayerPosition(enemy, 236.2594,175.8766,1003.0234,268.9561, 3);
		}
		/*case DUEL_MAP_FAST: {
			SetPlayerPosition(playerid, -6479.1128,1544.7804,47.4229,268.5569);
			SetPlayerPosition(enemy, -6449.2383,1544.8979,47.4151,91.1852);
		}*/
	}
	
	TogglePlayerControllable(playerid, false);
	TogglePlayerControllable(enemy, false);
	
	SetPlayerVirtualWorld(playerid, -(WORLD_DUEL + playerid + enemy) * 2);
	SetPlayerVirtualWorld(enemy, -(WORLD_DUEL + playerid + enemy) * 2);
	
	if(doingStunt[playerid] != 0)
		SetPVarInt(playerid, "wasDoingStunt", 1);
	if(doingStunt[enemy] != 0)
		SetPVarInt(enemy, "wasDoingStunt", 1);
	
	if(GetPVarInt(playerid, "HideObjects")) {
		DeletePVar(playerid, "HideObjects");
		Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, 1);
	}
	
	if(GetPVarInt(enemy, "HideObjects")) {
		DeletePVar(enemy, "HideObjects");
		Streamer_ToggleItemUpdate(enemy, STREAMER_TYPE_OBJECT, 1);
	}
	
	doingStunt[playerid] = doingStunt[enemy] = 0;
	
	GodModeLabel(playerid, false);
	GodModeLabel(enemy, false);
	
	DuelCountDown[playerid] = 5;
	DuelTimer[playerid] = SetTimerEx("DuelCountDownTimer", 1000, 1, "i", playerid);
	
	GiveDuelWeapons(playerid);
	GiveDuelWeapons(enemy);
	
	InDM[playerid] = InDM[enemy] = 20;
	canUseKey[playerid] = canUseKey[enemy] = false;
	
	if(DuelMap[playerid] == DUEL_MAP_CAGE)
		SetTimerEx("OpenDuelGate", 1500, false, "ii", playerid, enemy);
	
	if(BetTimer[playerid] != -1)
		KillTimer(BetTimer[playerid]);
	
	CantBet[InDuel[playerid]] = false;
	BetTimer[playerid] = SetTimerEx("CloseBets", 17500, 0, "i", playerid);
	return 1;
}

// Inits a team (2v2) duel.
InitTeamDuel(playerid, player_team_mate, enemy, enemy_team_mate) {
	SavePlayerPosition(playerid);
	SavePlayerPosition(player_team_mate);
	SavePlayerPosition(enemy);
	SavePlayerPosition(enemy_team_mate);
	
	SetPVarInt(playerid, "duelTeamMate", player_team_mate);
	SetPVarInt(player_team_mate, "duelTeamMate", playerid);
	SetPVarInt(enemy, "duelTeamMate", enemy_team_mate);
	SetPVarInt(enemy_team_mate, "duelTeamMate", enemy);
	
	InDuel[playerid] = InDuel[player_team_mate] = InDuel[enemy] = InDuel[enemy_team_mate] = playerid;
	DuelType[playerid] = DuelType[player_team_mate] = DuelType[enemy] = DuelType[enemy_team_mate] = DUEL_TYPE_TEAM;
	SetPlayerTeam(playerid, 17);
	SetPlayerTeam(player_team_mate, 17);
	
	SetPlayerTeam(enemy, 18);
	SetPlayerTeam(enemy_team_mate, 18);
	
	ClosePlayerDialog(playerid);
	ClosePlayerDialog(player_team_mate);
	ClosePlayerDialog(enemy);
	ClosePlayerDialog(enemy_team_mate);
	ToggleDuelMapsForPlayer(playerid, DuelMap[playerid], true);
	ToggleDuelMapsForPlayer(player_team_mate, DuelMap[playerid], true);
	ToggleDuelMapsForPlayer(enemy, DuelMap[playerid], true);
	ToggleDuelMapsForPlayer(enemy_team_mate, DuelMap[playerid], true);
	
	format(str, sizeof(str), ""DUEL" "LB2_E"Duel between %s(%d) and %s(%d) vs %s(%d) and %s(%d) is starting in 5 seconds!"GREY2_E"(Weapon: %s)", pName[playerid], playerid, pName[player_team_mate], player_team_mate, pName[enemy], enemy, pName[enemy_team_mate], enemy_team_mate, DuelWeapon[playerid]);
	SendClientMessageToAll(COLOR_LB, str);
	format(str, sizeof(str), "**[Duel]** Duel between %s(%d) and %s(%d) vs %s(%d) and %s(%d) is starting in 5 seconds!", pName[playerid], playerid, pName[player_team_mate], player_team_mate, pName[enemy], enemy, pName[enemy_team_mate], enemy_team_mate, DuelWeapon[playerid]);
	//DCC_SendChannelMessage(Channel_Echo, str);
	
	SetPlayerArmour(playerid, 0);
	SetPlayerArmour(player_team_mate, 0);
	SetPlayerArmour(enemy, 0);
	SetPlayerArmour(enemy_team_mate, 0);
	
	if(DuelWeap[playerid] != 14)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerHealth(player_team_mate, 100);
		SetPlayerHealth(enemy, 100);
		SetPlayerHealth(enemy_team_mate, 100);
	}
	else
	{
		SetPlayerHealth(playerid, 10);
		SetPlayerHealth(player_team_mate, 10);
		SetPlayerHealth(enemy, 10);
		SetPlayerHealth(enemy_team_mate, 10);
	
	}
	switch(DuelMap[playerid]) {
		case DUEL_MAP_CAGE: {
			SetPlayerPosition(playerid, 2181.0696,-2269.7246,923.0041,359.2627);
			SetPlayerPosition(player_team_mate, 2181.0696+2,-2269.7246,923.0041,359.2627);
			
			SetPlayerPosition(enemy, 2181.2922,-2220.9055,923.0041,179.6897);
			SetPlayerPosition(enemy_team_mate, 2181.2922+2,-2220.9055,923.0041,179.6897);
		}
		case DUEL_MAP_RCTRACK: { // Yes won!
			SetPlayerPosition(playerid, -1130.8488, 1057.7079, 1346.4141, 270.2878, 10);
			SetPlayerPosition(player_team_mate, -1130.8488+2, 1057.7079, 1346.4141, 270.2878, 10);
			
			SetPlayerPosition(enemy, -974.9122, 1061.2727, 1345.6769, 88.5069, 10);
			SetPlayerPosition(enemy_team_mate, -974.9122+2,1061.2727,1345.6769,88.5069, 10);
		}
		case DUEL_MAP_WAREHOUSE: {
			SetPlayerPosition(playerid, 1391.5095,-1.4223,1000.9108,179.7137, 1);
			SetPlayerPosition(player_team_mate, 1391.5095+2,-1.4223,1000.9108,179.7137, 1);
			
			SetPlayerPosition(enemy,1391.4711,-46.2894,1000.9236,0.1721, 1);
			SetPlayerPosition(enemy_team_mate,1391.4711+2,-46.2894,1000.9236,0.1721, 1);
		}
		case DUEL_MAP_LVPD: {
			
		}
		/*case DUEL_MAP_FAST: {
			SetPlayerPosition(playerid, -6479.1128,1544.7804,47.4229,268.5569);
			SetPlayerPosition(player_team_mate, -6479.1128+2,1544.7804,47.4229,268.5569);
			
			SetPlayerPosition(enemy, -6449.2383,1544.8979,47.4151,91.1852);
			SetPlayerPosition(enemy_team_mate, -6449.2383+2,1544.8979,47.4151,91.1852);
		}*/
	}
	
	SetPlayerVirtualWorld(playerid, -(WORLD_DUEL + playerid + player_team_mate + enemy + enemy_team_mate) * 2);
	SetPlayerVirtualWorld(player_team_mate, -(WORLD_DUEL + playerid + player_team_mate + enemy + enemy_team_mate) * 2);
	SetPlayerVirtualWorld(enemy, -(WORLD_DUEL + playerid + player_team_mate + enemy + enemy_team_mate) * 2);
	SetPlayerVirtualWorld(enemy_team_mate, -(WORLD_DUEL + playerid + player_team_mate + enemy + enemy_team_mate) * 2);
	
	TogglePlayerControllable(playerid, false);
	TogglePlayerControllable(player_team_mate, false);
	TogglePlayerControllable(enemy, false);
	TogglePlayerControllable(enemy_team_mate, false);
	
	if(doingStunt[playerid])
		SetPVarInt(playerid, "wasDoingStunt", 1);
	
	if(doingStunt[player_team_mate])
		SetPVarInt(playerid, "wasDoingStunt", 1);
	
	if(doingStunt[enemy])
		SetPVarInt(playerid, "wasDoingStunt", 1);
	
	if(doingStunt[enemy_team_mate])
		SetPVarInt(playerid, "wasDoingStunt", 1);
	
	if(GetPVarInt(playerid, "HideObjects"))
		DeletePVar(playerid, "HideObjects"), Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, 1);
	
	if(GetPVarInt(player_team_mate, "HideObjects"))
		DeletePVar(player_team_mate, "HideObjects"), Streamer_ToggleItemUpdate(player_team_mate, STREAMER_TYPE_OBJECT, 1);
	
	if(GetPVarInt(enemy, "HideObjects"))
		DeletePVar(enemy, "HideObjects"), Streamer_ToggleItemUpdate(enemy, STREAMER_TYPE_OBJECT, 1);
	
	if(GetPVarInt(enemy_team_mate, "HideObjects"))
		DeletePVar(enemy_team_mate, "HideObjects"), Streamer_ToggleItemUpdate(enemy_team_mate, STREAMER_TYPE_OBJECT, 1);
	
	doingStunt[playerid] = doingStunt[player_team_mate] = doingStunt[enemy] = doingStunt[enemy_team_mate] = 0;
	InDM[playerid] = InDM[player_team_mate] = InDM[enemy] = InDM[enemy_team_mate] = 20;
	canUseKey[playerid] = canUseKey[player_team_mate] = canUseKey[enemy] = canUseKey[enemy_team_mate] = false;
	
	GodModeLabel(playerid, false);
	GodModeLabel(player_team_mate, false);
	GodModeLabel(enemy, false);
	GodModeLabel(enemy_team_mate, false);
	
	GiveDuelWeapons(playerid);	
	GiveDuelWeapons(player_team_mate);	
	GiveDuelWeapons(enemy);
	GiveDuelWeapons(enemy_team_mate);
	DuelCountDown[playerid] = 5;
	SetTimerEx("OpenDuelGate", 1500, 0, "iiii", playerid, player_team_mate, enemy, enemy_team_mate);
		
	if(BetTimer[playerid] != -1)
		KillTimer(BetTimer[playerid]);
	
	DuelTimer[playerid] = SetTimerEx("DuelCountDownTimer", 1000, 1, "iiii", playerid, player_team_mate, enemy, enemy_team_mate);
	
}

// Hooked callbacks
hook OnPlayerConnect(playerid) {
	InDuel[playerid] = -1;
	DuelWeapon[playerid] = "NONE";
	DuelCountDown[playerid] = 0;
	DuelType[playerid] = DUEL_TYPE_NONE;
	SetPVarInt(playerid, "bettedDuelID", -1);
	SetPVarInt(playerid, "betPlayer", -1);
	SetPVarInt(playerid, "duelInvited", 0);
	SetPVarInt(playerid, "duelTeamMate", -1);
	return 1;
}
	
hook OnPlayerDisconnect(playerid, reason) {
	if(InDuel[playerid] != -1) {
		format(str, sizeof(str), ""DUEL" "GREY_E"%s has left. Duel has been cancelled.", pName[playerid]);
		SendClientMessageToAll(COLOR_GREY, str);
		foreach(new i : Player) {
			if(GetPVarInt(i, "bettedDuelID") == InDuel[playerid]) {
				new amount = GetPVarInt(i, "betAmount");
				GivePlayerCash(i, amount);
				format(str,sizeof(str),""RED_E"[BET] "WHITEP_E"%s(%i) has left the duel, you have been refunded "LG_E"$%s!", pName[playerid], playerid, ToCurrency(amount));
				SendClientMessage(i, COLOR_WHITEP, str);
				SetPVarInt(i, "betPlayer", -1);
				DeletePVar(i, "betAmount");
				SetPVarInt(i, "bettedDuelID", -1);
			}	
		}
		EndDuel(playerid);
	}
	
	InDuel[playerid] = -1;
	DuelWeapon[playerid] = "NONE";
	DuelCountDown[playerid] = 0;
	DuelType[playerid] = DUEL_TYPE_NONE;
	return 1;
}

hook OnPlayerDeath(playerid, killerid, reason) {
	if(killerid == INVALID_PLAYER_ID && GetPVarInt(playerid, "killerID") != -1)
		killerid = GetPVarInt(playerid, "killerID"),  reason = GetPVarInt(playerid, "killerWeapon");
	
	if(killerid == INVALID_PLAYER_ID && InDuel[playerid] != -1) {
		format(str, sizeof(str), ""DUEL" "LB2_E"%s(%i) has died. Duel ended.", pName[playerid], playerid);
		SendClientMessageToAll(COLOR_GREY, str);
		EndDuel(playerid);
		return 1;
	}
	else if(InDuel[playerid] != -1 && InDuel[playerid] == InDuel[killerid] && DuelType[InDuel[playerid]] == DUEL_TYPE_TEAM) { // Team duel
		new team_mate = GetPVarInt(playerid, "duelTeamMate");
		
		if(team_mate == killerid) {
			format(str, sizeof(str), ""DUEL" "LB2_E"%s(%i) has killed %s(%i) their own teammate in the duel! Duel ended.", pName[team_mate], team_mate, pName[playerid], playerid);
			SendClientMessageToAll(COLOR_LB, str);
			EndDuel(playerid);
			return 1;
		}	
		ResetPlayerWeapons(playerid);
		new Float:Health;
		GetPlayerHealth(killerid, Health);
		if(Health > 90.0)
		{
			format(str, sizeof(str), ""DUEL" "LB2_E"%s(%i) has destroyed %s(%i) in the double duel %.2f health left!", pName[killerid], killerid, pName[playerid], playerid, Health);
			SendClientMessageToAll(COLOR_LB, str);
			switch(random(8))
			{
				case 0:
				{
					format(str, sizeof(str), "Damn %s you got ripped..", pName[playerid]);
					SendBotMsg(str);
				}
				case 1:
				{
					format(str, sizeof(str), "I'll call the ambulance for you, %s", pName[playerid]);
					SendBotMsg(str);
				}
				case 2:
				{
					format(str, sizeof(str), "Ow that must've hurt %s", pName[playerid]);
					SendBotMsg(str);
				}
				case 3:
				{
					format(str, sizeof(str), "Damn %s, %s just shitted on you lol", pName[playerid], pName[killerid]);
					SendBotMsg(str);
				}
				case 4: { }
				case 5: { }
				case 6: { }
				case 7: { }
			}
		}
		else
		{
			format(str, sizeof(str),""DUEL" "LB2_E"%s(%i) has killed %s(%i) and has %.2f health left!", pName[killerid], killerid, pName[playerid], playerid, Health);
			SendClientMessageToAll(COLOR_LB, str);
			switch(random(8))
			{
				case 0:
				{
					format(str, sizeof(str), "Better luck next time %s", pName[playerid]);
					SendBotMsg(str);
				}
				case 1:
				{
					SendBotMsg("Rematch! Rematch! Rematch!");
				}
				case 2:
				{
					format(str, sizeof(str), "Good job %s, they know better now!", pName[killerid]); 
					SendBotMsg(str);
				}
				case 3:
				{
					format(str, sizeof(str), "R.I.P %s...", pName[playerid]);
					SendBotMsg(str);
				}
				case 4: { }
				case 5: { }
				case 6: { }
				case 7: { }
			}
		}
		
		InDuel[playerid] = -1;
		InDM[playerid] = 0;
		canUseKey[playerid] = true;
		GivePlayerScore(playerid, -1);
		LoadPlayerPosition(playerid);
		ResetPlayerWeapons(playerid);
		
		if(GetPVarInt(playerid, "wasDoingStunt")) {
			doingStunt[playerid] = 2;
			DeletePVar(playerid, "wasDoingStunt");
		}
		
		if(team_mate != -1 && InDuel[team_mate] == -1) {
			new killer_team_mate = GetPVarInt(killerid, "duelTeamMate");
			GivePlayerScore(killerid, 3);
			GivePlayerScore(killer_team_mate, 3);
			
			GivePlayerCash(killerid, 8000);
			GivePlayerCash(killer_team_mate, 8000);
			
			pDuelsWon[killerid]++;
	  		
			pDuelsWon[killer_team_mate]++;
			
			if(pDuelsWon[killerid] == 50 && !pAch19[killerid]) {
				pAch19[killerid] = 1;
				format(query, sizeof(query), "UPDATE achievements SET a19=1 WHERE reg_id=%d", pRegID[killerid]);
				MySQL_updateQuery(query);
				GivePlayerAchievement(killerid, "Duelist", "Congrats you have won 50 duels!~n~~y~+$100000 and 5 score!~n~~w~Type /ach to view your achievements.");
			}
			
			if(pDuelsWon[killer_team_mate] == 50 && !pAch19[killer_team_mate]) {
				pAch19[killer_team_mate] = 1;
				format(query, sizeof(query), "UPDATE achievements SET a19=1 WHERE reg_id=%d", pRegID[killer_team_mate]);
				MySQL_updateQuery(query);
				GivePlayerAchievement(killer_team_mate, "Duelist", "Congrats you have won 50 duels!~n~~y~+$100000 and 5 score!~n~~w~Type /ach to view your achievements.");
			}
			
			format(str, sizeof(str),""DUEL" "LB2_E"%s(%i) and %s(%d) have won the duel against %s(%i) and %s(%d)!", pName[killerid], killerid, pName[killer_team_mate], killer_team_mate, pName[playerid], playerid, pName[team_mate], team_mate);
			SendClientMessageToAll(COLOR_LB, str);
			
			if(InDuel[killer_team_mate] != -1) {
				InDuel[killer_team_mate] = -1;
				InDM[killer_team_mate] = 0;
				canUseKey[killer_team_mate] = true;
				GivePlayerScore(killer_team_mate, -1);
				LoadPlayerPosition(killer_team_mate);
				if(GetPVarInt(killer_team_mate, "wasDoingStunt")) {
					doingStunt[killer_team_mate] = 2;
					DeletePVar(killer_team_mate, "wasDoingStunt");
				}
				ResetPlayerWeapons(killer_team_mate);
			}
			InDuel[killerid] = -1;
			InDM[killerid] = 0;
			canUseKey[killerid] = true;
			GivePlayerScore(killerid, -1);
			LoadPlayerPosition(killerid);
			if(GetPVarInt(killerid, "wasDoingStunt")) {
				doingStunt[killerid] = 2;
				DeletePVar(killerid, "wasDoingStunt");
			}
			ResetPlayerWeapons(killerid);	
		
			// Give Bets
			foreach(new ii : Player)
			{
				if(GetPVarInt(playerid, "bettedDuelID") == InDuel[killerid])
				{
					if(GetPVarInt(ii, "betPlayer") == killerid || GetPVarInt(ii, "betPlayer") == killer_team_mate) {
						new amount = (GetPVarInt(ii, "betAmount") * 2);
						GivePlayerCash(ii, amount);
						format(str,sizeof(str),""RED_E"[BET] "WHITEP_E"%s(%i) and %s(%i) has won the duel, you have received "LG_E"$%s!", pName[killerid], killerid, pName[killer_team_mate], killer_team_mate, ToCurrency(amount));
						SendClientMessage(ii, COLOR_WHITEP, str);
					}
					SetPVarInt(ii, "betPlayer", -1);
					DeletePVar(ii, "betAmount");
					SetPVarInt(ii, "bettedDuelID", -1);
				}
			}
		}
	}
	else if(InDuel[playerid] != -1 && InDuel[playerid] == InDuel[killerid] && DuelType[InDuel[playerid]] == DUEL_TYPE_NORMAL) {
		new Float:Health;
		GetPlayerHealth(killerid, Health);

		pDuelsWon[killerid]++;
		ResetPlayerWeapons(killerid);
		ResetPlayerWeapons(playerid);
		format(query, sizeof(query), "UPDATE players SET duels_won=duels_won+1 WHERE reg_id=%d", pRegID[killerid]);
		MySQL_updateQuery(query);
		if(Health > 90.0)
		{
			format(str, sizeof(str), ""DUEL" "LB2_E"%s(%i) has destroyed %s(%i) in the duel %.2f health left!", pName[killerid], killerid, pName[playerid], playerid, Health);
			SendClientMessageToAll(COLOR_LB, str);
			switch(random(8))
			{
				case 0:
				{
					format(str, sizeof(str), "Damn %s you got ripped..", pName[playerid]);
					SendBotMsg(str);
				}
				case 1:
				{
					format(str, sizeof(str), "I'll call the ambulance for you, %s", pName[playerid]);
					SendBotMsg(str);
				}
				case 2:
				{
					format(str, sizeof(str), "Ow that must've hurt %s", pName[playerid]);
					SendBotMsg(str);
				}
				case 3:
				{
					format(str, sizeof(str), "Damn %s, %s just shitted on you lol", pName[playerid], pName[killerid]);
					SendBotMsg(str);
				}
				case 4: { }
				case 5: { }
				case 6: { }
				case 7: { }
			}
		}
		else
		{
			format(str, sizeof(str),""DUEL" "LB2_E"%s(%i) has won the duel against %s(%i) and has %.2f health left!", pName[killerid], killerid, pName[playerid], playerid, Health);
			SendClientMessageToAll(COLOR_LB, str);
			switch(random(8))
			{
				case 0:
				{
					format(str, sizeof(str), "Better luck next time %s", pName[playerid]);
					SendBotMsg(str);
				}
				case 1:
				{
					SendBotMsg("Rematch! Rematch! Rematch!");
				}
				case 2:
				{
					format(str, sizeof(str), "Good job %s, they know better now!", pName[killerid]);
					SendBotMsg(str);
				}
				case 3:
				{
					format(str, sizeof(str), "R.I.P %s...", pName[playerid]);
					SendBotMsg(str);
				}
				case 4: { }
				case 5: { }
				case 6: { }
				case 7: { }
			}
		}
		format(str, sizeof(str), "4DUEL: 2%s(%i) has won the duel against %s(%i) with %.2f health left.", pName[killerid], killerid, pName[playerid], playerid, Health);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		InDuel[playerid] = -1;
		InDuel[killerid] = -1;
		InDM[playerid] = 0;
		InDM[killerid] = 0;		
		format(str, sizeof(str), "~w~You won the duel against ~r~~h~%s(%d)~n~~w~+~g~$~w~7000~w~ and +2 score", pName[playerid], playerid);
		InfoTD_MSG(killerid, 4000, str);
		LoadPlayerPosition(killerid);
		GodModeLabel(killerid, true);
		GivePlayerCash(killerid, 7000);
		GivePlayerScore(killerid, 2);
		GivePlayerScore(playerid, -1);
		canUseKey[playerid] = true;
		canUseKey[killerid] = true;
		if(GetPVarInt(killerid, "wasDoingStunt") == 1)
		{
			doingStunt[killerid] = 2;
			DeletePVar(killerid, "wasDoingStunt");
			ResetPlayerWeapons(killerid);
		}
		
		if(pDuelsWon[killerid] == 50 && !pAch19[killerid]) {
			pAch19[killerid] = 1;
			format(query, sizeof(query), "UPDATE achievements SET a19=1 WHERE reg_id=%d", pRegID[killerid]);
			MySQL_updateQuery(query);
			GivePlayerAchievement(killerid, "Duelist", "Congrats you have won 50 duels!~n~~y~+$100000 and 5 score!~n~~w~Type /ach to view your achievements.");
		}
		// Give Bets
		foreach(new ii : Player)
		{
			if( GetPVarInt(playerid, "bettedDuelID") == InDuel[killerid])
			{
				if(GetPVarInt(ii, "betPlayer") == killerid) {
					new amount = (GetPVarInt(ii, "betAmount") * 2);
					GivePlayerCash(ii, amount);
					format(str,sizeof(str),""RED_E"[BET] "WHITEP_E"%s(%i) has won the duel, you have received "LG_E"$%s!", pName[killerid], killerid, ToCurrency(amount));
					SendClientMessage(ii, COLOR_WHITEP, str);
				}
				SetPVarInt(ii, "betPlayer", -1);
				DeletePVar(ii, "betAmount");
				SetPVarInt(ii, "bettedDuelID", -1);
			}
		}
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	
	if(GetPVarInt(playerid, "spoof") > gettime())
		return 1;
	
	switch(dialogid) {
		case DIALOG_DUEL: {
			new duelplayer = GetPVarInt(playerid, "duelPlayer");
			
			if(InDuel[duelplayer] != -1) {
				DeletePVar(playerid, "duelInvited");
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelInvited");
				return Error(playerid, "That player is already in a duel.");
			}
			if(!IsPlayerConnected(duelplayer)) {
				DeletePVar(playerid, "duelInvited");
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelInvited");
				return Error(playerid, "Player is not connected.");
			}
			
			if(GetPVarInt(duelplayer, "duelPlayer") != playerid) {
				DeletePVar(playerid, "duelInvited");
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelInvited");
				return Error(playerid, "That player is invited to a duel or has invited someone else to a duel!");
			}
			if(response) {
				switch(listitem) {
					case 0:
					{
						DuelWeapon[playerid] = "M4/Deagle/MP5/Combat";
						DuelWeap[playerid] = 1;
						DuelWeap[duelplayer] = 1;
					}
					case 1:
					{
						DuelWeapon[playerid] = "AK/Deagle/Tec-9/Sawn-Off";
						DuelWeap[playerid] = 2;
						DuelWeap[duelplayer] = 2;
					}
					case 2:
					{
						DuelWeapon[playerid] = "Deagle";
						DuelWeap[playerid] = 3;
						DuelWeap[duelplayer] = 3;
					}
					case 3:
					{
						DuelWeapon[playerid] = "M4";
						DuelWeap[playerid] = 4;
						DuelWeap[duelplayer] = 4;
					}
					case 4:
					{
						DuelWeapon[playerid] = "AK-47";
						DuelWeap[playerid] = 5;
						DuelWeap[duelplayer] = 5;
					}
					case 5:
					{
						DuelWeapon[playerid] = "Sawn-Off";
						DuelWeap[playerid] = 6;
						DuelWeap[duelplayer] = 6;
					}
					case 6:
					{
						DuelWeapon[playerid] = "Combat";
						DuelWeap[playerid] = 7;
						DuelWeap[duelplayer] = 7;
					}
					case 7:
					{
						DuelWeapon[playerid] = "Shotgun";
						DuelWeap[playerid] = 8;
						DuelWeap[duelplayer] = 8;
					}
					case 8:
					{
						DuelWeapon[playerid] = "MP5";
						DuelWeap[playerid] = 9;
						DuelWeap[duelplayer] = 9;
					}
					case 9:
					{
						DuelWeapon[playerid] = "TEC-9";
						DuelWeap[playerid] = 10;
						DuelWeap[duelplayer] = 10;
					}
					case 10:
					{
						DuelWeapon[playerid] = "Silenced 9mm";
						DuelWeap[playerid] = 11;
						DuelWeap[duelplayer] = 11;
					}
					case 11:
					{
						DuelWeapon[playerid] = "Sniper Rifle";
						DuelWeap[playerid] = 12;
						DuelWeap[duelplayer] = 12;
					}
					case 12:
					{
						DuelWeapon[playerid] = "Chainsaw";
						DuelWeap[playerid] = 13;
						DuelWeap[duelplayer] = 13;
					}
					case 13:
					{
						DuelWeapon[playerid] = "Bats";
						DuelWeap[playerid] = 14;
						DuelWeap[duelplayer] = 14;
					}
					case 14:
					{
						DuelWeapon[playerid] = "Grenades";
						DuelWeap[playerid] = 15;
						DuelWeap[duelplayer] = 15;
					}
					case 15: {
						DuelWeapon[playerid] = "RPG";
						DuelWeap[playerid] = 16;
						DuelWeap[duelplayer] = 16;
					}
					case 16: {
						DuelWeapon[playerid] = "Deagle/Shotgun/Sniper";
						DuelWeap[playerid] = 17;
						DuelWeap[duelplayer] = 17;
					}
					case 17: {
						DuelWeapon[playerid] = "Spray can";
						DuelWeap[playerid] = 18;
						DuelWeap[duelplayer] = 18;
					}
					case 18: {
						DuelWeapon[playerid] = "Micro SMG";
						DuelWeap[playerid] = 19;
						DuelWeap[duelplayer] = 19;
					}
				}
				ShowPlayerDialog(playerid, DIALOG_DUEL+1, DIALOG_STYLE_LIST, "Duel - Map Selection", "Cage (normal)\nBattlefield\nWarehouse\nLVPD\nFast", "Select", "Cancel");
			}
			else {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(duelplayer, "duelInvited");
			}
			return 1;
		}
		case DIALOG_DUEL + 1: { // DUEL MAP 
			new duelplayer = GetPVarInt(playerid, "duelPlayer");
			if(!response) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(duelplayer, "duelInvited");
				return 1;
			}
		
			
			if(InDuel[duelplayer] != -1) {
				DeletePVar(playerid, "duelInvited");
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelInvited");
				return Error(playerid, "That player is already in a duel.");
			}
			if(!IsPlayerConnected(duelplayer)) {
				DeletePVar(playerid, "duelInvited");
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelInvited");
				return Error(playerid, "Player is not connected.");
			}
			if(GetPVarInt(duelplayer, "duelPlayer") != playerid) {
				DeletePVar(playerid, "duelInvited");
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(duelplayer, "duelInvited");
				return Error(playerid, "That player is invited to a duel or has invited someone else to a duel!");
			}
			switch(listitem) {
				case 0: {
					DuelMap[playerid] = DuelMap[duelplayer] = DUEL_MAP_CAGE;
					DuelMapName[playerid] = "Cage (normal)";
					DuelMapName[duelplayer] = "Cage (normal)";
				}
				case 1: {
					DuelMap[playerid] = DuelMap[duelplayer] = DUEL_MAP_RCTRACK;
					DuelMapName[playerid] = "Battlefield";
					DuelMapName[duelplayer] = "Battlefield";
				}
				case 2: {
					DuelMap[playerid] = DuelMap[duelplayer] = DUEL_MAP_WAREHOUSE;
					DuelMapName[playerid] = "Warehouse";
					DuelMapName[duelplayer] = "Warehouse";
				}
				case 3: {
					DuelMap[playerid] = DuelMap[duelplayer] = DUEL_MAP_LVPD;
					DuelMapName[playerid] = "LVPD";
					DuelMapName[duelplayer] = "LVPD";
				}
				/*case 4: {
					//DuelMap[playerid] = DuelMap[duelplayer] = DUEL_MAP_FAST;
					DuelMapName[playerid] = "Fast";
					DuelMapName[duelplayer] = "Fast";
				}*/
			}
			if(pSpectating[duelplayer] != -1) return Error(playerid, "Player is currently spectating.");
			if(InDM[duelplayer] != 0) return Error(playerid, "Player just joined a DM, you can't duel them now!");

			format(line, sizeof(line), ""RED_E"%s(%d) "WHITE_E"has challenged you to a duel!\n\n"dot""WHITE_E"Weapon: "LB2_E"%s\n"dot""WHITE_E"Area: "LB2_E"%s\n\n"WHITE_E"Click on accept to confirm to duel, or cancel to deny it.", pName[playerid], playerid, DuelWeapon[playerid], DuelMapName[playerid]);
			ShowPlayerDialog(duelplayer, DIALOG_DUEL+2, DIALOG_STYLE_MSGBOX, ""RED_E"DUEL", line, "Accept", "Cancel");
			format(str, sizeof(str), ""DUEL" You have invited %s(%d) to duel, wait till the player accepts your invitation.", pName[duelplayer], duelplayer);
			SendClientMessage(playerid, COLOR_YELLOW, str);
			format(str, sizeof(str), ""DUEL" %s(%d) has challenged you to a duel! Weapon: "GREY_E"%s", pName[playerid], playerid, DuelWeapon[playerid]);
			SendClientMessage(duelplayer, COLOR_YELLOW, str);
			SendClientMessage(duelplayer, COLOR_YELLOW, ""DUEL" Click on 'duel' to accept the challenge.");
			SetPVarInt(duelplayer, "duelPlayer", playerid);
			if(GetPVarInt(duelplayer, "FirstDuel") == 0)
			{
				SendClientMessage(duelplayer, COLOR_LB, ""ORANGE_E"* "LB2_E"Use "ORANGE_E"/togduel "LB2_E"to turn off duel requests.");
				SetPVarInt(duelplayer, "FirstDuel", 1);
			}
			return 1;
		}
		case DIALOG_DUEL + 2: { // ACCEPT/DENY DUEL
			new otherplayer = GetPVarInt(playerid, "duelPlayer");
			
			if(!IsPlayerConnected(otherplayer)) {
				DeletePVar(playerid, "duelInvited");
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				return Error(playerid, "Player is not connected!");
			}
			
			if(response) {
				if(GetPVarInt(playerid, "duelPlayer") != otherplayer) {
					DeletePVar(playerid, "duelInvited");
					DeletePVar(playerid, "duelPlayer");
					DeletePVar(otherplayer, "duelInvited");
					return Error(playerid, "Player has already cancelled the duel invite.");
				}
				InitDuel(otherplayer, playerid);
			}
			else {
				format(str, sizeof(str), ""Server" "GREY_E"%s(%d) has denied your request for a duel.", pName[playerid], playerid);
				SendClientMessage(otherplayer, COLOR_GREY, str);
			}
			DeletePVar(playerid, "duelPlayer");
			DeletePVar(playerid, "duelInvited");
			DeletePVar(otherplayer, "duelPlayer");
			DeletePVar(otherplayer, "duelInvited");
		}
		
		// TEAM
		case DIALOG_DUEL + 3: { // TEAM WEP
			new otherplayer = GetPVarInt(playerid, "duelPlayer");
		 	new nextplayer = GetPVarInt(playerid,"duelPlayer2");
    		new lastplayer = GetPVarInt(playerid,"duelPlayer3");
		
			if(!response) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");	
			}
			if(!IsPlayerConnected(otherplayer) || !IsPlayerConnected(nextplayer) || !IsPlayerConnected(lastplayer)) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				return Error(playerid, "One of the players are not connected, cannot duel!");
			}
			if(response) {
				switch(listitem) {
					case 0:
					{
						DuelWeapon[playerid] = "M4/Deagle/MP5/Combat";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 1;
					}
					case 1:
					{
						DuelWeapon[playerid] = "AK/Deagle/Tec-9/Sawn-Off";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 2;
					}
					case 2:
					{
						DuelWeapon[playerid] = "Deagle";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 3;
					}
					case 3:
					{
						DuelWeapon[playerid] = "M4";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 4;
					}
					case 4:
					{
						DuelWeapon[playerid] = "AK-47";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 5;
					}
					case 5:
					{
						DuelWeapon[playerid] = "Sawn-Off";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 6;
					}
					case 6:
					{
						DuelWeapon[playerid] = "Combat";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 7;
					}
					case 7:
					{
						DuelWeapon[playerid] = "Shotgun";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 8;
					}
					case 8:
					{
						DuelWeapon[playerid] = "MP5";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 9;
					}
					case 9:
					{
						DuelWeapon[playerid] = "TEC-9";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 10;
					}
					case 10:
					{
						DuelWeapon[playerid] = "Silenced 9mm";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 11;
					}
					case 11:
					{
						DuelWeapon[playerid] = "Sniper Rifle";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 12;
					}
					case 12:
					{
						DuelWeapon[playerid] = "Chainsaw";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 13;
					}
					case 13:
					{
						DuelWeapon[playerid] = "Bats";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 14;
					}
					case 14:
					{
						DuelWeapon[playerid] = "Grenades";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 15;
					}
					case 15: {
						DuelWeapon[playerid] = "RPG";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 16;
					}
					case 16: {
						DuelWeapon[playerid] = "Deagle/Shotgun/Sniper";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 17;
					}
					
					case 17: {
						DuelWeapon[playerid] = "Spray can";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 18;
					}
					case 18: {
						DuelWeapon[playerid] = "Micro SMG";
						DuelWeap[playerid] = DuelWeap[otherplayer] = DuelWeap[nextplayer] = DuelWeap[lastplayer] = 19;
					}
				}
				ShowPlayerDialog(playerid, DIALOG_DUEL+4, DIALOG_STYLE_LIST, "Duel - Map Selection", "Cage (normal)\nBattlefield\nWarehouse\nLVPD\nFast", "Select", "Cancel");
			}
		}
		case DIALOG_DUEL + 4: { //TEAM MAP
			new otherplayer = GetPVarInt(playerid, "duelPlayer");
		 	new nextplayer = GetPVarInt(playerid,"duelPlayer2");
    		new lastplayer = GetPVarInt(playerid,"duelPlayer3");
		
			if(!response) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				return 1;
			}
		
			
			if(InDuel[otherplayer] != -1 || InDuel[nextplayer] != -1 || InDuel[lastplayer] != -1)
				return Error(playerid, "A player is already in a duel.");
			
			if(!IsPlayerConnected(otherplayer) || !IsPlayerConnected(nextplayer) || !IsPlayerConnected(lastplayer))
				return Error(playerid, "A player is not connected.");
			
			if(GetPVarInt(otherplayer, "duelPlayer") != playerid || GetPVarInt(nextplayer, "duelPlayer") != playerid || GetPVarInt(lastplayer, "duelPlayer") != playerid)
				return Error(playerid, "A player is already invited to a duel or has invited someone else to a duel!");
			
			switch(listitem) {
				case 0: {
					DuelMap[playerid] = DuelMap[otherplayer] = DuelMap[nextplayer] = DuelMap[lastplayer] = DUEL_MAP_CAGE;
					DuelMapName[playerid] = "Cage (normal)";
				}
				case 1: {
					DuelMap[playerid] = DuelMap[otherplayer] = DuelMap[nextplayer] = DuelMap[lastplayer] = DUEL_MAP_RCTRACK;
					DuelMapName[playerid] = "Battlefield";
				}
				case 2: {
					DuelMap[playerid] = DuelMap[otherplayer] = DuelMap[nextplayer] = DuelMap[lastplayer] = DUEL_MAP_WAREHOUSE;
					DuelMapName[playerid] = "Warehouse";
				}
				case 3: {
					DuelMap[playerid] = DuelMap[otherplayer] = DuelMap[nextplayer] = DuelMap[lastplayer] = DUEL_MAP_LVPD;
					DuelMapName[playerid] = "LVPD";
				}
				/*case 4: {
					//DuelMap[playerid] = DuelMap[otherplayer] = DuelMap[nextplayer] = DuelMap[lastplayer] = DUEL_MAP_FAST;
					DuelMapName[playerid] = "Fast";
				}*/
			}
			if(pSpectating[otherplayer] != -1 || pSpectating[nextplayer] != -1 || pSpectating[lastplayer] != -1)  {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				return Error(playerid, "A player is currently spectating.");
			}
			if(InDM[otherplayer] != 0 || InDM[nextplayer] != 0 || InDM[lastplayer] != 0) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				return Error(playerid, "A player just joined a DM, you can't duel them now!");
			}
			format(str, sizeof(str), ""DUEL" "LB2_E"You have invited %s(%i) to be your teammate for the double duel. Please wait until they respond.", pName[otherplayer], otherplayer);
			SendClientMessage(playerid, COLOR_GREY, str);
			
			format(str, sizeof(str), ""DUEL" "LB2_E"%s(%i) has invited you to be their teammate for the double duel.", pName[playerid], playerid);
			SendClientMessage(otherplayer, COLOR_GREY, str);
			
			format(line, sizeof(line), ""RED_E"%s(%d) "WHITE_E"has invited you to a double duel!\n\n"dot""WHITE_E"Weapon: "LB2_E"%s\n"dot""WHITE_E"Area: "LB2_E"%s\n\n"dot"Team: %s(%i) and %s(%i)\n"dot"%s(%i) and %s(%i)"WHITE_E"Click on accept to confirm to duel, or cancel to deny it.", pName[playerid], playerid, DuelWeapon[playerid], DuelMapName[playerid], pName[playerid], playerid, pName[otherplayer], otherplayer, pName[nextplayer], nextplayer, pName[lastplayer], lastplayer);
			ShowPlayerDialog(otherplayer, DIALOG_DUEL + 5, DIALOG_STYLE_MSGBOX, ""RED_E"Server - Double Duel", line, "Accept", "Deny");
		}
		case DIALOG_DUEL + 5: { // DDUEL - PLAYER TEAMMATE
			new player = GetPVarInt(playerid, "duelPlayer");
		 	new nextplayer = GetPVarInt(player,"duelPlayer2");
    		new lastplayer = GetPVarInt(player,"duelPlayer3");
			
			if(!response) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(player, "duelPlayer");
				DeletePVar(player, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				format(str, sizeof(str),""DUEL" "LB2_E"%s(%i) has denied your invite as your partner.", pName[playerid], playerid);
				return SendClientMessage(player, COLOR_GREY, str);
			}
			if(InDuel[playerid] != -1 || InDM[playerid]) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(player, "duelPlayer");
				DeletePVar(player, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				return Error(player, "A player is already in a duel.");
			}
			
			format(str, sizeof(str), ""DUEL" "LB2_E"%s(%i) has accepted to be your partner.", pName[playerid], playerid);
			SendClientMessage(player, COLOR_GREY, str);
			
			format(line, sizeof(line), ""RED_E"%s(%d) and %s(%d) "WHITE_E"has invited you to a double duel!\n\n"dot""WHITE_E"Weapon: "LB2_E"%s\n"dot""WHITE_E"Area: "LB2_E"%s\n\n"dot"Team: %s(%i) and %s(%i)\n"dot"%s(%i) and %s(%i)"WHITE_E"Click on accept to confirm to duel, or cancel to deny it.", pName[player], player, pName[playerid], playerid, DuelWeapon[player], DuelMapName[player], pName[player], player, pName[playerid], playerid, pName[nextplayer], nextplayer, pName[lastplayer], lastplayer);
			ShowPlayerDialog(nextplayer, DIALOG_DUEL + 6, DIALOG_STYLE_MSGBOX, ""RED_E"Server - Double Duel", line, "Accept", "Deny");
		}
		case DIALOG_DUEL + 6: { // DDUEL - ENEMY 1
			new player = GetPVarInt(playerid, "duelPlayer");
		 	new otherplayer = GetPVarInt(player,"duelPlayer");
    		new lastplayer = GetPVarInt(player,"duelPlayer3");
			
			if(!response) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(player, "duelPlayer");
				DeletePVar(player, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				format(str, sizeof(str),""DUEL" "LB2_E"%s(%i) has denied your invite to the double duel.", pName[playerid], playerid);
				return SendClientMessage(player, COLOR_GREY, str);
			}
			if(InDuel[playerid] != -1 || InDM[playerid]) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(player, "duelPlayer");
				DeletePVar(player, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(lastplayer, "duelPlayer");
				DeletePVar(lastplayer, "duelInvited");
				return Error(player, "A player is already in a duel.");
			}
			
			format(str, sizeof(str), ""DUEL" "LB2_E"%s(%i) has accepted your invite to the double duel.", pName[playerid], playerid);
			SendClientMessage(player, COLOR_GREY, str);
			
			format(line, sizeof(line), ""RED_E"%s(%d) "WHITE_E"has invited you to a double duel!\n\n"dot""WHITE_E"Weapon: "LB2_E"%s\n"dot""WHITE_E"Area: "LB2_E"%s\n\n"dot"Team: %s(%i) and %s(%i)\n"dot"%s(%i) and %s(%i)"WHITE_E"Click on accept to confirm to duel, or cancel to deny it.", pName[playerid], playerid, DuelWeapon[player], DuelMapName[player], pName[player], player, pName[otherplayer], otherplayer, pName[playerid], playerid, pName[lastplayer], lastplayer);
			ShowPlayerDialog(lastplayer, DIALOG_DUEL + 7, DIALOG_STYLE_MSGBOX, ""RED_E"Server - Double Duel", line, "Accept", "Deny");
		}
		case DIALOG_DUEL + 7: { // DDUEL - ENEMY 2 - TEAMMATE
			new player = GetPVarInt(playerid, "duelPlayer");
		 	new otherplayer = GetPVarInt(player,"duelPlayer");
    		new nextplayer = GetPVarInt(player,"duelPlayer2");
			
			if(!response) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(player, "duelPlayer");
				DeletePVar(player, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				format(str, sizeof(str),""DUEL" "LB2_E"%s(%i) has denied your invite to the double duel.", pName[playerid], playerid);
				return SendClientMessage(player, COLOR_GREY, str);
			}
			if(InDuel[playerid] != -1 || InDM[playerid]) {
				DeletePVar(playerid, "duelPlayer");
				DeletePVar(playerid, "duelInvited");
				DeletePVar(player, "duelPlayer");
				DeletePVar(player, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(nextplayer, "duelPlayer");
				DeletePVar(nextplayer, "duelInvited");
				return Error(player, "A player is already in a duel.");
			}
			
			InitTeamDuel(player, otherplayer, nextplayer, playerid);
			DeletePVar(playerid, "duelPlayer");
			DeletePVar(playerid, "duelInvited");
			DeletePVar(player, "duelPlayer");
			DeletePVar(player, "duelInvited");
			DeletePVar(otherplayer, "duelPlayer");
			DeletePVar(otherplayer, "duelInvited");
			DeletePVar(nextplayer, "duelPlayer");
			DeletePVar(nextplayer, "duelInvited");
		}
	}
	return 0;
}

// COMMANDS
CMD:bet(playerid, params[])
{
	new format_z[128];
	if(gettime() < GetPVarInt(playerid, "lastBetTime")+200) {
    	format(format_z, sizeof format_z, "{FF0000}[ERROR] {FFFFFF}You can bet again in %i seconds.", (GetPVarInt(playerid, "lastBetTime")+200)-gettime());
        SendClientMessage(playerid, -1, format_z);
		return 1;
	}

	if(InDuel[playerid] != -1)
		return Error(playerid, "You can't place a bet while dueling!");
	
	if(GetPVarInt(playerid, "betPlayer") != -1)
		return Error(playerid, "You have already made a bet, wait till the duel is over!");
	
	new amount;
	if(sscanf(params, "ui", otherid, amount))
	{
		Usage(playerid, "/bet <ID> <Amount>");
		return true;
	}
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Player not connected!");
	
	if(InDuel[otherid] == -1)
		return Error(playerid, "That player is not in a duel!");
	
	if(otherid == playerid)
		return Error(playerid, "You can't bet on yourself!");
	
	if(CantBet[InDuel[otherid]])
		return Error(playerid, "It's too late to make a bet, you must make a bet in the first 15 seconds!");

	if(pAdmin[playerid] != 5)
	{
		if(!(999 < amount < 75001) && GetLevel(pScore[playerid]) >= 6) return Error(playerid, "Bets must be between $1,000 and $75,000!");
		if(!(999 < amount < 50001) && GetLevel(pScore[playerid]) == 5) return Error(playerid, "Bets must be between $1,000 and $50,000!");
		if(!(999 < amount < 25001) && (GetLevel(pScore[playerid]) >= 2 && GetLevel(pScore[playerid]) <= 4)) return Error(playerid, "Bets must be between $1,000 and $25,000!");
		if(!(999 < amount < 10001) && GetLevel(pScore[playerid]) <= 1) return Error(playerid, "Bets must be between $1,000 and $10,000!");
	}
	if(amount > pCash[playerid]) return Error(playerid, "You don't have enough money to place this bet!");
	GivePlayerCash(playerid, -amount);
	if(DuelType[InDuel[otherid]] == DUEL_TYPE_NORMAL) format(str, sizeof(str), ""RED_E"[BET] "LIME_E"%s(%d) has bet "LG_E"$%s "LIME_E"on %s(%d)!", pName[playerid], playerid, ToCurrency(amount), pName[otherid], otherid);
	else format(str, sizeof(str), ""RED_E"[BET] "LIME_E"%s(%d) has bet "LG_E"$% "LIME_E"on the team of %s(%d) and %s(%d)", pName[playerid], playerid, ToCurrency(amount), pName[otherid], otherid, pName[GetPVarInt(otherid, "duelTeamMate")], GetPVarInt(otherid, "duelTeamMate"));
	SendBetMsg(COLOR_GREY2, str);
	format(str, sizeof(str), "~w~%s(%d) has bet ~g~~h~$%s ~w~on you!", pName[playerid], playerid, ToCurrency(amount));
	InfoTD_MSG(otherid, 4000, str);
	if(GetPVarInt(otherid, "duelTeamMate") != -1) InfoTD_MSG(GetPVarInt(otherid, "duelTeamMate"), 4000, str);
	SetPVarInt(playerid, "betPlayer", otherid);
	SetPVarInt(playerid, "betAmount", amount);
	SetPVarInt(playerid, "bettedDuelID", InDuel[otherid]);
	SetPVarInt(playerid, "lastBetTime", gettime());
	return 1;
}

CMD:duel(playerid, params[])
{
	new tempDuelID;
	if(!pSpawned[playerid])
	{
		Error(playerid, "You cannot use this command while you are dead!");
		return false;
	}
	if(!CanPlayerTeleport(playerid))
		return true;
	
	if(sscanf(params, "u", tempDuelID))
	{
		Usage(playerid, "/duel <ID>");
		return true;
	}
	if(GetPVarInt(tempDuelID, "BadSports"))
		return Error(playerid, "Player is banned from the main game.");
	if(tempDuelID == INVALID_PLAYER_ID)
		return Error(playerid, "Player not connected!");
	if(tempDuelID == playerid)
		return Error(playerid, "You can't duel yourself!");
	if(InDerby[tempDuelID] != 0 || doingStunt[tempDuelID] != 0 || InEvent[tempDuelID] != 0)
		return Error(playerid, "Player is already in another activity.");
	if(pSpawned[tempDuelID] == 0)
		return Error(playerid, "Player is not spawned!");
	if(GetPVarInt(playerid, "duelInvited") == 1)
		return Error(playerid, "You have already invited someone for a duel. Type /cancel to cancel the invite.");

	if(InDuel[tempDuelID] != -1)
		return Error(playerid, "Player is already in a duel!");
	if(pJail[tempDuelID] != 0)
		return Error(playerid, "Player is currently in jail and can't be requested.");
		
	if(duelsOFF[tempDuelID] == 1)
	{
		format(str, sizeof(str), ""RED_E"Server: "GREY_E"%s(%d) duel invitation has been automatically denied.", pName[playerid], playerid);
		SendClientMessage(tempDuelID, COLOR_GREY, str);
		Error(playerid, "This player currently has duel requests disabled, the player needs to /togduel to challenge you.");
		return true;
	}
	if(cAFK[tempDuelID] >= 10 || AFK[tempDuelID] == 1)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in AFK and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(pSpectating[tempDuelID] != -1) return Error(playerid, "Player is currently spectating.");

	if(GetPVarInt(tempDuelID, "duelInvited") == 1)
		return Error(playerid, "That player is currently waiting on another duel.");

	if(InDM[playerid] != 0 || InEvent[playerid] != 0 || ParticipatingWar[playerid] == 1 || RaceParticipant[playerid] != 0)
	{
		Error(playerid, "You can't duel players while in a DM/Race/Event/War!");
		return true;
	}
	if(InDM[tempDuelID] != 0 || InEvent[tempDuelID] != 0 || RaceParticipant[tempDuelID] != 0)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a Race/DM or Event and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(doingStunt[tempDuelID] == 33 || doingStunt[tempDuelID] == 18 || doingStunt[tempDuelID] == 19 || doingStunt[tempDuelID] == 88)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a minigame and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(GetPVarInt(tempDuelID, "ParticipatingHG"))
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a hungergame and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(GetPlayerVirtualWorld(tempDuelID) == SKYDIVE_WORLD)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in skydive and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
	}

	format(tmp, sizeof(tmp), ""WHITEP_E"Duel %s(%d) -> Select Weapon:", pName[tempDuelID], tempDuelID);
	ShowPlayerDialog(playerid, DIALOG_DUEL, DIALOG_STYLE_LIST, tmp,
	""LB2_E"M4, Deagle, MP5, Combat\n"LB2_E"AK, Deagle, TEC-9, Sawn-Off\n"LB2_E"Deagle\n"LB2_E"M4\n"LB2_E"AK-47\n\
	"LB2_E"Sawn Off Shotgun\n"LB2_E"Combat Shotgun\n\n"LB2_E"Regular Shotgun\n"LB2_E"MP5\n"LB2_E"TEC-9\n"LB2_E"Silenced 9mm\n"LB2_E"Sniper Rifle\n\
	"LB2_E"Chainsaw\n"LB2_E"Bats\n"LB2_E"Grenades\n"LB2_E"RPG\n"LB2_E"Deagle/Shotgun/Sniper\n"LB2_E"Spray can\n"LB2_E"Micro SMG", "Duel", "Cancel");

 	SetPVarInt(playerid, "duelInvited", 1);
	SetPVarInt(playerid, "duelPlayer", tempDuelID);
	SetPVarInt(tempDuelID, "duelPlayer", playerid);
	SetPVarInt(tempDuelID, "duelInvited", 1);
	SetTimerEx("DuelCancel", 15*1000, false, "i", playerid);
	return 1;
}

CMD:dduel(playerid, params[])//dduel
{
	new tempDuelID,p2,companion;
	if(!pSpawned[playerid])
	{
		Error(playerid, "You cannot use this command while you are dead!");
		return false;
	}
	if(!CanPlayerTeleport(playerid))
		return true;

	if(sscanf(params, "uuu", companion,p2,tempDuelID))
	{
		Usage(playerid, "/dduel <team member> <player 3> <player 4>");
		return true;
	}
	if(tempDuelID == playerid||tempDuelID==companion||tempDuelID==p2||playerid==companion||playerid==p2||p2==companion) return Error(playerid,"You can't use the same player id more than once!");
	if(tempDuelID == INVALID_PLAYER_ID)//P4
		return Error(playerid, "Player 4 not connected!");
	if(tempDuelID == playerid)
		return Error(playerid, "You can't duel yourself!");
	if(pSpawned[tempDuelID] == 0)
		return Error(playerid, "Player 4 is not spawned!");
	if(GetPVarInt(playerid, "duelInvited") == 1)
		return Error(playerid, "You have already invited someone for a duel. Type /cancel to cancel the invite.");

	if(InDuel[tempDuelID] != -1)
		return Error(playerid, "Player 4 is already in a duel!");
	if(pJail[tempDuelID] != 0)
		return Error(playerid, "Player 4 is currently in jail and can't be requested.");

	if(duelsOFF[tempDuelID] == 1)
	{
		format(str, sizeof(str), ""RED_E"Server: "GREY_E"%s(%d) duel invitation has been automatically denied.", pName[playerid], playerid);
		SendClientMessage(tempDuelID, COLOR_GREY, str);
		Error(playerid, "This player (4) currently has duel requests disabled, the player needs to /togduel to challenge you.");
		return 1;
	}
	if(cAFK[tempDuelID] >= 10 || AFK[tempDuelID] == 1)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in AFK and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(pSpectating[tempDuelID] != -1) return Error(playerid, "Player (4) is currently spectating.");

	if(GetPVarInt(tempDuelID, "duelInvited") == 1)
		return Error(playerid, "That player (4) is currently waiting on another duel.");

	if(InDM[playerid] != 0 || InEvent[playerid] != 0 || ParticipatingWar[playerid] == 1 || RaceParticipant[playerid] != 0)
	{
		Error(playerid, "You can't duel players while in a DM/Race/Event/War!");
		return true;
	}
	if(InDM[tempDuelID] != 0 || InEvent[tempDuelID] != 0 || RaceParticipant[tempDuelID] != 0)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a Race/DM or Event and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(doingStunt[tempDuelID] == 33 || doingStunt[tempDuelID] == 18 || doingStunt[tempDuelID] == 19 || doingStunt[tempDuelID] == 88)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a minigame and can't be requested to duel!", pName[tempDuelID], tempDuelID);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}

    if(p2 == INVALID_PLAYER_ID)//P3
		return Error(playerid, "Player 3 not connected!");
	if(p2 == playerid)
		return Error(playerid, "You can't duel yourself!");
	if(pSpawned[p2] == 0)
		return Error(playerid, "Player 3 is not spawned!");
	if(InDuel[p2] != -1)
		return Error(playerid, "Player 3 is already in a duel!");
	if(pJail[p2] != 0)
		return Error(playerid, "Player 3 is currently in jail and can't be requested.");

	if(duelsOFF[p2] == 1)
	{
		format(str, sizeof(str), ""RED_E"Server: "GREY_E"%s(%d) duel invitation has been automatically denied.", pName[playerid], playerid);
		SendClientMessage(p2, COLOR_GREY, str);
		Error(playerid, "This player(3) currently has duel requests disabled, the player needs to /togduel to challenge you.");
		return 1;
	}
	if(cAFK[p2] >= 10 || AFK[p2] == 1)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in AFK and can't be requested to duel!", pName[p2], p2);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(pSpectating[p2] != -1) return Error(playerid, "Player 3 is currently spectating.");

	if(GetPVarInt(p2, "duelInvited") == 1)
		return Error(playerid, "That player(3) is currently waiting on another duel.");

	if(InDM[p2] != 0 || InEvent[p2] != 0 || RaceParticipant[p2] != 0)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a Race/DM or Event and can't be requested to duel!", pName[p2], p2);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(doingStunt[p2] == 33 || doingStunt[p2] == 18 || doingStunt[p2] == 19 || doingStunt[p2] == 88)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a minigame and can't be requested to duel!", pName[p2], p2);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}

    if(companion == INVALID_PLAYER_ID)//P2
		return Error(playerid, "Player (2) not connected!");
	if(companion == playerid)
		return Error(playerid, "You can't duel yourself!");
	if(pSpawned[companion] == 0)
		return Error(playerid, "Player (2) is not spawned!");
	if(InDuel[companion] != -1)
		return Error(playerid, "Player (2) is already in a duel!");
	if(pJail[companion] != 0)
		return Error(playerid, "Player (2) is currently in jail and can't be requested.");

	if(duelsOFF[companion] == 1)
	{
		format(str, sizeof(str), ""RED_E"Server: "GREY_E"%s(%d) duel invitation has been automatically denied.", pName[playerid], playerid);
		SendClientMessage(companion, COLOR_GREY, str);
		Error(playerid, "This player(2) currently has duel requests disabled, the player needs to /togduel to challenge you.");
		return 1;
	}
	if(cAFK[companion] >= 10 || AFK[companion] == 1)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in AFK and can't be requested to duel!", pName[companion], companion);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(pSpectating[companion] != -1) return Error(playerid, "Player is currently spectating.");

	if(GetPVarInt(companion, "duelInvited") == 1)
		return Error(playerid, "That player(2) is currently waiting on another duel.");

	if(InDM[companion] != 0 || InEvent[companion] != 0 || RaceParticipant[companion] != 0)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a Race/DM or Event and can't be requested to duel!", pName[companion], companion);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}
	if(doingStunt[companion] == 33 || doingStunt[companion] == 18 || doingStunt[companion] == 19 || doingStunt[companion] == 88)
	{
		format(str, sizeof(str), ""Server" "GREY_E"%s(%i) is currently in a minigame and can't be requested to duel!", pName[companion], companion);
		SendClientMessage(playerid, COLOR_GREY, str);
		return true;
	}


	//format(tmp, sizeof(tmp), ""WHITEP_E"Duel %s(%d) -> Select Weapon:", pName[tempDuelID], tempDuelID);
	ShowPlayerDialog(playerid, DIALOG_DUEL+3, DIALOG_STYLE_LIST, "Double Duel",
	""LB2_E"M4, Deagle, MP5, Combat\n"LB2_E"AK, Deagle, TEC-9, Sawn-Off\n"LB2_E"Deagle\n"LB2_E"M4\n"LB2_E"AK-47\n"LB2_E"Sawn Off Shotgun\n"LB2_E"Combat Shotgun\n\n"LB2_E"Regular Shotgun\n"LB2_E"MP5\n"LB2_E"TEC-9\n"LB2_E"Silenced 9mm\n"LB2_E"Sniper Rifle\n"LB2_E"Chainsaw\n"LB2_E"Bats\n"LB2_E"Grenades\n"LB2_E"RPG\n"LB2_E"Deagle/Shotgun/Sniper\n"LB2_E"Spray can", "Duel", "Cancel");

	SetPVarInt(playerid, "duelInvited", 1);
	SetPVarInt(playerid, "duelPlayer", companion);
	SetPVarInt(playerid, "duelPlayer2", p2);
	SetPVarInt(playerid, "duelPlayer3", tempDuelID);

	SetPVarInt(companion, "duelPlayer", playerid);
	SetPVarInt(tempDuelID, "duelPlayer", playerid);
	SetPVarInt(p2, "duelPlayer", playerid);
	
	SetPVarInt(companion, "duelInvited", 1);
	SetPVarInt(p2, "duelInvited", 1);
	SetPVarInt(tempDuelID, "duelInvited", 1);
	return 1;
}

ToggleDuelMapsForPlayer(playerid, duel_map, bool:enabled) 
{
	switch(duel_map) 
	{
		/*case DUEL_MAP_FAST: 
		{
			if(!enabled) 
			{
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[0], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[1], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[2], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[3], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[4], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[5], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[6], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[7], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[8], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[9], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[10], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[11], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[12], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[13], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[14], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[15], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[16], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[17], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[18], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[19], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[20], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[21], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[22], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[23], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[24], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[25], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[26], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[27], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[28], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[29], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[30], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[31], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[32], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[33], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[34], 0);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[35], 0);
			} else {
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[0], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[1], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[2], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[3], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[4], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[5], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[6], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[7], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[8], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[9], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[10], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[11], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[12], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[13], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[14], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[15], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[16], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[17], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[18], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[19], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[20], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[21], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[22], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[23], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[24], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[25], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[26], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[27], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[28], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[29], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[30], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[31], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[32], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[33], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[34], 1);
				Streamer_ToggleItem(playerid, STREAMER_TYPE_OBJECT, Fast_Map[35], 1);
			}
		}*/
			case 99: 
			{
				//random code to get rid of warnings. does nothing.
				if(playerid)
					enabled = ! enabled;
				return 1;
			}
		
	}
	return 1;
}

/*
 		case DUEL_DIALOG+7://dduel
		{
			new otherplayer = GetPVarInt(playerid, "duelPlayer");
		 	new nextplayer = GetPVarInt(otherplayer,"duelPlayer3");
    		new lastplayer = GetPVarInt(otherplayer,"duelPlayer4");
			if(otherplayer == INVALID_PLAYER_ID)
				return Error(playerid, "Player not connected!");
			if(response)
			{
				if(g_DuelInProgress != 0)
				{
				DeletePVar(otherplayer, "duelPlayer4");
				DeletePVar(otherplayer, "duelPlayer3");
				DeletePVar(otherplayer, "duelPlayerC");
    			DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				return Error(playerid, "Another duel is in progress at the moment, wait till that duel is finished!");
				}
				if(GetPVarInt(playerid, "duelPlayer") != otherplayer)
				{
				DeletePVar(otherplayer, "duelPlayer4");
				DeletePVar(otherplayer, "duelPlayer3");
				DeletePVar(otherplayer, "duelPlayerC");
    			DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				return Error(playerid, "Player has already cancelled the duel invite.");
				}
				SetPVarInt(nextplayer,"duelPlayer",playerid);
				SetPVarInt(playerid,"duelInvited",1);
               	format(line, sizeof(line), "%s(%d) and %s(%d) "WHITE_E"want to duel you and %s(%d)!\n\n"dot""WHITE_E"Weapon: "LB2_E"%s\n"dot""WHITE_E"Area: "LB2_E"Cage\n\n"RED_E"€¢ "WHITE_E"Click on accept to confirm to duel, or cancel to deny it.",pName[otherplayer],otherplayer, pName[playerid], playerid, pName[lastplayer],lastplayer,DuelWeapon[otherplayer]);
				ShowPlayerDialog(nextplayer, DUEL_DIALOG+8, DIALOG_STYLE_MSGBOX, ""RED_E"DUEL", line, "Accept", "Cancel");
				format(str, sizeof(str), ""DUEL" %s(%d) has been invited to the teamduel, wait till the player accepts the invitation.", pName[nextplayer], nextplayer);
				SendClientMessage(otherplayer, COLOR_YELLOW, str);
				SendClientMessage(playerid, COLOR_YELLOW, str);
			//	format(line, sizeof(line), "p1: %d p2: %d p3:%d p4: %d",otherplayer,playerid,nextplayer,lastplayer);
			//	SendClientMessageToAll(-1,line);

				//form

				//InitializeDuel(playerid, otherplayer);
			}
			else
			{
				format(str, sizeof(str), ""Server" "GREY_E"%s(%d) has denied your request for a duel.", pName[playerid], playerid);
				SendClientMessage(otherplayer, COLOR_GREY, str);
				DeletePVar(otherplayer, "duelPlayer4");
				DeletePVar(otherplayer, "duelPlayer3");
				DeletePVar(otherplayer, "duelPlayerC");
    			DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");

			}

		}
        case DUEL_DIALOG+8://dduel
		{
			new otherplayer = GetPVarInt(playerid, "duelPlayer");
			new first = GetPVarInt(otherplayer,"duelPlayer");
			new nextplayer = GetPVarInt(first,"duelPlayer4");
			if(otherplayer == INVALID_PLAYER_ID || nextplayer == INVALID_PLAYER_ID)
				return Error(playerid, "Player not connected!");
			if(response)
			{
				if(g_DuelInProgress !=0)
				{
				DeletePVar(first, "duelPlayer4");
				DeletePVar(first, "duelPlayer3");
				DeletePVar(first, "duelPlayerC");
    			DeletePVar(first, "duelPlayer");
				DeletePVar(first, "duelInvited");
                DeletePVar(otherplayer, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				return Error(playerid, "Another duel is in progress at the moment, wait till that duel is finished!");
				}
				if(GetPVarInt(playerid, "duelPlayer") != otherplayer)
				{
				DeletePVar(first, "duelPlayer4");
				DeletePVar(first, "duelPlayer3");
				DeletePVar(first, "duelPlayerC");
    			DeletePVar(first, "duelPlayer");
				DeletePVar(first, "duelInvited");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				return Error(playerid, "Player has already cancelled the duel invite.");
				}
				SetPVarInt(playerid,"duelInvited",1);
                SetPVarInt(nextplayer,"duelPlayer",playerid);
                format(line, sizeof(line), "%s(%d) and %s(%d) "WHITE_E"want to duel you and %s(%d)!\n\n"dot""WHITE_E"Weapon: "LB2_E"%s\n"dot""WHITE_E"Area: "LB2_E"Cage\n\n"RED_E"€¢ "WHITE_E"Click on accept to confirm to duel, or cancel to deny it.",pName[first],first,pName[otherplayer],otherplayer, pName[playerid], playerid, DuelWeapon[first]);
				ShowPlayerDialog(nextplayer, DUEL_DIALOG+9, DIALOG_STYLE_MSGBOX, ""RED_E"DUEL", line, "Accept", "Cancel");
				format(str, sizeof(str), ""DUEL" You have invited %s(%d) to be your duel teammate, wait till the player accepts your invitation.", pName[nextplayer], nextplayer);
				SendClientMessage(playerid, COLOR_YELLOW, str);
			//	format(line, sizeof(line), "p1: %d p2: %d p3:%d p4: %d",first,otherplayer,playerid,nextplayer);
			//	SendClientMessageToAll(-1,line);
				//form

				//InitializeDuel(playerid, otherplayer);
			}
			else
			{
				format(str, sizeof(str), ""Server" "GREY_E"%s(%d) has denied your request for a duel.", pName[playerid], playerid);
				SendClientMessage(otherplayer, COLOR_GREY, str);
				SendClientMessage(first, COLOR_GREY, str);
				DeletePVar(first, "duelPlayer4");
				DeletePVar(first, "duelPlayer3");
				DeletePVar(first, "duelPlayerC");
    			DeletePVar(first, "duelPlayer");
				DeletePVar(first, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");

			}

		}
        case DUEL_DIALOG+9://dduel
		{
			new otherplayer = GetPVarInt(playerid, "duelPlayer");
			new secondp = GetPVarInt(otherplayer,"duelPlayer");
			new first = GetPVarInt(secondp,"duelPlayer");
			if(otherplayer == INVALID_PLAYER_ID)// || nextplayer == INVALID_PLAYER_ID)
				return Error(playerid, "Player not connected!");
			if(response)
			{
				if(g_DuelInProgress !=0)
				{
				DeletePVar(first, "duelPlayer4");
				DeletePVar(first, "duelPlayer3");
				DeletePVar(first, "duelPlayerC");
    			DeletePVar(first, "duelPlayer");
				DeletePVar(first, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(secondp, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(secondp, "duelInvited");
				return Error(playerid, "Another duel is in progress at the moment, wait till that duel is finished!");
				}
				if(GetPVarInt(playerid, "duelPlayer") != otherplayer)
				{
				DeletePVar(first, "duelPlayer4");
				DeletePVar(first, "duelPlayer3");
				DeletePVar(first, "duelPlayerC");
    			DeletePVar(first, "duelPlayer");
				DeletePVar(first, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(secondp, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(secondp, "duelInvited");
				return Error(playerid, "Player has already cancelled the duel invite.");
				}
			//	format(line, sizeof(line), "p1: %d p2: %d p3:%d p4: %d",first,secondp,otherplayer,playerid);
			//	SendClientMessageToAll(-1,line);
                //format(line, sizeof(line), "%s(%d) and %s(%d) "WHITE_E"want to duel you and %s(%d)!\n\n"dot""WHITE_E"Weapon: "LB2_E"%s\n"dot""WHITE_E"Area: "LB2_E"Cage\n\n"RED_E"€¢ "WHITE_E"Click on accept to confirm to duel, or cancel to deny it.",pName[first],first,pName[otherplayer],otherplayer, pName[playerid], playerid, DuelWeapon[otherplayer]);
				//ShowPlayerDialog(nextplayer, DUEL_DIALOG+9, DIALOG_STYLE_MSGBOX, ""RED_E"DUEL", line, "Accept", "Cancel");
				//format(str, sizeof(str), ""DUEL" You have invited %s(%d) to be your duel teammate, wait till the player accepts your invitation.", pName[nextplayer], nextplayer);
				//SendClientMessage(playerid, COLOR_YELLOW, str);
				//form
                //SetPVarInt(playerid,"duelInvited",1);
                //SetPVarInt(nextplayer,"duelPlayer",playerid);
				InitializeDDuel(first, secondp, otherplayer, playerid);
				foreach(new i : Player)
				{
				DeletePVar(i, "duelPlayer4");
				DeletePVar(i, "duelPlayer3");
				DeletePVar(i, "duelPlayerC");
    			DeletePVar(i, "duelPlayer");
				DeletePVar(i, "duelInvited");
				}

			}
			else
			{
				format(str, sizeof(str), ""Server" "GREY_E"%s(%d) has denied your request for a duel.", pName[playerid], playerid);
				SendClientMessage(otherplayer, COLOR_GREY, str);
				SendClientMessage(first, COLOR_GREY, str);
				DeletePVar(first, "duelPlayer4");
				DeletePVar(first, "duelPlayer3");
				DeletePVar(first, "duelPlayerC");
    			DeletePVar(first, "duelPlayer");
				DeletePVar(first, "duelInvited");
				DeletePVar(otherplayer, "duelPlayer");
				DeletePVar(otherplayer, "duelInvited");
				DeletePVar(secondp, "duelPlayer");
				DeletePVar(secondp, "duelInvited");

			}

		}


		case DUEL_DIALOG+3:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: SetPlayerPosition(playerid, 2155.8235,-2245.2771,937.9984,268.7045);
					case 1: SetPlayerPosition(playerid, 2203.0222,-2241.9666,923.9700,92.6368);
				}
				ResetPlayerWeapons(playerid);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("unfreezePlayer", 2200, false, "i", playerid);
				doingStunt[playerid] = 72;
				SetPlayerVirtualWorld(playerid, DUEL_WORLD);
			}
		}
		case DUEL_DIALOG+4:
		{
			if(response)
			{
				new player1 = GetPVarInt(playerid, "duelPlayer");
				new player2 = GetPVarInt(playerid, "duelPlayer2");
				switch(listitem)
				{
					case 0:
					{
						DuelWeapon[player1] = "M4/Deagle/MP5/Combat";
						DuelWeap[player1] = 1;
						DuelWeap[player2] = 1;
					}
					case 1:
					{
						DuelWeapon[player1] = "AK/Deagle/Tec-9/Sawn-Off";
						DuelWeap[player1] = 2;
						DuelWeap[player2] = 2;
					}
					case 2:
					{
						DuelWeapon[player1] = "Deagle";
						DuelWeap[player1] = 3;
						DuelWeap[player2] = 3;
					}
					case 3:
					{
						DuelWeapon[player1] = "M4";
						DuelWeap[player1] = 4;
						DuelWeap[player2] = 4;
					}
					case 4:
					{
						DuelWeapon[player1] = "AK-47";
						DuelWeap[player1] = 5;
						DuelWeap[player2] = 5;
					}
					case 5:
					{
						DuelWeapon[player1] = "Sawn-Off";
						DuelWeap[player1] = 6;
						DuelWeap[player2] = 6;
					}
					case 6:
					{
						DuelWeapon[player1] = "Combat";
						DuelWeap[player1] = 7;
						DuelWeap[player2] = 7;
					}
					case 7:
					{
						DuelWeapon[player1] = "Shotgun";
						DuelWeap[player1] = 8;
						DuelWeap[player2] = 8;
					}
					case 8:
					{
						DuelWeapon[player1] = "MP5";
						DuelWeap[player1] = 9;
						DuelWeap[player2] = 9;
					}
					case 9:
					{
						DuelWeapon[player1] = "TEC-9";
						DuelWeap[player1] = 10;
						DuelWeap[player2] = 10;
					}
					case 10:
					{
						DuelWeapon[player1] = "Silenced 9mm";
						DuelWeap[player1] = 11;
						DuelWeap[player2] = 11;
					}
					case 11:
					{
						DuelWeapon[player1] = "Sniper Rifle";
						DuelWeap[player1] = 12;
						DuelWeap[player2] = 12;
					}
					case 12:
					{
						DuelWeapon[player1] = "Chainsaw";
						DuelWeap[player1] = 13;
						DuelWeap[player2] = 13;
					}
					case 13:
					{
						DuelWeapon[player1] = "Bats";
						DuelWeap[player1] = 14;
						DuelWeap[player2] = 14;
					}
					case 14:
					{
						DuelWeapon[player1] = "Grenades";
						DuelWeap[player1] = 15;
						DuelWeap[player2] = 15;
					}
				}
				if(pHidden[playerid] == 0)
					format(str, sizeof(str), ""RED_E"- AS - "YELLOW_E"%s(%d) has forced a duel between %s(%d) and %s(%d)", pName[playerid], playerid, pName[player1], player1, pName[player2], player2);
				else
					format(str, sizeof(str), ""RED_E"- AS - "YELLOW_E"%s(%d) and %s(%d) has been forced to duel by an Administrator.", pName[player1], player1, pName[player2], player2);
				SendClientMessageToAll(COLOR_RED, str);

				InitializeDuel(player1, player2);
			}

			DeletePVar(playerid, "duelPlayer");
			DeletePVar(playerid, "duelPlayer2");
		}
		
		
		// Duel


forward DuelCancel(playerid);
public DuelCancel(playerid)
{
	new id = GetPVarInt(playerid, "duelPlayer");

	format(str, sizeof(str), ""Server" "GREY_E"Your duel has been cancelled as %s(%i) did not respond to it.", pName[id], id);
	SendClientMessage(playerid, COLOR_GREY, str);

	SetPVarInt(playerid, "duelInvited", 0);
	SetPVarInt(playerid, "duelPlayer", INVALID_PLAYER_ID);
	return true;
}


	
	CMD:specduel(playerid) return cmd_watchduel(playerid);
CMD:watchduel(playerid)
{
	if(!CanPlayerTeleport(playerid)) return true;
	if(pSpawned[playerid] == 0) return Error(playerid, "You can't spectate while not spawned yet!");
	if(g_DuelInProgress == 0) return Error(playerid, "There is no duel going on right now.");
	if(doingStunt[playerid] != 0 && doingStunt[playerid] != 72)
	{
		Error(playerid, "You can't spectate the event here!");
		return true;
	}
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in a DM!");
		return true;
	}

	ShowPlayerDialog(playerid, DUEL_DIALOG+3, DIALOG_STYLE_LIST, "Select Area", ""dot"Spectate from Top\n"dot"Spectate from Bottom", "Select", "Cancel");
	return true;
}


function CloseDuelGate()
{
	// Return gate back to Original pos.
	MoveDynamicObject(Gate[3], 2181.28, -2265.28, 924.07, 3);
	MoveDynamicObject(Gate[4], 2180.94, -2224.84, 924.07, 3);
}


CMD:forceduel(playerid, params[])
{
	if(pAdmin[playerid] < 3)
		return Error(playerid, "You are not authorized to use this command!");

	new player1, player2;
	if(sscanf(params, "uu", player1, player2))
	{
		Usage(playerid, "/forceduel <Player 1> <Player 2>");
		SendClientMessage(playerid, COLOR_YELLOW2, "FUNCTION: Will force a duel between the two players selected");
		return true;
	}

	if(player1 == INVALID_PLAYER_ID)
		return Error(playerid, "Player 1 not connected!");
	if(player2 == INVALID_PLAYER_ID)
		return Error(playerid, "Player 2 not connected!");

	ShowPlayerDialog(playerid, DUEL_DIALOG+4, DIALOG_STYLE_LIST, tmp,
	""LB2_E"M4, Deagle, MP5, Combat\n"LB2_E"AK, Deagle, TEC-9, Sawn-Off\n"LB2_E"Deagle\n"LB2_E"M4\n"LB2_E"AK-47\n"LB2_E"Sawn Off Shotgun\n"LB2_E"Combat Shotgun\n\n"LB2_E"Regular Shotgun\n"LB2_E"MP5\n"LB2_E"TEC-9\n"LB2_E"Silenced 9mm\n"LB2_E"Sniper Rifle\n"LB2_E"Chainsaw\n"LB2_E"Bats\n"LB2_E"Grenades", "Duel", "Cancel");
	SetPVarInt(playerid, "duelPlayer", player1);
	SetPVarInt(playerid, "duelPlayer2", player2);
	return true;
}

*/
