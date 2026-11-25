//==============================================================================
//                         Server Houses
//==============================================================================
#define INFORMATION_HEADER "{DB881A}Server: {15D4ED}Houses"
#define LABELTEXT1 ""LB_E"House Name: {F6F6F6}%s\n"LB_E"House Owner: {F6F6F6}No Owner\n"LB_E"House Value: {F6F6F6}$%s\n"LB_E"For Sale: {F6F6F6}Yes\n"LB_E"House ID: "ORANGE_E"%d"
#define LABELTEXT2 ""LB_E"House Name: {F6F6F6}%s\n"LB_E"House Owner: {F6F6F6}%s\n"LB_E"House Value: {F6F6F6}$%s\n"LB_E"House Privacy: "GREEN_E"%s\n"LB_E"House ID: "ORANGE_E"%d"
#define LABELTEXT3 ""LB_E"House Name: {F6F6F6}%s\n"LB_E"House Owner: {F6F6F6}%s\n"LB_E"House Value: {F6F6F6}$%s\n"LB_E"House Privacy: "GREEN_E"%s\n"LB_E"House ID: "ORANGE_E"%d\n"GREY_E"[House For Sale: "GREEN_E"$%s"GREY_E"]"

//==============================================================================
//                              Macros
//==============================================================================
new CMDSString[1200], IsInHouse[MAX_PLAYERS char];
//new bool: FALSE = false;

#define Answer(%0,%1,%2) (%0) == (1) ? (%1) : (%2)
#define IsPlayerInHouse(%0,%1) ((GetPVarInt(%0, "LastHouseCP") == (%1)) && (IsInHouse{%0} == (1))) ? (1) : (0)
#define ShowInfoBox(%0,%1,%2) do{CMDSString = ""; format(CMDSString, 1000, %1, %2); ShowPlayerDialog(%0, HOUSEMENU-1, DIALOG_STYLE_MSGBOX, INFORMATION_HEADER, CMDSString, "Close", "");}while(FALSE)
#define GameTextEx(%0,%1,%2,%3,%4) do{CMDSString = ""; format(CMDSString, 1000, %3, %4); GameTextForPlayer(%0, CMDSString, %1, %2);}while(FALSE)
#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)
#define TYPE_OUT (0)
#define TYPE_INT (1)

//==============================================================================
//                              COLORS
//==============================================================================
#define COLOR_INFO			   			0x00CC33FF
#define COLOR_DIALOG                    0xF6F6F6AA
//==============================================================================
#define DC_SAMP         				"{F6F6F6}"
#define DC_DIALOG 						"{F6F6F6}"
#define DC_ERROR 						"{FF0000}"
#define DC_ADMIN 						"{CC00CC}"
#define DC_INFO 						""LB_E""


//==============================================================================
//                              Configuration
//==============================================================================
#define MAX_HOUSES 					800 // Max houses created
#define MAX_HOUSE_INTERIORS         27 // Max house interiors created
#define MAX_HOUSES_OWNED    		1 // Max houses owned per player
#define HOUSEMENU 					2170 // Dialog ID

//------------------------------------------------------------------------------
#define GH_USE_MAPICONS 			true  // true = use mapicons | false = do not use mapicons
#define GH_USE_CPS 					false  // true = use checkpoints | false = use pickups
#define GH_HINTERIOR_UPGRADE 		true  // true = allow players to upgrade their house interior | false = do not allow players to upgrade their house interior
#define GH_USE_HOUSESTORAGE 		true  // true = allow players to use the house storage | false = do not allow players to use the house storage
#define SPAWN_IN_HOUSE 				true  // true = players will spawn in their house on their first spawn | false = players will not spawn in their house on their first spawn
#define CASE_SENSETIVE              true  // true = ignore case sensetive in strcmp | false = do not ignore case sensetive in strcmp
#define GH_ALLOW_BREAKIN            true  // true = allow players to breakin to houses | false = do not allow players to breakin to houses
#define GH_GIVE_WANTEDLEVEL         true  // true = increase the players wanted level when they either attempt to breakin/rob a house or they succeed in doing so | false = do not increase the players wanted level when they either attempt to breakin/rob a house or they succeed in doing so
#define GH_ALLOW_HOUSEROBBERY       true // true = allow players to rob houses | false = do not allow players to rob houses
#define GH_SAVE_ADMINWEPS 			false // true = save admin weapons (f.ex: minigun, grenades, RPG) | false = do not save admin weapons (f.ex: minigun, grenades, RPG)
#define GH_USE_WEAPONSTORAGE 		true // true = allow players to store weapons in their house | false = do not allow players to store weapons in their house
#define GH_ALLOW_HOUSETELEPORT      true // true = allow players to teleport to their house using /myhouses | false = do not allow players to teleport to their house using /myhouses
//------------------------------------------------------------------------------
#define HOUSEFILE_LENGTH      		40
#define INTERIORFILE_LENGTH   		30
#define MIN_HOUSE_VALUE             1 // Min house value of a house (ofc prices will change when a house is bought/sold nearby)
#define MAX_HOUSE_VALUE             1000000000 // Max house value of a house (ofc prices will change when a house is bought/sold nearby)
#define E_MAX_HOUSES_OWNEDUSE_VALUE 25000000 // Max house value of a house (ofc prices will change when a house is bought/sold nearby)
#define MIN_HINT_VALUE      		10000 // Min house interior value
#define MAX_HINT_VALUE      		50000000 // Max house interior value
#define HOUSE_ROBBERY_PERCENT       25 // How many percent of the cash in the house storage will be robbed?
#define MAX_MONEY_ROBBED            500000 // Max money you can rob from a house.
#define HSPAWN_TIMER_RATE   		500 // After how long will the timer call the spawn in house function? (in ms)
#define MICON_VD 					160.0 // Map icon visible range (drawdistance).
#define TEXTLABEL_DISTANCE 			30.0 // 3D text visible range (drawdistance)
#define TEXTLABEL_TESTLOS 			1 // 1 makes the 3D text label visible trough walls.
#define PICKUP_MODEL_OUT 			1273 // Pickup model ID which shows up OUTSIDE the house.
#define PICKUP_MODEL_INT 			1272 // Pickup model ID which shows up INSIDE the house.
#define PICKUP_TYPE                 1 // The pickup type if you decide to not use checkpoints
#define MAX_VISIT_TIME              1 // The max time the player can be visiting in (In Minutes).
#define TIME_BETWEEN_VISITS         2 // The time the player have to wait before previewing a new house interior (In minutes).
#define TIME_BETWEEN_BREAKINS       5 // The time the player have to wait before attempting to breakin to a house again (In minutes).
#define TIME_BETWEEN_ROBBERIES      10 // The time the player have to wait before attempting to rob a house again (In minutes).
#define HOUSE_SELLING_PROCENT   	75 // The amount of the house value the player will get when the house is sold.

#define MAX_HOUSE_NAME              35 // Max length of a house name
#define MIN_HOUSE_NAME              4 // Min length of a house name
#define MAX_HINT_NAME              	35 // Max length of a house interior name
#define MIN_HINT_NAME              	4 // Min length of a house interior name
#define MAX_HOUSE_PASSWORD          35 // Max length of a house password
#define MIN_HOUSE_PASSWORD          4 // Min length of a house password
#define MAX_ZONE_NAME 				28 // Max length of a zone name

#define INVALID_HOWNER_NAME         "INVALID_PLAYER_ID"// The "name" of the house owner when there is no owner of the house
#define DEFAULT_HOUSE_NAME          ""GREY2_E"House For Sale!" // The default name when a house is created/sold


//------------------------------------------------------------------------------
new Iterator:Houses<MAX_HOUSES>;
new Text3D:HouseLabel[MAX_HOUSES];
new HousePickupOut[MAX_HOUSES];
new HousePickupInt[MAX_HOUSES];
new HouseMIcon[MAX_HOUSES];
new Float:Xp, Float:Yp, Float:Zp, Float:Angle;

enum Data
{
	HouseID,
	HousePassword[40],
	HouseOwner,
	HouseName[80],
	HouseLocation[MAX_ZONE_NAME],
	Float:SpawnOutAngle,
	Float:CPOutX,
	Float:CPOutY,
	Float:CPOutZ,
	Float:SpawnOutX,
	Float:SpawnOutY,
	Float:SpawnOutZ,
	HouseValue,
	HouseStorage,
	HouseInterior,
	HouseForSale,
	Weapon[14],
	Ammo[14],
	HousePrivacy,
	HouseAlarm,
	HouseCamera,
	HouseDog,
	UpgradedLock
}
enum hIntData
{
	IntName[30],
	Float:IntSpawnX,
	Float:IntSpawnY,
	Float:IntSpawnZ,
	Float:IntSpawnAngle,
	Float:IntCPX,
	Float:IntCPY,
	Float:IntCPZ,
	IntInterior,
	IntValue
}
new hInfo[MAX_HOUSES][Data], hIntInfo[MAX_HOUSE_INTERIORS][hIntData];


