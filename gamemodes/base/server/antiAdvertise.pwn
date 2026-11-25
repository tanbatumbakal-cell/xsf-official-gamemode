#include <YSI\y_hooks>	

#define MAX_BLOCKEDIP 1000


new antiAdvertise[MAX_BLOCKEDIP][24];
stock loadAntiAdvertise()
{
	printf("does dis");
	mysql_function_query(g_SQL_handle, "SELECT ip FROM BlackListedIPs LIMIT 1000", true, "loadAntiAdvertisebB", "");
	
}
function loadAntiAdvertisebB()
{
	
	new h = 0;
	print("does dis2");

	for(new i = 0, r = cache_num_rows(); i < r; i++)	{
		cache_get_field_content(i, "ip", antiAdvertise[i], g_SQL_handle, 24);
		//printf("loaded ip %s",antiAdvertise[0]);
		h++;
	}

	printf("Number of blacklisted ips loaded: %d", h);
	return true;
}
function findFirstOccurenceOfLetter(input[],inputb[])
{
	for(new i = 0; i <strlen(input); i++)
	{
		new tempstr[10];
		strmid(tempstr,input, i, i+1);
		if(strfind(tempstr,inputb) != -1)
			return i;
	}
	return 0;
}
function checkForAdvertise(input[])
{
	for(new i = 0; i < sizeof(antiAdvertise); i++)
	{
		new tempstr[24];
		new inputb[400];
		format(inputb, sizeof(inputb), "%s", input);
		tempstr = antiAdvertise[i];
		if(strlen(tempstr) >5)
		{
			new amountoftimes = 0;
			for(new j = 0; j < 50; j++)
			{
				if(j == 3 && amountoftimes ==0)
					continue;
				new tempstrB[10];
				strmid(tempstrB,tempstr, j, j+1);
				if(strfind(inputb,tempstrB,true,0) != -1)
				{
					amountoftimes++;
					new tempnmbr = findFirstOccurenceOfLetter(inputb,tempstrB);
					strdel(inputb, tempnmbr, tempnmbr+1);
				}

			}
			if(amountoftimes >= strlen(antiAdvertise[i])-2)
				return true;
			else
				amountoftimes = 0;
			
		}
	}
	return false;

}

