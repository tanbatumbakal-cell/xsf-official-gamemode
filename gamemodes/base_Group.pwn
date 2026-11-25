// Server Group System

SendGroupMessage(playerid, message[])
{
	foreach(new ii : Player)
	{
		if(pGroupID[ii] == pGroupID[playerid])
		{
			format(query, sizeof(query), "%s", message);
			SendClientMessage(ii, -1, query);
		}
	}
}

CMD:gcmds(playerid) return cmd_groupcmds(playerid);
CMD:groupcmds(playerid)
{
	new gStr[1500];
	strcat(gStr, ""GREY_E"Group Commands:\n\n");
	strcat(gStr, ""YELLOW_E"/gcreate\t\t"RED_E"» "WHITE_E"Create your group.\n");
	strcat(gStr, ""YELLOW_E"/ginvite\t\t"RED_E"» "WHITE_E"Invite a player to your group.\n");
	strcat(gStr, ""YELLOW_E"/gdisband\t\t"RED_E"» "WHITE_E"Close/Disband your group.\n");
	strcat(gStr, ""YELLOW_E"/gmembers\t\t"RED_E"» "WHITE_E"View the group member list.\n");
	strcat(gStr, ""YELLOW_E"/gname\t\t"RED_E"» "WHITE_E"Change your group name.\n");
	strcat(gStr, ""YELLOW_E"/g or !<text>\t\t"RED_E"» "WHITE_E"Talk in group chat.\n");
	strcat(gStr, ""YELLOW_E"/gleave\t\t\t"RED_E"» "WHITE_E"Leave the group you're in.\n");
	strcat(gStr, ""YELLOW_E"/gset\t\t\t"RED_E"» "WHITE_E"Set the rank of a group member. (Co-Leaders+)\n");
	strcat(gStr, ""YELLOW_E"/ogset\t\t\t"RED_E"» "WHITE_E"Set the rank of a group offline member . (Co-Leaders+)\n");
	strcat(gStr, ""YELLOW_E"/gkick\t\t\t"RED_E"» "WHITE_E"Kick a player from your group (Leaders+)\n");
	strcat(gStr, ""YELLOW_E"/ogkick\t\t"RED_E"» "WHITE_E"Kick an offline player from your group (Leaders+)\n");
	strcat(gStr, ""YELLOW_E"/gaccept\t\t"RED_E"» "WHITE_E"Accept a group invitation.\n");
	strcat(gStr, ""YELLOW_E"/gdeny\t\t\t"RED_E"» "WHITE_E"Deny a group invitation.\n");
	strcat(gStr, ""YELLOW_E"/ginfo\t\t\t"RED_E"» "WHITE_E"View the group information.\n");
	strcat(gStr, ""YELLOW_E"/groups\t\t"RED_E"» "WHITE_E"View a list of groups online.\n");
	strcat(gStr, ""YELLOW_E"/groupwar\t\t"RED_E"» "WHITE_E"Invite a specific group to war.\n");
	strcat(gStr, ""YELLOW_E"/acceptwar\t\t"RED_E"» "WHITE_E"Accept a war invitation.\n");
	strcat(gStr, ""YELLOW_E"/gspawn\t\t"RED_E"» "WHITE_E"Change the spawn of your group to your current position.\n");
	strcat(gStr, ""YELLOW_E"/topgroups\t\t"RED_E"» "WHITE_E"List of groups with the highest scores.\n");
	strcat(gStr, ""YELLOW_E"/gtag\t\t"RED_E"» "WHITE_E"Change your group tag.\n");
	strcat(gStr, ""YELLOW_E"/grankname\t\t"RED_E"» "WHITE_E"Change your name of the Group Ranks\n");
	strcat(gStr, ""YELLOW_E"/gdeltag\t\t"RED_E"» "WHITE_E"Removes your current group tag\n");
	ShowPlayerDialog(playerid, NO_DIALOG, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Server: "WHITE_E"Group Commands", gStr, "OK", "");
	return true;
}

CMD:creategroup(playerid) return cmd_groupcreate(playerid);
CMD:gangcreate(playerid) return cmd_groupcreate(playerid);
CMD:gcreate(playerid) return cmd_groupcreate(playerid);
CMD:groupcreate(playerid)
{
	if(pGroupID[playerid] != -1) return Error(playerid, "You are already in a group!");
	new gStr[650];
	strcat(gStr, ""WHITE_E"Enter your desired group name below.\nOnce you create the group you can access all Group Commands (/gcmds).\n\n"RED_E"Please note:\n"dot"You must have at least 24 hours of online time to create a group.");
	strcat(gStr, "\n"dot"The cost to create a group is "GREEN_E"$"WHITE_E"5,000,000\n"dot"Your gang name cannot contain any invalid characters including space.\n\nEnter group name:");
	ShowPlayerDialog(playerid, GROUP_DIALOG, DIALOG_STYLE_INPUT, ""ORANGE_E"Server: "WHITE_E"Create Group", gStr, "Enter", "Exit");
	return true;
}
CMD:gmembers(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	
	format(query, sizeof(query), "SELECT name,group_rank FROM players WHERE group_id=%d ORDER BY group_rank DESC LIMIT 100;", pGroupID[playerid]);
	MySQL_query(query, true, "ShowGroupMembers", "i", playerid);
	return true;
}
CMD:ginfo(playerid)
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	
	format(query, sizeof(query), "SELECT gName,gScore,gDate,gFounder FROM groups WHERE gID = %d", pGroupID[playerid]);
	MySQL_query(query, true, "ShowGroupInfo", "i", playerid);
	return true;
}
CMD:gname(playerid)
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] != 6) return Error(playerid, "You must be the group leader to change the group name!");
	new gStr[650];
	strcat(gStr, ""WHITE_E"Enter the new name of your group\n\n"dot"You must have at least 1000 score to change the group name.\n"dot"The cost to change your group name is "GREEN_E"$"WHITE_E"3,000,000");
	strcat(gStr, "\n"dot"You are limited to group name changes, choose wisely.\n\nEnter group name:");

	ShowPlayerDialog(playerid, GROUP_DIALOG+1, DIALOG_STYLE_INPUT, ""WHITE_E"Change group name", gStr, "Enter", "Exit");
	return true;
}
function ShowGroupInfo(playerid)
{
	if(MySQL_rowCount())
	{
		new gangname[24],
			founder[24],
			score,
			udate,
			udatestr[40],
			count = 0,
			members[1536],
			string[2048];
			
		cache_get_row(0, 0, gangname);
		score = cache_get_row_int(0, 1);
		udate = cache_get_row_int(0, 2);
		cache_get_row(0, 3, founder);
		

		localtime(udate, tmParam);
		strftime(udatestr, sizeof(udatestr), "%d/%m/%Y %H:%M", tmParam);
		foreach(new ii : Player)
		{
			if(pGroupID[ii] == pGroupID[playerid])
			{
				if(count <= 20)
				{
					format(tmp, sizeof(tmp), "\n{%06x}%s(%i)", pColor[ii], pName[ii], ii);
					strcat(members, tmp);
				}
				count++;
			}
			if(count > 20)
			{
				format(string, sizeof(string), ""WHITE_E"%s (Group ID: %d)\n\n"LB2_E"Group Name:\t\t"WHITE_E"%s\n"LB2_E"Group Founder:\t"WHITE_E"%s\n"LB2_E"Date Created:\t\t"WHITE_E"%s\n"LB2_E"Group Score:\t\t"WHITE_E"%d\n"LB2_E"Members Online:\t"WHITE_E"%i\n\n"LB2_E"Members Online:%s\n"WHITE_E".. more than 20 group members online.", gangname, pGroupID[playerid], gangname, founder, udatestr, score, count, members);
			}
			else
			{
				format(string, sizeof(string), ""WHITE_E"%s (Group ID: %d)\n\n"LB2_E"Group Name:\t\t"WHITE_E"%s\n"LB2_E"Group Founder:\t"WHITE_E"%s\n"LB2_E"Date Created:\t\t"WHITE_E"%s\n"LB2_E"Group Score:\t\t"WHITE_E"%d\n"LB2_E"Members Online:\t"WHITE_E"%i\n\n"WHITE_E"Members Online:%s", gangname, pGroupID[playerid], gangname, founder, udatestr, score, count, members);
			}

			new tmpstr[60];
			format(tmpstr, sizeof(tmpstr), ""WHITE_E"%s - Group Info", pGroupName[playerid]);
			ShowPlayerDialog(playerid, NO_DIALOG, DIALOG_STYLE_MSGBOX, tmpstr, string, "OK", "");
		}
	}
}