//==============================================================================
//                   SendClientMessage Messages
//==============================================================================
#define E_NO_HOUSES_OWNED "{F6F6F6}You do not own any houses."
#define I_HMENU "{F6F6F6}Type /housemenu (/hm) to access the house menu."
#define E_H_ALREADY_OWNED "{F6F6F6}This house is already owned by someone else."
#define E_INVALID_HPASS_LENGTH "{F6F6F6}Invalid house password length"
#define E_INVALID_HPASS "{F6F6F6}Invalid house password. You may not use this house password."
#define E_INVALID_HPASS_CHARS "{F6F6F6}Your house password contains illegal characters ("LB_E"percentage sign {F6F6F6}or "LB_E"~{F6F6F6})."
#define E_INVALID_HNAME_LENGTH "{F6F6F6}Invalid house name length."
#define E_INVALID_HNAME_CHARS "{F6F6F6}Your house name contains illegal characters ("LB_E"percentage sign {F6F6F6}or "LB_E"~{F6F6F6})."
#define I_HPASS_NO_CHANGE "{F6F6F6}Your house password remains the same."
#define I_HPASS_REMOVED "{F6F6F6}The house password for this house has been removed."
#define E_NOT_ENOUGH_PMONEY "{F6F6F6}You do not have that much money."
#define E_INVALID_AMOUNT "{F6F6F6}Invalid amount."
#define E_HSTORAGE_L_REACHED "{F6F6F6}You can not deposit this much money into your house storage. It can only hold up to "LB_E"$500,000,000{F6F6F6}."
#define E_NOT_ENOUGH_HSMONEY "{F6F6F6}You do not have that much money in your house storage."
#define E_INVALID_HPASS_CHARS2 "{F6F6F6}The entered house password contains illegal characters ("LB_E"percentage sign {F6F6F6}or "LB_E"~{F6F6F6})."
#define E_C_ACCESS_SE_HM "{F6F6F6}You can not access someone elses house menu."
#define E_NOT_IN_HOUSE "{F6F6F6}You need to be in a house to use this command."
#define E_NOT_HOWNER "{F6F6F6}You need to be the owner of a house to use this command."
#define E_INVALID_HID "{F6F6F6}Invalid house ID. This house ID does not exist."
#define E_VIPHOUSE "{F6F6F6}This house is reserved for premium players, check /vip for more info."
#define E_H_A_F_SALE "{F6F6F6}This house is already for sale. You can not sell it."
#define E_ALREADY_HAVE_HINTERIOR "{F6F6F6}You already have this house interior."
#define E_HINT_WAIT_BEFORE_VISITING "{F6F6F6}Please wait before visiting a house interior again."
#define I_WRONG_HPASS1 "{F6F6F6}You have failed to enter "LB_E"%s's {F6F6F6}house using the password "LB_E"%s{F6F6F6}."
#define I_WRONG_HPASS2 ""LB_E"%s (%d) {F6F6F6}has attempted to enter your house using the password "LB_E"%s{F6F6F6}."
#define I_CORRECT_HPASS1 "{F6F6F6}You have successfully entered "LB_E"%s's {F6F6F6}house using the password "LB_E"%s{F6F6F6}."
#define I_CORRECT_HPASS2 ""LB_E"%s (%d) {F6F6F6}has successfully entered your house using the password "LB_E"%s{F6F6F6}!"
#define E_TOO_MANY_HOUSES "{F6F6F6}Sorry, but there are already "LB_E"%d {F6F6F6}houses created.\nDelete one of the current ones or increase the limit in the script."
#define I_H_CREATED "{F6F6F6}House ID "LB_E"%d {F6F6F6}created..."
#define I_ALLH_DESTROYED "{F6F6F6}All houses removed. ("LB_E"%d {F6F6F6}in total)"
#define I_HSPAWN_CHANGED "{F6F6F6}You have changed the spawnposition and angle for house ID "LB_E"%d{F6F6F6}."
#define I_TELEPORT_MSG "{F6F6F6}You have teleported to house ID "LB_E"%d{F6F6F6}."
#define I_H_SOLD "{F6F6F6}You have sold house ID "LB_E"%d{F6F6F6}..."
#define I_H_PRICE_CHANGED "{F6F6F6}The value for house ID "LB_E"%d has been changed to "LB_E"$%d{F6F6F6}."
#define I_H_MOVED "{F6F6F6}You have relocated house ID %d!"
#define I_H_RELOADED "{F6F6F6}You have re-loaded house ID %d!"
#define I_H_DESTROYED "{F6F6F6}House ID "LB_E"%d {F6F6F6}destroyed..."
#define I_HINT_VISIT_OVER "{F6F6F6}Your visiting time is over.\nDo you want to buy the house interior "LB_E"%s {F6F6F6}for "LB_E"$%d{F6F6F6}?"
#define HMENU_SELL_HOUSE2 "{F6F6F6}Type in how much you want to sell your house for below:"
#define HMENU_CANCEL_HOUSE_SALE "{F6F6F6}Your house is no longer for sale."
#define HMENU_HSALE_CANCEL "{F6F6F6}Click "LB_E"\"Remove\" {F6F6F6}to cancel the house sale for this house."
#define E_H_NOT_FOR_SALE "{F6F6F6}This house is not for sale."
#define E_INVALID_HSELL_AMOUNT "{F6F6F6}Invalid amount. The price you want to sell your house for can not be higher than "LB_E"$"#MAX_HOUSE_VALUE" {F6F6F6}or lower than "LB_E"$"#MIN_HOUSE_VALUE"{F6F6F6}."
#define I_H_SET_FOR_SALE "{F6F6F6}You have successfully set your house "LB_E"%s {F6F6F6}for sale for "LB_E"$%d{F6F6F6}."
#define HSELL_BUY_DIALOG ""LB_E"Current House Owner: {F6F6F6}%s\n"LB_E"Current House Name: {F6F6F6}%s\n\nAre You Sure You Want To Buy This House For "LB_E"$%d{F6F6F6}?"
#define HSELLER_CONNECTED_MSG1 "{F6F6F6}Your house "LB_E"%s {F6F6F6}has been sold to "LB_E"%s (%d){F6F6F6}.\n"
#define HSELLER_CONNECTED_MSG2 ""LB_E"You receive: {F6F6F6}$%d\n"LB_E"House Storage: {F6F6F6}$%d\n"LB_E"House Price: {F6F6F6}$%d"
#define HSELLER_OFFLINE_MSG1 "{F6F6F6}Your house "LB_E"%s {F6F6F6}has been sold to "LB_E"%s {F6F6F6}while you were offline.\n"
#define HSELLER_OFFLINE_MSG2 ""LB_E"You receive: {F6F6F6}$%d\n"LB_E"House Storage: {F6F6F6}$%d\n"LB_E"House Price: {F6F6F6}$%d"
#define I_TO_PLAYERS_HSOLD "{F6F6F6}This house has been sold.\nYou have been automaticly kicked out from the house."
#define E_INVALID_HINT "{F6F6F6}Invalid house interior. Accepted house interiors are between "LB_E"0 {F6F6F6}and "LB_E""#MAX_HOUSE_INTERIORS"{F6F6F6}."
#define E_CMD_USAGE_CHANGEHINTSPAWN "Usage:{F6F6F6} /changehintspawn (house interior)"
#define E_CMD_USAGE_REMOVEHOUSE "Usage:{F6F6F6} /removehouse (houseid)"
#define E_CMD_USAGE_CREATEHINT "Usage:{F6F6F6} /createhint (value) (name)"
#define E_CMD_USAGE_REMOVEHINT "Usage:{F6F6F6} /removehint (house interior)"
#define E_CMD_USAGE_CREATEHOUSE "Usage:{F6F6F6} /createhouse (house value) (optional: house interior)"
#define E_CMD_USAGE_CHANGESPAWN "Usage:{F6F6F6} /changespawn (houseid)"
#define E_CMD_USAGE_GOTOHOUSE "Usage:{F6F6F6} /gotohouse (houseid)"
#define E_CMD_USAGE_SELLHOUSE "Usage:{F6F6F6} /sellhouse (houseid)"
#define E_CMD_USAGE_CHANGEPRICE "Usage:{F6F6F6} /changeprice (houseid) (price)"
#define E_CMD_USAGE_MOVEHOUSE "Usage:{F6F6F6} /movehouse (houseid)"
#define E_CMD_USAGE_RELOADHOUSE "Usage:{F6F6F6} /reloadhouse (houseid)"
#define E_CMD_USAGE_CHANGEALLPRICE "Usage:{F6F6F6} /changeallprices (price)"
#define E_INVALID_HINT_ID "{F6F6F6}Invalid house interior ID."
#define I_HINT_SPAWN_CHANGED "{F6F6F6}You have changed the spawn position and angel for house interior ID %d."
#define I_HINT_CREATED "{F6F6F6}House interior ID "LB_E"%d {F6F6F6}created...\n"LB_E"House Interior Value: {F6F6F6}$%d\n"LB_E"House Interior Name: {F6F6F6}%s"
#define E_TOO_MANY_HINTS "{F6F6F6}Sorry, but there are already "LB_E"%d {F6F6F6}house interiors created.\nDelete one of the current ones or increase the limit in the script."
#define E_INVALID_HINT_VALUE "{F6F6F6}Invalid house interior value. The value must be between "LB_E"$"#MIN_HINT_VALUE" {F6F6F6}and "LB_E"$"#MAX_HINT_VALUE"{F6F6F6}."
#define E_INVALID_HINT_LENGTH "{F6F6F6}Invalid house interior name length. The length must be between "LB_E""#MIN_HINT_NAME" {F6F6F6}and "LB_E""#MAX_HINT_NAME"{F6F6F6}."
#define I_HOWNER_HINFO_1 ""LB_E"House Name: {F6F6F6}%s\n"LB_E"House Location: {F6F6F6}%s\n"LB_E"Distance to house from you: {F6F6F6}%0.2f feet\n"
#define I_HOWNER_HINFO_2 ""LB_E"House Value: {F6F6F6}$%d\n"LB_E"House Storage: {F6F6F6}$%d\n"LB_E"House Privacy: {F6F6F6}%s\n"LB_E"House ID: {F6F6F6}%d"
#define HMENU_ENTER_PASS ""LB_E"House Name: {F6F6F6}%s\n"LB_E"House Owner: {F6F6F6}%s\n"LB_E"House Value: {F6F6F6}$%d\n"LB_E"House ID: {F6F6F6}%d\n\nEnter The Password For The House Below If You Wish To Enter:"
#define I_HINT_DEPOSIT1 "{F6F6F6}You have "LB_E"$%d {F6F6F6}in your house storage.\n\nType in the amount you want to deposit below:"
#define I_HINT_WITHDRAW1 "{F6F6F6}You have "LB_E"$%d {F6F6F6}in your house storage.\n\nType in the amount you want to withdraw below:"
#define I_HINT_DEPOSIT2 "{F6F6F6}You have successfully deposited "LB_E"$%d {F6F6F6}Into your house storage.\n"LB_E"Current Balance: {F6F6F6}$%d"
#define I_HINT_WITHDRAW2 "{F6F6F6}You have successfully withdrawn "LB_E"$%d {F6F6F6}From your house storage.\n"LB_E"Current Balance: {F6F6F6}$%d"
#define I_HINT_CHECKBALANCE "{F6F6F6}You have "LB_E"$%d {F6F6F6}in your house storage."
#define E_HINT_DOESNT_EXIST "{F6F6F6}Invalid house interior. This house interior does not exist."
#define HMENU_BUY_HOUSE "{F6F6F6}Do you want to buy this house for "LB_E"$%s{F6F6F6}?"
#define HMENU_BUY_HINTERIOR "{F6F6F6}Do you want to buy the house interior "LB_E"%s {F6F6F6}for "LB_E"$%d{F6F6F6}?"
#define HMENU_BUY_HINTERIORFREE "{F6F6F6}As a VIP member you can recieve the house interior %s for free, do you want this interior?"
#define HMENU_SELL_HOUSE "{F6F6F6}Are you sure you want to sell your house "LB_E"%s {F6F6F6}for "LB_E"$%s{F6F6F6}?"
#define I_SELL_HOUSE1_1 "{F6F6F6}You have successfully sold your house for "LB_E"$%s\n"
#define I_SELL_HOUSE1_2 ""LB_E"Selling Fee: {F6F6F6}$%d\nThe "LB_E"$%d {F6F6F6}in your house storage has been transfered to your pocket."
#define I_SELL_HOUSE1_3 "\nThe "LB_E"$%s {F6F6F6}in your house storage has been transfered to your pocket."
#define I_SELL_HOUSE2 "{F6F6F6}You have successfully sold your house "LB_E"%s {F6F6F6}for "LB_E"$%d.\n"LB_E"Selling Fee: {F6F6F6}$%d"
#define I_SELL_HOUSE2_2 "{F6F6F6}You have successfully sold your house "LB_E"%s {F6F6F6}for "LB_E"$%s."
#define I_BUY_HOUSE "{F6F6F6}You have successfully bought this house for "LB_E"$%d{F6F6F6}!"
#define I_HPASSWORD_CHANGED "{F6F6F6}You have successfully set the house password to "LB_E"%s{F6F6F6}!"
#define I_HNAME_CHANGED "{F6F6F6}You have successfully set the house name to "LB_E"%s{F6F6F6}!"
#define I_VISITING_HOUSEINT "{F6F6F6}You're now visiting the house interior "LB_E"%s{F6F6F6}.\nThis house interior costs "LB_E"$%d{F6F6F6}.\nYour visit time will end in "LB_E"%d {F6F6F6}minute%s."
#define E_CANT_AFFORD_HINT1 "{F6F6F6}You can not afford to buy the house interior "LB_E"%s{F6F6F6}.\n"LB_E"House Interior Price: {F6F6F6}$%d\n"
#define E_CANT_AFFORD_HINT2 ""LB_E"You have: {F6F6F6}$%d\n"LB_E"You Need: {F6F6F6}$%d"
#define I_HINT_BOUGHT "{F6F6F6}You have bought the house interior "LB_E"%s {F6F6F6}for "LB_E"$%d."
#define I_HINT_BOUGHTFREE "{F6F6F6}As a VIP member, you have recieved the house interior "LB_E"%s {F6F6F6}for free."
#define I_HS_WEAPONS1 "{F6F6F6}You have successfully stored "LB_E"%d {F6F6F6}weapon%s in your house storage."
#define I_HS_WEAPONS2 "{F6F6F6}You have successfully received "LB_E"%d {F6F6F6}weapon%s from your house storage."
#define E_INVALID_HVALUE "{F6F6F6}Invalid house value. The house value must be between "LB_E"$"#MIN_HOUSE_VALUE" {F6F6F6}and "LB_E"$"#MAX_HOUSE_VALUE"{F6F6F6}."
#define I_HOPEN_FOR_VISITORS "{F6F6F6}You have successfully opened your house for visitors."
#define I_CLOSED_FOR_VISITORS1 "{F6F6F6}You have successfully closed your house for visitors.\n"LB_E"Total visitors kicked out: {F6F6F6}%d"
#define I_CLOSED_FOR_VISITORS2 ""LB_E"%s (%d) {F6F6F6}has closed their house for visitors. Automaticly exiting house..."
#define E_MAX_HOUSES_OWNED "{F6F6F6}You already own "LB_E"%d {F6F6F6}house(s). Sell one of your houses others before buying a new one."
#define E_CANT_AFFORD_HOUSE "{F6F6F6}You can not afford to buy this house.\n"LB_E"House Value: {F6F6F6}$%d\n"LB_E"You Have: {F6F6F6}$%d\n"LB_E"You Need: {F6F6F6}$%d"
#define I_SUCCESSFULL_BREAKIN1_1 ""LB_E"%s (%d) {F6F6F6}has successfully broken into your house "LB_E"%s {F6F6F6}in "LB_E"%s{F6F6F6}."
#define I_SUCCESSFULL_BREAKIN1_2 "{F6F6F6}Someone has successfully broken into your house "LB_E"%s {F6F6F6}in "LB_E"%s{F6F6F6}."
#define I_SUCCESSFULL_BREAKIN2 "{F6F6F6}You have successfully broken into this house.\n"LB_E"House Name: {F6F6F6}%s\n"LB_E"House Owner: {F6F6F6}%s"
#define E_FAILED_BREAKIN1_1 ""LB_E"%s (%d) {F6F6F6}has failed to breakin to your house "LB_E"%s {F6F6F6}in "LB_E"%s{F6F6F6}."
#define E_FAILED_BREAKIN1_2 "{F6F6F6}Someone has failed to breakin to your house "LB_E"%s {F6F6F6}in "LB_E"%s{F6F6F6}."
#define E_FAILED_BREAKIN2 "{F6F6F6}You have failed to breakin to this house.\n"LB_E"House Name: {F6F6F6}%s\n"LB_E"House Owner: {F6F6F6}%s"
#define E_KICKED_NOT_IN_HOUSE "{F6F6F6}This player is not in your house."
#define I_KICKED_FROM_HOUSE1 "{F6F6F6}You have kicked out "LB_E"%s (%d) {F6F6F6}from your house."
#define I_KICKED_FROM_HOUSE2 "{F6F6F6}You have been kicked out from the house by "LB_E"%s (%d){F6F6F6}."
#define E_ALREADY_HAVE_HOUSEKEYS "{F6F6F6}You have already given the house keys for this house to this player."
#define I_HOUSEKEYS_RECIEVED_1 "{F6F6F6}You have given "LB_E"%s (%d) {F6F6F6}house keys to this house."
#define I_HOUSEKEYS_RECIEVED_2 "{F6F6F6}You have been given house keys to "LB_E"%s {F6F6F6}in "LB_E"%s {F6F6F6}by "LB_E"%s (%d){F6F6F6}."
#define E_DOESNT_HAVE_HOUSEKEYS "{F6F6F6}This player does not have the house keys for this house."
#define I_HOUSEKEYS_TAKEN_1 "{F6F6F6}You have taken away "LB_E"%s's (%d) {F6F6F6}house keys to this house."
#define I_HOUSEKEYS_TAKEN_2 ""LB_E"%s (%d) {F6F6F6}has taken away the house keys to his house "LB_E"%s {F6F6F6}in "LB_E"%s{F6F6F6}."
#define E_NONE_IN_HOUSE "{F6F6F6}There isn't anyone in your house."


