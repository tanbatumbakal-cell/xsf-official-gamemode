/**
 * @file      deagledm.inc/p
 * @author    blewert <http://github.com/blewert/>
 *
 * @copyright xTreme Stunt Freeroam (c) 2016
 *
*/

#if defined DEAGLEDM_H
	#endinput
#else
	#define DEAGLEDM_H
#endif

//Macros
#define DeagleDM:: __ddm_

//Constants
const DeagleDM::ID            = 23;
const DeagleDM::VIRTUAL_WORLD = 0xDEAD;
const DeagleDM::INTERIOR      = 1;

//The amount of players in the deagle dm.
new DeagleDM::playerCount;

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
new DeagleDM::spawns[][E_STRUCT_SPAWN] = 
{
	{ 1410.5527,  -2.6866, 1000.9233, 109.4244 },
	{ 1414.2845, -34.1630, 1000.9252, 43.2059  },
	{ 1402.4855, -45.2225, 1000.9104, 346.2832 },
	{ 1365.8320, -43.2938, 1000.9198, 317.1430 },
	{ 1365.4464,   0.0482, 1000.9219, 229.7222 },
	{ 1383.5692, -19.1010, 1000.9232, 302.7298 },
	{ 1406.5112, -22.1959, 1000.9214, 42.3708  }
};


CMD:ddm(playerid) return cmd_deagledm(playerid);
CMD:deagledm(playerid)
{
	//Check if they can teleport 
	if(!CanPlayerTeleport(playerid)) return true;
	if(InDM[playerid] == 13) return Error(playerid, "Leave the CnR minigame before joining a DM! "RED_E"/leave.");
	if(doingStunt[playerid] != 0) return Error(playerid, "Teleport out of this stunt area before joining a DM!");
	if(InDM[playerid] == DeagleDM::ID) return Error(playerid, "You already are in this DM!");

	//Decrement player count if coming from another dm
	CheckDM(playerid);
	
	//Save their position so they can tp back
	SavePlayerPosition(playerid);
	
	//Reset their weapons before teleporting.
	ResetPlayerWeapons(playerid);
	
	new randIdx = random(sizeof DeagleDM::spawns);
	
	#define s[%0] __ddm_spawns[randIdx][%0]
	SetPlayerPosition(playerid, s[spawnX], s[spawnY], s[spawnZ], s[spawnA]);
	#undef s
	
	//Reset more stuff and show them a message
	IsInHouse{playerid} = 0;
	doingStunt[playerid] = 0;
	GodModeLabel(playerid, false);
	TeleMSGDM(playerid, "Deagle DM (/deagledm)");
	
	//Set their interior
	SetPlayerInterior(playerid, DeagleDM::INTERIOR);
	
	//Give them only a deagle, set their health and virtual world
	GivePlayerWeapon(playerid, 24, 9999);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerVirtualWorld(playerid, DeagleDM::VIRTUAL_WORLD);
	
	//Make sure we know that they're here!
	InDM[playerid] = DeagleDM::ID;
	DeagleDM::playerCount++;
	
	//And update the footer and minigame box
	UpdateDMText();
	UpdateMinigameBox(playerid, 1, "/deagledm");
	if(GetDMMembers(23) == 1)
	{
	    new stri[128];
	    GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	    format(stri, sizeof stri, "{FF0000}[DM Advertisement] {FFFFFF}%s has joined Deagle DM and feels lonely! Join him, /ddm", PlayerName);
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

