//Event system readme

/*
Event system is going to contain multiple files. Each file will be made for each and every event made.
So folder structure should look like this:
|─── Server-script
|	|─── gamemodes
|	|	|─── events
|	|	|	|─── EVENT_NAME1
|	|	|	|	|─── File1.pwn
|	|	|	|	|─── File2.pwn
|	|	|	|─── EVENT_NAME2
|	|	|	|	|─── File1.pwn
|	|	|	|	|─── File2.pwn
| //and so on
|
Instead of creating database entries individually for each event, we will use the raw coordinates directly into the scripts.
Same goes to stock samp functions. 
Public functions such as onplayerdeath, onplayerspawn, will be made as local functions, and used under the stock ones.


Example:
################################─── START ───###################################
## main script Server.pwn:
public OnPlayerDeath(...)
{
	....
	....
	KillPresidentDeath(playerid, killerid, reason); //put something like this
}

## under /gamemodes/events/killthepresident/main.pwn (purely an example)
stock KillPresidentDeath(playerid, killerid, reason);
{
	If(killerid != INVALID_PLAYER_ID)
	{
		....
	}
	return 1;
}
##############################─── END ───#########################################
and so on.



Furthermore - all variables related to each event, should be added to the event file if possible.
More details regarding the setup of events will arrive as there's some progress.