/*stock GetGroupElements(string_to_fill[],page=1,&left=0,&inserted=0,amount=50,&invalid_owner=0,maxstrsize=sizeof(string_to_fill))
{
	string_to_fill[0] = 0;
	string_to_fill[1] = 0;

	new houses = 0;
	new curr = 0;
	new from = (page-1)*amount;
	new to = from+amount;

	left = 0;
	inserted = 0;
	invalid_owner = 0;

	for(new i = 0; i < rows; i++)
	{
		new result[MAX_PLAYER_NAME],
		rank = 0;

		cache_get_row(i, 0, result);
		rank = cache_get_row_int(i, 1);

		format(tmp, sizeof(tmp), "\n%i. %s (%s)", count + 1, result, GangPositions[rank][E_gang_pos_name]);
		strcat(tmpstring, tmp);
		count++;
	}


	//loop all houses
	houses = 0;
	foreach(Houses, i)
	{
		if(!strcmp(hInfo[i][HouseOwner], INVALID_HOWNER_NAME, CASE_SENSETIVE) && i != 0)
		{
			//check if we want to list this house
			houses++;
			if(curr >= from && curr < to)
			{
				format(str, sizeof(str), " "WHITE_E"%d) "WHITEP_E"House ID: %d "GREY_E"(Location: %s) (Price: "GREEN_E"$%s"GREY_E")\n", houses, i, GetHouseLocation(i), ToCurrency(hInfo[i][HouseValue]));
				strcat(string_to_fill,str,maxstrsize);
				++inserted;
			}
			else if(curr >= to)
			{
				//if not make sure we know there are houses left to list
				++left;
			}
			//and skip unneeded houses but make sure to keep track
			++curr;
		}
		else
		{
		   ++invalid_owner;
		}
	}
	return 1;
}*/

function ShowGroupMembers(playerid)
{
	new rows = MySQL_rowCount();
	if(rows)
	{
		new tmpstring[2700],
			count = 0,
			finstring[3000];
		
		for(new i = 0; i < rows; i++)
		{
			new result[MAX_PLAYER_NAME],
				rank = 0;

			cache_get_row(i, 0, result);
			rank = cache_get_row_int(i, 1);

			format(tmp, sizeof(tmp), "\n%i. %s (%s)", count + 1, result, GetGroupRank(pGroupID[playerid],rank));
			strcat(tmpstring, tmp);
			count++;
		}
		
		format(finstring, sizeof(finstring), ""WHITE_E"There are "LB_E"%i"WHITE_E" members in this group.\n"GREY_E"Group Members:"WHITE_E"", count);
		strcat(finstring, tmpstring);
		ShowPlayerDialog(playerid, NO_DIALOG, DIALOG_STYLE_LIST, ""WHITEP_E"Group Members", finstring, "OK", "");
	}
}

