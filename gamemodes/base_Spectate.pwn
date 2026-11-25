// Spectating System
#include <YSI\y_hooks>
new
	PlayerText: _TD_see_player[MAX_PLAYERS][22],
	PlayerText: _TD_see_vehicle[MAX_PLAYERS][27],
	cmdstr[144];

// OnGamoeModeInit
	timer();




hook OnPlayerDisconnect(playerid, reason)
{
	if(GetPVarInt(playerid, "see_type") != 0)
	{
		if(GetPVarInt(playerid, "see_type") == 1) for(new i = 0; i < 22; i++) PlayerTextDrawHide(playerid, _TD_see_player[playerid][i]), loadSeeTextDraws(playerid, 3);
		else if(GetPVarInt(playerid, "see_type") == 2) for(new i = 0; i < 27; i++) PlayerTextDrawHide(playerid, _TD_see_vehicle[playerid][i]), loadSeeTextDraws(playerid, 4);
		pSpectating[playerid] = -1, DeletePVar(playerid, "see_type");
		DeletePVar(playerid, "see_selectable");
	}
	if(GetPVarInt(playerid, "see_type") == 1) loadSeeTextDraws(playerid, 3);
	if(GetPVarInt(playerid, "see_type") == 2) loadSeeTextDraws(playerid, 4);
	return 1;
}
hook OnPlayerUpdate(playerid)
{
	if(GetPVarInt(playerid, "see_type") == 1)
	{
		new Float: hparm[2];
		GetPlayerHealth(pSpectating[playerid], hparm[0]);
		GetPlayerArmour(pSpectating[playerid], hparm[1]);
		format(cmdstr, sizeof cmdstr, "HEALTH~n~%.1f", hparm[0]), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][6], cmdstr);
		format(cmdstr, sizeof cmdstr, "ARMOUR~n~%.1f", hparm[1]), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][7], cmdstr);
	}
	else if(GetPVarInt(playerid, "see_type") == 2)
	{
		new Float: hparm[3];
		GetPlayerHealth(pSpectating[playerid], hparm[0]);
		GetPlayerArmour(pSpectating[playerid], hparm[1]);
		GetVehicleHealth(GetPlayerVehicleID(pSpectating[playerid]), hparm[2]);
		format(cmdstr, sizeof cmdstr, "PHEALTH~n~%.1f", hparm[0]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][6], cmdstr);
		format(cmdstr, sizeof cmdstr, "PARMOUR~n~%.1f", hparm[1]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][7], cmdstr);
		format(cmdstr, sizeof cmdstr, "VHEALTH~n~%.1f", hparm[2]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][8], cmdstr);
		//format(cmdstr, sizeof cmdstr, "SPEED_~n~%i_km/h", vSpeed[pSpectating[playerid]]);
		PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][23], cmdstr);
	}
	return 1;
}



stock SCMADM(adml, string[])
{
	new outstring[144];
	foreach(new i : Player) if(GetPVarInt(i, "pld_admin") >= adml) //format(outstring, sizeof outstring, "[ADMMSG] "ccWhite"%s", string), SCM(i, cYellow, outstring);
	// GetPVarInt(i, "pld_admin") - ???????? ?? ???? ???? / ?????? ???. ?????? ??????
	return 1;
}

stock getVehicleSpeed(veh)
{
	new Float:c[3], Float:speed;
	GetVehicleVelocity(veh, c[0], c[1], c[2]);
	speed = floatsqroot(c[0]*c[0]+c[1]*c[1]+c[2]*c[2]);
	return floatround(speed * 100);
}