stock Float:DistanceToPoint(Float:X1, Float:Y1, Float:Z1, Float:X2, Float:Y2, Float:Z2) return Float:floatsqroot(((X2 - X1) * (X2 - X1)) + ((Y2 - Y1) * (Y2 - Y1)) + ((Z2 - Z1) * (Z2 - Z1)));

//##############################################################################
// 								      Callbacks
//##############################################################################
function HouseVisiting(playerid)
{
	new string[200], tmpstring[50];
	GetPVarString(playerid, "HousePrevName", tmpstring, 50);
	format(string, sizeof(string), I_HINT_VISIT_OVER, tmpstring, GetPVarInt(playerid, "HousePrevValue"));
	ShowPlayerDialog(playerid, HOUSEMENU+17, DIALOG_STYLE_MSGBOX, INFORMATION_HEADER, string, "Buy", "Cancel");
	return 1;
}


function HouseSpawning(playerid)
{
	new houses, tmpName[24];
	GetPlayerName(playerid, tmpName, sizeof tmpName);
	foreach(new h : Houses)
	{
        
			if(hInfo[h][HouseOwner] == pRegID[playerid])
			{
				houses++;
				if(houseID[playerid] != -1)
				{
					SetPlayerHouseInterior(playerid, houseID[playerid]);
				}
				else SetPlayerHouseInterior(playerid, h);

				SetPVarInt(playerid, "LastHouseCP", h);
				if(GetPVarInt(playerid, "houseChecked") != h)
				{
					SetPVarInt(playerid, "houseChecked", h);
					format(query, sizeof(query), "UPDATE houses SET last_visited=UNIX_TIMESTAMP() WHERE house_id=%d", hInfo[h][HouseID]);
					MySQL_updateQuery(query);
				}
				break;
			}
		
	}
	if(houses == 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW, " INFO: "RED_E"Your house has been sold due to inactivity.");
		SendClientMessage(playerid, COLOR_YELLOW, ""LB2_E" You have spawned at Abandoned Airport.");
		SetPlayerPosition(playerid, 396.9685,2552.2439,19.8588,181.5505);
		pSpawnPlace[playerid] = -1;
		houseID[playerid] = -1;
		format(query, sizeof(query), "UPDATE players SET spawnplace=-1,house_id=-1 WHERE reg_id=%d", pRegID[playerid]);
		MySQL_updateQuery(query);

	}
}
function LoadHouseData()
{
	new h,
	s[32],
	Cache:housecache;
	housecache = cache_save();
	for(new i = 0, r = cache_num_rows(); i < r; i++)	
	{
		cache_set_active(housecache);
		h = Iter_Free(Houses);
		hInfo[h][HouseID] = cache_get_field_content_int(i, "house_id");
		cache_get_field_content(i, "hname", hInfo[h][HouseName], g_SQL_handle, 80);
		cache_get_field_content(i, "hlocation", hInfo[h][HouseLocation], g_SQL_handle, MAX_ZONE_NAME);
		cache_get_field_content(i, "hpass", hInfo[h][HousePassword], g_SQL_handle, 40);
		hInfo[h][HouseOwner] = cache_get_field_content_int(i, "howner");
		hInfo[h][SpawnOutX] = cache_get_field_content_float(i, "x");
		hInfo[h][SpawnOutY] = cache_get_field_content_float(i, "y");
		hInfo[h][SpawnOutZ] = cache_get_field_content_float(i, "z");
		hInfo[h][SpawnOutAngle] = cache_get_field_content_float(i, "a");
		hInfo[h][CPOutX] = cache_get_field_content_float(i, "cpx");
		hInfo[h][CPOutY] = cache_get_field_content_float(i, "cpy");
		hInfo[h][CPOutZ] = cache_get_field_content_float(i, "cpz");
		hInfo[h][HouseValue] = cache_get_field_content_int(i, "hvalue");
		hInfo[h][HouseStorage] = cache_get_field_content_int(i, "hstorage");
		hInfo[h][HouseInterior] = cache_get_field_content_int(i, "hint");
		hInfo[h][HousePrivacy] = cache_get_field_content_int(i, "hprivacy");
		hInfo[h][HouseForSale] = cache_get_field_content_int(i, "hforsale");
		cache_get_field_content(i, "name", s);
		CreateCorrectHouseExitCP(h);
		new labeltext[300];
		if(hInfo[h][HouseOwner] == 0)
		{
			format(labeltext, sizeof(labeltext), LABELTEXT1, hInfo[h][HouseName], ToCurrency(hInfo[h][HouseValue]), h);
			HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 31, -1, -1, -1, -1, MICON_VD);
			HousePickupOut[h] = CreateDynamicPickup(PICKUP_MODEL_OUT, PICKUP_TYPE, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], -1, -1, -1, 30.0);
		}
		else
		{
			if(hInfo[h][HouseForSale] != 0)
			{
				format(labeltext, sizeof(labeltext), LABELTEXT3, hInfo[h][HouseName], s, ToCurrency(hInfo[h][HouseValue]), Answer(hInfo[h][HousePrivacy], "Open", "Closed"), h, ToCurrency(hInfo[h][HouseForSale]));
				HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 31, -1, -1, -1, -1, MICON_VD);
				HousePickupOut[h] = CreateDynamicPickup(19524, PICKUP_TYPE, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], -1, -1, -1, 30.0);
			}
			else
			{
				format(labeltext, sizeof(labeltext), LABELTEXT2, hInfo[h][HouseName], s, ToCurrency(hInfo[h][HouseValue]), Answer(hInfo[h][HousePrivacy], "Open", "Closed"), h);
				HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 32, -1, -1, -1, -1, MICON_VD);
				HousePickupOut[h] = CreateDynamicPickup(19522, PICKUP_TYPE, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], -1, -1, -1, 30.0);
			}
		}
		HouseLabel[h] = CreateDynamic3DTextLabel(labeltext, COLOR_GREEN, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ]+0.7, TEXTLABEL_DISTANCE, .testlos = 1);

		Iter_Add(Houses, h);
		h++;
	}
	cache_delete(housecache);
	// DEBUG
	
	return 1;
}