CMD:gspawn(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You must be in a group to use this command!");
	if(pGroupRank[playerid] < 5) return Error(playerid, "You must be at least a co-leader to use this command.");
	
	new Float:TripPos[3];
	GetPlayerPos(playerid, TripPos[0], TripPos[1], TripPos[2]);
	
	ChangeSpawnPos(pGroupID[playerid], TripPos[0], TripPos[1], TripPos[2]);
	return 1;
}

function ChangeSpawnPos(groupid, Float:x, Float:y, Float:z)
{
	format(query, sizeof query, "UPDATE players SET `gSpawnX`='%f', `gSpawnY`='%f', `gSpawnZ`='%f' WHERE `group_id`='%d'", x, y, z, groupid);
	MySQL_updateQuery(query);
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
	    	if(pGroupID[i] == groupid)
	    	{
     			gSpawnPos[i][0] = x;
     			gSpawnPos[i][1] = y;
     			gSpawnPos[i][2] = z;

				SendClientMessage(i, -1, "{FF0000}[GROUP] {FFFFFF}Group spawn position has been updated.");
			}
		}
	}
	return 1;
}

function CreateGroup(playerid, gname[])
{
	pGroupID[playerid] = cache_insert_id();
	pGroupRank[playerid] = 6; // Leader
	
	GivePlayerCash(playerid, -5000000);
	
	format(query, sizeof(query), "UPDATE players SET group_id=%d,group_rank=%d WHERE reg_id=%d", pGroupID[playerid], pGroupRank[playerid], pRegID[playerid]);
	MySQL_updateQuery(query);

	format(str, sizeof(str), ""GROUP" "LB_E"%s(%d) has created the group '%s'", pName[playerid], playerid, pGroupName[playerid]);
	SendClientMessageToAll(COLOR_WHITEP, str);
	Info(playerid, "You have created your group, -$5,000,000 has been deducted from your cash.");
	
	format(str, sizeof(str), "4Server:3 %s(%i) has created the group '%s'!", pName[playerid], playerid, pGroupName[playerid]);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);

	ShowPlayerDialog(playerid, NO_DIALOG, DIALOG_STYLE_MSGBOX, ""GREEN_E"Group Created!", ""WHITE_E"You have successfully created your group.\n\n"dot"You can now use all commands in /gcmds.\n"dot"Invite players to your group using /ginvite.\n\
	"dot"You can earn group score by killing players in DMs!\n\nGood luck with your new group!", "OK", "");
}

function MySQL_GroupExist(playerid, gname[])
{
	if(!MySQL_rowCount())
	{
		mysql_format(g_SQL_handle, query, sizeof(query), "INSERT INTO groups(gName,gFounder,gDate) VALUES('%e','%e',UNIX_TIMESTAMP())", pGroupName[playerid], pName[playerid]);
		MySQL_query(query, false, "CreateGroup", "is", playerid, pGroupName[playerid]);
	}
	else
	{
		Error(playerid, "This group name already exists, choose another!");
		cmd_gcreate(playerid);
	}
	return 1;
}

function MySQL_GroupExist2(playerid, gname[])
{
	if(!MySQL_rowCount())
	{
		mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE groups SET gName='%e' WHERE gID=%d", pGroupName[playerid], pGroupID[playerid]);
		MySQL_updateQuery(query);

		GivePlayerCash(playerid, -3000000);
		format(str, sizeof(str), ""GROUP" Group leader %s(%i) has changed the group name to '%s'", pName[playerid], playerid, pGroupName[playerid]);
		foreach(new ii : Player)
		{
			if(pGroupID[ii] == pGroupID[playerid])
			{
				pGroupName[ii] = pGroupName[playerid];
				SendClientMessage(ii, COLOR_LB, str);
			}
		}
		format(str, sizeof(str), "4Server:3 %s(%i) has changed his group name to '%s'!", pName[playerid], playerid, pGroupName[playerid]);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, str);
	}
	else
	{
		Error(playerid, "This group name already exists, choose another!");
		cmd_gname(playerid);
	}
	return 1;
}

MySQL_LoadPlayerGroup(playerid)
{
	format(query, sizeof(query), "SELECT gname,gcolor FROM groups WHERE gID=%d", pGroupID[playerid]);
	MySQL_query(query, true, "LoadPlayerGroup", "i", playerid);
}

function LoadPlayerGroup(playerid)
{
	if(MySQL_rowCount())
	{
		cache_get_row(0, 0, pGroupName[playerid]);
		new tempgcol = cache_get_row_int(0, 1);
		if(tempgcol != -1)
			pGroupColor[playerid] = StripAlpha(tempgcol);
		else
			pGroupColor[playerid] = tempgcol;
	}
}

UpdateGroupScore(gGroupID, value)
{
	format(query, sizeof(query), "UPDATE groups SET gScore=gScore+%d WHERE gID = %d", value, gGroupID);
	MySQL_updateQuery(query);
}