stock loadSeeTextDraws(playerid, type) // type 1 == create_player | 2 == create vehicle | 3 == destroy_player | 4 == destroy_vehicle
{
	if(type == 1)
	{
	// specplayer:
		_TD_see_player[playerid][0] = CreatePlayerTextDraw(playerid, 1.999997, 422.620147, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][0], 0.000000, 2.338148);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][0], 637.199890, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][0], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][0], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][0], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][0], 342116641);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][0], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][0], 0);

		_TD_see_player[playerid][1] = CreatePlayerTextDraw(playerid, 319.199615, 405.440277, "Eugen_McLuhan");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][1], 0.329997, 1.353597);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][1], -37.599994, -32.853336);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][1], 2);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][1], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][1], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][1], 1);

		_TD_see_player[playerid][2] = CreatePlayerTextDraw(playerid, 413.122772, 392.006713, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][2], 0.000000, 2.722903);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][2], 222.400085, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][2], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][2], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][2], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][2], 338969393);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][2], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][2], 0);

		_TD_see_player[playerid][3] = CreatePlayerTextDraw(playerid, 241.599945, 387.519836, "LEFT");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][3], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][3], 241.599945+35.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][3], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][3], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][3], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][3], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][3], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_player[playerid][3], true);

		_TD_see_player[playerid][4] = CreatePlayerTextDraw(playerid, 354.399841, 386.773315, "RIGHT");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][4], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][4], 354.399841+45.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][4], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][4], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][4], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][4], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_player[playerid][4], true);

		_TD_see_player[playerid][5] = CreatePlayerTextDraw(playerid, 314.399566, 390.506713, "ID: 1000");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][5], 0.307599, 1.398398);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][5], 2);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][5], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][5], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][5], 2);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][5], 1);

		_TD_see_player[playerid][6] = CreatePlayerTextDraw(playerid, 71.199996, 418.880126, "HEALTH~n~160.0");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][6], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][6], 2);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][6], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][6], 1);

		_TD_see_player[playerid][7] = CreatePlayerTextDraw(playerid, 214.400100, 418.880065, "ARMOUR~n~160.0");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][7], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][7], 2);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][7], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][7], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][7], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][7], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][7], 1);

		_TD_see_player[playerid][8] = CreatePlayerTextDraw(playerid, 318.133392, 418.133605, "INT~n~100");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][8], 0.509199, 1.465597);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][8], 2);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][8], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][8], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][8], 1);

		_TD_see_player[playerid][9] = CreatePlayerTextDraw(playerid, 437.599029, 418.133850, "WORLD~n~1000000000");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][9], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][9], 2);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][9], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][9], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][9], 1);

		_TD_see_player[playerid][10] = CreatePlayerTextDraw(playerid, 575.999816, 418.880279, "CASH~n~$100000");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][10], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][10], 2);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][10], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][10], 1);

		_TD_see_player[playerid][11] = CreatePlayerTextDraw(playerid, 154.000000, 424.113525, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][11], 0.000000, 2.172219);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][11], 146.800003, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][11], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][11], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][11], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][11], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][11], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][11], 0);

		_TD_see_player[playerid][12] = CreatePlayerTextDraw(playerid, 276.399749, 423.366943, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][12], 0.000000, 2.086296);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][12], 270.799804, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][12], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][12], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][12], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][12], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][12], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][12], 0);

		_TD_see_player[playerid][13] = CreatePlayerTextDraw(playerid, 371.599945, 421.873504, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][13], 0.000000, 2.089261);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][13], 364.399932, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][13], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][13], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][13], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][13], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][13], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][13], 0);

		_TD_see_player[playerid][14] = CreatePlayerTextDraw(playerid, 513.999816, 423.366760, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][14], 0.000000, 2.255182);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][14], 506.799835, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][14], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][14], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][14], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][14], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][14], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][14], 0);

		_TD_see_player[playerid][15] = CreatePlayerTextDraw(playerid, 410.799835, 406.939910, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][15], 0.000000, -0.731481);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][15], 226.800033, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][15], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][15], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][15], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][15], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][15], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][15], 0);

		_TD_see_player[playerid][16] = CreatePlayerTextDraw(playerid, 488.799804, 147.840270, "ADMINS_HERE:");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][16], 0.326799, 1.039996);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][16], -28.000001, 2.986665);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][16], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][16], -1061109505);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][16], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][16], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][16], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][16], 1);

		_TD_see_player[playerid][17] = CreatePlayerTextDraw(playerid, 282.799987, 392.753326, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][17], 0.000000, 0.927775);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][17], 275.600006, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][17], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][17], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][17], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][17], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][17], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][17], 0);

		_TD_see_player[playerid][18] = CreatePlayerTextDraw(playerid, 348.399993, 392.753326, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][18], 0.000000, 0.927775);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][18], 342.799987, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][18], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][18], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][18], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][18], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][18], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][18], 0);

		_TD_see_player[playerid][19] = CreatePlayerTextDraw(playerid, 2.000000, 421.873321, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][19], 0.000000, -0.565554);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][19], 637.199951, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][19], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][19], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_player[playerid][19], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_player[playerid][19], 626132049);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][19], 0);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][19], 0);

		_TD_see_player[playerid][20] = CreatePlayerTextDraw(playerid, 297.226470, 375.573486, "SLAP");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][20], 0.445998, 1.338665);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][20], 297.226470+35.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][20], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][20], -1523963137);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][20], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][20], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][20], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][20], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_player[playerid][20], true);

		_TD_see_player[playerid][21] = CreatePlayerTextDraw(playerid, 290.399993, 337.493316, "CLOSE");
		PlayerTextDrawLetterSize(playerid, _TD_see_player[playerid][21], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid, _TD_see_player[playerid][21], 290.399993+45.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_player[playerid][21], 1);
		PlayerTextDrawColor(playerid, _TD_see_player[playerid][21], -16776961);
		PlayerTextDrawSetShadow(playerid, _TD_see_player[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_player[playerid][21], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_player[playerid][21], 51);
		PlayerTextDrawFont(playerid, _TD_see_player[playerid][21], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_player[playerid][21], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_player[playerid][21], true);
	}
	else if(type == 2)
	{
	// specvehicle:
		_TD_see_vehicle[playerid][0] = CreatePlayerTextDraw(playerid, 1.999997, 422.620147, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][0], 0.000000, 2.338148);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][0], 637.199890, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][0], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][0], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][0], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][0], 342116641);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][0], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][0], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][0], 0);

		_TD_see_vehicle[playerid][1] = CreatePlayerTextDraw(playerid, 319.199615, 405.440277, "Eugen_McLuhan");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][1], 0.329997, 1.353597);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][1], -37.599994, -32.853336);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][1], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][1], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][1], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][1], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][1], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][1], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][1], 1);

		_TD_see_vehicle[playerid][2] = CreatePlayerTextDraw(playerid, 414.723632, 376.646728, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][2], 0.000000, 4.399998);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][2], 221.923736, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][2], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][2], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][2], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][2], 338969393);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][2], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][2], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][2], 0);

		_TD_see_vehicle[playerid][3] = CreatePlayerTextDraw(playerid, 241.599945, 387.519836, "LEFT");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][3], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][3], 241.599945+35.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][3], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][3], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][3], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][3], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][3], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][3], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][3], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_vehicle[playerid][3], true);

		_TD_see_vehicle[playerid][4] = CreatePlayerTextDraw(playerid, 354.399841, 386.773315, "RIGHT");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][4], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][4], 354.399841+45.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][4], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][4], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][4], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][4], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][4], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][4], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][4], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_vehicle[playerid][4], true);

		_TD_see_vehicle[playerid][5] = CreatePlayerTextDraw(playerid, 314.399566, 390.506713, "ID: 1000");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][5], 0.307599, 1.398398);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][5], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][5], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][5], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][5], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][5], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][5], 2);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][5], 1);

		_TD_see_vehicle[playerid][6]  = CreatePlayerTextDraw(playerid, 51.199996, 418.880126, "PHEALTH~n~160.0");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][6], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][6], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][6], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][6], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][6], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][6], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][6], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][6], 1);

		_TD_see_vehicle[playerid][7] = CreatePlayerTextDraw(playerid, 150.400100, 418.880065, "PARMOUR~n~160.0");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][7], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][7], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][7], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][7], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][7], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][7], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][7], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][7], 1);

		_TD_see_vehicle[playerid][8] = CreatePlayerTextDraw(playerid, 250.133392, 418.133605, "VHEALTH~n~1000.0");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][8], 0.509199, 1.465597);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][8], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][8], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][8], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][8], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][8], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][8], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][8], 1);

		_TD_see_vehicle[playerid][9] = CreatePlayerTextDraw(playerid, 357.599029, 418.133850, "WORLD~n~1000000000");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][9], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][9], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][9], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][9], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][9], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][9], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][9], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][9], 1);

		_TD_see_vehicle[playerid][10] = CreatePlayerTextDraw(playerid, 455.999816, 418.880279, "CASH~n~$100000");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][10], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][10], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][10], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][10], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][10], 0);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][10], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][10], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][10], 1);

		_TD_see_vehicle[playerid][11] = CreatePlayerTextDraw(playerid, 102.000000, 424.113525, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][11], 0.000000, 2.172219);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][11], 94.800003, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][11], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][11], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][11], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][11], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][11], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][11], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][11], 0);

		_TD_see_vehicle[playerid][12] = CreatePlayerTextDraw(playerid, 200.399749, 423.366943, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][12], 0.000000, 2.486294);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][12], 194.799804, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][12], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][12], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][12], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][12], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][12], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][12], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][12], 0);

		_TD_see_vehicle[playerid][13] = CreatePlayerTextDraw(playerid, 303.599945, 421.873504, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][13], 0.000000, 2.489259);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][13], 296.399932, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][13], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][13], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][13], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][13], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][13], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][13], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][13], 0);

		_TD_see_vehicle[playerid][14] = CreatePlayerTextDraw(playerid, 413.999816, 423.366760, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][14], 0.000000, 2.255182);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][14], 406.799835, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][14], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][14], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][14], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][14], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][14], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][14], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][14], 0);

		_TD_see_vehicle[playerid][15] = CreatePlayerTextDraw(playerid, 410.799835, 406.939910, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][15], 0.000000, -0.731481);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][15], 226.800033, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][15], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][15], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][15], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][15], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][15], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][15], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][15], 0);

		_TD_see_vehicle[playerid][16] = CreatePlayerTextDraw(playerid, 488.799804, 147.840270, "ADMINS_HERE:");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][16], 0.326799, 1.039996);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][16], -28.000001, 2.986665);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][16], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][16], -1061109505);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][16], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][16], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][16], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][16], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][16], 1);

		_TD_see_vehicle[playerid][17] = CreatePlayerTextDraw(playerid, 282.799987, 392.753326, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][17], 0.000000, 0.927775);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][17], 275.600006, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][17], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][17], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][17], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][17], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][17], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][17], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][17], 0);

		_TD_see_vehicle[playerid][18] = CreatePlayerTextDraw(playerid, 348.399993, 392.753326, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][18], 0.000000, 0.927775);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][18], 342.799987, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][18], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][18], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][18], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][18], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][18], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][18], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][18], 0);

		_TD_see_vehicle[playerid][19] = CreatePlayerTextDraw(playerid, 2.000000, 421.873321, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][19], 0.000000, -0.565554);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][19], 637.199951, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][19], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][19], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][19], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][19], 626132049);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][19], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][19], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][19], 0);

		_TD_see_vehicle[playerid][20] = CreatePlayerTextDraw(playerid, 415.626403, 405.440185, "CARBREAK");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][20], 0.445998, 1.338665);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][20], 415.626403+62.5, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][20], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][20], -1523963137);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][20], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][20], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][20], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][20], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][20], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_vehicle[playerid][20], true);

		_TD_see_vehicle[playerid][21] = CreatePlayerTextDraw(playerid, 319.199645, 372.586883, "Police Car (LSPF) - 597");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][21], 0.360399, 1.592532);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][21], 2);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][21], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][21], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][21], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][21], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][21], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][21], 1);

		_TD_see_vehicle[playerid][22] = CreatePlayerTextDraw(playerid, 509.200012, 422.619995, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][22], 0.000000, 2.504070);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][22], 502.000000, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][22], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][22], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][22], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][22], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][22], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][22], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][22], 0);

		_TD_see_vehicle[playerid][23] = CreatePlayerTextDraw(playerid, 631.199768, 418.133422, "SPEED ~n~200 km/h");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][23], 0.449999, 1.600000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][23], 3);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][23], -1);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][23], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][23], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][23], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][23], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][23], 1);

		_TD_see_vehicle[playerid][24] = CreatePlayerTextDraw(playerid, 187.199981, 403.946655, "SLAP");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][24], 0.449999, 1.450667);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][24], 187.199981+35.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][24], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][24], -1523963137);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][24], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][24], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][24], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][24], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][24], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_vehicle[playerid][24], true);

		_TD_see_vehicle[playerid][25] = CreatePlayerTextDraw(playerid, 410.800018, 389.766693, "usebox");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][25], 0.000000, -0.565554);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][25], 227.600006, 0.000000);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][25], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][25], 0);
		PlayerTextDrawUseBox(playerid, _TD_see_vehicle[playerid][25], true);
		PlayerTextDrawBoxColor(playerid, _TD_see_vehicle[playerid][25], 102);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][25], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][25], 0);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][25], 0);


		_TD_see_vehicle[playerid][26] = CreatePlayerTextDraw(playerid, 290.399993, 337.493316, "CLOSE");
		PlayerTextDrawLetterSize(playerid, _TD_see_vehicle[playerid][26], 0.449999, 1.600000);
		PlayerTextDrawTextSize(playerid, _TD_see_vehicle[playerid][26], 290.399993+45.0, 15.0);
		PlayerTextDrawAlignment(playerid, _TD_see_vehicle[playerid][26], 1);
		PlayerTextDrawColor(playerid, _TD_see_vehicle[playerid][26], -16776961);
		PlayerTextDrawSetShadow(playerid, _TD_see_vehicle[playerid][26], 0);
		PlayerTextDrawSetOutline(playerid, _TD_see_vehicle[playerid][26], 1);
		PlayerTextDrawBackgroundColor(playerid, _TD_see_vehicle[playerid][26], 51);
		PlayerTextDrawFont(playerid, _TD_see_vehicle[playerid][26], 1);
		PlayerTextDrawSetProportional(playerid, _TD_see_vehicle[playerid][26], 1);
		PlayerTextDrawSetSelectable(playerid, _TD_see_vehicle[playerid][26], true);
	}
	else if(type == 3) for(new i = 0; i < 22; i++) PlayerTextDrawDestroy(playerid, _TD_see_player[playerid][i]);
	else if(type == 4) for(new i = 0; i < 27; i++) PlayerTextDrawDestroy(playerid, _TD_see_vehicle[playerid][i]);
	return 1;
}

