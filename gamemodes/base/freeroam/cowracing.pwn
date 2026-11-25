#include <YSI\y_hooks>

#define FREEROAM_WORLD 0

enum cowenum
{
    object,
    cname[20],
    cowcolor[10]
};
new cows[5][cowenum];

enum cowbetenum
{
    bcowid,
    cbamount
    
};
new Float:cowratings[5];
new cowbets[MAX_PLAYERS][cowbetenum];
new Float:cowy[5];
new cowracerunning = 0;
new cowbillboard;
new cowtimer = 59;
new cowpickup[10];
new incowracedialog[MAX_PLAYERS];


#define DIALOG_COWRACE          141
#define DIALOG_COWRACE_BET1     142
#define DIALOG_COWRACE_BET2     143
#define DIALOG_COWRACE_BET3     144
#define DIALOG_COWRACE_BET4     145
#define DIALOG_COWRACE_BET5     146


forward cowrace();

#define MIN_COWSPEED        2
#define MAX_COWSPEED        8
#define MAX_COWDISTANCE     15 

forward resetcows();
forward wincowrace(cowid);
forward updatecowbillboard();
forward cowcountdown();
forward GenerateCowRatings();

public GenerateCowRatings()
{
    cowratings[0] = floatrandom(3.00-1.8)+1.8;
    cowratings[1] = floatrandom(3.00-1.8)+1.8;
    cowratings[2] = floatrandom(3.00-1.8)+1.8;
    cowratings[3] = floatrandom(3.00-1.8)+1.8;
    cowratings[4] = floatrandom(3.00-1.8)+1.8;
    return 1;
}

public cowcountdown()
{
    if(cowtimer == 0)
    {
        cowrace();
        return cowtimer = 59;
    }
    else
    {    
        cowtimer--;
        new String[128];
        format(String, sizeof(String), "\n\n{1f5c99}Place your bets\n{CC0099}Race starts in %i seconds!",cowtimer);
        SetDynamicObjectMaterialText(cowbillboard, 0, String, OBJECT_MATERIAL_SIZE_256x128,"Arial", 18, 0,  0xFFFFFFFF,1, 1);
        SetTimer("cowcountdown",1000,0);
    }
    return 1;
}

public updatecowbillboard()
{

    new positions[5];
   
    for(new i = 0; i < 5;i++)
        positions[GetCowPosition(i)] = i;
      

    new String[80];
    format(String, sizeof(String), "%s1:%s\n%s2:%s\n%s3:%s\n%s4:%s\n%s5:%s",
        cows[positions[0]][cowcolor],cows[positions[0]][cname],cows[positions[1]][cowcolor],cows[positions[1]][cname],
        cows[positions[2]][cowcolor],cows[positions[2]][cname],cows[positions[3]][cowcolor],cows[positions[3]][cname],
        cows[positions[4]][cowcolor],cows[positions[4]][cname]);
  

    
    SetDynamicObjectMaterialText(cowbillboard, 0, String, OBJECT_MATERIAL_SIZE_256x128,"Arial", 18, 0,  0xFFFFFFFF,1, 0);
    return 1;
}
forward Float:floatrandom(Float:maxx);
stock Float:floatrandom(Float:maxx) {
    return floatmul(floatdiv(float(random(cellmax)), float(cellmax - 1)), maxx);
}

StringNumeric(const strr[])
{
    for(new i = 0,ii = strlen(strr);i < ii;++i)
    {
        if(strr[i] > '9' || strr[i] < '0') return 0;
    }
    return 1;
}
stock GetCowPosition(cowid)
{
    new index = 0;
    for(new j = 0; j < 5; j++)
    {

        if(j != cowid)
        {
            new Float:cx,Float:cy,Float:cz;
            new Float:cx2,Float:cy2,Float:cz2;
            GetDynamicObjectPos(cows[j][object], cx, cy, cz);
            GetDynamicObjectPos(cows[cowid][object], cx2, cy2, cz2);
            if(1308 - cx > 1308 - cx2)
            index++;
        }
    }
    
    //index++;
    
    return index;
}



