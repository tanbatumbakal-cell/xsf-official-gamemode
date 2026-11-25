// LMS Script

#define DEFAULT_LMS_TIME            (240)
#define LMS_WORLD                   (199)

new LMS_Players,
	LMS_Count,
	LMS_Timer,
	LMS_Started,
	LMS_Active;


	
CMD:lms(playerid)
{
	if(!CanPlayerTeleport(playerid)) return true;
	if(LMS_Players >= 22) return SendClientMessage(playerid, COLOR_WHITEP, ""RED_E"Server: "WHITEP_E"Sorry, the LMS has reached its max players!");
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't join the LMS while in a DM!");
		return true;
	}
	if(doingStunt[playerid] != 0)
	{
		Error(playerid, "You can't join LMS from this area, type /leave.");
		return true;
	}

	if(doingStunt[playerid] == 33) return cmd_exit(playerid);
	if(LMS_Active == 1) return Error(playerid, "LMS has already started!");
	
	SavePlayerPosition(playerid);
	if(LMS_Started == 0)
	{
		LMS_StartGame();
		LMS_Started = 1;
	}
	doingStunt[playerid] = 33;
	InDM[playerid] = 62;
	canUseKey[playerid] = false;
	//JoinMSG(playerid, "the Last Man Standing", "lms");
	UpdateMinigameBox(playerid, 2, "/LMS");
	Info(playerid, "You have joined the Last Man Standing, kill all players to win this minigame!");
	LMS_Players++;
	
	LMS_SetPlayer(playerid);
	return 1;
}

RemoveFromLMS(playerid)
{
	doingStunt[playerid] = 0;
	InDM[playerid] = 0;
	ResetPlayerWeapons(playerid);
	TogglePlayerControllable(playerid, true);
	LoadPlayerPosition(playerid);
	GodModeLabel(playerid, true);
	canUseKey[playerid] = true;
	LMS_Players--;
	GameTextForPlayer(playerid, " ", 2000, 3);
}


LMS_StartGame()
{
	LMS_Count = 20;
	LMS_Timer = SetTimer("LMSCountDown", 1000, true);

	SendClientMessageToAll(COLOR_WHITEP, ""LMS" Last Man Standing has started, type /lms to participate!");
	IRC_GroupSay(ircGroup, IRC_CHANNEL, "2,9LMS3 Last Man Standing has started, type /lms to participate!");
	return 1;
}

LMS_SetPlayer(playerid)
{
	SetPlayerHealth(playerid, 98);
	SetPlayerArmour(playerid, 0.0);
	SetPlayerPosition(playerid, 2734.8899 - random(10), -1768.1736 + random(10), 79.5520, random(360));
	SetPlayerCameraPos(playerid, 2756.913330, -1741.638427, 87.108947);
	SetPlayerCameraLookAt(playerid, 2753.843505, -1745.249755, 85.516685);
	TogglePlayerControllable(playerid, false);
	SetPlayerVirtualWorld(playerid, LMS_WORLD);
	ResetPlayerWeapons(playerid);
	GodModeLabel(playerid, false);
}

LMS_Cancel()
{
	LMS_Players = 0;
	LMS_Active = 0;
	LMS_Count = 0;
	LMS_Started = 0;
	return 1;
}

function LMS_LoseGame()
{
	new players;

	foreach(new ii : Player)
	{
		if(doingStunt[ii] != 33) continue;
		players++;
	}

	if(players == 1 && LMS_Active == 1)
	{
		SetTimer("DecideLMSWinners", 1500, 0);
	}
	else if(players == 0)
	{
		KillTimer(LMS_Timer);

		foreach(new ii : Player)
		{
			if(doingStunt[ii] == 33)
			{
				TogglePlayerControllable(ii, true);
				ResetPlayerWeapons(ii);
				LoadPlayerPosition(ii);
				GodModeLabel(ii, true);
				canUseKey[ii] = true;
				SendClientMessageToAll(COLOR_WHITEP, ""LMS" LMS has been cancelled due to lack of participants!");
				IRC_GroupSay(ircGroup, IRC_CHANNEL, "2,9LMS3 LMS has been cancelled due to lack of participants!");
				doingStunt[ii] = 0;
				InDM[ii] = 0;
			}
		}
		LMS_Cancel();
	}
	return 1;
}