stock updateSeeTextDraws(playerid, sspi) // sspi == 1 - LEFT or RIGHT
{
	new sseeplayerid = GetPVarInt(playerid, "see_playerid");
	new Float: hparm[3];
	GetPlayerHealth(sseeplayerid, hparm[0]), GetPlayerArmour(sseeplayerid, hparm[1]);
	if(GetPlayerInterior(playerid) != GetPlayerInterior(sseeplayerid)) SetPlayerInterior(playerid, GetPlayerInterior(sseeplayerid));
	if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(sseeplayerid)) SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(sseeplayerid));
	if(!IsPlayerInAnyVehicle(sseeplayerid))
	{
		if(GetPVarInt(playerid, "see_type") == 2)
		{
			for(new i = 0; i < 27; i++) PlayerTextDrawHide(playerid, _TD_see_vehicle[playerid][i]);
			loadSeeTextDraws(playerid, 4); // vehicle
			loadSeeTextDraws(playerid, 1); // player
			for(new i = 0; i < 22; i++) PlayerTextDrawShow(playerid, _TD_see_player[playerid][i]);
			PlayerSpectatePlayer(playerid, sseeplayerid);
		}
		SetPVarInt(playerid, "see_type", 1);
		if(sspi == 1) PlayerSpectatePlayer(playerid, sseeplayerid);
		format(cmdstr, sizeof cmdstr, "%s", pName[sseeplayerid]), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][1], cmdstr);
		format(cmdstr, sizeof cmdstr, "ID: %i", sseeplayerid), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][5], cmdstr);
		format(cmdstr, sizeof cmdstr, "INT~n~%i", GetPlayerInterior(sseeplayerid)), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][8], cmdstr);
		format(cmdstr, sizeof cmdstr, "WORLD~n~%d", GetPlayerVirtualWorld(sseeplayerid)), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][9], cmdstr);
		format(cmdstr, sizeof cmdstr, "CASH~n~$%d", GetPVarInt(sseeplayerid, "pld_cash")), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][10], cmdstr);
		new adminsHere[1+12+((3+1+MAX_PLAYER_NAME) * 10)], count = 2;
		format(adminsHere, sizeof adminsHere, "ADMINS_HERE:~n~1_%s", pName[playerid]);
		foreach(new j : Player) if((GetPVarInt(j, "see_playerid") == sseeplayerid) && (j != playerid)) format(cmdstr, sizeof cmdstr, "~n~%i_%s", count, pName[j]), strcat(adminsHere, cmdstr), count++;
		PlayerTextDrawSetString(playerid, _TD_see_player[playerid][16], adminsHere);
	}
	else
	{
		if(GetPVarInt(playerid, "see_type") == 1)
		{
			for(new i = 0; i < 22; i++) PlayerTextDrawHide(playerid, _TD_see_player[playerid][i]);
			loadSeeTextDraws(playerid, 3); // player
			loadSeeTextDraws(playerid, 2); // vehicle
			for(new i = 0; i < 27; i++) PlayerTextDrawShow(playerid, _TD_see_vehicle[playerid][i]);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(sseeplayerid));
		}
		SetPVarInt(playerid, "see_type", 2);
		if(sspi == 1) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(sseeplayerid));
		GetVehicleHealth(GetPlayerVehicleID(sseeplayerid), hparm[2]);
		format(cmdstr, sizeof cmdstr, "%s", pName[sseeplayerid]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][1], cmdstr);
		format(cmdstr, sizeof cmdstr, "ID: %i", sseeplayerid), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][5], cmdstr);
		format(cmdstr, sizeof cmdstr, "WORLD~n~%d", GetPlayerVirtualWorld(sseeplayerid)), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][9], cmdstr);
		format(cmdstr, sizeof cmdstr, "CASH~n~$%d", GetPVarInt(sseeplayerid, "pld_cash")), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][10], cmdstr);
		format(cmdstr, sizeof cmdstr, "%s_-_%i", vehName[GetVehicleModel(GetPlayerVehicleID(sseeplayerid))-400], GetVehicleModel(GetPlayerVehicleID(sseeplayerid))), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][21], cmdstr);
		new adminsHere[1+12+((3+1+MAX_PLAYER_NAME) * 10)], count = 2;
		format(adminsHere, sizeof adminsHere, "ADMINS_HERE:~n~1_%s", pName[playerid]);
		foreach(new j : Player) if((GetPVarInt(j, "see_playerid") == sseeplayerid) && (j != playerid)) format(cmdstr, sizeof cmdstr, "~n~%i_%s", count, pName[j]), strcat(adminsHere, cmdstr), count++;
		PlayerTextDrawSetString(playerid, _TD_see_player[playerid][16], adminsHere);
	}
	return 1;
}

