/*
		Server - xTreme Stunt Freeroam (c) 2017
		Live Map
		Author: Xeon
*/

#include <djson>
#pragma unused djson_GameModeInit
		
#define FILE_JSON "stats.json"
		
new 
	Livemaptimer
;

forward public OnLiveMapUpdate();
public OnLiveMapUpdate()
{
	new Float:pos[3];
	foreach(new i : Player)
	{
		if(!IsPlayerConnected(i))
		{
			format(str, sizeof(str), "%d/online", i);
			djSetInt(FILE_JSON, str, 0);
		}
		else
		{
			GetPlayerPos(i, pos[0], pos[1], pos[2]);

			format(str, sizeof(str), "%d/x", i);
			djSetFloat(FILE_JSON, str, pos[0]);

			format(str, sizeof(str), "%d/y", i);
			djSetFloat(FILE_JSON, str, pos[1]);

			format(str, sizeof(str), "%d/name", i);
			djSet(FILE_JSON, str, pName[i]);

			format(str, sizeof(str), "%d/ping", i);
			djSetInt(FILE_JSON, str, GetPlayerPing(i));

			format(str, sizeof(str), "%d/online", i);
			djSetInt(FILE_JSON, str, 1);
		}
	}
}