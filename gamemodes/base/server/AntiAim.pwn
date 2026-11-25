#include <YSI\y_hooks>
#if !defined BUSTAIM_MAX_PL_PERCENTAGE
	#define BUSTAIM_MAX_PL_PERCENTAGE 3
#endif
#if !defined BUSTAIM_MAX_PING
	#define BUSTAIM_MAX_PING 600
#endif
#if !defined BUSTAIM_SKIP_WEAPON_IDS
	#define BUSTAIM_SKIP_WEAPON_IDS 38
#endif
#if !defined BUSTAIM_MAX_CONTINOUS_SHOTS
	#define BUSTAIM_MAX_CONTINOUS_SHOTS 10
#endif
#if !defined BUSTAIM_PROAIM_TELEPORT_PROBES
	#define BUSTAIM_PROAIM_TELEPORT_PROBES 2
#endif
#if !defined BUSTAIM_OUT_OF_RANGE_PROBES
	#define BUSTAIM_OUT_OF_RANGE_PROBES 2
#endif
#if !defined BUSTAIM_RANDOM_AIM_PROBES
	#define BUSTAIM_RANDOM_AIM_PROBES 5
#endif
#if !defined MIN_DIST_FOR_AIM_CHECKS
	#define MIN_DIST_FOR_AIM_CHECKS 5
#endif
#if !defined MAX_B2V_DEVIATION
	#define MAX_B2V_DEVIATION 10
#endif
#if !defined BUSTAIM_PLAYER_SPHERE_RADIUS
	#define BUSTAIM_PLAYER_SPHERE_RADIUS 3
#endif
static ids[MAX_PLAYERS];
public OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings)
{
	new nme[MAX_PLAYER_NAME],wname[32];
	
	ids[playerid]++;
	GetPlayerName(playerid,nme,sizeof(nme));
	GetWeaponName(weaponid,wname,sizeof(wname));
	if(warnings & WARNING_OUT_OF_RANGE_SHOT)
	{
	    format(str,256, ""RED_E"* ADMIN-MSG: "GREY2_E"[%d]%s(%d) fired shots from a distance greater than the %s's fire range(Normal Range:%d)",ids[playerid],nme,playerid,wname,BustAim::GetNormalWeaponRange(weaponid));
		SendAdminMessage(COLOR_GREY,str);
	
	}
	if(warnings & WARNING_PROAIM_TELEPORT)
	{
	    format(str,256,""RED_E"* ADMIN-MSG: "GREY2_E"[%d]%s(%d) is possibly using proaim (Teleport Detected)",ids[playerid],nme,playerid);
		SendAdminMessage(COLOR_GREY,str);

	}
	if(warnings & WARNING_RANDOM_AIM)
	{
	    format(str,256,""RED_E"* ADMIN-MSG: "GREY2_E"[%d]%s(%d) is suspected to be using aimbot(Hit with Random Aim with %s)",ids[playerid],nme,playerid,wname);
		SendAdminMessage(COLOR_GREY,str);

	}
	if(warnings & WARNING_CONTINOUS_SHOTS)
	{
	    //format(str,256,""RED_E"* ADMIN-MSG: "GREY2_E"[%d]%s(%d) has fired 300 shots continously with %s(%d)",ids[playerid],nme,playerid,wname,weaponid);
		//SendAdminMessage(-1,str);
	}
	return 0;
}

CMD:profile(playerid,params[])
{	
	if(pAdmin[playerid] < 1)
		return Error(playerid, "You are not authorized to use this command!");
	
	new id;
    if(sscanf(params, "u",id))
	{
	    return SendClientMessage(playerid, 0xFF0000AA, "Usage:/profile [PlayerID/Name]");
	}
    new allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns;
    BustAim::GetPlayerProfile(id,allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns);
	new name[MAX_PLAYER_NAME];
	GetPlayerName(id,name,MAX_PLAYER_NAME);
	format(str,144,""RED_E"* ADMIN-MSG: "GREY2_E"Aim Profile of %s(%d):Complete Profile:Stats of all weapons",name,id);
	SendClientMessage(playerid,COLOR_GREEN,str);
	format(str,144,""RED_E"* ADMIN-MSG: "GREY2_E"Fired:%d Hits:%d HitPercentage:%.2f MaxContinousShots:%d Bullets OutOfRangeWarns:%d AimWarns:%d TeleportWarns:%d",allshots,hitshots,((hitshots*100.0)/allshots),max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns);
	SendClientMessage(playerid,COLOR_GREEN,str);
	return 1;
}

CMD:wprofile(playerid,params[])
{
	if(pAdmin[playerid] < 1)
		return Error(playerid, "You are not authorized to use this command!");
	
    new id,wid;
    if(sscanf(params, "ui",id,wid))
	{
	    return SendClientMessage(playerid, 0xFF0000AA, "Usage:/wprofile [PlayerID/Name] [WeaponID]");
	}
    new allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns;
    BustAim::GetPlayerWeaponProfile(id,wid,allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns);
	new name[MAX_PLAYER_NAME],wname[32];
	GetPlayerName(id,name,MAX_PLAYER_NAME);
	GetWeaponName(wid,wname,32);
	format(str,144,""RED_E"* ADMIN-MSG: "GREY2_E"Weapon Profile of %s(%d):Stats of Weapon %s(%d)",name,id,wname,wid);
	SendClientMessage(playerid,COLOR_GREEN,str);
	format(str,144,""RED_E"* ADMIN-MSG: "GREY2_E"Fired:%d Hits:%d HitPercentage:%.2f MaxContinousShots:%d Bullets OutOfRangeWarns:%d AimWarns:%d TeleportWarns:%d",allshots,hitshots,((hitshots*100.0)/allshots),max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns);
	SendClientMessage(playerid,COLOR_GREEN,str);
	return 1;
}