task timer[1000]()
{
	foreach(new i : Player) if((GetPlayerState(i) == PLAYER_STATE_SPECTATING) && (GetPVarInt(i, "see_type") > 0)) updateSeeTextDraws(i, 0);
	return 1;
}

YCMD:see(playerid, params[], help)
{
	// if: ????????????? ?? ??
	if(sscanf(params, "u", params[0])) return SCM(playerid, -1, ""MSGUSE"/see "MSGUSE2"");
	if(params[0] == playerid) return SCM(playerid, -1, ""MSGERROR"?????? ????????? ?? ?????.");
	// if: ????????????? ?? ???? ?????
	if(GetPVarInt(playerid, "see_type") == 1) loadSeeTextDraws(playerid, 3);
	if(GetPVarInt(playerid, "see_type") == 2) loadSeeTextDraws(playerid, 4);
	format(cmdstr, sizeof cmdstr, ""ccRed"[ADMSEE] ????? (%i) %s.    ( ???????? ?????? - ???????? ???? | ?????? - ESC )", params[0], pName[params[0]]), SCM(playerid, -1, cmdstr);
	loadSeeTextDraws(playerid, 1); // player
	loadSeeTextDraws(playerid, 2); // vehicle
	new Float: hparm[3];
	GetPlayerHealth(params[0], hparm[0]);
	GetPlayerArmour(params[0], hparm[1]);
	if(GetPlayerInterior(playerid) != GetPlayerInterior(params[0])) SetPlayerInterior(playerid, GetPlayerInterior(params[0]));
	if(GetPlayerVirtualWorld(playerid) != GetPlayerVirtualWorld(params[0])) SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(params[0]));
