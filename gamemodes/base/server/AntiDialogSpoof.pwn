/*
				Server - xTreme Stunt Freeroam (c) 2017
				Anti-Dialog spoof system
				Author: J0shES
				
				This will stop our good old friend ban evader #1! (I don't want to give him credit.)

*/

#include <YSI\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
/*	if(GetPVarInt(playerid, "dialogID") != dialogid) {
		SetPVarInt(playerid, "spoofed", gettime()+1);
		format(str, sizeof(str), ""RED_E"* ADMIN MSG: "GREY_E"%s(%i) attempted to spoof a Dialog ID! (%i %i)", pName[playerid], playerid, GetPVarInt(playerid, "dialogID"), dialogid);
		foreach(new i : Player) { if(Helper[i] == 3 || pAdmin[i]) SendClientMessage(i, COLOR_RED, str); }
		format(str, sizeof(str), "4Server:3 %s(%i) attempted to spoof a Dialog ID!", pName[playerid], playerid);
		IRC_GroupSay(ircGroup, IRC_aCHANNEL, str);
		return 0;
	}*/
	return 1;
}