CMD:g(playerid, params[])
{
  	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");

	if(isnull(params))
	{
	    Usage(playerid, "/g <text>");
	    return true;
	}

	// Decide about multi-line msgs
	new i = -1;
	if(strlen(params) > 70)
	{
		i = strfind(params, " ", false, 60);
		if(i > 80 || i == -1) i = 70;

		// store the second line text
		line = " ";
		strcat(line, params[i]);

		// delete the rest from msg
		params[i] = EOS;
	}

	if(pGroupColor[playerid] == -1)
	{
		format(str, sizeof(str), ""LIME_E"[Group Chat] "LB_E"%s(%i) (%s): "WHITE_E"%s", pName[playerid], playerid,GetGroupRank(pGroupID[playerid],pGroupRank[playerid]), params);
		SendGroupMessage(playerid, str);
		if(i != -1) SendGroupMessage(playerid, line);
	}
	else
	{
		new cStr[20];
		format(cStr, sizeof(cStr), "{%06x}", pGroupColor[playerid]);
		format(str, sizeof(str), ""LIME_E"[Group Chat] %s%s(%i) (%s): "WHITE_E"%s", cStr, pName[playerid], playerid, GetGroupRank(pGroupID[playerid],pGroupRank[playerid]), params);
		SendGroupMessage(playerid, str);
		if(i != -1) SendGroupMessage(playerid, line);
	}

	format(str, sizeof(str), "2[Group Chat] (%s)3 %s(%i):1 %s", pGroupName[playerid], pName[playerid], playerid, params);
	IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
 	return true;
}
CMD:groupcolor(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] != 6) return Error(playerid, "You must be the leader of the group to change the group color!");

	if(sscanf(params, "iii", hour, minute, second) || !(0 <= hour <= 255) || !(0 <= minute <= 255) || !(0 <= second <= 255))
	{
		Error(playerid, "Use /groupcolor <0-255> <0-255> <0-255>");
		return 1;
		/*SendClientMessage(playerid, COLOR_YELLOW, ""RED_E"Server: "YELLOW_E"You can also set your own player color using RGB values. /color <0-255> <0-255> <0-255>");
		SendClientMessage(playerid, COLOR_YELLOW, ""RED_E"Server: "YELLOW_E"Use /cc to change your vehicle color.");
		ShowPlayerDialog(playerid, 6, DIALOG_STYLE_LIST, ""ORANGE_E"Server: "LB_E"Colors", ""RED_E"Red\n"BLUE_E"Blue\n"WHITE_E"White\n{FFFF82}Ivory\n"PINK_E"Pink\n"YELLOW_E"Yellow\n"GREEN_E"Green\n"LB_E"Lightblue\n"GREY_E"Grey\n"ORANGE_E"Orange\n{800080}Purple\n"LG_E"Light Green\n{B0C4DE}Steelblue", "Select", "Exit");
		*/
	}
	else
	{
		if(hour < 60 && minute < 60 && second < 60)
		{
			Error(playerid, "Color too dark! RGB values under 60 are not allowed!");
			return true;
		}

		datez = COLOR_RGB(hour, minute, second, 99);
		format(line, sizeof(line), ""GROUP"%s %s(%i) has changed the group color.", GetColorRGBA(datez),pName[playerid], playerid);
		foreach(new ii : Player)
		{
			if(pGroupID[ii] == pGroupID[playerid])
			{
				SendClientMessage(ii,datez, line);
			}
		}
		pGroupColor[playerid] = StripAlpha(datez);
		foreach(new ii : Player)
		{
			if(pGroupID[ii] == pGroupID[playerid])
			{
				pGroupColor[ii] = pGroupColor[playerid];
			}
		}
		format(query, sizeof(query), "UPDATE groups SET gColor=%d WHERE gID=%d", datez, pGroupID[playerid]);
		MySQL_updateQuery(query);
	}
	return true;
}
CMD:groupcolour(playerid, params[]) return cmd_groupcolor(playerid, params);
CMD:gcolour(playerid, params[]) return cmd_groupcolor(playerid, params);
CMD:gcolor(playerid, params[]) return cmd_groupcolor(playerid, params);

CMD:gkick(playerid, params[]) return cmd_groupkick(playerid, params);
CMD:groupkick(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	
	if(pGroupRank[playerid] < 6) return Error(playerid, "You must be the leader of the group to kick players out!");
	if(sscanf(params, "u", otherid))
	{
		Usage(playerid, "/groupkick <ID>");
		return true;
	}
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Player not connected!");
	if(otherid == playerid) return Error(playerid, "You cannot kick yourself from the group use /gleave instead.");
	if(pGroupID[otherid] != pGroupID[playerid]) return Error(playerid, "This player is not in your group!");
	format(query, sizeof(query), "SELECT gfounder FROM groups WHERE gID=%d LIMIT 1", pGroupID[playerid]);
	mysql_query(g_SQL_handle, query);
	new rows = MySQL_rowCount();
	if(rows)
	{
		new founder[24];
		cache_get_row(0, 0, founder);
		if(strcmp(founder, pName[otherid]))
		{
 			return Error(playerid, "You can't kick the founder out of your gang!");
		}
	}
	format(query, sizeof(query), "UPDATE players SET group_id=-1,group_rank=0 WHERE reg_id=%d", pRegID[otherid]);
	MySQL_updateQuery(query);
	
	format(str, sizeof(str), "You have kicked out the group by %s(%d)!", pName[playerid], playerid);
	ShowPlayerDialog(otherid, NO_DIALOG, DIALOG_STYLE_MSGBOX, ""RED_E"Kicked off group", str, "Close", "");

	format(line, sizeof(line), ""GROUP" %s(%i) has kicked out %s(%d) from the group.", pName[playerid], playerid, pName[otherid], otherid);
	SendGroupMessage(playerid, line);
	format(line, sizeof(line), "4Server:3 %s(%i) has kicked out %s(%d) from his group.", pName[playerid], playerid, pName[otherid], otherid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, line);
	pSpawnPlace[otherid] = -1;
	pGroupID[otherid] = -1;
	pGroupRank[otherid] = 0;
	SpawnPos[otherid][SpawnSavedPos] = false;
	return true;
}
CMD:ogkick(playerid, params[]) return cmd_ogroupkick(playerid, params);
CMD:ogroupkick(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");

	if(pGroupRank[playerid] < 6) return Error(playerid, "You must be the leader of the group to kick players out!");
  
	if(sscanf(params, "s[24]", tmp))
	{
		Usage(playerid, "/ogroupkick <name>");
		return true;
	}

	mysql_format(g_SQL_handle, query, sizeof(query), "SELECT group_id , gfounder FROM players WHERE name = '%e'", tmp);
	MySQL_query(query, true, "KickPlayerFromGroup", "is", playerid, tmp);
	return true;
}
CMD:grouptag(playerid, params[]) return cmd_gtag(playerid, params);
CMD:gtag(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	new tag[24];
	if(pGroupRank[playerid] < 6) return Error(playerid, "You must be the leader of the group to set a group tag");

	if(sscanf(params, "s[24]", tmp))
	{
		Usage(playerid, "/gtag <tag>");
		return true;
	}
	if(strlen(tmp) > 3) return Error(playerid,"Gang tag may not be longer than 3 characters");
	format(tag,sizeof(tag),"[%s]" , tmp);
	mysql_format(g_SQL_handle, query, sizeof(query), "SELECT * FROM `groups` WHERE gTag = '%e'",tag);
	mysql_query(g_SQL_handle, query);
	if(!cache_num_rows())
	{
		format(line, sizeof(line), ""GROUP" %s(%i) has changed the group tag to %s", pName[playerid], playerid, tmp);
		SendGroupMessage(playerid, line);
		new escaped_tmp[24];
		mysql_real_escape_string(tag, escaped_tmp);

		mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE groups SET gTag='%e' WHERE gID=%d",tag, pGroupID[playerid]);
		MySQL_updateQuery(query);
		foreach(new i: Player)
		{
			if(pGroupID[i] == pGroupID[playerid]) LoadTag(i);
		}
	}
	else return Error(playerid,"This tag is already taken by another group");
	return true;
}
function KickPlayerFromGroup(playerid, kickedPlayer[])
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), ""RED_E"ERROR: "GREY_E"No player named '%s' exists in the database.", kickedPlayer);
		SendClientMessage(playerid, COLOR_WHITE, str);
	}
	else
	{
		new gGroupID = cache_get_row_int(0, 0);
		new founder[24];
		cache_get_row(1, 0, founder);
		if(gGroupID != pGroupID[playerid]) return Error(playerid, "This player is not in your group!");
		if(strcmp(founder, kickedPlayer))
		{
 			return Error(playerid, "You can't kick the founder out of your gang!");
		}

		// Kick the player from the group
		format(query, sizeof(query), "UPDATE players SET group_id=-1,group_rank=0 WHERE name = '%s'", kickedPlayer);
		MySQL_updateQuery(query);

		format(line, sizeof(line), ""GROUP" %s(%i) has kicked out %s from the group.", pName[playerid], playerid, kickedPlayer);
		SendGroupMessage(playerid, line);
		format(line, sizeof(line), "4Server:3 %s(%i) has kicked out %s from his group.", pName[playerid], playerid, kickedPlayer);
		IRC_GroupSay(ircGroup, IRC_CHANNEL, line);
	}
	return 1;
}

