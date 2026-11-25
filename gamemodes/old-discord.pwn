/*

DCCMD:say(DCC_Channel:channel, DCC_User:user, const message[])
{
	if(isnull(message)) return //DCC_SendChannelMessage(Channel_Echo, "**[Usage]:** !say [text]");
	
	new string[50];
	DCC_GetUserName(user, string, sizeof(string));
	
	format(str, sizeof(str), "**[Discord]** %s: %s", string, message);
	//DCC_SendChannelMessage(Channel_Echo, str);
	//DCC_SendChannelMessage(Channel_Staff, str);

	format(str, sizeof(str), "["BLUE_E"Discord"WHITE_E"] %s: %s", string, message);
	SendClientMessageToAll(-1, str);
	return true;
}

DCCMD:8ball(DCC_Channel:channel, DCC_User:user, const message[])
{
	if(isnull(message)) return //DCC_SendChannelMessage(Channel_Echo, "**[Usage]:** !8ball [question]");
	if(strfind(message, "?") == -1) return //DCC_SendChannelMessage(Channel_Echo, "**[Error]:** This isn't a question!");
	
	new int = random(6);
	switch(int)
	{
		case 0: //DCC_SendChannelMessage(Channel_Echo, "**[Reaction]** Maybe!");
		case 1: //DCC_SendChannelMessage(Channel_Echo, "**[Reaction]** I think so.");
		case 2: //DCC_SendChannelMessage(Channel_Echo, "**[Reaction]** Yes, I'm Sure!");
		case 3: //DCC_SendChannelMessage(Channel_Echo, "**[Reaction]** What the?! No.");
		case 4: //DCC_SendChannelMessage(Channel_Echo, "**[Reaction]** Not now, please.");
		case 5: //DCC_SendChannelMessage(Channel_Echo, "**[Reaction]** I doubt!");
	}
	return true;
}

DCCMD:checkban(DCC_Channel:channel, DCC_User:user, const message[])
{
	if(sscanf(message, "s[24]", tmp))
	{
		//DCC_SendChannelMessage(channel, "**[Usage]** !checkban [Nickname]");
		return true;
	}
	if(strfind(tmp, "%", true) != -1)
		return //DCC_SendChannelMessage(channel, "**[Error]** Invalid characters in ban name!");

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
	MySQL_query(query, true, "CheckPlayerBanned_Discord", "is", _:channel, message);
	return true;
}

function CheckPlayerBanned_Discord(DCC_Channel:channel, const msg[])
{
	if(MySQL_rowCount() == 0)
	{
		format(str, sizeof(str), "**[Error]** No player with name or IP '%s' found on the ban list.", msg);
		//DCC_SendChannelMessage(channel, str);
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
		
		format(line, sizeof(line), "**[Database]** Player **%s** was banned by **%s** for Ban Reason **%s** in **%s** and they're banned (for) **%s**.", msg, PlayerName, Reason, tmp, banTime);
		//DCC_SendChannelMessage(channel, line);
	}
	return true;
}

DCCMD:uptime(DCC_Channel:channel, DCC_User:user, const message[])
{
	format(str, sizeof(str), "The server has been online for **%s**.", Uptime());
	//DCC_SendChannelMessage(channel,  str);
	return 1;
}

function GameModeLoad()
{
	//DCC_SendChannelMessage(Channel_Echo, "**[Server]** Global Gamemode Initialization..");
	//DCC_SendChannelMessage(Channel_Staff, "**[Server]** Global Gamemode Initialization..");
	MySQL_query("SELECT * FROM `Labels`", true, "OnLabelsLoad", "", 0);
	return 1;
}

DCCMD:cmds(DCC_Channel:channel, DCC_User:user, const message[])
{
	//DCC_SendChannelMessage(channel, "**[Commands::Users]** !say !pm !info !players !getid !checkban !uptime !admins !8ball");
	if(channel != Channel_Echo)
	{
		new bool:role;

		DCC_HasGuildMemberRole(staff_guild, user, vip_role, role);
		if(role) //DCC_SendChannelMessage(channel, "**[Commands::Premium]** !vip");
		
		DCC_HasGuildMemberRole(staff_guild, user, vip_role, role);
		if(role) //DCC_SendChannelMessage(channel, "**[Commands::Helper]** !h !(un)mute !(un)jail !forcerespawn !warn");

		DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
		if(role) {
			//DCC_SendChannelMessage(channel, "**[Commands::Admin]** !(un)ban !kick !aka !akaip !ann !amsg !(un)freeze !slap !getip !akill !playerinfo");
			//DCC_SendChannelMessage(channel, "**[Commands::Admin]** !loadrace !respawnvehicles !startrace !caps !pweaps !spectators !check");
		}
		
		DCC_HasGuildMemberRole(staff_guild, user, head_role, role);
		if(role) //DCC_SendChannelMessage(channel, "**[Commands::Lead Admin]** !banip !unbanip !explode !sethealth !setname !setpassword !cc !oban !crash !day !night");
		
		DCC_HasGuildMemberRole(staff_guild, user, manager_role, role);
		if(role) //DCC_SendChannelMessage(channel, "**[Commands::Managers]** No Commands at the moment.");
		
		DCC_HasGuildMemberRole(staff_guild, user, owner_role, role);
		if(role) //DCC_SendChannelMessage(channel, "**[Commands::Owners]** !rcon !gmx !saveallstats");
	}
	return 1;
}

DCCMD:players(DCC_Channel:channel, DCC_User:user, const message[])
{
	new charsPerLine = 0;
	new playersOnline = 0;
	line[0] = EOS;

	foreach(new ii : Player)
	{
		playersOnline ++;
		GetPlayerName(ii, PlayerName, sizeof(PlayerName));

		if(charsPerLine == 0) format(tmp, sizeof(tmp), "**[Players]** %s(%i)", PlayerName, ii);
		else format(tmp, sizeof(tmp), ", %s(%i)", PlayerName, ii);
		
		charsPerLine += strlen(tmp);
		if(charsPerLine >= 330)
		{
			//DCC_SendChannelMessage(channel, line);
			charsPerLine = 0;
			line[0] = EOS;
		}
		strcat(line, tmp);
	}
	if(charsPerLine != 0)
	{
		//DCC_SendChannelMessage(channel, line);
	}
	if(playersOnline == 0) return //DCC_SendChannelMessage(channel, "**[Players]** There aren't any players online!");

	if(playersOnline == 1)
	{
		format(str, sizeof(str), "**[Players]** There is 1 player online.");
	}
	else format(str, sizeof(str), "**[Players]** There are %d players online.", playersOnline);
	//DCC_SendChannelMessage(channel, str);
	return true;
}

DCCMD:admins(DCC_Channel:channel, DCC_User:user, const message[])
{
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
		//DCC_SendChannelMessage(channel, "**[Admins]** There are no administrators online!");
		return true;
	}

	if(count == 1)
	{
		format(str, sizeof(str), "**[Admins]** Displaying the one admin online:");
	}
	else
	{
		format(str, sizeof(str), "**[Admins]** Displaying the list of %d admins online:", count);
	}
	//DCC_SendChannelMessage(channel, str);

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
				format(str, sizeof(str), "**[%s::AFK]** %s (ID: %i)", tmp, PlayerName, ii);
			}
			else format(str, sizeof(str), "**[%s]** %s (ID: %i)", tmp, PlayerName, ii);
			//DCC_SendChannelMessage(channel, str);
		}
	}

	return true;
}

DCCMD:pm(DCC_Channel:channel, DCC_User:user, const message[])
{
	if(sscanf(message, "us[128]", otherid, tmp))
	{
		//DCC_SendChannelMessage(channel, "**[Usage]** !pm [playerid] [message]");
		return false;
	}
	if(otherid == INVALID_PLAYER_ID)
	{
		//DCC_SendChannelMessage(channel, "**[Error]** Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	
	new name[60];
	DCC_GetUserName(user, name, sizeof(name));
	format(str, sizeof(str), "PM from %s(Discord): "WHITE_E"%s", name, tmp);
	SendClientMessage(otherid, COLOR_YELLOW, str);
	format(str, sizeof(str), "**[Private Message]** %s (Discord) -> %s(%i): %s", name, giveplayer, otherid, tmp);
	//DCC_SendChannelMessage(Channel_Echo, str), //DCC_SendChannelMessage(Channel_Staff, str);

	format(str, sizeof(str), "PM From %s(Discord): %s", name, tmp);
	for(new ir = 1; ir < MAX_PMS - 1; ir++)
	{
		PMs[otherid][ir] = PMs[otherid][ir + 1];
	}
	PMs[otherid][MAX_PMS - 1] = str;

	return true;
}

DCCMD:getid(DCC_Channel:channel, DCC_User:user, const message[])
{
	if(isnull(message))
	{
		//DCC_SendChannelMessage(channel, "**[Usage]** !getid <part of name>");
		return true;
	}

	if(!(2 <= strlen(message) <= 15))
	{
		//DCC_SendChannelMessage(channel, "**[Error]** Name length invalid");
		return true;
	}

	format(str, sizeof(str), "**[Progress]** Searching for '%s' in names...", message);
	//DCC_SendChannelMessage(channel, str);
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
				if(strfind(PlayerName, message, true) == pos)
				{
					found ++;
					format(str,sizeof(str),"**[Results]** %d. %s (ID: %d)", found, PlayerName, ii);
					//DCC_SendChannelMessage(channel, str);
					searched = true;
				}
			}
		}
	}
	if(found == 0) //DCC_SendChannelMessage(channel, "**[Results]** No players found matching that name!");
	return true;
}

DCCMD:info(DCC_Channel:channel, DCC_User:user, const message[])
{
	//DCC_SendChannelMessage(channel, "**[Server Information]**");
	//DCC_SendChannelMessage(channel, "**[IP Address]** samp.Serverserver.com");
	format(str, sizeof(str), "**[Players]** %d/%d", Iter_Count(Player), GetMaxPlayers());
	//DCC_SendChannelMessage(channel, str);

	return true;
}

DCCMD:rcon(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, owner_role, role);
	
	if(!role || channel != Channel_Staff) return 1;
	if(isnull(message)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !rcon [command]");
	if(strcmp(message, "login", true, 5) == 0) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** You can't use this command from Discord");
	
	new name[24];
	DCC_GetUserName(user, name, 24);
	
	format(str, sizeof(str), "4Server:3 %s(IRC) sent RCON CMD: %s", name, message);
	IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);

	format(str, sizeof(str), ""Server" %s(IRC) sent RCON CMD: %s", name, message);
	SendClientMessageToAll(COLOR_GREY, str);
		
	format(str, sizeof(str), "**[Rcon]** %s(Discord) used: %s", name, message);
	SendClientMessageToAll(COLOR_GREY, str);
	
	format(str, sizeof(str), message);
	SendRconCommand(str);
	return true;
}

DCCMD:makeadmin(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, owner_role, role);
	if(!role || channel != Channel_Staff) return 1;
	
	new alevel;
	if(sscanf(message, "ud", otherid, alevel)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !makeadmin [Id] [level]");

	if(otherid == INVALID_PLAYER_ID)
		return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
	if(alevel > 5)
		return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Level can't be higher than 5!");
	if(alevel < 0)
		return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Level can't be lower than 0!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	if(pLogged[otherid] == false)
	{
		format(str, sizeof(str), "**[Error]** Player %s(%i) isn't logged in!", giveplayer, otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return true;
	}

	new levelstr[12], name[24];
	levelstr = (alevel > pAdmin[otherid]) ? ("promoted") : ("demonted");
	DCC_GetUserName(user, name, sizeof(name));

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
	
	format(str, sizeof(str), ""YELLOW_E"- AS - "SBLUE_E"Manager %s has %s %s(%i) to %s.", name, levelstr, giveplayer, otherid, tmp);
	SendClientMessageToAll(COLOR_SBLUE, str);
	SendClientMessageToAll(COLOR_LB, " ");
	
	levelstr = (alevel > pAdmin[otherid]) ? ("Promotion") : ("Demotion");
	format(str, sizeof(str), "**[%s]** Manager %s(Discord) has %s(%i) to %s.", levelstr, name, giveplayer, otherid, tmp);
	//DCC_SendChannelMessage(Channel_Staff, str), //DCC_SendChannelMessage(Channel_Echo, str);
	levelstr = (alevel > pAdmin[otherid]) ? ("promoted") : ("demonted");
	format(str, sizeof(str), "~y~~h~You have been %s to %s!", levelstr, tmp);
	InfoTD_MSG(otherid, 5000, str);
	return true;
}


DCCMD:asay(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	
	if(!strlen(message))
		return //DCC_SendChannelMessage(channel, "**[Usage]** !asay [message]");

	new name[24];
	DCC_GetUserName(user, name, sizeof(name));
	format(str, sizeof(str), ""RED_E"* "YELLOW_E"Administrator %s on Discord: "WHITEP_E"%s", name, message);
	SendClientMessageToAll(COLOR_RED, str);

	format(str, sizeof(str), "**[Chat]** Server Discord Admin (%s): %s", name, message);
	//DCC_SendChannelMessage(Channel_Echo, str);

	return true;
}

DCCMD:ban(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	
	if(sscanf(message, "us[128]", otherid, tmp))
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !ban [playerid] [reason]");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "**[Error]** Invalid Playerid (%d)", otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return 1;
	}
	
	if(GetPVarInt(otherid, "pRemoved")) return true;
	new name[24];
	DCC_GetUserName(user, name, sizeof(name));
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
	//New Shortcuts
	else if(!strcmp(tmp, "rf", true)) tmp = "Rapid Fire";
	else if(!strcmp(tmp, "bf", true)) tmp = "BulletProof";
	else if(!strcmp(tmp, "tp", true)) tmp = "Teleport Hack";
	else if(!strcmp(tmp, "vh", true)) tmp = "Vehicle Hacks";

	format(str, sizeof(str), "- AS - "RED_E"Administrator %s(Discord) has banned %s(%i) "GREY2_E"[Reason: %s]", name, giveplayer, otherid, tmp);
	SendClientMessageToAll(COLOR_YELLOW, str);
	format(str, sizeof(str), "**[Admin]** %s(Discord) banned %s(%i) [Reason: %s]", name, giveplayer, otherid, tmp);
	//DCC_SendChannelMessage(Channel_Staff, str), //DCC_SendChannelMessage(Channel_Echo, str);

	for(new ii = 0; ii < 10; ii++)
	{
		SendClientMessage(otherid, COLOR_SYSTEM, " ");
	}

	SendClientMessage(otherid, COLOR_RED, "YOU HAVE BEEN BANNED!");
	format(str, sizeof(str), "Admin: %s(Discord)", name);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "Reason: %s", tmp);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "The time is %02d/%02d/%d %02d:%02d", day, month, year, hour, minute);
	SendClientMessage(otherid, COLOR_GREY2, str);
	format(str, sizeof(str), "Go to Serverserver.com/forums to appeal your ban. Include a screenshot of your ban.");
	SendClientMessage(otherid, COLOR_GREY2, str);
	SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
	SetPVarInt(otherid, "pRemoved", 1);
	format(query, sizeof(query), "INSERT INTO bans(user_banned, bIP, user_banner, ban_reason, ban_timestamp, ban_time) VALUES ('%s', '%s', '%s(Discord)', '%s', UNIX_TIMESTAMP(), 0)", giveplayer, PlayerIP, name, tmp);
	MySQL_updateQuery(query);
	GameTextForPlayer(otherid, "~r~~h~Banned!", 4000, 5);
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	KickEx(otherid);
	return true;
}

DCCMD:tempban(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	new ban_time;
	if(sscanf(message, "uds[128]", otherid, datez, tmp))
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !tempban [playerid] [time(in days)] [reason]");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "**[Error]** Invalid PlayerID (%d)", otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return 1;
	}
	
	new name[24];
	DCC_GetUserName(user, name, sizeof(name));
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
	//New Shortcuts
	else if(!strcmp(tmp, "rf", true)) tmp = "Rapid Fire";
	else if(!strcmp(tmp, "bf", true)) tmp = "BulletProof";
	else if(!strcmp(tmp, "tp", true)) tmp = "Teleport Hack";
	else if(!strcmp(tmp, "vh", true)) tmp = "Vehicle Hacks";

	format(str, sizeof(str), "* Administrator %s(Discord) has temp-banned %s(%i) for %d days. "GREY2_E"[Reason: %s]", name, giveplayer, otherid, datez, tmp);
	SendClientMessageToAll(COLOR_RED, str);
	format(str, sizeof(str), "**[Admin]** %s(Discord) temp-banned %s(%i) for %d days. [Reason: %s]", name, giveplayer, otherid, datez, tmp);
	//DCC_SendChannelMessage(Channel_Staff, str), //DCC_SendChannelMessage(Channel_Echo, str);

	for(new ii = 0; ii < 10; ii++)
	{
		SendClientMessage(otherid, COLOR_SYSTEM, " ");
	}

	SendClientMessage(otherid, COLOR_RED, "YOU HAVE BEEN BANNED!");
	format(str, sizeof(str), "Admin: %s(Discord)", name);
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

	format(query, sizeof(query), "INSERT INTO bans(user_banned, bIP, user_banner, ban_reason, ban_timestamp, ban_time) VALUES ('%s', '%s', '%s(Discord)', '%s', UNIX_TIMESTAMP(), %d)", giveplayer, PlayerIP, name, tmp, ban_time);
	MySQL_updateQuery(query);
	GameTextForPlayer(otherid, "~r~~h~Temp-Banned!", 4000, 5);
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	KickEx(otherid);
	return true;
}


DCCMD:oban(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	new player[24];
	if(sscanf(message, "s[24]D(0)s[50]", player, datez, tmp)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !oban [Account name] [time in days (0 for permanent ban)] [reason]");
	if(strlen(tmp) > 50) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Reason must be under 50 characters.");
	foreach(new ii : Player)
	{
		if(strfind(pName[ii], player, true) != -1) return //DCC_SendChannelMessage(Channel_Staff, "**[Notice]** Player is online, you can use !ban on them.");
	}
	new escaped_player[24];
	mysql_real_escape_string(player, escaped_player);
	format(query, sizeof(query), "SELECT ip FROM players WHERE name='%s'", escaped_player);
	MySQL_query(query, true, "OnDiscordBanData", "sssi", _:user, escaped_player, tmp, datez);
	return true;
}

function OnDiscordBanData(DCC_User:user, NameToBan[], banReason[], banTime)
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), "**[Database::Error]** Account '%s' does not exist!", NameToBan);
		//DCC_SendChannelMessage(Channel_Staff, str);
	}
	else
	{
		new admin[24];
		DCC_GetUserName(user, admin, sizeof(admin));
		MySQL_getString(0, 0, PlayerIP);
		if(banTime != 0)
		{
			banTime= gettime() + (datez * 86400);
		}
		format(query, sizeof(query), "INSERT INTO bans(user_banned, bIP, user_banner, ban_reason, ban_timestamp, ban_time) VALUES ('%s', '%s', '%s(Discord)', '%s', UNIX_TIMESTAMP(), %d)", NameToBan, PlayerIP, admin, tmp, banTime);
		MySQL_updateQuery(query);

		format(str, sizeof(str), "**[Admin]** %s(Discord) has banned %s from the server.", admin, NameToBan);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str), IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		format(str, sizeof(str), ""Server" "RED_E"%s(Discord) has banned %s from the server.", admin, NameToBan);
		SendClientMessageToAll(COLOR_GREY, str);
	}
	return true;
}

DCCMD:kick(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(message, "us[90]", otherid, tmp)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !kick [playerid] [reason]");
	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "**[Error]** Invalid Playerid (%d)", otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return 1;
	}
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);

	format(str, sizeof(str), "**[Admin]** %s(Discord) has kicked %s(%i) [Reason: %s]", giveplayer, pName[otherid], otherid, tmp);
	//DCC_SendChannelMessage(Channel_Staff, str);

	format(str, sizeof(str), "Administrator %s(Discord) has kicked %s(%i) "GREY2_E"[Reason: %s]", giveplayer, pName[otherid], otherid, tmp);
	SendClientMessageToAll(COLOR_RED, str);
	GameTextForPlayer(otherid, "~r~~h~Kicked!", 4000, 5);
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	KickEx(otherid);
	SetPVarInt(otherid, "pRemoved", 1);
	return true;
}

DCCMD:warn(DCC_Channel:channel, DCC_User:user, const message[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	if(!role || channel == Channel_Echo) return 1;
	if(sscanf(message, "us[90]", otherid, tmp)) return //DCC_SendChannelMessage(channel, "**[Usage]** !warn [playerid] [reason]");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(channel, "**[Error]** Player not connected!");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "**[Admin]** %s(Helper) has warned %s(%i) [Reason: %s]", giveplayer, pName[otherid], otherid, tmp);
	//DCC_SendChannelMessage(Channel_Staff, str);
	//DCC_SendChannelMessage(Channel_Helper, str);

	format(str, sizeof(str), "Administrator %s(Discord) has warned %s(%i) "GREY2_E"[Reason: %s]", giveplayer, pName[otherid], otherid, tmp);
	SendClientMessageToAll(COLOR_RED, str);
	SendClientMessage(otherid, COLOR_RED, ">> You have been warned by an administrator, read the /rules, too many warnings will result in a kick or ban!");
	PlayerPlaySound(otherid, 1186, 0.0, 0.0, 0.0);
	pWarns[otherid] ++;
	if(pWarns[otherid] >= 3)
	{
		format(str, sizeof(str), "**[Helper]** %s(%i) has been kicked for excessive warnings.", pName[otherid], otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		//DCC_SendChannelMessage(Channel_Helper, str);

		SetPlayerPosition(otherid, 405.1100,2474.0784,35.7369,360.0000);
		format(str, sizeof(str), ""RED_E""Server" "GREY_E"%s(%i) has been kicked for excessive warnings.", pName[otherid], otherid);
		SendClientMessageToAll(COLOR_WHITE, str);
		KickEx(otherid);
		return true;
	}

	return true;
}

DCCMD:getip(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !getip [playerid]");
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
	if(pAdmin[otherid] == 6) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** You can't use getip on the server owner!");
	format(str, 256, "**[Database]** %s(%i)'s IP: %s", pName[otherid], otherid, PlayerIP);
	//DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}

DCCMD:sethealth(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	new health;
	if(sscanf(params, "u", otherid, health)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !sethealth [playerid] [health]");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	if(health > 100 || health < 0)
	{
		format(str, sizeof(str), "**[Error]** %s, you have specified an invalid health amount (%d.0).", giveplayer, health);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return false;
	}
	if(health > 98) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** You can't set anyone's health over 98 due to the anti-cheat system.");
	SetPlayerHealth(otherid, health);
	format(str, sizeof(str), "**[Admin]** %s(Discord) set %s(%i)'s health to %d.", giveplayer, giveplayer, otherid, health);
	//DCC_SendChannelMessage(Channel_Staff, str);
	return 1;
}

DCCMD:ann(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	discord_announce(channel, user, params);
	return true;
}

DCCMD:announce(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(isnull(params)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !ann(ounce) [message]");
	if(strfind(params, "~x~", true) != -1) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** ~x~ is not allowed in announce.");
	if(strfind(params, "#k~", true) != -1) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** 2The constant key is not allowed in announce.");
	
	iTemp = 0;
	for(new i = (strlen(params)-1); i != -1; i--)
	{
		if(params[i] == '~')
			iTemp ++;
	}
	if(iTemp % 2 == 1) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** You either have an extra ~ or one is missing in the announcement!");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, 256, "**[Error]** %s(Discord) announced %s", giveplayer, params);
	//DCC_SendChannelMessage(Channel_Staff, str);

	format(str, sizeof(str), "~w~%s", params);
	GameTextForAll(str, 6500, 3);

	return true;
}

DCCMD:banip(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(isnull(params)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !banip [ip] ");
	if(strfind(params, "*", true) != -1) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** You are not authorized to ban ranges. ");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "**[Error]** %s has IP banned address %s.", giveplayer, params);
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), ""Server" "GREY2_E"%s(Discord) IP banned address %s.", giveplayer, params);
	SendClientMessageToAll(COLOR_GREY2, str);
	format(str, sizeof(str), "banip %s", params);
	SendRconCommand(str);
	return true;
}

DCCMD:unbanip(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(isnull(params)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !unbanip [ip]");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "**[Admin]** %s has IP un-banned address %s", giveplayer, params);
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "unbanip %s", params);
	SendRconCommand(str);
	format(str, sizeof(str), "reloadbans");
	SendRconCommand(str);

	return true;
}

DCCMD:unban(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "s[24]", tmp)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !unban <playername (3-21 chars)>");
	
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	new escaped_tmp[24];
	mysql_real_escape_string(tmp, escaped_tmp);
	format(query, sizeof(query), "SELECT * FROM bans WHERE user_banned = '%s'", escaped_tmp);
	MySQL_query(query, true, "OnDiscordUnbanData", "ss", giveplayer, escaped_tmp);
	return true;
}

function OnDiscordUnbanData(admin[], BannedName[])
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), "**[Error]** No player named '%s' found on the ban list.", BannedName);
		//DCC_SendChannelMessage(Channel_Staff, str);
	}
	else
	{
		new banIP[16];
		MySQL_getString(0, 1, banIP);
		format(query, sizeof(query), "DELETE FROM bans WHERE bIP = '%s'", banIP);
		MySQL_updateQuery(query);

		format(str, sizeof(str), "**[Admin]** %s(Discord) has unbanned %s from the server.", admin, BannedName);
		//DCC_SendChannelMessage(Channel_Staff, str);

		format(str, sizeof(str), ""Server" "GREY2_E"%s(Discord) has unbanned %s from the server.", admin, BannedName);
		SendClientMessageToAll(COLOR_GREY, str);
	}
	return true;
}

DCCMD:mute(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	
	if(!role) return 1;
	new timeSec, reason[80];
	if(sscanf(params, "udS[60]", otherid, timeSec, reason))
	{
		//DCC_SendChannelMessage(channel, "**[Usage]** !mute <ID/Name> <time in seconds> <reason>");
		return false;
	}
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(channel, "**[Error]** Player not connected!");
	if(strlen(reason) > 60) return //DCC_SendChannelMessage(channel, "**[Error]** Reason too long! Must be shorter than 60 characters!");

	if(timeSec < 10 || timeSec > 600) return //DCC_SendChannelMessage(channel, "**[Error]** The mute-time must remain between 10-600 seconds.");

	if(pMute[otherid] > 1)
	{
		format(str, sizeof(str), "**[Error]** %s(%i) is already muted (mute lifted in %d seconds)", pName[otherid], otherid, pMute[otherid]);
		//DCC_SendChannelMessage(channel, str);
		return 1;
	}

	pMute[otherid] = timeSec;

	if(!isnull(reason))
	{
		format(str, sizeof(str), "Admin/Helper %s(Discord) muted %s(%i) for %s (%d seconds)", giveplayer, pName[otherid], otherid, reason, timeSec);
		format(tmp, sizeof(tmp), "**[Helper]** %s(Discord) muted %s(%i) for %s (%d seconds).", giveplayer, pName[otherid], otherid, reason, timeSec);
	}
	else
	{
		format(str, sizeof(str), "Admin/Helper %s(Discord) muted %s(%i) (%d seconds)", giveplayer, pName[otherid], otherid, timeSec);
		format(tmp, sizeof(tmp), "**[Helper]** %s(Discord) muted %s(%i) (%d seconds).", giveplayer, pName[otherid], otherid, timeSec);
	}
	SendClientMessageToAll(COLOR_YELLOW, str);
	//DCC_SendChannelMessage(channel, tmp);

	return true;
}

DCCMD:unmute(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	
	if(!role) return 1;
	if(sscanf(params, "u", otherid))
	{
		//DCC_SendChannelMessage(channel, "**[Usage]** !unmute <ID/Name>");
		return false;
	}
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	if(otherid == INVALID_PLAYER_ID)
	{
		//DCC_SendChannelMessage(channel, "**[Error]** Player not connected!");
		return 1;
	}
	if(pMute[otherid] == 0)
	{
		format(str, sizeof(str), "**[Helper]** Player %s(%i) is not muted.", pName[otherid], otherid);
		//DCC_SendChannelMessage(channel, str);
		return 1;
	}

	format(str, sizeof(str), "**[Helper]** %s(Discord) has unmuted %s(%i).", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(channel, str);

	format(str, sizeof(str), ""Server" %s(Discord) has unmuted %s(%i).", giveplayer, pName[otherid], otherid);
	SendClientMessageToAll(COLOR_GREY, str);
	pMute[otherid] = 0;

	return true;
}

DCCMD:jail(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	
	if(!role) return 1;

	new reason[100], timeSec;
	if(sscanf(params, "udS[99]", otherid, timeSec, reason))
	{
		//DCC_SendChannelMessage(channel, "**[Usage]** !jail <ID/Name> <time in seconds> <reason>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		format(str, sizeof(str), "**[Error]** Invalid Player ID (%d).", otherid);
		//DCC_SendChannelMessage(channel, str);
		return 1;
	}

	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	if(pJail[otherid] > 0)
	{
		format(str, sizeof(str), "**[Error]** %s(%i) is already jailed (gets out in %d seconds)", pName[otherid], otherid, pJail[otherid]);
		//DCC_SendChannelMessage(channel, str);
		return true;
	}


	if(strlen(reason) > 60) return //DCC_SendChannelMessage(channel, "**[Error]** Reason too long! Must be shorter than 60 characters!");
	if(timeSec < 10 || timeSec > 600) return //DCC_SendChannelMessage(channel, "**[Error]** The mute-time must remain between 10-600 seconds.");

	if(InDuel[otherid] != 0)
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
		format(str, sizeof(str), ""RED_E"* Admin/Helper %s(Discord) jailed "GREY_E"%s(%i) "RED_E"for %d seconds.", giveplayer, pName[otherid], otherid, timeSec);
		format(tmp, sizeof(tmp), "**[Helper]** %s(Discord) jailed %s(%i) for %d seconds.", giveplayer, pName[otherid], otherid, timeSec);
	}
	else
	{
		format(str, sizeof(str), ""RED_E"* Helper/Admin %s(Discord) jailed %s(%i) for "GREY_E"%s "RED_E"(%d seconds)", giveplayer, pName[otherid], otherid, reason, timeSec);
		format(tmp, sizeof(tmp), "**[Helper]** %s(Discord) jailed %s(%i) for %s (%d seconds)", giveplayer, pName[otherid], otherid, reason, timeSec);
	}
	SendClientMessageToAll(COLOR_GREY, str);
	//DCC_SendChannelMessage(channel, tmp);
	return true;
}

DCCMD:unjail(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	
	if(!role) return 1;
	if(sscanf(params, "u", otherid))
	{
		//DCC_SendChannelMessage(Channel_Staff, "*[Usage]** !unjail <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		//DCC_SendChannelMessage(channel, "*[Error]** Player not connected!");
		return 1;
	}

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	if(pJail[otherid] == 0)
	{
		format(str, sizeof(str), "**[Error]** Player %s(%i) is not in jail.", pName[otherid], otherid);
		//DCC_SendChannelMessage(channel, str);
		return 1;
	}


	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	pJail[otherid] = 0;
	SetPlayerHealth(otherid, 100.0);
	SetPlayerInterior(otherid, 0);
	SetPlayerVirtualWorld(otherid, 0);
	SpawnPlayer(otherid);

	format(str, sizeof(str), "Helper/Admin %s(Discord) has unjailed %s(%i)", giveplayer, pName[otherid], otherid);
	SendClientMessageToAll(COLOR_GREY, str);

	format(str, sizeof(str), "**[Helper]** %s(Discord) has unjailed %s(%i)", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(channel, str);
	return true;
}


DCCMD:freeze(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "us[90]", otherid, tmp)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !freeze <playerid> <reason>");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
	if(Freezed[otherid]) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** This player is already frozen");
	
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "**[Admin]** %s(Discord) has frozen %s(%i) for: %s", giveplayer, pName[otherid], otherid, tmp);
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "* Administrator %s(Discord) has frozen %s(%i) for: %s", giveplayer, pName[otherid], otherid, tmp);
	SendClientMessageToAll(COLOR_GREY, str);
	TogglePlayerControllable(otherid, false);
	Freezed[otherid] = true;
	return true;
}

DCCMD:unfreeze(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !unfreeze <playerid>");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
	if(Freezed[otherid]) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** This player is not frozen");
	
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "**[Admin]** %s(Discord) has unfrozen %s(%i).", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "Administrator %s(Discord) has unfrozen %s(%i).", giveplayer, pName[otherid], otherid);
	SendClientMessageToAll(COLOR_GREY, str);
	TogglePlayerControllable(otherid, true);
	Freezed[otherid] = false;
	return true;
}


DCCMD:akill(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !akill <playerid>");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");

	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "**[Admin]** %s(Discord) has killed %s(%i).", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "* Administrator %s(Discord) has killed %s(%i).", giveplayer, pName[otherid], otherid);
	SendClientMessageToAll(COLOR_YELLOW, str);
	SetPlayerHealth(otherid, 0.0);
	return true;
}


DCCMD:stats(DCC_Channel:channel, DCC_User:user, const params[])
{
	if(sscanf(params, "r", otherid)) return //DCC_SendChannelMessage(channel, "**[Usage]** !stats [playerid]");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(channel, "**[Error]** Player not connected!");
	if(!pLogged[otherid] || pHidden[otherid] || pmhidden[otherid]) return //DCC_SendChannelMessage(channel, "**[Error]** This player is not registered!");

	format(str, sizeof(str), "**[Database::Name(Id)]** %s(%i)", pName[otherid], otherid);
	//DCC_SendChannelMessage(channel, str);
	format(str, sizeof(str), "%s is a %s", pName[otherid], GetPlayerAdminLevelName(otherid));
	//DCC_SendChannelMessage(channel, str);
	format(str, sizeof(str), "**[Database::RegDate]** Member since **%s**", pRegDate[otherid]);
	//DCC_SendChannelMessage(channel, str);
	format(str, sizeof(str), "**[Database::Time]** *Time online:* %d hours %d minutes %d seconds", pTotalHours[otherid], pTotalMinutes[otherid], pTotalSeconds[otherid]);
	//DCC_SendChannelMessage(channel, str);
	format(str, sizeof(str), "**[ChumLee::PlayerInfo]** *Kills:* %d *Deaths:* %d *KDR:* %0.2f *Money:* $%d *Score:* %d", pInfo[otherid][pKills], pInfo[otherid][pDeaths], Float:pInfo[otherid][pKills]/Float:pInfo[otherid][pDeaths], pCash[otherid], GetPlayerScore(otherid));
	//DCC_SendChannelMessage(channel, str);
	return true;
}

DCCMD:playerinfo(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !playerinfo [playerid]");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** Player not connected!");

	new 
		Float:pArmour,
		Float:pHealth
	;

	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	GetPlayerArmour(otherid, pArmour);
	GetPlayerHealth(otherid, pHealth);

	format(str, sizeof(str), "**[Database::Name(Id)]** %s(%i)", giveplayer, otherid);
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "**[Database::Level]** %s is a **%s**", pName[otherid], GetPlayerAdminLevelName(otherid));
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "**[Health/Armour]** %3.f/%3.f", pHealth, pArmour);
	//DCC_SendChannelMessage(Channel_Staff, str);
	
	if(IsPlayerInAnyVehicle(otherid))
	{
		new Float:vpHealth;
		vID = GetPlayerVehicleID(otherid);
		vv = GetVehicleModel(vID);

		GetVehicleHealth(GetPlayerVehicleID(otherid), vpHealth);
		format(str, sizeof(str), "**[ChumLee::Vehicle]** *Model:* %d | *Health:* %3.f", vehName[vv - 400], vID, vv, vpHealth);
		//DCC_SendChannelMessage(Channel_Staff, str);
	}

	format(str, sizeof(str), "**[Database::Time]** *Time online:* %d hours %d minutes %d seconds", pTotalHours[otherid], pTotalMinutes[otherid], pTotalSeconds[otherid]);
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "**[ChumLee::PlayerInfo]** *Kills:* %d | *Deaths:* %d | *Money:* $%d | *Interior:* %d", pInfo[otherid][pKills], pInfo[otherid][pDeaths], pCash[otherid], GetPlayerInterior(otherid));
	//DCC_SendChannelMessage(Channel_Staff, str);
	format(str, sizeof(str), "**[ChumLee::IP/Ping]** *IP address:* %s | *Ping:* %d", PlayerIP, GetPlayerPing(otherid));
	//DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}

DCCMD:explode(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !explode [playerid]");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "4Server:3 Player not connected!");
	
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "**[Admin]** %s(Discord) has exploded %s(%i).", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(Channel_Staff, str);
	
	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	CreateExplosion(POS[0], POS[1], POS[2], 7, 3.0);
	return true;
}

DCCMD:a(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(isnull(params)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !a <message>");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(line, sizeof(line), "**[Admin Chat]** %s(Discord): %s", giveplayer, params);
	//DCC_SendChannelMessage(Channel_Staff, line);
	format(line, sizeof(line), ""RED_E"[Admin Chat] "LG_E"%s(Discord): "LB_E"%s",giveplayer, params);
	SendAdminMessage(COLOR_LB, line);
	return true;
}

DCCMD:h(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	if(!role || channel != Channel_Helper) return 1;
	if(isnull(params)) return //DCC_SendChannelMessage(Channel_Helper, "**[Usage]** !h <message>");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(line, sizeof(line), "**[Helper Chat]** %s(Discord): %s", giveplayer, params);
	//DCC_SendChannelMessage(Channel_Helper, line);
	//DCC_SendChannelMessage(Channel_Staff, line);
	format(line, sizeof(line), ""SBLUE_E"[Helper Chat] "WHITEP_E"%s(Discord): "LB_E"%s", giveplayer, params);
	foreach(new i : Player) if(Helper[i] > 0) SendClientMessage(i, COLOR_LB, line);
	return true;
}

DCCMD:vip(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, vip_role, role);
	if(!role || channel != Channel_VIP) return 1;
	if(isnull(params)) return //DCC_SendChannelMessage(Channel_VIP, "**[Usage]** !vip <message>");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(line, sizeof(line), "**[Premium Chat]** %s(Discord): %s", giveplayer, params);
	//DCC_SendChannelMessage(Channel_Staff, line);
	//DCC_SendChannelMessage(Channel_VIP, line);
	format(line, sizeof(line), ""YELLOW_E"[Premium Chat] "SBLUE_E"%s(Discord): "WHITEP_E"%s", giveplayer, params);
	foreach(new i : Player) if(pPremium[i] > 0) SendClientMessage(i, COLOR_LB, line);
	return true;
}

DCCMD:startmb(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	//DCC_SendChannelMessage(Channel_Staff, "**[MoneyBag]** You have started a moneybag hunt!");
	EndMBHunt();
	return 1;
}

DCCMD:saveallstats(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	foreach(new ii : Player)
	{
		SavePlayerStats(ii);
	}
	//DCC_SendChannelMessage(Channel_Staff, "**[ChumLee::Database]** All server player stats have been saved!");
	GameTextForAll("~b~~h~Server Restarting~w~!", 6500, 3);
	for(new l; l < 4; l++) SendClientMessageToAll(COLOR_GREY2, "\n");
	SendClientMessageToAll(COLOR_LB, ""RED_E"*** "LB2_E"Server Is Restarting, reconnect if you get disconnected!");
	SendClientMessageToAll(COLOR_LB, ""RED_E"*** "LB2_E"Please re-join the server if you get a ban message upon connection!");
	return true;
}

DCCMD:gmx(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	SetTimer("RestartServer", 10*1000, true);
	format(str, sizeof(str), "**[Restart]** The server is restarting the server in 10 seconds!");
	//DCC_SendChannelMessage(Channel_Staff, str);
	//DCC_SendChannelMessage(Channel_Echo, str);
	//DCC_SendChannelMessage(Channel_Helper, str);
	//DCC_SendChannelMessage(Channel_VIP, str);

	format(str, sizeof(str), ""Server" "GREY2_E"Server restarting in 10 seconds, /savestats to save your data!");
	SendClientMessageToAll(COLOR_RED, str);
	return true;
}

DCCMD:spectators(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	new speccers;
	foreach(new ii : Player)
	{
		if(pAdmin[ii] == 0) continue;
		if(pSpectating[ii] != -1)
		{
			speccers = speccers + 1;
		}
	}

	if(speccers == 0) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** There aren't any spectators!");

	format(str, sizeof(str), "**[ChumLee::Spectators]** Displaying a list of %d admin(s)/VIP(s) spectating:", speccers);
	//DCC_SendChannelMessage(Channel_Staff, str);

	speccers = 0;
	foreach(new ii : Player)
	{
		if(pSpectating[ii] != -1)
		{
			speccers = speccers + 1;
			GetPlayerName(pSpectating[ii], giveplayer, sizeof(giveplayer));
			format(str, sizeof(str), "**[Results]** %d. %s(%i) spectating %s(%i).", speccers, pName[ii], ii, giveplayer, pSpectating[ii]);
			//DCC_SendChannelMessage(Channel_Staff, str);
		}
	}
	return true;
}
DCCMD:caps(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !caps <playerid>");

	if(otherid == INVALID_PLAYER_ID)
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
		return 1;
	}
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	if(!GetPVarType(otherid, "Caps"))
	{
		//Disable Caps
		SetPVarInt(otherid, "Caps", 1);
		format(str, sizeof(str), ""Server" "RED_E"Administrator %s(Discord) has disabled your caps in chat.", giveplayer);
		SendClientMessage(otherid, COLOR_GREY, str);
		format(str, sizeof(str), "* "GREY2_E"Administrator %s(Discord) has disabled %s(%i) caps in chat.", giveplayer, pName[otherid], otherid);
		SendClientMessageToAll(COLOR_RED, str);
		format(str, sizeof(str), "**[Admin]** %s(Discord) has disabled %s(%i) caps in chat.", giveplayer, pName[otherid], otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		//DCC_SendChannelMessage(Channel_Echo, str);
	}
	else
	{
		//Enable Caps
		DeletePVar(otherid, "Caps");
		format(str, sizeof(str), ""Server" "GREY2_E"Administrator %s(Discord) has enabled your caps in chat. Do not constantly use it.", giveplayer);
		SendClientMessage(otherid, COLOR_GREY, str);
		format(str, sizeof(str), "**[Admin]** %s(%i) has enabled %s(%i) caps in chat.", giveplayer, pName[otherid], otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		//DCC_SendChannelMessage(Channel_Echo, str);
	}
	return true;
}

DCCMD:pweaps(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if (sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !pweaps <playerid>");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");

	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "**[ChumLee::Weapons]** Showing a list of %s(%i)'s weapons:", giveplayer, otherid);
	//DCC_SendChannelMessage(Channel_Staff, str);

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

		format(tmp, sizeof(tmp), "%s(%s)%s", str, weapon_ammo_str, (i != 11 ? (", ") : ("")));
		strcat(line, tmp);

		if(weapons_processed == 4)
		{
			//DCC_SendChannelMessage(Channel_Staff, line);
			weapons_processed = 0, line[0] = EOS;
		}
	}

	if(weapons_total == 0)
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Error]** This player has no weapons!");
	}
	else if(1 <= weapons_processed <= 4)
	{
		//DCC_SendChannelMessage(Channel_Staff, line);
	}

	#undef weapons_total
	#undef weapons_processed
	#undef weapon_id
	#undef weapon_ammo_raw
	#undef weapon_ammo_str
	return true;
}

DCCMD:amsg(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if (sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !asay <message>");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), ""RED_E"* "YELLOW_E"Administrator %s on Discord: "WHITEP_E"%s", giveplayer, params);
	SendClientMessageToAll(COLOR_RED, str);

	format(str, sizeof(str), "**[Admin]** (%s): %s", giveplayer, params);
	//DCC_SendChannelMessage(Channel_Staff, str);

	return true;
}

DCCMD:loadrace(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	if(RaceActive == 1) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** A race is already active");
	if(isnull(params)) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** !loadrace <racename>");
	format(str, sizeof(str), params);
	if(!LoadRace(str))
	{
		format(str, sizeof(str), "**[Error]** Race %s is invalid!", params);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return true;
	}

	format(str, sizeof(str), "**[Error]** Race %s is starting..", params);
	//DCC_SendChannelMessage(Channel_Staff, str);

	RaceActive = 1;
	SetTimer("startrace", 1000, false);
	return true;
}

DCCMD:startrace(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	if(LCurrentCheckpoint == 0) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** No race loaded, use !loadrace.");
	if(RaceActive == 1)
	{
		if(RaceStart == 1)
		{
			format(str, sizeof(str), "**[Error]** Race %s is already active!", CRaceName);
			//DCC_SendChannelMessage(Channel_Staff, str);
		}
		else
		{
			DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
			format(str, sizeof(str), ""ORANGE_E"* Administrator"YELLOW_E" %s(Discord) "ORANGE_E"has started the race "LB_E"'%s'!", giveplayer, CRaceName);
			SendClientMessageToAll(COLOR_GREY, str);
			format(str, sizeof(str), "**[Admin]** %s has started the race '%s'", giveplayer, CRaceName);
			//DCC_SendChannelMessage(Channel_Staff, str);
			mscd = 6;
		}
	}
	return 1;
}

DCCMD:endrace(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	if(RaceActive== 0) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** No race active!");
	if(cd > 0) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Main countdown in progress, can't end race now!");
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), ""ORANGE_E"* Administrator"YELLOW_E" %s(Discord) "ORANGE_E"has ended the race.", giveplayer);
	SendClientMessageToAll(COLOR_GREY, str);

	format(str, sizeof(str), "**[Admin]** %s(Discord) has ended the race.", giveplayer);
	//DCC_SendChannelMessage(Channel_Staff, str);

	endrace();
	return 1;
}

DCCMD:day(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	SetWorldTime(12);	
	format(str, sizeof(str), ""LB_E"Administrator "YELLOW_E"%s(Discord) "LB_E"has changed the time to day.", giveplayer);
	SendClientMessageToAll(COLOR_GREY, str);

	format(str, sizeof(str), "**[Admin]** %s(Discord) has changed the time to day.", giveplayer);
	//DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}

DCCMD:night(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	SetWorldTime(2);
	format(str, sizeof(str), ""LB_E"Administrator "YELLOW_E"%s(Discord) "LB_E"has changed the time to night.", giveplayer);
	SendClientMessageToAll(COLOR_GREY, str);

	format(str, sizeof(str), "**[Admin]** %s(Discord) has changed the time to night.", giveplayer);
	//DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}

DCCMD:respawnvehicles(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

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
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"Administrator %s(Discord) has respawned all unoccupied vehicles.", giveplayer);
	SendClientMessageToAll(COLOR_RED, str);
	format(tmp, sizeof(tmp), "**[Admin]** %s(Discord) has respawned all unoccupied vehicles.", giveplayer);
	//DCC_SendChannelMessage(Channel_Staff, tmp);
	return true;
}

DCCMD:cc(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	for(new ii = 0; ii < 100; ii++)
	{
		SendClientMessageToAll(COLOR_SYSTEM, " ");
		GameTextForAll("~p~Chat cleared!", 1000, 1);
	}
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(str, sizeof(str), "Administrator %s(Discord) has cleared the chat!", giveplayer);
	SendClientMessageToAll(COLOR_GREY, str);
	format(str, sizeof(str), "**[Admin]** %s(Discord) cleared the chat", giveplayer);
	//DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}

DCCMD:aka(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;
	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !aka <playerid>");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not connected!");
	if(pAdmin[otherid] == 6)
	{
		DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
		//DCC_SendChannelMessage(Channel_Staff, "**[Error]** You can't AKA the server owner.");
		format(str, 90, "*** "RED_E"%s(Discord) tried to AKA you!", giveplayer);
		SendClientMessage(otherid, COLOR_YELLOW, str);
		return 1;
	}
	GetPlayerIp(otherid, PlayerIP, sizeof(PlayerIP));
	format(query, sizeof(query), "SELECT name FROM players WHERE IP='%s'", PlayerIP);
	MySQL_query(query, true, "CheckPlayerIP_Discord", "s", PlayerIP);
	return true;
}

DCCMD:setpassword(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	new cname[24];
	if(sscanf(params, "s[21]s[20]", cname, tmp))
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Discord]** !setpassword <name> <new password>");
		return true;
	}

	format(query, sizeof(query), "SELECT pass FROM players WHERE name='%s'", cname);
	MySQL_query(query, true, "ChangePlayerPassword_Discord", "ss", cname, tmp);
	return true;
}


// SetPassword Callback
function ChangePlayerPassword_Discord(cPlayer[], newpass[])
{
	if(MySQL_rowCount())
	{
		format(str, sizeof(str), "**[Password]** Password for %s has been set to '%s'", cPlayer, newpass);
		//DCC_SendChannelMessage(Channel_Staff, str);
		format(query, sizeof(query), "UPDATE players SET pass=SHA1('%s') WHERE name='%s'", newpass, cPlayer);
		MySQL_updateQuery(query);
	}
	else
	{
		// Name Exists
		format(str, sizeof(str), "**[Error]** The name '%s' doesn't exist in the database!", cPlayer);
		//DCC_SendChannelMessage(Channel_Staff, str);
	}
	return true;
}

function CheckPlayerIP_Discord(zplayerIP[])
{
	new rows = MySQL_rowCount();
	if(!rows)
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Admin]** No accounts exist with this IP!");
	}
	else
	{
		format(tmp, sizeof(tmp), "**[Progress]** Names matching IP: %s:", zplayerIP);
		//DCC_SendChannelMessage(Channel_Staff, tmp);
		for(new i = 0; i != rows; i++)
		{
			// Get the name from the cache and append it
			MySQL_getString(i, 0, str);
			format(line, sizeof(line), "**[Results]** %s", str);
			//DCC_SendChannelMessage(Channel_Staff, line);
		}
	}
	return 1;
}
DCCMD:akaip(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	if(isnull(params))
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !akaip <ip>");
		return false;
	}

	format(query, sizeof(query), "SELECT name FROM players WHERE IP='%s'", params);
	MySQL_query(query, true, "CheckPlayerIP2_Discord", "s", params);
	return true;
}

function CheckPlayerIP2_Discord(zplayerIP[])
{
	new rows = MySQL_rowCount();
	if(!rows)
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Admin]** No accounts exist with this IP!");
	}
	else
	{
		format(tmp, sizeof(tmp), "**[Progress]** Names matching IP: %s:", zplayerIP);
		//DCC_SendChannelMessage(Channel_Staff, tmp);
		for(new i = 0; i != rows; i++)
		{
			// Get the name from the cache and append it
			MySQL_getString(i, 0, str);
			format(line, sizeof(line), "**[Results]** %s", str);
			//DCC_SendChannelMessage(Channel_Staff, line);
		}
	}
	return 1;
}
DCCMD:check(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, staff_role, role);
	if(!role || channel != Channel_Staff) return 1;

	new count = 0;
	//DCC_SendChannelMessage(Channel_Staff, "**[Anti-Cheat]** Possible hacker's:");
	foreach(new ii : Player)
	{
		if(pAdmin[ii] == 0 && pPremium[ii] == 0 && InDM[ii] == 0 && InEvent[ii] == 0 && GetPVarInt(ii, "PurchasedWeapons") == 0)
		{
			new w = GetPlayerWeapon(ii);
			new Float:armour;
			GetPlayerArmour(ii, armour);
			if (armour > 1 || w==16 || w==18 || w==35 || w==36 || w==37 || w==38 || w==39 || w==44 || w==45)
			{
				format(str, sizeof(str), "**[Results]** Name: %s, ID: %d", pName[ii], ii);
				//DCC_SendChannelMessage(Channel_Staff,  str);
				count++;
			}
		}
	}
	if (count == 0) //DCC_SendChannelMessage(Channel_Staff, "**[Anti-Cheat]** found no possible hackers in the server.");
	return 1;
}

DCCMD:forcerespawn(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	if(!role || channel == Channel_Echo) return 1;

	if(sscanf(params, "u", otherid)) return //DCC_SendChannelMessage(channel, "**[Usage]** /forcerespawn <playerid>");
	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(channel, "**[Error]** Player not connected!");
	if(RaceParticipant[otherid] == 3 && RaceStart == 1) return //DCC_SendChannelMessage(channel, "**[Error]** You can't spawn this player. (Race Count down in progress)");
	if(RaceParticipant[otherid] || InDM[otherid] != 0 || doingStunt[otherid] != 0) cmd_leave(otherid);
	SpawnPlayer(otherid);

	format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"%s(%i) has been respawned by a %s.", pName[otherid], otherid, giveplayer);
		
	SendClientMessageToAll(-1, str);
	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	format(str, sizeof(str), "**[Helper]** %s(%i) has respawned %s(%i).", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(Channel_Helper, str);
	//DCC_SendChannelMessage(Channel_Staff, str);

	SendClientMessage(otherid, -1, "You have been forced to respawn.");
	return 1;
}

DCCMD:slap(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, helper_role, role);
	if(!role || channel == Channel_Echo) return 1;

	if(sscanf(params, "u", otherid))
	{
		//DCC_SendChannelMessage(channel, "**[Usage]** !slap <ID/Name>");
		return false;
	}

	if(otherid == INVALID_PLAYER_ID) return //DCC_SendChannelMessage(channel, "**[Error]** Player not connected!");

	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	SetPlayerPos(otherid, POS[0], POS[1], POS[2] + 10);
	format(str, sizeof(str), "**[Helper]** %s(Discord) slapped %s(%i).", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(Channel_Helper, str);
	//DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}

DCCMD:setname(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user,head_role, role);
	if(!role || channel != Channel_Echo) return 1;

	if(sscanf(params, "is[20]", otherid, tmp)) return //DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !setname <playerid> <newname>");
	if(pLogged[otherid] == false) return //DCC_SendChannelMessage(Channel_Staff, "**[Error]** Player not logged in!");

	if(!IsPlayerConnected(otherid))
	{
		format(str, sizeof(str), "**[Error]** Invalid PlayerID (%d)", otherid);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return 1;
	}
	if(strlen(tmp) > 20)
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Error]** New name can't be longer than 20 characters!");
		return true;
	}
	GetPlayerName(otherid, giveplayer, sizeof(giveplayer));
	if(!IsValidPassword(tmp))
	{
		format(str, sizeof(str), "**[Error]** %s(%i)'s name has not been changed to \"%s\". Please doublecheck the name!", giveplayer, otherid, tmp);
		//DCC_SendChannelMessage(Channel_Staff, str);
		return true;
	}

	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));
	format(query, sizeof(query), "SELECT name FROM players WHERE name='%s'", tmp);
	MySQL_query(query, true, "ChangePlayerName_Discord", "iss", otherid, giveplayer, tmp);
	return true;
}
forward ChangePlayerName_Discord(otherplayer, ircAdmin[], nname[]);
public ChangePlayerName_Discord(otherplayer, ircAdmin[], nname[])
{
	if(!MySQL_rowCount())
	{
		//Good
		new oldname[24], newname[24];
		GetPlayerName(otherplayer, oldname, sizeof(oldname));
		format(query, sizeof(query), "UPDATE players SET name='%s' WHERE reg_id=%d", nname, pRegID[otherplayer]);
		MySQL_updateQuery(query);
		format(str, sizeof(str), ""Server" "LB2_E"%s(Discord) has changed your name to '%s'", ircAdmin, nname);
		SendClientMessage(otherplayer, COLOR_LB, str);
		Info(otherplayer, "Make sure you log in with this new name on every connect!");
		format(str, sizeof(str), "**[Admin]** %s(Discord) has changed %s's name to '%s'", ircAdmin, oldname, nname);
		//DCC_SendChannelMessage(Channel_Staff, str);
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
		if(pGroupRank[otherplayer] == 7)
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
		format(str, sizeof(str), "**[Error]** The name '%s' already exists in the database, please use a different name!", nname);
		//DCC_SendChannelMessage(Channel_Staff, str);
	}
	return true;
}

DCCMD:crash(DCC_Channel:channel, DCC_User:user, const params[])
{
	new bool:role;
	DCC_HasGuildMemberRole(staff_guild, user, head_role, role);
	if(!role || channel != Channel_Echo) return 1;
	if(sscanf(params, "u", otherid))
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Usage]** !crash <playerid>");
		return true;
	}

	if(otherid == INVALID_PLAYER_ID)
	{
		//DCC_SendChannelMessage(Channel_Staff, "**[Usage]** Player not connected!");
		return 1;
	}

	DCC_GetUserName(user, giveplayer, sizeof(giveplayer));

	SetPVarInt(otherid, "pBugged", 1);
	new IP[24];
	GetPlayerIp(otherid, IP,sizeof(IP));
	format(IP,sizeof(IP), "banip %s", IP);
	SendRconCommand(IP);

	format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"Administrator %s(Discord) has crashed %s(%i)", giveplayer, pName[otherid], otherid);
	SendClientMessageToAll(COLOR_RED, str);

	format(str, sizeof(str), "**[Admin]** %s(Discord) has crashed %s(%i)", giveplayer, pName[otherid], otherid);
	//DCC_SendChannelMessage(Channel_Staff, str);
	return true;
}
*/

// Discord
/*new
	DCC_Channel:Channel_Echo,
	DCC_Channel:Channel_Staff
;

#define DCCMD:%1(%2) 				forward discord_%1(%2); public discord_%1(%2)

// anywhere
public DCC_OnChannelMessage(DCC_Channel:channel, DCC_User:author, const message[])
{
	if (message[0] == '!')
	{
		new functiona[32], posi = 0;
		while (message[++posi] > ' ') 
		{
			functiona[posi - 1] = tolower(message[posi]);
		}
		format(functiona, sizeof(functiona), "discord_%s", functiona);
		while(message[posi] == ' ') 
		{
			posi++;
		}
		if (!message[posi]) 
		{
			CallLocalFunction(functiona, "dds", _: channel, _: author, "\1");
		}
		else
		{
			CallLocalFunction(functiona, "dds", _: channel, _: author, message[posi]);
		}
	}
	return 1;
}*/