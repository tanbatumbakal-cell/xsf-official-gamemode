#define TEST_SERVER 0
						//=== Test server Config ===
						//Values: 	0 = NORMAL, in production, and enables IRC
						//			1 = TEST SERVER on your host
						// 			2 = TEST SERVER on local machine for testing

//=== PLEASE CHANGE THIS ===============
#define BIND_MAIN "CHANGE ME TO YOUR PUBLIC IP"
#if TEST_SERVER == 0 //production, main server (where players join)
	#define MYSQL_HOST "" //if on same server, "localhost" is used here.
	#define MYSQL_USER "" //mysql user - DO NOT USE ROOT!!!! (Make a user that does not have access to f.ex "DROP")
	#define MYSQL_PASS "" //mysql password
	#define MYSQL_DB   "" //mysql database name
#elseif TEST_SERVER == 1 //test server on host
	#define MYSQL_HOST "" 
	#define MYSQL_USER ""  
	#define MYSQL_PASS "" 
	#define MYSQL_DB   "" 
#elseif TEST_SERVER == 2 //test server locally..
	#define MYSQL_HOST "" 
	#define MYSQL_USER ""  
	#define MYSQL_PASS "" 
	#define MYSQL_DB   "" 
#endif

//feel free to change IRC stuff on bottom as well.
////////////////////////////////////
///////////////////////////////////

#define RESPAWN_TIME 60 // Vehicle respawn time

#undef MAX_PLAYERS
	#define MAX_PLAYERS 421

#undef MAX_VEHICLES
	#define MAX_VEHICLES 1600
#define BIND_LOCAL 	"127.0.0.1"

// === Anti Map Stealer ===
#define USE_ANTI_STEALER (true)
#if USE_ANTI_STEALER == true

#define DISALLOWED_ADDRESS "DA0E5085558CCACC88ECCA40C4CEC49A9408EEE8"
native gpci(playerid, const serial[], maxlen);

#endif



#if TEST_SERVER == 0
	#define IRC
	#define IRC_SERVER  	"irc.sa-irc.com"
	#define IRC_PORT    6667
	#define IRC_REALNAME    "Server"
	#define IRC_HOSTNAME    "Server"
	#define IRC_CHANNEL     "#Server.echo"
	#define IRC_aCHANNEL    "#Server.staff"
	#define IRC_BOT_1_NAME  "Server-1"
	#define IRC_BOT_2_NAME  "Server-2"
	#define IRC_BOT_3_NAME  "Server-3"
	#define IRC_BOT_4_NAME  "Server-4"
	#define IRC_BOT_5_NAME  "Server-5"
	#define IRC_NICKSERV            "Nickserv"
	#define IRC_NOTICE_REGISTER 	"This nickname is registered."
	#define IRC_NOTICE_NOREGISTER   "Your nick isn't registered"
	#define IRC_NOTICE_PASSWORD_OK  "Password accepted"
	#define IRC_NOTICE_PASSWORD_NO  "Password incorrect"
	#define IRC_IDENTIFY_RAW        "/msg nickserv identify password"
	#define IRC_REGISTER_RAW        "/msg nickserv register password email"
	#define IRC_NOTICE_REGISTERED   "registered under your account"
#else
	#define IRC
	#define IRC_SERVER  	"ASDASD"
	#define IRC_PORT    6667
	#define IRC_REALNAME    "ASDASD"
	#define IRC_HOSTNAME    "ASDASD"
	#define IRC_CHANNEL     "ASDASD"
	#define IRC_aCHANNEL    "ASDASD"
	#define IRC_BOT_1_NAME  "ASDASD1"
	#define IRC_BOT_2_NAME  "ASDASD2"
	#define IRC_BOT_3_NAME  "ASDASD3"
	#define IRC_BOT_4_NAME  "ASDASD4"
	#define IRC_BOT_5_NAME  "ASDASD5"
	#define IRC_NICKSERV            "Nickserv"
	#define IRC_NOTICE_REGISTER 	"This nickname is registered."
	#define IRC_NOTICE_NOREGISTER   "Your nick isn't registered"
	#define IRC_NOTICE_PASSWORD_OK  "Password accepted"
	#define IRC_NOTICE_PASSWORD_NO  "Password incorrect"
	#define IRC_IDENTIFY_RAW        "/msg nickserv identify password"
	#define IRC_REGISTER_RAW        "/msg nickserv register password email"
	#define IRC_NOTICE_REGISTERED   "registered under your account"
#endif

	
//=== [IRC Vars] ===
#define MAX_BOTS (6)
new ircName[MAX_BOTS][16];
new	ircBot[MAX_BOTS];
new ircGroup;
new bool:ircBotConnected[MAX_BOTS],
	bool:ircBotInChannel[MAX_BOTS],
	bool:ircIdentified[MAX_BOTS];

