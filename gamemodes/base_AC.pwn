 /*
		Server - xTreme Stunt Freeroam (c) 2017
		Anti Cheat
		Author: Xeon
*/

#include <Pawn.RakNet>
#include <triggerbot>

new 
	AutoCbug[MAX_PLAYERS]
;

const AIM_SYNC = 203;
const PLAYER_SYNC = 207;
const BULLET_SYNC = 206;
const PASSENGER_SYNC = 211;

// Anti Invalid-Camera crasher
IPacket:AIM_SYNC(playerid, BitStream:bs)
{
	if(!IsPlayerAdmin(playerid) && pAdmin[playerid] == 0 && IsPlayerConnected(playerid) && GetPVarInt(otherid, "BadSports") != 1)
	{
		new aimData[PR_AimSync];
		BS_IgnoreBits(bs, 8);
		BS_ReadAimSync(bs, aimData);
		if (aimData[PR_camMode] == 45 || aimData[PR_camMode] == 49)
		{
			format(str, sizeof(str), ""RED_E"[AntiCheat]: %s (ID:%d) is suspect of using InvalidCamera Hack.", pName[playerid], playerid);
			SendAdminMessage(-1, str);
			return false;
		}
	}
	return true;
}

// Anti InvisibleMinigun
IPacket:BULLET_SYNC(playerid, BitStream:bs)
{
	if(!IsPlayerAdmin(playerid) && pAdmin[playerid] == 0 && IsPlayerConnected(playerid) && GetPVarInt(otherid, "BadSports") != 1)
	{
		new bulletData[PR_BulletSync];
		BS_IgnoreBits(bs, 8);
		BS_ReadBulletSync(bs, bulletData);
		if(!GetPVarInt(playerid, "givenByAdmin") && bulletData[PR_weaponId] == WEAPON_MINIGUN && InDM[playerid] == 0)
		{ 
			format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) is suspect of using Invisible Minigun Hack.", pName[playerid], playerid);		
			//SendClientMessageToAll(-1, str);
			SendAdminMessage(-1, str);
			return false;
		}
		if (!(-35000.0 <= bulletData[PR_origin][0] <= 35000.0) || !(-35000.0 <= bulletData[PR_origin][1] <= 35000.0) || !(-35000.0 <= bulletData[PR_origin][2] <= 35000.0))
		{
			format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) is suspect of using BadBulletDataOrigin Hack.", pName[playerid], playerid);
			SendAdminMessage(-1, str);
			return false;
		}
	}

	/*if (!(-35000.0 <= bulletData[PR_hitPos][0] <= 35000.0) || !(-35000.0 <= bulletData[PR_hitPos][1] <= 35000.0) || !(-35000.0 <= bulletData[PR_hitPos][2] <= 35000.0))
	{
		format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) was kicked by the server [Reason: BadBulletDataHitPos]", pName[playerid], playerid);
		SendClientMessageToAll(-1, str);
		Kick(playerid);
		return false;
	}*/
	return true;
}

// Anti InvalidBullet (Crasher) && Anti SurfHack && Anti CleoFly
IPacket:PLAYER_SYNC(playerid, BitStream:bs)
{
	if(!IsPlayerAdmin(playerid) && pAdmin[playerid] == 0 && IsPlayerConnected(playerid) && GetPVarInt(otherid, "BadSports") != 1)
	{
		new onFootData[PR_OnFootSync];
		BS_IgnoreBits(bs, 8);
		BS_ReadOnFootSync(bs, onFootData);

	    /*if((doingStunt[playerid] != 9) && onFootData[PR_animationId] == 958 && onFootData[PR_weaponId] != WEAPON_PARACHUTE || onFootData[PR_animationId] == 959 && onFootData[PR_weaponId] != WEAPON_PARACHUTE)
		{
			format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) is suspect of using CleoFly/FlyHack.", pName[playerid], playerid);
			SendAdminMessage(-1, str);
			return false;
		}*/
		if(onFootData[PR_position][2] == -5.5) 
		{
			format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) is suspect of using BulletCrasher.", pName[playerid], playerid);
			SendAdminMessage(-1, str);
			return false;
		}
	}
	return true;
}

/*
// Anti TriggerBot
public OnPlayerTriggerbot(playerid)
{
    format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) was kicked by the server [Reason: TriggerBot]", pName[playerid], playerid);
	SendClientMessageToAll(-1, str);
	Kick(playerid);	
	return true;
}*/

/*
// Anti Health/Armour hacks
hook OnPlayerUpdate(playerid)
{
	new Float:health;
    GetPlayerHealth(playerid, health);
    if(health == 100 && GOD[playerid] != 1 && pSpawned[playerid])
    {
    	format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) is suspect of using Health Hacks.", pName[playerid], playerid);
    	SendAdminMessage(-1, str);
    }

    GetPlayerArmour(playerid, health);
    if(health == 100 && GOD[playerid] != 1 && pSpawned[playerid])
    {
    	format(str, sizeof(str), ""RED_E"[Anti-Cheat]: %s (ID:%d) is suspect of using Armour Hacks.", pName[playerid], playerid);
    	SendAdminMessage(-1, str);
    }
    return 1;
}
*/
