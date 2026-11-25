// Fallout Script

#define DEFAULT_FALLOUT_TIME            (240)
#define FALLOUT_WORLD                   (5051)

enum e_fallout_data
{
	I_iShaketimer[101],
	I_iNumberout[101],
	I_iObject[101],
	I_iShake[101],
	I_iTimer[2],
	I_iCount,
	I_iJoin,
	I_tLoseGame
}

enum
{
	e_Fallout_Inactive,
	e_Fallout_Startup,
	e_Fallout_Running,
	e_Fallout_Finish,
}

new	fInfo[e_fallout_data],
	g_FalloutStatus,
	CurrentFalloutPlayers = 0;

new FalloutGameTime = DEFAULT_FALLOUT_TIME;
new bool:FalloutLost[MAX_PLAYERS];
	
CMD:fallout(playerid)
{
	if(!CanPlayerTeleport(playerid)) return true;
	if(GetPlayerVirtualWorld(playerid) != 0) return Error(playerid, "You can't use this command outside the main world.");
	if(g_FalloutStatus == e_Fallout_Running) return Error(playerid, "Fallout has already started!");
	if(CurrentFalloutPlayers >= 25) return SendClientMessage(playerid, COLOR_WHITEP, ""RED_E"Server: "WHITEP_E"Sorry, the fallout has reached its max players!");
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't join the fallout while in a DM!");
		return true;
	}
	if(doingStunt[playerid] != 0 && doingStunt[playerid] != 18)
	{
		Error(playerid, "You can't join fallout from this area, type /leave.");
		return true;
	}

	SavePlayerPosition(playerid);
	Fallout_SetPlayer(playerid);
	if(g_FalloutStatus == e_Fallout_Inactive)
	{
		FalloutGameTime = DEFAULT_FALLOUT_TIME;
		Fallout_BuildMap();
		Fallout_StartGame();
		g_FalloutStatus = e_Fallout_Startup;
	}
	ShowPlayerFalloutTextdraws(playerid);
	UpdateMinigameBox(playerid, 2, "/Fallout");
	HidePlayerMSGBox(playerid);
	Info(playerid, "Be the last person standing to win this minigame, Good luck!");
	CurrentFalloutPlayers++;
	UpdateDMText();
	doingStunt[playerid] = 18;
	return 1;
}

RemoveFromFallout(playerid)
{
	doingStunt[playerid] = 0;
	HidePlayerFalloutTextdraws(playerid);
	ShowPlayerMSGBox(playerid);
	TogglePlayerControllable(playerid, true);
	LoadPlayerPosition(playerid);
	CurrentFalloutPlayers--;
	UpdateDMText();
	FalloutLost[playerid] = true;
}

ShowPlayerFalloutTextdraws(playerid)
{
	TextDrawHideForPlayer(playerid, TeleTD);
	TextDrawShowForPlayer(playerid, FalloutTD1);
	TextDrawShowForPlayer(playerid, FalloutTD2);
}

HidePlayerFalloutTextdraws(playerid)
{
	TextDrawShowForPlayer(playerid, TeleTD);
	TextDrawHideForPlayer(playerid, FalloutTD1);
	TextDrawHideForPlayer(playerid, FalloutTD2);
}

Fallout_StartGame()
{
	foreach(new ii : Player)
	{
		FalloutLost[ii] = false;
		if(doingStunt[ii] == 18)
		{
			SetPlayerHealth(ii, 98);
		}
	}

	fInfo[I_iTimer][1] = SetTimer("FalloutCountDown", 1000, true);

	SendClientMessageToAll(COLOR_WHITEP, ""FALLOUT" Fallout minigame has started, type /fallout to participate!");
	IRC_GroupSay(ircGroup, IRC_CHANNEL, "2,9FALLOUT3 Fallout minigame has started, type /fallout to participate!");
	return 1;
}

