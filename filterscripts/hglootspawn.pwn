#include <a_samp>
#include <zcmd>

CMD:spawn(playerid, params[]) {
	new Float:coords[3];
	GetPlayerPos(playerid, coords[0], coords[1], coords[2]);
	coords[2] -= 0.85;
	new string[120];
	format(string, sizeof string, "{%f, %f, %f}", coords[0], coords[1], coords[2]);
	printf("{%f, %f, %f}", coords[0], coords[1], coords[2]);
	SendClientMessage(playerid, -1, string);
	return 1;
}