stock Float:GetPosInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	switch(IsPlayerInAnyVehicle(playerid))
	{
		case 0: GetPlayerFacingAngle(playerid, a);
		case 1: GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;
}

stock LoadHouses()
{
	mysql_tquery(g_SQL_handle, "SELECT int_name,intx,inty,intz,inta,cpx,cpy,cpz,interior,value FROM interiors", "LoadHouseInteriorData");
	mysql_tquery(g_SQL_handle, "SELECT a.*, b.name FROM houses a LEFT JOIN players b ON a.howner = b.reg_id", "LoadHouseData");
	//mysql_tquery(g_SQL_handle, "SELECT * FROM houses ORDER BY house_id ASC", "LoadHouseData");
}

function LoadHouseInteriorData()
{
	new hint;

	new prows = cache_get_row_count();
	while( hint < prows )
	{

		cache_get_field_content(hint, "int_name", hIntInfo[hint][IntName], 30);
		hIntInfo[hint][IntSpawnX] = cache_get_field_content_float(hint, "intx");
		hIntInfo[hint][IntSpawnY] = cache_get_field_content_float(hint, "inty");
		hIntInfo[hint][IntSpawnZ] = cache_get_field_content_float(hint, "intz");
		hIntInfo[hint][IntSpawnAngle] = cache_get_field_content_float(hint, "inta");
		hIntInfo[hint][IntCPX] = cache_get_field_content_float(hint, "cpx");
		hIntInfo[hint][IntCPY] = cache_get_field_content_float(hint, "cpy");
		hIntInfo[hint][IntCPZ] = cache_get_field_content_float(hint, "cpz");
		hIntInfo[hint][IntInterior] = cache_get_field_content_int(hint, "interior");
		hIntInfo[hint][IntValue] = cache_get_field_content_int(hint, "value");
		hint++;
	}
	return 1;
}
//==============================================================================
// GetOwnedHouses(playerid);
// This function is used to find out how many houses a player owns
//==============================================================================
stock GetOwnedHouses(playerid)
{
	new tmpcount;
	foreach(new h : Houses)
	{
		if(hInfo[h][HouseOwner] == pRegID[playerid])
		{
			tmpcount++;
		}
		
	}
	return tmpcount;
}

//==============================================================================
// ReturnPlayerHouseID(playerid, houseslot);
// This function is used to return the house id from a players house 'slot'
// Example: ReturnPlayerHouseID(playerid, 0);
// Would return for example house ID 500.
//==============================================================================
stock ReturnPlayerHouseID(playerid, houseslot)
{
	new tmpcount;
	if(houseslot < 1 && houseslot > MAX_HOUSES_OWNED) return -1;
	foreach(new h : Houses)
	{
        
			if(hInfo[h][HouseOwner] == pRegID[playerid])
			{
				tmpcount++;
				if(tmpcount == houseslot)
				{
					return h;
				}
			}
		
	}
	return -1;
}

stock UnloadHouses()
{
	foreach(new h : Houses)
	{
		DestroyHouseEntrance(h, TYPE_OUT);
		DestroyHouseEntrance(h, TYPE_INT);
		DestroyDynamicMapIcon(HouseMIcon[h]);
		DestroyDynamic3DTextLabel(HouseLabel[h]);
	}
	Iter_Clear(Houses);
	return 1;
}

stock CreateCorrectHouseExitCP(houseid)
{
	new _int = hInfo[houseid][HouseInterior];
	HousePickupInt[houseid] = CreateDynamicPickup(PICKUP_MODEL_INT, PICKUP_TYPE, hIntInfo[_int][IntCPX], hIntInfo[_int][IntCPY], hIntInfo[_int][IntCPZ], (houseid + 1000), hIntInfo[_int][IntInterior], -1, 20.0);
	return 1;
}

stock SetPlayerHouseInterior(playerid, houseid)
{
	new _int = hInfo[houseid][HouseInterior];
	IsInHouse{playerid} = 1;
	SetPlayerPos(playerid, hIntInfo[_int][IntSpawnX], hIntInfo[_int][IntSpawnY], hIntInfo[_int][IntSpawnZ]);
	SetPlayerFacingAngle(playerid, hIntInfo[_int][IntSpawnAngle]);
	SetPlayerInterior(playerid, hIntInfo[_int][IntInterior]);
	SetPlayerVirtualWorld(playerid, (houseid + 1000));
	SetCameraBehindPlayer(playerid);
}

//==============================================================================
//                      CUSTOM HOUSE FUNCTIONS.
//==============================================================================
stock pNick(playerid)
{
	new GHNick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, GHNick, MAX_PLAYER_NAME);
	return GHNick;
}

stock ReturnProcent(Float:amount, Float:procent) return floatround(((amount / 100) * procent));


stock GetTotalHouses() return Iter_Count(Houses);
stock UpdateHouseText(houseid)
{
	new h[32];
	mysql_format(g_SQL_handle, query, 256, "SELECT name FROM players WHERE reg_id = %d", hInfo[houseid][HouseOwner]);
	mysql_query(g_SQL_handle, query, true);
	cache_get_field_content(0, "name", h);	
	new labeltext[300];
	if(hInfo[houseid][HouseForSale] != 0)
	{
		format(labeltext, sizeof(labeltext), LABELTEXT3, hInfo[houseid][HouseName], h, ToCurrency(hInfo[houseid][HouseValue]), Answer(hInfo[houseid][HousePrivacy], "Open", "Closed"), houseid, ToCurrency(hInfo[houseid][HouseForSale]));
	}
	if(hInfo[houseid][HouseOwner] == 0)
		format(labeltext, sizeof(labeltext), LABELTEXT2, hInfo[houseid][HouseName], ToCurrency(hInfo[houseid][HouseValue]), Answer(hInfo[houseid][HousePrivacy], "Open", "Closed"), houseid);
	else if(hInfo[houseid][HouseOwner] != 0)
		format(labeltext, sizeof(labeltext), LABELTEXT2, hInfo[houseid][HouseName], h, ToCurrency(hInfo[houseid][HouseValue]), Answer(hInfo[houseid][HousePrivacy], "Open", "Closed"), houseid);
	
	UpdateDynamic3DTextLabelText(HouseLabel[houseid], COLOR_GREEN, labeltext);
	printf("house bought %s", h);
}
stock AddS(amount)
{
	new returnstring[2];
	format(returnstring, 2, "");
	if(amount != 1 && amount != -1)
	{
		format(returnstring, 2, "s");
	}
	return returnstring;
}

stock GetSecondsBetweenAction(action) return floatround(floatdiv((GetTickCount() - action), 1000), floatround_tozero);

stock DestroyHouseEntrance(houseid, type)
{
	if(type == TYPE_OUT) { DestroyDynamicPickup(HousePickupOut[houseid]); }
	if(type == TYPE_INT) { DestroyDynamicPickup(HousePickupInt[houseid]); }
	return 1;
}

stock ShowInfoBoxEx(playerid, COLOR, message[])
{
	new HugeAssString[1000];
	format(HugeAssString, sizeof(HugeAssString), "{%06x}%s", (COLOR >>> 8), message);
	return ShowPlayerDialog(playerid, (HOUSEMENU-1), DIALOG_STYLE_MSGBOX, INFORMATION_HEADER, HugeAssString, "Close", "");
}

stock RandomEx(min, max) return (random((max - min)) + min);
stock ExitHouse(playerid, houseid)
{
	IsInHouse{playerid} = 0;
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid, hInfo[houseid][SpawnOutX], hInfo[houseid][SpawnOutY], hInfo[houseid][SpawnOutZ]);
	SetPlayerFacingAngle(playerid, hInfo[houseid][SpawnOutAngle]);
	SetCameraBehindPlayer(playerid);

	if(InDM[playerid] == 13) SetPlayerVirtualWorld(playerid, 20);
	else SetPlayerVirtualWorld(playerid, 0);
	return 1;
}

//==============================================================================
//                          COMMANDS
//==============================================================================
CMD:hm(playerid) return cmd_housemenu(playerid);
CMD:housemenu(playerid)
{
	
	new h = GetPVarInt(playerid, "LastHouseCP");
	if(hInfo[h][HouseOwner] != pRegID[playerid] && IsInHouse{playerid} == 1) 
		return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_C_ACCESS_SE_HM);
	if(IsInHouse{playerid} == 0) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_NOT_IN_HOUSE);
	if(InDM[playerid] != 0) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, "You can't access your house menu while in a DM!");
	if(GetOwnedHouses(playerid) == 0) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_NOT_HOWNER);
	if(IsInHouse{playerid} == 1 && hInfo[h][HouseOwner] == pRegID[playerid] && GetOwnedHouses(playerid) >= 1)
	{
		if(hInfo[h][HouseForSale] != 0)
		{
			ShowPlayerDialog(playerid, HOUSEMENU, DIALOG_STYLE_LIST, INFORMATION_HEADER, "House Selling\nHouse Storage\nHouse Name\nHouse Password\nHouse Privacy\nHouse Interior "LG_E"(New Interiors!)\nManage Players in House\nSet as Spawn Place\n"RED_E"Cancel House Selling", "Select", "Cancel");
		}
		else ShowPlayerDialog(playerid, HOUSEMENU, DIALOG_STYLE_LIST, INFORMATION_HEADER, "House Selling\nHouse Storage\nHouse Name\nHouse Password\nHouse Privacy\nHouse Interior "LG_E"(New Interiors!)\nManage Players in House\nSet as Spawn Place", "Select", "Cancel");
	}
	
	return 1;
}

