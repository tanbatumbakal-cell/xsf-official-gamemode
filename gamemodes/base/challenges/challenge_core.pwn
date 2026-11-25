#include <YSI\y_hooks>

#define CHALLENGE_EASY		1
#define CHALLENGE_MED		2
#define CHALLENGE_HARD	    3
#define CHALLENGE_INSANE    4

new PlayerText:challengemenu_td[MAX_PLAYERS][2];

stock ChallengeDifficulty(diff)
{
	new diffintext[20];
	switch(diff)
	{
		case 1: diffintext = "{009933}(Easy)";
		case 2: diffintext = "{FF9900}(Medium)";
		case 3: diffintext = "{B80000}(Hard)";
		case 4: diffintext = "{B80000}(Insane)";
		case 5: diffintext = "Easy";
		case 6: diffintext = "Medium";
		case 7: diffintext = "Hard";
		case 8: diffintext = "Insane";

	}
	return diffintext;
}

forward CreateChallengeTextdraws(playerid,challenge[20],difficulty,attempts,completes);
forward UpdateChallengeTextDraws(playerid,challenge[20],difficulty,attempts,completes);
forward DestroyChallengeTextDraws(playerid);

public DestroyChallengeTextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, challengemenu_td[playerid][0]);
	PlayerTextDrawDestroy(playerid, challengemenu_td[playerid][1]);



	return 1;
}
public UpdateChallengeTextDraws(playerid,challenge[20],difficulty,attempts,completes)
{

	new tmpstring[60];
	format(tmpstring,sizeof(tmpstring),"_____%s~n~___%s~n~__%i~n~%i",challenge,ChallengeDifficulty(difficulty+4),attempts,completes);
	PlayerTextDrawSetString(playerid, challengemenu_td[playerid][1], tmpstring); 
	PlayerTextDrawShow(playerid, challengemenu_td[playerid][1]);
	
	return 1;
}

public CreateChallengeTextdraws(playerid,challenge[20],difficulty,attempts,completes)
{
DestroyChallengeTextDraws(playerid);

challengemenu_td[playerid][0] = CreatePlayerTextDraw(playerid,2.380920, 262.106658, "Stunt_Name:~n~Difficulty:~n~Attempts:~n~Finishes:");
PlayerTextDrawLetterSize(playerid,challengemenu_td[playerid][0], 0.165333, 1.169066);
PlayerTextDrawAlignment(playerid,challengemenu_td[playerid][0], 1);
PlayerTextDrawColor(playerid,challengemenu_td[playerid][0], 582321151);
PlayerTextDrawSetShadow(playerid,challengemenu_td[playerid][0], 0);
PlayerTextDrawSetOutline(playerid,challengemenu_td[playerid][0], 1);
PlayerTextDrawBackgroundColor(playerid,challengemenu_td[playerid][0], 255);
PlayerTextDrawFont(playerid,challengemenu_td[playerid][0], 2);
PlayerTextDrawSetProportional(playerid,challengemenu_td[playerid][0], 1);
PlayerTextDrawSetShadow(playerid,challengemenu_td[playerid][0], 0);


new tmpstring[60];
	
format(tmpstring,sizeof(tmpstring),"_____%s~n~___%s~n~__%i~n~%i",challenge,ChallengeDifficulty(difficulty+4),attempts,completes);

challengemenu_td[playerid][1] = CreatePlayerTextDraw(playerid,39.333301, 262.533325, tmpstring);
PlayerTextDrawLetterSize(playerid,challengemenu_td[playerid][1], 0.165333, 1.169066);
PlayerTextDrawAlignment(playerid,challengemenu_td[playerid][1], 1);
PlayerTextDrawColor(playerid,challengemenu_td[playerid][1], -1);
PlayerTextDrawSetShadow(playerid,challengemenu_td[playerid][1], 0);
PlayerTextDrawSetOutline(playerid,challengemenu_td[playerid][1], 1);
PlayerTextDrawBackgroundColor(playerid,challengemenu_td[playerid][1], 255);
PlayerTextDrawFont(playerid,challengemenu_td[playerid][1], 2);
PlayerTextDrawSetProportional(playerid,challengemenu_td[playerid][1], 1);
PlayerTextDrawSetShadow(playerid,challengemenu_td[playerid][1], 0);

PlayerTextDrawShow(playerid, challengemenu_td[playerid][0]);
PlayerTextDrawShow(playerid, challengemenu_td[playerid][1]);


return 1;
}


