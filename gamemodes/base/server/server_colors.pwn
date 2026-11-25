/*==============================================================================
								 Colors
===============================================================================*/
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_WHITEP 		0xFFE4C4FF
#define COLOR_ORANGE   	0xDB881AFF
#define COLOR_ORANGE2		0xFF5000FF
#define COLOR_IVORY 		0xFFFF82FF
#define COLOR_LIME 		0xD2D2ABFF
#define COLOR_BLUE			0x004BFFFF
#define COLOR_SBLUE		0x56A4E4FF
#define COLOR_RCONBLUE     0x2587CEAA
#define COLOR_PURPLE 		0x5A00FFFF
#define COLOR_RED 			0xFF0000FF
#define COLOR_LRED 		0xE65555FF
#define COLOR_LIGHTGREEN 	0x00FF00FF
#define COLOR_YELLOW 		0xFFFF00FF
#define COLOR_YELLOW2 		0xF5DEB3FF
#define COLOR_LB 			0x15D4EDFF
#define COLOR_PINK			0xEE82EEFF
#define COLOR_GOLD			0xFFD700FF
#define COLOR_FIREBRICK 	0xB22222FF
#define COLOR_GREEN 		0x3BBD44FF
#define COLOR_GREY			0xBABABAFF
#define COLOR_GREY2 		0x778899FF
#define COLOR_GREY3		0xC8C8C8FF
#define COLOR_DARK 		0x7A7A7AFF
#define COLOR_BROWN 		0x8B4513FF
#define COLOR_SYSTEM 		0xEFEFF7FF


#define RED_E 		"{FF0000}"
#define BLUE_E 	"{004BFF}"
#define SBLUE_E 	"{56A4E4}"
#define PINK_E 	"{FFB6C1}"
#define YELLOW_E 	"{FFFF00}"
#define LG_E 		"{00FF00}"
#define LB_E 		"{15D4ED}"
#define LB2_E 		"{87CEFA}"
#define GREY_E 	"{BABABA}"
#define GREY2_E 	"{778899}"
#define GREY3_E 	"{C8C8C8}"
#define DARK_E 	"{7A7A7A}"
#define WHITE_E 	"{FFFFFF}"
#define WHITEP_E 	"{FFE4C4}"
#define IVORY_E 	"{FFFF82}"
#define ORANGE_E 	"{DB881A}"
#define GREEN_E 	"{3BBD44}"
#define PURPLE_E 	"{5A00FF}"
#define LIME_E 	"{D2D2AB}"
#define LRED_E		"{E65555}"

// Staff System Colors
#define HELPER_C		"{40be42}"
#define MOD_C		"{0d8403}"
#define ADMIN_C		"{9c348f}"
#define SENIOR_C		"{ffa403}"
#define HEAD_C		"{0009fc}"
#define OWNER_C		"{ff0000}"

//=== Color ===
#define COLOR_RGB(%1,%2,%3,%4) (((((%1) & 0xff) << 24) | (((%2) & 0xff) << 16) | (((%3) & 0xff) << 8) | ((%4) & 0xff)))
#define StripAlpha(%0) ((%0) >>> 8)

//=== Functions ===
#define Error(%1,%2) SendClientMessage(%1, COLOR_GREY3, ""RED_E"ERROR: "GREY3_E""%2)
#define Info(%1,%2) SendClientMessage(%1, COLOR_WHITEP, ""LB_E"INFO: "WHITEP_E""%2)
#define Usage(%1,%2) SendClientMessage(%1, COLOR_WHITEP, ""RED_E"» "ORANGE_E"USAGE: "WHITEP_E""%2)
#define PreloadAnimLib(%1,%2) ApplyAnimation(%1,%2,"NULL",0.0,0,0,0,0,0)
#define function%0(%1) forward %0(%1); public %0(%1)
#define Server "{FF0000}Server {7A7A7A}»{DBED15}"
#define RACE "{DBED15}[{DB881A}RACE{DBED15}]{FFE4C4}"
#define PARKOUR "{FFB6C1}[{56A4E4}PARKOUR{FFB6C1}]{D2D2AB}"
#define EVENT "{DBED15}[{7A7A7A}EVENT{DBED15}]{FFFFFF}"
#define FALLOUT "{DBED15}[{15D4ED}FALLOUT{DBED15}]{D2D2AB}"
#define DERBY "{DBED15}[{FFB6C1}DERBY{DBED15}]{FFE4C4}"
#define LMS "{7A7A7A}[{FF0000}LMS{7A7A7A}]{FFE4C4}"
#define DUEL "{FF0000}[DUEL]"
#define GROUP "{DBED15}[{D2D2AB}GROUP{DBED15}]{87CEFA}"
#define MB "{00FF00}[MB]"
#define CJ "{DBED15}[CJ]"
#define arrow "{15D4ED}»"
#define dot "{F2F853}• {F0F0F0}"
#define SendFormatMessage(%0,%1,%2,%3) do{format(str, 150, %2, %3); SendClientMessage(%0, %1, str); } while(FALSE)