Fallout_SetPlayer(playerid)
{
	TogglePlayerControllable(playerid, false);
	SetPlayerPosition(playerid, 2441.8523,-1672.8038,168.0097,352.6965);
	SetPlayerCameraPos(playerid, 2492.738037, -1598.145751, 174.717132);
	SetPlayerCameraLookAt(playerid, 2489.733154, -1601.759521, 173.010986);
	Streamer_Update(playerid);
	SetPlayerVirtualWorld(playerid, FALLOUT_WORLD);
	ResetPlayerWeapons(playerid);
}

Fallout_Cancel()
{
	CurrentFalloutPlayers = 0;
	UpdateDMText();
	g_FalloutStatus = e_Fallout_Inactive;
	for(new i = 0; i < 101; i++)
	{
		DestroyObject(fInfo[I_iObject][i]);
		fInfo[I_iNumberout][i] = -1;
		KillTimer(fInfo[I_iShaketimer][i]);
		fInfo[I_iShake][i] = 0;
	}
	KillTimer(fInfo[I_iTimer][0]);
	KillTimer(fInfo[I_iTimer][1]);
	KillTimer(fInfo[I_tLoseGame]);
	return 1;
}

function Fallout_LoseGame()
{
	new players;

	foreach(new ii : Player)
	{
		if(doingStunt[ii] != 18) continue;
		if(FalloutLost[ii]) continue;

		GetPlayerPos(ii, POS[0], POS[1], POS[2]);

		if(POS[2] <= 158.0 && !FalloutLost[ii])
		{
			GameTextForPlayer(ii, "~r~~h~You have been eliminated!", 3000, 3);
			format(str, sizeof(str), ""FALLOUT" %s(%d) has fell off!", pName[ii], ii);
			SendFalloutMessage(COLOR_WHITEP, str);

			FalloutLost[ii] = true;
			CurrentFalloutPlayers--;
			UpdateDMText();
			HidePlayerFalloutTextdraws(ii);
			ShowPlayerMSGBox(ii);
			doingStunt[ii] = 0;
			LoadPlayerPosition(ii);
		}
		else
		{
			players++;
		}
	}

	if(players <= 1 && g_FalloutStatus == e_Fallout_Running)
	{
		g_FalloutStatus = e_Fallout_Finish;
		SetTimer("DecideFalloutWinners", 900, 0);
	}
	else if(players == 0 && g_FalloutStatus == e_Fallout_Running)
	{
		g_FalloutStatus = e_Fallout_Finish;
		SetTimer("DecideFalloutWinners", 900, 0);
	}
	return 1;
}