/*
	==! ??????? ???? ????? ???????????, ????, ? ??? ?????? ?? ?? ??????????? ???????????
	==? ?????? ????????? ??? ?????? ?????????? (????? ??? ?????? ??????? ?? ??? ?? ??????????)
	if(GetPVarInt(playerid, "see_type") < 1)
	{
		new Float: pos[4];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]), GetPlayerFacingAngle(playerid, pos[3]);
		new value[44];
		format(value, sizeof value, "%i,%d", GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid)), updAccString(playerid, "saveIntVW", value);
		format(value, sizeof value, "%f,%f,%f,%f", pos[0], pos[1], pos[2], pos[3]), updAccString(playerid, "savePos", value);
	}
*/
	TogglePlayerSpectating(playerid, 1);
	if(!IsPlayerInAnyVehicle(params[0]))
	{
		SetPVarInt(playerid, "see_type", 1);
		PlayerSpectatePlayer(playerid, params[0]);
		for(new i = 0; i < 22; i++) PlayerTextDrawShow(playerid, _TD_see_player[playerid][i]);
		format(cmdstr, sizeof cmdstr, "%s", pName[params[0]]), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][1], cmdstr);
		format(cmdstr, sizeof cmdstr, "ID: %i", params[0]), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][5], cmdstr);
		format(cmdstr, sizeof cmdstr, "HEALTH~n~%.1f", hparm[0]), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][6], cmdstr);
		format(cmdstr, sizeof cmdstr, "ARMOUR~n~%.1f", hparm[1]), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][7], cmdstr);
		format(cmdstr, sizeof cmdstr, "INT~n~%i", GetPlayerInterior(params[0])), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][8], cmdstr);
		format(cmdstr, sizeof cmdstr, "WORLD~n~%d", GetPlayerVirtualWorld(params[0])), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][9], cmdstr);
		format(cmdstr, sizeof cmdstr, "CASH~n~$%d", GetPVarInt(params[0], "pld_cash")), PlayerTextDrawSetString(playerid, _TD_see_player[playerid][10], cmdstr);
		new adminsHere[1+12+((3+1+MAX_PLAYER_NAME) * 10)], count = 2;
		format(adminsHere, sizeof adminsHere, "ADMINS_HERE:~n~1_%s", pName[playerid]);
		foreach(new j : Player) if((GetPVarInt(j, "see_playerid") == params[0]) && (j != playerid)) format(cmdstr, sizeof cmdstr, "~n~%i_%s", count, pName[j]), strcat(adminsHere, cmdstr), count++;
		PlayerTextDrawSetString(playerid, _TD_see_player[playerid][16], adminsHere);
	}
	else
	{
		SetPVarInt(playerid, "see_type", 2);
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(params[0]));
		for(new i = 0; i < 27; i++) PlayerTextDrawShow(playerid, _TD_see_vehicle[playerid][i]);
		GetVehicleHealth(GetPlayerVehicleID(params[0]), hparm[2]);
		format(cmdstr, sizeof cmdstr, "%s", pName[params[0]]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][1], cmdstr);
		format(cmdstr, sizeof cmdstr, "ID: %i", params[0]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][5], cmdstr);
		format(cmdstr, sizeof cmdstr, "PHEALTH~n~%.1f", hparm[0]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][6], cmdstr);
		format(cmdstr, sizeof cmdstr, "PARMOUR~n~%.1f", hparm[1]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][7], cmdstr);
		format(cmdstr, sizeof cmdstr, "VHEALTH~n~%.1f", hparm[2]), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][8], cmdstr);
		format(cmdstr, sizeof cmdstr, "WORLD~n~%d", GetPlayerVirtualWorld(params[0])), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][9], cmdstr);
		format(cmdstr, sizeof cmdstr, "CASH~n~$%d", GetPVarInt(params[0], "pld_cash")), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][10], cmdstr);
		format(cmdstr, sizeof cmdstr, "%s_-_%i", vehName[GetVehicleModel(GetPlayerVehicleID(params[0]))-400], GetVehicleModel(GetPlayerVehicleID(params[0]))), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][21], cmdstr);
		format(cmdstr, sizeof cmdstr, "SPEED_~n~%i_km/h", getVehicleSpeed(GetPlayerVehicleID(params[0]))), PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][23], cmdstr);
		new adminsHere[1+12+((3+1+MAX_PLAYER_NAME) * 10)], count = 2;
		format(adminsHere, sizeof adminsHere, "ADMINS_HERE:~n~1_%s", pName[playerid]);
		foreach(new j : Player) if((GetPVarInt(j, "see_playerid") == params[0]) && (j != playerid)) format(cmdstr, sizeof cmdstr, "~n~%i_%s", count, pName[j]), strcat(adminsHere, cmdstr), count++;
		PlayerTextDrawSetString(playerid, _TD_see_vehicle[playerid][16], adminsHere);
	}
	pSpectating[playerid] = params[0];
	SetPVarInt(playerid, "see_selectable", 0);
	return 1;
}