public cowrace()
{   

    cowracerunning = 1;
    MoveDynamicObject(cows[0][object],1308 - random(MAX_COWDISTANCE)-5,748.28925, 11.81810,random(MAX_COWSPEED+MIN_COWSPEED)+MIN_COWSPEED,-1000.0,-1000.0,-1000.0);
    
 
    MoveDynamicObject(cows[1][object],1308 - random(MAX_COWDISTANCE)-5,743.40179, 11.81810,random(MAX_COWSPEED+MIN_COWSPEED)+MIN_COWSPEED,-1000.0,-1000.0,-1000.0);
 
   
    MoveDynamicObject(cows[2][object],1308 - random(MAX_COWDISTANCE)-5,738.27972, 11.81810,random(MAX_COWSPEED+MIN_COWSPEED)+MIN_COWSPEED,-1000.0,-1000.0,-1000.0);

    
    MoveDynamicObject(cows[3][object],1308 - random(MAX_COWDISTANCE)-5,733.17657, 11.81810,random(MAX_COWSPEED+MIN_COWSPEED)+MIN_COWSPEED,-1000.0,-1000.0,-1000.0);

    
    MoveDynamicObject(cows[4][object],1308 - random(MAX_COWDISTANCE)-5,728.23962, 11.81810,random(MAX_COWSPEED)+MIN_COWSPEED,-1000.0,-1000.0,-1000.0);

    return 1;

}
public OnDynamicObjectMoved(objectid)
{

    for(new i = 0; i < 5; i++)
    {
        if(objectid == cows[i][object])
        {
            if(cowracerunning == 0) return resetcows();
            new Float:cx,Float:cy,Float:cz;
            GetDynamicObjectPos(cows[i][object], cx, cy, cz);
            if(cx == 1197) 
                return wincowrace(i);
            else
            {
                new dist = random(MAX_COWDISTANCE)+5;
                
                if((cx - dist) <= 1197)
                    MoveDynamicObject(cows[i][object],1197,cowy[i], 11.81810,random(MAX_COWSPEED)+MIN_COWSPEED,-1000.0,-1000.0,-1000.0);
                else
                   MoveDynamicObject(cows[i][object],cx - dist,cowy[i], 11.81810,random(MAX_COWSPEED)+MIN_COWSPEED,-1000.0,-1000.0,-1000.0);
           }
        }
        
    }
    updatecowbillboard();
    return 1;
}

