#define TOTAL_MAT 3
#define MAX_FONT_NAME 30 			// The limit of Max font name !
#define MAX_TEXT 50 				// The limit of Max text, That can be used !
#define MAX_MATERIALS 69 			// Max amount of Materials
#define MAT_OBJECT  19480 			// The object to put the material




/// FORWARDS //
forward MATERIAL_OnGameModeExit();
forward MATERIAL_OnGameModeInit();
forward MATERIAL_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
forward MATERIAL_OPEDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);

#define white "{FFFFFF}"
#define MYRED "{FF0000}"
#define MYBLUE "{0000FF}"
#define MYYELLOW "{FFFF00}"
#define MYORANGE "{FFA500}"
#define MYPURPLE "{800080}"
#define MYGREEN "{008000}"
#define MYLBLUE "{0080FF}"
#define MYWHITE "{FFFFFF}"
#define MYBLACK "{000000}"
#define MYCYAN "{00FFFF}"
#define MYPINK "{FF00FF}"
#define MYBROWN "{6A0000}"
#define MYLPURPLE "{8080C0}"
#define MYLGREEN "{00FF00}"
#define MYGREY "{676767}"



#define MRED 0xFFFF0000
#define MBLUE 0xFF0000FF
#define MYELLOW 0xFFFFFF00
#define MORANGE 0xFFFF8000
#define MPURPLE 0xFF400080
#define MGREEN 0xFF008000
#define MLBLUE 0xFF0080FF
#define MWHITE 0xFFFFFFFF
#define MBLACK 0xFF000000
#define MCYAN 0xFF00FFFF
#define MPINK 0xFFFF00FF
#define MBROWN 0xFF6A0000
#define MLPURPLE 0xFF8080C0
#define MLGREEN 0xFF00FF00
#define MGRAY 0xFF676767

