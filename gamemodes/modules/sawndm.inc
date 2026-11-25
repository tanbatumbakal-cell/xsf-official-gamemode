/**
 * @file      sawndm.inc/p
 * @author    blewert <http://github.com/blewert/>
 *
 * @copyright xTreme Stunt Freeroam (c) 2016
 *
*/

#if defined SAWNDM_H
	#endinput
#else
	#define SAWNDM_H
#endif

//Macros
#define SawnDM:: __sdm_

//Constants
const SawnDM::ID            = 24;
const SawnDM::VIRTUAL_WORLD = 0xDEAD + 0xA;
const SawnDM::INTERIOR      = 15;

//The amount of players in the deagle dm.
new SawnDM::playerCount;

//Enum for spawns
#if !defined E_STRUCT_SPAWN
enum E_STRUCT_SPAWN
{
	Float:spawnX,
	Float:spawnY,
	Float:spawnZ,
	Float:spawnA
}
#endif


//Spawnpoints
new SawnDM::spawns[][E_STRUCT_SPAWN] = 
{
	{ -1421.9829,  984.2650, 1024.6899, 283.7489 },
	{ -1421.3293, 1006.9474, 1024.6899, 235.1817 },
	{ -1403.1263, 1012.1840, 1024.6899, 198.1035 },
	{ -1378.4839, 1008.8943, 1024.6899, 128.1250 },
	{ -1374.2024,  982.6783, 1024.6899,  66.6068 },
	{ -1391.2125,  970.1472, 1024.6899,  17.0996 }
};


CMD:sdm(playerid) return cmd_sawndm(playerid);
CMD:sawndm(playerid)
{
	//Check if they can teleport 
	if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] == 13) return Error(playerid, "Leave the CnR minigame before joining a DM! "RED_E"/leave.");
	if(doingStunt[playerid] != 0) return Error(playerid, "Teleport out of this stunt area before joining a DM!");
	if(InDM[playerid] == SawnDM::ID) return Error(playerid, "You already are in this DM!");

	//Decrement player count if coming from another dm
	CheckDM(playerid);
	
	//Save their position so they can tp back
	SavePlayerPosition(playerid);
	
	//Reset their weapons before teleporting.
	ResetPlayerWeapons(playerid);
	
	new randIdx = random(sizeof SawnDM::spawns);
	
	#define s[%0] __sdm_spawns[randIdx][%0]
	SetPlayerPosition(playerid, s[spawnX], s[spawnY], s[spawnZ], s[spawnA]);
	#undef s
	
	Streamer_DestroyAllVisibleItems(playerid, STREAMER_TYPE_OBJECT);
	Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, 0);
	
	//Reset more stuff and show them a message
	IsInHouse{playerid} = 0;
	doingStunt[playerid] = 0;
	GodModeLabel(playerid, false);
	TeleMSGDM(playerid, "Sawnoff DM (/sawndm)");
	
	//Set their interior
	SetPlayerInterior(playerid, SawnDM::INTERIOR);
	
	//Give them only a deagle, set their health and virtual world
	GivePlayerWeapon(playerid, 26, 9999);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerVirtualWorld(playerid, SawnDM::VIRTUAL_WORLD);
	
	//Make sure we know that they're here!
	InDM[playerid] = SawnDM::ID;
	SawnDM::playerCount++;
	
	//And update the footer and minigame box
	UpdateDMText();
	UpdateMinigameBox(playerid, 1, "/sawndm");
	if(GetDMMembers(24) == 1)
	{
	    new stri[128];
	    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	    format(stri, sizeof stri, "{FF0000}[DM Advertisement] {FFFFFF}%s has joined Sawn DM and feels lonely! Join him, /sdm", PlayerName);
	    foreach(new i : Player)
	    {
	        if(dmMessages[i] == 1)
	        {
	            SendClientMessage(i, -1, stri);
			}
		}
	}
	
	return true;
}

