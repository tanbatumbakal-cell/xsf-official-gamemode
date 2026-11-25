#include <a_samp>
#include <zcmd>

forward StopPlayerAnimation(playerid);
public StopPlayerAnimation(playerid) {
	ClearAnimations(playerid, 1);
	return 1;
}

CMD:testcmd(playerid, params[]) {
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 0, 0, 0, 1, 0, 1);
    SetTimerEx("StopPlayerAnimation", 1500, false, "i", playerid);
    return 1;
}
