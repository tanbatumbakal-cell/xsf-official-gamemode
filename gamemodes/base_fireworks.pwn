// Server Fireworks Script
// Created by NoTime.

#define MAX_LIGHTS 100
#define MAX_PARTS 13
#define Sprinkleid 52
#define RBSprinkleid 20

new Float:FRX[MAX_PLAYERS], Float:FRY[MAX_PLAYERS], Float:FRZ[MAX_PLAYERS];
new Float:FTX[MAX_PLAYERS], Float:FTY[MAX_PLAYERS], Float:FTZ[MAX_PLAYERS];
new Float:RBX[MAX_PLAYERS], Float:RBY[MAX_PLAYERS], Float:RBZ[MAX_PLAYERS];
new firecrackertime[MAX_PLAYERS];
new firerockettime[MAX_PLAYERS];
new explosionrocket[MAX_PLAYERS];
new Firecracker[MAX_PLAYERS];
new Firerocket[MAX_PLAYERS];
new rocketsmoke[MAX_PLAYERS];
new FireCrackerRoll[MAX_PLAYERS];
new firecrackerroll[MAX_PLAYERS];
new CrackerRollSmoke[MAX_PLAYERS];
new Float:RollStartX[MAX_PLAYERS], Float:RollStartY[MAX_PLAYERS], Float:RollStartZ[MAX_PLAYERS];

new RocketBoxTime[MAX_PLAYERS];
new RocketBox[MAX_PLAYERS];
new RocketBoxSmoke[MAX_PLAYERS];

new FountainSmoke[MAX_PLAYERS];
new Fountain[MAX_PLAYERS];

new Light[MAX_LIGHTS][MAX_PLAYERS];
new RollParts[MAX_PLAYERS][MAX_PARTS];
new FountainSprinkle[Sprinkleid][MAX_PLAYERS];

new RocketBoxSprinkle[RBSprinkleid][MAX_PLAYERS];
new RBLight[MAX_LIGHTS][MAX_PLAYERS];

new Fountain1Time[MAX_PLAYERS];
new Fountain2Time[MAX_PLAYERS];
new Fountain3Time[MAX_PLAYERS];
new DestroySprinkleID[MAX_PLAYERS];

enum FWN
{
	FireCracker,
	Firerocket1,
	Firerocket2,
	Crackerroll,
	Fountain1,
	Fountain2,
	Fountain3,
	RocketB,
	DrawDistance,
};
new AllowedFirework[FWN];

forward FirecrackerTime(playerid);
forward CrackerRollTime(playerid);
forward FirerocketTime(playerid);
forward splittime(playerid);
forward splittime2(playerid);
forward splittime3(playerid);
forward lighttimer(playerid);
forward lighttimer2(playerid);
forward CreateRoll(Rollid, Float:X, Float:Y, Float:Z);
forward DestroyRoll(Rollid);
forward FountainTimer(playerid);
forward Destroy1Sprinkle(playerid);
forward Destroy3Sprinkle(playerid);
forward LastSprinkles(playerid);
forward RocketBoxTimer(playerid);
forward SplitRBSprinkle(lightobject, playerid);
forward DestroyRBLight(playerid);


stock Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	if (IsPlayerInAnyVehicle(playerid))
		GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else
		GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
	return a;
}

public SplitRBSprinkle(lightobject, playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetObjectPos(RocketBoxSprinkle[RocketBoxTime[playerid]][playerid], X, Y, Z);
	CreateExplosion(X, Y, Z, 2, 0);
	DestroyObject(RocketBoxSprinkle[RocketBoxTime[playerid]][playerid]);
	RBLight[1][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[1][playerid], (X-(0+(random(8)))), (Y-(0+(random(8)))), (Z-25), (2+(random(4))));
	RBLight[2][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[2][playerid], (X+(0+(random(8)))), (Y+(0+(random(8)))), (Z-25), (2+(random(4))));
	RBLight[3][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[3][playerid], (X-(0+(random(8)))), (Y+(0+(random(8)))), (Z-25), (2+(random(4))));
	RBLight[4][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[4][playerid], (X+(0+(random(8)))), (Y-(0+(random(8)))), (Z-25), (2+(random(4))));
	SetTimerEx("DestroyRBLight", 2600, 0, "i", playerid);
	return 1;
}