CMD:gleave(playerid,params[]) return cmd_groupleave(playerid,params);
CMD:groupleave(playerid,params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] == 6) return Error(playerid, "You can't leave the group as the leader");
	new reason[125];
	if(sscanf(params, "s[128]", reason))
	{
		Usage(playerid, "/gleave <reason>");
		return true;
	}
	new count = 0;
	
	format(str, sizeof(str), ""GROUP" %s(%i) has left the group.", pName[playerid], playerid);
	SendGroupMessage(playerid, str);
	format(str, sizeof(str), "Reason: %s",reason);
	SendGroupMessage(playerid, str);
	foreach(new ii : Player)
	{
		if(pGroupID[ii] == pGroupID[playerid])
		{
			count++;
		}
	}
	format(str, sizeof(str), ""Server" "GREY_E"You have left your group '%s'.", pGroupName[playerid]);
	SendClientMessage(playerid, COLOR_WHITE, str);
	format(str, sizeof(str), "4Server:3 %s(%i) has left his group.", pName[playerid], playerid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);
	if(count == 0)
	{
		// Disband Group
		format(query, sizeof(query), "DELETE FROM groups WHERE gID=%d", pGroupID[playerid]);
		MySQL_updateQuery(query);
		format(str, sizeof(str), ""Server" "GREY_E"Group '%s' has been disbanded as you are the only player left.", pGroupName[playerid]);
		SendClientMessage(playerid, COLOR_WHITE, str);
	}
	
	pGroupID[playerid] = -1;
	pGroupRank[playerid] = 0;
	SpawnPos[playerid][SpawnSavedPos] = false;

	format(query, sizeof(query), "UPDATE players SET group_id=-1,group_rank=0 WHERE reg_id=%d", pRegID[playerid]);
	MySQL_updateQuery(query);
	return true;
}
CMD:gset(playerid, params[]) return cmd_groupset(playerid, params);
CMD:groupset(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] < 5)
		return Error(playerid, "You must be at least the co-leader of the group to set ranks!");
	

	new level;
	new count;
	if(sscanf(params, "ui", otherid, level))
	{
		Usage(playerid, "/groupset <ID> <Level>");
		return true;
	}
	if(otherid == INVALID_PLAYER_ID)
		return Error(playerid, "Player not connected!");
	if(pGroupID[otherid] != pGroupID[playerid]) return Error(playerid, "This player is not in your group!");
	if(level > 6)
		return Error(playerid, "Level can't be higher than 6!");
	if(level < 1)
		return Error(playerid, "Level can't be lower than 1!");
		
	if(pGroupRank[otherid] > pGroupRank[playerid]) return Error(playerid, "You can't set level on a group member higher than you!");
	if(pGroupRank[otherid] == level) return Error(playerid, "Player is already this level!");
	
	if(pGroupRank[playerid] < 6)
	{
		if(level == 6) return Error(playerid, "Only group leaders can promote others to leaders..");
		if(pGroupRank[otherid] > 6)
		{
			Error(playerid, "You can't set levels on the group leader!");
			format(line, sizeof(line), ""RED_E"*** "LB_E"%s(%d) has just tried to set your group level!", pName[playerid], playerid);
			SendClientMessage(otherid, COLOR_LB, line);
			return 1;
		}
	}

	if(pGroupRank[otherid] == 6)
	{
		foreach(new ii : Player)
		{
			if(pGroupID[ii] == pGroupID[playerid] && (pGroupRank[ii] == 6 && ii != playerid))
			{
				count++;
			}
		}
		if(count == 0)
		{
			return Error(playerid, "There must be at least one leader for the group! You can demote yourself when another leader is online.");
		}
	}
	count = 0;
	if(level == 6) 
	{
		foreach(new ii : Player)
		{
			if(pGroupID[ii] == pGroupID[playerid] && pGroupRank[ii] == 6)
			{
				count++;
			}
		}
		if(count >= 3)
		{
			return Error(playerid, "There can only be a maxium of 3 group leaders!");
		}
	}
	
	new levelstr[12];
	levelstr = (level > pGroupRank[otherid]) ? ("promoted") : ("demoted");

	pGroupRank[otherid] = level;
	format(query, sizeof(query), "UPDATE players SET group_rank=%d WHERE reg_id=%d", level, pRegID[otherid]);
	MySQL_updateQuery(query);

	if(pGroupRank[playerid] == 6)
	{
		format(str, sizeof(str), ""WHITEP_E"You have been %s to %s(%d) by group leader %s(%d)!", levelstr, GetGroupRank(pGroupID[playerid],level), level, pName[playerid], playerid);
		format(line, sizeof(line), ""GROUP" %s(%i) has been %s to %s(%d) by group leader %s(%i)", pName[otherid], otherid, levelstr, GetGroupRank(pGroupID[playerid],level), level, pName[playerid], playerid);
	}
	else
	{
		format(str, sizeof(str), ""WHITEP_E"You have been %s to %s(%d) by group co-leader %s(%d)!", levelstr, GetGroupRank(pGroupID[playerid],level), level, pName[playerid], playerid);
		format(line, sizeof(line), ""GROUP" %s(%i) has been %s to %s(%d) by group co-leader %s(%i)", pName[otherid], otherid, levelstr, GetGroupRank(pGroupID[playerid],level), level, pName[playerid], playerid);
	}
	ShowPlayerDialog(otherid, NO_DIALOG, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Group", str, "Close", "");
	SendGroupMessage(playerid, line);

	return true;
}
CMD:ogset(playerid, params[]) return cmd_ogroupset(playerid, params);
CMD:ogroupset(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] < 5)
		return Error(playerid, "You must be at least the co-leader of the group to set ranks!");

	new level;
	if(sscanf(params, "s[24]i", tmp, level))
	{
		Usage(playerid, "/ogset <name> <level>");
		return true;
	}
	if(level > 5)
		return Error(playerid, "Level can't be higher than 5!");
	if(level < 1)
		return Error(playerid, "Level can't be lower than 1!");
	if(pGroupRank[playerid] != 6 && level == 6) return Error(playerid, "You can't make yourself leader as the co-leader!");
	new escaped_tmp[24];
	mysql_real_escape_string(tmp, escaped_tmp);

	format(query, sizeof(query), "SELECT group_id,group_rank FROM players WHERE name = '%s'", escaped_tmp);
	MySQL_query(query, true, "SetPlayerGroupLevel", "isi", playerid, escaped_tmp, level);
	return true;
}
function SetPlayerGroupLevel(playerid, Player[], level)
{
	if(!MySQL_rowCount())
	{
		format(str, sizeof(str), ""RED_E"ERROR: "GREY_E"No player named '%s' exists in the database.", Player);
		SendClientMessage(playerid, COLOR_WHITE, str);
	}
	else
	{
		new gGroupID = cache_get_row_int(0, 0);
		new gGroupRank = cache_get_row_int(0, 1);
		if(gGroupRank > pGroupRank[playerid]) return Error(playerid, "You can't set level on a group member higher than you!");
		if(gGroupID != pGroupID[playerid]) return Error(playerid, "This player is not in your group!");

		// Set the players level
		format(query, sizeof(query), "UPDATE players SET group_rank=%d WHERE name = '%s'", level, Player);
		MySQL_updateQuery(query);

		format(line, sizeof(line), "%s(%i) has set %s to %s.", pName[playerid], playerid, Player, GetGroupRank(gGroupID,level));
		SendGroupMessage(playerid, line);
	}
	return 1;
}
CMD:gdisband(playerid, params[]) return cmd_groupdelete(playerid, params);
CMD:groupdelete(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] < 6) return Error(playerid, "You must be the leader of the group to delete it!");
	format(query, sizeof(query), "SELECT gfounder FROM groups WHERE gID=%d LIMIT 1", pGroupID[playerid]);
	mysql_query(g_SQL_handle, query);
	new rows = MySQL_rowCount();
	if(rows)
	{
		new founder[24];
		cache_get_row(0, 0, founder);

		if(!strcmp(founder, pName[playerid]))
		{
			format(line, sizeof(line), ""GROUP"%s(%i) has disbanded group '%s'", pName[playerid], playerid, pGroupName[playerid]);
			SendClientMessageToAll(COLOR_LB, line);

			format(line, sizeof(line), ""GROUP"%s(%i) disbanded the group! You have been auto-removed from the group.", pName[playerid], playerid);
			SendGroupMessage(playerid, line);
			format(str, sizeof(str), "4Server:3 %s(%i) has disbanded his group.", pName[playerid], playerid);
			IRC_GroupSay(ircGroup, IRC_CHANNEL, str);
			format(query, sizeof(query), "UPDATE players SET group_id=-1,group_rank=0 WHERE group_id=%d", pGroupID[playerid]);
			MySQL_updateQuery(query);
			format(query, sizeof(query), "DELETE FROM groups WHERE gID=%d", pGroupID[playerid]);
			MySQL_updateQuery(query);

			foreach(new ii : Player)
			{
				if(pGroupID[ii] == pGroupID[playerid] && playerid != ii)
				{
					pGroupID[ii] = -1;
					pGroupRank[ii] = 0;
					SpawnPos[ii][SpawnSavedPos] = false;
					pSpawnPlace[ii] = -1;
				}
			}
			pGroupID[playerid] = -1;
			pGroupRank[playerid] = 0;
			pGTag[playerid][0] = EOS;
			SpawnPos[playerid][SpawnSavedPos] = false;
			pSpawnPlace[playerid] = -1;
			SendClientMessage(playerid, COLOR_GREY, ""Server" "GREY_E"You have successfully disbanded your group and removed all the members!");
		}
		else
		{
			Error(playerid, "Only the founder of the group can disband the group!");
		}
	}
	return true;
}

