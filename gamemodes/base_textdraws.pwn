// Server Textdraw Script

//[Textdraws]
new Text:helpTD,
	Text:InfoTD2,
	Text:godTD,
	Text:raceCT,
	Text:parkourCT,
	Text:derbyCT,
	Text:xmasTD[2],
	Text:SEv2Box,
	Text:wTD,
	Text:wTD1,
	Text:wTD2,
	Text:wTD3,
	Text:wTD4,
	Text:wTD5,
	Text:wTD6,
	Text:wTD7,
	Text:wTD8,
	Text:wTD9,
	Text:killCamTD,
	Text:killCamTD1,
	Text:msgTD,
	Text:DMTextdraw,
	Text:TeleTD,
	Text:CheckTD,
	Text:ErrorTD,
	Text:NewMsgTD,
	Text:cnrTD,
	Text:cnrTD2,
	Text:letterbox[4],
	Text:AchTD[6],
	Text:ConnectTD[12],
	Text:JailTD,
	Text:vSpeedBox,
	Text:Task_TD,
	PlayerText:Task_PTD[MAX_PLAYERS][3],
	PlayerText:duelCT[MAX_PLAYERS],
	PlayerText:DynamicAchTD[MAX_PLAYERS][2],
	PlayerText:vTD[MAX_PLAYERS],
	PlayerText:vSpeed[MAX_PLAYERS],
	PlayerText:InfoTD[MAX_PLAYERS],
	PlayerText:killCamTD8[MAX_PLAYERS],
	PlayerText:NameX[MAX_PLAYERS],
	PlayerText:killStreakTD[MAX_PLAYERS],
	PlayerText:HealthTD[MAX_PLAYERS],
	PlayerText:Armour[MAX_PLAYERS];

	new Text:Server_TD[7];


new Text:DerbyTD1,
	Text:DerbyTD2;
	
new Text:FalloutTD1,
	Text:FalloutTD2;
	
new PlayerText:RaceTD1[MAX_PLAYERS],
	Text:RaceTD2;
	
new PlayerText:ParkourTD1[MAX_PLAYERS],
	Text:ParkourTD2;