public DestroyRBLight(playerid)
{
	DestroyObject(RBLight[1][playerid]);
	DestroyObject(RBLight[2][playerid]);
	DestroyObject(RBLight[3][playerid]);
	DestroyObject(RBLight[4][playerid]);
	RocketBoxTime[playerid] = RocketBoxTime[playerid]+1;
	RocketBoxTimer(playerid);
	return 1;
}

public RocketBoxTimer(playerid)
{
	if(RocketBoxTime[playerid] == 11)
	{
		RocketBoxTime[playerid] = 0;
		DestroyObject(RocketBox[playerid]);
		DestroyObject(RocketBoxSmoke[playerid]);
		return 1;
	}
	if(RocketBoxTime[playerid] >= 1)
	{
		new LightObject;
		switch(random(2))
		{
			case 0:
			{
				LightObject = 354;
			}
			case 1:
			{
				LightObject = 1213;
			}
		}
		RocketBoxSprinkle[RocketBoxTime[playerid]][playerid] = CreateObject(LightObject, RBX[playerid], RBY[playerid], RBZ[playerid], 0, 0, 0);
		MoveObject(RocketBoxSprinkle[RocketBoxTime[playerid]][playerid], RBX[playerid], RBY[playerid], (RBZ[playerid]+35), 20);
		SetTimerEx("SplitRBSprinkle", 1500, 0, "ii",LightObject, playerid);
		return 1;
	}
	return 1;
}

public Destroy1Sprinkle(playerid)
{
	if(DestroySprinkleID[playerid] >= 50)
	{
		new x;
		for (x=0;x<Sprinkleid;x++)
		{
			DestroyObject(FountainSprinkle[x][playerid]);
		}
		return 1;
	}
	if(DestroySprinkleID[playerid] >= 0)
	{
		DestroyObject(FountainSprinkle[DestroySprinkleID[playerid]][playerid]);
		DestroySprinkleID[playerid] = DestroySprinkleID[playerid]+1;
		return 1;
	}
	return 1;
}

public Destroy3Sprinkle(playerid)
{
	if(DestroySprinkleID[playerid] >= 50)
	{
		new x;
		for (x=0;x<Sprinkleid;x++)
		{
			DestroyObject(FountainSprinkle[x][playerid]);
		}
		return 1;
	}
	if(DestroySprinkleID[playerid] >= 0)
	{
		new Float:X, Float:Y, Float:Z;
		GetObjectPos(FountainSprinkle[DestroySprinkleID[playerid]][playerid] ,X, Y, Z);
		CreateExplosion(X, Y, Z, 12, 0);
		DestroyObject(FountainSprinkle[DestroySprinkleID[playerid]][playerid]);
		DestroySprinkleID[playerid] = DestroySprinkleID[playerid]+1;
		return 1;
	}
	return 1;
}

public LastSprinkles(playerid)
{
	Fountain1Time[playerid] = 0;
	Fountain2Time[playerid] = 0;
	Fountain3Time[playerid] = 0;
	DestroySprinkleID[playerid] = 0;
	return 1;
}

