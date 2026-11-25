/*==============================================================================
							  IRC SYSTEM
===============================================================================
IRC_SetUp()
{
	ircName[0] = IRC_BOT_1_NAME;
	ircName[1] = IRC_BOT_2_NAME;
	ircName[2] = IRC_BOT_3_NAME;
	ircName[3] = IRC_BOT_4_NAME;
	ircName[4] = IRC_BOT_5_NAME;
	SetTimerEx("IRC_ConnectDelay", 2000, 0, "d", 1); // Connect the first bot with a one-second delay
	SetTimerEx("IRC_ConnectDelay", 3000, 0, "d", 2); // Connect the second bot with a two-second delay
	SetTimerEx("IRC_ConnectDelay", 4000, 0, "d", 3); // Connect the third bot with a three-second delay
	SetTimerEx("IRC_ConnectDelay", 5000, 0, "d", 4); // Connect the 4th bot with a four-second delay
	SetTimerEx("IRC_ConnectDelay", 6000, 0, "d", 5); // Connect the 5th bot with a five-second delay

	// Create the IRC groups
	ircGroup = IRC_CreateGroup();
}

forward IRC_ConnectDelay(tempid);
public IRC_ConnectDelay(tempid)
{
	ircBot[tempid - 1] = IRC_Connect(IRC_SERVER, IRC_PORT, ircName[tempid - 1], IRC_REALNAME, IRC_HOSTNAME);
	return 1;
}

IRC_QuitBots()
{
	IRC_Quit(ircBot[0], "Serverserver.com (server restarting)");
	IRC_Quit(ircBot[1], "Serverserver.com (server restarting)");
	IRC_Quit(ircBot[2], "Serverserver.com (server restarting)");
	IRC_Quit(ircBot[3], "Serverserver.com (server restarting)");
	IRC_Quit(ircBot[4], "Serverserver.com (server restarting)");
}

public IRC_OnConnect(botid)
{
	ircBotConnected[botid] = true;
	IRC_JoinChannel(botid, IRC_CHANNEL);
	IRC_JoinChannel(botid, IRC_aCHANNEL, "noadminsallowed");
	printf("IRC_OnConnect(%d): Bot ircBot[%d] has connected.", botid, botid);
	IRC_AddToGroup(ircGroup, botid);
}
public IRC_OnDisconnect(botid)
{
	ircBotConnected[botid] = false;
	IRC_RemoveFromGroup(ircGroup, botid);
}

public IRC_OnJoinChannel(botid, channel[])
{
	printf("IRC_OnJoinChannel(%d): Bot ircBot[%d] has joined %s.", botid, botid, channel);

	ircBotInChannel[botid] = true;
	IRC_SendRaw(botid, IRC_IDENTIFY_RAW);

	if(botid == ircBot[0] && !strcmp(channel, IRC_CHANNEL, true))
	{
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "2Visit our site at 3Serverserver.com!");
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "3Server2,0 is running at samp.Serverserver.com");
		IRC_GroupSay(ircGroup, IRC_aCHANNEL, "2This is the staff only IRC channel.");
		IRC_GroupSay(ircGroup, IRC_aCHANNEL, "3Server2,0 is running at samp.Serverserver.com");
	}
}

public IRC_OnLeaveChannel(botid, channel[], message[])
{
	printf("IRC_OnLeaveChannel(%d): Bot ircBot[%d] has left %s (message: %s).", botid, botid, channel, message);

	if(!strcmp(channel, IRC_CHANNEL, true))
	{
		ircBotInChannel[botid] = false;
	}
}

public IRC_OnUserSay(botid, recipient[], user[], host[], message[])
{
	if(botid == ircBot[0])
	{
		if(!strcmp(user, ircName[0], true) || !strcmp(user, ircName[1], true) || !strcmp(user, ircName[2], true))
			return true;
		if(message[0] == '#' && IRC_IsHalfop(botid, recipient, user))
		{
			new character;
			while(message[++character]) if(message[character] == '%') message[character] = ' ';

			format(str, sizeof(str), "4[Admin Chat]3 %s(IRC): 2%s", user, message[1]);
			IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
			format(str, sizeof(str), "[Admin Chat] "LG_E"%s(IRC): "LB_E"%s", user, message[1]);
			SendAdminMessage(COLOR_RED, str);

		}
		if(message[0] == '*' && message[1] != '*')
		{
			if(!IRC_IsVoice(botid, recipient, user))
			{
				IRC_Notice(botid, user, "4You must have voice(+v) to be able to talk on the IRC channel!");
				return false;
			}
			new character;
			while(message[++character]) if(message[character] == '%') message[character] = ' ';

			if(strfind(message, "/q", true) != -1)
			{
				IRC_GroupSay(ircGroup, IRC_CHANNEL, "4Server:2 You can't use /q on the IRC channel!");
				return false;
			}
			new dotCount, numCount;
			for(new i = 0; i < strlen(message); i++)
			{
				if(message[i] == '.')
				{
					dotCount++;
				}
				else if(message[i] >= '0' && message[i] <= '9')
				{
					numCount++;
				}
			}

			if(dotCount > 2 && numCount > 7)
			{
				if(strfind(message, "213.32.66.20:7777") == -1)
				{
					IRC_GroupSay(ircGroup, IRC_CHANNEL, "4Server:2 You can't post IP's on the IRC channel!");
					return true;
				}
			}

			if(message[1] != ' ')
			{
				format(line, sizeof(line), ""BLUE_E"[IRC] "YELLOW_E"%s: "WHITE_E"%s", user, message[1]);
				format(str, sizeof(str), "0,1%s(IRC):2 %s", user, message[1]);
			}
			else
			{
				format(line, sizeof(line), ""BLUE_E"[IRC] "YELLOW_E"%s: "WHITE_E"%s", user, message[2]);
				format(str, sizeof(str), "0,1%s(IRC):2 %s", user, message[2]);
			}
			SendClientMessageToAll(COLOR_WHITE, line);
			IRC_GroupSay(ircGroup, recipient, str);
		}
	}
	return true;
}

public IRC_OnUserSetChannelMode(botid, channel[], user[], host[], mode[])
{
	if(botid == ircBot[0])
	{
		printf("IRC_OnUserSetChannelMode(%d): %s(%s) changed channel %s mode to %s.", botid, user, host, channel, mode);

		format(str, sizeof(str), ""BLUE_E"[IRC]"WHITE_E" %s set %s channel mode to %s. ("IRC_SERVER")", user, channel, mode);
		SendClientMessageToAll(COLOR_WHITE, str);
	}
	return true;
}

public IRC_OnUserNotice(botid, recipient[], user[], host[], message[])
{
	if(!strcmp(user, IRC_NICKSERV, true))
	{
		if(ircIdentified[botid] == false)
		{
			if(strfind(message, IRC_NOTICE_REGISTER, true) != -1)
			{
				IRC_SendRaw(botid, IRC_IDENTIFY_RAW);
			}
			else if(strfind(message, IRC_NOTICE_PASSWORD_OK, true) != -1)
			{
				ircIdentified[botid] = true;
				return true;
			}
			else if(strfind(message, IRC_NOTICE_NOREGISTER, true) != -1)
			{
				IRC_SendRaw(botid, IRC_REGISTER_RAW);
				IRC_SendRaw(botid, IRC_IDENTIFY_RAW);
			}
		}
	}
	return true;
}

public IRC_OnUserJoinChannel(botid, channel[], user[], host[])
{
	/*if(botid == ircBot[0])
	{
		format(str, sizeof(str), ""BLUE_E"[IRC]"WHITE_E" %s has joined %s. ("IRC_SERVER")", user, channel);
		SendClientMessageToAll(COLOR_WHITE, str);
	}
	return true;*/
}
/*
public IRC_OnUserLeaveChannel(botid, channel[], user[], host[])
{
	/*if(botid == ircBot[0])
	{
		format(str, sizeof(str), ""BLUE_E"[IRC]"WHITE_E" %s has left %s. ("IRC_SERVER")", user, channel);
		SendClientMessageToAll(COLOR_WHITE, str);
	}
	return true;
}

public IRC_OnUserDisconnect(botid, user[], host[], message[])
{
	/*if(botid == ircBot[0])
	{
		format(str, sizeof(str), ""BLUE_E"[IRC]"WHITE_E" %s has disconnected from IRC.", user);
		SendClientMessageToAll(COLOR_WHITE, str);
	}
	return true;
}

public IRC_OnUserNickChange(botid, oldnick[], newnick[], host[])
{
	if(botid == ircBot[0])
	{
		format(str, sizeof(str), ""BLUE_E"[IRC]"WHITE_E" %s has changed nick to %s. ("IRC_CHANNEL" on "IRC_SERVER")", oldnick, newnick);
		SendClientMessageToAll(COLOR_WHITE, str);
	}
	return true;
}

IRCCMD:cmds(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user))
	{
		IRC_Notice(botid, user, "7+ (Voice Commands)1: 2!say !pm !info !players !getid !checkban");
	}
	else
	{
		IRC_Notice(botid, user, "7~ (owner)1: 2!rcon !die !gmx !saveallstats");
		IRC_Notice(botid, user, "7& (sOP)1:   2!botjoin !botpart !botmsg !botnick !reconnectbots");
		IRC_Notice(botid, user, "7@ (OP)1:    2!banip !unbanip !throw !explode !sethealth !setname !setpassword !cc !oban !crash !day !night");
		IRC_Notice(botid, user, "7% (hOP)1:   2!(un)ban !kick !aka !akaip !ann !amsg !(un)mute !(un)freeze !slap !getip !akill !playerinfo !warn");
		IRC_Notice(botid, user, "7% (hOP)1:   2!loadrace !respawnvehicles !startrace !caps !pweaps !spectators !check");
		IRC_Notice(botid, user, "7+ (voice)1: 2!say !pm !info !players !getid !checkban");
	}


	return true;
}
IRCCMD:aka(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: 2!aka <ID/Name>");
		return true;
	}
	if(otherid == INVALID_PLAYER_ID)
		return IRC_GroupSay(ircGroup, channel, "4Player not connected!");
	if(pAdmin[otherid] == 6)
	{
		IRC_GroupSay(ircGroup, channel, "4ERROR: 2You can't AKA the server owner.");
		format(str, 90, "*** "RED_E"%s(IRC) tried to AKA you!", user);
		SendClientMessage(otherid, COLOR_YELLOW, str);
		return 1;
	}
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	format(query, sizeof(query), "SELECT name FROM players WHERE IP='%s'", PlayerIP);
	MySQL_query(query, true, "CheckPlayerIP_IRC", "ss", channel, PlayerIP);
	return true;
}

IRCCMD:setpassword(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;

	new cname[24];
	if(sscanf(params, "s[21]s[20]", cname, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: 2!setpassword <name> <new password>");
		return true;
	}

	format(query, sizeof(query), "SELECT pass FROM players WHERE name='%s'", cname);
	MySQL_query(query, true, "ChangePlayerPassword_IRC", "sss", channel, cname, tmp);
	return true;
}


// SetPassword Callback
function ChangePlayerPassword_IRC(channel[], cPlayer[], newpass[])
{
	if(MySQL_rowCount())
	{
		format(str, sizeof(str), "4Server: 2Password for %s has been set to '%s'", cPlayer, newpass);
		IRC_GroupSay(ircGroup, channel, str);
		format(query, sizeof(query), "UPDATE players SET pass=SHA1('%s') WHERE name='%s'", newpass, cPlayer);
		MySQL_updateQuery(query);
	}
	else
	{
		// Name Exists
		format(str, sizeof(str), "4ERROR: 2The name '%s' doesn't exist in the database!", cPlayer);
		IRC_GroupSay(ircGroup, channel, str);
	}
	return true;
}

IRCCMD:reconnectbots(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOwner(botid, channel, user)) return false;

	format(str, sizeof(str), "4Server: 2%s(IRC) has re-connected all IRC bots.", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"s(IRC) re-connected all IRC bots.", user);
	SendClientMessageToAll(COLOR_RED, str);
	IRC_QuitBots(); //Disconnect Old bots

	// Set the IRC names
	ircName[0] = IRC_BOT_1_NAME;
	ircName[1] = IRC_BOT_2_NAME;
	ircName[2] = IRC_BOT_3_NAME;
	ircName[3] = IRC_BOT_4_NAME;
	ircName[4] = IRC_BOT_5_NAME;
	SetTimerEx("IRC_ConnectDelay", 3000, 0, "d", 1); // Connect the first bot with a one-second delay
	SetTimerEx("IRC_ConnectDelay", 5000, 0, "d", 2); // Connect the second bot with a two-second delay
	SetTimerEx("IRC_ConnectDelay", 7000, 0, "d", 3); // Connect the third bot with a three-second delay
	SetTimerEx("IRC_ConnectDelay", 9000, 0, "d", 4); // Connect the 4th bot with a four-second delay
	SetTimerEx("IRC_ConnectDelay", 11000, 0, "d", 5); // Connect the 5th bot with a five-second delay

	// Create the IRC groups
	ircGroup = IRC_CreateGroup();
	return 1;
}

function CheckPlayerIP_IRC(echochannel[], zplayerIP[])
{
	new rows = MySQL_rowCount();
	if(!rows)
	{
		IRC_GroupSay(ircGroup, echochannel, "4Server:3 No accounts exist with this IP!");
	}
	else
	{
		format(tmp, sizeof(tmp), "4Names matching IP: %s:", zplayerIP);
		IRC_GroupSay(ircGroup, echochannel, tmp);
		for(new i = 0; i != rows; i++)
		{
			// Get the name from the cache and append it
			MySQL_getString(i, 0, str);
			format(line, sizeof(line), "2%s", str);
			IRC_GroupSay(ircGroup, echochannel, line);
		}
	}
	return 1;
}
IRCCMD:akaip(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!akaip <ip>");
		return false;
	}

	format(query, sizeof(query), "SELECT name FROM players WHERE IP='%s'", params);
	MySQL_query(query, true, "CheckPlayerIP2_IRC", "ss", channel, params);
	return true;
}

function CheckPlayerIP2_IRC(echochannel[], zplayerIP[])
{
	new rows = MySQL_rowCount();
	if(!rows)
	{
		IRC_GroupSay(ircGroup, echochannel, "4Server:3 No accounts exist with this IP!");
	}
	else
	{
		format(tmp, sizeof(tmp), "4Names matching IP: %s:", zplayerIP);
		IRC_GroupSay(ircGroup, echochannel, tmp);
		for(new i = 0; i != rows; i++)
		{
			// Get the name from the cache and append it
			MySQL_getString(i, 0, str);
			format(line, sizeof(line), "2%s", str);
			IRC_GroupSay(ircGroup, echochannel, line);
		}
	}
	return 1;
}
IRCCMD:check(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	new count = 0;
	IRC_GroupSay(ircGroup, channel,  "4* Possible hacker's:");
	foreach(new ii : Player)
	{
		if(pAdmin[ii] == 0 && pPremium[ii] == 0 && InDM[ii] == 0 && InEvent[ii] == 0 && GetPVarInt(ii, "PurchasedWeapons") == 0)
		{
			new w = GetPlayerWeapon(ii);
			new Float:armour;
			GetPlayerArmour(ii, armour);
			if (armour > 1 || w==16 || w==18 || w==35 || w==36 || w==37 || w==38 || w==39 || w==44 || w==45)
			{
				format(str, sizeof(str), "3Name: 1%s3, ID: 1%d", pName[ii], ii);
				IRC_GroupSay(ircGroup, channel,  str);
				count++;
			}
		}
	}
	if (count == 0) IRC_GroupSay(ircGroup, channel,  "4HCv4 2found no possible hackers in the server.");
	return 1;
}

IRCCMD:checkban(botid, channel[], user[], host[], params[])
{
	if(sscanf(params, "s[24]", tmp))
	{
		IRC_GroupSay(ircGroup, channel,  "4Usage: 2!checkban <ban name>");
		return true;
	}
	if(strfind(tmp, "%", true) != -1)
		return IRC_GroupSay(ircGroup, channel,  "4Invalid characters in ban name!");

	new dotCount, numCount;
	for(new i = 0; i < strlen(tmp); i++)
	{
		if(tmp[i] == '.')
		{
			dotCount++;
		}
		else if(tmp[i] >= '0' && tmp[i] <= '9')
		{
			numCount++;
		}
	}
	new escaped_tmp[24];
	mysql_real_escape_string(tmp, escaped_tmp);
	if(dotCount > 2 && numCount > 7) // IP
	{
		format(query, sizeof(query), "SELECT user_banner,ban_reason,user_banned,ban_timestamp,ban_time FROM bans WHERE bIP = '%s'", escaped_tmp);
	}
	else format(query, sizeof(query), "SELECT user_banner,ban_reason,user_banned,ban_timestamp,ban_time FROM bans WHERE user_banned = '%s'", escaped_tmp); // Name
	MySQL_query(query, true, "CheckPlayerBanned_IRC", "sis", user, botid, tmp);
	return true;
}

function CheckPlayerBanned_IRC(ircAdmin[], ircpBot, BannedName[])
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), "4Error:3 No player with name or IP '%s' found on the ban list.", BannedName);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	else
	{
		new BannedPlayer[24], Reason[40];
		new dateBanned;
		new banTime[40], banTime_Int;
		MySQL_getString(0, 0, PlayerName);
		MySQL_getString(0, 1, Reason);
		MySQL_getString(0, 2, BannedPlayer);
		dateBanned = MySQL_getInt(0, 3);
		banTime_Int = MySQL_getInt(0, 4);

		if(banTime_Int == 0)
		{
			banTime = "Permanent";
		}
		else
		{
			new tmp_banTime = banTime_Int - gettime();
			if(tmp_banTime > 86400)
			{
				tmp_banTime = tmp_banTime/86400;
				format(banTime, sizeof(banTime), "%d days left.", tmp_banTime);
			}
			else banTime = "Few hours";
		}

		localtime(dateBanned, tmParam);
		strftime(tmp, sizeof(tmp), "%d/%m/%Y", tmParam);

		format(line, sizeof(line), "4Player:3 %s 1|| 4Admin:3 %s 1|| 4Ban Reason:3 %s 1|| 4Ban Date:3 %s 1|| 4Time Left:3 %s", BannedPlayer, PlayerName, Reason, tmp, banTime);
		IRC_Notice(ircpBot, ircAdmin, line);
	}
	return true;
}

IRCCMD:uptime(botid, channel[], user[], host[], params[])
{
	format(str, sizeof(str), "4The server has been online for2 %s.", Uptime());
	IRC_GroupSay(ircGroup, channel,  str);
	return 1;
}
IRCCMD:startmb(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	IRC_GroupSay(ircGroup, channel,  "4Server 2You have started a moneybag hunt!");
	EndMBHunt();
	return 1;
}
IRCCMD:saveallstats(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOwner(botid, channel, user)) return false;
	foreach(new ii : Player)
	{
		SavePlayerStats(ii);
	}
	format(tmp, sizeof(tmp), ""Server" %s(IRC) has manually saved your stats.", user);
	SendClientMessageToAll(COLOR_YELLOW, tmp);
	IRC_GroupSay(ircGroup, channel,  "4* 3All server player stats have been saved!");
	GameTextForAll("~b~~h~Server Restarting~w~!", 6500, 3);
	for(new l; l < 4; l++) SendClientMessageToAll(COLOR_GREY2, "\n");
	SendClientMessageToAll(COLOR_LB, ""RED_E"*** "LB2_E"Server Is Restarting, reconnect if you get disconnected!");
	SendClientMessageToAll(COLOR_LB, ""RED_E"*** "LB2_E"Please re-join the server if you get a ban message upon connection!");
	return true;
}
IRCCMD:gmx(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOwner(botid, channel, user)) return false;
	SetTimer("RestartServer", 1000, true);
	format(str, sizeof(str), "4Server:3 %s(IRC) is restarting the server in 10 seconds!", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	format(str, sizeof(str), ""Server" "GREY2_E"Server restarting in 10 seconds, /savestats to save your data!", user);
	SendClientMessageToAll(COLOR_RED, str);
	return true;
}
IRCCMD:spectators(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	new speccers;
	foreach(new ii : Player)
	{
		if(pAdmin[ii] == 0) continue;
		if(pSpectating[ii] != -1)
		{
			speccers = speccers + 1;
		}
	}

	if(speccers == 0)
		return IRC_GroupSay(ircGroup, channel, "4"Server"3 There aren't any spectators!");

	format(str, sizeof(str), "2Displaying a list of %d admin(s)/VIP(s) spectating:", speccers);
	IRC_GroupSay(ircGroup, channel, str);

	speccers = 0;
	foreach(new ii : Player)
	{
		if(pSpectating[ii] != -1)
		{
			speccers = speccers + 1;
			GetPlayerName(pSpectating[ii], giveplayer, sizeof(giveplayer));
			format(str, sizeof(str), " 2%d. 3%s(%i) spectating %s(%i).", speccers, pName[ii], ii, giveplayer, pSpectating[ii]);
			IRC_GroupSay(ircGroup, channel, str);
		}
	}
	return true;
}
IRCCMD:caps(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!caps <ID>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	if(!GetPVarType(otherid, "Caps"))
	{
		//Disable Caps
		SetPVarInt(otherid, "Caps", 1);
		format(str, sizeof(str), ""Server" "RED_E"Administrator %s(IRC) has disabled your caps in chat.", user);
		SendClientMessage(otherid, COLOR_GREY, str);
		format(str, sizeof(str), "* "GREY2_E"Administrator %s(IRC) has disabled %s(%i) caps in chat.", user, pName[otherid], otherid);
		SendClientMessageToAll(COLOR_RED, str);
		format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has disabled %s(%i) caps in chat.", user, pName[otherid], otherid);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	else
	{
		//Enable Caps
		DeletePVar(otherid, "Caps");
		format(str, sizeof(str), ""Server" "GREY2_E"Administrator %s(IRC) has enabled your caps in chat. Do not constantly use it.", user);
		SendClientMessage(otherid, COLOR_GREY, str);
		format(str, sizeof(str), "4Server: 2%s(%i) has enabled %s(%i) caps in chat.", user, pName[otherid], otherid);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	return true;
}

IRCCMD:pweaps(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if (sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!pweaps <ID>");
		return 1;
	}

	if(otherid == INVALID_PLAYER_ID) return IRC_GroupSay(ircGroup, channel, "4Player not connected!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "Showing a list of %s(%i)'s weapons:", giveplayer, otherid);
	IRC_GroupSay(ircGroup, channel, str);

	line[0] = EOS;
	#define weapons_processed hour
	#define weapons_total minute
	#define weapon_id second
	#define weapon_ammo_raw day
	#define weapon_ammo_str giveplayer

	for(new i = 1; i != 12; i++)
	{
		GetPlayerWeaponData(otherid, i, weapon_id, weapon_ammo_raw);

		if(!weapon_id) continue;

		weapons_processed ++;
		weapons_total ++;

		GetWeaponName(weapon_id, str, 48);

		if(weapon_ammo_raw < 0) weapon_ammo_str = "MAX";
		else valstr(weapon_ammo_str, weapon_ammo_raw);

		format(tmp, sizeof(tmp), ""GREEN_E"%s(%s){FFFFFF}%s", str, weapon_ammo_str, (i != 11 ? (", ") : ("")));
		strcat(line, tmp);

		if(weapons_processed == 4)
		{
			IRC_GroupSay(ircGroup, channel, line);
			weapons_processed = 0, line[0] = EOS;
		}
	}

	if(weapons_total == 0)
	{
		IRC_GroupSay(ircGroup, channel, "4This player has no weapons!");
	}
	else if(1 <= weapons_processed <= 4)
	{
		IRC_GroupSay(ircGroup, channel, line);
	}

	#undef weapons_total
	#undef weapons_processed
	#undef weapon_id
	#undef weapon_ammo_raw
	#undef weapon_ammo_str
	return true;
}
IRCCMD:getid(botid, channel[], user[], host[], params[])
{
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!getid <part of name>");
		return true;
	}

	if(!(2 <= strlen(params) <= 15))
	{
		IRC_GroupSay(ircGroup, channel, "4Error: 2Name length invalid");
		return true;
	}

	format(str, sizeof(str), "2Searching for 4'%s' 2in names...", params);
	IRC_GroupSay(ircGroup, channel, str);
	new found;
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);
		new namelen = strlen(PlayerName);
		new bool:searched=false;
		for(new pos=0; pos <= namelen; pos++)
		{
			if(searched != true)
			{
				if(strfind(PlayerName, params, true) == pos)
				{
					found ++;
					format(str,sizeof(str),"7%d. 2%s 4(ID: %d)", found, PlayerName, ii);
					IRC_GroupSay(ircGroup, channel, str);
					searched = true;
				}
			}
		}
	}
	if(found == 0) IRC_GroupSay(ircGroup, channel, "2No players found matching that name!");
	return true;
}

IRCCMD:a(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!a <message>");
		return false;
	}
	format(line, sizeof(line), "4[Admin Chat]3 %s(IRC):2 %s", user, params);
	IRC_GroupSay(ircGroup, IRC_aCHANNEL, line);
	format(line, sizeof(line), ""RED_E"[Admin Chat] "LG_E"%s(IRC): "LB_E"%s", user, params);
	SendAdminMessage(COLOR_LB, line);

	return true;
}


IRCCMD:h(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!a <message>");
		return false;
	}
	format(str, sizeof(str), "2[Helper Chat]3 %s(IRC):2 %s", user, params);
	IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	format(str, sizeof(str), ""SBLUE_E"[Helper Chat] "WHITEP_E"%s(IRC): "LB_E"%s", user, params);
	foreach(new ii : Player) if(pAdmin[ii] > 0 || Helper[ii] == 1) SendClientMessage(ii, COLOR_LB, str);

	return true;
}

IRCCMD:loadrace(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	if(RaceActive == 1)
	{
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "4Server: 2ERROR: A race is already active");
		return true;
	}

	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "4USAGE: 2!loadrace <racename>");
		return true;
	}

	if(!LoadRace(params))
	{
		format(str, sizeof(str), "4Server: 2Race %s is invalid!", params);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		return true;
	}

	format(str, sizeof(str), "4Server: 2Race %s is starting..", params);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	RaceActive = 1;
	SetTimer("startrace", 1000, false);
	return true;
}

IRCCMD:startrace(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	if(LCurrentCheckpoint == 0)
	{
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "4Server: 2ERROR: No race loaded, use !loadrace.");
		return true;
	}

	if(RaceActive == 1)
	{
		if(RaceStart == 1)
		{
			format(str, sizeof(str), "4Server: 2Race %s is already active!", CRaceName);
			IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		}
		else
		{
			format(str, sizeof(str), ""ORANGE_E"* Administrator"YELLOW_E" %s(IRC) "ORANGE_E"has started the race "LB_E"'%s'!", user, CRaceName);
			SendClientMessageToAll(COLOR_GREY, str);
			format(str, sizeof(str), "4Server: 2Administrator %s has started the race '%s'", user, CRaceName);
			IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
			mscd = 6;
		}
	}
	return 1;
}
IRCCMD:endrace(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(RaceActive== 0)
	{
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "4ERROR: No race active!");
		return 1;
	}
	if(cd > 0)
	{
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "4ERROR: Main countdown in progress, can't end race now!");
		return 1;
	}
	format(str, sizeof(str), ""ORANGE_E"* Administrator"YELLOW_E" %s(IRC) "ORANGE_E"has ended the race.", user);
	SendClientMessageToAll(COLOR_GREY, str);
	format(str, sizeof(str), "4Administrator5 %s(IRC) has ended the race.", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	endrace();
	return 1;
}
IRCCMD:day(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;

	SetWorldTime(12);
	format(str, sizeof(str), ""LB_E"Administrator "YELLOW_E"%s(IRC) "LB_E"has changed the time to day.", user);
	SendClientMessageToAll(COLOR_GREY, str);
	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has changed the time to day.", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	return true;
}

IRCCMD:night(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;

	SetWorldTime(2);
	format(str, sizeof(str), ""LB_E"Administrator "YELLOW_E"%s(IRC) "LB_E"has changed the time to night.", user);
	SendClientMessageToAll(COLOR_GREY, str);
	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has changed the time to night.", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	return true;
}

IRCCMD:respawnvehicles(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	for(new itt=0; itt<MAX_VEHICLES; itt++)
	{
		new vehs;
		foreach(new ii : Player)
		{
			if(GetPlayerVehicleID(ii) == itt || PlayerVehicle[ii][0] == itt || PlayerVehicle[ii][1] == itt)
			{
				vehs = 1;
			}
		}
		if(!vehs)
		{
			SetVehicleToRespawn(itt);
		}
		vehs = 0;
	}
    foreach(new ii : Player)
	{
		if(!IsPlayerInAnyVehicle(ii))
		{
			if(!IsPlayerInAnyVehicle(ii))
			{
				RemoveComponents(ii, true);
				DestroyVehicle(pSpawnVehicle[ii]);
				pSpawnVehicle[ii] = -1;
			}
		}
	}
	format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"Administrator %s(IRC) has respawned all unoccupied vehicles.", user);
	SendClientMessageToAll(COLOR_RED, str);
	format(tmp, sizeof(tmp), "4Server: 2Administrator %s(IRC) has respawned all unoccupied vehicles.", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, tmp), IRC_GroupSay(ircGroup, IRC_aCHANNEL, tmp);
	return true;
}

IRCCMD:cc(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	for(new ii = 0; ii < 100; ii++)
	{
		SendClientMessageToAll(COLOR_SYSTEM, " ");
		GameTextForAll("~p~Chat cleared!", 1000, 1);
	}
	format(str, sizeof(str), "Administrator %s(IRC) has cleared the chat!", user);
	SendClientMessageToAll(COLOR_GREY, str);
	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) cleared the chat", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	return true;
}

IRCCMD:players(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsVoice(botid, channel, user)) return false;

	new charsPerLine = 0;
	new playersOnline = 0;
	line[0] = EOS;

	foreach(new ii : Player)
	{
		playersOnline ++;
		GetPlayerName(ii, PlayerName, sizeof(PlayerName));

		format(tmp, sizeof(tmp), "%d.6 %s(%i)1 ", playersOnline, PlayerName, ii);
		charsPerLine += strlen(tmp);
		if(charsPerLine >= 420)
		{
			// Send the currently formatted IRC line and empty it!
			IRC_GroupSay(ircGroup, channel, line);
			charsPerLine = 0;
			line[0] = EOS;
		}
		strcat(line, tmp);
	}
	// If we still have something in the message buffer, send it
	if(charsPerLine != 0)
	{
		IRC_GroupSay(ircGroup, channel, line);
	}
	if(playersOnline == 0) return IRC_GroupSay(ircGroup, IRC_CHANNEL, "3There aren't any players online!");

	if(playersOnline == 1)
	{
		format(str, sizeof(str), "3There is 1 player online.");
	}
	else format(str, sizeof(str), "3There are %d players online.", playersOnline);
	IRC_GroupSay(ircGroup, channel, str);
	return true;
}

IRCCMD:admins(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsVoice(botid, channel, user)) return false;
	new count;
	foreach(new ii : Player)
	{
		if(pAdmin[ii] > 0)
		{
			count = count + 1;
		}
	}

	if(count == 0)
	{
		IRC_GroupSay(ircGroup, IRC_CHANNEL, "4Server:3 There are no administrators online!");
		IRC_GroupSay(ircGroup, IRC_aCHANNEL, "4Server:3 There are no administrators online!");
		return true;
	}

	if(count == 1)
	{
		format(str, sizeof(str), "4Server:3 Displaying the one admin online:");
	}
	else
	{
		format(str, sizeof(str), "4Server:3 Displaying the list of %d admins online:", count);
	}
	IRC_GroupSay(ircGroup, channel, str);

	foreach(new ii : Player)
	{
		if(pAdmin[ii] > 0)
		{
			switch(pAdmin[ii])
			{
				case 0:tmp = "Regular Player";
				case 1..3: tmp = "Admin";
				case 4: tmp = "Lead Admin";
				case 5: tmp = "Manager";
				case 6: tmp = "Owner";
			}
			GetPlayerName(ii, PlayerName, sizeof(PlayerName));
			if(cAFK[ii] > 20)
			{
				format(str, sizeof(str), "5%s 2(ID: %i) (%s) 1(AFK)", PlayerName, ii, tmp);
			}
			else format(str, sizeof(str), "5%s 2(ID: %i) (%s)", PlayerName, ii, tmp);
			IRC_GroupSay(ircGroup, channel, str);
		}
	}

	return true;
}


IRCCMD:setname(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;

	if(sscanf(params, "is[20]", otherid, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!setname <ID/Name> <newname>");
		return false;
	}
	if(pLogged[otherid] == false)
		return IRC_GroupSay(ircGroup, channel, "4Server:3 Player not logged in!");

	if(!IsPlayerConnected(otherid))
	{
		format(str, sizeof(str), "4Server:3 Invalid PlayerID (%d)", otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}
	if(strlen(tmp) > 20)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 New name can't be longer than 20 characters!");
		return true;
	}
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	if(!IsValidPassword(tmp))
	{
		format(str, sizeof(str), "4Server:3 %s(%i)'s name has not been changed to \"%s\". Please doublecheck the name!", giveplayer, otherid, tmp);
		IRC_GroupSay(ircGroup, channel, str);
		return true;
	}

	format(query, sizeof(query), "SELECT name FROM players WHERE name='%s'", tmp);
	MySQL_query(query, true, "ChangePlayerName_IRC", "iss", otherid, user, tmp);
	return true;
}
forward ChangePlayerName_IRC(otherplayer, ircAdmin[], nname[]);
public ChangePlayerName_IRC(otherplayer, ircAdmin[], nname[])
{
	if(!MySQL_rowCount())
	{
		//Good
		new oldname[24], newname[24];
		GetPlayerName(otherplayer, oldname, sizeof(oldname));
		format(query, sizeof(query), "UPDATE players SET name='%s' WHERE reg_id=%d", nname, pRegID[otherplayer]);
		MySQL_updateQuery(query);
		format(str, sizeof(str), ""Server" "LB2_E"%s(IRC) has changed your name to '%s'", ircAdmin, nname);
		SendClientMessage(otherplayer, COLOR_LB, str);
		Info(otherplayer, "Make sure you log in with this new name on every connect!");
		format(str, sizeof(str), "4Server:3 %s(IRC) has changed %s's name to '%s'", ircAdmin, oldname, nname);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		SetPlayerName(otherplayer, nname);
		GetPlayerName(otherplayer, newname, sizeof(newname));
		pName[otherplayer] = newname;
		// Private Vehicle
		if(BoughtVehicle[otherplayer][0] == true)
		{
			format(query, sizeof(query), "UPDATE vehicles SET Owner='%s' WHERE Owner='%s' AND VehicleCount = 1", newname, oldname);
			MySQL_updateQuery(query);
		}
		if(BoughtVehicle[otherplayer][1] == true)
		{
			format(query, sizeof(query), "UPDATE vehicles SET Owner='%s' WHERE Owner='%s' AND VehicleCount = 2", newname, oldname);
			MySQL_updateQuery(query);
		}
		// House
		foreach(new h : Houses)
		{
			if(!strcmp(hInfo[h][HouseOwner], oldname, CASE_SENSETIVE))
			{
				// Has House
				format(hInfo[h][HouseOwner], MAX_PLAYER_NAME, "%s", newname);
				format(query, sizeof(query), "UPDATE houses SET howner='%s' WHERE house_id=%d", newname, hInfo[h][HouseID]);
				MySQL_updateQuery(query);
				UpdateHouseText(h);
			}
		}
		if(PurchasedToy[otherplayer] == true)
		{
			format(query, sizeof(query), "UPDATE toys SET Name='%s' WHERE Name='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}
		// Update group founder
		if(pGroupRank[otherplayer] == 6)
		{
			format(query, sizeof(query), "UPDATE groups SET gFounder='%s' WHERE gFounder='%s'", newname, oldname);
			MySQL_updateQuery(query);
		}
		format(query, sizeof(query), "UPDATE racetimes SET holder='%s' WHERE holder='%s'", newname, oldname);
		MySQL_updateQuery(query);
	}
	else
	{
		// Name Exists
		format(str, sizeof(str), "4ERROR:3 The name '%s' already exists in the database, please use a different name!", nname);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	return true;
}

IRCCMD:crash(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!crash <ID/Name>");
		return true;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	SetPVarInt(otherid, "pBugged", 1);
	new IP[24];
	GetPlayerIp(otherid, IP,sizeof(IP));
	format(IP,sizeof(IP), "banip %s", IP);
	SendRconCommand(IP);

	format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"Administrator %s(IRC) has crashed %s(%i)", user, giveplayer, otherid);
	SendClientMessageToAll(COLOR_RED, str);

	format(str, sizeof(str), "4Server:3 Administrator %s(IRC) has crashed %s(%i)", user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	return true;
}

IRCCMD:slap(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!slap <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
		return IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 10);
	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) slapped %s(%i).", user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);


	return true;
}

IRCCMD:takemoney(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;
	new money;
	if(sscanf(params, "ud", otherid, money))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!takemoney <ID/Name> <amount>");
		return false;
	}
	if(otherid == INVALID_PLAYER_ID)
		return IRC_GroupSay(ircGroup, channel, "4Error:3 Player not connected!");

	if(money > pCash[otherid])
		return IRC_GroupSay(ircGroup, channel, "4Error:3 Player does not have enough to deduct from!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GivePlayerCash(otherid, -money);
	format(str, sizeof(str), ""Server" "RED_E"Administrator %s(IRC) has taken "GREEN_E"$%d "RED_E"from you.", user, money);
	SendClientMessage(otherid, COLOR_RED, str);
	format(str, sizeof(str), "4Server:3Administrator %s(IRC) has taken $%d from %s(%i) ", user, money, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	return true;
}

IRCCMD:throw(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!throw <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 40);

	format(str, sizeof(str), ""Server" %s(IRC) has thrown %s(%i).", user, giveplayer, otherid);
	SendClientMessageToAll(COLOR_GREY, str);
	format(str, sizeof(str), "4Server:3 %s(IRC) has thrown %s(%i).", user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	return true;
}

IRCCMD:msg(botid, channel[], user[], host[], params[])
{
	irccmd_say(botid, channel, user, host, params);
	return true;
}
IRCCMD:say(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsVoice(botid, channel, user))
	{
		IRC_Notice(botid, user, "4You must have voice(+v) to be able to talk on the IRC channel!");
		return false;
	}
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!say <message>");
		return false;
	}

	new character;
	while(params[++character]) if(params[character] == '%') params[character] = ' ';

	format(line, sizeof(line), ""BLUE_E"[IRC] "YELLOW_E"%s: "WHITE_E"%s", user, params);
	SendClientMessageToAll(COLOR_WHITE, line);

	format(line, sizeof(line), "0,1%s(IRC):2 %s", user, params);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, line), IRC_GroupSay(ircGroup, IRC_aCHANNEL, line);

	return true;
}

IRCCMD:rcon(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOwner(botid, channel, user)) return false;
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!rcon <RCON command>");
		return false;
	}

	if(strcmp(params, "login", true) == 0)
	{
		IRC_GroupSay(ircGroup, channel, "7Server: 2RCON doesn't require logging in from IRC!");
		return false;
	}

	format(str, sizeof(str), "4Server:3 %s(IRC) sent RCON CMD: %s", user, params);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), ""Server" %s(IRC) sent RCON CMD: %s", user, params);
	SendClientMessageToAll(COLOR_GREY, str);

	SendRconCommand(params);
	return true;
}

IRCCMD:makeadmin(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOwner(botid, channel, user)) return false;
	new alevel;
	if(sscanf(params, "ud", otherid, alevel))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!makeadmin <ID> <Admin Level>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
		return IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
	if(alevel > 5)
		return IRC_GroupSay(ircGroup, channel, "4Server: 2Level can't be higher than 5!");
	if(alevel < 0)
		return IRC_GroupSay(ircGroup, channel, "4Server: 2Level can't be lower than 0!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	if(pLogged[otherid] == false)
	{
		format(str, sizeof(str), "4Server: 2Player %s(%i) isn't logged in!", giveplayer, otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return true;
	}

	new levelstr[12];
	levelstr = (alevel > pAdmin[otherid]) ? ("promoted") : ("demoted");


	switch(alevel)
	{
		case 0:
		{
			tmp = "Regular Player";
			pHidden[otherid] = 0;
			format(query, sizeof(query), "UPDATE players SET hidden=0 WHERE reg_id=%d", pRegID[otherid]);
			MySQL_updateQuery(query);
			if(admin3D[otherid] != Text3D:-1) DestroyDynamic3DTextLabel(admin3D[otherid]);
		}
		case 1: tmp = "Junior Admin";
		case 2: tmp = "Admin";
		case 3: tmp = "Senior Admin";
		case 4: tmp = "Lead Admin";
		case 5: tmp = "Manager";
		case 6: tmp = "Owner";
	}

	format(query, sizeof(query), "UPDATE players SET adminlevel=%d WHERE reg_id=%d", alevel, pRegID[otherid]);
	MySQL_updateQuery(query);

	pAdmin[otherid] = alevel;
	SendClientMessageToAll(COLOR_LB, " ");
	format(str, sizeof(str), ""YELLOW_E"- AS - "SBLUE_E"Manager %s has %s %s(%i) to %s.", user, levelstr, giveplayer, otherid, tmp);
	SendClientMessageToAll(COLOR_SBLUE, str);
	SendClientMessageToAll(COLOR_LB, " ");
	format(str, sizeof(str), "4Server: 2Manager %s(IRC) has %s %s(%i) to %s.", user, levelstr, giveplayer, otherid, tmp);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	format(str, sizeof(str), "~y~~h~You have been %s to %s!", levelstr, tmp);
	InfoTD_MSG(otherid, 5000, str);
	return true;
}
IRCCMD:die(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOwner(botid, channel, user)) return false;

	format(str, sizeof(str), "4Server:3 %s(IRC) has disconnected the IRC echo bots.", user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), ""Server" %s(IRC) has disconnected the IRC echo bots.", user);
	SendClientMessageToAll(COLOR_GREY, str);

	IRC_Quit(ircBot[0], "" "Serverserver.com (!die)");
	IRC_Quit(ircBot[1], "" "Serverserver.com (!die)");
	IRC_Quit(ircBot[2], "" "Serverserver.com (!die)");
	IRC_Quit(ircBot[3], "" "Serverserver.com (!die)");
	IRC_Quit(ircBot[4], "" "Serverserver.com (!die)");
	return true;
}

IRCCMD:botjoin(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsAdmin(botid, channel, user)) return false;
	if(sscanf(params, "ds[20]", botid, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!botjoin <bot ID> <channel>");
		return false;
	}

	if(botid < 1 || botid > 3)
	{
		IRC_GroupSay(ircGroup, channel, "4Error: 2Bot IDs go from 1 to 3!");
		return true;
	}

	IRC_JoinChannel(ircBot[botid - 1], tmp);

	format(str, sizeof(str), "4Server:3 BOT %s(%d) joining \"%s\" (commanded by %s)", ircName[botid], botid, tmp, user);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	return true;
}

IRCCMD:botmsg(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsAdmin(botid, channel, user)) return false;
	if(sscanf(params, "ds[32]s[256]", botid, str, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!botmsg <bot ID> <channel> <message>");
		return false;
	}

	if(botid < 1 || botid > 3)
	{
		IRC_GroupSay(ircGroup, channel, "4Error: 2Bot IDs go from 1 to 3!");
		return true;
	}

	format(str, sizeof(str), "NOTICE %s :BOT %s(%d) -> \"%s\": %s", user, ircName[botid], botid, str, tmp);
	IRC_SendRaw(ircBot[botid - 1], str);

	return true;
}

IRCCMD:asay(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(!strlen(params))
		return IRC_GroupSay(ircGroup, channel, "4Usage: !asay <message>");

	new character;
	while(params[++character]) if(params[character] == '%') params[character] = ' ';

	format(str, sizeof(str), ""RED_E"* "YELLOW_E"Administrator %s on IRC: "WHITEP_E"%s", user, params);
	SendClientMessageToAll(COLOR_RED, str);

	format(str, sizeof(str), "2Server3 IRC Admin (%s): 4%s", user, params);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	return true;
}

IRCCMD:ban(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "us[128]", otherid, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!ban <ID/Name> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "4Server3 Invalid PlayerID (%d)", otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}
	if(GetPVarInt(otherid, "pRemoved")) return true;
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	gettime(hour, minute, second);
	getdate(year, month, day);

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";
	// New shortcuts.
	else if(!strcmp(tmp, "rf", true)) tmp = "Rapid Fire";
	else if(!strcmp(tmp, "bf", true)) tmp = "BulletProof";
	else if(!strcmp(tmp, "tp", true)) tmp = "Teleport Hack";
	else if(!strcmp(tmp, "vh", true)) tmp = "Vehicle Hacks";
	
	format(str, sizeof(str), "- AS - "RED_E"Administrator %s(IRC) has banned %s(%i) "GREY2_E"[Reason: %s]", user, giveplayer, otherid, tmp);
	SendClientMessageToAll(COLOR_YELLOW, str);
	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) banned %s(%i) [Reason: %s]", user, giveplayer, otherid, tmp);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	for(new ii = 0; ii < 10; ii++)
	{
		SendClientMessage(otherid, COLOR_SYSTEM, " ");
	}

	SendClientMessage(otherid, COLOR_RED, "YOU HAVE BEEN BANNED!");
	format(str, sizeof(str), "Admin: %s(IRC)", user);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "Reason: %s", tmp);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "The time is %02d/%02d/%d %02d:%02d", day, month, year, hour, minute);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "Go to Serverserver.com/forums to appeal your ban. Include a screenshot of your ban.");
	SendClientMessage(otherid, COLOR_GREY2, str);
	SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	SetPVarInt(otherid, "pRemoved", 1);
	format(query, sizeof(query), "INSERT INTO bans(user_banned, bIP, user_banner, ban_reason, ban_timestamp, ban_time) VALUES ('%s', '%s', '%s(IRC)', '%s', UNIX_TIMESTAMP(), 0)", giveplayer, PlayerIP, user, tmp);
	MySQL_updateQuery(query);
	GameTextForPlayer(otherid, "~r~~h~Banned!", 4000, 5);
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	KickEx(otherid);
	return true;
}

IRCCMD:tempban(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	new ban_time;
	if(sscanf(params, "uds[128]", otherid, datez, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!tempban <ID/Name> <time(in days)> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "4Server3 Invalid PlayerID (%d)", otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	gettime(hour, minute, second);
	getdate(year, month, day);

	if(!strcmp(tmp, "ab", true)) tmp = "Airbreak";
	else if(!strcmp(tmp, "ad", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "ads", true)) tmp = "Advertising";
	else if(!strcmp(tmp, "hh", true)) tmp = "Health Hacks";
	else if(!strcmp(tmp, "wh", true)) tmp = "Weapon Hacks";
	else if(!strcmp(tmp, "sh", true)) tmp = "Speed Hacks";
	else if(!strcmp(tmp, "mh", true)) tmp = "Money Hacks";
	else if(!strcmp(tmp, "rh", true)) tmp = "Ram Hacks";
	else if(!strcmp(tmp, "ah", true)) tmp = "Ammo Hacks";

	format(str, sizeof(str), "* Administrator %s(IRC) has temp-banned %s(%i) for %d days. "GREY2_E"[Reason: %s]", user, giveplayer, otherid, datez, tmp);
	SendClientMessageToAll(COLOR_RED, str);
	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) temp-banned %s(%i) for %d days. [Reason: %s]", user, giveplayer, otherid, datez, tmp);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	for(new ii = 0; ii < 10; ii++)
	{
		SendClientMessage(otherid, COLOR_SYSTEM, " ");
	}

	SendClientMessage(otherid, COLOR_RED, "YOU HAVE BEEN BANNED!");
	format(str, sizeof(str), "Admin: %s(IRC)", user);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "Reason: %s", tmp);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "The time is %02d/%02d/%d %02d:%02d", day, month, year, hour, minute);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "Go to Serverserver.com/forums to appeal your ban. Include a screenshot of your ban.");
	SendClientMessage(otherid, COLOR_GREY2, str);
	if(datez != 0)
	{
		format(str, sizeof(str), ""RED_E"Server: "GREY2_E"This is a "RED_E"TEMP-BAN "GREY2_E"that will last for %d days.", datez);
		SendClientMessage(otherid, COLOR_GREY2, str);
	}
	ban_time = gettime() + (datez * 86400);
	SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);

	format(query, sizeof(query), "INSERT INTO bans(user_banned, bIP, user_banner, ban_reason, ban_timestamp, ban_time) VALUES ('%s', '%s', '%s(IRC)', '%s', UNIX_TIMESTAMP(), %d)", giveplayer, PlayerIP, user, tmp, ban_time);
	MySQL_updateQuery(query);
	GameTextForPlayer(otherid, "~r~~h~Temp-Banned!", 4000, 5);
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	KickEx(otherid);
	return true;
}

IRCCMD:oban(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	new player[24];
	if(sscanf(params, "s[24]D(0)s[50]", player, datez, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!oban <account name> <time in days (0 for permanent ban)> <reason> ");
		return true;
	}
	if(strlen(tmp) > 50) return IRC_GroupSay(ircGroup, channel, "4Reason must be under 50 characters.");
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(strfind(PlayerName, player, true) != -1)
		{
			IRC_GroupSay(ircGroup, channel, "4Player is online, you can use /ban on them.");
			return true;
		}
	}
	new escaped_player[24];
	mysql_real_escape_string(player, escaped_player);
	format(query, sizeof(query), "SELECT ip FROM players WHERE name='%s'", escaped_player);
	MySQL_query(query, true, "OnIRCBanData", "sssi", user, escaped_player, tmp, datez);
	return true;
}

function OnIRCBanData(admin[], NameToBan[], banReason[], banTime)
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), "4Server3 Account '%s' does not exist!", NameToBan);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	else
	{
		MySQL_getString(0, 0, PlayerIP);
		if(banTime != 0)
		{
			banTime= gettime() + (datez * 86400);
		}
		format(query, sizeof(query), "INSERT INTO bans(user_banned, bIP, user_banner, ban_reason, ban_timestamp, ban_time) VALUES ('%s', '%s', '%s', '%s', UNIX_TIMESTAMP(), %d)", NameToBan, PlayerIP, admin, tmp, banTime);
		MySQL_updateQuery(query);

		format(str, sizeof(str), "4Server:3 %s(IRC) has banned %s from the server.", admin, NameToBan);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		format(str, sizeof(str), ""Server" "RED_E"%s(IRC) has banned %s from the server.", admin, NameToBan);
		SendClientMessageToAll(COLOR_GREY, str);
	}
	return true;
}

IRCCMD:kick(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "us[90]", otherid, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!kick <ID/Name> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "4Server:3 Invalid PlayerID (%d)", otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}
	SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has kicked %s(%i) [Reason: %s]", user, giveplayer, otherid, tmp);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), "Administrator %s(IRC) has kicked %s(%i) "GREY2_E"[Reason: %s]", user, giveplayer, otherid, tmp);
	SendClientMessageToAll(COLOR_RED, str);
	GameTextForPlayer(otherid, "~r~~h~Kicked!", 4000, 5);
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	KickEx(otherid);
	SetPVarInt(otherid, "pRemoved", 1);
	return true;
}

IRCCMD:warn(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "us[90]", otherid, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!warn <ID/Name> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has warned %s(%i) [Reason: %s]", user, giveplayer, otherid, tmp);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), "Administrator %s(IRC) has warned %s(%i) "GREY2_E"[Reason: %s]", user, giveplayer, otherid, tmp);
	SendClientMessageToAll(COLOR_RED, str);
	SendClientMessage(otherid, COLOR_RED, ">> You have been warned by an administrator, read the /rules, too many warnings will result in a kick or ban!");
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	pWarns[otherid] ++;
	if(pWarns[otherid] >= 3)
	{
		format(str, sizeof(str), "4Server: %s(%i) has been kicked for excessive warnings.", giveplayer, otherid);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
		format(str, sizeof(str), ""RED_E""Server" "GREY_E"%s(%i) has been kicked for excessive warnings.", giveplayer, otherid);
		SendClientMessageToAll(COLOR_WHITE, str);
		KickEx(otherid);
		return true;
	}

	return true;
}
IRCCMD:botnick(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsAdmin(botid, channel, user)) return false;
	if(sscanf(params, "is[31]", botid, str))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!nick <bot ID> <nickname>");
		return false;
	}

	if(strlen(str) > 30)
		return IRC_GroupSay(ircGroup, channel, "4Error: 2Name too long!");

	if(botid < 1 || botid > 3)
		return IRC_GroupSay(ircGroup, channel, "4Error: 2Bot IDs go from 1 to 3!");

	IRC_ChangeNick(ircBot[botid - 1], str);

	return true;
}

IRCCMD:info(botid, channel[], user[], host[], params[])
{
	IRC_GroupSay(ircGroup, channel, "7- Server Information -");
	IRC_GroupSay(ircGroup, channel, "4IP Address:17 samp.Serverserver.com");
	format(str, sizeof(str), "4Players:17 %d/%d", Iter_Count(Player), GetMaxPlayers());
	IRC_GroupSay(ircGroup, channel, str);

	return true;
}

IRCCMD:getip(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!getip <ID/Name>");
		return false;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}
	if(pAdmin[otherid] == 6)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 You can't use getip on the server owner!");
		return 1;
	}

	format(str, 256, "4Server:3 %s(%i)'s IP: %s", giveplayer, otherid, PlayerIP);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	return true;
}

IRCCMD:sethealth(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;
	new health;
	if(sscanf(params, "u", otherid, health))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!sethealth <ID/Name> <health>");
		return false;
	}
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return false;
	}

	if(health > 100 || health < 0)
	{
		format(str, sizeof(str), "4Server:3 %s, you have specified an invalid health amount (%d.0).", user, health);
		IRC_GroupSay(ircGroup, channel, str);
		return false;
	}
	if(health > 98)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 You can't set anyone's health over 98 due to the anti-cheat system.");
		return false;
	}
	SetPlayerHealth(otherid, health);
	format(str, sizeof(str), "4Server:3 %s(IRC) set %s(%i)'s health to %d.", user, giveplayer, otherid, health);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	return 1;
}

IRCCMD:ann(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	irccmd_announce(botid, channel, user, host, params);
	return true;
}

IRCCMD:announce(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!announce <message>");
		return false;
	}

	if(strfind(params, "~x~", true) != -1)
		return IRC_GroupSay(ircGroup, channel, "4ERROR: 2~x~ is not allowed in announce.");
	if(strfind(params, "#k~", true) != -1)
		return IRC_GroupSay(ircGroup, channel, "4ERROR: 2The constant key is not allowed in announce.");

	// Count tildes (uneven number = faulty input)
	iTemp = 0;
	for(new i = (strlen(params)-1); i != -1; i--)
	{
		if(params[i] == '~')
			iTemp ++;
	}
	if(iTemp % 2 == 1)
		return IRC_GroupSay(ircGroup, channel, "4ERROR: 2You either have an extra ~ or one is missing in the announcement!");

	format(str, 256, "4Announcement:3 %s(IRC) announced %s", user, params);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 6500, 3);

	return true;
}

IRCCMD:pm(botid, channel[], user[], host[], params[])
{
	if(sscanf(params, "us[128]", otherid, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!pm <ID/Name> <message>");
		return false;
	}
	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "PM from %s(IRC): "WHITE_E"%s", user, tmp);
	SendClientMessage(otherid, COLOR_YELLOW, str);
	format(str, sizeof(str), "4PM: 3%s(IRC) -> %s(%i): %s", user, giveplayer, otherid, tmp);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	if(GetPVarInt(otherid, "FirstPM_IRC") == 0)
	{
		format(str, sizeof(str), ""ORANGE_E"* "LB2_E"Use "ORANGE_E"/ircpm %s "LB2_E"to reply to the IRC user", user);
		SendClientMessage(otherid, COLOR_LB, str);
		SetPVarInt(otherid, "FirstPM_IRC", 1);
	}

	format(str, sizeof(str), "PM From %s(IRC): %s", user, tmp);
	for(new ir = 1; ir < MAX_PMS - 1; ir++)
	{
		PMs[otherid][ir] = PMs[otherid][ir + 1];
	}
	PMs[otherid][MAX_PMS - 1] = str;

	return true;
}

IRCCMD:banip(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!banip <ip> ");
		return false;
	}
	if(strfind(params, "*", true) != -1)
	{
		IRC_GroupSay(ircGroup, channel, "4Error: 2You are not authorized to ban ranges. ");
		return true;
	}
	format(str, sizeof(str), "4Server:3 %s has IP banned address %s.", user, params);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), ""Server" "GREY2_E"%s(IRC) IP banned address %s.", user, params);
	SendClientMessageToAll(COLOR_GREY2, str);

	format(str, sizeof(str), "banip %s", params);
	SendRconCommand(str);

	return true;
}

IRCCMD:unbanip(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;
	if(isnull(params))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!unbanip <ip>");
		return false;
	}

	format(str, sizeof(str), "4Server:3 %s has IP un-banned address %s", user, params);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), "unbanip %s", params);
	SendRconCommand(str);
	format(str, sizeof(str), "reloadbans");
	SendRconCommand(str);

	return true;
}

IRCCMD:unban(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	if(sscanf(params, "s[24]", tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!unban <playername (3-21 chars)>");
		return true;
	}
	new escaped_tmp[24];
	mysql_real_escape_string(tmp, escaped_tmp);

	format(query, sizeof(query), "SELECT user_banned,bIP FROM bans WHERE user_banned = '%s'", escaped_tmp);
	MySQL_query(query, true, "OnIRCUnbanData", "sss", channel, user, escaped_tmp);
	return true;
}

function OnIRCUnbanData(channel, admin[], BannedName[])
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), "4[ERROR] 2No player named '%s' found on the ban list.", BannedName);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	else
	{
		new banIP[16];
		MySQL_getString(0, 1, banIP);
		format(query, sizeof(query), "DELETE FROM bans WHERE bIP = '%s'", banIP);
		MySQL_updateQuery(query);

		format(str, sizeof(str), "4Server:3 %s(IRC) has unbanned %s from the server.", admin, BannedName);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		format(str, sizeof(str), ""Server" "GREY2_E"%s(IRC) has unbanned %s from the server.", admin, BannedName);
		SendClientMessageToAll(COLOR_GREY, str);
	}
	return true;
}

IRCCMD:mute(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	new timeSec, reason[80];
	if(sscanf(params, "udS[60]", otherid, timeSec, reason))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: !mute <ID/Name> <time in seconds> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID) return IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
	if(strlen(reason) > 60) return IRC_GroupSay(ircGroup, channel, "4Server:3 Reason too long! Must be shorter than 60 characters!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	if(timeSec < 10 || timeSec > 600) return IRC_GroupSay(ircGroup, channel, "4Server:3 The mute-time must remain between 10-600 seconds.");

	if(pMute[otherid] > 1)
	{
		format(str, sizeof(str), "4Server:3 %s(%i) is already muted (mute lifted in %d seconds)", giveplayer, otherid, pMute[otherid]);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}

	pMute[otherid] = timeSec;

	if(!isnull(reason))
	{
		format(str, sizeof(str), "Administrator %s(IRC) muted %s(%i) for %s (%d seconds)", user, giveplayer, otherid, reason, timeSec);
		format(tmp, sizeof(tmp), "4Server: 2Administrator %s(IRC) muted %s(%i) for %s (%d seconds).", user, giveplayer, otherid, reason, timeSec);
	}
	else
	{
		format(str, sizeof(str), "Administrator %s(IRC) muted %s(%i) (%d seconds)", user, giveplayer, otherid, timeSec);
		format(tmp, sizeof(tmp), "4Server: 2Administrator %s(IRC) muted %s(%i) (%d seconds).", user, giveplayer, otherid, timeSec);
	}
	SendClientMessageToAll(COLOR_YELLOW, str);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, tmp), IRC_GroupSay(ircGroup, IRC_aCHANNEL, tmp);

	return true;
}
IRCCMD:omute(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	new player[24];
	if(sscanf(params, "s[24]ds[60]", player, datez, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: !omute <ID/Name> <time in seconds> <reason>");
		return false;
	}
	if(strlen(tmp) > 80)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Reason too long! Must be shorter than 60 characters!");
		return true;
	}
	if(datez < 10 || datez > 1000) return IRC_GroupSay(ircGroup, channel, "4Server:3 The mute-time must remain between 10-600 seconds.");

	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(strfind(PlayerName, player, true) != -1)
		{
			IRC_GroupSay(ircGroup, channel, "4Server:3 Player is online, you can use !mute on them.");
			return true;
		}
	}

	new escaped_player[24];
	mysql_real_escape_string(player, escaped_player);

	format(query, sizeof(query), "SELECT reg_id FROM players WHERE name='%s'", escaped_player);
	MySQL_query(query, true, "OnIRCOMuteQueryData", "sssi", user, escaped_player, tmp, datez);
	return true;
}

function OnIRCOMuteQueryData(adminid[], NameToMute[], muteReason[], muteTime)
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), "4Error:3 Account '%s' does not exist.", NameToMute);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	else
	{
		new RegID;
		RegID = MySQL_getInt(0, 0);
		format(str, sizeof(str), "4Server:3 You have muted %s for %d seconds. (Mute will take affect as soon as player logs in)", NameToMute, muteTime);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

		format(str, sizeof(str), "4Server:3 %s(IRC) has offline muted %s for %d seconds (Reason: %s)", adminid, NameToMute, muteTime, muteReason);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

		format(str, sizeof(str), "- AS - "RED_E"%s(IRC) has offline muted %s for %d seconds. "GREY2_E"[Reason: %s]", adminid, NameToMute, muteTime, muteReason);
		SendClientMessageToAll(COLOR_YELLOW, str);

		format(query, sizeof(query), "UPDATE players SET Muted=%d WHERE reg_id=%d", muteTime, RegID);
		MySQL_updateQuery(query);
	}
	return true;
}
IRCCMD:unmute(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: !unmute <ID/Name>");
		return false;
	}
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}
	if(pMute[otherid] == 0)
	{
		format(str, sizeof(str), "4Server:3 Player %s(%i) is not muted.", giveplayer, otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}

	format(str, sizeof(str), "4Server:3 %s(IRC) has unmuted %s(%i).",user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), ""Server" %s(IRC) has unmuted %s(%i).", user, giveplayer, otherid);
	SendClientMessageToAll(COLOR_GREY, str);
	pMute[otherid] = 0;

	return true;
}
IRCCMD:jail(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	new reason[100], timeSec;
	if(sscanf(params, "udS[99]", otherid, timeSec, reason))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: !jail <ID/Name> <time in seconds> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "4Server:3 Jail: Invalid Player ID (%d).", otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	if(pJail[otherid] > 0)
	{
		format(str, sizeof(str), "4Server:3 %s(%i) is already jailed (gets out in %d seconds)", giveplayer, otherid, pJail[otherid]);
		IRC_GroupSay(ircGroup, channel, str);
		return true;
	}


	if(strlen(reason) > 60) return IRC_GroupSay(ircGroup, channel, "4Server:3 Reason too long! Must be shorter than 60 characters!");
	if(timeSec < 10 || timeSec > 600) return IRC_GroupSay(ircGroup, channel, "4Server:3 The mute-time must remain between 10-600 seconds.");

	if(InDuel[otherid] != -1)
	{
		format(str, sizeof(str), ""DUEL" "GREY_E"%s has been eliminated.", pName[otherid], otherid);
		SendClientMessageToAll(COLOR_GREY, str);
		EndDuel(otherid);
	}
	pJail[otherid] = timeSec;
	SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	SetPlayerWorldBounds(otherid, 20000.0, -20000.0, 20000.0, -20000.0);
	ResetPlayerWeapons(otherid);
	SetPVarInt(otherid, "JailedByAdmin", 1);
	ShowPlayerDialog(otherid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	if(reason[0] == '*')
	{
		format(str, sizeof(str), ""RED_E"* Administrator %s(IRC) jailed "GREY_E"%s(%i) "RED_E"for %d seconds.", user, giveplayer, otherid, timeSec);
		format(tmp, sizeof(tmp), "4Server: 2Administrator %s(IRC) jailed %s(%i) for %d seconds.", user, giveplayer, otherid, timeSec);
	}
	else
	{
		format(str, sizeof(str), ""RED_E"* Administrator %s(IRC) jailed %s(%i) for "GREY_E"%s "RED_E"(%d seconds)", user, giveplayer, otherid, reason, timeSec);
		#if defined IRC
		format(tmp, sizeof(tmp), "4Server: 2Administrator %s(IRC) jailed %s(%i) for %s (%d seconds)", user, giveplayer, otherid, reason, timeSec);
		#endif
	}
	SendClientMessageToAll(COLOR_GREY, str);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, tmp), IRC_GroupSay(ircGroup, IRC_aCHANNEL, tmp);
	return true;
}
IRCCMD:ojail(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;

	new player[24];
	if(sscanf(params, "s[24]ds[60]", player, datez, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: !ojail <ID/Name> <time in seconds> <reason>");
		return false;
	}
	if(strlen(tmp) > 60)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Reason too long! Must be shorter than 60 characters!");
		return true;
	}
	if(datez < 10 || datez > 1000) return IRC_GroupSay(ircGroup, channel, "4Server:3 The mute-time must remain between 10-600 seconds.");
	foreach(new ii : Player)
	{
		GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);

		if(strfind(PlayerName, player, true) != -1)
		{
			IRC_GroupSay(ircGroup, channel, "4Server:3 Player is online, you can use !mute on them.");
			return true;
		}
	}

	new escaped_player[24];
	mysql_real_escape_string(player, escaped_player);

	format(query, sizeof(query), "SELECT reg_id FROM players WHERE name='%s'", escaped_player);
	MySQL_query(query, true, "OnOJailQueryData", "sssi", user, escaped_player, tmp, datez);
	return true;
}

function OnIRCOJailQueryData(adminid, NameToJail[], jailReason[], jailTime)
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), "4Error:3 Account '%s' does not exist.", NameToJail);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	}
	else
	{
		new RegID;
		RegID = MySQL_getInt(0, 0);
		format(str, sizeof(str), "4Server:3 You have jailed %s for %d seconds. (Time will take affect as soon as player logs in)", NameToJail, jailTime);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		format(str, sizeof(str), "4Server:3 %s(%i) has offline jailed %s for %d seconds. [Reason: %s]", adminid, NameToJail, jailTime, jailReason);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

		format(str, sizeof(str), "- AS - "RED_E"%s(IRC) has offline jailed %s for %d seconds. "GREY2_E"[Reason: %s]", adminid, NameToJail, jailTime, jailReason);
		SendClientMessageToAll(COLOR_YELLOW, str);

		format(query, sizeof(query), "UPDATE players SET Jailed=%d WHERE reg_id=%d", jailTime, RegID);
		MySQL_updateQuery(query);
	}
	return true;
}
IRCCMD:unjail(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "4Usage: !unjail <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	if(pJail[otherid] == 0)
	{
		format(str, sizeof(str), "4Server:3 Player %s(%i) is not in jail.", giveplayer, otherid);
		IRC_GroupSay(ircGroup, channel, str);
		return 1;
	}


	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	pJail[otherid] = 0;
	SetPlayerHealth(otherid, 100.0);
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SpawnPlayer(otherid);

	format(str, sizeof(str), "Administrator %s(IRC) has unjailed %s(%i)", user, giveplayer, otherid);
	SendClientMessageToAll(COLOR_GREY, str);

	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has unjailed %s(%i)", user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	return true;
}

IRCCMD:freeze(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "us[90]", otherid, tmp))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!freeze <ID/Name> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}
	if(Freezed[otherid]) IRC_GroupSay(ircGroup, channel, "4Server:3 This player is already frozen");
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "4Server: 2%s(IRC) has frozen %s(%i) for: %s", user, giveplayer, otherid, tmp);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), "Administrator %s(IRC) has frozen %s(%i) for: %s", user, giveplayer, otherid, tmp);
	SendClientMessageToAll(COLOR_GREY, str);

	TogglePlayerControllable(otherid, false);
	Freezed[otherid] = true;
	return true;
}

IRCCMD:unfreeze(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!unfreeze <ID/Name> ");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}
	if(Freezed[otherid]) IRC_GroupSay(ircGroup, channel, "4Server:3 This player is not frozen");
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has unfrozen %s(%i).", user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), "Administrator %s(IRC) has unfrozen %s(%i).", user, giveplayer, otherid);
	SendClientMessageToAll(COLOR_GREY, str);

	TogglePlayerControllable(otherid, true);
	Freezed[otherid] = false;
	return true;
}

IRCCMD:akill(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!akill <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "4Server: 2Administrator %s(IRC) has killed %s(%i).", user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), "* Administrator %s(IRC) has killed %s(%i).", user, giveplayer, otherid);
	SendClientMessageToAll(COLOR_YELLOW, str);

	SetPlayerHealth(otherid, 0.0);
	return true;
}
IRCCMD:stats(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsVoice(botid, channel, user)) return false;
	if(sscanf(params, "r", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!stats <ID/Name>");
		return false;
	}
	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}
	if(!pLogged[otherid] || pHidden[otherid] || pmhidden[otherid])
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 This player is not registered!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "7,1Player Stats: 8%s(%i)", giveplayer, otherid);
	IRC_GroupSay(ircGroup, channel, str);

	new adm_str[20];
	switch(pAdmin[otherid])
	{
		case 0: adm_str = "Regular player";
		case 1..3: adm_str = "Admin";
		case 4: adm_str = "Lead Admin";
		case 5: adm_str = "Management";
		case 6: adm_str = "Server Owner";
	}

	format(str, sizeof(str), "%s is a 8,1%s", giveplayer, adm_str);
	IRC_GroupSay(ircGroup, channel, str);

	format(str, sizeof(str), "8,1Member since:1,0 %s", pRegDate[otherid]);
	IRC_GroupSay(ircGroup, channel, str);

	format(str, sizeof(str), "8,1Time online:1,0 %d 8,1hours,1,0 %d 8,1minutes,1,0 %d 8,1seconds1,0", pTotalHours[otherid], pTotalMinutes[otherid], pTotalSeconds[otherid]);
	IRC_GroupSay(ircGroup, channel, str);

	format(str, sizeof(str), "8,1Kills:1,0 %d 8,1Deaths:1,0 %d 8,1KDR:1,0 %0.2f 8,1Money:1,0 $%d 8,1Score:1,0 %d", pInfo[otherid][pKills], pInfo[otherid][pDeaths], Float:pInfo[otherid][pKills]/Float:pInfo[otherid][pDeaths], pCash[otherid], GetPlayerScore(otherid));
	IRC_GroupSay(ircGroup, channel, str);
	return true;
}

IRCCMD:playerinfo(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsHalfop(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!playerinfo <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	new Float:pArmour,
		Float:pHealth,
		adm_str[20];

	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	GetPlayerArmour(otherid, pArmour);
	GetPlayerHealth(otherid, pHealth);
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	switch(pAdmin[otherid])
	{
		case 0: adm_str = "Regular player";
		case 1..3: adm_str = "Admin";
		case 4: adm_str = "Lead Admin";
		case 5: adm_str = "Manager";
		case 6: adm_str = "Owner";
	}

	format(str, sizeof(str), "7,1Playerinfo: 8%s(%i)", giveplayer, otherid);
	IRC_GroupSay(ircGroup, channel, str);
	format(str, sizeof(str), "%s is a 8,1%s", giveplayer, adm_str);
	IRC_GroupSay(ircGroup, channel, str);
	format(str, sizeof(str), "8,1Health:1,0 %3.f 8,1Armour:1,0 %3.f", pHealth, pArmour);
	IRC_GroupSay(ircGroup, channel, str);
	if(IsPlayerInAnyVehicle(otherid))
	{
		new Float:vpHealth;
		vID = GetPlayerVehicleID(otherid);
		vv = GetVehicleModel(vID);

		GetVehicleHealth(GetPlayerVehicleID(otherid), vpHealth);
		format(str, sizeof(str), "8,1Vehicle:1,0 %s (8,1ID1,0: %d) (8,1MODEL:1,0: %d) 8,1Vehicle Health:1,0 %3.f", vehName[vv - 400], vID, vv, vpHealth);
		IRC_GroupSay(ircGroup, channel, str);
	}
	format(str, sizeof(str), "8,1Time online:1,0 %d 8,1hours,1,0 %d 8,1minutes,1,0 %d 8,1seconds1,0", pTotalHours[otherid], pTotalMinutes[otherid], pTotalSeconds[otherid]);
	IRC_GroupSay(ircGroup, channel, str);
	format(str, sizeof(str), "8,1Kills:1,0 %d 8,1Deaths:1,0 %d 8,1Money:1,0 $%d 8,1Interior:1,0 %d", pInfo[otherid][pKills], pInfo[otherid][pDeaths], pCash[otherid], GetPlayerInterior(otherid));
	IRC_GroupSay(ircGroup, channel, str);
	format(str, sizeof(str), "8,1IP address:1,0 %s 8,1Ping:1,0 %d", PlayerIP, GetPlayerPing(otherid));
	IRC_GroupSay(ircGroup, channel, str);

	return true;
}

IRCCMD:explode(botid, channel[], user[], host[], params[])
{
	if(!IRC_IsOp(botid, channel, user)) return false;
	if(sscanf(params, "u", otherid))
	{
		IRC_GroupSay(ircGroup, channel, "7Usage: 2!explode <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		IRC_GroupSay(ircGroup, channel, "4Server:3 Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "4Server:3 %s(IRC) has exploded %s(%i).", user, giveplayer, otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	
	format(str, sizeof(str), "**[Private Message]** %s(IRC) has exploded %s(%i).", user, giveplayer, otherid);
	DCC_SendChannelMessage(Channel_Staff, str);
	
	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 3.0);

	return true;
}

CMD:ircpm(playerid, params[])
{
	new ircPlayer[24];
	if(sscanf(params, "s[24]s[90]", ircPlayer, tmp))
	{
		Usage(playerid, "/ircpm <user> <message>");
		return true;
	}

	format(str, sizeof(str), "2*** 3%s(%i) (In-Game): 4%s", pName[playerid], playerid, tmp);
	IRC_Notice(ircBot[0], ircPlayer, str);
	format(str, sizeof(str), "* "LB_E"PM sent to %s on IRC: "WHITEP_E"%s", ircPlayer, tmp);
	SendClientMessage(playerid, COLOR_WHITEP, str);
	format(str, sizeof(str), "**[Private Message]** %s (%i) to %s (IRC): %s", pName[playerid], playerid, ircPlayer, tmp);
	DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}

CMD:irc(playerid, params[])
{
	if(isnull(params))
	{
		Usage(playerid, "/irc <message> - Sends a message to the IRC channel.");
		return true;
	}

	format(str, sizeof(str), "2*** 3%s(%i) to IRC: 4%s", pName[playerid], playerid, params);


	IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
	format(str, sizeof(str), "* "RED_E"Message sent to IRC: "YELLOW_E"%s", params);
	SendClientMessage(playerid, COLOR_YELLOW, str);
	format(str, sizeof(str), "**[IRC]** %s (%i) to IRC: %s", pName[playerid], playerid, params);
	DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}
*/