CMD:breakin(playerid)
{
	if(doingStunt[playerid] != 0) return Error(playerid, "You cannot do this while in a challenge.");

	new houseid;
	foreach(new h : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ]))
		{
			houseid = h;
			break;
		}
	}
	if(!houseid)
	{
		Error(playerid, "You must be on the house pickup of the house you wish to break in!");
		return true;
	}
	if(GetPVarInt(playerid, "breakIN") == 4)
	{
		SendClientMessage(playerid, COLOR_RED, "Server: "YELLOW_E"You can only attempt breakins 4 times per minute!");
		return true;
	}
	if(GetPVarInt(playerid, "breakIN") == 0) SetTimerEx("ResetBreakin", 60000, false, "i", playerid);
	new counts = GetPVarInt(playerid, "breakIN") + 1;
	SetPVarInt(playerid, "breakIN", counts);
	new h[32];
	mysql_format(g_SQL_handle, query, 256, "SELECT name FROM players WHERE reg_id = %d", hInfo[houseid][HouseOwner]);
	mysql_query(g_SQL_handle, query, true);
	cache_get_field_content(0, "name", h);	
	switch(random(3))
	{
		case 0:
		{
			ShowInfoBox(playerid, I_SUCCESSFULL_BREAKIN2, hInfo[houseid][HouseName], h);
			SetPlayerHouseInterior(playerid, houseid);
		}
		case 1..2:
		{
			ShowInfoBox(playerid, E_FAILED_BREAKIN2, hInfo[houseid][HouseName], h);
		}
	}
	return true;
}
function ResetBreakin(playerid)
{
	if(IsPlayerConnected(playerid)) DeletePVar(playerid, "breakIN");
}
CMD:enter(playerid, params[])
{
	new houseid;
	foreach(new h : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.5, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ]))
		{
			houseid = h;
			break;
		}
	}
	if(!houseid)
	{
		Error(playerid, "You must be near the house you wish to enter!!");
		return true;
	}
	if(sscanf(params, "s[40]", tmp))
	{
		SendClientMessage(playerid, COLOR_RCONBLUE, "USAGE: /enter <house password>");
		return true;
	}
	if(strfind(tmp, "%", CASE_SENSETIVE) != -1 || strfind(tmp, "~", CASE_SENSETIVE) != -1) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HPASS_CHARS2);
	if(strlen(tmp) < MIN_HOUSE_PASSWORD || strlen(tmp) > MAX_HOUSE_PASSWORD) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HPASS_LENGTH);
	new h[32];
	mysql_format(g_SQL_handle, query, 256, "SELECT name FROM players WHERE reg_id = %d", hInfo[houseid][HouseOwner]);
	mysql_query(g_SQL_handle, query, true);
	cache_get_field_content(0, "name", h);	
	if(strcmp(hInfo[houseid][HousePassword], tmp, false) != 0)
	{
		ShowInfoBox(playerid, I_WRONG_HPASS1, h, tmp);
	}
	else
	{
		ShowInfoBox(playerid, I_CORRECT_HPASS1, h, tmp);
		SetPlayerHouseInterior(playerid, houseid);
	}
	return 1;
}

CMD:exitinterior(playerid, params[]) {
	if(!GetPVarInt(playerid, "HousePrevTimer"))
		return Error(playerid, "You need to preview an interior first to use this command.");
		
	KillTimer(GetPVarInt(playerid, "HousePrevTimer"));
	DeletePVar(playerid, "HousePrevTimer");
	DeletePVar(playerid, "HousePreview");
	
	new h = GetPVarInt(playerid, "LastHouseCP");
	hInfo[h][HouseInterior] = GetPVarInt(playerid, "OldHouseInt");
	SetPlayerHouseInterior(playerid, h);
	return 1;
}

/*CMD:robhouse(playerid)
{
	new h = GetPVarInt(playerid, "LastHouseCP"), houseowner = GetHouseOwnerEx(GetPVarInt(playerid, "LastHouseCP")), robtime = GetPVarInt(playerid, "TimeSinceHouseBreakin");
	if(IsInHouse{playerid} == 0) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_NOT_IN_HOUSE);
	if(!strcmp(hInfo[h][HouseOwner], pNick(playerid), CASE_SENSETIVE)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CANT_ROB_OWN_HOUSE);
	if(!IsPlayerConnected(houseowner)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_HROB_OWNER_NOT_CONNECTED);
	if(GetPVarInt(playerid, "IsRobbingHouse") == 1) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_ALREADY_ROBBING_HOUSE);
	if(GetSecondsBetweenAction(robtime) < (TIME_BETWEEN_ROBBERIES * 60000) && robtime != 0) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_WAIT_BEFORE_ROBBING);
	switch(random(10000))
	{
		case 0..6999: // Failed robbery
		{
			switch(hInfo[h][HouseCamera])
			{
				case 0:
				{
					if(hInfo[h][HouseAlarm] == 1)
					{
						ShowInfoBox(houseowner, E_FAILED_HROB1_2, hInfo[h][HouseName], hInfo[h][HouseLocation]);
					}
				}
				case 1: ShowInfoBox(houseowner, E_FAILED_HROB1_1, pNick(playerid), playerid, hInfo[h][HouseName], hInfo[h][HouseLocation]);
			}
			SecurityDog_Bite(playerid, h, 1, 1);
			ShowInfoBox(playerid, E_FAILED_HROB2, hInfo[h][HouseName], hInfo[h][HouseOwner]);
		}
		case 7000..9999: // Successfull robbery
		{
			switch(hInfo[h][HouseCamera])
			{
				case 0:
				{
					if(hInfo[h][HouseAlarm] == 1)
					{
						ShowInfoBox(houseowner, I_HROB_STARTED1_1, hInfo[h][HouseName], hInfo[h][HouseLocation]);
					}
				}
				case 1: ShowInfoBox(houseowner, I_HROB_STARTED1_2, pNick(playerid), playerid, hInfo[h][HouseName], hInfo[h][HouseLocation]);
			}
			ShowInfoBox(playerid, I_HROB_STARTED2, hInfo[h][HouseOwner], hInfo[h][HouseName], hInfo[h][HouseLocation]);
			SetPVarInt(playerid, "IsRobbingHouse", 1), SetPVarInt(playerid, "HouseRobberyTime", RandomEx(MIN_ROB_TIME, MAX_ROB_TIME));
			SetPVarInt(playerid, "HouseRobberyTimer", SetTimerEx("HouseRobbery", 999, true, "ii", playerid, h));
		}
	}
	#if GH_GIVE_WANTEDLEVEL == true
	if((GetPlayerWantedLevel(playerid) + HROBBERY_WL) > GH_MAX_WANTED_LEVEL)
	{
		SetPlayerWantedLevel(playerid, GH_MAX_WANTED_LEVEL);
	}
	else SetPlayerWantedLevel(playerid, (GetPlayerWantedLevel(playerid) + HROBBERY_WL));
	#endif
	SetPVarInt(playerid, "TimeSinceHouseRobbery", GetTickCount());
	return 1;
}*/

CMD:house(playerid) return cmd_myhouses(playerid);
CMD:myhouse(playerid) return cmd_myhouses(playerid);
CMD:myhouses(playerid)
{
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't use this command while in a DM!");
		return true;
	}
	if(doingStunt[playerid] != 0)
	{
		Error(playerid, "You can't use this command in this area!");
		return true;
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) 
    {
        Error(playerid, "You can't use this command while in spectating mode.");
        return true;
	}
 
	if(GetOwnedHouses(playerid) == 0) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_NO_HOUSES_OWNED);
	new h, _tmpstring[128], count = GetOwnedHouses(playerid);
	CMDSString = "";
	Loop(itt, (count + 1), 1)
	{
		h = ReturnPlayerHouseID(playerid, itt);
		if(itt == count)
		{
			format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s in %s", itt, hInfo[h][HouseName], hInfo[h][HouseLocation]);
		}
		else format(_tmpstring, sizeof(_tmpstring), ""LB_E"%d.\t{FFFF2A}%s in %s\n", itt, hInfo[h][HouseName], hInfo[h][HouseLocation]);
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, HOUSEMENU+50, DIALOG_STYLE_LIST, INFORMATION_HEADER, CMDSString, "Select", "Cancel");
	return 1;
}

CMD:createhouse(playerid, params[])
{
	if(pAdmin[playerid] < 4)
		return Error(playerid, "You are not authorized to use this command!");
	if(GetPlayerInterior(playerid) != 0)
		return Error(playerid, "You can't create houses on any interior other than 0.");
	new cost, hint;
	new Float:X, Float:Y, Float:Z;
	if(sscanf(params, "iD(0)", cost, hint)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_CREATEHOUSE);
	if(Iter_Count(Houses) > MAX_HOUSES) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, ""WHITE_E"Max limit of houses reached!");
	if(hint < 0 || hint > MAX_HOUSE_INTERIORS) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HINT);
	if(cost < MIN_HOUSE_VALUE || cost > MAX_HOUSE_VALUE) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HVALUE);
	else
	{
		// Set a random interior if not specified.
		if(hint == 0)
		{
			hint = random(10);
		}
		GetPlayerPos(playerid, Xp, Yp, Zp);
		GetPlayerFacingAngle(playerid, Angle);
		
		new interior = GetPlayerInterior(playerid);
		GetPlayerPos(playerid, X, Y, Z);
		GetPosInFrontOfPlayer(playerid, X, Y, -2.5);

		mysql_format(g_SQL_handle, query, sizeof(query), "INSERT INTO houses(hname,howner,hpass,x,y,z,a,cpx,cpy,cpz,hint,hvalue) VALUES('House For Sale!','0','INVALID_HOUSE_PASSWORD', %0.2f, %0.2f, %0.2f, %0.2f, %0.2f, %0.2f, %0.2f, %d, %d)", X, Y, Zp, (180.0 + Angle), Xp, Yp, Zp, interior, cost);
		MySQL_query(query, false, "OnHouseCreate", "ifffffffii", playerid, Xp, Yp, Zp, (180.0 + Angle), X, Y, Zp, hint, cost);
	}
	return 1;
}

forward OnHouseCreate(playerid, Float:inX, Float:inY, Float:inZ, Float:outA, Float:outX, Float:outY, Float:outZ, interiorID, cost);
public OnHouseCreate(playerid, Float:inX, Float:inY, Float:inZ, Float:outA, Float:outX, Float:outY, Float:outZ, interiorID, cost)
{
	new h = Iter_Free(Houses);
	if(h == -1) return Error(playerid, "An error has occurred while trying to create the house.");

	new labeltext[300];

	hInfo[h][HouseID] = cache_insert_id();
	printf("A_I value of the newly entered house: %d", h);
	hInfo[h][CPOutX] = inX, hInfo[h][CPOutY] = inY, hInfo[h][CPOutZ] = inZ;
	hInfo[h][SpawnOutX] = outX, hInfo[h][SpawnOutY] = outY, hInfo[h][SpawnOutZ] = outZ, hInfo[h][SpawnOutAngle] = outA;
	hInfo[h][HouseInterior] = interiorID;
	hInfo[h][HouseOwner] = 0;
	format(hInfo[h][HousePassword], 28, "%s", "INVALID_HOUSE_PASSWORD");
	format(hInfo[h][HouseName], 28, "%s", DEFAULT_HOUSE_NAME);
	format(hInfo[h][HouseLocation], 30, "%s", GetHouseLocation(h));
	hInfo[h][HouseValue] = cost, hInfo[h][HouseStorage] = 0, hInfo[h][HouseForSale] = 0;

	format(labeltext, sizeof(labeltext), LABELTEXT1, DEFAULT_HOUSE_NAME, ToCurrency(cost), h);
	HouseMIcon[h] = CreateDynamicMapIcon(inX, inY, inZ, 31, -1, -1, -1, -1, MICON_VD);
	HouseLabel[h] = CreateDynamic3DTextLabel(labeltext, COLOR_GREEN, inX, inY, inZ+0.7, TEXTLABEL_DISTANCE, .testlos = 1);
	HousePickupOut[h] = CreateDynamicPickup(PICKUP_MODEL_OUT, PICKUP_TYPE, inX, inY, inZ, -1, -1, -1, 30.0);
	HousePickupInt[h] = CreateDynamicPickup(PICKUP_MODEL_INT, PICKUP_TYPE, hIntInfo[interiorID][IntCPX], hIntInfo[interiorID][IntCPY], hIntInfo[interiorID][IntCPZ], (h + 1000), hIntInfo[interiorID][IntInterior], -1, 15.0);

	ShowInfoBox(playerid, I_H_CREATED, h);
	format(str, sizeof(str), "Server: "GREY2_E"House ID "GREY_E"[%d] "GREY2_E"created!", h);
	SendClientMessage(playerid, COLOR_RED, str);
	
	Iter_Add(Houses, h);
	mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE houses SET hlocation='%e',hint=%d WHERE house_id=%d", hInfo[h][HouseLocation], interiorID, hInfo[h][HouseID]);
	MySQL_updateQuery(query);
	return 1;
}