public FountainTimer(playerid)
{
	if(Fountain1Time[playerid] >= 50)
	{
		DestroyObject(Fountain[playerid]);
		DestroyObject(FountainSmoke[playerid]);
		SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("LastSprinkles", 600, 0, "i", playerid);
		return 1;
	}
	if(Fountain1Time[playerid] >= 1)
	{
		new Float:RandomXPos;
		new Float:RandomYPos;
		switch(random(2))
		{
			case 0:
			{
				RandomXPos = -(random(4));
			}
			case 1:
			{
				RandomXPos = (random(4));
			}
		}
		switch(random(2))
		{
			case 0:
			{
				RandomYPos = -(random(4));
			}
			case 1:
			{
				RandomYPos = (random(4));
			}
		}
		FountainSprinkle[Fountain1Time[playerid]][playerid] = CreateObject(354, FTX[playerid], FTY[playerid], FTZ[playerid], 0, 0, 0);
		MoveObject(FountainSprinkle[Fountain1Time[playerid]][playerid], (FTX[playerid]+RandomXPos), (FTY[playerid]+RandomYPos), (FTZ[playerid]+8), 30);
		Fountain1Time[playerid] = Fountain1Time[playerid]+1;
		SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("FountainTimer", (100+(random(200))), 0, "i",playerid);
		return 1;
	}
	if(Fountain2Time[playerid] >= 50)
	{
		DestroyObject(Fountain[playerid]);
		DestroyObject(FountainSmoke[playerid]);
		SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("LastSprinkles", 600, 0, "i", playerid);
		return 1;
	}
	if(Fountain2Time[playerid] >= 1)
	{
		new Float:RandomXPos;
		new Float:RandomYPos;
		switch(random(2))
		{
			case 0:
			{
				RandomXPos = -(random(4));
			}
			case 1:
			{
				RandomXPos = (random(4));
			}
		}
		switch(random(2))
		{
			case 0:
			{
				RandomYPos = -(random(4));
			}
			case 1:
			{
				RandomYPos = (random(4));
			}
		}
		FountainSprinkle[Fountain2Time[playerid]][playerid] = CreateObject(1213, FTX[playerid], FTY[playerid], FTZ[playerid], 0, 0, 0);
		MoveObject(FountainSprinkle[Fountain2Time[playerid]][playerid], (FTX[playerid]+RandomXPos), (FTY[playerid]+RandomYPos), (FTZ[playerid]+8), 30);
		Fountain2Time[playerid] = Fountain2Time[playerid]+1;
		SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("FountainTimer", (100+(random(200))), 0, "i",playerid);
		return 1;
	}
	if(Fountain3Time[playerid] >= 50)
	{
		DestroyObject(Fountain[playerid]);
		DestroyObject(FountainSmoke[playerid]);
		SetTimerEx("Destroy3Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("LastSprinkles", 600, 0, "i", playerid);
		return 1;
	}
	if(Fountain3Time[playerid] >= 1)
	{
		new Float:RandomXPos;
		new Float:RandomYPos;
		new RandomLight;
		switch(random(2))
		{
			case 0:
			{
				RandomXPos = -(random(4));
			}
			case 1:
			{
				RandomXPos = (random(4));
			}
		}
		switch(random(2))
		{
			case 0:
			{
				RandomYPos = -(random(4));
			}
			case 1:
			{
				RandomYPos = (random(4));
			}
		}
		switch(random(2))
		{
			case 0:
			{
				RandomLight = 354;
			}
			case 1:
			{
				RandomLight = 1213;
			}
		}
		FountainSprinkle[Fountain3Time[playerid]][playerid] = CreateObject(RandomLight, FTX[playerid], FTY[playerid], FTZ[playerid], 0, 0, 0);
		MoveObject(FountainSprinkle[Fountain3Time[playerid]][playerid], (FTX[playerid]+RandomXPos), (FTY[playerid]+RandomYPos), (FTZ[playerid]+8), 30);
		Fountain3Time[playerid] = Fountain3Time[playerid]+1;
		SetTimerEx("Destroy3Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("FountainTimer", (100+(random(200))), 0, "i",playerid);
		return 1;
	}
	return 1;
}

public CreateRoll(Rollid, Float:X, Float:Y, Float:Z)
{
	RollParts[Rollid][1] = CreateObject(1654,X,Y,Z, 90, 90, 0);
	RollParts[Rollid][2] = CreateObject(1654,(X+0.25),Y,Z, 90, 90, 0);
	RollParts[Rollid][3] = CreateObject(1654,(X+0.50),Y,Z, 90, 90, 0);
	RollParts[Rollid][4] = CreateObject(1654,(X+0.75),Y,Z, 90, 90, 0);
	RollParts[Rollid][5] = CreateObject(1654,(X+1.00),Y,Z, 90, 90, 0);
	RollParts[Rollid][6] = CreateObject(1654,(X+1.25),Y,Z, 90, 90, 0);
	RollParts[Rollid][7] = CreateObject(1654,X,(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][8] = CreateObject(1654,(X+0.25),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][9] = CreateObject(1654,(X+0.50),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][10] = CreateObject(1654,(X+0.75),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][11] = CreateObject(1654,(X+1.00),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][12] = CreateObject(1654,(X+1.25),(Y+0.1),Z, 90, 90, 0);
	return 1;
}

public DestroyRoll(Rollid)
{
	DestroyObject(RollParts[Rollid][1]);
	DestroyObject(RollParts[Rollid][2]);
	DestroyObject(RollParts[Rollid][3]);
	DestroyObject(RollParts[Rollid][4]);
	DestroyObject(RollParts[Rollid][5]);
	DestroyObject(RollParts[Rollid][6]);
	DestroyObject(RollParts[Rollid][7]);
	DestroyObject(RollParts[Rollid][8]);
	DestroyObject(RollParts[Rollid][9]);
	DestroyObject(RollParts[Rollid][10]);
	DestroyObject(RollParts[Rollid][11]);
	DestroyObject(RollParts[Rollid][12]);
	return 1;
}

public CrackerRollTime(playerid)
{
	if(firecrackerroll[playerid] == 1)
	{
		DestroyObject(CrackerRollSmoke[playerid]);
	}
	if(firecrackerroll[playerid] == 49)
	{
		firecrackerroll[playerid] = 0;
		DestroyRoll(playerid);
		return 1;
	}
	if(firecrackerroll[playerid] >= 1)
	{
		new Float:X, Float:Y, Float:Z;
		if(firecrackerroll[playerid] >= 1 && firecrackerroll[playerid] <= 4)
		{
			GetObjectPos(RollParts[playerid][1], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 5 && firecrackerroll[playerid] <= 8)
		{
			GetObjectPos(RollParts[playerid][2], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 9 && firecrackerroll[playerid] <= 12)
		{
			GetObjectPos(RollParts[playerid][3], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 13 && firecrackerroll[playerid] <= 16)
		{
			GetObjectPos(RollParts[playerid][4], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 17 && firecrackerroll[playerid] <= 20)
		{
			GetObjectPos(RollParts[playerid][5], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 21 && firecrackerroll[playerid] <= 24)
		{
			GetObjectPos(RollParts[playerid][6], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 25 && firecrackerroll[playerid] <= 28)
		{
			GetObjectPos(RollParts[playerid][12], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 29 && firecrackerroll[playerid] <= 32)
		{
			GetObjectPos(RollParts[playerid][11], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 33 && firecrackerroll[playerid] <= 36)
		{
			GetObjectPos(RollParts[playerid][10], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 37 && firecrackerroll[playerid] <= 40)
		{
			GetObjectPos(RollParts[playerid][9], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 41 && firecrackerroll[playerid] <= 44)
		{
			GetObjectPos(RollParts[playerid][8], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		if(firecrackerroll[playerid] >= 45 && firecrackerroll[playerid] <= 48)
		{
			GetObjectPos(RollParts[playerid][7], X, Y, Z);
			DestroyRoll(playerid);
			CreateExplosion(X, Y, Z, 12, 0);
			CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
			firecrackerroll[playerid] = firecrackerroll[playerid]+1;
			SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
			return 1;
		}
		return 1;
	}
	return 1;
}

public FirecrackerTime(playerid)
{
	if(firecrackertime[playerid] == 1)
	{
		new Float:X, Float:Y,Float:Z;
		GetObjectPos(Firecracker[playerid], X, Y, Z);
		CreateExplosion(X,Y,Z, 12, 0);
		DestroyObject(Firecracker[playerid]);
		firecrackertime[playerid] = 0;
		return 1;
	}
	return 1;
}

public FirerocketTime(playerid)
{
	if(firerockettime[playerid] == 1)
	{
		GetObjectPos(Firerocket[playerid], FRX[playerid], FRY[playerid], FRZ[playerid]);
		explosionrocket[playerid] = CreateExplosion(FRX[playerid], FRY[playerid], FRZ[playerid], 6, 0);
		SetTimerEx("splittime", 500, 0, "i", playerid);
		return 1;
	}
	if(firerockettime[playerid] == 2)
	{
		GetObjectPos(Firerocket[playerid], FRX[playerid], FRY[playerid], FRZ[playerid]);
		explosionrocket[playerid] = CreateExplosion(FRX[playerid], FRY[playerid], FRZ[playerid], 6, 0);
		SetTimerEx("splittime2", 100, 0, "i", playerid);
		return 1;
	}
	return 1;
}

public splittime(playerid)
{
	if(firerockettime[playerid] == 1)
	{
		CreateExplosion(FRX[playerid]-(0+(random(3))),FRY[playerid]-(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]-(0+(random(3))),FRY[playerid]+(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]-(0+(random(3))),FRY[playerid],FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]+(0+(random(3))),FRY[playerid]-(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]+(0+(random(3))),FRY[playerid]+(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]+(0+(random(3))),FRY[playerid],FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]-(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]+(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		Light[1][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]-(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[2][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid],FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[3][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid],FRZ[playerid]-(0+(random(6))), 0, 0,0);
		Light[4][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]-(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[5][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]+(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[6][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid],FRZ[playerid]-(0+(random(6))), 0, 0,0);
		Light[7][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]-(0+(random(6))),FRZ[playerid]-(0+(random(6))), 0, 0,0);
		Light[8][playerid] = CreateObject(354,FRX[playerid],FRY[playerid]-(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(Light[1][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X-(0+(random(6))), Y-(0+(random(6))), Z-20, 6);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		MoveObject(Light[2][playerid], X-(0+(random(6))), Y+(0+(random(6))), Z-20, 5);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		MoveObject(Light[3][playerid], X-(0+(random(6))), Y, Z-20, 4);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		MoveObject(Light[4][playerid], X+(0+(random(6))), Y-(0+(random(6))), Z-20, 5);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		MoveObject(Light[5][playerid], X+(0+(random(6))), Y+(0+(random(6))), Z-20, 5);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		MoveObject(Light[6][playerid], X+(0+(random(6))), Y, Z-20, 4);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		MoveObject(Light[7][playerid], X, Y-(0+(random(6))), Z-20, 6);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		MoveObject(Light[8][playerid], X, Y+(0+(random(6))), Z-20, 5);
		SetTimerEx("lighttimer", 3900, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

public splittime2(playerid)
{
	if(firerockettime[playerid] == 2)
	{
		CreateExplosion(FRX[playerid]-(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]-(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]-(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 6, 0);
		Light[1][playerid] = CreateObject(354,FRX[playerid]-(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[2][playerid] = CreateObject(354,FRX[playerid]-(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[3][playerid] = CreateObject(354,FRX[playerid]-(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 0, 0,0);
		Light[4][playerid] = CreateObject(354,FRX[playerid]+(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[5][playerid] = CreateObject(354,FRX[playerid]+(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[6][playerid] = CreateObject(354,FRX[playerid]+(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 0, 0,0);
		Light[7][playerid] = CreateObject(354,FRX[playerid],FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[8][playerid] = CreateObject(354,FRX[playerid],FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(Light[1][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		MoveObject(Light[2][playerid], X-6, Y+6, Z-20, 4);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		MoveObject(Light[3][playerid], X-6, Y, Z-20, 4);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		MoveObject(Light[4][playerid], X+6, Y-6, Z-20, 4);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		MoveObject(Light[5][playerid], X+6, Y+6, Z-20, 4);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		MoveObject(Light[6][playerid], X+6, Y, Z-20, 4);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		MoveObject(Light[7][playerid], X, Y-6, Z-20, 4);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		MoveObject(Light[8][playerid], X, Y+6, Z-20, 4);
		SetTimerEx("splittime3", 3000, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

public splittime3(playerid)
{
	if(firerockettime[playerid] == 2)
	{
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(Light[1][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[9][playerid], X, Y, Z);
		Light[11][playerid] = CreateObject(1213,X-7,Y+7,Z+8, 0, 0,0);
		Light[12][playerid] = CreateObject(1213,X-7,Y,Z+5, 0, 0,0);
		Light[13][playerid] = CreateObject(1213,X,Y+7,Z-5, 0, 0,0);
		Light[14][playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		Light[15][playerid] = CreateObject(1213,X,Y-7,Z+5, 0, 0,0);
		Light[16][playerid] = CreateObject(1213,X-7,Y,Z-5, 0, 0,0);
		Light[17][playerid] = CreateObject(1213,X,Y+7,Z-8, 0, 0,0);
		Light[18][playerid] = CreateObject(1213,X,Y+7,Z-5, 0, 0,0);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		Light[19][playerid] = CreateObject(1213,X+7,Y,Z-1, 0, 0,0);
		Light[20][playerid] = CreateObject(1213,X-7,Y,Z-8, 0, 0,0);
		Light[21][playerid] = CreateObject(1213,X+7,Y+7,Z-5, 0, 0,0);
		Light[22][playerid] = CreateObject(1213,X,Y,Z+5, 0, 0,0);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		Light[23][playerid] = CreateObject(1213,X+7,Y-7,Z-5, 0, 0,0);
		Light[24][playerid] = CreateObject(1213,X-7,Y,Z-7, 0, 0,0);
		Light[25][playerid] = CreateObject(1213,X+7,Y+7,Z+5, 0, 0,0);
		Light[26][playerid] = CreateObject(1213,X,Y-7,Z, 0, 0,0);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		Light[27][playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		Light[28][playerid] = CreateObject(1213,X-7,Y,Z+8, 0, 0,0);
		Light[29][playerid] = CreateObject(1213,X+7,Y,Z-8, 0, 0,0);
		Light[30][playerid] = CreateObject(1213,X,Y+7,Z+5, 0, 0,0);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		Light[31][playerid] = CreateObject(1213,X-7,Y-7,Z-7, 0, 0,0);
		Light[32][playerid] = CreateObject(1213,X,Y,Z-5, 0, 0,0);
		Light[33][playerid] = CreateObject(1213,X+7,Y+7,Z+5, 0, 0,0);
		Light[34][playerid] = CreateObject(1213,X+4,Y-7,Z-5, 0, 0,0);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		Light[35][playerid] = CreateObject(1213,X-7,Y-7,Z-8, 0, 0,0);
		Light[36][playerid] = CreateObject(1213,X-7,Y,Z+5, 0, 0,0);
		Light[37][playerid] = CreateObject(1213,X,Y,Z-5, 0, 0,0);
		Light[38][playerid] = CreateObject(1213,X,Y-7,Z+8, 0, 0,0);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		Light[39][playerid] = CreateObject(1213,X-4,Y-7,Z-8, 0, 0,0);
		Light[40][playerid] = CreateObject(1213,X+7,Y,Z+8, 0, 0,0);
		Light[41][playerid] = CreateObject(1213,X+4,Y,Z+5, 0, 0,0);
		Light[42][playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		GetObjectPos(Light[1][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		MoveObject(Light[2][playerid], X-6, Y+6, Z-20, 4);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		MoveObject(Light[3][playerid], X-6, Y, Z-20, 4);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		MoveObject(Light[4][playerid], X+6, Y-6, Z-20, 4);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		MoveObject(Light[5][playerid], X+6, Y+6, Z-20, 4);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		MoveObject(Light[6][playerid], X+6, Y, Z-20, 4);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X, Y-6, Z-20, 4);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		MoveObject(Light[8][playerid], X, Y+6, Z-20, 4);
		GetObjectPos(Light[11][playerid], X, Y, Z);
		MoveObject(Light[11][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[12][playerid], X, Y, Z);
		MoveObject(Light[12][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[13][playerid], X, Y, Z);
		MoveObject(Light[13][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[14][playerid], X, Y, Z);
		MoveObject(Light[14][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[15][playerid], X, Y, Z);
		MoveObject(Light[15][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[16][playerid], X, Y, Z);
		MoveObject(Light[16][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[17][playerid], X, Y, Z);
		MoveObject(Light[17][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[18][playerid], X, Y, Z);
		MoveObject(Light[18][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[19][playerid], X, Y, Z);
		MoveObject(Light[19][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[20][playerid], X, Y, Z);
		MoveObject(Light[20][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[21][playerid], X, Y, Z);
		MoveObject(Light[21][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[22][playerid], X, Y, Z);
		MoveObject(Light[22][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[23][playerid], X, Y, Z);
		MoveObject(Light[23][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[24][playerid], X, Y, Z);
		MoveObject(Light[24][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[25][playerid], X, Y, Z);
		MoveObject(Light[25][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[26][playerid], X, Y, Z);
		MoveObject(Light[26][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[27][playerid], X, Y, Z);
		MoveObject(Light[27][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[28][playerid], X, Y, Z);
		MoveObject(Light[28][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[29][playerid], X, Y, Z);
		MoveObject(Light[29][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[30][playerid], X, Y, Z);
		MoveObject(Light[30][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[31][playerid], X, Y, Z);
		MoveObject(Light[31][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[32][playerid], X, Y, Z);
		MoveObject(Light[32][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[33][playerid], X, Y, Z);
		MoveObject(Light[33][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[34][playerid], X, Y, Z);
		MoveObject(Light[34][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[35][playerid], X, Y, Z);
		MoveObject(Light[35][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[36][playerid], X, Y, Z);
		MoveObject(Light[36][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[37][playerid], X, Y, Z);
		MoveObject(Light[37][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[38][playerid], X, Y, Z);
		MoveObject(Light[38][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[39][playerid], X, Y, Z);
		MoveObject(Light[39][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[40][playerid], X, Y, Z);
		MoveObject(Light[40][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[41][playerid], X, Y, Z);
		MoveObject(Light[41][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[42][playerid], X, Y, Z);
		MoveObject(Light[42][playerid], X-6, Y-6, Z-20, 4);
		SetTimerEx("lighttimer2", 4000, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

public lighttimer(playerid)
{
	DestroyObject(Light[1][playerid]);
	DestroyObject(Light[2][playerid]);
	DestroyObject(Light[3][playerid]);
	DestroyObject(Light[4][playerid]);
	DestroyObject(Light[5][playerid]);
	DestroyObject(Light[6][playerid]);
	DestroyObject(Light[7][playerid]);
	DestroyObject(Light[8][playerid]);
	firerockettime[playerid] = 0;
	return 1;
}

public lighttimer2(playerid)
{
	DestroyObject(Light[1][playerid]);
	DestroyObject(Light[2][playerid]);
	DestroyObject(Light[3][playerid]);
	DestroyObject(Light[4][playerid]);
	DestroyObject(Light[5][playerid]);
	DestroyObject(Light[6][playerid]);
	DestroyObject(Light[7][playerid]);
	DestroyObject(Light[8][playerid]);
	DestroyObject(Light[11][playerid]);
	DestroyObject(Light[12][playerid]);
	DestroyObject(Light[13][playerid]);
	DestroyObject(Light[14][playerid]);
	DestroyObject(Light[15][playerid]);
	DestroyObject(Light[16][playerid]);
	DestroyObject(Light[17][playerid]);
	DestroyObject(Light[18][playerid]);
	DestroyObject(Light[19][playerid]);
	DestroyObject(Light[20][playerid]);
	DestroyObject(Light[21][playerid]);
	DestroyObject(Light[22][playerid]);
	DestroyObject(Light[23][playerid]);
	DestroyObject(Light[24][playerid]);
	DestroyObject(Light[25][playerid]);
	DestroyObject(Light[26][playerid]);
	DestroyObject(Light[27][playerid]);
	DestroyObject(Light[28][playerid]);
	DestroyObject(Light[29][playerid]);
	DestroyObject(Light[30][playerid]);
	DestroyObject(Light[31][playerid]);
	DestroyObject(Light[32][playerid]);
	DestroyObject(Light[33][playerid]);
	DestroyObject(Light[34][playerid]);
	DestroyObject(Light[35][playerid]);
	DestroyObject(Light[36][playerid]);
	DestroyObject(Light[37][playerid]);
	DestroyObject(Light[38][playerid]);
	DestroyObject(Light[39][playerid]);
	DestroyObject(Light[40][playerid]);
	DestroyObject(Light[41][playerid]);
	DestroyObject(Light[42][playerid]);
	firerockettime[playerid] = 0;
	return 1;
}

CMD:lightfw(playerid, params[])
{
	if(pAdmin[playerid] == 0)
		if(pPremium[playerid] != 3)
			return Error(playerid, "You are not authorized to use this command!");
	if(pSpectating[playerid] != -1) return Error(playerid, "You can't use this command while spectating!");
	if(InDM[playerid] != 0) return Error(playerid, "You can't use this command while in a DM!");
	if(doingStunt[playerid] != 0) return Error(playerid, "You can't use this command in this area!");

	new distance;
	if(AllowedFirework[DrawDistance] == 0) distance = 15;
	if(AllowedFirework[DrawDistance] == 1) distance = 22;
	if(AllowedFirework[DrawDistance] == 2) distance = 30;
	new fwtype;
	if (sscanf(params, "i", fwtype))
	{
		SendClientMessage(playerid, COLOR_WHITE, "USAGE: /lightfw <1-8>");
		return 1;
	}
	switch(fwtype)
	{
		case 1:
		{
			if(firecrackertime[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, 8);
				firecrackertime[playerid] = 1;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s throws away a firecracker.", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				Firecracker[playerid] = CreateObject(1672, X,Y,(Z-0.9), 0, 0, 0);
				SetTimerEx("FirecrackerTime", (2000+(random(3000))), 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already threw a firecracker.");
		}
		case 2:
		{
			if(firecrackerroll[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, 8);
				firecrackerroll[playerid] = 1;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s Places down a firecracker roll", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				FireCrackerRoll[playerid] = CreateRoll(playerid,X,Y,(Z-1.00));
				RollStartX[playerid] = X;
				RollStartY[playerid] = Y;
				RollStartZ[playerid] = (Z-1.00);
				CrackerRollSmoke[playerid] = CreateObject(2780, X, Y, (Z-5.00), 0, 0, 0);
				SetTimerEx("CrackerRollTime", (2000+(random(3000))), 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already placed a firecracker roll.");
		}
		case 3:
		{
			if(firerockettime[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, distance);
				firerockettime[playerid] = 1;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s lights up a fire rocket.", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				
				Firerocket[playerid] = CreateObject(354, X,Y,(Z), 0, 0, 0);
				rocketsmoke[playerid] = CreateObject(2780, X,Y,(Z), 0, 0, 0);
				MoveObject(Firerocket[playerid], X, Y, Z+30, 10);
				MoveObject(rocketsmoke[playerid], X, Y, Z+30, 10);
				SetTimerEx("FirerocketTime", 3000, 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already lit a firerocket.");
		}
		case 4:
		{
			if(firerockettime[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, distance);
				firerockettime[playerid] = 2;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s lights up a fire rocket.", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				
				Firerocket[playerid] = CreateObject(354, X,Y,(Z), 0, 0, 0);
				rocketsmoke[playerid] = CreateObject(2780, X,Y,(Z), 0, 0, 0);
				MoveObject(Firerocket[playerid], X, Y, Z+50, 15);
				MoveObject(rocketsmoke[playerid], X, Y, Z+50, 15);
				SetTimerEx("FirerocketTime", 3000, 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already lit a firerocket.");
		}
		case 5:
		{
			if(Fountain1Time[playerid] == 0 && Fountain2Time[playerid] == 0 && Fountain3Time[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, 15);
				Fountain1Time[playerid] = 1;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s places a Firework Fountain on the ground.", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				
				FTX[playerid] = X;
				FTY[playerid] = Y;
				FTZ[playerid] = (Z-1.0);
				Fountain[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
				FountainSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
				SetTimerEx("FountainTimer", 3000, 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already lit a Firework Fountain.");
		}
		case 6:
		{
			if(Fountain1Time[playerid] == 0 && Fountain2Time[playerid] == 0 && Fountain3Time[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, 15);
				Fountain2Time[playerid] = 1;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s places a Firework Fountain on the ground.", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				
				FTX[playerid] = X;
				FTY[playerid] = Y;
				FTZ[playerid] = (Z-1.0);
				Fountain[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
				FountainSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
				SetTimerEx("FountainTimer", 3000, 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already lit a Firework Fountain.");
		}
		case 7:
		{
			if(Fountain1Time[playerid] == 0 && Fountain2Time[playerid] == 0 && Fountain3Time[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, 15);
				Fountain3Time[playerid] = 1;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s places a Firework Fountain on the ground.", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				
				FTX[playerid] = X;
				FTY[playerid] = Y;
				FTZ[playerid] = (Z-1.0);
				Fountain[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
				FountainSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
				SetTimerEx("FountainTimer", 3000, 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already lit a Firework Fountain.");
		}
		case 8:
		{
			if(RocketBoxTime[playerid] == 0)
			{
				new Float:X, Float:Y,Float:Z;
				GetPlayerPos(playerid,X,Y,Z);
				GetXYInFrontOfPlayer(playerid, X,Y, distance);
				RocketBoxTime[playerid] = 1;
				format(str, sizeof(str), ""YELLOW_E"- AS - "WHITE_E"%s places a Rocketbox on the ground.", pName[playerid]);
				foreach(new ii : Player)
				{
					if(IsPlayerInRangeOfPoint(ii, 20.0, X, Y, Z) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(ii)) SendClientMessage(ii, COLOR_WHITE, str);
				}
				
				RBX[playerid] = X;
				RBY[playerid] = Y;
				RBZ[playerid] = (Z-1.0);
				RocketBox[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
				RocketBoxSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
				SetTimerEx("RocketBoxTimer", 3000, 0, "i", playerid);
				return 1;
			}
			else return Error(playerid, "You already lit a Firework RocketBox.");
		}
		default: SendClientMessage(playerid, COLOR_WHITE, "No.");
	}
	return 1;
}