CMD:ginvite(playerid, params[]) return cmd_groupinvite(playerid, params);
CMD:groupinvite(playerid, params[])
{
	if(sscanf(params, "u", otherid)) return Usage(playerid, "/groupinvite <ID>");
	if(otherid == INVALID_PLAYER_ID) return Error(playerid, "Player not connected!");
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] < 4) return Error(playerid, "You must be at least the advisor to invite players to the group!");
	if(otherid == playerid) return Error(playerid, "You can't invite yourself to your own group!");
	if(pLogged[otherid] == false) return Error(playerid, "That player isn't registered!");
	if(pGroupID[otherid] != -1) return Error(playerid, "This player is already in a group!");
	if(GetPVarInt(otherid, "gInvitedPlayer") == playerid) return Error(playerid, "You have already sent a group invite to this player!");

/*	GetPlayerPos(otherid, POS[0], POS[1], POS[2]);
	
	if(!IsPlayerInRangeOfPoint(playerid, 10.0, POS[0], POS[1], POS[2]))
	{
		return Error(playerid, "You must be near the player your inviting!");
	}
*/
	GetGroupMembers(playerid, otherid, pGroupID[playerid]);
	
	gSpawnPos[otherid][0] = gSpawnPos[playerid][0];
	gSpawnPos[otherid][1] = gSpawnPos[playerid][1];
	gSpawnPos[otherid][2] = gSpawnPos[playerid][2];
	return true;
}