CMD:removehouse(playerid, params[])
{
	new h;
	if(pAdmin[playerid] < 4) return Error(playerid, "You are not authorized to use this command!");
	if(sscanf(params, "d", h)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_REMOVEHOUSE);
	foreach(new i : Player)
	{
		if(IsPlayerInHouse(i, h))
		{
			ExitHouse(i, h);
		}
	}
	DestroyHouseEntrance(h, TYPE_OUT);
	DestroyHouseEntrance(h, TYPE_INT);
	DestroyDynamicMapIcon(HouseMIcon[h]);
	DestroyDynamic3DTextLabel(HouseLabel[h]);
	ShowInfoBox(playerid, I_H_DESTROYED, h);
	format(query, sizeof(query), "DELETE FROM `houses` WHERE house_id=%d", hInfo[h][HouseID]);
	MySQL_updateQuery(query);
	Iter_Remove(Houses, h);
	return 1;
}

/*CMD:createhint(playerid, params[])
{
	new filename[HOUSEFILE_LENGTH], h = GetFreeInteriorID(), value, name[31], interior = GetPlayerInterior(playerid);
	if(!IsPlayerAdmin(playerid)) return 0;
	if(sscanf(params, "ds[30]", value, name)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_CREATEHINT);
	if(h < 0)
	{
		ShowInfoBox(playerid, E_TOO_MANY_HINTS, MAX_HOUSE_INTERIORS);
		return 1;
	}
	if(value < MIN_HINT_VALUE || value > MAX_HINT_VALUE) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HINT_VALUE);
	if(name[30]) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HINT_LENGTH);
	else
	{
		format(filename, sizeof(filename), HINT_FILEPATH, h);
		fcreate(filename);
		GetPlayerPos(playerid, Xp, Yp, Zp);
		GetPlayerFacingAngle(playerid, Angle);
		hIntInfo[h][IntCPX] = Xp, hIntInfo[h][IntCPY] = Yp, hIntInfo[h][IntCPZ] = Zp;
		hIntInfo[h][IntInterior] = interior, hIntInfo[h][IntSpawnAngle] = (Angle + 180.0), format(hIntInfo[h][IntName], 30, "%s", name), hIntInfo[h][IntValue] = value;
		new INI:file = INI_Open(filename);
		INI_WriteFloat(file, "CPX", Xp);
		INI_WriteFloat(file, "CPY", Yp);
		INI_WriteFloat(file, "CPZ", Zp);
		INI_WriteString(file, "Name", name);
		INI_WriteInt(file, "Value", value);
		GetPosInFrontOfPlayer(playerid, Xp, Yp, -2.5);
		INI_WriteFloat(file, "SpawnX", Xp);
		INI_WriteFloat(file, "SpawnY", Yp);
		INI_WriteFloat(file, "SpawnZ", Zp);
		INI_WriteFloat(file, "Angle", hIntInfo[h][IntSpawnAngle]);
		INI_WriteInt(file, "Interior", interior);
		INI_Close(file);
		hIntInfo[h][IntSpawnX] = Xp, hIntInfo[h][IntSpawnY] = Yp, hIntInfo[h][IntSpawnZ] = Zp;
		ShowInfoBox(playerid, I_HINT_CREATED, h, value, name);
	}
	return 1;
}*/

CMD:gh(playerid, params[]) return cmd_gohouse(playerid, params);
CMD:gotohouse(playerid, params[]) return cmd_gohouse(playerid, params);
CMD:gohouse(playerid, params[])
{
	if(!CanPlayerTeleport(playerid)) return true;
	
	if(InDM[playerid] != 0)
	{
		Error(playerid, "You can't teleport to houses while in a DM!");
		return true;
	}
	if(doingStunt[playerid] != 0)
	{
		Error(playerid, "You can't teleport to houses in this area!");
		return true;
	}
	
	if(InEvent[playerid] != 0) return Error(playerid, "You can't teleport to houses in an event!");
	
	new h;
	
	if(sscanf(params, "d", h)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_GOTOHOUSE);
	
	if(h > MAX_HOUSES) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HID);
	
	if(!Iter_Contains(Houses, h)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HID);

	if(hInfo[h][HouseID] == 202 || hInfo[h][HouseID] == 41 || hInfo[h][HouseID] == 301 || hInfo[h][HouseID] == 302 || hInfo[h][HouseID] == 303 || hInfo[h][HouseID] == 304)
	{
	   if(pPremium[playerid] < 2) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_VIPHOUSE);
	}
	
	SetPlayerPosition(playerid, hInfo[h][SpawnOutX], hInfo[h][SpawnOutY], hInfo[h][SpawnOutZ], hInfo[h][SpawnOutAngle]+180);
	ShowInfoBox(playerid, I_TELEPORT_MSG, h);
	return 1;
}

//can be deleted if the fix works
/*CMD:sellhouse(playerid, params[])
{
	if(pAdmin[playerid] < 4)
		return Error(playerid, "You are not authorized to use this command!");

	new h;
	if(sscanf(params, "d", h)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_SELLHOUSE);
	if(!strcmp(hInfo[h][HouseOwner], INVALID_HOWNER_NAME, CASE_SENSETIVE)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_H_A_F_SALE);
	else
	{
		//h = GetHouseIndexFromID(h);
		ShowInfoBox(playerid, I_H_SOLD, h+1);
		
		format(hInfo[h][HouseOwner], MAX_PLAYER_NAME, "%s", INVALID_HOWNER_NAME);
		format(hInfo[h][HousePassword], 30, "%s", "INVALID_HOUSE_PASSWORD");
		format(hInfo[h][HouseName], MAX_HOUSE_NAME, "%s", DEFAULT_HOUSE_NAME);
		hInfo[h][HouseStorage] = 0;
		hInfo[h][HousePrivacy] = 0;
		hInfo[h][HouseForSale] = 0;
		format(query, sizeof(query), "UPDATE houses SET hname='House For Sale!',howner='INVALID_PLAYER_ID',hpass='INVALID_HOUSE_PASSWORD',hstorage=0,hprivacy=0,last_visited=0,hforsale=0 WHERE house_id=%d", hInfo[h][HouseID]);
		MySQL_updateQuery(query);

		foreach(new i : Player)
		{
			if(IsPlayerInHouse(i, h))
			{
				ExitHouse(i, h);
				ShowInfoBoxEx(i, COLOR_INFO, I_TO_PLAYERS_HSOLD);
			}
		}
		DestroyDynamicMapIcon(HouseMIcon[h]);
		HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 31, -1, 0, 0, -1, MICON_VD);
		UpdateHouseText(h);
	}
	return 1;
}*/

//start of attempted bug fix, debug_mode ON
CMD:selloldhouses(playerid)
{
    if(pAdmin[playerid] != 5) return Error(playerid, "You are not authorized to use this command!");
 
    MySQL_query("SELECT last_visited FROM houses ORDER BY house_id", true, "SellOldHouses", "i", playerid);
    print("called /selloldhouses");
    return 1;
}
 
CMD:sellhouse(playerid, params[])
{
    if(pAdmin[playerid] < 3) return Error(playerid, "You are not authorized to use this command!");
 
    new h;
    if(sscanf(params, "d", h)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_SELLHOUSE);
   
    if(hInfo[h][HouseOwner] == 0) 
    	return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_H_A_F_SALE);
   
    //h = GetHouseIndexFromID(h);
    ShowInfoBox(playerid, I_H_SOLD, h);
 
    SellHouse(playerid, h);
    print("called /sellhouse");
    return 1;
}
 
function SellOldHouses(playerid)
{
	new housesSold, rows = MySQL_rowCount();

	print("Debug 1/5: Function called!");
	iTemp = gettime() - 86400 * 31;
	if(rows)
	{
		print("Debug 2/5: Rows found!");
		for(new h; h < rows; h++)
		{
			printf("Debug 3/5: Calling row ID %d...", h);
			new lastvisit_date = cache_get_row_int(h, 0);
			if(iTemp > lastvisit_date && lastvisit_date != 0)
			{
				printf("Debug 4/5: House %d being deleted", h);
				format(hInfo[h][HousePassword], 30, "%s", "INVALID_HOUSE_PASSWORD");
				format(hInfo[h][HouseName], MAX_HOUSE_NAME, "%s", DEFAULT_HOUSE_NAME);
				hInfo[h][HouseStorage] = 0;
				hInfo[h][HousePrivacy] = 0;
				hInfo[h][HouseForSale] = 0;
 				hInfo[h][HouseOwner] = 0;
 				print("Debug 4.33/5: Continued");
				format(query, sizeof(query), "UPDATE houses SET hname='House For Sale!',howner = 0 ,hpass='INVALID_HOUSE_PASSWORD',hstorage=0,hforsale=0,hprivacy=0,last_visited=0 WHERE house_id=%d", hInfo[h][HouseID]);
				MySQL_updateQuery(query);
 				
 				print("Debug 4.66/5: Continued");
				foreach(new i : Player)
				{
					if(IsPlayerInHouse(i, h))
					{
						ExitHouse(i, h);
						ShowInfoBoxEx(i, COLOR_INFO, I_TO_PLAYERS_HSOLD);
					}
				}
				DestroyDynamicMapIcon(HouseMIcon[h]);
				HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 31, -1, 0, 0, -1, MICON_VD);
				UpdateHouseText(h);
				housesSold++;
				print("Debug 4.99/5: Finished");
			}
		}
	}
	printf("Debug 5/5: Total houses %d", housesSold);
	if(pHidden[playerid] == 0)
		format(str, sizeof(str), ""YELLOW_E"- AS - "WHITEP_E"Administrator %s(%i) has sold all houses not visited for 30 days.", pName[playerid], playerid);
	else
		format(str, sizeof(str), ""YELLOW_E"- AS - "WHITEP_E"All houses not visited for 30 days have been sold by an Administrator.");
	SendClientMessageToAll(COLOR_WHITEP, str);
	format(str, sizeof(str), ""YELLOW_E"- AS - "WHITEP_E"A total of %d houses have been sold!", housesSold);
	SendClientMessageToAll(COLOR_WHITEP, str);
 
	format(tmp, sizeof(tmp), "4Server: 2Administrator %s(%i) has sold all houses not visited for 30 days.", pName[playerid], playerid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, tmp), IRC_GroupSay(ircGroup, IRC_aCHANNEL, tmp);
	return 1;
}

