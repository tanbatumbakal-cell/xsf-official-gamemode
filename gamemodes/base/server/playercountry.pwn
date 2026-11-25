#include <YSI\y_hooks>
#include <a_http>


forward OnLookupComplete(playerid, country[], region[], city[]);

#if !defined MAX_COUNTRY_NAME
	#define MAX_COUNTRY_NAME    (32)
#endif

enum e_LookupData {
	// Packed string containing the name of the country.
	e_LookupCountry[MAX_COUNTRY_NAME char],
	
	// Packed string containing the name of the region.
	e_LookupRegion[MAX_COUNTRY_NAME char],

	// Packed string containing the name of the city.
	e_LookupCity[MAX_COUNTRY_NAME char]
};

static
	g_asLookupData[MAX_PLAYERS][e_LookupData]
;

hook OnPlayerConnect(playerid)
{
	new
	    string[64]
	;
		
    strpack(g_asLookupData[playerid][e_LookupCountry], "Unknown", MAX_COUNTRY_NAME char);
    strpack(g_asLookupData[playerid][e_LookupRegion], "Unknown", MAX_COUNTRY_NAME char);
    strpack(g_asLookupData[playerid][e_LookupCity], "Unknown", MAX_COUNTRY_NAME char);

	GetPlayerIp(playerid, string, sizeof(string));

	if (!IsPlayerNPC(playerid) && strcmp(string, "127.0.0.1") != 0)
	{
	    // Insert the domain at the beginning of the IP.
		strins(string, "www.ip-api.com/csv/", 0);
		
		// Send the lookup request.
		HTTP(playerid, HTTP_GET, string, "", "HTTP_OnLookupResponse");
		
	}

}
stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}
forward HTTP_OnLookupResponse(index, response, data[]);
public HTTP_OnLookupResponse(index, response, data[])
{

	if (!IsPlayerConnected(index))
	{
		return 0;
	}
	else if (response == 200)
	{
		new dest[24][128];
		split(data,dest,',');
	    //CallLocalFunction("OnLookupComplete", "dsss", index, dest[0][1], dest[0][4], dest[0][10]);

	    // Pack the data for later use.
	    strpack(g_asLookupData[index][e_LookupCountry], dest[1], MAX_COUNTRY_NAME char);
	    strpack(g_asLookupData[index][e_LookupRegion], dest[5], MAX_COUNTRY_NAME char);
	    strpack(g_asLookupData[index][e_LookupCity], dest[10], MAX_COUNTRY_NAME char);
			
		
	}
	return 0;
}

stock GetPlayerCountry(playerid, country[], size = sizeof(country))
{
	if (IsPlayerConnected(playerid))
		return strunpack(country, g_asLookupData[playerid][e_LookupCountry], size);

	else
	    strunpack(country, !"Unknown", size);

	return 0;
}

stock GetPlayerRegion(playerid, region[], size = sizeof(region))
{
	if (IsPlayerConnected(playerid))
		return strunpack(region, g_asLookupData[playerid][e_LookupRegion], size);

	else
	    strunpack(region, !"Unknown", size);
	    
	return 0;
}

stock GetPlayerCity(playerid, city[], size = sizeof(city))
{
	if (IsPlayerConnected(playerid))
		return strunpack(city, g_asLookupData[playerid][e_LookupCity], size);

	else
	    strunpack(city, !"Unknown", size);
	    
	return 0;
}