function FalloutCountDown()
{
	new player;
	fInfo[I_iCount]--;

	if(fInfo[I_iCount] == 0)
	{
	    new count = 0;
		foreach(new ii : Player) if(doingStunt[ii] == 18) count++;

		if(count < 2)
		{
			Fallout_Cancel();
			SendClientMessageToAll(COLOR_WHITEP, ""FALLOUT" Fallout has been cancelled!");
			IRC_GroupSay(ircGroup, IRC_CHANNEL, "2,9FALLOUT3 Fallout has been cancelled!");
			foreach(new ii : Player)
			{
				if(doingStunt[ii] == 18)
				{
					TogglePlayerControllable(ii, true);
					LoadPlayerPosition(ii);
					HidePlayerFalloutTextdraws(ii);
					doingStunt[ii] = 0;
					format(str, sizeof(str), "~r~~h~Fallout cancelled!");
				}
			}
		}
	    else format(str, sizeof(str), "~g~~h~Start!");
		
	}
	else
	{
		format(str, sizeof(str), "~w~FALLOUT STARTING IN:~n~~r~~h~- %i -~n~~w~SECONDS.", fInfo[I_iCount]);
	}

	foreach(new ii : Player)
	{
		if(doingStunt[ii] == 18)
		{
			GameTextForPlayer(ii, str, 2000, 3);
		}
	}

	if(fInfo[I_iCount] <= 0)
	{
		KillTimer(fInfo[I_iTimer][1]);
		foreach(new ii : Player) if(doingStunt[ii] == 18) player++;
		if(player <= 1)
		{
			Fallout_Cancel();
			foreach(new ii : Player)
			{
				if(doingStunt[ii] == 18)
				{
					SendClientMessage(ii, COLOR_WHITEP, ""FALLOUT" Fallout has ended due to lack of contenders!");
					LoadPlayerPosition(ii);
					doingStunt[ii] = 0;
					ShowPlayerMSGBox(ii);
					HidePlayerFalloutTextdraws(ii);
					InfoTD_MSG(ii, 500, " ");
				}
			}
		}
		else
		{
			SetTimer("StartFalling", 2000, 0);
			g_FalloutStatus = e_Fallout_Running;
			format(str, sizeof(str), ""FALLOUT" Fallout has started with %d players!", CurrentFalloutPlayers);
			SendClientMessageToAll(COLOR_WHITEP, str);
			foreach(new ii : Player)
			{
				if(doingStunt[ii] == 18)
				{
					PlayerPlaySound(ii, 3200, 0, 0, 0);
					SetPlayerPos(ii, 2482.1921 - random(39), -1660.4783 + random(47), 161.5000);
					SetPlayerFacingAngle(ii, random(360));
					SetCameraBehindPlayer(ii);
					TogglePlayerControllable(ii, true);
					FalloutLost[ii] = false;
					format(str, sizeof(str), "~w~Fallout has started with ~b~~h~~h~%d ~w~players.~n~Be the last one standing to win the fallout!", CurrentFalloutPlayers);
					InfoTD_MSG(ii, 6000, str);
				}
			}
		}
		
	}
	return 1;
}

function SolarFall()
{
	new objectid, go;
	for(new i = 0; i < 101; i++) if(fInfo[I_iNumberout][i] == -1) go++;

	if(go == 3)
	{
		if(g_FalloutStatus == e_Fallout_Running)
		{
			g_FalloutStatus = e_Fallout_Finish;
			SetTimer("DecideFalloutWinners", 200, 0);
		}
		KillTimer(fInfo[I_iTimer][0]);
		return 1;
	}

	start:
	objectid = random(101);

	if(fInfo[I_iNumberout][objectid] != -1) goto start;

	fInfo[I_iNumberout][objectid] = 0;

	fInfo[I_iShaketimer][objectid] = SetTimerEx("SquareShake", 100, 1, "i", objectid);
	return 1;
}

function StartFalling()
{
	fInfo[I_iTimer][0] = SetTimer("SolarFall", 500, 1);
	fInfo[I_tLoseGame] = SetTimer("Fallout_LoseGame", 500, 1);
	return 1;
}

function DecideFalloutWinners()
{
	g_FalloutStatus = e_Fallout_Inactive;

	new winners;

	foreach(new ii : Player)
	{
		if(doingStunt[ii] != 18) continue;
		if(!FalloutLost[ii])
		{
			winners++;
			if(winners == 1)
			{
				format(str,sizeof(str),""FALLOUT" %s(%i) has won the fallout! {E8D04C}Prize: $5,000, 2 score and 1 cookie!", pName[ii], ii);
			}
			else format(str, sizeof(str), ""FALLOUT" Winners: %i. %s(%d)", winners, pName[ii], ii);
			SendClientMessageToAll(COLOR_WHITEP, str);
			format(tmp, sizeof(tmp), "2,9FALLOUT3 Winner(s): %i. %s(%d)", winners, pName[ii], ii);
			IRC_GroupSay(ircGroup, IRC_CHANNEL, tmp);
			GameTextForPlayer(ii, "~b~~h~You won!", 3000, 3);
			SendClientMessage(ii, COLOR_WHITEP, ""FALLOUT" You have won the fallout minigame!");
			InfoTD_MSG(ii, 4500, "~g~~h~~h~You have won the fallout minigame!~n~~w~+~g~$~w~5000~w~ +2 score and +1 cookie");
			GivePlayerCash(ii, 5000);
			GivePlayerScore(ii, 2);
			GivePlayerCookie(ii, 1);
			doingStunt[ii] = 0;
			LoadPlayerPosition(ii);
			HidePlayerFalloutTextdraws(ii);
			ShowPlayerMSGBox(ii);
			pFallouts[ii]++;
  			
			format(query, sizeof(query), "UPDATE players SET fallouts=fallouts+1 WHERE reg_id=%d", pRegID[ii]);
			MySQL_updateQuery(query);
			if(pGroupID[ii] != -1)
			{
				UpdateGroupScore(pGroupID[ii], 1);
			}
			if(pFallouts[ii] >= 50)
			{
				if(pAch21[ii] == 0)
				{
					pAch21[ii] = 1;
					format(query, sizeof(query), "UPDATE achievements SET a21=1 WHERE reg_id=%d", pRegID[ii]);
					MySQL_updateQuery(query);
					GivePlayerAchievement(ii, "Fallout King", "Congrats you have won 50 fallouts!~n~~y~+$100000 and 5 score!~n~~w~Type /ach to view your achievements.");
				}
			}

		}
	}
	Fallout_Cancel();
	if(winners == 0) SendClientMessageToAll(COLOR_WHITEP, ""FALLOUT" No winners this round! Start a new game using /fallout!");
	return 1;
}