// Textdraws
CreatePlayerTextDraws(playerid)
{
	Task_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 26.400001, 167.033264, "-_Kill_10_Enemies_(0/10)");
	PlayerTextDrawLetterSize(playerid, Task_PTD[playerid][0], 0.197500, 0.806666);
	PlayerTextDrawAlignment(playerid, Task_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, Task_PTD[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, Task_PTD[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Task_PTD[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, Task_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, Task_PTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Task_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Task_PTD[playerid][0], 0);

	Task_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 26.900001, 179.100402, "-_Win_a_parkour");
	PlayerTextDrawLetterSize(playerid, Task_PTD[playerid][1], 0.197500, 0.806666);
	PlayerTextDrawAlignment(playerid, Task_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, Task_PTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, Task_PTD[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Task_PTD[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, Task_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, Task_PTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, Task_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Task_PTD[playerid][1], 0);

	Task_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 26.900001, 190.901123, "-_Win_a_Fallout");
	PlayerTextDrawLetterSize(playerid, Task_PTD[playerid][2], 0.197500, 0.806666);
	PlayerTextDrawAlignment(playerid, Task_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, Task_PTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, Task_PTD[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Task_PTD[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, Task_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, Task_PTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Task_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Task_PTD[playerid][2], 0);
	
	//InfoTD
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 148.888, 361.385, "Welcome!");
	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.326, 1.654);
	PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, InfoTD[playerid], -18177);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);

	RaceTD1[playerid] = CreatePlayerTextDraw(playerid, 119.111312, 317.084564, "~w~Position: ~b~~h~-/-  ~w~Checkpoint: ~b~~h~-/-  ~w~Race: ~g~~h~--  ~w~Time: ~g~~h~-:-");
	PlayerTextDrawLetterSize(playerid, RaceTD1[playerid], 0.243330, 1.888710);
	PlayerTextDrawAlignment(playerid, RaceTD1[playerid], 2);
	PlayerTextDrawColor(playerid, RaceTD1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, RaceTD1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, RaceTD1[playerid], 511);
	PlayerTextDrawBackgroundColor(playerid, RaceTD1[playerid], 51);
	PlayerTextDrawFont(playerid, RaceTD1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RaceTD1[playerid], 1);
	
	ParkourTD1[playerid] = CreatePlayerTextDraw(playerid, 119.111312, 317.084564, "~w~Position: ~b~~h~-/-  ~w~Checkpoint: ~b~~h~-/-  ~w~Race: ~g~~h~--  ~w~Time: ~g~~h~-:-");
	PlayerTextDrawLetterSize(playerid, ParkourTD1[playerid], 0.243330, 1.888710);
	PlayerTextDrawAlignment(playerid, ParkourTD1[playerid], 2);
	PlayerTextDrawColor(playerid, ParkourTD1[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ParkourTD1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ParkourTD1[playerid], 511);
	PlayerTextDrawBackgroundColor(playerid, ParkourTD1[playerid], 51);
	PlayerTextDrawFont(playerid, ParkourTD1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ParkourTD1[playerid], 1);

	//vT-D
	vTD[playerid] = CreatePlayerTextDraw(playerid, 536.800231, 235.795471, "Vehicle");
	PlayerTextDrawLetterSize(playerid, vTD[playerid], 0.561555, 3.038580);
	PlayerTextDrawAlignment(playerid, vTD[playerid], 2);
	PlayerTextDrawColor(playerid, vTD[playerid], 0x0073FFFF);
	PlayerTextDrawSetShadow(playerid, vTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, vTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, vTD[playerid], 51);
	PlayerTextDrawFont(playerid, vTD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, vTD[playerid], 1);

	//Speedo TD
	vSpeed[playerid] = CreatePlayerTextDraw(playerid, 545.333190, 396.230926, "KMH");
	PlayerTextDrawLetterSize(playerid, vSpeed[playerid], 0.464665, 1.824000);
	PlayerTextDrawAlignment(playerid, vSpeed[playerid], 1);
	PlayerTextDrawColor(playerid, vSpeed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, vSpeed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, vSpeed[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, vSpeed[playerid], 51);
	PlayerTextDrawFont(playerid, vSpeed[playerid], 2);
	PlayerTextDrawSetProportional(playerid, vSpeed[playerid], 1);

	// Achievements.
	DynamicAchTD[playerid][0] = CreatePlayerTextDraw(playerid, 313.000000, 213.000000, "TITLE");
	PlayerTextDrawAlignment(playerid, DynamicAchTD[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid, DynamicAchTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, DynamicAchTD[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, DynamicAchTD[playerid][0], 0.519999, 1.700000);
	PlayerTextDrawColor(playerid, DynamicAchTD[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, DynamicAchTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, DynamicAchTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, DynamicAchTD[playerid][0], 0);

	DynamicAchTD[playerid][1] = CreatePlayerTextDraw(playerid, 313.000000, 235.000000, "INFO");
	PlayerTextDrawAlignment(playerid, DynamicAchTD[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid, DynamicAchTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, DynamicAchTD[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, DynamicAchTD[playerid][1], 0.290000, 1.200000);
	PlayerTextDrawColor(playerid, DynamicAchTD[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, DynamicAchTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, DynamicAchTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, DynamicAchTD[playerid][1], 0);
	
	// killCam
	HealthTD[playerid] = CreatePlayerTextDraw(playerid, 4.888863, 357.404418, "_");
	PlayerTextDrawLetterSize(playerid, HealthTD[playerid], 0.477997, 2.227199);
	PlayerTextDrawAlignment(playerid, HealthTD[playerid], 1);
	PlayerTextDrawColor(playerid, HealthTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, HealthTD[playerid], 26);
	PlayerTextDrawSetOutline(playerid, HealthTD[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, HealthTD[playerid], 51);
	PlayerTextDrawFont(playerid, HealthTD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, HealthTD[playerid], 1);

	Armour[playerid] = CreatePlayerTextDraw(playerid, 475.555511, 356.408935, "_");
	PlayerTextDrawLetterSize(playerid, Armour[playerid], 0.511331, 2.386487);
	PlayerTextDrawAlignment(playerid, Armour[playerid], 1);
	PlayerTextDrawColor(playerid, Armour[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Armour[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Armour[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Armour[playerid], 51);
	PlayerTextDrawFont(playerid, Armour[playerid], 2);
	PlayerTextDrawSetProportional(playerid, Armour[playerid], 1);

	NameX[playerid] = CreatePlayerTextDraw(playerid, 5.777771, 339.484558, "_");
	PlayerTextDrawLetterSize(playerid, NameX[playerid], 0.429553, 1.784175);
	PlayerTextDrawAlignment(playerid, NameX[playerid], 1);
	PlayerTextDrawColor(playerid, NameX[playerid], -1);
	PlayerTextDrawSetShadow(playerid, NameX[playerid], 0);
	PlayerTextDrawSetOutline(playerid, NameX[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, NameX[playerid], 51);
	PlayerTextDrawFont(playerid, NameX[playerid], 2);
	PlayerTextDrawSetProportional(playerid, NameX[playerid], 1);

	killStreakTD[playerid] = CreatePlayerTextDraw(playerid, 516.0000, 338.488861, "_");
	PlayerTextDrawLetterSize(playerid, killStreakTD[playerid], 0.466888, 1.465597);
	PlayerTextDrawAlignment(playerid, killStreakTD[playerid], 1);
	PlayerTextDrawColor(playerid, killStreakTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, killStreakTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, killStreakTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, killStreakTD[playerid], 51);
	PlayerTextDrawFont(playerid, killStreakTD[playerid], 3);
	PlayerTextDrawSetProportional(playerid, killStreakTD[playerid], 1);

	killCamTD8[playerid] = CreatePlayerTextDraw(playerid, 191.111083, 392.746551, "You will respawn in x seconds.~n~Press the fire key to respawn at anytime.");
	PlayerTextDrawLetterSize(playerid, killCamTD8[playerid], 0.357111, 1.639821);
	PlayerTextDrawAlignment(playerid, killCamTD8[playerid], 1);
	PlayerTextDrawColor(playerid, killCamTD8[playerid], -1);
	PlayerTextDrawSetShadow(playerid, killCamTD8[playerid], 0);
	PlayerTextDrawSetOutline(playerid, killCamTD8[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, killCamTD8[playerid], 51);
	PlayerTextDrawFont(playerid, killCamTD8[playerid], 1);
	PlayerTextDrawSetProportional(playerid, killCamTD8[playerid], 1);
	
	duelCT[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 195.000000, "5");
	PlayerTextDrawAlignment(playerid, duelCT[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, duelCT[playerid], 0xff0000ff);
	PlayerTextDrawFont(playerid, duelCT[playerid], 3);
	PlayerTextDrawLetterSize(playerid, duelCT[playerid], 1.300000, 4.199998);
	PlayerTextDrawColor(playerid, duelCT[playerid], 0x0000ffcc);
	PlayerTextDrawSetOutline(playerid, duelCT[playerid], 1);
	PlayerTextDrawSetProportional(playerid, duelCT[playerid], 1);
	PlayerTextDrawSetShadow(playerid, duelCT[playerid], 1);
}

Create_TextDraws()
{
	Task_TD = TextDrawCreate(68.300079, 151.399887, "Daily_Task");
	TextDrawLetterSize(Task_TD, 0.269000, 1.161333);
	TextDrawAlignment(Task_TD, 3);
	TextDrawColor(Task_TD, 11141119);
	TextDrawSetShadow(Task_TD, 0);
	TextDrawSetOutline(Task_TD, -1);
	TextDrawBackgroundColor(Task_TD, 255);
	TextDrawFont(Task_TD, 1);
	TextDrawSetProportional(Task_TD, 1);
	TextDrawSetShadow(Task_TD, 0);

	Server_TD[0] = TextDrawCreate(540.666625, 2.503666, "X");
	TextDrawLetterSize(Server_TD[0], 0.426666, 1.794962);
	TextDrawAlignment(Server_TD[0], 1);
	TextDrawColor(Server_TD[0], -2147483393);
	TextDrawSetShadow(Server_TD[0], 0);
	TextDrawSetOutline(Server_TD[0], 1);
	TextDrawBackgroundColor(Server_TD[0], 255);
	TextDrawFont(Server_TD[0], 1);
	TextDrawSetProportional(Server_TD[0], 1);
	TextDrawSetShadow(Server_TD[0], 0);

	Server_TD[1] = TextDrawCreate(546.333435, 7.481453, "S");
	TextDrawLetterSize(Server_TD[1], 0.480666, 2.657776);
	TextDrawAlignment(Server_TD[1], 1);
	TextDrawColor(Server_TD[1], -65281);
	TextDrawSetShadow(Server_TD[1], 0);
	TextDrawSetOutline(Server_TD[1], 1);
	TextDrawBackgroundColor(Server_TD[1], 255);
	TextDrawFont(Server_TD[1], 2);
	TextDrawSetProportional(Server_TD[1], 1);
	TextDrawSetShadow(Server_TD[1], 0);

	Server_TD[2] = TextDrawCreate(550.333374, 3.333283, "treme");
	TextDrawLetterSize(Server_TD[2], 0.214333, 1.060740);
	TextDrawAlignment(Server_TD[2], 1);
	TextDrawColor(Server_TD[2], -1);
	TextDrawSetShadow(Server_TD[2], 0);
	TextDrawSetOutline(Server_TD[2], 1);
	TextDrawBackgroundColor(Server_TD[2], 255);
	TextDrawFont(Server_TD[2], 2);
	TextDrawSetProportional(Server_TD[2], 1);
	TextDrawSetShadow(Server_TD[2], 0);

	Server_TD[3] = TextDrawCreate(554.666625, 17.022228, "F");
	TextDrawLetterSize(Server_TD[3], 0.480666, 2.657776);
	TextDrawAlignment(Server_TD[3], 1);
	TextDrawColor(Server_TD[3], -5963521);
	TextDrawSetShadow(Server_TD[3], 0);
	TextDrawSetOutline(Server_TD[3], 1);
	TextDrawBackgroundColor(Server_TD[3], 255);
	TextDrawFont(Server_TD[3], 2);
	TextDrawSetProportional(Server_TD[3], 1);
	TextDrawSetShadow(Server_TD[3], 0);

	Server_TD[4] = TextDrawCreate(559.333435, 12.874034, "TUNT");
	TextDrawLetterSize(Server_TD[4], 0.214333, 1.060740);
	TextDrawAlignment(Server_TD[4], 1);
	TextDrawColor(Server_TD[4], -1);
	TextDrawSetShadow(Server_TD[4], 0);
	TextDrawSetOutline(Server_TD[4], 1);
	TextDrawBackgroundColor(Server_TD[4], 255);
	TextDrawFont(Server_TD[4], 2);
	TextDrawSetProportional(Server_TD[4], 1);
	TextDrawSetShadow(Server_TD[4], 0);

	Server_TD[5] = TextDrawCreate(564.000000, 25.733329, "reeroam");
	TextDrawLetterSize(Server_TD[5], 0.214333, 1.060740);
	TextDrawAlignment(Server_TD[5], 1);
	TextDrawColor(Server_TD[5], -1);
	TextDrawSetShadow(Server_TD[5], 0);
	TextDrawSetOutline(Server_TD[5], 1);
	TextDrawBackgroundColor(Server_TD[5], 255);
	TextDrawFont(Server_TD[5], 2);
	TextDrawSetProportional(Server_TD[5], 1);
	TextDrawSetShadow(Server_TD[5], 0);

	Server_TD[6] = TextDrawCreate(573.333496, -8.074089, "");
	TextDrawLetterSize(Server_TD[6], 0.000000, 0.000000);
	TextDrawTextSize(Server_TD[6], 51.000000, 62.000000);
	TextDrawAlignment(Server_TD[6], 1);
	TextDrawColor(Server_TD[6], -1);
	TextDrawBackgroundColor(Server_TD[6], 0x00000000);
	TextDrawFont(Server_TD[6], 5);
	TextDrawSetProportional(Server_TD[6], 0);
	TextDrawSetShadow(Server_TD[6], 0);
	TextDrawSetPreviewModel(Server_TD[6], 16442);
	TextDrawSetPreviewRot(Server_TD[6], 0.000000, 0.000000, 50.000000, 1.000000);
	TextDrawSetPreviewVehCol(Server_TD[6], 1, 1);

	helpTD = TextDrawCreate(6.666, 264.817, "~g~~h~~h~/help~n~~b~~h~~h~/cmds~n~~r~~h~~h~/teles");
	TextDrawLetterSize(helpTD, 0.392, 2.018);
	TextDrawAlignment(helpTD, 1);
	TextDrawColor(helpTD, -1);
	TextDrawSetOutline(helpTD, -1);
	TextDrawBackgroundColor(helpTD, 51);
	TextDrawFont(helpTD, 2);
	TextDrawSetProportional(helpTD, 1);
	


	xmasTD[0] = TextDrawCreate(153.000000, 134.000000, "New Textdraw");
	TextDrawBackgroundColor(xmasTD[0], 0x00000000);
	TextDrawFont(xmasTD[0], 5);
	TextDrawLetterSize(xmasTD[0], 0.470000, 1.000000);
	TextDrawColor(xmasTD[0], -1);
	TextDrawSetOutline(xmasTD[1], 0);
	TextDrawSetProportional(xmasTD[0], 1);
	TextDrawSetShadow(xmasTD[0], 1);
	TextDrawBoxColor(xmasTD[0], 255);
	TextDrawTextSize(xmasTD[0], 38.000000, 44.000000);
	TextDrawSetPreviewModel(xmasTD[0], 19064);
	TextDrawSetPreviewRot(xmasTD[0], -16.000000, 350.000000, 180.000000, 1.000000);

	xmasTD[1] = TextDrawCreate(475.000000, 135.000000, "New Textdraw");
	TextDrawBackgroundColor(xmasTD[1], 0x00000000);
	TextDrawFont(xmasTD[1], 5);
	TextDrawLetterSize(xmasTD[1], 0.470000, 1.000000);
	TextDrawColor(xmasTD[1], -1);
	TextDrawSetOutline(xmasTD[1], 0);
	TextDrawSetShadow(xmasTD[1], 1);
	TextDrawBoxColor(xmasTD[1], 255);
	TextDrawTextSize(xmasTD[1], 38.000000, 44.000000);
	TextDrawSetPreviewModel(xmasTD[1], 19064);
	TextDrawSetPreviewRot(xmasTD[1], -16.000000, 15.000000, 0.000000, 1.000000);


	
	#define FOOTER_STR_FORMAT \
	"~y~/CNR: %s~h~%d \
	~y~/DERBY: %s~h~%d \
	~y~/FALLOUT: %s~h~%d \
	~y~/BF: %s~h~%d \
	~y~/WAR: %s~h~%d \
	~y~/TDM: %s~h~%d \
	~y~/FDM: %s~h~%d \
	~y~/MINI: %s~h~%d \
	~y~/ODM: %s~h~%d \
	~y~/DSS: %s~h~%d "
	
	#define FOOTER_STR \
	"~y~/CNR: ~r~~h~0 \
	~y~/DERBY: ~r~~h~0 \
	~y~/FALLOUT: ~r~~h~0 \
	~y~/BF: ~r~~h~0 \
	~y~/WAR: ~r~~h~0 \
	~y~/TDM: ~r~~h~0 \
	~y~/FDM: ~r~~h~0 \
	~y~/MINI: ~r~~h~0 \
	~y~/ODM: ~r~~h~0 \
	~y~/DSS: ~r~~h~0"
	
	DMTextdraw = TextDrawCreate(316.889007, 435.555541, FOOTER_STR);
	TextDrawLetterSize(DMTextdraw, 0.225554, 1.246577);
	TextDrawAlignment(DMTextdraw, 2);
	TextDrawColor(DMTextdraw, -1);
	TextDrawSetShadow(DMTextdraw, 0);
	TextDrawSetOutline(DMTextdraw, 1);
	TextDrawBackgroundColor(DMTextdraw, 0x000000FF);
	TextDrawFont(DMTextdraw, 2);
	TextDrawSetProportional(DMTextdraw, 1);

	SEv2Box = TextDrawCreate(671.778015, 436.557861, "usebox");
	TextDrawLetterSize(SEv2Box, 0.000000, 2.177777);
	TextDrawTextSize(SEv2Box, -11.333312, 0.000000);
	TextDrawAlignment(SEv2Box, 1);
	TextDrawColor(SEv2Box, 0);
	TextDrawUseBox(SEv2Box, true);
	TextDrawBoxColor(SEv2Box, 0x00000066);
	TextDrawSetShadow(SEv2Box, 0);
	TextDrawSetOutline(SEv2Box, 0);
	TextDrawFont(SEv2Box, 0);

	msgTD = TextDrawCreate(361.00000, 419.133331, "Want access to ~y~bonus commands~w~? Check out ~r~/premium~w~!");
	TextDrawLetterSize(msgTD, 0.275333, 1.565156);
	TextDrawAlignment(msgTD, 1);
	TextDrawColor(msgTD, -1);
	TextDrawSetShadow(msgTD, 0);
	TextDrawSetOutline(msgTD, 1);
	TextDrawBackgroundColor(msgTD, 0x000000FF);
	TextDrawFont(msgTD, 1);
	TextDrawSetProportional(msgTD, 1);
	
	DerbyTD1 = TextDrawCreate(87.555740, 301.155822,  "~w~Players Left: ~b~~h~--  ~w~Time Left: ~b~~h~--  ~n~~w~Map: ~b~~h~--");
	TextDrawLetterSize(DerbyTD1, 0.243330, 1.888710);
	TextDrawAlignment(DerbyTD1, 2);
	TextDrawColor(DerbyTD1, -1);
	TextDrawSetShadow(DerbyTD1, 0);
	TextDrawSetOutline(DerbyTD1, 511);
	TextDrawBackgroundColor(DerbyTD1, 51);
	TextDrawFont(DerbyTD1, 1);
	TextDrawSetProportional(DerbyTD1, 1);

	DerbyTD2 = TextDrawCreate(58.666645, 279.253326, "Derby");
	TextDrawLetterSize(DerbyTD2, 0.661554, 2.043021);
	TextDrawAlignment(DerbyTD2, 1);
	TextDrawColor(DerbyTD2, COLOR_RED);
	TextDrawSetShadow(DerbyTD2, 0);
	TextDrawSetOutline(DerbyTD2, 1);
	TextDrawBackgroundColor(DerbyTD2, 0x000000FF);
	TextDrawFont(DerbyTD2, 0);
	TextDrawSetProportional(DerbyTD2, 1);

	FalloutTD1 = TextDrawCreate(84.444595, 318.577819, "~w~Players: ~b~~h~--  ~w~Time Left: ~b~~h~---");
	TextDrawLetterSize(FalloutTD1, 0.312665, 1.714488);
	TextDrawAlignment(FalloutTD1, 2);
	TextDrawColor(FalloutTD1, -1);
	TextDrawSetShadow(FalloutTD1, 0);
	TextDrawSetOutline(FalloutTD1, 511);
	TextDrawBackgroundColor(FalloutTD1, 51);
	TextDrawFont(FalloutTD1, 1);
	TextDrawSetProportional(FalloutTD1, 1);

	FalloutTD2 = TextDrawCreate(46.666652, 297.173461, "Fallout");
	TextDrawLetterSize(FalloutTD2, 0.777109, 1.843909);
	TextDrawAlignment(FalloutTD2, 1);
	TextDrawColor(FalloutTD2, COLOR_LB);
	TextDrawSetShadow(FalloutTD2, 0);
	TextDrawSetOutline(FalloutTD2, 1);
	TextDrawBackgroundColor(FalloutTD2, 0x000000FF);
	TextDrawFont(FalloutTD2, 0);
	TextDrawSetProportional(FalloutTD2, 1);
	
	RaceTD2 = TextDrawCreate(89.333305, 293.688842, "Race");
	TextDrawLetterSize(RaceTD2, 0.661555, 2.043022);
	TextDrawAlignment(RaceTD2, 1);
	TextDrawColor(RaceTD2, COLOR_GREEN);
	TextDrawSetShadow(RaceTD2, 0);
	TextDrawSetOutline(RaceTD2, 1);
	TextDrawBackgroundColor(RaceTD2, 0x000000FF);
	TextDrawFont(RaceTD2, 0);
	TextDrawSetProportional(RaceTD2, 1);
	
	ParkourTD2 = TextDrawCreate(89.333305, 293.688842, "Parkour");
	TextDrawLetterSize(ParkourTD2, 0.661555, 2.043022);
	TextDrawAlignment(ParkourTD2, 1);
	TextDrawColor(ParkourTD2, COLOR_RED);
	TextDrawSetShadow(ParkourTD2, 0);
	TextDrawSetOutline(ParkourTD2, 1);
	TextDrawBackgroundColor(ParkourTD2, 0x000);
	TextDrawFont(ParkourTD2, 0);
	TextDrawSetProportional(ParkourTD2, 1);


	InfoTD2 = TextDrawCreate(397.333496, 390.239532, "Moneybag hunt has started. Location: Las Venturas");
	TextDrawLetterSize(InfoTD2, 0.419331, 1.928534);
	TextDrawAlignment(InfoTD2, 2);
	TextDrawColor(InfoTD2, -1);
	TextDrawSetShadow(InfoTD2, 0);
	TextDrawSetOutline(InfoTD2, 2);
	TextDrawBackgroundColor(InfoTD2, 0x000000FF);
	TextDrawFont(InfoTD2, 3);
	TextDrawSetProportional(InfoTD2, 1);

	godTD = TextDrawCreate(492.888214, 101.048820, "~g~~h~~h~~h~Godmode Enabled");
	TextDrawLetterSize(godTD, 0.275333, 1.555199);
	TextDrawTextSize(godTD, 608.444091, -111.004455);
	TextDrawAlignment(godTD, 1);
	TextDrawColor(godTD, -1);
	TextDrawUseBox(godTD, true);
	TextDrawBoxColor(godTD, 102);
	TextDrawSetShadow(godTD, 0);
	TextDrawSetOutline(godTD, 1);
	TextDrawBackgroundColor(godTD, 51);
	TextDrawFont(godTD, 2);
	TextDrawSetProportional(godTD, 1);

	wTD = TextDrawCreate(265.555572, 141.375549, "usebox");
	TextDrawLetterSize(wTD, 0.000000, 26.784570);
	TextDrawTextSize(wTD, 24.666667, 0.000000);
	TextDrawAlignment(wTD, 1);
	TextDrawColor(wTD, 553648128);
	TextDrawUseBox(wTD, 1);
	TextDrawBoxColor(wTD, 65673);
	TextDrawBackgroundColor(wTD, 16777318);
	TextDrawFont(wTD, 0);

	wTD1 = TextDrawCreate(52.888870, 146.346679, "~y~xTreme Stunt Freeroam");
	TextDrawLetterSize(wTD1, 0.621109, 3.018667);
	TextDrawAlignment(wTD1, 1);
	TextDrawColor(wTD1, -1);
	TextDrawSetShadow(wTD1, 0);
	TextDrawSetOutline(wTD1, 1);
	TextDrawBackgroundColor(wTD1, 51);
	TextDrawFont(wTD1, 0);
	TextDrawSetProportional(wTD1, 1);

	wTD2 = TextDrawCreate(39.111110, 192.639984, "~w~Type ~b~~h~/help ~w~to get started.");
	TextDrawLetterSize(wTD2, 0.293110, 1.465600);
	TextDrawAlignment(wTD2, 1);
	TextDrawColor(wTD2, -1);
	TextDrawSetShadow(wTD2, 0);
	TextDrawSetOutline(wTD2, 1);
	TextDrawBackgroundColor(wTD2, 51);
	TextDrawFont(wTD2, 2);
	TextDrawSetProportional(wTD2, 1);

	wTD3 = TextDrawCreate(72.444389, 212.551162, "~b~~h~/cmds ~w~for commands.");
	TextDrawLetterSize(wTD3, 0.319333, 1.390933);
	TextDrawAlignment(wTD3, 1);
	TextDrawColor(wTD3, -1);
	TextDrawSetShadow(wTD3, 0);
	TextDrawSetOutline(wTD3, 1);
	TextDrawBackgroundColor(wTD3, 51);
	TextDrawFont(wTD3, 2);
	TextDrawSetProportional(wTD3, 1);

	wTD4 = TextDrawCreate(71.111167, 232.462265, "~b~~h~/teles ~w~for /teleports.");
	TextDrawLetterSize(wTD4, 0.291777, 1.351110);
	TextDrawAlignment(wTD4, 1);
	TextDrawColor(wTD4, -1);
	TextDrawSetShadow(wTD4, 0);
	TextDrawSetOutline(wTD4, 1);
	TextDrawBackgroundColor(wTD4, 51);
	TextDrawFont(wTD4, 2);
	TextDrawSetProportional(wTD4, 1);

	wTD5 = TextDrawCreate(71.555580, 251.377761, "~b~~h~/v ~w~to spawn vehicles.");
	TextDrawLetterSize(wTD5, 0.315333, 1.271466);
	TextDrawAlignment(wTD5, 1);
	TextDrawColor(wTD5, -1);
	TextDrawSetShadow(wTD5, 0);
	TextDrawSetOutline(wTD5, 1);
	TextDrawBackgroundColor(wTD5, 51);
	TextDrawFont(wTD5, 2);
	TextDrawSetProportional(wTD5, 1);

	wTD6 = TextDrawCreate(31.111114, 277.377832, "~r~~h~~h~/cmds /teles /help /rules");
	TextDrawLetterSize(wTD6, 0.357111, 1.764266);
	TextDrawAlignment(wTD6, 1);
	TextDrawColor(wTD6, -1);
	TextDrawSetShadow(wTD6, 0);
	TextDrawSetOutline(wTD6, 1);
	TextDrawBackgroundColor(wTD6, 51);
	TextDrawFont(wTD6, 2);
	TextDrawSetProportional(wTD6, 1);

	wTD7 = TextDrawCreate(51.555606, 345.457641, "~b~~h~~h~~h~www.Serverserver.com");
	TextDrawLetterSize(wTD7, 0.484666, 1.948444);
	TextDrawAlignment(wTD7, 1);
	TextDrawColor(wTD7, -1);
	TextDrawSetShadow(wTD7, 0);
	TextDrawSetOutline(wTD7, 1);
	TextDrawBackgroundColor(wTD7, 51);
	TextDrawFont(wTD7, 3);
	TextDrawSetProportional(wTD7, 1);

	wTD8 = TextDrawCreate(56.888904, 316.088928, "~w~Visit our website at:");
	TextDrawLetterSize(wTD8, 0.448666, 1.739377);
	TextDrawAlignment(wTD8, 1);
	TextDrawColor(wTD8, -1);
	TextDrawSetShadow(wTD8, 0);
	TextDrawSetOutline(wTD8, 1);
	TextDrawBackgroundColor(wTD8, 51);
	TextDrawFont(wTD8, 1);
	TextDrawSetProportional(wTD8, 1);

	wTD9 = TextDrawCreate(205.333221, 173.724395, "~g~~h~Build "BUILD"");
	TextDrawLetterSize(wTD9, 0.338889, 1.296355);
	TextDrawAlignment(wTD9, 1);
	TextDrawColor(wTD9, -1);
	TextDrawSetShadow(wTD9, 0);
	TextDrawSetOutline(wTD9, 1);
	TextDrawBackgroundColor(wTD9, 51);
	TextDrawFont(wTD9, 1);
	TextDrawSetProportional(wTD9, 1);

	raceCT = TextDrawCreate(320.000000, 195.000000, "5");
	TextDrawAlignment(raceCT, 2);
	TextDrawBackgroundColor(raceCT, 0xff0000ff);
	TextDrawFont(raceCT, 3);
	TextDrawLetterSize(raceCT, 1.300000, 4.199998);
	TextDrawColor(raceCT, 0x0000ffcc);
	TextDrawSetOutline(raceCT, 1);
	TextDrawSetProportional(raceCT, 1);
	TextDrawSetShadow(raceCT, 1);
	
	parkourCT = TextDrawCreate(320.000000, 195.000000, "5");
	TextDrawAlignment(parkourCT, 2);
	TextDrawBackgroundColor(parkourCT, 0xff0000ff);
	TextDrawFont(parkourCT, 3);
	TextDrawLetterSize(parkourCT, 1.300000, 4.199998);
	TextDrawColor(parkourCT, 0x0000ffcc);
	TextDrawSetOutline(parkourCT, 1);
	TextDrawSetProportional(parkourCT, 1);
	TextDrawSetShadow(parkourCT, 1);

	derbyCT = TextDrawCreate(320.000000, 195.000000, "5");
	TextDrawAlignment(derbyCT, 2);
	TextDrawBackgroundColor(derbyCT, 0xff0000ff);
	TextDrawFont(derbyCT, 3);
	TextDrawLetterSize(derbyCT, 1.300000, 4.199998);
	TextDrawColor(derbyCT, 0x0000ffcc);
	TextDrawSetOutline(derbyCT, 1);
	TextDrawSetProportional(derbyCT, 1);
	TextDrawSetShadow(derbyCT, 1);

	// Speedo
	vSpeedBox = TextDrawCreate(540.666259, 418.637756, "0");
	TextDrawLetterSize(vSpeedBox, 0.000000, -3.155556);
	TextDrawTextSize(vSpeedBox, 649.999572, 0.000000);
	TextDrawAlignment(vSpeedBox, 1);
	TextDrawColor(vSpeedBox, 0);
	TextDrawUseBox(vSpeedBox, true);
	TextDrawBoxColor(vSpeedBox, 102);
	TextDrawSetShadow(vSpeedBox, 0);
	TextDrawSetOutline(vSpeedBox, 0);
	TextDrawFont(vSpeedBox, 2);

	// Letterbox Textdraw
	letterbox[0] = TextDrawCreate(-1.000000, 2.000000,"---");
	letterbox[1] = TextDrawCreate(0.000000, 337.000000,"---");
	TextDrawUseBox(letterbox[0],1);
	TextDrawBoxColor(letterbox[0],0x000000ff);
	TextDrawTextSize(letterbox[0],640.000000,-69.000000);
	TextDrawUseBox(letterbox[1],1);
	TextDrawBoxColor(letterbox[1],0x000000ff);
	TextDrawTextSize(letterbox[1],638.000000,-60.000000);
	TextDrawAlignment(letterbox[0],0);
	TextDrawAlignment(letterbox[1],0);
	TextDrawBackgroundColor(letterbox[0],0x000000ff);
	TextDrawBackgroundColor(letterbox[1],0x000000ff);
	TextDrawFont(letterbox[0],3);
	TextDrawLetterSize(letterbox[0],1.000000,12.199999);
	TextDrawFont(letterbox[1],3);
	TextDrawLetterSize(letterbox[1],0.899999,15.000000);
	TextDrawColor(letterbox[0],0x000000ff);
	TextDrawColor(letterbox[1],0x000000ff);
	TextDrawSetOutline(letterbox[0],1);
	TextDrawSetOutline(letterbox[1],1);
	TextDrawSetProportional(letterbox[0],1);
	TextDrawSetProportional(letterbox[1],1);
	TextDrawSetShadow(letterbox[0],1);
	TextDrawSetShadow(letterbox[1],1);
	
	// Minigame Textdraw
	/*TD_line[0] = TextDrawCreate(639.777770, 318.086669, "usebox");
	TextDrawLetterSize(TD_line[0], 0.000000, 4.550493);
	TextDrawTextSize(TD_line[0], 464.222229, 0.000000);
	TextDrawAlignment(TD_line[0], 1);
	TextDrawColor(TD_line[0], 0);
	TextDrawUseBox(TD_line[0], true);
	TextDrawBoxColor(TD_line[0], 102);
	TextDrawSetShadow(TD_line[0], 0);
	TextDrawSetOutline(TD_line[0], 0);
	TextDrawFont(TD_line[0], 0);

	TD_line[1] = TextDrawCreate(469.777709, 320.568847, " ");
	TextDrawLetterSize(TD_line[1], 0.215777, 1.161955);
	TextDrawAlignment(TD_line[1], 1);
	TextDrawColor(TD_line[1], -1);
	TextDrawSetShadow(TD_line[1], 0);
	TextDrawSetOutline(TD_line[1], 1);
	TextDrawBackgroundColor(TD_line[1], 51);
	TextDrawFont(TD_line[1], 1);
	TextDrawSetProportional(TD_line[1], 1);

	TD_line[2] = TextDrawCreate(469.777709, 333.013305, " ");
	TextDrawLetterSize(TD_line[2], 0.215777, 1.161955);
	TextDrawAlignment(TD_line[2], 1);
	TextDrawColor(TD_line[2], -1);
	TextDrawSetShadow(TD_line[2], 0);
	TextDrawSetOutline(TD_line[2], 1);
	TextDrawBackgroundColor(TD_line[2], 51);
	TextDrawFont(TD_line[2], 1);
	TextDrawSetProportional(TD_line[2], 1);

	TD_line[3] = TextDrawCreate(469.777709, 345.457763, " ");
	TextDrawLetterSize(TD_line[3], 0.215777, 1.161955);
	TextDrawAlignment(TD_line[3], 1);
	TextDrawColor(TD_line[3], -1);
	TextDrawSetShadow(TD_line[3], 0);
	TextDrawSetOutline(TD_line[3], 1);
	TextDrawBackgroundColor(TD_line[3], 51);
	TextDrawFont(TD_line[3], 1);
	TextDrawSetProportional(TD_line[3], 1);*/
	TD_line[0] = TextDrawCreate(477.555572, 321.564483, " ");
	TextDrawLetterSize(TD_line[0], 0.213555, 1.037510);
	TextDrawAlignment(TD_line[0], 1);
	TextDrawColor(TD_line[0], -1);
	TextDrawSetShadow(TD_line[0], 0);
	TextDrawSetOutline(TD_line[0], 1);
	TextDrawBackgroundColor(TD_line[0], 142);
	TextDrawFont(TD_line[0], 1);
	TextDrawSetProportional(TD_line[0], 1);

	TD_line[1] = TextDrawCreate(477.555572, 334.008911, " ");
	TextDrawLetterSize(TD_line[1], 0.213555, 1.037510);
	TextDrawAlignment(TD_line[1], 1);
	TextDrawColor(TD_line[1], -1);
	TextDrawSetShadow(TD_line[1], 0);
	TextDrawSetOutline(TD_line[1], 1);
	TextDrawBackgroundColor(TD_line[1], 142);
	TextDrawFont(TD_line[1], 1);
	TextDrawSetProportional(TD_line[1], 1);

	TD_line[2] = TextDrawCreate(477.655572, 346.453399, " ");
	TextDrawLetterSize(TD_line[2], 0.213555, 1.037510);
	TextDrawAlignment(TD_line[2], 1);
	TextDrawColor(TD_line[2], -1);
	TextDrawSetShadow(TD_line[2], 0);
	TextDrawSetOutline(TD_line[2], 1);
	TextDrawBackgroundColor(TD_line[2], 142);
	TextDrawFont(TD_line[2], 1);
	TextDrawSetProportional(TD_line[2], 1);

	TD_line[3] = TextDrawCreate(477.555572, 358.288824, " ");
	TextDrawLetterSize(TD_line[3], 0.213555, 1.037510);
	TextDrawAlignment(TD_line[3], 1);
	TextDrawColor(TD_line[3], -1);
	TextDrawSetShadow(TD_line[3], 0);
	TextDrawSetOutline(TD_line[3], 1);
	TextDrawBackgroundColor(TD_line[3], 142);
	TextDrawFont(TD_line[3], 1);
	TextDrawSetProportional(TD_line[3], 1);

	//Top Colored Bar
	letterbox[2] = TextDrawCreate(729.000000, 111.000000, "_");
	TextDrawBackgroundColor(letterbox[2], 255);
	TextDrawFont(letterbox[2], 1);
	TextDrawLetterSize(letterbox[2], 50.000000, 0.099999);
	TextDrawColor(letterbox[2], -16776961);
	TextDrawSetOutline(letterbox[2], 0);
	TextDrawSetProportional(letterbox[2], 1);
	TextDrawSetShadow(letterbox[2], 1);
	TextDrawUseBox(letterbox[2], 1);
	TextDrawBoxColor(letterbox[2], 0xFF4C3FCC);
	TextDrawTextSize(letterbox[2], -5.000000, 1031.000000);

	// Bottom Colored Bar
	letterbox[3] = TextDrawCreate(729.000000, 337.000000, "_");
	TextDrawBackgroundColor(letterbox[3], 255);
	TextDrawFont(letterbox[3], 1);
	TextDrawLetterSize(letterbox[3], 50.000000, 0.099999);
	TextDrawColor(letterbox[3], -16776961);
	TextDrawSetOutline(letterbox[3], 0);
	TextDrawSetProportional(letterbox[3], 1);
	TextDrawSetShadow(letterbox[3], 1);
	TextDrawUseBox(letterbox[3], 1);
	TextDrawBoxColor(letterbox[3], 0xFF4C3FCC);
	TextDrawTextSize(letterbox[3], -5.000000, 1031.000000);

	TeleTD = TextDrawCreate(6.221940, 319.573181, " ");
	TextDrawLetterSize(TeleTD, 0.179777, 1.371021);
	TextDrawAlignment(TeleTD, 1);
	TextDrawColor(TeleTD, -1);
	TextDrawSetShadow(TeleTD, 0);
	TextDrawSetOutline(TeleTD, 1);
	TextDrawBackgroundColor(TeleTD, 0x00000066);
	TextDrawFont(TeleTD, 1);
	TextDrawSetProportional(TeleTD, 1);
	
	ConnectTD[0] = TextDrawCreate(552.666809, 126.442207, "usebox");
	TextDrawLetterSize(ConnectTD[0], 0.000000, 18.272958);
	TextDrawTextSize(ConnectTD[0], 116.222175, 0.000000);
	TextDrawAlignment(ConnectTD[0], 1);
	TextDrawColor(ConnectTD[0], 65535);
	TextDrawUseBox(ConnectTD[0], true);
	TextDrawBoxColor(ConnectTD[0], 0x00000088);
	TextDrawSetShadow(ConnectTD[0], 0);
	TextDrawSetOutline(ConnectTD[0], 0);
	TextDrawFont(ConnectTD[0], 0);

	ConnectTD[1] = TextDrawCreate(269.000000, 100.000000, "SAMP");
	TextDrawBackgroundColor(ConnectTD[1], 0x00000000);
	TextDrawFont(ConnectTD[1], 5);
	TextDrawLetterSize(ConnectTD[1], 0.500000, 1.000000);
	TextDrawColor(ConnectTD[1], -1);
	TextDrawSetOutline(ConnectTD[1], 0);
	TextDrawSetProportional(ConnectTD[1], 1);
	TextDrawSetShadow(ConnectTD[1], 1);
	TextDrawTextSize(ConnectTD[1], 107.000000, 93.000000);
	TextDrawSetPreviewModel(ConnectTD[1], 18749);
	TextDrawSetPreviewRot(ConnectTD[1], 0.000000, 0.000000, 180.000000, 0.800000);

	ConnectTD[3] = TextDrawCreate(228.444183, 169.248886, "~w~Server ~r~~h~~h~~h~:: ~w~xTreme Stunt Freeroam");
	TextDrawLetterSize(ConnectTD[3], 0.386888, 1.545244);
	TextDrawAlignment(ConnectTD[3], 1);
	TextDrawColor(ConnectTD[3], -1);
	TextDrawSetShadow(ConnectTD[3], 0);
	TextDrawSetOutline(ConnectTD[3], 1);
	TextDrawBackgroundColor(ConnectTD[3], 51);
	TextDrawFont(ConnectTD[3], 3);
	TextDrawSetProportional(ConnectTD[3], 1);

	ConnectTD[4] = TextDrawCreate(278.477984, 213.546676, "Build "BUILD"");
	TextDrawLetterSize(ConnectTD[4], 0.503333, 1.908622);
	TextDrawAlignment(ConnectTD[4], 1);
	TextDrawColor(ConnectTD[4], -1);
	TextDrawSetShadow(ConnectTD[4], 0);
	TextDrawSetOutline(ConnectTD[4], 1);
	TextDrawBackgroundColor(ConnectTD[4], 0x000000FF);
	TextDrawFont(ConnectTD[4], 2);
	TextDrawSetProportional(ConnectTD[4], 1);

	ConnectTD[5] = TextDrawCreate(277.333190, 252.373443, "Welcome!");
	TextDrawLetterSize(ConnectTD[5], 0.602443, 1.814043);
	TextDrawAlignment(ConnectTD[5], 1);
	TextDrawColor(ConnectTD[5], COLOR_WHITE);
	TextDrawSetShadow(ConnectTD[5], 0);
	TextDrawSetOutline(ConnectTD[5], 0);
	TextDrawBackgroundColor(ConnectTD[5], 0x000000FF);
	TextDrawFont(ConnectTD[5], 1);
	TextDrawSetProportional(ConnectTD[5], 1);

	ConnectTD[6] = TextDrawCreate(236.444427, 185.173339, "~b~Stunt~w~/~g~~h~Drift~w~/~y~Race~w~/~r~DM~w~/~p~~h~Fun");
	TextDrawLetterSize(ConnectTD[6], 0.449999, 1.600000);
	TextDrawAlignment(ConnectTD[6], 1);
	TextDrawColor(ConnectTD[6], -1);
	TextDrawSetShadow(ConnectTD[6], 0);
	TextDrawSetOutline(ConnectTD[6], 1);
	TextDrawBackgroundColor(ConnectTD[6], 51);
	TextDrawFont(ConnectTD[6], 1);
	TextDrawSetProportional(ConnectTD[6], 1);

	ConnectTD[7] = TextDrawCreate(369.777954, 150.826553, "0.3.7");
	TextDrawLetterSize(ConnectTD[7], 0.236666, 1.649776);
	TextDrawAlignment(ConnectTD[7], 1);
	TextDrawColor(ConnectTD[7], -1);
	TextDrawSetShadow(ConnectTD[7], 0);
	TextDrawSetOutline(ConnectTD[7], 1);
	TextDrawBackgroundColor(ConnectTD[7], 51);
	TextDrawFont(ConnectTD[7], 2);
	TextDrawSetProportional(ConnectTD[7], 1);

	ConnectTD[8] = TextDrawCreate(464.000000, 318.000000, "SAMP03z");
	TextDrawBackgroundColor(ConnectTD[8], 0x00000000);
	TextDrawFont(ConnectTD[8], 5);
	TextDrawLetterSize(ConnectTD[8], 1.620000, 2.300000);
	TextDrawColor(ConnectTD[8], -1);
	TextDrawSetOutline(ConnectTD[8], 0);
	TextDrawSetProportional(ConnectTD[8], 1);
	TextDrawSetShadow(ConnectTD[8], 1);
	TextDrawTextSize(ConnectTD[8], 168.000000, 160.000000);
	TextDrawSetPreviewModel(ConnectTD[8], 18750);
	TextDrawSetPreviewRot(ConnectTD[8], 280.000000, 0.000000, 180.000000, 1.000000);

	ConnectTD[9] = TextDrawCreate(388.000000, 198.000000, "Box");
	TextDrawBackgroundColor(ConnectTD[9], 0x00000000);
	TextDrawFont(ConnectTD[9], 5);
	TextDrawLetterSize(ConnectTD[9], 0.500000, 1.000000);
	TextDrawColor(ConnectTD[9], -1);
	TextDrawSetOutline(ConnectTD[9], 0);
	TextDrawSetProportional(ConnectTD[9], 1);
	TextDrawSetShadow(ConnectTD[9], 1);
	TextDrawTextSize(ConnectTD[9], 87.000000, 82.000000);
	TextDrawSetPreviewModel(ConnectTD[9], 18779);
	TextDrawSetPreviewRot(ConnectTD[9], 0.000000, 0.000000, 50.000000, 1.000000);
	
	ConnectTD[10] = TextDrawCreate(139.000000, 141.000000, "New Textdraw");
	TextDrawBackgroundColor(ConnectTD[10], 0x00000000);
	TextDrawFont(ConnectTD[10], 5);
	TextDrawLetterSize(ConnectTD[10], 0.759999, 0.199999);
	TextDrawColor(ConnectTD[10], -1);
	TextDrawSetOutline(ConnectTD[10], 0);
	TextDrawSetProportional(ConnectTD[10], 1);
	TextDrawSetShadow(ConnectTD[10], 1);
	TextDrawTextSize(ConnectTD[10], 78.000000, 88.000000);
	TextDrawSetPreviewModel(ConnectTD[10], 7392);
	TextDrawSetPreviewRot(ConnectTD[10], -16.000000, 0.000000, 90.000000, 1.000000);
	
	ConnectTD[11] = TextDrawCreate(448.000000, 142.000000, "New Textdraw");
	TextDrawBackgroundColor(ConnectTD[11], 0x00000000);
	TextDrawFont(ConnectTD[11], 5);
	TextDrawLetterSize(ConnectTD[11], 0.759999, 0.199999);
	TextDrawColor(ConnectTD[11], -1);
	TextDrawSetOutline(ConnectTD[11], 0);
	TextDrawSetProportional(ConnectTD[11], 1);
	TextDrawSetShadow(ConnectTD[11], 1);
	TextDrawTextSize(ConnectTD[11], 78.000000, 88.000000);
	TextDrawSetPreviewModel(ConnectTD[11], 7392);
	TextDrawSetPreviewRot(ConnectTD[11], -16.000000, 0.000000, -90.000000, 1.000000);
	TextDrawSetSelectable(ConnectTD[11], 0);
	
	ConnectTD[2] = TextDrawCreate(176.000000, 219.000000, "Box");
	TextDrawBackgroundColor(ConnectTD[2], 0x00000000);
	TextDrawFont(ConnectTD[2], 5);
	TextDrawLetterSize(ConnectTD[2], 0.500000, 1.000000);
	TextDrawColor(ConnectTD[2], -1);
	TextDrawSetOutline(ConnectTD[2], 0);
	TextDrawSetProportional(ConnectTD[2], 1);
	TextDrawSetShadow(ConnectTD[2], 1);
	TextDrawTextSize(ConnectTD[2], 76.000000, 71.000000);
	TextDrawSetPreviewModel(ConnectTD[2], 415);
	TextDrawSetPreviewRot(ConnectTD[2], 0.000000, 0.000000, 70.000000, 0.899999);
	
	CheckTD = TextDrawCreate(370.222778, 329.031158, "LD_CHAT:thumbup");
	TextDrawLetterSize(CheckTD, 0.000000, 0.000000);
	TextDrawTextSize(CheckTD, 45.777770, 31.359985);
	TextDrawAlignment(CheckTD, 1);
	TextDrawColor(CheckTD, -1);
	TextDrawSetShadow(CheckTD, 0);
	TextDrawSetOutline(CheckTD, 0);
	TextDrawFont(CheckTD, 4);

	ErrorTD = TextDrawCreate(394.577801, 335.004394, "LD_CHAT:badchat");
	TextDrawLetterSize(ErrorTD, 0.449999, 1.600000);
	TextDrawTextSize(ErrorTD, 42.222240, 31.360012);
	TextDrawAlignment(ErrorTD, 2);
	TextDrawColor(ErrorTD, -1);
	TextDrawSetShadow(ErrorTD, 0);
	TextDrawSetOutline(ErrorTD, 1);
	TextDrawBackgroundColor(ErrorTD, 51);
	TextDrawFont(ErrorTD, 4);
	TextDrawSetProportional(ErrorTD, 1);

	NewMsgTD = TextDrawCreate(370.222778, 329.031158, "LD_CHAT:goodcha");
	TextDrawLetterSize(NewMsgTD, 0.000000, 0.000000);
	TextDrawTextSize(NewMsgTD, 32.444427, 28.871093);
	TextDrawAlignment(NewMsgTD, 2);
	TextDrawColor(NewMsgTD, -1);
	TextDrawSetShadow(NewMsgTD, 0);
	TextDrawSetOutline(NewMsgTD, 0);
	TextDrawFont(NewMsgTD, 4);

	
	cnrTD = TextDrawCreate(21.333314, 422.115478, "Cops and Robbers");
	TextDrawLetterSize(cnrTD, 0.421111, 1.515377);
	TextDrawAlignment(cnrTD, 1);
	TextDrawColor(cnrTD, -5963521);
	TextDrawSetShadow(cnrTD, 0);
	TextDrawSetOutline(cnrTD, 1);
	TextDrawBackgroundColor(cnrTD, 255);
	TextDrawFont(cnrTD, 3);
	TextDrawSetProportional(cnrTD, 1);

	cnrTD2 = TextDrawCreate(7.111104, 406.186584, "Server");
	TextDrawLetterSize(cnrTD2, 0.436222, 1.734400);
	TextDrawAlignment(cnrTD2, 1);
	TextDrawColor(cnrTD2, -2147483393);
	TextDrawSetShadow(cnrTD2, 0);
	TextDrawSetOutline(cnrTD2, 1);
	TextDrawBackgroundColor(cnrTD2, 255);
	TextDrawFont(cnrTD2, 2);
	TextDrawSetProportional(cnrTD2, 1);
	
	JailTD = TextDrawCreate(393.777587, 372.835693, "LD_BUM:bum1");
	TextDrawLetterSize(JailTD, 0.000000, 0.000000);
	TextDrawTextSize(JailTD, 102.666786, -108.515617);
	TextDrawAlignment(JailTD, 3);
	TextDrawColor(JailTD, -1);
	TextDrawFont(JailTD, 4);
	
	AchTD[0] = TextDrawCreate(495.000000, 190.000000, "Box0");
	TextDrawBackgroundColor(AchTD[0], 255);
	TextDrawFont(AchTD[0], 1);
	TextDrawLetterSize(AchTD[0], 0.000000, 9.100000);
	TextDrawColor(AchTD[0], -1);
	TextDrawSetOutline(AchTD[0], 0);
	TextDrawSetProportional(AchTD[0], 1);
	TextDrawSetShadow(AchTD[0], 1);
	TextDrawUseBox(AchTD[0], 1);
	TextDrawBoxColor(AchTD[0], 90);
	TextDrawTextSize(AchTD[0], 141.000000, 0.000000);

	AchTD[1] = TextDrawCreate(495.000000, 190.000000, "Box1");
	TextDrawBackgroundColor(AchTD[1], 255);
	TextDrawFont(AchTD[1], 1);
	TextDrawLetterSize(AchTD[1], 0.000000, 4.299999);
	TextDrawColor(AchTD[1], -1);
	TextDrawSetOutline(AchTD[1], 0);
	TextDrawSetProportional(AchTD[1], 1);
	TextDrawSetShadow(AchTD[1], 1);
	TextDrawUseBox(AchTD[1], 1);
	TextDrawBoxColor(AchTD[1], -241);
	TextDrawTextSize(AchTD[1], 141.000000, 0.000000);

	AchTD[2] = TextDrawCreate(187.000000, 191.000000, "ACHIEVEMENT UNLOCKED");
	TextDrawBackgroundColor(AchTD[2], 255);
	TextDrawFont(AchTD[2], 1);
	TextDrawLetterSize(AchTD[2], 0.649999, 2.000000);
	TextDrawColor(AchTD[2], 16711935);
	TextDrawSetOutline(AchTD[2], 0);
	TextDrawSetProportional(AchTD[2], 1);
	TextDrawSetShadow(AchTD[2], 0);

	AchTD[3] = TextDrawCreate(495.000000, 194.000000, "Box2");
	TextDrawBackgroundColor(AchTD[3], 255);
	TextDrawFont(AchTD[3], 1);
	TextDrawLetterSize(AchTD[3], 0.000000, 9.100000);
	TextDrawColor(AchTD[3], -1);
	TextDrawSetOutline(AchTD[3], 0);
	TextDrawSetProportional(AchTD[3], 1);
	TextDrawSetShadow(AchTD[3], 1);
	TextDrawUseBox(AchTD[3], 1);
	TextDrawBoxColor(AchTD[3], 90);
	TextDrawTextSize(AchTD[3], 141.000000, 0.000000);

	AchTD[4] = TextDrawCreate(450.000000, 192.000000, "Box3");
	TextDrawBackgroundColor(AchTD[4], 255);
	TextDrawFont(AchTD[4], 1);
	TextDrawLetterSize(AchTD[4], 0.000000, 1.700000);
	TextDrawColor(AchTD[4], -1);
	TextDrawSetOutline(AchTD[4], 0);
	TextDrawSetProportional(AchTD[4], 1);
	TextDrawSetShadow(AchTD[4], 1);
	TextDrawUseBox(AchTD[4], 1);
	TextDrawBoxColor(AchTD[4], 16711690);
	TextDrawTextSize(AchTD[4], 182.000000, 0.000000);

	AchTD[5] = TextDrawCreate(317.000000, 193.000000, "]                                            ]");
	TextDrawAlignment(AchTD[5], 2);
	TextDrawBackgroundColor(AchTD[5], 255);
	TextDrawFont(AchTD[5], 2);
	TextDrawLetterSize(AchTD[5], 0.500000, 1.600000);
	TextDrawColor(AchTD[5], 16711935);
	TextDrawSetOutline(AchTD[5], 0);
	TextDrawSetProportional(AchTD[5], 1);
	TextDrawSetShadow(AchTD[5], 0);
	
	// KillCam
	killCamTD = TextDrawCreate(276.444244, 38.328853, "~r~Server");
	TextDrawLetterSize(killCamTD, 0.636222, 2.486042);
	TextDrawAlignment(killCamTD, 1);
	TextDrawColor(killCamTD, -1);
	TextDrawSetShadow(killCamTD, 0);
	TextDrawSetOutline(killCamTD, 1);
	TextDrawBackgroundColor(killCamTD, 51);
	TextDrawFont(killCamTD, 0);
	TextDrawSetProportional(killCamTD, 1);

	killCamTD1 = TextDrawCreate(318.666687, 47.288948, "killCam");
	TextDrawLetterSize(killCamTD1, 0.657553, 2.515911);
	TextDrawAlignment(killCamTD1, 1);
	TextDrawColor(killCamTD1, -1);
	TextDrawSetShadow(killCamTD1, 0);
	TextDrawSetOutline(killCamTD1, 1);
	TextDrawBackgroundColor(killCamTD1, 51);
	TextDrawFont(killCamTD1, 3);
	TextDrawSetProportional(killCamTD1, 1);
}

Destroy_TextDraws()
{
	foreach(new ii : Player)
	{
		PlayerTextDrawDestroy(ii, InfoTD[ii]);
		PlayerTextDrawDestroy(ii, vTD[ii]);
	}
	TextDrawDestroy(Server_TD[0]);
	TextDrawDestroy(Server_TD[1]);
	TextDrawDestroy(Server_TD[2]);
	TextDrawDestroy(Server_TD[3]);
	TextDrawDestroy(Server_TD[4]);
	TextDrawDestroy(Server_TD[5]);
	TextDrawDestroy(Server_TD[6]);
	TextDrawDestroy(wTD);
	TextDrawDestroy(wTD1);
	TextDrawDestroy(wTD2);
	TextDrawDestroy(wTD3);
	TextDrawDestroy(wTD4);
	TextDrawDestroy(wTD5);
	TextDrawDestroy(helpTD);
	TextDrawDestroy(godTD);
	TextDrawDestroy(msgTD);
	TextDrawDestroy(DMTextdraw);

}

forward hidevTD(playerid);
public hidevTD(playerid)
{
	PlayerTextDrawHide(playerid, vTD[playerid]);
	if(hideMSG[playerid] == 0)
	{
		ShowPlayerMSGBox(playerid);
	}
}

forward hideError(playerid);
public hideError(playerid)
{
	TextDrawHideForPlayer(playerid, ErrorTD);
}

forward hideJailTD(playerid);
public hideJailTD(playerid)
{
	TextDrawHideForPlayer(playerid, JailTD);
}

forward hideCheck(playerid);
public hideCheck(playerid)
{
	TextDrawHideForPlayer(playerid, CheckTD);
}

forward hideMsgTD(playerid);
public hideMsgTD(playerid)
{
	TextDrawHideForPlayer(playerid, NewMsgTD);
}

// Timer for hiding the help textdraw
forward hideHelpTD(playerid);
public hideHelpTD(playerid)
{
	TextDrawHideForPlayer(playerid, helpTD);
}

// Hide player textdraws, OnPlayerDisconnect
stock HidePlayerTextDraws_OPDC(playerid)
{
	TextDrawHideForPlayer(playerid, msgTD);
	TextDrawHideForPlayer(playerid, DMTextdraw);
	TextDrawHideForPlayer(playerid, helpTD);
	PlayerTextDrawDestroy(playerid, vTD[playerid]);
	TextDrawHideForPlayer(playerid, godTD);
	TextDrawHideForPlayer(playerid, TeleTD);
	TextDrawHideForPlayer(playerid, Server_TD[0]);
	TextDrawHideForPlayer(playerid, Server_TD[1]);
	TextDrawHideForPlayer(playerid, Server_TD[2]);
	TextDrawHideForPlayer(playerid, Server_TD[3]);
	TextDrawHideForPlayer(playerid, Server_TD[4]);
	TextDrawHideForPlayer(playerid, Server_TD[5]);
	TextDrawHideForPlayer(playerid, Server_TD[6]);


	TextDrawHideForPlayer(playerid, wTD);
	TextDrawHideForPlayer(playerid, wTD1);
	TextDrawHideForPlayer(playerid, wTD2);
	TextDrawHideForPlayer(playerid, wTD3);
	TextDrawHideForPlayer(playerid, wTD4);
	TextDrawHideForPlayer(playerid, wTD5);
	TextDrawHideForPlayer(playerid, raceCT);
	HidePlayerMSGBox(playerid);
}

// Show player textdraws, OnPlayerSpawn
stock ShowPlayerTextDraws_OPS(playerid)
{
	TextDrawShowForPlayer(playerid, msgTD);

	if(hideMSG[playerid] == 0) ShowPlayerMSGBox(playerid);
}

// Textdraws
stock ShowPlayerAchievement(playerid, title[], infos[])
{
	TextDrawShowForPlayer(playerid, AchTD[0]);
	TextDrawShowForPlayer(playerid, AchTD[1]);
	TextDrawShowForPlayer(playerid, AchTD[2]);
	TextDrawShowForPlayer(playerid, AchTD[3]);
	TextDrawShowForPlayer(playerid, AchTD[4]);
	TextDrawShowForPlayer(playerid, AchTD[5]);
	PlayerTextDrawSetString(playerid, DynamicAchTD[playerid][0], title);
	PlayerTextDrawSetString(playerid, DynamicAchTD[playerid][1], infos);
	PlayerTextDrawShow(playerid, DynamicAchTD[playerid][0]);
	PlayerTextDrawShow(playerid, DynamicAchTD[playerid][1]);
	PlayerPlaySound(playerid, 1183, 0, 0, 0);
	SetPVarInt(playerid, "AchShowing", 1);
	SetTimerEx("HideAch", 5500, false, "d", playerid);
	return true;
}

forward HideAch(playerid);
public HideAch(playerid)
{
	DeletePVar(playerid, "AchShowing");
	PlayerPlaySound(playerid, 1186, 0, 0, 0);
	TextDrawHideForPlayer(playerid, AchTD[0]);
	TextDrawHideForPlayer(playerid, AchTD[1]);
	TextDrawHideForPlayer(playerid, AchTD[2]);
	TextDrawHideForPlayer(playerid, AchTD[3]);
	TextDrawHideForPlayer(playerid, AchTD[4]);
	TextDrawHideForPlayer(playerid, AchTD[5]);
	PlayerTextDrawHide(playerid, DynamicAchTD[playerid][0]);
	PlayerTextDrawHide(playerid, DynamicAchTD[playerid][1]);
	return true;
}

hideKillCam(playerid)
{
	PlayerTextDrawHide(playerid, Armour[playerid]), PlayerTextDrawHide(playerid, HealthTD[playerid]), PlayerTextDrawHide(playerid, NameX[playerid]),
	PlayerTextDrawHide(playerid, killStreakTD[playerid]), PlayerTextDrawHide(playerid, killCamTD8[playerid]), TextDrawHideForPlayer(playerid, killCamTD), TextDrawHideForPlayer(playerid, killCamTD1);
	if(hideMSG[playerid] == 0) ShowPlayerMSGBox(playerid);
}
showKillCam(playerid)
{
	PlayerTextDrawShow(playerid, Armour[playerid]), PlayerTextDrawShow(playerid, HealthTD[playerid]), PlayerTextDrawShow(playerid, NameX[playerid]),
	PlayerTextDrawShow(playerid, killStreakTD[playerid]), PlayerTextDrawShow(playerid, killCamTD8[playerid]), TextDrawShowForPlayer(playerid, killCamTD), TextDrawShowForPlayer(playerid, killCamTD1);
	if(hideMSG[playerid] == 0) HidePlayerMSGBox(playerid);
}

// Info textdraw messaging
forward InfoTD_MSG(playerid, ms_time, text[]);
public InfoTD_MSG(playerid, ms_time, text[])
{
	if(GetPVarInt(playerid, "InfoTDshown") != -1)
	{
		PlayerTextDrawHide(playerid, InfoTD[playerid]);
		KillTimer(GetPVarInt(playerid, "InfoTDshown"));
	}

	PlayerTextDrawSetString(playerid, InfoTD[playerid], text);
	PlayerTextDrawShow(playerid, InfoTD[playerid]);
	SetPVarInt(playerid, "InfoTDshown", SetTimerEx("InfoTD_Hide", ms_time, false, "i", playerid));
}

// Info textdraw timer for hiding the textdraw
forward InfoTD_Hide(playerid);
public InfoTD_Hide(playerid)
{
	SetPVarInt(playerid, "InfoTDshown", -1);
	PlayerTextDrawHide(playerid, InfoTD[playerid]);
}