#define	DIALOG_MATS     	1056
#define	DIALOG_TEXT     	1057
#define	DIALOG_FONT         1058
#define	DIALOG_DELETE   	1059
#define	DIALOG_FONTCOLOR 	1060
#define	DIALOG_FONTSIZE     1061
#define	DIALOG_BGCOLOR      1062
#define	DIALOG_ALLIGNMENT   1063
#define	DIALOG_RESOLUTION   1064
#define	DIALOG_EDITMAT      1065
#define DIALOG_CHANGEOBJECT 1067
#define DIALOG_CHANGEINDEX  1068
enum MaterialInfo
{
	Float:MatX,
	Float:MatY,
	Float:MatZ,
	Float:MatRX,
	Float:MatRY,
	Float:MatRZ,
	MatText[MAX_TEXT],
	MatObj,
	MatSize,
	MatBGC,
	MatALG,
	MatFont[MAX_FONT_NAME],
	MatColor,
	MatBold,
	MatRes,
	MatOwner[MAX_PLAYER_NAME+1],
	MatObjectID,
	MatIndex,
}
new matInfo[MAX_MATERIALS][MaterialInfo];
new MatsIDs[MAX_MATERIALS][3];
new Iterator:MatsItr<MAX_MATERIALS>;
new SOID[MAX_PLAYERS];
forward CreateMat(type,id,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz);
enum FontInformation
{
	FontName[MAX_FONT_NAME],
};
new FontInfo[][FontInformation] = // All the fonts, You can also add new one, Check example below.
{
	{"Lucida Console"},
	{"Verdana"},
	{"Webdings"},
	{"Wingdings"},
	{"Times New Roman"},
	{"Microsoft Sans Serif"},
	{"GTAWEAPON3"},
	{"Impact"},
	{"Georgia"},
	{"Arial"},
	{"Arial Black"},
	{"Comic Sans MS"},
	{"Trebuchet MS"}
//	{"MY FONT NAME"}
};
public MATERIAL_OnGameModeInit()
{
	for(new i = 0; i < MAX_MATERIALS; i++)
  	{
  	    DeleteMat(i);
  		format(query, sizeof(query), "SELECT * FROM materials WHERE MatID = %d",i);
		mysql_query(g_SQL_handle, query);
		if(cache_num_rows())
		{
			LoadMat(i);
			CreateMat(3,i,matInfo[i][MatX],matInfo[i][MatY],matInfo[i][MatZ],matInfo[i][MatRX],matInfo[i][MatRY],matInfo[i][MatRZ]);
		}
	}
	return 1;
}
CountMaterials(playerid)
{
	format(query, sizeof(query), "SELECT * FROM materials WHERE MatOwner = '%s'",GetName(playerid));
	mysql_query(g_SQL_handle, query);
	if(cache_num_rows()) return cache_num_rows();
	else return -1;
}
public MATERIAL_OnGameModeExit()
{
	for(new i = 0; i < MAX_MATERIALS; i++)
  	{
  		if(Iter_Contains(MatsItr,i))
  		{
			SaveMat(i);
			DeleteMat(i);
		}
	}
	return 1;
}
CMD:createmat(playerid,params[])
{
    if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in DM!");
		return true;
	}
	if(doingStunt[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in this area!");
		return true;
	}
	if(pAdmin[playerid] == 6 || pPremium[playerid] == 3 || pDeveloper[playerid] == 1)
	{
		if(!MaterialBanned(playerid)) return true;
		new string[128];
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z); GetPlayerFacingAngle(playerid, a);
		if(Iter_Count(MatsItr) > MAX_MATERIALS) return Error(playerid, "You've reached the total amount of Materials, Max Materials: "#MAX_MATERIALS"");
		if(pAdmin[playerid] != 6 && pDeveloper[playerid] != 1)
		{
			if(CountMaterials(playerid) >= TOTAL_MAT) return Error(playerid,"You've reached the total amount of  Materials, Max Materials per player: "#TOTAL_MAT"");
		}
		new id = Iter_Free(MatsItr);
		format(string, sizeof(string), ""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"Material created succesfully, The Material id is %d, (/mymats to view your materials)", id);
		SendClientMessage(playerid, COLOR_RED, string);
		SetPVarInt(playerid,"matID",id);
		format(matInfo[id][MatText],30,"%s" , GetName(playerid));
		format(matInfo[id][MatFont],30,"Arial");
		matInfo[id][MatObjectID] = MAT_OBJECT;
		format(matInfo[id][MatOwner],MAX_PLAYER_NAME+1,GetName(playerid));
		matInfo[id][MatColor] = MRED;
		CreateMat(1,id,x,y,z,0,0,a);
		EditDynamicObject(playerid,matInfo[id][MatObj]);
	}
	else return Error(playerid, "You are not authorized to use this command!");
	return 1;
}
CMD:nearmat(playerid, params[])
{
    if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in DM!");
		return true;
	}
	if(doingStunt[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in this area!");
		return true;
	}
	if(pAdmin[playerid] == 6 || pPremium[playerid] == 3  || pDeveloper[playerid] == 1)
	{
	    if(!MaterialBanned(playerid)) return true;
	    new string[555],count = 0;
	    for(new i = 0; i < MAX_MATERIALS; i++)
	  	{
	  	    if(IsPlayerInRangeOfPoint(playerid, 15.0, matInfo[i][MatX], matInfo[i][MatY], matInfo[i][MatZ]) && Iter_Contains(MatsItr,i))
			{
				count = 1;
				format(string, sizeof(string), "%sMaterial ID: %d , Text: %s , Owner: %s\n",string, i, matInfo[i][MatText] , matInfo[i][MatOwner]);
			}
		}
		if(count == 0) return Error(playerid,"You are not near any Material");
		ShowPlayerDialog(playerid, NO_DIALOG, DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Near Materials", string , "OK", "");

	}
	else return Error(playerid, "You are not authorized to use this command!");
    return 1;
}
CMD:materialban(playerid, params[])
{
	if(pAdmin[playerid] < 5)
		return Error(playerid, "You are not authorized to use this command!");
	new name[36];
 	if(sscanf(params, "s[36]", name)) return SendClientMessage(playerid, COLOR_WHITEP, ""RED_E"» "ORANGE_E"USAGE: "WHITEP_E" /materialban <Name>");
	format(query, sizeof(query), "SELECT * FROM players WHERE name='%s' LIMIT 1", name);
 	mysql_query(g_SQL_handle, query);
	if(cache_num_rows())
	{
    	new banned = cache_get_field_content_int(0,"MaterialBanned");
    	if(banned == 1)
    	{
    	    Error(playerid, "Player is already material banned");
    	}
    	else
    	{
	   		mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE players SET MaterialBanned=1 WHERE name = '%s'" , name);
			mysql_query(g_SQL_handle, query);
		  	if(pHidden[playerid] == 0)
				format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"%s(%i) has Material-Banned %s", pName[playerid], playerid, name);
			else
				format(str, sizeof(str), ""YELLOW_E"- AS - "RED_E"%s has been Material-Banned by an Administrator", name);
			SendClientMessageToAll(COLOR_RED, str);
  			foreach(new ii : Player)
			{
				GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);
				if(strfind(PlayerName, name, true) != -1)
				{
					SendClientMessage(ii,-1,""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"You've been material-banned, Now you cannot create 3D Text Label.");
					return true;
				}
			}
    	}
	}
	else return Error(playerid, "Account doesn't exists.");

	return true;
}
CMD:materialunban(playerid, params[])
{
	if(pAdmin[playerid] < 5)
		return Error(playerid, "You are not authorized to use this command!");
	new name[36];
 	if(sscanf(params, "s[36]", name)) return SendClientMessage(playerid, COLOR_WHITEP, ""RED_E"» "ORANGE_E"USAGE: "WHITEP_E" /materialunban <Name>");
	format(query, sizeof(query), "SELECT * FROM players WHERE name='%s' LIMIT 1", name);
 	mysql_query(g_SQL_handle, query);
	if(cache_num_rows())
	{
    	new banned = cache_get_field_content_int(0,"MaterialBanned");
    	if(banned == 0)
    	{
    	    Error(playerid, "Player is already material unbanned");
    	}
    	else
    	{
	   		mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE players SET MaterialBanned=0 WHERE name = '%s'" , name);
			mysql_query(g_SQL_handle, query);
		  	if(pHidden[playerid] == 0)
		  	{
				format(str, sizeof(str), ""YELLOW_E"- AS - "GREEN_E"%s(%i) has Material-Unbanned %s", pName[playerid], playerid, name);
				SendClientMessageToAll(COLOR_RED, str);
			}
			else
			{
				format(str, sizeof(str), ""YELLOW_E"- AS - "GREEN_E"%s has been Material-Unbanned by an Administrator", name);
				SendClientMessageToAll(COLOR_RED, str);
			}
 			foreach(new ii : Player)
			{
				GetPlayerName(ii, PlayerName, MAX_PLAYER_NAME);
				if(strfind(PlayerName, name, true) != -1)
				{
					SendClientMessage(ii,-1,""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"You've been material-unbanned, Now you can create materials.");
					return true;
				}
			}
	
    	}
	}
	else return Error(playerid, "Account doesn't exists.");

	return true;
}
CMD:mymats(playerid, params[])
{
    if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in DM!");
		return true;
	}
	if(doingStunt[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in this area!");
		return true;
	}
    new string[256],string2[2000],count = 0,bool:page = false;
	if(pAdmin[playerid] == 6 || pPremium[playerid] == 3 || pDeveloper[playerid] == 1)
	{
    	if(!MaterialBanned(playerid)) return Error(playerid,"You are material banned!");
	    if(CountMaterials(playerid) == 0) return Error(playerid,"You don't have any materials created");
		MatsIDs[0][1] = 0;
		MatsIDs[0][2] = 0;
	    for(new i = 0; i < MAX_MATERIALS; i++)
	  	{
    		MatsIDs[i][0] = 0;
	  	    if(strcmp(GetName(playerid),matInfo[i][MatOwner] , true) == 0)
	  		{
  				count++;
  				MatsIDs[0][2]++;
		    	if(count <= CountMaterials(playerid))
			  	{
					format(string, sizeof(string), ""white"%d - Text: %s , %s\n", MatsIDs[0][2], matInfo[i][MatText] , GetPositionLocation(matInfo[i][MatX], matInfo[i][MatY]));
					strcat(string2,string);
					MatsIDs[count][0] = i;
					if(count >= 10)
					{
						page = true;
						MatsIDs[0][1] = i;
						break;
					}
				}
			}
		}
		if(page) ShowPlayerDialog(playerid, DIALOG_EDITMAT , DIALOG_STYLE_LIST,"My Materials", string2 , "Edit", "Next Page");
		else ShowPlayerDialog(playerid, DIALOG_EDITMAT , DIALOG_STYLE_LIST,"My Materials", string2 , "Edit", "Close");
	}
	else return Error(playerid, "You are not authorized to use this command!");
    return 1;
}
CMD:editmat(playerid, params[])
{
    if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in DM!");
		return true;
	}
	if(doingStunt[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in this area!");
		return true;
	}
	if(pAdmin[playerid] >= 5  || pDeveloper[playerid] == 1)
	{
    	if(!MaterialBanned(playerid)) return true;
		new ID;
	    if(sscanf(params, "i", ID)) return SendClientMessage(playerid, COLOR_WHITEP, ""RED_E"» "ORANGE_E"USAGE: "WHITEP_E" /editmat <ID>");
	    if(!Iter_Contains(MatsItr,ID)) return Error(playerid,"Material ID doesn't exists");
	    if(strcmp(GetName(playerid),matInfo[ID][MatOwner] , true) == 0 || pAdmin[playerid] == 6  || pDeveloper[playerid] == 1)
		{
	    	if(!Iter_Contains(MatsItr,ID)) return Error(playerid,"Material ID doesn't exists");
   			ShowMatDialog(playerid);
			SOID[playerid] = ID;
		}
		else
		{
			Error(playerid,"This material isn't yours");
		}
	}
	else return Error(playerid, "You are not authorized to use this command!");
    return 1;
}
ShowMatDialog(playerid)
{
	if(pAdmin[playerid] == 6 || pDeveloper[playerid] == 1)
	{
    	ShowPlayerDialog(playerid, DIALOG_MATS , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text", "Change Text\nChange Font\nChange Color\nChange Font Size\nChange Background Color\nChange Allignment\nBold Text\nChange Resolution\nEdit Material Pos\nDuplicate Material\nDelete Material\nGoto Material\nChange Object ID\nChange Material Index", "Select", "Close");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_MATS , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text", "Change Text\nChange Font\nChange Color\nChange Font Size\nChange Background Color\nChange Allignment\nBold Text\nChange Resolution\nEdit Material Pos\nDuplicate Material\nDelete Material\nGoto Material", "Select", "Close");
	}
	return 1;
}
public MATERIAL_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new ID = SOID[playerid];
	switch(dialogid)
	{
		case DIALOG_EDITMAT:
		{
			if(response)
			{
				ShowMatDialog(playerid);
				SOID[playerid] = MatsIDs[listitem+1][0];
			}
			else if(!response)
			{
			    new string[256],string2[2000],count = 0,bool:page = false;
				if(MatsIDs[0][1] > 0)
				{
				    for(new i = MatsIDs[0][1]+1; i < MAX_MATERIALS; i++)
				  	{
			    		MatsIDs[i][0] = 0;
				  	    if(strcmp(GetName(playerid),matInfo[i][MatOwner] , true) == 0)
				  		{
			  				count++;
			  				MatsIDs[0][2]++;
					    	if(count <= CountMaterials(playerid))
						  	{
								format(string, sizeof(string), ""white"%d - Text: %s , %s\n",MatsIDs[0][2], matInfo[i][MatText],GetPositionLocation(matInfo[i][MatX], matInfo[i][MatY]));
								strcat(string2,string);
								MatsIDs[count][0] = i;
								if(count >= 10)
								{
									page = true;
									MatsIDs[0][1] = i;
									break;
								}
							}
						}
					}
					if(page) ShowPlayerDialog(playerid, DIALOG_EDITMAT , DIALOG_STYLE_LIST,"My Materials", string2 , "Edit", "Next Page");
					else MatsIDs[0][1] = 0 , ShowPlayerDialog(playerid, DIALOG_EDITMAT , DIALOG_STYLE_LIST,"My Materials", string2 , "Edit", "Close");
				}
			}
		}
		case DIALOG_TEXT:
		{
			if(!response) return ShowMatDialog(playerid);
			if(strlen(inputtext) >= MAX_TEXT || strlen(inputtext) <= 0 ) return Error(playerid,"Text may not be less than 0 or more than "#MAX_TEXT"!");
			format(matInfo[ID][MatText],128,inputtext);
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
			ShowMatDialog(playerid);
		}
		case DIALOG_ALLIGNMENT:
		{
			if(!response) return ShowMatDialog(playerid);
			switch(listitem)
			{
				case 0: matInfo[ID][MatALG] = 0;
				case 1: matInfo[ID][MatALG] = 1;
				case 2: matInfo[ID][MatALG] = 2;
			}
			ShowPlayerDialog(playerid, DIALOG_ALLIGNMENT , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Allignment", "Left Allignment\nCenter Allignment\nRight Allignment", "Select", "Back");
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
		}
		case DIALOG_RESOLUTION:
		{
			if(!response) return ShowMatDialog(playerid);
			switch(listitem)
			{
				case 0: matInfo[ID][MatRes] = 10;
				case 1: matInfo[ID][MatRes] = 20;
				case 2: matInfo[ID][MatRes] = 30;
				case 3: matInfo[ID][MatRes] = 40;
				case 4: matInfo[ID][MatRes] = 50;
				case 5: matInfo[ID][MatRes] = 60;
				case 6: matInfo[ID][MatRes] = 70;
				case 7: matInfo[ID][MatRes] = 80;
				case 8: matInfo[ID][MatRes] = 90;
				case 9: matInfo[ID][MatRes] = 100;
				case 10: matInfo[ID][MatRes] = 110;
				case 11: matInfo[ID][MatRes] = 120;
				case 12: matInfo[ID][MatRes] = 130;
				case 13: matInfo[ID][MatRes] = 140;
			}
			ShowPlayerDialog(playerid, DIALOG_RESOLUTION , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Resolution", "32x32\n64x32\n64x64\n128x32\n128x64\n128x128\n256x32\n256x64\n256x128\n256x256\n512x64\n512x128\n512x256\n512x512", "Select", "Back");
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
		}
		case DIALOG_FONTSIZE:
		{
			if(!response) return ShowMatDialog(playerid);
			if(!isnumeric(inputtext))
			{
				ShowPlayerDialog(playerid, DIALOG_FONTSIZE , DIALOG_STYLE_INPUT, "Material Text - Font Size","Enter a Font Size\nMust be numeric", "Enter", "Close");
			}
			matInfo[ID][MatSize] = strval(inputtext);
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
			ShowMatDialog(playerid);
		}
		case DIALOG_FONT:
		{
			if(!response) return ShowMatDialog(playerid);
			format(matInfo[ID][MatFont],128,inputtext);
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
			new string[MAX_FONT_NAME+90];
			for(new a=0; a<sizeof(FontInfo); a++)
			{
				format(string, sizeof(string), "%s%s\n", string, FontInfo[a][FontName]);
			}
			ShowPlayerDialog(playerid, DIALOG_FONT , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Font", string, "Select", "Back");
		}
		case DIALOG_FONTCOLOR:
		{
			if(!response) return ShowMatDialog(playerid);
			switch(listitem)
			{
				case 0: matInfo[ID][MatColor] = MRED;
				case 1: matInfo[ID][MatColor] = MBLUE;
				case 2: matInfo[ID][MatColor] = MYELLOW;
				case 3: matInfo[ID][MatColor] = MORANGE;
				case 4: matInfo[ID][MatColor] = MPURPLE;
				case 5: matInfo[ID][MatColor] = MGREEN;
				case 6: matInfo[ID][MatColor] = MLBLUE;
				case 7: matInfo[ID][MatColor] = MWHITE;
				case 8: matInfo[ID][MatColor] =  MBLACK;
				case 9: matInfo[ID][MatColor] =  MCYAN;
				case 10: matInfo[ID][MatColor] =  MPINK;
				case 11: matInfo[ID][MatColor] =  MBROWN;
				case 12: matInfo[ID][MatColor] = MLPURPLE;
				case 13: matInfo[ID][MatColor] = MLGREEN;
				case 14: matInfo[ID][MatColor] = MGRAY;
			}
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
			ShowPlayerDialog(playerid, DIALOG_FONTCOLOR , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Color", ""MYRED"Red\n"MYBLUE"Blue\n"MYYELLOW"Yellow\n"MYORANGE"Orange\n"MYPURPLE"Purple\n"MYGREEN"Green\n"MYLBLUE"Light Blue\n"MYWHITE"White\n"MYBLACK"Black\n"MYCYAN"Cyan\n"MYPINK"Pink\n"MYBROWN"Brown\n"MYLPURPLE"Light Purple\n"MYLGREEN"Light Green\n"MYGREY"Gray", "Select", "Back");
		}
		case DIALOG_BGCOLOR:
		{
			if(!response) return ShowMatDialog(playerid);
			if(response)
			{
				if(pAdmin[playerid] != 6 && pDeveloper[playerid] != 1)
				{
					ShowMatDialog(playerid);
					Error(playerid,"You are not authorized to use this option !");
					return 1;
				}
				switch(listitem)
				{
					case 0:	matInfo[ID][MatBGC] = MRED;
					case 1: matInfo[ID][MatBGC] = MBLUE;
					case 2: matInfo[ID][MatBGC] = MYELLOW;
					case 3: matInfo[ID][MatBGC] = MORANGE;
					case 4: matInfo[ID][MatBGC] = MPURPLE;
					case 5: matInfo[ID][MatBGC] = MGREEN;
					case 6: matInfo[ID][MatBGC] = MLBLUE;
					case 7: matInfo[ID][MatBGC] = MWHITE;
					case 8: matInfo[ID][MatBGC] =  MBLACK;
					case 9: matInfo[ID][MatBGC] =  MCYAN;
					case 10: matInfo[ID][MatBGC] =  MPINK;
					case 11: matInfo[ID][MatBGC] =  MBROWN;
					case 12: matInfo[ID][MatBGC] = MLPURPLE;
					case 13: matInfo[ID][MatBGC] = MLGREEN;
					case 14: matInfo[ID][MatBGC] = MGRAY;
					case 15: matInfo[ID][MatBGC] = 0;
				}
				ShowPlayerDialog(playerid, DIALOG_BGCOLOR , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Background Color",""MYRED"Red\n"MYBLUE"Blue\n"MYYELLOW"Yellow\n"MYORANGE"Orange\n"MYPURPLE"Purple\n"MYGREEN"Green\n"MYLBLUE"Light Blue\n"MYWHITE"White\n"MYBLACK"Black\n"MYCYAN"Cyan\n"MYPINK"Pink\n"MYBROWN"Brown\n"MYLPURPLE"Light Purple\n"MYLGREEN"Light Green\n"MYGREY"Gray\nNo Background", "Select", "Back");
				CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
			}
		}
		case DIALOG_CHANGEOBJECT:
		{
		    if(!response) return ShowMatDialog(playerid);
			if(!isnumeric(inputtext)) return ShowPlayerDialog(playerid, DIALOG_CHANGEOBJECT , DIALOG_STYLE_INPUT, ""ORANGE_E"Server: "WHITE_E"Material Text - Change Object","Please enter an object ID to change!\n{FF0000}ERROR: Must be numeric", "Enter", "Back");

			DestroyDynamicObject(matInfo[ID][MatObj]);
		    matInfo[ID][MatObjectID] = strval(inputtext);
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
	  		ShowMatDialog(playerid);
	  		Streamer_UpdateEx(playerid, matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ]);
		}
		case DIALOG_CHANGEINDEX:
		{
		    if(!response) return ShowMatDialog(playerid);
			if(!isnumeric(inputtext)) return ShowPlayerDialog(playerid, DIALOG_CHANGEINDEX , DIALOG_STYLE_INPUT, ""ORANGE_E"Server: "WHITE_E"Material Text - Change Index","Please enter an material index to set the Text on, (0 to 15)!\n{FF0000}ERROR: Must be numeric.", "Enter", "Back");
	 		if(strval(inputtext) > 15 || strval(inputtext) < 0) return ShowPlayerDialog(playerid, DIALOG_CHANGEINDEX , DIALOG_STYLE_INPUT, ""ORANGE_E"Server: "WHITE_E"Material Text - Change Index","Please enter an material index to set the Text on, (0 to 15)!\n{FF0000}ERROR: Material index ranges from 0 to 15.", "Enter", "Back");
			DestroyDynamicObject(matInfo[ID][MatObj]);
		    matInfo[ID][MatIndex] = strval(inputtext);
			CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
			ShowMatDialog(playerid);
			Streamer_UpdateEx(playerid, matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ]);
		}
		case DIALOG_MATS:
		{
			if(response)
			{
				new string[400];
				switch(listitem)
				{
					case 0: ShowPlayerDialog(playerid, DIALOG_TEXT , DIALOG_STYLE_INPUT, "Material Text - Change Text", "Please input the text", "Select", "Back");
					case 1:
					{
						for(new a=0; a<sizeof(FontInfo); a++)
						{
							format(string, sizeof(string), "%s%s\n", string, FontInfo[a][FontName]);
						}
						ShowPlayerDialog(playerid, DIALOG_FONT , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Font", string, "Select", "Back");
					}
					case 2: ShowPlayerDialog(playerid, DIALOG_FONTCOLOR , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Color", ""MYRED"Red\n"MYBLUE"Blue\n"MYYELLOW"Yellow\n"MYORANGE"Orange\n"MYPURPLE"Purple\n"MYGREEN"Green\n"MYLBLUE"Light Blue\n"MYWHITE"White\n"MYBLACK"Black\n"MYCYAN"Cyan\n"MYPINK"Pink\n"MYBROWN"Brown\n"MYLPURPLE"Light Purple\n"MYLGREEN"Light Green\n"MYGREY"Gray", "Select", "Back");
					case 3: ShowPlayerDialog(playerid, DIALOG_FONTSIZE , DIALOG_STYLE_INPUT, "Material Text - Font Size","Please enter a font size for your Material\nMust be Numeric.", "Enter", "Back");
					case 4: ShowPlayerDialog(playerid, DIALOG_BGCOLOR , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Background Color",""MYRED"Red\n"MYBLUE"Blue\n"MYYELLOW"Yellow\n"MYORANGE"Orange\n"MYPURPLE"Purple\n"MYGREEN"Green\n"MYLBLUE"Light Blue\n"MYWHITE"White\n"MYBLACK"Black\n"MYCYAN"Cyan\n"MYPINK"Pink\n"MYBROWN"Brown\n"MYLPURPLE"Light Purple\n"MYLGREEN"Light Green\n"MYGREY"Gray\nNo Background", "Select", "Back");
					case 5: ShowPlayerDialog(playerid, DIALOG_ALLIGNMENT , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Allignment", "Left Allignment\nCenter Allignment\nRight Allignment", "Select", "Back");
					case 6:
					{
						if(matInfo[ID][MatBold] == 1)
						{
							matInfo[ID][MatBold] = 0;
							SendClientMessage(playerid,-1,""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"Material unbolded succesfully.");
						}
						else
						{
							matInfo[ID][MatBold] = 1;
							SendClientMessage(playerid,-1,""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"Material bolded succesfully.");
						}
						CreateMat(3,ID,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatRY],matInfo[ID][MatRZ]);
						ShowMatDialog(playerid);
					}
					case 7: ShowPlayerDialog(playerid, DIALOG_RESOLUTION , DIALOG_STYLE_LIST, ""ORANGE_E"Server: "WHITE_E"Material Text - Choose Resolution", "32x32\n64x32\n64x64\n128x32\n128x64\n128x128\n256x32\n256x64\n256x128\n256x256\n512x64\n512x128\n512x256\n512x512", "Select", "Back");
					case 8:
					{
						EditDynamicObject(playerid,matInfo[ID][MatObj]);
						SetPVarInt(playerid,"matID",ID);
					}
					case 9:
					{
						if(pAdmin[playerid] !=6 && pDeveloper[playerid] != 1)
						{
							if(CountMaterials(playerid) >= TOTAL_MAT) return Error(playerid, "You've reached the total amount of  Materials, Max Materials per player: "#TOTAL_MAT"");
						}
						new id = Iter_Free(MatsItr);
						matInfo[id][MatX] = matInfo[ID][MatX];
						matInfo[id][MatY] = matInfo[ID][MatY];
						matInfo[id][MatZ] = matInfo[ID][MatZ];
						matInfo[id][MatRX] = matInfo[ID][MatRX];
						matInfo[id][MatRY] = matInfo[ID][MatRY];
						matInfo[id][MatRZ] = matInfo[ID][MatRZ];
						matInfo[id][MatSize] = matInfo[ID][MatSize];
						matInfo[id][MatBGC] = matInfo[ID][MatBGC];
						matInfo[id][MatALG] = matInfo[ID][MatALG];
						matInfo[id][MatBold] = matInfo[ID][MatBold];
						matInfo[id][MatRes] = matInfo[ID][MatRes];
						matInfo[id][MatColor] = matInfo[ID][MatColor];
						matInfo[id][MatIndex] = matInfo[ID][MatIndex];
						matInfo[id][MatObjectID] = matInfo[ID][MatObjectID];
						
						SetPVarInt(playerid,"matID",id);
						format(matInfo[id][MatText],30,matInfo[ID][MatText]);
						format(matInfo[id][MatFont],30,matInfo[ID][MatFont]);
						CreateMat(2,id,matInfo[ID][MatX],matInfo[ID][MatY],matInfo[ID][MatZ],matInfo[ID][MatRX],matInfo[ID][MatY],matInfo[ID][MatZ]);
						EditDynamicObject(playerid,matInfo[id][MatObj]);
						format(string,sizeof(string),""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"Material ID %d succesfully duplicated on %d!",ID,id);
						SendClientMessage(playerid,-1,string);
						format(matInfo[id][MatOwner],MAX_PLAYER_NAME+1,GetName(playerid));
					}
					case 10:
					{
						foreach(new i : Player)
						{
							if(strcmp(GetName(i),matInfo[ID][MatOwner] , true) == 0)
							{
								format(string,sizeof(string),""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"Your material id: %d has been deleted !",ID);
								SendClientMessage(i,-1,string);
								format(query, sizeof(query), "DELETE FROM `materials` WHERE `MatID` = %d;",ID);
								mysql_query(g_SQL_handle, query);
								DeleteMat(ID);
								break;
							}
							else
							{
								format(query, sizeof(query), "DELETE FROM `materials` WHERE `MatID` = %d;",ID);
								mysql_query(g_SQL_handle, query);
	       						format(string,sizeof(string),""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"Material ID: %d has been deleted !",ID);
								SendClientMessage(playerid,-1,string);
								DeleteMat(ID);
								break;
							}
						}
					}
					case 11:
					{
						if(!CanPlayerTeleport(playerid)) return true;
						if(InDM[playerid] != 0)
						{
							Error(playerid, "You can't use this command while in DM!");
							return true;
						}
						if(doingStunt[playerid] != 0)
						{
							Error(playerid, "You can't use this command while in this area!");
							return true;
						}
						SetPlayerPosition(playerid, matInfo[ID][MatX], matInfo[ID][MatY]+3, matInfo[ID][MatZ], matInfo[ID][MatRZ]);
						format(string,sizeof(string),""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E"You've succesfully teleported to Material ID %d",ID);
						SendClientMessage(playerid,-1,string);
					}
					case 12: if(pAdmin[playerid] == 6 || pDeveloper[playerid] == 1) ShowPlayerDialog(playerid, DIALOG_CHANGEOBJECT , DIALOG_STYLE_INPUT, ""ORANGE_E"Server: "WHITE_E"Material Text","Please enter an object ID to change!", "Enter", "Back");
					case 13: if(pAdmin[playerid] == 6|| pDeveloper[playerid] == 1) ShowPlayerDialog(playerid, DIALOG_CHANGEINDEX , DIALOG_STYLE_INPUT, ""ORANGE_E"Server: "WHITE_E"Material Text","Please enter an material index to set the Text on, (0 to 15)!.", "Enter", "Back");
				}
			}
		}
	}
	return 0;
}
public MATERIAL_OPEDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	new string[100];
	new editing = GetPVarInt(playerid,"matID");

	if(response == EDIT_RESPONSE_UPDATE)
	{
	    SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
	}
 	if(response == EDIT_RESPONSE_CANCEL)
	{
		if(editing >= 0)
		{
			SendClientMessage(playerid, COLOR_RED,""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E" Material editing canceled !");
			DeletePVar(playerid, "matID");
  			ShowMatDialog(playerid);
			SOID[playerid] = editing;
		}
	}
 	if(response == EDIT_RESPONSE_FINAL)
	{
		SetDynamicObjectPos(objectid, x, y, z);
		SetDynamicObjectRot(objectid, rx, ry, rz);
		if(editing >= 0)
		{
			matInfo[editing][MatX] = x;
			matInfo[editing][MatY] = y;
			matInfo[editing][MatZ] = z;
			matInfo[editing][MatRX] = rx;
			matInfo[editing][MatRY] = ry;
			matInfo[editing][MatRZ] = rz;
		    format(string, sizeof(string), ""RED_E":: "WHITEP_E"Server "RED_E":: "LB2_E" You have succesfully edited ID: %d's Material", editing);
		    SendClientMessage(playerid, COLOR_RED, string);
   			DeletePVar(playerid, "matID");
		    SetDynamicObjectPos(objectid, x, y, z);
			SetDynamicObjectRot(objectid, rx, ry, rz);
			ShowMatDialog(playerid);
			SOID[playerid] = editing;
		}
	}
	return 1;
}
LoadMat(idx)
{
	format(query, sizeof(query), "SELECT * FROM materials WHERE MatID = %d",idx);
	new Cache:result = mysql_query(g_SQL_handle, query);
	if(cache_num_rows())
	{
    	matInfo[idx][MatX] = cache_get_field_content_float(0,"MatX");
		matInfo[idx][MatY] = cache_get_field_content_float(0,"MatY");
		matInfo[idx][MatZ] = cache_get_field_content_float(0,"MatZ");
		matInfo[idx][MatRX] = cache_get_field_content_float(0,"MatRX");
		matInfo[idx][MatRY] = cache_get_field_content_float(0,"MatRY");
		matInfo[idx][MatRZ] = cache_get_field_content_float(0,"MatRZ");
		cache_get_field_content(0, "MatText",matInfo[idx][MatText], MAX_TEXT);
		cache_get_field_content(0, "MatFont",matInfo[idx][MatFont], MAX_TEXT);
		cache_get_field_content(0, "MatOwner",matInfo[idx][MatOwner], MAX_TEXT);
		matInfo[idx][MatColor] = cache_get_field_content_int(0,"MatColor");
		matInfo[idx][MatSize] = cache_get_field_content_int(0,"MatSize");
		matInfo[idx][MatBGC] = cache_get_field_content_int(0,"MatBGC");
		matInfo[idx][MatALG] = cache_get_field_content_int(0,"MatALG");
		matInfo[idx][MatBold] = cache_get_field_content_int(0,"MatBold");
		matInfo[idx][MatRes] = cache_get_field_content_int(0,"MatRes");
		matInfo[idx][MatObjectID] = cache_get_field_content_int(0,"MatObjectID");
		matInfo[idx][MatIndex] = cache_get_field_content_int(0,"MatIndex");
	}
	cache_delete(result);
	return 1;
}
MaterialBanned(playerid)
{
	format(query, sizeof(query), "SELECT * FROM players WHERE name='%s' LIMIT 1", GetName(playerid));
 	mysql_query(g_SQL_handle, query);
	if(cache_num_rows())
	{
    	new banned = cache_get_field_content_int(0,"MaterialBanned");
    	if(banned == 1)
    	{
     		Error(playerid, "You are material banned! Contact with a Manager+ admin for unban.");
			return 0;
    	}
	}
	return 1;
}
SaveMat(idx)
{
	query[0] = EOS;
	format(query,sizeof(query),"DELETE FROM `materials` WHERE `MatID` = %d LIMIT 1" , idx);
 	MySQL_updateQuery(query);
	mysql_format(g_SQL_handle, query, sizeof(query), "INSERT INTO materials(MatID,MatX,MatY,MatZ,MatRX,MatRY,MatRZ,MatText,MatFont,MatOwner,MatColor,MatSize,MatBGC,MatALG,MatBold,MatRes,MatObjectID,MatIndex) VALUES(%d,%f,%f,%f,%f,%f,%f,'%e','%e','%e',%d,%d,%d,%d,%d,%d,%d,%d)",
		idx,
		matInfo[idx][MatX],
		matInfo[idx][MatY],
		matInfo[idx][MatZ],
		matInfo[idx][MatRX],
		matInfo[idx][MatRY],
		matInfo[idx][MatRZ],

		matInfo[idx][MatText],
		matInfo[idx][MatFont],
		matInfo[idx][MatOwner],

		matInfo[idx][MatColor],
		matInfo[idx][MatSize],
		matInfo[idx][MatBGC],
		matInfo[idx][MatALG],
		matInfo[idx][MatBold],
		matInfo[idx][MatRes],
		matInfo[idx][MatObjectID],
		matInfo[idx][MatIndex]);
	mysql_query(g_SQL_handle, query);
	return 1;
}
DeleteMat(i)
{
	matInfo[i][MatX] = 0;
	matInfo[i][MatY] = 0;
	matInfo[i][MatZ] = 0;
	matInfo[i][MatRX] = 0;
	matInfo[i][MatRY] = 0;
 	matInfo[i][MatRZ] = 0;
 	matInfo[i][MatText] = 0;
 	matInfo[i][MatOwner] = -1;
 	DestroyDynamicObject(matInfo[i][MatObj]);
 	matInfo[i][MatObj] = 0;
 	matInfo[i][MatSize] = 0;
 	matInfo[i][MatFont] = 0;
 	matInfo[i][MatColor] = 0;
    matInfo[i][MatBGC] = 0;
    matInfo[i][MatALG] = 0;
    matInfo[i][MatBold] = 0;
    matInfo[i][MatRes] = 0;
    matInfo[i][MatIndex] = 0;
    matInfo[i][MatObjectID] = 0;
 	Iter_Remove(MatsItr,i);
//	printf("Material ID: %d Deleted !",i);
	return 1;
}
public CreateMat(type,id,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
{
	if(type == 1)
	{
		matInfo[id][MatX] = x;
		matInfo[id][MatY] = y;
		matInfo[id][MatZ] = z;
		matInfo[id][MatRX] = rx;
		matInfo[id][MatRY] = ry;
		matInfo[id][MatRZ] = rz;
		matInfo[id][MatSize] = 40;
		matInfo[id][MatBGC] = 0;
	 	matInfo[id][MatALG] = 1;
	 	matInfo[id][MatBold] = 0;
	 	matInfo[id][MatRes] = 120;
	 	matInfo[id][MatIndex] = 0;
	}
	if(IsValidDynamicObject(matInfo[id][MatObj])) DestroyDynamicObject(matInfo[id][MatObj]);
	matInfo[id][MatObj] = CreateDynamicObject(matInfo[id][MatObjectID], matInfo[id][MatX] , matInfo[id][MatY], matInfo[id][MatZ], matInfo[id][MatRX], matInfo[id][MatRY], matInfo[id][MatRZ], 0);
	SetDynamicObjectMaterialText(matInfo[id][MatObj] , matInfo[id][MatIndex] , matInfo[id][MatText] , matInfo[id][MatRes],matInfo[id][MatFont], matInfo[id][MatSize], matInfo[id][MatBold] , matInfo[id][MatColor],matInfo[id][MatBGC],matInfo[id][MatALG]);
	if(!Iter_Contains(MatsItr,id)) Iter_Add(MatsItr,id);
	if(type != 3)
	{
		format(query, sizeof(query), "INSERT INTO materials(MatID,MatX,MatY,MatZ,MatRX,MatRY,MatRZ,MatText,MatFont,MatOwner,MatColor,MatSize,MatBGC,MatALG,MatBold,MatRes,MatObjectID,MatIndex) VALUES(%d,%f,%f,%f,%f,%f,%f,'%s','%s','%s',%d,%d,%d,%d,%d,%d,%d,%d)",
		id,
		matInfo[id][MatX],
		matInfo[id][MatY],
		matInfo[id][MatZ],
		matInfo[id][MatRX],
		matInfo[id][MatRY],
		matInfo[id][MatRZ],

		matInfo[id][MatText],
		matInfo[id][MatFont],
		matInfo[id][MatOwner],

		matInfo[id][MatColor],
		matInfo[id][MatSize],
		matInfo[id][MatBGC],
		matInfo[id][MatALG],
		matInfo[id][MatBold],
		matInfo[id][MatRes],
		matInfo[id][MatObjectID],
		matInfo[id][MatIndex]);
		mysql_query(g_SQL_handle, query);
	}
	SaveMat(id);
	foreach(new ii : Player)
	{
	    Streamer_UpdateEx(ii, matInfo[id][MatX],matInfo[id][MatY],matInfo[id][MatZ]);
	}
}