function SquareShake(objectid)
{
	if(objectid == 0)
	{
		return KillTimer(fInfo[I_iShaketimer][objectid]);
	}

	switch(fInfo[I_iShake][objectid])
	{
		case 0, 5:
		{
			SetObjectRot(fInfo[I_iObject][objectid], 31.8, 2, 0);
		}
		case 1, 6:
		{
			SetObjectRot(fInfo[I_iObject][objectid], 33.8, 0, 0);
		}
		case 2, 7:
		{
			SetObjectRot(fInfo[I_iObject][objectid], 31.8, -2, 0);
		}
		case 3, 8:
		{
			SetObjectRot(fInfo[I_iObject][objectid], 29.8, 0, 0);
		}
		case 4, 9:
		{
			SetObjectRot(fInfo[I_iObject][objectid], 31.8, 0, 0);
		}
		case 10:
		{
			new Float:patPOS[3];
			GetObjectPos(fInfo[I_iObject][objectid], patPOS[0], patPOS[1], patPOS[2]);
			MoveObject(fInfo[I_iObject][objectid], patPOS[0], patPOS[1], floatsub(patPOS[2], 100.0), 4);
		}
		case 11..99:
		{
			SetObjectPos(fInfo[I_iObject][objectid], floatsub(31.8, floatsub((fInfo[I_iShake][objectid] * 2), 20)), 0, 0);
		}
		case 100:
		{
			DestroyObject(fInfo[I_iObject][objectid]);
			KillTimer(fInfo[I_iShaketimer][objectid]);
		}
	}

	fInfo[I_iShake][objectid]++;
	return 1;
}

Fallout_BuildMap()
{
	for(new i = 0; i < 101; i++)
	{
		DestroyObject(fInfo[I_iObject][i]);
		fInfo[I_iNumberout][i] = -1;
		KillTimer(fInfo[I_iShaketimer][i]);
		KillTimer(fInfo[I_iTimer][0]);
		fInfo[I_iShake][i] = 0;
	}

	new j;
	fInfo[I_iCount] = 22;
	fInfo[I_iObject][j++] = CreateObject(1697, 2441.96, -1672.08, 166.13,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1660.48, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1655.11, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1649.74, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1644.38, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1639.01, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1633.64, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1628.28, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1622.91, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1617.54, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2482.19, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2477.74, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2473.29, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2468.83, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2464.38, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2459.93, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2455.48, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2451.02, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2446.57, -1612.18, 160.00,   31.80, 0.00, 0.00);
	fInfo[I_iObject][j++] = CreateObject(1697, 2442.12, -1612.18, 160.00,   31.80, 0.00, 0.00);
	return 1;
}
