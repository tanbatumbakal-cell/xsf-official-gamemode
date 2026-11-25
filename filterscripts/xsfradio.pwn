#include <a_samp>
#include <zcmd>

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Server Radio Loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

CMD:Serverradio(playerid)
{
	PlayAudioStreamForPlayer(playerid, "http://188.165.198.21:8000/listen.pls?sid=1");
	SendClientMessage(playerid, -1, "{FF0000}[Server Radio] Streaming has now started.");
	return 1;
}