stock GetGroupMembers(playerid, otherplayerid, groupid)
{
	format(query, sizeof(query), "SELECT group_id FROM players WHERE group_id=%d", groupid);
	MySQL_query(query, true, "MySQL_GetGroupMembers", "ii", playerid, otherplayerid);
}

forward MySQL_GetGroupMembers(playerid, otherplayerid);
public MySQL_GetGroupMembers(playerid, otherplayerid)
{
	if(MySQL_rowCount() > 100)
	{
		return Error(playerid, "You can't have more than 100 members in your group!");
	}
	format(str, sizeof(str), ""GROUP" %s(%i) has invited you to his group '%s'. Type /gaccept or /gdeny to respond.", pName[playerid], playerid, pGroupName[playerid]);
	SendClientMessage(otherplayerid, COLOR_WHITE, str);
	format(str, sizeof(str), ""GROUP" You have invited %s(%i) to join your group, wait for the player to respond.", pName[otherplayerid], otherplayerid);
	SendClientMessage(playerid, COLOR_WHITE, str);
	SetPVarInt(otherplayerid, "gInvitedPlayer", playerid);
	return 1;
}
CMD:gaccept(playerid)
{
	new Invitee = GetPVarInt(playerid, "gInvitedPlayer");
	
	if(GetPVarInt(playerid, "gInvitedPlayer") == -1) return Error(playerid, "You have not been invited to any group.");
	
	if(Invitee == INVALID_PLAYER_ID)
		return Error(playerid, "The player that has invited you has left the server! Invite has been cancelled."), DeletePVar(playerid, "gInvitedPlayer");
	
	pGroupID[playerid] = pGroupID[Invitee];
	pGroupRank[playerid] = 1;
	pGroupName[playerid] = pGroupName[Invitee];
	pGroupColor[playerid] = pGroupColor[Invitee];
	format(query, sizeof(query), "UPDATE players SET group_id=%d,group_rank=1 WHERE reg_id=%d", pGroupID[playerid], pRegID[playerid]);
	MySQL_updateQuery(query);

	format(str, sizeof(str), ""GROUP" %s(%i) has joined the group! Invited by: %s(%d)", pName[playerid], playerid, pName[Invitee], Invitee);
	SendGroupMessage(playerid, str);

	format(str, sizeof(str), ""GROUP" You have joined the group '%s'!", pGroupName[playerid]);
	SendClientMessage(playerid, COLOR_GREY, str);
	format(str, sizeof(str), "4Server:3 %s(%i) has joined the group '%s'! Invited by: %s(%d)", pName[playerid], playerid, pGroupName[playerid], pName[Invitee], Invitee);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, str);
	
	SetPVarInt(playerid, "gInvitedPlayer", -1);
	return true;
}
CMD:gdeny(playerid)
{
	new Invitee = GetPVarInt(playerid, "gInvitedPlayer");
	
	if(GetPVarInt(playerid, "gInvitedPlayer") == -1) return Error(playerid, "You have not been invited to any group.");

	if(Invitee == INVALID_PLAYER_ID)
		return Error(playerid, "The player that has invited you has left the server! Invite has been cancelled."), DeletePVar(playerid, "gInvitedPlayer");

	format(str, sizeof(str), ""GROUP" You have denied the group request from %s(%d)", pName[Invitee], Invitee);
	SendClientMessage(playerid, COLOR_GREY, str);
	
	format(str, sizeof(str), ""GROUP" %s(%d) has denied the group request.", pName[playerid], playerid);
	SendClientMessage(Invitee, COLOR_GREY, str);
	SetPVarInt(playerid, "gInvitedPlayer", -1);
	return true;
}