function LMSCountDown()
{
	new player;
	LMS_Count--;

	if(LMS_Count == 0)
	{
		format(str, sizeof(str), "~r~~h~FIGHT!");
	}
	else
	{
		format(str, sizeof(str), "~y~~h~LMS STARTING IN:~n~~r~~h~- %i -~n~~y~~h~SECONDS.", LMS_Count);
	}

	foreach(new ii : Player)
	{
		if(doingStunt[ii] == 33)
		{
			GameTextForPlayer(ii, str, 2000, 3);
		}
	}

	if(LMS_Count <= 0)
	{
		KillTimer(LMS_Timer);
		foreach(new ii : Player)
		{
			if(doingStunt[ii] == 33)
			{
				SetCameraBehindPlayer(ii);
				PlayerPlaySound(ii, 3200, 0, 0, 0);
				switch(random(2))
				{
					case 0:
					{
						GivePlayerWeapon(ii, 31, 1000);
						GivePlayerWeapon(ii, 24, 1000);
						GivePlayerWeapon(ii, 27, 8);
						GivePlayerWeapon(ii, 29, 1000);
					}
					case 1:
					{
						GivePlayerWeapon(ii, 30, 1000);
						GivePlayerWeapon(ii, 23, 1000);
						GivePlayerWeapon(ii, 26, 8);
						GivePlayerWeapon(ii, 28, 1000);
					}
				}
				TogglePlayerControllable(ii, true);
				format(str, sizeof(str), "~w~LMS has started with ~b~~h~~h~%d ~w~players.~n~Eliminate the other players to win the minigame!", LMS_Players);
				InfoTD_MSG(ii, 6000, str);
				player++;
			}
		}

		if(player <= 1)
		{
			LMS_Cancel();

			foreach(new ii : Player)
			{
				if(doingStunt[ii] == 33)
				{
					SendClientMessage(ii, COLOR_WHITEP, ""LMS" LMS has ended due to lack of contenders!");
					ResetPlayerWeapons(ii);
					LoadPlayerPosition(ii);
					doingStunt[ii] = 0;
					InDM[ii] = 0;
					canUseKey[ii] = true;
					GodModeLabel(ii, true);
					InfoTD_MSG(ii, 500, " ");
				}
			}
		}
		else LMS_Active = 1;
	}
	return 1;
}

function DecideLMSWinners()
{
	LMS_Active = 0;

	new winners;

	foreach(new ii : Player)
	{
		if(doingStunt[ii] != 33) continue;

		winners++;
		new cash = (RandomEx(5, 10)*1000);
		new score = RandomEx(2, 5);
		format(str,sizeof(str),""LMS" %s(%i) has won the last man standing minigame! {E8D04C}Prize: $%s and %d score!", pName[ii], ii, ToCurrency(cash), score);
		SendClientMessageToAll(COLOR_WHITEP, str);
		format(tmp, sizeof(tmp), "2,9LMS3 Winner: %i. %s(%d)", winners, pName[ii], ii);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, tmp);
		GameTextForPlayer(ii, "~g~~h~You won!", 3000, 3);
		SendClientMessage(ii, COLOR_WHITEP, ""LMS" You have won the last man standing minigame!");
		format(str,sizeof(str),"~g~~h~~h~You have won the LMS minigame!~n~~w~+~g~$~w~%s~w~ and %d score", ToCurrency(cash), score);
		InfoTD_MSG(ii, 4500, str);
		
			
		ResetPlayerWeapons(ii);
		GivePlayerCash(ii, cash);
		GivePlayerScore(ii, score);
		doingStunt[ii] = 0;
		InDM[ii] = 0;
		GodModeLabel(ii, true);
		canUseKey[ii] = true;
		LoadPlayerPosition(ii);
	}
	LMS_Cancel();
	if(winners == 0) SendClientMessageToAll(COLOR_WHITEP, ""LMS" No winners this round! Start a new game using /lms!");
	return 1;
}