function SellHouse(playerid, h)
{  
 
    format(hInfo[h][HousePassword], 30, "%s", "INVALID_HOUSE_PASSWORD");
    format(hInfo[h][HouseName], MAX_HOUSE_NAME, "%s", DEFAULT_HOUSE_NAME);
    hInfo[h][HouseStorage] = 0;
    hInfo[h][HousePrivacy] = 0;
    hInfo[h][HouseForSale] = 0;
    hInfo[h][HouseOwner] = 0;
    format(query, sizeof(query), "UPDATE houses SET hname='House For Sale!',howner=0,hpass='INVALID_HOUSE_PASSWORD',hstorage=0,hprivacy=0,last_visited=0,hforsale=0 WHERE house_id=%d", hInfo[h][HouseID]);
    MySQL_updateQuery(query);
   
    foreach(new i : Player)
    {
        if(IsPlayerInHouse(i, h))
        {
            ExitHouse(i, h);
            ShowInfoBoxEx(i, COLOR_INFO, I_TO_PLAYERS_HSOLD);
        }
    }
    DestroyDynamicMapIcon(HouseMIcon[h]);
    HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 31, -1, 0, 0, -1, MICON_VD);
    UpdateHouseText(h);

    //update player spawn
    format(query, sizeof(query), "UPDATE players SET spawnplace=-1 WHERE reg_id=%d", pRegID[playerid]);
    MySQL_updateQuery(query);
    return 1;
}
//end of attempted bug fix


//can be deleted if the fix works
/*CMD:selloldhouses(playerid, params[])
{
	if(pAdmin[playerid] != 5)
		return Error(playerid, "You are not authorized to use this command!");

	MySQL_query("SELECT last_visited FROM houses ORDER BY house_id", true, "SellOldHouses", "i", playerid);
	return 1;
 }

function SellOldHouses(playerid)
{
	new housesSold;
	iTemp = gettime() - 86400 * 31;
	new rows = MySQL_rowCount();
	if(rows)
	{
		for(new h; h < rows; h++)
		{
			new lastvisit_date = cache_get_row_int(h, 0);
			if(iTemp > lastvisit_date && lastvisit_date != 0)
			{
				format(hInfo[h][HouseOwner], MAX_PLAYER_NAME, "%s", INVALID_HOWNER_NAME);
				format(hInfo[h][HousePassword], 30, "%s", "INVALID_HOUSE_PASSWORD");
				format(hInfo[h][HouseName], MAX_HOUSE_NAME, "%s", DEFAULT_HOUSE_NAME);
				hInfo[h][HouseStorage] = 0;
				hInfo[h][HousePrivacy] = 0;
				hInfo[h][HouseForSale] = 0;

				format(query, sizeof(query), "UPDATE houses SET hname='House For Sale!',howner='INVALID_PLAYER_ID',hpass='INVALID_HOUSE_PASSWORD',hstorage=0,hforsale=0,hprivacy=0,last_visited=0 WHERE house_id=%d", hInfo[h][HouseID]);
				MySQL_updateQuery(query);

				foreach(new i : Player)
				{
					if(IsPlayerInHouse(i, h))
					{
						ExitHouse(i, h);
						ShowInfoBoxEx(i, COLOR_INFO, I_TO_PLAYERS_HSOLD);
					}
				}
				DestroyDynamicMapIcon(HouseMIcon[h]);
				HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 31, -1, 0, 0, -1, MICON_VD);
				UpdateHouseText(h);
				housesSold++;
			}
		}
	}
	if(pHidden[playerid] == 0)
		format(str, sizeof(str), ""YELLOW_E"- AS - "WHITEP_E"Administrator %s(%i) has sold all houses not visited for 30 days.", pName[playerid], playerid);
	else
		format(str, sizeof(str), ""YELLOW_E"- AS - "WHITEP_E"All houses not visited for 30 days have been sold by an Administrator.");
	SendClientMessageToAll(COLOR_WHITEP, str);
	format(str, sizeof(str), ""YELLOW_E"- AS - "WHITEP_E"A total of %d houses have been sold!", housesSold);
	SendClientMessageToAll(COLOR_WHITEP, str);

	format(tmp, sizeof(tmp), "4Server: 2Administrator %s(%i) has sold all houses not visited for 30 days.", pName[playerid], playerid);
	IRC_GroupSay(ircGroup, IRC_CHANNEL, tmp), IRC_GroupSay(ircGroup, IRC_aCHANNEL, tmp);
	return 1;
}*/

CMD:changeprice(playerid, params[])
{
	if(pAdmin[playerid] < 4)
		return Error(playerid, "You are not authorized to use this command!");

	new h, price;
	if(sscanf(params, "dd", h, price)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_CHANGEPRICE);
	if(price < MIN_HOUSE_VALUE || price > MAX_HOUSE_VALUE) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_INVALID_HVALUE);
	//h = GetHouseIndexFromID(h);
	hInfo[h][HouseValue] = price;

	format(query, sizeof(query), "UPDATE houses SET hvalue=%d WHERE house_id=%d", price, hInfo[h][HouseID]);
	MySQL_updateQuery(query);
	
	ShowInfoBox(playerid, I_H_PRICE_CHANGED, h, price);
	UpdateHouseText(h);
	return 1;
}

CMD:changehname(playerid, params[])
{
	if(pAdmin[playerid] < 4)
		return Error(playerid, "You are not authorized to use this command!");
	new h;
	if(sscanf(params, "ds[30]", h, tmp)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, "Usage:{F6F6F6} /changehname (houseid) (new name)");
	//h = GetHouseIndexFromID(h);
	
	format(hInfo[h][HouseName], MAX_HOUSE_NAME, "%s", tmp);

	mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE houses SET hname='%e' WHERE house_id=%d", tmp, hInfo[h][HouseID]);
	MySQL_updateQuery(query);

	ShowInfoBox(playerid, "{F6F6F6}The name for house ID "LB_E"%d {F6F6F6}has been changed to "LB_E"%s{F6F6F6}.", h, tmp);
	UpdateHouseText(h);
	return 1;
}
CMD:changeowner(playerid, params[])
{
	if(pAdmin[playerid] < 4)
		return Error(playerid, "You are not authorized to use this command!");
	new h, pid;
	if(sscanf(params, "dd", h, pid)) 
		return ShowInfoBoxEx(playerid, COLOR_SYSTEM, "Usage:{F6F6F6} /changeowner (houseid) (new owner id).");
	//h = GetHouseIndexFromID(h);
	if(!IsPlayerConnected(pid))
		return ShowInfoBoxEx(playerid, COLOR_SYSTEM, "Error:player not found.");

	hInfo[h][HouseOwner] = pRegID[pid];
	mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE houses SET howner=%d WHERE house_id=%d", tmp, hInfo[h][HouseID]);
	MySQL_updateQuery(query);

	ShowInfoBox(playerid, "{F6F6F6}The owner for house ID "LB_E"%d {F6F6F6}has been changed to "LB_E"%p{F6F6F6}.", h, tmp);
	UpdateHouseText(h);
	return 1;
}

CMD:movehouse(playerid, params[])
{
	if(pAdmin[playerid] < 4)
		return Error(playerid, "You are not authorized to use this command!");

	new h;
	if(sscanf(params, "d", h)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_MOVEHOUSE);
	//h = GetHouseIndexFromID(h);
	
	new Float:cpX, Float:cpY, Float:cpZ;
	new Float:outX, Float:outY, Float:outZ, Float:outA;
	new labeltext[300];


	GetPlayerPos(playerid, cpX, cpY, cpZ);
	GetPlayerFacingAngle(playerid, Angle);

	GetPlayerPos(playerid, outX, outY, outZ);
	GetPosInFrontOfPlayer(playerid, outX, outY, -2.5);
	outA = (180.0 + Angle);

	DestroyHouseEntrance(h, TYPE_OUT);
	DestroyDynamicMapIcon(HouseMIcon[h]);
	DestroyDynamic3DTextLabel(HouseLabel[h]);
	format(hInfo[h][HouseLocation], 30, "%s", GetHouseLocation(h));
	hInfo[h][CPOutX] = cpX, hInfo[h][CPOutY] = cpY, hInfo[h][CPOutZ] = cpZ;
	hInfo[h][SpawnOutX] = outX, hInfo[h][SpawnOutY] = outY, hInfo[h][SpawnOutZ] = outZ, hInfo[h][SpawnOutAngle] = outA;
	new s[32];
	mysql_format(g_SQL_handle, query, 256, "SELECT name FROM players WHERE reg_id = %d", hInfo[h][HouseOwner]);
	mysql_query(g_SQL_handle, query, true);
	cache_get_field_content(0, "name", s);	
	if(hInfo[h][HouseOwner] == 0)
	{
		format(labeltext, sizeof(labeltext), LABELTEXT1, hInfo[h][HouseName], ToCurrency(hInfo[h][HouseValue]), hInfo[h][HouseID]);
		HouseMIcon[h] = CreateDynamicMapIcon(cpX, cpY, cpZ, 31, -1, -1, -1, -1, MICON_VD);
	}
	else
	{
		format(labeltext, sizeof(labeltext), LABELTEXT2, hInfo[h][HouseName], s, ToCurrency(hInfo[h][HouseValue]), Answer(hInfo[h][HousePrivacy], "Open", "Closed"), hInfo[h][HouseID]);
		HouseMIcon[h] = CreateDynamicMapIcon(cpX, cpY, cpZ, 32, -1, -1, -1, -1, MICON_VD);
	}
	
	HouseLabel[h] = CreateDynamic3DTextLabel(labeltext, COLOR_GREEN, cpX, cpY, cpZ+0.7, TEXTLABEL_DISTANCE, .testlos = 1);
	HousePickupOut[h] = CreateDynamicPickup(PICKUP_MODEL_OUT, PICKUP_TYPE, cpX, cpY, cpZ, -1, -1, -1, 30.0);

	mysql_format(g_SQL_handle, query, sizeof(query), "UPDATE houses SET x=%f,y=%f,z=%f,a=%f,cpx=%f,cpy=%f,cpz=%f,hlocation='%e' WHERE house_id=%d", outX, outY, cpZ, outA, cpX, cpY, cpZ, hInfo[h][HouseLocation], hInfo[h][HouseID]);
	MySQL_updateQuery(query);
	
	ShowInfoBox(playerid, I_H_MOVED, h);
	return 1;
}
CMD:reloadhouse(playerid, params[])
{
	if(pAdmin[playerid] < 4)
		return Error(playerid, "You are not authorized to use this command!");

	new h;
	new labeltext[300];
	if(sscanf(params, "d", h)) return ShowInfoBoxEx(playerid, COLOR_SYSTEM, E_CMD_USAGE_RELOADHOUSE);


	//h = GetHouseIndexFromID(h);
	DestroyHouseEntrance(h, TYPE_OUT);
	DestroyDynamicMapIcon(HouseMIcon[h]);
	DestroyDynamic3DTextLabel(HouseLabel[h]);
	new s[32];
	mysql_format(g_SQL_handle, query, 256, "SELECT name FROM players WHERE reg_id = %d", hInfo[h][HouseOwner]);
	mysql_query(g_SQL_handle, query, true);
	cache_get_field_content(0, "name", s);	
	if(hInfo[h][HouseOwner] == 0)
	{
		format(labeltext, sizeof(labeltext), LABELTEXT1, hInfo[h][HouseName], ToCurrency(hInfo[h][HouseValue]), hInfo[h][HouseID]);
		HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 31, -1, -1, -1, -1, MICON_VD);
	}
	else
	{
		format(labeltext, sizeof(labeltext), LABELTEXT2, hInfo[h][HouseName], s, ToCurrency(hInfo[h][HouseValue]), Answer(hInfo[h][HousePrivacy], "Open", "Closed"), hInfo[h][HouseID]);
		HouseMIcon[h] = CreateDynamicMapIcon(hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], 32, -1, -1, -1, -1, MICON_VD);
	}

	HouseLabel[h] = CreateDynamic3DTextLabel(labeltext, COLOR_GREEN, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ]+0.7, TEXTLABEL_DISTANCE, .testlos = 1);
	HousePickupOut[h] = CreateDynamicPickup(PICKUP_MODEL_OUT, PICKUP_TYPE, hInfo[h][CPOutX], hInfo[h][CPOutY], hInfo[h][CPOutZ], -1, -1, -1, 30.0);
	ShowInfoBox(playerid, I_H_RELOADED, h);
	return 1;
}