CMD:mgjoin(playerid, params[])
{
	if(pAdmin[playerid] < 5) return Error(playerid, "You are not authorized to use this command!");
	if(isnull(params)) return Usage(playerid, "/mgjoin [groupid]");
	if(!IsNumeric(params)) return Error(playerid, "Invalid Numeric ID, Please enter a valid number {0, 1, 2, ..}.");
	otherid = strval(params);

	new count = 0;
	foreach(new ii : Player)
	{
		if(pGroupID[ii] == otherid)
		{
			pGroupID[playerid] = pGroupID[ii];
			pGroupName[playerid] = pGroupName[ii];
			count = 1;
			break;
		}
	}

	if(count > 0)
	{
		new string[504];
		format(string, sizeof(string), ""RED_E"-AS- You have joined GroupID "WHITE_E"%d "RED_E"("WHITE_E"%s"RED_E") as Groups Manager (Rank: 7)", otherid, pGroupName[playerid]);
		SendClientMessage(playerid, -1, string);
		format(string, sizeof(string), ""RED_E"-AS- Manager "WHITE_E"'%s' "RED_E"has force-joined your group as Rank 7.", pName[playerid]);
		SendGroupMessage(playerid, string);
		format(string, sizeof(string), "UPDATE players SET group_id=%d,group_rank=7 WHERE reg_id=%d", pGroupID[playerid], pRegID[playerid]);
		MySQL_updateQuery(string);
		pGroupRank[playerid] = 7;
		return 1;
	}
	else Error(playerid, "There's no such groupID online.");
	return 1;
}
#define ShiftRGBAToRGB(%0)				(((%0) >>> 8) & 0xFFFFFF)
GetColorRGBA(color){
    new string[10];
    format(string,sizeof(string),"{%06x}",ShiftRGBAToRGB(color));
    return string;
}
/*
CMD:gcolor(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");
	if(pGroupRank[playerid] < 5) return Error(playerid, "You must be the atleast co-leader of the group to use this command!");
	if(isnull(params)) return ShowPlayerDialog(playerid, 118, DIALOG_STYLE_LIST, ""ORANGE_E"Server: "LB_E"Colors", ""RED_E"Red\n"BLUE_E"Blue\n"WHITE_E"White\n"PINK_E"Pink\n"GREY_E"Grey\n"ORANGE_E"Orange", "Select", "Exit");
	if(strval(params) > 6) return Usage(playerid, "/gcolor (Hex-Color: 6 char max.)");
	if(!IsValidColor(params)) return Error(playerid, "Invalid Hex-Color.");
	format(GroupColor[pGroupID[playerid]], 14, params);
	SendClientMessage(playerid, COLOR_GREEN, "You have successfully change your gang color.");
	return 1;
}

IsValidColor(code[])
{
	new checked;
	for(new i; i < 6; i++)
	{
		if(IsNumeric(code[i])) checked+=1;
		else if((code[i] == 'A' || code[i] == 'a') || (code[i] == 'B' || code[i] == 'b') || (code[i] == 'C' || code[i] == 'c') || (code[i] == 'D' || code[i] == 'd') || (code[i] == 'E' || code[i] == 'e') || (code[i] == 'F' || code[i] == 'f')) checked+=1;
	}
	
	if(checked == 6) return true;
	return false;
}
*/
CMD:delgtag(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");

	if(pGroupRank[playerid] < 6) return Error(playerid, "You must be the leader of the group to remove tag!");
	format(str, sizeof(str), ""GROUP" %s(%i) has removed the group tag", pName[playerid] , playerid);
	SendGroupMessage(playerid, str);
	mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE `groups` SET `gTag` ='' WHERE gID = %d", pGroupID[playerid]);
	mysql_query(g_SQL_handle, query);
	return 1;
}

CMD:grankname(playerid, params[])
{
	if(pGroupID[playerid] == -1) return Error(playerid, "You are not in a group!");

	if(pGroupRank[playerid] < 6) return Error(playerid, "You must be the leader of the group to set rank names!");

	new rank;
	if(sscanf(params, "ds[24]",rank,tmp))
	{
		Usage(playerid, "/grankname <rank number> <name>");
		return true;
	}
	if(strlen(tmp) > 20 || strlen(tmp) < 0) return Error(playerid,"Rank name limit is 2-20 characters");
	if(rank > 6 || rank < 0) return Error(playerid,"Valid ranks are from 1-6");

	mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE `groups` SET `rank_%d` ='%e' WHERE gID = %d", rank , tmp , pGroupID[playerid]);
	mysql_query(g_SQL_handle, query);
	print(query);
	format(str, sizeof(str), ""GROUP" %s(%i) has changed group Rank %d name to %s", pName[playerid] , playerid,  rank , tmp);
	SendGroupMessage(playerid, str);
	return true;
}
GetGroupRank(groupid,rank)
{
	new rname[24] = "INVALID RANK";
   	format(query, sizeof(query), "SELECT * FROM `groups` WHERE gID=%d", groupid);
 	mysql_query(g_SQL_handle, query);
	if(cache_num_rows())
	{
	    format(str,sizeof(str),"rank_%d"  , rank);
	    cache_get_field_content(0,str, rname);
	}
	return rname;
}
LoadTag(playerid)
{
   	format(query, sizeof(query), "SELECT * FROM `groups` WHERE gID=%d", pGroupID[playerid]);
 	new Cache:Result = mysql_query(g_SQL_handle, query);
	if(cache_num_rows())
	{
	    cache_get_field_content(0, "gTag", pGTag[playerid]);
	    cache_delete(Result);
	    return 1;
	}
	else
	{
		cache_delete(Result);
		return 0;
	}
}