public wincowrace(cowid)
{
    cowracerunning = 0;
    resetcows();

    
    format(str, sizeof(str), "COWRACING: "WHITE_E" %s has won the cowrace!",cows[cowid][cname]);
    SendClientMessageToAll(COLOR_RED,str);
    foreach(new i : Player)
    {
        if(cowbets[i][bcowid] == cowid)  
        {
            GivePlayerCash(i,floatround(float(cowbets[i][cbamount]) * cowratings[cowid]));
            
            format(str, sizeof(str),"COWRACING: "WHITE_E" You have won %s for betting on the right cow",floatround(float(cowbets[i][cbamount]) * cowratings[cowid]));
            SendClientMessage(i,COLOR_RED,str);
        }   
        cowbets[i][bcowid] =-1;
        cowbets[i][cbamount] = 0;

    }
    GenerateCowRatings();
   
 
    return resetcows();
}
public resetcows()
{

    StopDynamicObject(cows[0][object]);
    StopDynamicObject(cows[1][object]);
    StopDynamicObject(cows[2][object]);
    StopDynamicObject(cows[3][object]);
    StopDynamicObject(cows[4][object]);
    DestroyDynamicObject(cows[0][object]);
    DestroyDynamicObject(cows[1][object]);
    DestroyDynamicObject(cows[2][object]);
    DestroyDynamicObject(cows[3][object]);
    DestroyDynamicObject(cows[4][object]);
    
 

    cows[0][object] =  CreateDynamicObject(16442, 1308, 748.28925, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[1][object] = CreateDynamicObject(16442, 1308, 743.40179, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[2][object] =  CreateDynamicObject(16442, 1308, 738.27972, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[3][object] =  CreateDynamicObject(16442, 1308, 733.17657, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[4][object] = CreateDynamicObject(16442, 1308, 728.23962, 11.81810,   0.00000, 0.00000, 185.00000);


    SetDynamicObjectMaterialText(cowbillboard, 0, "\n\n\n{1f5c99}Place your bets", OBJECT_MATERIAL_SIZE_256x128,"Arial", 18, 0,  0xFFFFFFFF,1, 1);
    
    return 1;

}
forward placebet(playerid,cowid,amount[]);
public placebet(playerid,cowid,amount[])
{
    if(strval(amount) == 0)
    {
        incowracedialog[playerid] = 0;
        return Error(playerid, "COWRACING: "WHITE_E" You need to bet atleast $1");
       
    }
    if(strval(amount) > 100000)
    {
        incowracedialog[playerid] = 0;
        return Error(playerid, "COWRACING: "WHITE_E" The maximum bet is 100 000!");
       
    }
    if(cowracerunning == 1) 
    {
        incowracedialog[playerid] = 0;
        return Error(playerid, "COWRACING: "WHITE_E" Race has already started!");
        
    }
    if(!StringNumeric(amount))
    {

        SendClientMessage(playerid,COLOR_RED, "COWRACING: "WHITE_E" You can only enter numbers!");
        new String[128];
        format(String, sizeof(String), "Enter the amount you want to bet on %s",cows[cowid][cname]);
        return ShowPlayerDialog(playerid,DIALOG_COWRACE_BET1, DIALOG_STYLE_INPUT, "Cow Race", String, "Bet", "Cancel");
    }
    else
    {
        if(pCash[playerid] < strval(amount)) 
        {
            incowracedialog[playerid] = 0;

            return  Error(playerid, "COWRACING: "WHITE_E" You dont have enough money to place this bet!");
        }
        cowbets[playerid][bcowid] = cowid;
        cowbets[playerid][cbamount] = strval(amount);
        
        GivePlayerCash(playerid,-strval(amount));
        SendClientMessageEx(playerid,COLOR_RED, "COWRACING: "WHITE_E": You have bet $%s on %s",strval(amount)),cows[cowid][cname]);
        incowracedialog[playerid] = 0;
        if(cowracerunning == 0)
            cowcountdown();
        
        cowracerunning = 2;
    }


    return 1;

}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_COWRACE:
        {
            if(!response) incowracedialog[playerid] = 0;
            if(response)
            {
                switch(listitem)
                {
                    case 0:return ShowPlayerDialog(playerid,DIALOG_COWRACE_BET1, DIALOG_STYLE_INPUT, "Cow Race", "Enter the amount you want to bet on Bertha", "Bet", "Cancel");
                    case 1:return ShowPlayerDialog(playerid,DIALOG_COWRACE_BET2, DIALOG_STYLE_INPUT, "Cow Race", "Enter the amount you want to bet on Bubba", "Bet", "Cancel");
                    case 2:return ShowPlayerDialog(playerid,DIALOG_COWRACE_BET3, DIALOG_STYLE_INPUT, "Cow Race", "Enter the amount you want to bet on Bert", "Bet", "Cancel");
                    case 3:return ShowPlayerDialog(playerid,DIALOG_COWRACE_BET4, DIALOG_STYLE_INPUT, "Cow Race", "Enter the amount you want to bet on Barry", "Bet", "Cancel");
                    case 4:return ShowPlayerDialog(playerid,DIALOG_COWRACE_BET5, DIALOG_STYLE_INPUT, "Cow Race", "Enter the amount you want to bet on Bella", "Bet", "Cancel");


                }

            }
        }
        case DIALOG_COWRACE_BET1:
        {
            if(!response) return incowracedialog[playerid] = 0;
            return placebet(playerid,0,inputtext);
        }
        case DIALOG_COWRACE_BET2:
        {
            if(!response) return incowracedialog[playerid] = 0;
            return placebet(playerid,1,inputtext);
        }
        case DIALOG_COWRACE_BET3:
        {
            if(!response) return incowracedialog[playerid] = 0;
            return placebet(playerid,2,inputtext);
        }
        case DIALOG_COWRACE_BET4:
        {
            if(!response) return incowracedialog[playerid] = 0;
            return placebet(playerid,3,inputtext);
        }
        case DIALOG_COWRACE_BET5:
        {
            if(!response) return incowracedialog[playerid] = 0;
            return placebet(playerid,4,inputtext);
        }
    }
    return 1;
}
   

hook OnPlayerConnect(playerid)
{
    RemoveBuildingForPlayer(playerid, 735, 1191.0859, 693.9922, 7.9297, 0.25);
    RemoveBuildingForPlayer(playerid, 615, 1128.3672, 728.2578, 9.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 615, 1148.6172, 728.2578, 9.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 673, 1162.8203, 733.7266, 9.2656, 0.25);
    RemoveBuildingForPlayer(playerid, 615, 1167.6016, 728.2578, 9.8672, 0.25);
    RemoveBuildingForPlayer(playerid, 775, 1199.5156, 733.8672, 9.6641, 0.25);
    return 1;

}
hook OnGameModeInit()
{
    cows[0][object] =  CreateDynamicObject(16442, 1308, 748.28925, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[1][object] = CreateDynamicObject(16442, 1308, 743.40179, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[2][object] =  CreateDynamicObject(16442, 1308, 738.27972, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[3][object] =  CreateDynamicObject(16442, 1308, 733.17657, 11.81810,   0.00000, 0.00000, 185.00000);
    cows[4][object] = CreateDynamicObject(16442, 1308, 728.23962, 11.81810,   0.00000, 0.00000, 185.00000);

    cowbillboard = CreateDynamicObject(9190, 1259.92847, 738.14166, 31.24532,   0.00000, 0.00000, 90.00000);
    SetDynamicObjectMaterialText(cowbillboard, 0, "\n\n\n{1f5c99}Place your bets", OBJECT_MATERIAL_SIZE_256x128,"Arial", 18, 0,  0xFFFFFFFF,1, 1);

    format(cows[0][cname], 20, "bertha");
    format(cows[1][cname], 20, "Bubba");
    format(cows[2][cname], 20, "Bert");
    format(cows[3][cname], 20, "Barry");
    format(cows[4][cname], 20, "Bella");

    format(cows[0][cowcolor], 10, "{1f5c99}");
    format(cows[1][cowcolor], 10, "{00FF00}");
    format(cows[2][cowcolor], 10, "{FFCC00}");
    format(cows[3][cowcolor], 10, "{FF0000}");
    format(cows[4][cowcolor], 10, "{CC0099}");
    
    cowy[0] = 748.28925;
    cowy[1] = 743.40179;
    cowy[2] = 738.27972;
    cowy[3] = 733.17657;
    cowy[4] = 728.23962;

    for(new i=0; i < MAX_PLAYERS; i++)
    {
        cowbets[i][bcowid] =-1;
        cowbets[i][cbamount] = 0;
    }

    cowpickup[0] = CreateDynamicPickup(1274,23,1289.4113,761.9526,22.8729, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[1] = CreateDynamicPickup(1274,23,1288.0861,761.9529,22.8729, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[2] = CreateDynamicPickup(1274,23,1285.6688,761.9532,22.8729, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[3] = CreateDynamicPickup(1274,23,1284.3734,761.9532,22.8729, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[4] = CreateDynamicPickup(1274,23,1289.2755,714.9383,22.8771, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[5] = CreateDynamicPickup(1274,23,1288.0270,714.9384,22.8771, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[6] = CreateDynamicPickup(1274,23,1285.8737,714.9055,22.8771, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[7] = CreateDynamicPickup(1274,23,1284.3326,714.9055,22.8771, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[8] = CreateDynamicPickup(1274,23,1329.2926,739.3184,32.3069, FREEROAM_WORLD,-1,-1,100.0);
    cowpickup[9] = CreateDynamicPickup(1274,23,1329.2880,737.8536,32.3061, FREEROAM_WORLD,-1,-1,100.0);


    GenerateCowRatings();

    CreateDynamicObject(19544, 1283.72168, 731.08972, 9.85440,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.12378, 719.22736, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.12329, 709.58630, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.65369, 719.26331, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.64478, 709.64545, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.65405, 728.88440, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.65466, 738.51379, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.67175, 748.14001, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.66394, 709.63751, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.63904, 719.23187, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.14331, 709.60553, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.15515, 719.20593, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.64429, 709.61731, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.64771, 719.19745, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.14380, 709.55859, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.14526, 719.21387, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.63440, 709.61334, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.64197, 719.25739, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.81055, 709.67212, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.82031, 719.29199, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.82544, 728.91168, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83960, 748.15411, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.81055, 709.67212, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.82031, 719.29199, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.82544, 728.91168, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83301, 738.53210, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83960, 748.15411, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.48206, 709.66736, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.46130, 719.15204, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.46130, 719.15198, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.48206, 709.66742, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.12378, 719.25940, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.65369, 719.26331, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.64478, 709.64539, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.12329, 709.60028, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.64197, 719.25739, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.63440, 709.61328, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.14380, 709.55859, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.14526, 719.21393, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.64771, 719.19739, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.64429, 709.61731, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.14331, 709.60553, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.63904, 719.23187, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.66394, 709.63751, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.15515, 719.20587, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.67175, 748.14001, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.65466, 738.51379, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.65405, 728.88440, 18.45918,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(18770, 1311.61279, 724.53552, -62.38324,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(18770, 1259.63831, 723.60333, -62.38324,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3858, 1294.00000, 7678.00000, 724.00000,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(18770, 1259.45435, 723.60327, -62.38320,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19544, 1283.72168, 746.05353, 9.83440,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.11560, 728.84760, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.11560, 738.45300, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.11560, 748.07977, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.11560, 757.71283, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.46631, 757.81512, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.45752, 767.40442, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.11560, 767.34442, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.62305, 767.34442, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.12708, 767.34442, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.62195, 767.34442, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.12415, 767.34399, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.62244, 767.34381, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.62634, 757.71283, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.12708, 757.71283, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.60486, 757.71283, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.12903, 757.71283, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.61206, 757.71283, 10.00000,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.48816, 757.75568, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.09656, 757.67230, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1327.45825, 767.34436, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1317.11658, 767.30444, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.62634, 757.71283, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1306.62305, 767.34442, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.12708, 767.34442, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1296.13525, 757.73108, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.60486, 757.71283, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1285.62195, 767.34442, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.12415, 767.34399, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1275.14734, 757.71283, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.61206, 757.71283, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1264.62244, 767.34381, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(18770, 1311.61279, 752.14728, -62.38320,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19544, 1221.26685, 746.05353, 9.83440,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19544, 1221.26685, 731.08972, 9.83440,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(18770, 1259.68103, 753.35059, -62.38320,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83960, 757.75702, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83960, 767.37891, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83960, 757.75702, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83960, 767.37891, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1328.11035, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1318.53040, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1308.88916, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1299.26318, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1289.66870, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1280.06885, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1270.45374, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1264.17896, 772.13531, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.42664, 767.38312, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.42664, 757.82343, 11.34820,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.42664, 757.82343, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1259.42664, 767.38312, 21.84340,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1264.17896, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1270.45374, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1280.06885, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1289.66870, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1299.26318, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1308.88916, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1318.53040, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1328.11035, 772.13531, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1311.95251, 747.44592, 13.26740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1311.95251, 737.84558, 13.26740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1311.95251, 728.22559, 13.26740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1306.58984, 727.65851, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1306.58923, 732.83801, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1306.66589, 737.98309, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1306.61060, 743.12555, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1306.65137, 748.33282, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1296.71021, 748.33710, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1296.71021, 743.12549, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1296.71021, 737.98309, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1296.71021, 732.83801, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1296.71021, 727.65851, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(14409, 1314.12927, 730.62439, 13.11430,   0.00000, 0.00000, 180.00000,FREEROAM_WORLD);
    CreateDynamicObject(14409, 1314.12927, 746.06207, 13.11430,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(14409, 1314.12927, 742.87500, 15.36770,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(14409, 1314.12927, 734.08252, 15.36770,   0.00000, 0.00000, 180.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1313.78125, 738.55688, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1317.25354, 738.57678, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1321.37280, 738.37445, 18.45918,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1321.36316, 728.83539, 18.45920,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1321.36328, 748.03345, 18.47150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1316.08704, 728.30151, 13.26740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1316.11108, 748.36823, 13.26740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1314.42285, 733.11023, 11.54470,   90.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1314.44336, 743.62750, 11.70970,   90.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1314.40625, 737.93622, 16.46200,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1314.38940, 738.85992, 16.44700,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19435, 1316.08704, 734.80438, 17.34560,   90.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19435, 1316.08704, 738.30450, 17.34560,   90.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19435, 1316.08704, 741.78070, 17.34560,   90.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19435, 1316.08704, 734.80438, 17.60192,   90.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19435, 1316.08704, 738.30450, 17.62164,   90.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19435, 1316.08704, 741.78070, 17.72560,   90.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1316.05823, 735.40009, 9.71297,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1316.08130, 745.00702, 9.71297,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1316.10535, 734.13849, 16.64595,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1316.24463, 743.75909, 16.64595,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1314.33215, 736.25720, 11.54470,   90.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1314.34167, 738.99921, 11.54470,   90.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19452, 1314.37598, 741.41986, 11.54470,   90.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1286.76819, 748.33008, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1276.78870, 748.32520, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1266.89209, 748.33728, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1257.01758, 748.33374, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1247.01318, 748.32983, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1237.12549, 748.32874, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1227.07874, 748.32343, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1227.07874, 748.32343, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1217.09705, 748.32123, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1207.09509, 748.32141, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1197.11499, 748.33704, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1286.77954, 743.15277, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1276.76965, 743.16376, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1266.80908, 743.18201, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1256.95068, 743.16779, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1246.97412, 743.16486, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1236.97046, 743.17981, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1227.02808, 743.15906, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1217.22546, 743.16724, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1286.82678, 737.98926, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1276.90259, 738.00305, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1286.89331, 732.85278, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1286.88818, 727.64716, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1276.98938, 727.67596, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1277.02808, 732.86151, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1266.98230, 738.01929, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1267.17188, 732.84570, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1267.10754, 727.65564, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1247.16565, 738.05988, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1257.24426, 732.84155, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1257.18787, 727.66156, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1257.07471, 738.03516, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1257.07471, 738.03516, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1247.16565, 738.05988, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1247.34143, 732.81866, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1247.20813, 727.63312, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1237.35962, 738.05396, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1237.52954, 732.82507, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1237.48108, 727.62335, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1227.51733, 738.07147, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1227.63086, 732.82654, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1227.62402, 727.62427, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1217.61560, 738.09015, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1207.27686, 743.14404, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1217.64734, 732.82813, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1217.70068, 727.62390, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1207.75525, 738.08423, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1207.70581, 732.82153, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1207.69849, 727.59723, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1197.31616, 743.17737, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1197.31616, 743.17737, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1197.77441, 738.08612, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1197.71570, 732.82544, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1197.65759, 727.58490, 9.21170,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19304, 1332.82849, 735.43469, 10.73910,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19304, 1332.85144, 742.00140, 10.73910,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1337.56604, 738.64423, 9.18051,   10.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1252.30017, 754.39392, 10.46850,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1237.96838, 754.36176, 10.46850,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1231.20569, 754.34857, 10.46850,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1231.20569, 754.34857, 11.58373,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1237.96838, 754.36176, 11.57089,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1252.30017, 754.39392, 11.60694,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1231.20569, 754.34857, 12.85615,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1231.20569, 754.34857, 14.18125,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1231.20435, 754.32861, 15.52298,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1237.96838, 754.36176, 12.83503,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1237.96838, 754.36176, 14.22759,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1237.96838, 754.36176, 15.48894,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1252.30017, 754.39392, 12.82671,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1252.30017, 754.39392, 14.17955,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1252.30017, 754.39392, 15.49911,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1251.34814, 723.51105, 10.46850,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1230.78174, 723.51569, 10.46850,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1241.34216, 723.43048, 10.46850,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1241.34216, 723.43048, 11.76283,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1230.78174, 723.51569, 11.75580,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1251.34814, 723.51105, 11.77664,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1251.34814, 723.51105, 12.84445,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1251.34814, 723.51105, 14.14553,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1251.34814, 723.51105, 15.39085,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1241.34216, 723.43048, 12.85689,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1241.34216, 723.43048, 14.18484,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1241.34216, 723.43048, 15.38977,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1230.78174, 723.51569, 12.91334,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1230.78174, 723.51569, 14.20992,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1230.78174, 723.51569, 15.40877,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(16060, 1214.08496, 762.41052, 8.97764,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(16060, 1179.12256, 742.74451, 7.57712,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(16060, 1213.23853, 718.73181, 9.08761,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(16060, 1184.20959, 747.00146, 7.57712,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40015, 721.39355, 10.48532,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40015, 721.39355, 11.66012,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40015, 721.39355, 12.85483,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40015, 721.39355, 14.16900,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40015, 721.39355, 15.48318,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.38367, 707.79474, 10.48532,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40076, 728.22223, 10.48532,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40076, 728.22223, 11.64020,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40076, 728.22223, 12.85544,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40076, 728.22223, 14.15057,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.40076, 728.22223, 15.46326,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.38367, 707.79474, 11.61523,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.38367, 707.79474, 12.85614,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.38367, 707.79474, 14.14996,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(7662, 1190.38367, 707.79474, 15.42344,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(16060, 1215.12549, 712.70154, 9.01302,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(16060, 1201.34424, 719.11578, 9.08761,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(16060, 1203.16382, 762.89392, 8.97764,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1198.04773, 728.64240, 9.21170,   -3.96000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1198.04077, 738.56152, 9.21170,   -3.96000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19737, 1198.03333, 748.50098, 9.21170,   -3.96000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1264.25427, 704.85315, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1273.84363, 704.85309, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1283.44409, 704.85309, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1293.06519, 704.85309, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1302.68774, 704.85309, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1312.31494, 704.85309, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1321.95532, 704.85309, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1328.07239, 704.85309, 11.34820,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1328.07239, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1321.95532, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1312.31494, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1302.68774, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1293.06519, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1283.44409, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1273.84363, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1264.25427, 704.85309, 21.84340,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(0, 1245.58789, 754.47467, 37.76230,   0.00000, 0.00000, -59.94000,FREEROAM_WORLD);
    CreateDynamicObject(0, 1259.93408, 745.00989, -62.38320,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19672, 1260.19299, 729.36053, 34.98199,   2.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19672, 1259.90979, 747.68915, 34.98200,   -2.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(16151, 1284.80322, 770.97528, 10.39791,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1279.13098, 724.21558, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1269.50781, 724.21558, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1288.63843, 724.21558, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1298.16907, 724.21558, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1307.76672, 724.21558, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1263.28699, 724.21558, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1308.04504, 752.98212, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1298.41956, 752.98212, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1288.79895, 752.98212, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1279.23718, 752.98212, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1269.61267, 752.98212, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1263.51355, 752.98212, 13.31050,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1311.95251, 726.03748, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1311.95251, 730.83441, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1311.95251, 735.77789, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1311.95251, 740.75732, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1311.95251, 745.67749, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1311.95251, 750.61810, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1316.08704, 726.61328, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1316.08704, 734.48431, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1316.08704, 729.49628, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1313.72180, 724.21167, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1316.08704, 742.68457, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1316.08704, 747.64447, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1316.08704, 750.38489, 18.48500,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1313.69360, 752.94543, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.24731, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1305.34619, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1300.52515, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1295.68445, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1290.78430, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1285.90393, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1280.98352, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1276.00232, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1271.06213, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1266.12280, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1261.18030, 752.98212, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1260.95703, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1265.90247, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1270.84570, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1275.70886, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1280.66870, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1285.61133, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1290.59167, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1295.57227, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1300.53406, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1305.53577, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.42017, 724.21558, 18.48500,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1304.09729, 720.03003, 19.44480,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1295.49622, 756.58807, 19.44960,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1286.88440, 756.58807, 19.44960,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1278.32410, 756.58807, 19.44960,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1269.71082, 756.58807, 19.44960,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.33875, 760.63507, 20.12130,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.60645, 758.97290, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1294.00061, 758.97290, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1284.45752, 758.97290, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1274.83447, 758.99292, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1268.54956, 758.97290, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1266.83569, 758.97290, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1265.31934, 763.71088, 20.12130,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1308.33008, 767.00970, 20.12130,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1265.31396, 770.07184, 20.12930,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1270.45435, 763.73792, 21.78701,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1280.94275, 763.75580, 21.78701,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1291.41260, 763.74701, 21.78701,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1301.91333, 763.72430, 21.78701,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1303.13428, 763.72058, 21.78701,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1304.05054, 763.20099, 22.68906,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1304.04443, 769.74078, 25.42228,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.56995, 765.58350, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(18770, 1333.52087, 752.14728, -62.38320,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(18770, 1333.61157, 724.53552, -62.38320,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1295.44849, 763.19751, 22.68906,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1278.26550, 763.19751, 22.68910,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1269.55017, 763.19751, 22.68910,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1294.08984, 765.58350, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1284.50757, 765.58350, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1274.86609, 765.58350, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1274.99451, 767.27002, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1274.94641, 770.55011, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1284.56677, 767.37817, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1294.11768, 767.37927, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.58459, 767.42859, 24.50154,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1295.40295, 769.74078, 25.42230,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1286.78479, 769.74078, 25.42230,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1278.18408, 769.74078, 25.42230,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1269.69141, 769.74078, 25.42230,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1268.54370, 765.60608, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1266.87146, 765.59320, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1265.31934, 767.19708, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1265.31934, 770.40167, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1268.64478, 767.34912, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1266.86804, 767.27142, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1266.89246, 770.40417, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1269.52026, 770.50452, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.31311, 767.14349, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.31311, 770.34192, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.53381, 770.57349, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(1571, 1284.88147, 763.70367, 22.96100,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(1571, 1288.44116, 763.70374, 22.96098,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19858, 1290.39624, 763.02911, 22.79853,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(8614, 1309.10510, 763.01599, 20.59861,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1284.02942, 770.64636, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1293.60559, 770.34174, 24.50150,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1304.09729, 756.58807, 19.44960,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1295.49512, 720.03003, 19.44480,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1286.89319, 720.03003, 19.44480,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1278.31226, 720.03003, 19.44480,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1269.71057, 720.03003, 19.44480,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.60535, 717.64258, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1294.00586, 717.64258, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1308.34448, 712.91418, 20.12130,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1284.36548, 717.64258, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1274.74536, 717.64258, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1268.35059, 717.62982, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1267.00977, 717.62982, 20.12130,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1265.48975, 712.88129, 20.12130,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1303.15137, 712.88898, 21.79114,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1292.68640, 712.89258, 21.79114,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1282.24548, 712.89429, 21.79114,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1271.80566, 712.88239, 21.79114,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1270.64453, 712.86243, 21.79114,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1304.09729, 713.76862, 22.68320,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1295.51770, 713.76862, 22.68320,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1278.33557, 713.76862, 22.68320,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1269.71472, 713.76862, 22.68320,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.60120, 711.36499, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1294.01501, 711.35797, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1284.39111, 711.35345, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1274.82935, 711.35339, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1269.18982, 711.35168, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1267.06848, 711.35168, 22.81740,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1270.23938, 709.65045, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1279.89099, 709.68762, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1289.48914, 709.68207, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1299.13440, 709.69629, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.59827, 709.67242, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1303.63367, 706.55139, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1293.94446, 706.73499, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1284.46155, 706.54694, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1274.88135, 706.66718, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1270.38049, 706.73145, 24.49723,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1265.48975, 709.83801, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.36401, 709.82941, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1265.48975, 706.52509, 20.12130,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.36401, 706.67047, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.36401, 706.53040, 19.97830,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1265.48975, 706.72827, 22.81740,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(8572, 1309.33862, 714.89630, 20.66616,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(8614, 1315.86902, 709.06531, 20.66620,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(8614, 1312.51721, 705.87952, 22.81940,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1304.07153, 707.50958, 25.24444,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1295.55554, 707.49658, 25.24444,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1286.97876, 707.49268, 25.24444,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1278.42651, 707.56384, 25.24444,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1269.84106, 707.56000, 25.24444,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1306.69055, 709.45801, 23.93887,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19448, 1306.71436, 708.45355, 23.91893,   0.00000, 90.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(1571, 1285.26184, 713.15491, 22.96100,   0.00000, 0.00000, 180.00000,FREEROAM_WORLD);
    CreateDynamicObject(1571, 1288.84155, 713.18768, 22.96100,   0.00000, 0.00000, 180.00000,FREEROAM_WORLD);
    CreateDynamicObject(19858, 1283.28516, 711.94012, 22.79850,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(8572, 1314.21057, 769.14227, 20.66616,   0.00000, 0.00000, 90.00000,FREEROAM_WORLD);
    CreateDynamicObject(8572, 1311.24414, 771.08234, 23.26103,   0.00000, 0.00000, 180.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.66821, 768.67603, 24.50150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19356, 1308.65308, 767.11578, 24.50150,   0.00000, 90.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1315.41455, 728.82104, 28.77450,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1324.78772, 728.80090, 30.42530,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1328.50891, 728.82098, 31.06720,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1315.41455, 739.30792, 28.77450,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1315.41455, 747.96973, 28.77450,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1324.78772, 739.30792, 30.42530,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1324.78772, 747.96973, 30.42530,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1328.50891, 739.30792, 31.06720,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19375, 1328.50891, 747.96973, 31.06720,   10.00000, 90.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.82544, 728.91168, 32.33160,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83301, 738.53210, 32.33160,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19377, 1332.83960, 748.15411, 32.33160,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.75818, 750.64728, 27.98970,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.75818, 746.06732, 27.98970,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.75818, 741.06689, 27.98970,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.75818, 736.06482, 27.98970,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.75806, 731.06256, 27.98970,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1310.75818, 726.12158, 27.98970,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(8572, 1322.17615, 753.87415, 20.86082,   0.00000, 0.00000, -180.00000,FREEROAM_WORLD);
    CreateDynamicObject(8572, 1318.76843, 753.91016, 23.99228,   0.00000, 0.00000, -180.00000,FREEROAM_WORLD);
    CreateDynamicObject(8572, 1315.30286, 753.91290, 27.25150,   0.00000, 0.00000, -180.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1316.95911, 753.08453, 29.08724,   10.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1321.80127, 753.08453, 29.95691,   10.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1326.70105, 753.08453, 30.82001,   10.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(19866, 1331.54138, 753.08447, 31.67512,   10.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1330.44287, 746.79370, 32.10251,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1330.30029, 729.68939, 32.10250,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(1571, 1331.02539, 738.64111, 32.49676,   0.00000, 0.00000, -90.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1321.02112, 746.85175, 30.31099,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);
    CreateDynamicObject(3819, 1321.20300, 729.70929, 30.31099,   0.00000, 0.00000, 0.00000,FREEROAM_WORLD);






    //actors
    /*

    AddPlayerClass(230,1284.4611,713.4426,25.2960,358.0388,0,0,0,0,0,0); // actor
    AddPlayerClass(230,1285.7043,713.4729,25.2960,1.4855,0,0,0,0,0,0); // actor
    AddPlayerClass(230,1287.9692,713.6725,25.2960,2.4255,0,0,0,0,0,0); // actor
    AddPlayerClass(230,1289.3634,713.5991,25.2960,358.3522,0,0,0,0,0,0); // actor
    AddPlayerClass(230,1289.4325,716.0004,22.8771,358.3522,0,0,0,0,0,0); // Z coord
    AddPlayerClass(230,1289.5562,763.8817,25.2959,178.8105,0,0,0,0,0,0); // actor
    AddPlayerClass(230,1288.0726,763.9026,25.2959,184.7639,0,0,0,0,0,0); // actor
    AddPlayerClass(230,1285.6724,763.8091,25.2960,172.5438,0,0,0,0,0,0); // actor
    AddPlayerClass(230,1284.3866,763.7563,25.2960,181.6306,0,0,0,0,0,0); // actor

    */
   



    return 1;
}