enum SAZONE_MAIN { SAZONE_NAME[28], Float:SAZONE_AREA[6] }; // By BetaMaster
static const gSAZones[][SAZONE_MAIN] =
{
	{"24/7",	                	{-34.23,-186.02,1003.54,-4.24,-169.91,1003.54}},
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Bar",               	        {487.65,-88.76,998.75,512.06,-67.74,999.25}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield Intersection",     {1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield Intersection",     {1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield Intersection",     {1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield Intersection",     {1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligulas Casino",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligulas Casino",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City Hall",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Come-A-Lot",                  {2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Downtown San Fierro",         {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Downtown San Fierro",         {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown San Fierro",         {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown San Fierro",         {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown San Fierro",         {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown San Fierro",         {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown San Fierro",         {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown San Fierro",         {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fishers Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint Intersection",          {-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Glen Park",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Glen Park",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Glen Park",                   {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"Kings",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"Kings",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"Kings",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Las Colinas",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Las Colinas",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Las Colinas",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Las Colinas",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Las Colinas",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Las Colinas",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Las Colinas",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"Los Santos International",    {1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Los Santos International",    {1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Los Santos International",    {1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Los Santos International",    {1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Los Santos International",    {1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Los Santos International",    {2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery Intersection",     {1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery Intersection",     {1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Mulholland",                  {687.80,-860.60,-89.00,911.80,-768.00,110.90}},
	{"Mulholland",                  {737.50,-768.00,-89.00,1142.20,-674.80,110.90}},
	{"Mulholland",                  {1096.40,-910.10,-89.00,1169.10,-768.00,110.90}},
	{"Mulholland",                  {952.60,-937.10,-89.00,1096.40,-860.60,110.90}},
	{"Mulholland",                  {911.80,-860.60,-89.00,1096.40,-768.00,110.90}},
	{"Mulholland",                  {861.00,-674.80,-89.00,1156.50,-600.80,110.90}},
	{"Mulholland Intersection",     {1463.90,-1150.80,-89.00,1812.60,-768.00,110.90}},
	{"North Rock",                  {2285.30,-768.00,0.00,2770.50,-269.70,200.00}},
	{"Ocean Docks",                 {2373.70,-2697.00,-89.00,2809.20,-2330.40,110.90}},
	{"Ocean Docks",                 {2201.80,-2418.30,-89.00,2324.00,-2095.00,110.90}},
	{"Ocean Docks",                 {2324.00,-2302.30,-89.00,2703.50,-2145.10,110.90}},
	{"Ocean Docks",                 {2089.00,-2394.30,-89.00,2201.80,-2235.80,110.90}},
	{"Ocean Docks",                 {2201.80,-2730.80,-89.00,2324.00,-2418.30,110.90}},
	{"Ocean Docks",                 {2703.50,-2302.30,-89.00,2959.30,-2126.90,110.90}},
	{"Ocean Docks",                 {2324.00,-2145.10,-89.00,2703.50,-2059.20,110.90}},
	{"Ocean Flats",                 {-2994.40,277.40,-9.10,-2867.80,458.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-222.50,-0.00,-2593.40,277.40,200.00}},
	{"Ocean Flats",                 {-2994.40,-430.20,-0.00,-2831.80,-222.50,200.00}},
	{"Octane Springs",              {338.60,1228.50,0.00,664.30,1655.00,200.00}},
	{"Old Venturas Strip",          {2162.30,2012.10,-89.00,2685.10,2202.70,110.90}},
	{"Palisades",                   {-2994.40,458.40,-6.10,-2741.00,1339.60,200.00}},
	{"Palomino Creek",              {2160.20,-149.00,0.00,2576.90,228.30,200.00}},
	{"Paradiso",                    {-2741.00,793.40,-6.10,-2533.00,1268.40,200.00}},
	{"Pershing Square",             {1440.90,-1722.20,-89.00,1583.50,-1577.50,110.90}},
	{"Pilgrim",                     {2437.30,1383.20,-89.00,2624.40,1783.20,110.90}},
	{"Pilgrim",                     {2624.40,1383.20,-89.00,2685.10,1783.20,110.90}},
	{"Pilson Intersection",         {1098.30,2243.20,-89.00,1377.30,2507.20,110.90}},
	{"Pirates in Mens Pants",      {1817.30,1469.20,-89.00,2027.40,1703.20,110.90}},
	{"Playa del Seville",           {2703.50,-2126.90,-89.00,2959.30,-1852.80,110.90}},
	{"Prickle Pine",                {1534.50,2583.20,-89.00,1848.40,2863.20,110.90}},
	{"Prickle Pine",                {1117.40,2507.20,-89.00,1534.50,2723.20,110.90}},
	{"Prickle Pine",                {1848.40,2553.40,-89.00,1938.80,2863.20,110.90}},
	{"Prickle Pine",                {1938.80,2624.20,-89.00,2121.40,2861.50,110.90}},
	{"Queens",                      {-2533.00,458.40,0.00,-2329.30,578.30,200.00}},
	{"Queens",                      {-2593.40,54.70,0.00,-2411.20,458.40,200.00}},
	{"Queens",                      {-2411.20,373.50,0.00,-2253.50,458.40,200.00}},
	{"Randolph Industrial Estate",  {1558.00,596.30,-89.00,1823.00,823.20,110.90}},
	{"Redsands East",               {1817.30,2011.80,-89.00,2106.70,2202.70,110.90}},
	{"Redsands East",               {1817.30,2202.70,-89.00,2011.90,2342.80,110.90}},
	{"Redsands East",               {1848.40,2342.80,-89.00,2011.90,2478.40,110.90}},
	{"Redsands West",               {1236.60,1883.10,-89.00,1777.30,2142.80,110.90}},
	{"Redsands West",               {1297.40,2142.80,-89.00,1777.30,2243.20,110.90}},
	{"Redsands West",               {1377.30,2243.20,-89.00,1704.50,2433.20,110.90}},
	{"Redsands West",               {1704.50,2243.20,-89.00,1777.30,2342.80,110.90}},
	{"Regular Tom",                 {-405.70,1712.80,-3.00,-276.70,1892.70,200.00}},
	{"Restraunt",	       			{-229.07,1393.80,28.35,-222.40,1412.19,27.77}},
	{"Restraunt",	       			{-221.54,1401.45,27.77,-217.49,1407.54,28.41}},
	{"Richman",                     {647.50,-1118.20,-89.00,787.40,-954.60,110.90}},
	{"Richman",                     {647.50,-954.60,-89.00,768.60,-860.60,110.90}},
	{"Richman",                     {225.10,-1369.60,-89.00,334.50,-1292.00,110.90}},
	{"Richman",                     {225.10,-1292.00,-89.00,466.20,-1235.00,110.90}},
	{"Richman",                     {72.60,-1404.90,-89.00,225.10,-1235.00,110.90}},
	{"Richman",                     {72.60,-1235.00,-89.00,321.30,-1008.10,110.90}},
	{"Richman",                     {321.30,-1235.00,-89.00,647.50,-1044.00,110.90}},
	{"Richman",                     {321.30,-1044.00,-89.00,647.50,-860.60,110.90}},
	{"Richman",                     {321.30,-860.60,-89.00,687.80,-768.00,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada Intersection",         {-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camels Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clowns Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"The Four Dragons Casino",     {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1130.80,-89.00,952.60,-954.60,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	// Main Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"San Andreas",                	{4601.083, -2989.536, -242.90, 2989.536, -3666.853, 1500.00}},
	{"Mount Chilliad",              {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

stock GetHouseLocation(houseid) 
{
	new zone[MAX_ZONE_NAME];
	format(zone, MAX_ZONE_NAME, "Unknown");
	new size = sizeof(gSAZones);
	Loop(i, size, 0)
	{
		if(hInfo[houseid][CPOutX] >= gSAZones[i][SAZONE_AREA][0] && hInfo[houseid][CPOutX] <= gSAZones[i][SAZONE_AREA][3] && hInfo[houseid][CPOutY] >= gSAZones[i][SAZONE_AREA][1] && hInfo[houseid][CPOutY] <= gSAZones[i][SAZONE_AREA][4])
		{
			format(zone, MAX_ZONE_NAME, "%s", gSAZones[i][SAZONE_NAME]);
			return zone;
		}
	}
	return zone;
}

stock GetHouseIndexFromID(houseid)
{
	for(new h = 0; h < MAX_HOUSES; h++)
	{
		if(hInfo[h][HouseID] == houseid) return h;
	}
	return -1;
}
stock GetPlayerLocation(playerid)
{
	new zone[MAX_ZONE_NAME];
	format(zone, MAX_ZONE_NAME, "Unknown");
	new size = sizeof(gSAZones);
	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	Loop(i, size, 0)
	{
		if(POS[0] >= gSAZones[i][SAZONE_AREA][0] && POS[0] <= gSAZones[i][SAZONE_AREA][3] && POS[1] >= gSAZones[i][SAZONE_AREA][1] && POS[1] <= gSAZones[i][SAZONE_AREA][4])
		{
			format(zone, MAX_ZONE_NAME, "%s", gSAZones[i][SAZONE_NAME]);
			return zone;
		}
	}
	return zone;
}

GetPositionLocation(Float:x, Float:y) {
	new zone[MAX_ZONE_NAME];
	format(zone, MAX_ZONE_NAME, "Unknown");
	new size = sizeof(gSAZones);
	Loop(i, size, 0)
	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
			format(zone, MAX_ZONE_NAME, "%s", gSAZones[i][SAZONE_NAME]);
			return zone;
		}
	}
	return zone;
}