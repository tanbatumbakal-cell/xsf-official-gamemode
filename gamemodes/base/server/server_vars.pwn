/*

Configuration Settings.		Vehicles, moneybag, some configuration and variables..																																							*/

// sscanf
/*native sscanf(const data[], const format[], {Float,_}:...);
native SSCANF_Init(players, invalid, len);
native SSCANF_Join(playerid, const name[], npc);
native SSCANF_Leave(playerid);*/

new veh_cnr[230];
new veh_TankDM[5];
new veh_War[26];
new veh_iDM[2];
new Tram[3];
new veh_admin;

new rektPlayers[MAX_PLAYERS];
// Player Colors
new PlayerColors[840] = {
	0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
	0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
	0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
	0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
	0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
	0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
	0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
	0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
	0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
	0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
	0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
	0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
	0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
	0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
	0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
	0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
	0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
	0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
	0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
	0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
	0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
	0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
	0xD8C762FF,0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,
	0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
	0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
	0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
	0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
	0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
	0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
	0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
	0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
	0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
	0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
	0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
	0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
	0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
	0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
	0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
	0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
	0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
	0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
	0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
	0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
	0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
	0xD8C762FF,0xD8C762FF,0xFF1493FF,0xF4A460FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,
	0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,
	0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,
	0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
	0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
	0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
	0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
	0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
	0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
	0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
	0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
	0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
	0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
	0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
	0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
	0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
	0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
	0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
	0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
	0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
	0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
	0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
	0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
	0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
	0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
	0xD8C762FF,0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,
	0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
	0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
	0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
	0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
	0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
	0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
	0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
	0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
	0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
	0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
	0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
	0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
	0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
	0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
	0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
	0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
	0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
	0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
	0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
	0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
	0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
	0xD8C762FF,0xD8C762FF,0xFF1493FF,0xF4A460FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,
	0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,
	0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF

};

// Random Colors - Originally from AndreT Modified by ReV for 0.3x
new randomColors[24] = {6, 7, 126, 128, 2, 152, 158, 228, 181, 229, 211, 1, 6, 243, 3, 175, 137, 155, 158, 79, 161, 162, 192, 3};

new ServerColors[8] = {0, 1, 2, 3, 6, 103, 175, 252};
// Vehicle Names
new vehName[][] =
{
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};


// MoneyBag System.
new Float:MoneyBagPos[3],
	MoneyBagLocation[50],
	MoneyBagFound = 1,
	MoneyBagStart;

#define MoneyBagCash ((random(60)+40)*1000)

enum mbinfo
{
	Float:XPOS,
	Float:YPOS,
	Float:ZPOS,
	Position[50]
};

// Cookie Jar System
new Float:CookieJarPos[3],
	CookieJarLocation[50],
	CookieJarFound = 1,
	CookieJarStart;

enum cjinfo
{
	Float:XPOS,
	Float:YPOS,
	Float:ZPOS,
	Position[50]
};

// Private Vehicles
enum e_player_veh_data
{
	Owner[24],
	Model,
	Price,
	PaintJob,
	Color1,
	Color2,
	Plate[15],
	Locked,
	Mod1,
	Mod2,
	Mod3,
	Mod4,
	Mod5,
	Mod6,
	Mod7,
	Mod8,
	Mod9,
	Mod10,
	Mod11,
	Mod12,
	Mod13,
	Mod14,
	Mod15,
	Mod16,
	Mod17,
	Model2,
	Price2,
	PaintJob2,
	Color12,
	Color22,
	Model3,
	Price3,
	PaintJob3,
	Color13,
	Color23
}
new PlayerInfoVeh[MAX_PLAYERS][2][e_player_veh_data];

// Private Vehicle Components
new pv_spoiler[20][0] =
{
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};
new pv_nitro[3][0] =
{
	{1008},
	{1009},
	{1010}
};
new pv_fbumper[23][0] =
{
	{1117},
	{1152},
	{1153},
	{1155},
	{1157},
	{1160},
	{1165},
	{1166},
	{1169},
	{1170},
	{1171},
	{1172},
	{1173},
	{1174},
	{1175},
	{1179},
	{1181},
	{1182},
	{1185},
	{1188},
	{1189},
	{1190},
	{1191}
};
new pv_rbumper[22][0] =
{
	{1140},
	{1141},
	{1148},
	{1149},
	{1150},
	{1151},
	{1154},
	{1156},
	{1159},
	{1161},
	{1167},
	{1168},
	{1176},
	{1177},
	{1178},
	{1180},
	{1183},
	{1184},
	{1186},
	{1187},
	{1192},
	{1193}
};
new pv_exhaust[28][0] =
{
	{1018},
	{1019},
	{1020},
	{1021},
	{1022},
	{1028},
	{1029},
	{1037},
	{1043},
	{1044},
	{1045},
	{1046},
	{1059},
	{1064},
	{1065},
	{1066},
	{1089},
	{1092},
	{1104},
	{1105},
	{1113},
	{1114},
	{1126},
	{1127},
	{1129},
	{1132},
	{1135},
	{1136}
};
new pv_bventr[2][0] =
{
	{1142},
	{1144}
};
new pv_bventl[2][0] =
{
	{1143},
	{1145}
};
new pv_bscoop[4][0] =
{
	{1004},
	{1005},
	{1011},
	{1012}
};
new pv_roof[17][0] =
{
	{1006},
	{1032},
	{1033},
	{1035},
	{1038},
	{1053},
	{1054},
	{1055},
	{1061},
	{1067},
	{1068},
	{1088},
	{1091},
	{1103},
	{1128},
	{1130},
	{1131}
};
new pv_lskirt[21][0] =
{
	{1007},
	{1026},
	{1031},
	{1036},
	{1039},
	{1042},
	{1047},
	{1048},
	{1056},
	{1057},
	{1069},
	{1070},
	{1090},
	{1093},
	{1106},
	{1108},
	{1118},
	{1119},
	{1133},
	{1122},
	{1134}
};
new pv_rskirt[21][0] =
{
	{1017},
	{1027},
	{1030},
	{1040},
	{1041},
	{1051},
	{1052},
	{1062},
	{1063},
	{1071},
	{1072},
	{1094},
	{1095},
	{1099},
	{1101},
	{1102},
	{1107},
	{1120},
	{1121},
	{1124},
	{1137}
};
new pv_hydraulics[1][0] =
{
	{1087}
};
new pv_base[1][0] =
{
	{1086}
};
new pv_rbbars[4][0] =
{
	{1109},
	{1110},
	{1123},
	{1125}
};
new pv_fbbars[2][0] =
{
	{1115},
	{1116}
};
new pv_wheels[17][0] =
{
	{1025},
	{1073},
	{1074},
	{1075},
	{1076},
	{1077},
	{1078},
	{1079},
	{1080},
	{1081},
	{1082},
	{1083},
	{1084},
	{1085},
	{1096},
	{1097},
	{1098}
};
new pv_lights[2][0] =
{
	{1013},
	{1024}
};

// Server Uptime
new up_days,
	up_hours,
	up_minutes,
	up_seconds;
new hour,
	minute,
	second,
	day,
	month,
	year;

// Vehicle variable defines
new vID,
	vv;

// Spectating
new playerSpectated[MAX_PLAYERS],   // amount of admins spectating the player
	pSpectating[MAX_PLAYERS]; 		// -1: not spectating; otherwise spectated player's ID

/*stock SetPlayerVirtualWorld_Server(playerid, vw)
{
	SetPlayerVirtualWorld(playerid, vw);
	if(GetPVarInt(playerid, "HideObjects"))
	{
		DeletePVar(playerid, "HideObjects");
		Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_OBJECT, 1);
	}
	if(playerSpectated[playerid] > 0)
	{
		vID = (IsPlayerInAnyVehicle(playerid) ? GetPlayerVehicleID(playerid) : INVALID_VEHICLE_ID);
		foreachex(Player, ii)
		{
			if(pSpectating[ii] == playerid && GetPlayerState(ii) == PLAYER_STATE_SPECTATING)
			{
				SetPlayerVirtualWorld(ii, vw);
				if(vID == INVALID_VEHICLE_ID)
					PlayerSpectatePlayer(ii, playerid);
				else
					PlayerSpectateVehicle(ii, vID);
			}
		}
	}
}
#define SetPlayerVirtualWorld SetPlayerVirtualWorld_Server*/


LoadVehicles()
{
	// Stadium
	new stadiumVEH[6];
	stadiumVEH[0] = AddStaticVehicle(522,-1496.0048,1625.4183,1052.0997,268.6247,13,6); // NRG 500
	stadiumVEH[1] = AddStaticVehicle(522,-1495.7233,1622.6516,1052.1017,267.5627,13,6); // NRG 500
	stadiumVEH[2] = AddStaticVehicle(522,-1495.4155,1619.7268,1052.1012,270.7532,13,6); // NRG 500
	stadiumVEH[3] = AddStaticVehicle(522,-1495.6400,1616.9315,1052.0990,268.9297,13,6); // NRG 500
	stadiumVEH[4] = AddStaticVehicle(522,-1495.6876,1614.1799,1052.1058,269.9096,13,6); // NRG 500
	stadiumVEH[5] = AddStaticVehicle(522,-1495.4916,1611.3296,1052.1057,271.6064,13,6); // NRG 500
	LinkVehicleToInterior(stadiumVEH[0], 14);
	LinkVehicleToInterior(stadiumVEH[1], 14);
	LinkVehicleToInterior(stadiumVEH[2], 14);
	LinkVehicleToInterior(stadiumVEH[3],  14);
	LinkVehicleToInterior(stadiumVEH[4], 14);
	LinkVehicleToInterior(stadiumVEH[5], 14);

	// LibertyCity
	new lcVEH[2];
	lcVEH[0] = AddStaticVehicle(579, -738.5291,485.5336,1371.5741,142.6290, 1, 6);
	lcVEH[1] = AddStaticVehicle(480, -751.3954,484.9469,1371.0378,146.3247, 3, 6);
	LinkVehicleToInterior(lcVEH[0], 1);
	LinkVehicleToInterior(lcVEH[1], 1);

	 //dmisland
	veh_iDM[0] = AddStaticVehicle(430,238.9671,3914.5547,-0.6491,265.5235,0,106); // dmisland boat
	veh_iDM[1] = AddStaticVehicle(430,236.7088,3900.4482,-0.0705,264.9725,69,74); // dmisland boat
	SetVehicleVirtualWorld(veh_iDM[0], 5);
	SetVehicleVirtualWorld(veh_iDM[1], 5);

	// VIP Vehicles.
	AddStaticVehicle(541,587.1032,-1892.2131,3.2012,81.9682,0,3); // Stevens Car
	AddStaticVehicle(415,2863.1018,2225.3252,10.6951,176.8708,0,0); // revs house
	AddStaticVehicle(522,2866.4358,2225.3674,10.4995,172.8868,0,6); // revs house
	AddStaticVehicle(415,977.8933,-2130.4436,13.0382,238.5683,1,1); // revs cheetha
	AddStaticVehicle(522,977.3327,-2134.7285,12.7701,239.3091,0,3); // revs nrg

	// CNR
	// Cop Vehicles
	veh_cnr[0] = AddStaticVehicleEx(598, 2285.7664, 2430.2393, 2.9800, 0.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[1] = AddStaticVehicleEx(598, 2282.8796, 2444.7170, 3.0999, 90.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[2] = AddStaticVehicleEx(528, 2296.8323, 2451.4624, 3.2577, 270.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[3] = AddStaticVehicleEx(490, 2307.7488, 2431.1436, 3.3698, 180.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[4] = AddStaticVehicleEx(427, 2298.2749, 2460.4929, 3.2459, 270.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[5] = AddStaticVehicleEx(427, 2298.1682, 2456.1875, 3.2459, 270.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[6] = AddStaticVehicleEx(598, 2321.2974, 2417.7664, 10.4536, 90.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[7] = AddStaticVehicleEx(598, 2314.1763, 2417.7959, 10.4536, 90.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[8] = AddStaticVehicleEx(598, 2307.0156, 2417.6638, 10.4536, 90.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[9] = AddStaticVehicleEx(598, 2328.1362, 2417.8223, 10.4536, 90.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[10] = AddStaticVehicleEx(598, 2273.5405, 2463.0112, 10.5051, 0.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[11] = AddStaticVehicleEx(598, 2273.5466, 2456.9402, 10.5051, 180.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[12] = AddStaticVehicleEx(598, 2277.9021, 2462.9363, 10.5051, 0.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[13] = AddStaticVehicleEx(415, 2282.2024, 2478.4297, 10.5049, 180.0000, 0, 0, RESPAWN_TIME, 1);
	veh_cnr[14] = AddStaticVehicleEx(415, 2277.7954, 2478.4199, 10.5049, 180.0000, 0, 0, RESPAWN_TIME, 1);
	veh_cnr[15] = AddStaticVehicleEx(415, 2256.1121, 2442.0830, 10.5049, 180.0000, 0, 0, RESPAWN_TIME, 1);

	// Robber Vehicles
	veh_cnr[16] = AddStaticVehicleEx(411, 1280.0061, 2695.6333, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[17] = AddStaticVehicleEx(411, 1285.6471, 2695.7056, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[18] = AddStaticVehicleEx(411, 1291.1995, 2695.4111, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[19] = AddStaticVehicleEx(429, 1302.4000, 2695.8667, 10.3835, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[20] = AddStaticVehicleEx(429, 1307.9850, 2695.8362, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[21] = AddStaticVehicleEx(429, 1297.1378, 2695.7798, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[22] = AddStaticVehicleEx(402, 1313.4661, 2695.5857, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[23] = AddStaticVehicleEx(402, 1319.1223, 2695.5850, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[24] = AddStaticVehicleEx(541, 1324.4031, 2695.5764, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[25] = AddStaticVehicleEx(541, 1330.2311, 2695.4443, 10.4000, 180.5275, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[26] = AddStaticVehicleEx(415, 1279.8021, 2648.6233, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[27] = AddStaticVehicleEx(415, 1285.6569, 2648.7864, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[28] = AddStaticVehicleEx(411, 1291.5170, 2648.9045, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[29] = AddStaticVehicleEx(411, 1297.0155, 2648.9978, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[30] = AddStaticVehicleEx(560, 1302.3193, 2649.0042, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[31] = AddStaticVehicleEx(560, 1307.9081, 2649.2947, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[32] = AddStaticVehicleEx(560, 1313.3921, 2649.1892, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[33] = AddStaticVehicleEx(560, 1318.9828, 2649.0398, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[34] = AddStaticVehicleEx(480, 1324.3802, 2648.9885, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[35] = AddStaticVehicleEx(480, 1330.2117, 2649.1299, 10.4000, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[36] = AddStaticVehicleEx(487, 1270.8619, 2693.8574, 10.9383, 270.2402, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[37] = AddStaticVehicleEx(579, 1267.5758, 2665.1628, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[38] = AddStaticVehicleEx(579, 1267.6429, 2660.3694, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[39] = AddStaticVehicleEx(560, 1267.2524, 2680.3022, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[40] = AddStaticVehicleEx(560, 1267.2820, 2684.6252, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[41] = AddStaticVehicleEx(521, 1298.4913, 2669.3699, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[42] = AddStaticVehicleEx(521, 1303.1528, 2669.4624, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[43] = AddStaticVehicleEx(521, 1307.7366, 2669.5107, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[44] = AddStaticVehicleEx(461, 1307.1868, 2676.7117, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[45] = AddStaticVehicleEx(461, 1302.6726, 2676.9072, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[46] = AddStaticVehicleEx(461, 1298.3093, 2677.1536, 10.6000, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[47] = AddStaticVehicleEx(487, 1368.5327, 2652.2581, 11.0928, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[48] = AddStaticVehicleEx(487, 1355.8174, 2651.9392, 11.0928, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[49] = AddStaticVehicleEx(476, 1340.8507, 2649.2686, 11.8100, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[50] = AddStaticVehicleEx(470, 1391.6516, 2672.1060, 10.5461, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[51] = AddStaticVehicleEx(470, 1391.6101, 2677.2314, 10.5461, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);

	// Extra CNR Vehicles
	veh_cnr[52] = AddStaticVehicleEx(429, 2315.6377, 2490.2546, 2.9531,90.5976,0,1, RESPAWN_TIME, 1); // banshee
	veh_cnr[53] = AddStaticVehicleEx(429, 2315.6377, 2485.0505, 2.9531,90.1596,0,1, RESPAWN_TIME, 1); // banshee
	veh_cnr[54] = AddStaticVehicleEx(429, 2315.6377, 2480.0505, 2.9531,90.1596,0,1, RESPAWN_TIME, 1); // banshee
	veh_cnr[55] = AddStaticVehicleEx(411, 2315.6377, 2475.0505, 2.9531,90.1596,0,1, RESPAWN_TIME, 1); // banshee
	veh_cnr[56] = AddStaticVehicleEx(411, 2315.6377, 2470.0505, 2.9531,90.1596,0,1, RESPAWN_TIME, 1); // banshee
	veh_cnr[57] = AddStaticVehicleEx(411, 2315.6377, 2465.0505, 2.9531,90.1596,0,1, RESPAWN_TIME, 1); // banshee

	veh_cnr[58] = AddStaticVehicleEx(415,2273.0752,2408.1292,10.5143,89.6031,0,0, RESPAWN_TIME, 1); // cheetah
	veh_cnr[59] = AddStaticVehicleEx(415,2266.0752,2408.2861,10.5151,89.3953,0,0, RESPAWN_TIME, 1); // cheetah
	veh_cnr[60] = AddStaticVehicleEx(541,2259.0752,2408.2861,10.5151,89.3953,0,1, RESPAWN_TIME, 1); // Bullet
	veh_cnr[61] = AddStaticVehicleEx(541,2252.0752,2408.2861,10.5151,89.3953,0,1, RESPAWN_TIME, 1); // Bullet
	veh_cnr[62] = AddStaticVehicleEx(541,2245.0752,2408.2861,10.5151,89.3953,0,1, RESPAWN_TIME, 1); // Bullet

	veh_cnr[63] = AddStaticVehicleEx(597,2269.0212,2442.7817,10.5881,0.1288,1,1, RESPAWN_TIME); // police car
	veh_cnr[64] = AddStaticVehicleEx(597,2273.5813,2442.8718,10.5879,358.9766,0,0, RESPAWN_TIME); // police car
	veh_cnr[65] = AddStaticVehicleEx(597,2277.0212,2442.7817,10.5881,0.1288,1,1, RESPAWN_TIME); // police car
	veh_cnr[66] = AddStaticVehicleEx(597,2281.5813,2442.8718,10.5879,358.9766,0,0, RESPAWN_TIME); // police car
	veh_cnr[67] = AddStaticVehicleEx(579,2251.9163,2442.2461,10.7527,359.4724,0,0, RESPAWN_TIME, 1); // huntley
	veh_cnr[68] = AddStaticVehicleEx(579,2260.3193,2442.0244,10.7540,359.9288,0,0, RESPAWN_TIME, 1); // huntley
	veh_cnr[69] = AddStaticVehicleEx(580,2260.4109,2477.2659,10.6165,179.2883,0,0, RESPAWN_TIME, 1); // stafford
	veh_cnr[70] = AddStaticVehicleEx(523,2256.5503,2477.2349,10.3924,178.7605,130,151, RESPAWN_TIME); // Police Bike
	veh_cnr[71] = AddStaticVehicleEx(523,2254.0439,2476.5071,10.3912,179.8921,130,151, RESPAWN_TIME); // Police Bike
	veh_cnr[72] = AddStaticVehicleEx(523,2251.2036,2476.9832,10.3941,178.4231,130,151, RESPAWN_TIME); // Police Bike
	veh_cnr[73] = AddStaticVehicleEx(522,2311.9348,2404.8508,10.3843,90.1988,0,154, RESPAWN_TIME, 1); // Police NRG
	veh_cnr[74] = AddStaticVehicleEx(522,2307.3904,2404.8455,10.3948,90.1990,0,154, RESPAWN_TIME, 1); // Police NRG
	veh_cnr[75] = AddStaticVehicleEx(522,2301.8076,2404.8271,10.3920,90.1989,0,154, RESPAWN_TIME, 1); // Police NRG
	veh_cnr[76] = AddStaticVehicleEx(522,2308.5410,2424.6011,10.3888,179.2661,0,1, RESPAWN_TIME, 1); // Police NRG
	veh_cnr[78] = AddStaticVehicleEx(490,2303.2266,2430.8889,3.4019,1.0985,0,0, RESPAWN_TIME); // fbi rancher
	veh_cnr[79] = AddStaticVehicleEx(490,2298.8901,2430.9990,3.4020,0.3266,0,0, RESPAWN_TIME); // fbi rancher
	veh_cnr[80] = AddStaticVehicleEx(497,2305.5271,2384.1899,10.9974,1.0422,1,0, RESPAWN_TIME); // Police Heli
	veh_cnr[81] = AddStaticVehicleEx(497,2332.3037,2389.5691,10.9974,357.4843,1,0, RESPAWN_TIME, 1); // Police Heli
	veh_cnr[82] = AddStaticVehicleEx(500,2273.3101,2425.0483,10.9230,180.0461,0,0, RESPAWN_TIME, 1); // Police Mesa
	veh_cnr[83] = AddStaticVehicleEx(429, 2100.7373, 1408.8678, 10.4270, 0.0000, -1, -1, RESPAWN_TIME, 1);
	veh_cnr[84] = AddStaticVehicleEx(522,2315.1082,2461.6951,2.8463,90.7273,0,154, RESPAWN_TIME, 1); // Police NRG
	veh_cnr[85] = AddStaticVehicleEx(522,2315.1082,2459.3013,2.8463,90.7273,0,154, RESPAWN_TIME, 1); // Police NRG
	veh_cnr[86] = AddStaticVehicleEx(522,2315.1082,2466.6951,2.8463,90.7273,0,154, RESPAWN_TIME, 1); // Police NRG

	// CNR LVAir Vehicles.
	veh_cnr[87] = AddStaticVehicleEx(411, 1309.5747, 1278.8414, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[88] = AddStaticVehicleEx(411, 1312.8395, 1278.8396, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[89] = AddStaticVehicleEx(429, 1315.9796, 1278.9790, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[90] = AddStaticVehicleEx(429, 1319.1512, 1279.0945, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[91] = AddStaticVehicleEx(415, 1322.2698, 1279.0577, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[92] = AddStaticVehicleEx(415, 1325.5930, 1279.2817, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[93] = AddStaticVehicleEx(451, 1328.8311, 1279.0909, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[94] = AddStaticVehicleEx(541, 1282.9833, 1287.7239, 10.5422, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[95] = AddStaticVehicleEx(541, 1282.9558, 1290.8872, 10.5422, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[96] = AddStaticVehicleEx(411, 1283.0532, 1294.1323, 10.5422, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[97] = AddStaticVehicleEx(411, 1283.0544, 1297.4629, 10.5422, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[98] = AddStaticVehicleEx(506, 1283.2983, 1300.6232, 10.5422, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[99] = AddStaticVehicleEx(601, 1285.1306, 1304.5479, 10.5422, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[100] = AddStaticVehicleEx(601, 1285.0521, 1308.4935, 10.5422, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[101] = AddStaticVehicleEx(490, 1337.5485, 1269.9567, 10.9254, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[102] = AddStaticVehicleEx(522, 1307.0708, 1278.8146, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[103] = AddStaticVehicleEx(522, 1305.7250, 1278.7140, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[104] = AddStaticVehicleEx(522, 1307.0139, 1283.0350, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[105] = AddStaticVehicleEx(522, 1305.6306, 1283.0891, 10.5105, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[106] = AddStaticVehicleEx(497, 1343.3812, 1274.6497, 10.9254, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[107] = AddStaticVehicleEx(497, 1355.7439, 1274.8292, 10.9254, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[108] = AddStaticVehicleEx(476, 1290.3831, 1324.4240, 11.9787, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[109] = AddStaticVehicleEx(476, 1290.0220, 1362.5779, 11.9787, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[110] = AddStaticVehicleEx(476, 1287.8682, 1382.6012, 11.9787, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[111] = AddStaticVehicleEx(476, 1287.7076, 1394.9185, 11.9787, 271.1091, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);
	veh_cnr[112] = AddStaticVehicleEx(490, 1333.1863, 1269.9811, 10.9254, 0.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME, 1);

	// Extra Cnr Vehicles (LV)
	veh_cnr[113] = AddStaticVehicleEx(402, 2103.9365, 1409.2023, 10.4270, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[114] = AddStaticVehicleEx(541, 2107.3374, 1408.7982, 10.4270, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[115] = AddStaticVehicleEx(415, 2110.4185, 1408.8940, 10.4270, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[116] = AddStaticVehicleEx(411, 2113.6597, 1408.6208, 10.4270, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[117] = AddStaticVehicleEx(451, 2116.7991, 1408.6875, 10.4270, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[118] = AddStaticVehicleEx(409, 2113.2688, 1446.2333, 10.5323, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[119] = AddStaticVehicleEx(409, 2103.4111, 1446.2007, 10.5323, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[120] = AddStaticVehicleEx(411, 2100.7563, 1397.7274, 10.4270, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[121] = AddStaticVehicleEx(503, 2103.9639, 1397.4199, 10.4270, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[122] = AddStaticVehicleEx(451, 2107.2268, 1397.4266, 10.4270, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[123] = AddStaticVehicleEx(506, 2110.3989, 1397.8550, 10.4270, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[124] = AddStaticVehicleEx(477, 2113.5391, 1397.8296, 10.4270, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[125] = AddStaticVehicleEx(415, 2116.7644, 1397.8007, 10.4270, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[126] = AddStaticVehicleEx(461, 2142.4116, 1408.1587, 10.3220, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[127] = AddStaticVehicleEx(461, 2145.6335, 1408.1178, 10.3220, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[128] = AddStaticVehicleEx(461, 2148.9055, 1408.1516, 10.3220, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[129] = AddStaticVehicleEx(461, 2142.2683, 1398.5519, 10.3220, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[130] = AddStaticVehicleEx(461, 2145.5781, 1398.6636, 10.3220, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[131] = AddStaticVehicleEx(461, 2148.6086, 1398.9231, 10.3220, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[132] = AddStaticVehicleEx(560, 2123.0803, 1409.1115, 10.4085, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[133] = AddStaticVehicleEx(560, 2126.3201, 1409.3019, 10.4085, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[134] = AddStaticVehicleEx(411, 2040.1135, 1026.3641, 10.4711, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[135] = AddStaticVehicleEx(415, 2040.0099, 1033.9723, 10.4711, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[136] = AddStaticVehicleEx(541, 2039.9918, 1040.8757, 10.4711, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[137] = AddStaticVehicleEx(541, 2075.0894, 990.1443, 10.2643, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[138] = AddStaticVehicleEx(415, 2075.0662, 998.1401, 10.2643, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[139] = AddStaticVehicleEx(415, 2130.5500, 886.0754, 10.5140, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[140] = AddStaticVehicleEx(541, 2130.5190, 889.5998, 10.5140, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[141] = AddStaticVehicleEx(521, 2131.3472, 892.6055, 10.5140, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[142] = AddStaticVehicleEx(521, 2131.4673, 896.0662, 10.5140, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[143] = AddStaticVehicleEx(411, 2394.2163, 987.0877, 10.5186, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[144] = AddStaticVehicleEx(541, 2394.1362, 994.4210, 10.5186, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[145] = AddStaticVehicleEx(560, 2040.1885, 1698.3335, 10.3569, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[146] = AddStaticVehicleEx(541, 2040.2072, 1691.5651, 10.3569, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[147] = AddStaticVehicleEx(411, 2040.0759, 1685.2753, 10.3569, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[148] = AddStaticVehicleEx(415, 2039.9205, 1678.0175, 10.3569, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[149] = AddStaticVehicleEx(521, 2154.9229, 2204.1733, 10.1553, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[150] = AddStaticVehicleEx(415, 2154.9673, 2197.6487, 10.3573, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[151] = AddStaticVehicleEx(411, 2154.9883, 2189.4622, 10.3573, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[152] = AddStaticVehicleEx(415, 2108.0957, 2206.1814, 10.5125, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[153] = AddStaticVehicleEx(541, 2104.5874, 2206.2532, 10.5125, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[154] = AddStaticVehicleEx(521, 2195.4246, 2502.6604, 10.3253, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[155] = AddStaticVehicleEx(411, 2192.0562, 2502.7839, 10.4263, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[156] = AddStaticVehicleEx(415, 2188.7148, 2502.7351, 10.4263, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[157] = AddStaticVehicleEx(415, 1901.7208, 2437.2273, 10.7268, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[158] = AddStaticVehicleEx(411, 1901.8853, 2432.8225, 10.7268, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[159] = AddStaticVehicleEx(415, 2042.2969, 2468.9534, 10.4520, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[160] = AddStaticVehicleEx(541, 2046.4966, 2469.0774, 10.4520, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[161] = AddStaticVehicleEx(411, 2050.4756, 2468.9180, 10.4520, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[162] = AddStaticVehicleEx(521, 2048.7249, 2480.6021, 10.3170, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[163] = AddStaticVehicleEx(429, 2103.8013, 2099.0564, 10.4258, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[164] = AddStaticVehicleEx(415, 2103.9055, 2036.5156, 10.4258, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[165] = AddStaticVehicleEx(411, 1921.1913, 960.6904, 10.4189, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[166] = AddStaticVehicleEx(487, 2248.5244, 561.5898, 8.3046, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[167] = AddStaticVehicleEx(541, 2626.6692, 1136.5547, 10.4337, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[168] = AddStaticVehicleEx(415, 2359.9810, 2118.7295, 10.3560, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[169] = AddStaticVehicleEx(411, 2559.1348, 2059.4570, 10.5310, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[170] = AddStaticVehicleEx(415, 2563.4094, 2059.5325, 10.5310, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[171] = AddStaticVehicleEx(415, 2465.1418, 2495.9724, 10.5130, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[172] = AddStaticVehicleEx(541, 2177.6233, 1856.3647, 10.3210, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[173] = AddStaticVehicleEx(411, 2352.3940, 1408.7013, 42.4236, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[174] = AddStaticVehicleEx(420, 1726.4780, 1514.6333, 10.3142, 176.7064, -1, -1, RESPAWN_TIME);
	veh_cnr[175] = AddStaticVehicleEx(420, 1726.0718, 1507.9292, 10.3142, 176.7064, -1, -1, RESPAWN_TIME);
	veh_cnr[176] = AddStaticVehicleEx(541, 1613.2184, 2190.0691, 10.6235, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[177] = AddStaticVehicleEx(415, 1613.1095, 2193.4602, 10.6235, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[178] = AddStaticVehicleEx(521, 1613.1432, 2196.5708, 10.6235, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[179] = AddStaticVehicleEx(411, 1904.5020, 2580.9487, 10.6629, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[180] = AddStaticVehicleEx(415, 1891.3849, 2640.4014, 10.5232, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[181] = AddStaticVehicleEx(415, 2370.6016, 2578.9448, 10.6252, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[182] = AddStaticVehicleEx(411, 1464.5872, 2781.9956, 10.2806, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[183] = AddStaticVehicleEx(487, 1054.8546, 2914.8301, 52.1418, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[184] = AddStaticVehicleEx(415, 970.7299, 2171.4565, 10.8280, 180.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[185] = AddStaticVehicleEx(573, 1024.0416, 2112.0227, 11.1962, 0.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[186] = AddStaticVehicleEx(415, 2170.8064, 1973.5698, 10.5298, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[187] = AddStaticVehicleEx(411, 2170.8379, 1977.3904, 10.5298, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[188] = AddStaticVehicleEx(541, 2170.6355, 1981.3920, 10.5298, 270.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[189] = AddStaticVehicleEx(402, 2185.7629, 1974.9166, 10.5298, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[190] = AddStaticVehicleEx(521, 2185.8025, 1979.0999, 10.5298, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[191] = AddStaticVehicleEx(521, 2185.8909, 1983.3361, 10.5298, 90.0000, -1, -1, RESPAWN_TIME);
	veh_cnr[192] = AddStaticVehicleEx(415, 2891.4436, 2379.5432, 10.5303, 90.0000, -1, -1, RESPAWN_TIME);

	// CnR Vehicles Robber Spawn 2
	veh_cnr[193] = AddStaticVehicleEx(411, 2765.0442, 1265.5535, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[194] = AddStaticVehicleEx(415, 2765.0293, 1268.8038, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[196] = AddStaticVehicleEx(429, 2765.1980, 1272.0405, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[197] = AddStaticVehicleEx(541, 2765.4146, 1275.2354, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[198] = AddStaticVehicleEx(559, 2765.4106, 1278.4106, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[199] = AddStaticVehicleEx(451, 2765.4412, 1281.5879, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[200] = AddStaticVehicleEx(411, 2765.3840, 1284.7849, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[201] = AddStaticVehicleEx(415, 2765.3730, 1288.0205, 10.4536, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[202] = AddStaticVehicleEx(461, 2784.5842, 1294.2311, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[203] = AddStaticVehicleEx(461, 2786.0305, 1294.2556, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[204] = AddStaticVehicleEx(521, 2787.7935, 1294.3330, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[205] = AddStaticVehicleEx(521, 2789.2507, 1294.3242, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[206] = AddStaticVehicleEx(468, 2790.9614, 1294.3700, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[207] = AddStaticVehicleEx(468, 2792.2700, 1294.3771, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[208] = AddStaticVehicleEx(521, 2795.6921, 1294.3262, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[209] = AddStaticVehicleEx(461, 2794.2910, 1294.3749, 10.3363, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[210] = AddStaticVehicleEx(541, 2772.3320, 1295.2655, 10.4250, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[211] = AddStaticVehicleEx(560, 2775.5068, 1295.1967, 10.4250, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[212] = AddStaticVehicleEx(560, 2781.9297, 1295.2877, 10.4250, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[213] = AddStaticVehicleEx(411, 2778.6670, 1295.3494, 10.4250, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[214] = AddStaticVehicleEx(470, 2831.0859, 1267.6276, 10.4750, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[215] = AddStaticVehicleEx(470, 2831.1555, 1263.3196, 10.4750, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[216] = AddStaticVehicleEx(579, 2830.9846, 1244.2028, 10.5850, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[217] = AddStaticVehicleEx(579, 2819.0112, 1269.6533, 10.4250, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[218] = AddStaticVehicleEx(579, 2830.8774, 1240.2238, 10.5850, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[219] = AddStaticVehicleEx(476, 2846.3262, 1348.4125, 11.9002, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[220] = AddStaticVehicleEx(476, 2846.2710, 1360.7991, 11.9002, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[221] = AddStaticVehicleEx(487, 2837.8398, 1369.9240, 10.8845, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[222] = AddStaticVehicleEx(487, 2824.4790, 1369.9354, 10.8845, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[223] = AddStaticVehicleEx(487, 2811.0303, 1369.8270, 10.8845, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[224] = AddStaticVehicleEx(560, 2804.8704, 1326.1536, 10.4250, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[225] = AddStaticVehicleEx(415, 2804.8391, 1329.4180, 10.4250, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[226] = AddStaticVehicleEx(411, 2804.8352, 1332.5953, 10.4250, 270.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[227] = AddStaticVehicleEx(437, 2805.3179, 1341.8086, 11.0727, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[228] = AddStaticVehicleEx(579, 2818.8008, 1311.1056, 10.4250, 90.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);
	veh_cnr[229] = AddStaticVehicleEx(437, 2805.3098, 1356.4868, 11.0727, 180.0000, ServerColors[random(8)], ServerColors[random(8)], RESPAWN_TIME);

	for(new iit = 0; iit < sizeof(veh_cnr); iit++)
	{
		SetVehicleVirtualWorld(veh_cnr[iit], 20);
	}

	// TankDM (inside SF bridge) (5 vehicles)
	veh_TankDM[0] = AddStaticVehicleEx(432, -2689.939, 1905.828, 57.641, 0.0, -1, -1, RESPAWN_TIME);
	veh_TankDM[1] = AddStaticVehicleEx(432, -2672.674, 1862.018, 59.182, 0.0, -1, -1, RESPAWN_TIME);
	veh_TankDM[2] = AddStaticVehicleEx(432, -2688.304, 1636.353, 58.500, 0.0, -1, -1, RESPAWN_TIME);
	veh_TankDM[3] = AddStaticVehicleEx(432, -2687.673, 1664.446, 59.029, 0.0, -1, -1, RESPAWN_TIME);
	veh_TankDM[4] = AddStaticVehicleEx(432, -2669.491, 1713.949, 59.917, 0.0, -1, -1, RESPAWN_TIME);
	for(new iit = 0; iit < sizeof(veh_TankDM); iit++)
	{
		SetVehicleVirtualWorld(veh_TankDM[iit], 5);
	}


	// WAR
	veh_War[0] = AddStaticVehicleEx(432, 279.956, 2023.419, 17.740, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[1] = AddStaticVehicleEx(432, 346.640, 2027.735, 22.733, 161.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[2] = AddStaticVehicleEx(432, 182.539, 1926.751, 17.993, 161.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[3] = AddStaticVehicleEx(432, 209.315, 1837.491, 17.740, 181.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[4] = AddStaticVehicleEx(432, 124.917, 1807.932, 17.740, 298.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[5] = AddStaticVehicleEx(432, 103.167, 1932.212, 18.555, 215.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[6] = AddStaticVehicleEx(432, 274.210, 1872.511, 17.747, 139.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[7] = AddStaticVehicleEx(425, 273.064, 1934.610, 17.740, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[8] = AddStaticVehicleEx(425, 367.779, 2028.651, 23.484, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[9] = AddStaticVehicleEx(425, 180.722, 1835.501, 24.093, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[10] = AddStaticVehicleEx(425, 251.342, 1881.802, 21.492, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[11] = AddStaticVehicleEx(425, 359.894, 1922.685, 18.492, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[12] = AddStaticVehicleEx(520, 236.012, 1810.887, 18.492, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[13] = AddStaticVehicleEx(520, 312.458, 1796.301, 18.560, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[14] = AddStaticVehicleEx(520, 283.530, 1989.224, 18.560, 271.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[15] = AddStaticVehicleEx(520, 283.823, 1955.214, 18.560, 271.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[16] = AddStaticVehicleEx(520, 167.582, 1809.466, 18.560, 271.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[17] = AddStaticVehicleEx(470, 209.595, 1932.297, 24.162, 271.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[18] = AddStaticVehicleEx(470, 167.190, 1834.750, 17.751, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[19] = AddStaticVehicleEx(470, 322.496, 1844.586, 17.751, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[20] = AddStaticVehicleEx(470, 190.912, 2073.601, 22.754, 214.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[21] = AddStaticVehicleEx(470, 127.990, 1933.860, 19.363, 214.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[22] = AddStaticVehicleEx(470, 211.451, 1917.771, 17.751, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[23] = AddStaticVehicleEx(470, 221.226, 1917.771, 17.751, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[24] = AddStaticVehicleEx(470, 294.087, 1900.686, 17.751, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	veh_War[25] = AddStaticVehicleEx(470, 253.094, 1835.335, 17.751, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	for(new iit = 0; iit < sizeof(veh_War); iit++)
	{
		SetVehicleVirtualWorld(veh_War[iit], 5);
	}

	// Dam Stunts
	AddStaticVehicleEx(522,-491.2772217,2216.2446289,45.1934509,87.9949951, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-491.2992554,2218.7441406,45.1934509,87.9949951, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-491.3218994,2221.2958984,45.1934509,87.9949951, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-491.3446655,2223.8457031,45.1934509,87.9949951, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(481,-493.4183960,2233.5634766,45.1418495,90.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //BMX
	AddStaticVehicleEx(481,-493.5036621,2236.0354004,45.1418495,90.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //BMX
	AddStaticVehicleEx(411,-498.8699341,2264.0773926,45.3330727,180.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(411,-503.8742676,2264.0927734,45.3330727,180.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(451,-508.8750000,2263.8249512,45.2974472,180.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Turismo
	AddStaticVehicleEx(451,-513.9135132,2263.8447266,45.2974472,180.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Turismo
	AddStaticVehicleEx(495,-518.8936157,2263.4804688,46.0931473,180.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Sandking
	AddStaticVehicleEx(495,-523.8648071,2263.4228516,46.0931473,180.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Sandking
	AddStaticVehicleEx(415,-491.2794189,2213.8488770,45.3047180,90.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Cheetah
	AddStaticVehicleEx(541,-491.8936462,2210.1086426,45.2330742,90.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Bullet
	AddStaticVehicleEx(480,-495.0150757,2239.2229004,45.3830719,90.0000000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); //Comet

	// Train/Trams
	AddStaticVehicle(538,1462.0745,2630.8787,10.8203,200.0,-1,-1); // LV passenger
	AddStaticVehicle(538,-1942.7950,168.4164,27.0006,200.0,-1,-1); // SF passenger
	AddStaticVehicle(537,1700.7551,-1953.6531,14.8756,200.0,-1,-1); // LS passenger
	Tram[0] = AddStaticVehicle(449,-2004.1682,278.8217,33.6609,358.6192,ServerColors[random(8)], ServerColors[random(8)]); // Tram in front of Wangs
	Tram[1] = AddStaticVehicle(449,-1619.6893,1232.5928,7.4973,44.9046,ServerColors[random(8)], ServerColors[random(8)]); // Tram in front of Ottos
	Tram[2] = AddStaticVehicle(449,-2056.3936,1287.1257,7.7827,144.0699,ServerColors[random(8)], ServerColors[random(8)]); // Tram Near SF Stunt Zone

	// Farm
	AddStaticVehicleEx(522,79.7956696,116.8847046,2.3713145,148.0000000,-1,-1,30); //NRG-500
	AddStaticVehicleEx(522,81.8939056,115.5258484,2.3713145,147.9967651,-1,-1,30); //NRG-500
	AddStaticVehicleEx(522,88.6511917,111.1517029,2.3713145,147.9913330,-1,-1,30); //NRG-500
	AddStaticVehicleEx(522,90.7704544,109.7799072,2.3713145,147.9913330,-1,-1,30); //NRG-500
	AddStaticVehicleEx(481,77.6845169,118.3319550,2.3197131,150.0000000,-1,-1,30); //BMX
	AddStaticVehicleEx(481,93.0934067,108.7277298,2.3197131,149.9963379,-1,-1,30); //BMX
	AddStaticVehicleEx(495,73.6699448,119.0991287,3.0792620,148.0000000,-1,-1,30); //Sandking
	AddStaticVehicleEx(495,95.4352646,105.4710083,3.0792620,147.9967651,-1,-1,30); //Sandking
	AddStaticVehicleEx(415,64.9105377,111.8877563,2.4825814,238.0000000,-1,-1,30); //Cheetah
	AddStaticVehicleEx(415,92.8306580,94.4819031,2.4825814,57.9965820,-1,-1,30); //Cheetah
	AddStaticVehicleEx(451,90.1114960,90.4894104,2.4753091,58.0000000,-1,-1,30); //Turismo
	AddStaticVehicleEx(451,62.3301849,107.8099518,2.4753091,237.9968262,-1,-1,30); //Turismo
	AddStaticVehicleEx(411,87.7658005,86.4652786,2.5109367,58.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,59.9682312,103.8265457,2.5109367,237.9968262,-1,-1,30); //Infernus
	AddStaticVehicleEx(541,57.1962776,99.6879654,2.4109371,238.0000000,-1,-1,30); //Bullet
	AddStaticVehicleEx(541,85.2866211,82.1267853,2.4109371,57.9965820,-1,-1,30); //Bullet
	AddStaticVehicleEx(522,106.9549332,-100.2243042,1.8356625,57.9998779,-1,-1,30); //NRG-500
	AddStaticVehicleEx(522,108.9236679,-97.0363388,1.8356625,57.9968262,-1,-1,30); //NRG-500
	AddStaticVehicleEx(522,94.9750519,-119.1696777,1.8356625,57.9968262,-1,-1,30); //NRG-500
	AddStaticVehicleEx(522,93.0343323,-122.4666748,1.8356625,57.9968262,-1,-1,30); //NRG-500
	AddStaticVehicleEx(471,110.8960953,-93.6875687,1.7502851,58.0000000,-1,-1,30); //Quad
	AddStaticVehicleEx(471,90.9076080,-125.3042984,1.7502851,57.9968262,-1,-1,30); //Quad
	AddStaticVehicleEx(495,86.8962860,-130.9386902,2.7353592,0.0000000,-1,-1,30); //Sandking
	AddStaticVehicleEx(495,114.7697983,-86.9463425,2.7353592,115.9998779,-1,-1,30); //Sandking
	AddStaticVehicleEx(411,80.1561356,-127.4825058,1.9752849,328.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,108.0057907,-83.1710358,1.9752849,147.9967041,-1,-1,30); //Infernus
	AddStaticVehicleEx(451,75.6285019,-122.5822678,1.9396572,298.0000000,-1,-1,30); //Turismo
	AddStaticVehicleEx(451,101.6180725,-81.2895508,1.9396572,177.9979858,-1,-1,30); //Turismo

	// Funroad
	AddStaticVehicleEx(411,2688.3955078,-4343.5302734,12.4632730,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,2684.2700195,-4343.5322266,12.4632730,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,2680.3955078,-4343.5771484,12.4632730,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,2676.3955078,-4343.4599609,12.4632730,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,2672.4951172,-4343.4365234,12.4632730,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,2668.9345703,-4343.4111328,12.4632730,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,2665.8444824,-4343.3896484,12.4632730,0.0000000,-1,-1,30); //Infernus
	AddStaticVehicleEx(411,2662.3955078,-4343.4716797,12.4632730,0.0000000,-1,-1,30); //Infernus

	// SkyRoad
	AddStaticVehicleEx(411,2995.7117,-1438.0516,1243.8635,190.1255,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2992.5386,-1438.6368,1243.8635,190.3343,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2989.2190,-1439.2253,1243.8635,191.8621,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2986.2188,-1439.7852,1243.8635,190.4824,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2983.0330,-1440.3347,1243.8635,190.6846,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2979.9634,-1440.9570,1243.8635,190.6507,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2976.7375,-1441.6381,1243.8635,191.1150,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2973.7603,-1442.1237,1243.8635,190.2113,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2970.4902,-1442.7092,1243.8635,189.5898,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2967.2305,-1443.3925,1243.8635,190.0178,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2964.2310,-1443.7775,1243.8635,189.4281,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2961.0303,-1444.4191,1243.8635,189.7177,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2994.3779,-1430.1746,1243.8635,10.1458,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2991.1680,-1430.7502,1243.8635,11.1135,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2987.9287,-1431.1223,1243.8635,9.2166,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2984.8699,-1431.5933,1243.8635,9.8497,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2981.7366,-1432.1873,1243.8635,10.0225,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2978.4426,-1432.8026,1243.8635,10.6514,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2975.2898,-1433.2393,1243.8635,9.5927,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2972.2881,-1433.5935,1243.8635,8.0244,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2969.0051,-1434.2621,1243.8635,10.8093,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2965.7427,-1434.8345,1243.8635,9.8446,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2962.6904,-1435.3536,1243.8635,9.4565,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,2959.4126,-1435.9664,1243.8635,9.5607,randomColors[random(23)], randomColors[random(23)],RESPAWN_TIME); // Infernus´

	// Trackmania 2
	AddStaticVehicleEx(411,-1914.40002441,6623.29980469,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.30004883,6629.79980469,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.40002441,6636.20019531,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.30004883,6642.39990234,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.30004883,6649.00000000,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.19995117,6655.39990234,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.30004883,6661.60009766,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.30004883,6668.20019531,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.30004883,6674.50000000,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1914.40002441,6617.00000000,11.60000038,90.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.69995117,6613.89990234,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.59997559,6620.29980469,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.80004883,6626.50000000,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.59997559,6633.20019531,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.59997559,6639.20019531,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.40002441,6645.70019531,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.30004883,6652.10009766,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.00000000,6658.50000000,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.00000000,6665.10009766,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411,-1943.00000000,6671.29980469,11.60000038,270.0,randomColors[random(23)],-1,RESPAWN_TIME); // Infernus


	//Planes Lot
	AddStaticVehicle(487, 1775.515625, -3127.157470, 24.314222, 87.041519, randomColors[random(23)], -1); //Maverick
	AddStaticVehicle(583, 1748.381835, -3266.477539, 18.280221, 269.249511, randomColors[random(23)], -1); //Tug
	AddStaticVehicle(583, 1748.454467, -3262.892822, 18.280109, 267.842590, randomColors[random(23)], -1); //Tug
	AddStaticVehicle(583, 1748.645751, -3259.749023, 18.280176, 268.477874, randomColors[random(23)], -1); //Tug
	AddStaticVehicle(583, 1748.697753, -3256.174072, 18.280422, 271.067016, randomColors[random(23)], -1); //Tug
	AddStaticVehicle(487, 1762.926879, -3237.613525, 22.791439, 218.349075, randomColors[random(23)], -1); //Maverick
	AddStaticVehicle(469, 2097.583251, -2937.364746, 21.647428, 182.673400, randomColors[random(23)], -1); //Seasparrow
	AddStaticVehicle(469, 2115.727050, -2939.081542, 21.648586, 184.363800, randomColors[random(23)], -1); //Seasparrow
	AddStaticVehicle(592, 1777.456665, -3189.490966, 19.934438, 269.277435, randomColors[random(23)], -1); //Andromada
	AddStaticVehicle(513, 1762.183227, -3092.843994, 20.144132, 270.338043, randomColors[random(23)], -1); //Stuntplane
	AddStaticVehicle(513, 1758.548706, -3069.816894, 20.149263, 270.262939, randomColors[random(23)], -1); //Stuntplane
	AddStaticVehicle(513, 1754.716308, -3043.984130, 20.146921, 269.530731, randomColors[random(23)], -1); //Stuntplane
	AddStaticVehicle(476, 1752.280029, -3001.200195, 19.491935, 271.028625, randomColors[random(23)], -1); //Rustler
	AddStaticVehicle(476, 1752.445434, -3014.474121, 19.488981, 271.751403, randomColors[random(23)], -1); //Rustler
	AddStaticVehicle(476, 1752.237670, -3028.584716, 19.485055, 267.497802, randomColors[random(23)], -1); //Rustler
	AddStaticVehicle(513, 1752.740600, -2987.962646, 19.316184, 270.296234, randomColors[random(23)], -1); //Stuntplane
	AddStaticVehicle(487, 1813.982, -3263.537, 19.910, 0.0, randomColors[random(23)], -1); //Maverick
	AddStaticVehicle(487, 1825.732, -3263.537, 19.910, 0.0, randomColors[random(23)], -1); //Maverick
	AddStaticVehicle(487, 1837.482, -3263.537, 19.910, 0.0, randomColors[random(23)], -1); //Maverick
	AddStaticVehicle(512, 1849.732, -3263.537, 19.910, 0.0, randomColors[random(23)], -1); //Cropduster
	AddStaticVehicle(512, 1861.732, -3263.537, 19.910, 0.0, randomColors[random(23)], -1); //Cropduster
	AddStaticVehicle(512, 1873.707, -3263.537, 19.910, 0.0, randomColors[random(23)], -1); //Cropduster
	AddStaticVehicle(476, 1885.724, -3264.079, 19.374, 0.0, randomColors[random(23)], -1); //Rustler
	AddStaticVehicle(476, 1897.724, -3264.079, 19.374, 0.0, randomColors[random(23)], -1); //Rustler
	AddStaticVehicle(476, 1909.724, -3264.079, 19.374, 0.0, randomColors[random(23)], -1); //Rustler
	AddStaticVehicle(593, 1923.572, -3264.189, 19.290, 0.0, randomColors[random(23)], -1); //Dodo
	AddStaticVehicle(593, 1936.544, -3264.236, 19.290, 0.0, randomColors[random(23)], -1); //Dodo
	AddStaticVehicle(593, 1949.544, -3264.236, 19.290, 0.0, randomColors[random(23)], -1); //Dodo
	AddStaticVehicle(519, 1972.787, -3264.055, 19.789, 0.0, randomColors[random(23)], -1); //Shamal
	AddStaticVehicle(519, 1994.037, -3264.055, 19.789, 0.0, randomColors[random(23)], -1); //Shamal
	AddStaticVehicle(519, 2014.937, -3263.831, 19.789, 0.0, randomColors[random(23)], -1); //Shamal
	AddStaticVehicle(553, 2049.517, -3259.214, 21.024, 0.0, randomColors[random(23)], -1); //Nevada
	AddStaticVehicle(553, 2085.343, -3258.691, 21.024, 0.0, randomColors[random(23)], -1); //Nevada
	AddStaticVehicle(553, 2120.093, -3258.691, 21.024, 0.0, randomColors[random(23)], -1); //Nevada
	AddStaticVehicle(553, 2153.593, -3258.691, 21.024, 0.0, randomColors[random(23)], -1); //Nevada

	//Grove
	AddStaticVehicle(451, 2517.3938, -1666.5775, 13.7838, 83.0626, 16, 16); //Turismo
	AddStaticVehicle(579, 2473.2749, -1690.8932, 13.4422, 359.2218, 16, 16); //Huntley
	AddStaticVehicle(411, 2493.3135, -1655.6705, 13.0961, 89.3216, 16, 16); //Infernus

	//disney
	AddStaticVehicleEx(411,362.3610,619.6272,19.0,226.5751,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(411,365.1174,622.5909,19.0,226.3374,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(411,367.9186,625.4645,19.0,225.5066,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(411,370.6541,628.2816,19.0,225.7116,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(411,373.6037,631.2492,19.0,226.8734,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(411,376.6400,634.1841,19.0,225.9090,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(411,379.6424,637.2258,19.0,224.2085,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(411,382.5711,640.0408,19.0,225.1949,randomColors[random(23)],-1,RESPAWN_TIME); // Inf
	AddStaticVehicleEx(451,396.6397,609.8585,19.0,14.5789,randomColors[random(23)],-1,RESPAWN_TIME); // Turismo
	AddStaticVehicleEx(451,393.7251,606.8213,19.0,16.1906,randomColors[random(23)],-1,RESPAWN_TIME); // Turismo
	AddStaticVehicleEx(451,390.9021,603.9765,19.0,14.7155,randomColors[random(23)],-1,RESPAWN_TIME); // Turismo
	AddStaticVehicleEx(451,387.9419,600.9276,19.0,15.3427,randomColors[random(23)],-1,RESPAWN_TIME); // Turismo
	AddStaticVehicleEx(451,385.0202,598.0220,19.0,15.2365,randomColors[random(23)],-1,RESPAWN_TIME); // Turismo

	//cityjump
	AddStaticVehicle(411,1017.0259,-715.0996,860.0897,274.0000,6,255); // cityjump
	AddStaticVehicle(411,1017.3765,-711.6907,860.0887,255.5423,132,255); // cityjump
	AddStaticVehicle(411,1020.0477,-708.2253,860.0872,222.1614,131,255); // cityjump
	AddStaticVehicle(411,1023.4238,-705.9216,860.0897,202.7478,150,255); // cityjump
	AddStaticVehicle(411,1027.2705,-706.9785,860.0897,156.7459,148,255); // cityjump

	//quadrace
	AddStaticVehicle(471,1986.5553,-810.1364,130.4952,359.6447,149,255); // quadrace
	AddStaticVehicle(471,1992.9823,-809.9624,130.3314,359.1084,149,255); // quadrace
	AddStaticVehicle(471,1984.7711,-810.2634,130.4818,2.9290,154,255); // quadrace
	AddStaticVehicle(471,1990.6604,-809.6654,130.4895,359.7585,236,255); // quadrace

	//racemap2
	AddStaticVehicle(411,2748.9756,1958.8330,5269.4824,180.0000,148,255); // racemap
	AddStaticVehicle(411,2745.4009,1958.8330,5269.4824,180.0000,151,255); // racemap
	AddStaticVehicle(411,2741.7202,1958.8328,5269.4824,180.0703,147,255); // racemap
	AddStaticVehicle(411,2738.3152,1958.8414,5269.4741,179.6663,155,255); // racemap
	AddStaticVehicle(411,2734.7180,1958.8424,5269.4863,180.0193,7,255); // racemap
	AddStaticVehicle(411,2731.5593,1958.8442,5269.4810,178.9329,144,255); // racemap

	//GD
	AddStaticVehicle(451,548.8139,846.1790,7113.7720,359.7605,130,255); // newgd
	AddStaticVehicle(451,552.0930,846.3073,7112.4702,0.0265,142,255); // newgd
	AddStaticVehicle(451,554.9915,846.0916,7111.2920,0.1358,142,255); // newgd
	AddStaticVehicle(530,563.7738,844.7303,7107.8584,0.6451,158,255); // newgd
	AddStaticVehicle(530,567.1681,844.7103,7106.4609,1.4590,6,255); // newgd
	AddStaticVehicle(530,569.8282,844.7248,7105.3813,0.5567,236,255); // newgd
	AddStaticVehicle(541,575.7502,845.8945,7102.8604,0.6926,146,255); // newgd
	AddStaticVehicle(541,578.2466,845.6000,7101.8359,1.1312,236,255); // newgd
	AddStaticVehicle(541,581.4488,845.3392,7100.5645,0.2859,147,255); // newgd
	AddStaticVehicle(609,590.0372,846.7653,7097.5781,0.8107,6,255); // newgd
	AddStaticVehicle(609,593.9351,846.7994,7095.9922,1.1055,144,255); // newgd
	AddStaticVehicle(452,599.5823,872.8425,7093.1133,179.4618,6,255); // newgd
	AddStaticVehicle(411,569.6187,874.2178,7105.4336,180.0002,159,255); // newgd
	AddStaticVehicle(411,566.7704,874.0460,7106.5786,180.8875,86,255); // newgd
	AddStaticVehicle(411,564.0062,873.4903,7107.6880,179.8544,161,255); // newgd
	AddStaticVehicle(431,549.8120,871.1516,7113.7563,176.8954,130,255); // newgd
	AddStaticVehicle(406,543.0304,871.3753,7118.1147,182.7830,6,255); // newgd

	//driftisland
	AddStaticVehicle(503,3071.8096,-3151.7681,47.2093,0.0640,75,1); // /driftisland
	AddStaticVehicle(494,3064.5969,-3151.0171,47.1920,0.0300,75,1); // /driftisland
	AddStaticVehicle(541,3070.1790,-3118.9138,45.2823,252.2981,123,1); // /driftisland
	AddStaticVehicle(451,3070.4255,-3115.5779,45.1637,278.1074,36,1); // /driftisland
	AddStaticVehicle(603,3070.5645,-3109.7820,44.9976,269.9515,255,1); // /driftisland
	AddStaticVehicle(504,3099.3311,-3151.4226,46.8297,27.9805,40,1); // /driftisland

	//BikeC
	new veh_bikeC[11];
	veh_bikeC[0] = AddStaticVehicle(522,1118.1583,1360.4303,10.3473,175.9955,236,255); // bc
	veh_bikeC[1] =AddStaticVehicle(522,1115.3757,1360.6385,10.3727,174.0724,150,255); // bc
	veh_bikeC[2] =AddStaticVehicle(522,1116.8628,1360.7001,10.3819,172.6443,175,255); // bc
	veh_bikeC[3] =AddStaticVehicle(468,1112.3943,1360.8801,10.5144,171.3476,131,255); // bc
	veh_bikeC[4] =AddStaticVehicle(522,1113.9193,1360.6929,10.4211,176.0134,155,255); // bc
	veh_bikeC[5] =AddStaticVehicle(468,1110.9777,1360.7141,10.4370,172.4175,175,255); // bc
	veh_bikeC[6] =AddStaticVehicle(581,1109.4070,1360.8016,10.4031,177.9902,149,255); // bc
	veh_bikeC[7] =AddStaticVehicle(581,1107.9777,1360.6622,10.4074,181.0323,148,255); // bc
	veh_bikeC[8] =AddStaticVehicle(521,1106.0084,1360.6349,10.4130,179.7719,154,255); // bc
	veh_bikeC[9] =AddStaticVehicle(461,1102.4650,1360.4196,10.3990,166.7076,151,255); // bc
	veh_bikeC[10] =AddStaticVehicle(521,1104.2096,1360.3617,10.3406,180.0261,148,255); // bc
	for(new iit = 0; iit < sizeof(veh_bikeC); iit++)
	{
		SetVehicleVirtualWorld(veh_bikeC[iit], 12);
	}

	//Deathjump
	AddStaticVehicleEx(437,2631.50000000,-1038.19995117,883.50000000,269.93896484,100,104,RESPAWN_TIME); //Coach
	AddStaticVehicleEx(437,2631.39990234,-1050.09997559,883.50000000,269.93408203,100,104,RESPAWN_TIME); //Coach
	AddStaticVehicleEx(522,2691.80004883,-1060.09997559,882.90002441,0.00000000,6,0,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,2689.00000000,-1060.00000000,882.90002441,0.00000000,186,0,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,2686.10009766,-1059.80004883,882.90002441,0.00000000,2,0,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(468,2682.00000000,-1060.00000000,883.00000000,0.00000000,215,142,RESPAWN_TIME); //Sanchez
	AddStaticVehicleEx(468,2679.60009766,-1060.40002441,883.00000000,0.00000000,0,0,RESPAWN_TIME); //Sanchez
	AddStaticVehicleEx(468,2676.69995117,-1059.90002441,883.00000000,0.00000000,3,3,RESPAWN_TIME); //Sanchez
	AddStaticVehicleEx(495,2669.50000000,-1059.09997559,883.79998779,0.00000000,2,0,RESPAWN_TIME); //Sandking
	AddStaticVehicleEx(495,2663.00000000,-1059.30004883,883.79998779,0.00000000,2,0,RESPAWN_TIME); //Sandking
	AddStaticVehicleEx(457,2650.39990234,-1040.30004883,883.00000000,0.00000000,5,0,RESPAWN_TIME); //Caddy
	AddStaticVehicleEx(457,2656.50000000,-1040.30004883,883.00000000,0.00000000,88,89,RESPAWN_TIME); //Caddy
	AddStaticVehicleEx(420,2653.69995117,-1050.90002441,883.09997559,179.73498535,215,142,RESPAWN_TIME); //Taxi
	AddStaticVehicleEx(420,2656.80004883,-1051.19995117,883.09997559,179.73083496,215,142,RESPAWN_TIME); //Taxi
	AddStaticVehicleEx(571,2674.69995117,-1121.00000000,852.40002441,0.00000000,42,119,RESPAWN_TIME); //Kart
	AddStaticVehicleEx(601,2666.19995117,-1039.69995117,883.20001221,0.00000000,245,245,RESPAWN_TIME); //S.W.A.T. Van
	AddStaticVehicleEx(434,2678.80004883,-1040.30004883,883.40002441,0.00000000,93,126,RESPAWN_TIME); //Hotknife
	AddStaticVehicleEx(480,2644.10009766,-1030.30004883,883.09997559,178.82641602,0,0,RESPAWN_TIME); //Comet
	AddStaticVehicleEx(480,2650.19995117,-1030.19995117,883.09997559,178.82446289,4,4,RESPAWN_TIME); //Comet
	AddStaticVehicleEx(560,2656.50000000,-1030.59997559,883.00000000,179.73498535,185,14,RESPAWN_TIME); //Sultan

	//Huge Loop
	AddStaticVehicleEx(411, 482.3195, -20.0222, 680.7685, 126.6686, 64, 1, RESPAWN_TIME); // LOOP-INFERNUS-1
	AddStaticVehicleEx(411, 487.8175, -20.2552, 680.7569, 127.5139, 123, 1, RESPAWN_TIME); // LOOP-INFERNUS-2
	AddStaticVehicleEx(411, 493.4407, -20.0513, 680.7545, 130.3129, 116, 1, RESPAWN_TIME); // LOOP-INFERNUS-3
	AddStaticVehicleEx(411, 498.6631, -19.9411, 680.7545, 130.6971, 112, 1, RESPAWN_TIME); // LOOP-INFERNUS-4
	AddStaticVehicleEx(411, 503.4510, -19.9187, 680.7546, 131.4548, 106, 1, RESPAWN_TIME); // LOOP-INFERNUS-5
	AddStaticVehicleEx(411, 497.9041, -31.0518, 680.6855, 359.6010, 31, 31, RESPAWN_TIME); // LOOP-INFERNUS-6
	AddStaticVehicleEx(411, 502.6539, -31.2181, 680.6518, 358.7756, 42, 42, RESPAWN_TIME); // LOOP-INFERNUS-7
	AddStaticVehicleEx(411, 478.7649, -39.3824, 680.7531, 359.6185, 0, 0, RESPAWN_TIME);// LOOP-INFERNUS-8
	AddStaticVehicleEx(411, 481.8880, -39.3919, 680.7530, 358.6935, 0, 0, RESPAWN_TIME); // LOOP-INFERNUS-9
	AddStaticVehicleEx(411, 460.8441, -20.8642, 680.6526, 236.0938, 0, 6, RESPAWN_TIME); // LOOP-INFERNUS-10
	AddStaticVehicleEx(411, 470.9919, -49.6101, 680.6838, 36.9633, 2, 1, RESPAWN_TIME); // LOOP-INFERNUS-11
	AddStaticVehicleEx(411, 502.6077, -39.2831, 680.7545, 179.5781, 123, 1, RESPAWN_TIME); // LOOP-INFERNUS-12
	AddStaticVehicleEx(411, 497.9334, -39.4644, 680.7545, 179.7408, 116, 1, RESPAWN_TIME); // LOOP-INFERNUS-13
	AddStaticVehicleEx(411, 475.7599, -50.1053, 680.7768, 36.2140, 112, 1, RESPAWN_TIME); // LOOP-INFERNUS-14
	AddStaticVehicleEx(411, 479.8474, -50.0542, 680.7545, 36.1146, 106, 1, RESPAWN_TIME); // LOOP-INFERNUS-15
	AddStaticVehicleEx(411, 475.3574, -39.4188, 680.7591, 0.5098, 0, 0, RESPAWN_TIME); // LOOP-INFERNUS-16

	//aa
	AddStaticVehicleEx(429,329.7509,2538.4402,17.7131,182.0048,126,255, 50); // aa1
	AddStaticVehicleEx(402,332.8269,2544.9421,17.7673,181.1880,181,255, 50); // aa1
	AddStaticVehicleEx(541,326.1461,2538.3003,17.6399,182.7016,192,255, 50); // aa1
	AddStaticVehicleEx(415,318.6516,2544.5176,17.7770,180.4922,158,255, 50); // aa1
	AddStaticVehicleEx(562,322.5125,2538.2764,17.6365,177.9029,126,255, 50); // aa1
	AddStaticVehicleEx(411,318.6168,2538.4460,17.7281,180.0403,228,255, 50); // aa1
	AddStaticVehicleEx(411,298.0734,2536.9460,17.7290,181.5094,6,255, 50); // aa1
	AddStaticVehicleEx(429,294.4437,2536.4854,17.6913,183.6130,152,255, 50); // aa1
	AddStaticVehicleEx(562,291.1471,2536.4939,17.6434,177.8404,175,255, 50); // aa1
	AddStaticVehicleEx(415,287.7766,2536.2612,17.7732,181.9663,228,255, 50); // aa1
	AddStaticVehicleEx(411,284.0482,2536.0613,17.7290,180.2609,7,255, 50); // aa1


	veh_admin = AddStaticVehicleEx(520, 360.5009, 2645.0251, 32.4636, 208.3392, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(415, 416.0383, 2600.5662, 32.1382, 137.6907, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(541, 418.0970, 2598.2249, 32.9473, 137.7254, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(411, 420.4160, 2596.1868, 32.0044, 137.4536, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 427.3368, 2590.1614, 32.0077, 89.1904, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 424.2410, 2590.2019, 32.0077, 89.1904, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(471, 427.1866, 2592.6411, 32.9397, 92.5343, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(415, 378.9636, 2615.0503, 32.1970, 187.6952, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(461, 338.5983, 2534.1787, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(461, 339.8745, 2534.1191, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(521, 341.2231, 2533.9209, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(521, 342.5522, 2534.0552, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(461, 338.3506, 2537.1187, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 339.8463, 2537.1865, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(521, 341.2798, 2537.1768, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(521, 342.7180, 2537.3015, 16.7921, 179.9650, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(487, 355.1820, 2547.4761, 17.1169, 180.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(487, 343.0677, 2546.9480, 17.1169, 180.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(415, 424.7986, 2531.1333, 22.7298, 90.0615, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(411, 425.0240, 2527.4182, 22.7298, 90.0615, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(429, 425.0653, 2524.1826, 22.7298, 90.0615, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(541, 425.1122, 2521.0332, 22.7298, 90.0615, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(556, 374.9861, 2472.0547, 16.9263, 0.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(556, 370.3864, 2472.0859, 16.9263, 0.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(513, 348.9853, 2535.5100, 17.5218, 180.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 425.6444, 2556.6250, 24.9081, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 425.6182, 2555.0845, 24.9081, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 425.6146, 2553.2554, 24.9081, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 425.6006, 2551.1665, 24.9081, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(495, 424.7826, 2546.5376, 24.8671, 90.7500, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(495, 424.8520, 2542.4348, 24.8671, 90.7500, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(424, 424.8471, 2538.5232, 24.3880, 90.7943, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(424, 424.7607, 2534.8870, 24.3880, 90.7943, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(471, 423.1311, 2562.6289, 24.3722, 180.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(471, 421.0154, 2562.5327, 24.3722, 180.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(471, 425.2360, 2562.7883, 24.3722, 180.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 425.7315, 2558.4756, 24.9081, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(429, 424.9274, 2517.8560, 24.7298, 90.0615, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(437, 308.0573, 2541.0161, 16.8071, 180.0000, -1, -1, 50);

	AddStaticVehicleEx(411, 423.1012, 2459.8230, 16.7614, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(541, 423.2176, 2462.7646, 16.7614, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(415, 423.1039, 2465.8044, 16.7614, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(429, 422.9948, 2468.8979, 16.7614, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 422.7733, 2457.2515, 16.7614, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);
	AddStaticVehicleEx(522, 422.5844, 2455.6099, 16.7614, 90.0000, randomColors[random(23)],randomColors[random(23)], 50);


	// SKIRamp
	AddStaticVehicleEx(415,-1303.6017,-1660.9081,538.2225,353.1777,130,130, RESPAWN_TIME); // SKIRAMP-CHEETAH-1
	AddStaticVehicleEx(415,-1306.8027,-1660.6342,538.2216,353.5898,114,106, RESPAWN_TIME); // SKIRAMP-CHEETAH-2
	AddStaticVehicleEx(415,-1307.6282,-1668.7665,538.2217,174.0615,130,130, RESPAWN_TIME); // SKIRAMP-CHEETAH-3
	AddStaticVehicleEx(415,-1304.4297,-1669.0270,538.2222,174.0614,114,106, RESPAWN_TIME); // SKIRAMP-CHEETAH-4
	AddStaticVehicleEx(437,-1327.7188,-1677.6526,538.5835,262.8995,99,52, RESPAWN_TIME); // SKIRAMP-COACH-1
	AddStaticVehicleEx(437,-1324.7375,-1647.9915,538.5934,263.0820,99,52, RESPAWN_TIME); // SKIRAMP-COACH-2
	AddStaticVehicleEx(411,-1273.7748,-1683.2458,538.1775,354.1786,106,1, RESPAWN_TIME); // SKIRAMP-INFERNUS-1
	AddStaticVehicleEx(411,-1276.9615,-1682.9397,538.1775,354.1908,80,1, RESPAWN_TIME); // SKIRAMP-INFERNUS-2
	AddStaticVehicleEx(411,-1280.1732,-1682.5282,538.1775,353.7160,12,1, RESPAWN_TIME); // SKIRAMP-INFERNUS-3
	AddStaticVehicleEx(411,-1283.2382,-1682.1975,538.1774,353.8906,64,1, RESPAWN_TIME); // SKIRAMP-INFERNUS-4
	AddStaticVehicleEx(411,-1286.5723,-1681.7646,538.1774,353.5283,123,1, RESPAWN_TIME); // SKIRAMP-INFERNUS-5
	AddStaticVehicleEx(451,-1273.7832,-1653.3217,538.1571,173.3969,36,36, RESPAWN_TIME); // SKIRAMP-TURISMO-2
	AddStaticVehicleEx(451,-1270.6949,-1653.5406,538.1300,173.2510,125,125, RESPAWN_TIME); // SKIRAMP-TURISMO-1
	AddStaticVehicleEx(451,-1277.0070,-1653.1075,538.1571,173.7635,16,16, RESPAWN_TIME); // SKIRAMP-TURISMO-3
	AddStaticVehicleEx(451,-1280.1930,-1652.7335,538.1572,173.4489,18,18, RESPAWN_TIME); // SKIRAMP-TURISMO-4
	AddStaticVehicleEx(451,-1283.3954,-1652.3607,538.1566,174.2572,46,46, RESPAWN_TIME); // SKIRAMP-TURISMO-5
	AddStaticVehicleEx(407,-1310.7633,-1678.4587,538.6887,286.3398,3,1, RESPAWN_TIME); // SKIRAMP-FIRETRUCK-1
	AddStaticVehicleEx(454,-1263.6328,-1657.8984,538.6894,227.4370,126,97, RESPAWN_TIME); // SKIRAMP-TROPIC-1

	//sf Jizzy San Fierro
	AddStaticVehicle(411,-2682.7085,1330.2838,16.7580,320.5946,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(411,-2686.1880,1331.1350,16.7876,320.4946,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(411,-2689.7695,1331.6843,16.7874,318.7202,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(411,-2692.6841,1331.9794,16.7876,321.4788,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(502,-2684.1072,1353.7578,16.9741,268.0359,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(434,-2684.8245,1358.1743,17.0547,267.9997,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(423,-2684.4558,1363.0135,17.1031,267.9993,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(409,-2682.7019,1367.6807,16.7912,268.0001,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(556,-2690.0386,1365.2911,17.5690,271.9641,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(522,-2673.8970,1355.9656,16.6557,173.9991,randomColors[random(23)],-1); // SfBike
	AddStaticVehicle(522,-2671.5264,1355.8832,16.6554,173.9975,randomColors[random(23)],-1); // SfBike
	AddStaticVehicle(522,-2668.9165,1355.8719,16.6552,173.9975,randomColors[random(23)],-1); // SfBike
	AddStaticVehicle(522,-2666.1995,1355.7961,16.6499,173.9961,randomColors[random(23)],-1); // SfBike
	AddStaticVehicle(522,-2618.0315,1375.1138,6.6822,93.1444,randomColors[random(23)],-1); // SfBike
	AddStaticVehicle(522,-2617.9932,1377.3975,6.7058,91.4552,randomColors[random(23)],-1); // SfBike
	AddStaticVehicle(522,-2617.9934,1379.6932,6.7219,90.6230,randomColors[random(23)],-1); // SfBike
	AddStaticVehicle(556,-2642.0835,1392.0088,7.5096,193.9869,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(556,-2648.1997,1390.1783,7.4532,194.9078,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(443,-2657.5620,1376.5282,7.8033,269.5387,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(480,-2645.3677,1373.0775,6.9595,270.5286,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(415,-2645.5537,1369.3159,6.8807,269.4694,randomColors[random(23)],-1); // SfVehicle
	AddStaticVehicle(411,-2645.5398,1365.4290,6.8932,270.7357,randomColors[random(23)],-1); // SfVehicle


	// Chilliad (18 vehicles)
	AddStaticVehicleEx(522, -2348.2009, -1597.3967, 485.1652, 240.2311, 7, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(522, -2348.5098, -1599.2775, 485.1704, 235.2625, 126, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(522, -2349.2795, -1600.8761, 485.1651, 233.3064, 6, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(603,-2352.9900,-1632.8055,484.5833,273.5390,7,1, RESPAWN_TIME); // Chilliad_Phoenix
	AddStaticVehicleEx(559,-2353.0784,-1628.6650,484.3387,259.6158,130,130, RESPAWN_TIME); // Chilliad_Jester_TUNE
	AddStaticVehicleEx(429,-2351.8501,-1624.1846,483.3578,261.0215,154,146, RESPAWN_TIME); // Chilliad_Banshee
	AddStaticVehicleEx(411,-2351.7410,-1620.0779,484.3854,266.1861,1,1, RESPAWN_TIME); // Chilliad_Infernus
	AddStaticVehicleEx(443,-2344.6169,-1616.5525,484.3071,255.8479,14,8, RESPAWN_TIME); // Chilliad_Packer
	AddStaticVehicleEx(443,-2345.3711,-1610.7327,484.3154,254.4024,14,8, RESPAWN_TIME); // Chilliad_Packer
	AddStaticVehicle(409,-2351.2144,-1643.0742,484.3541,5.9771,175,0); // Chilliad Limo
	AddStaticVehicle(437,-2336.1814,-1590.3180,484.6874,215.6822,105,20); // Chilliad Bus
	AddStaticVehicle(415,-2331.2266,-1590.1281,484.3261,215.8079,147,149); // Chilliad Cheetah
	AddStaticVehicle(411,-2328.8721,-1587.8173,484.2812,219.3843,166,166); // Chilliad Infurnes
	AddStaticVehicle(541,-2330.1174,-1583.1034,484.1791,239.0295,0,6); // Chilliad Bullet
	AddStaticVehicle(451,-2328.7454,-1580.3527,484.2687,236.7509,154,146); // Chilliad Turismo
	AddStaticVehicleEx(406,-2340.6580,-1593.5358,485.1473,216.3380,0,0, RESPAWN_TIME); // Chilliad_Dumper

	// SkatePark (15 vehicles)
	AddStaticVehicleEx(522, 1926.920, -1414.544, 13.179, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // NRG
	AddStaticVehicleEx(481, 1917.619, -1414.995, 13.179, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // BMX
	AddStaticVehicleEx(522, 1923.370, -1414.544, 13.179, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // NRG
	AddStaticVehicleEx(481, 1914.469, -1415.070, 13.179, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // BMX
	AddStaticVehicleEx(522, 1920.245, -1414.544, 13.179, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // NRG
	AddStaticVehicleEx(481, 1910.444, -1414.970, 13.179, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // BMX
	AddStaticVehicleEx(481, 1899.651, -1359.537, 13.117, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // BMX
	AddStaticVehicleEx(481, 1903.052, -1359.287, 13.117, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // BMX
	AddStaticVehicleEx(481, 1906.377, -1359.087, 13.117, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // BMX
	AddStaticVehicleEx(522, 1909.653, -1358.837, 13.117, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522, 1912.953, -1359.012, 13.117, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // NRG
	AddStaticVehicleEx(471, 1912.514, -1371.037, 13.216, 358.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // QUAD
	AddStaticVehicleEx(471, 1915.990, -1371.786, 13.216, 358.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // QUAD
	AddStaticVehicleEx(468, 1918.008, -1361.683, 13.288, 107.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // SANCHEZ
	AddStaticVehicleEx(468, 1919.283, -1363.508, 13.288, 107.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // SANCHEZ

	// PipeJump (12 vehicles)
	AddStaticVehicleEx(411, 956.2487, -1391.8467, 654.1215, 179.5437, 0, 1, RESPAWN_TIME); // pp_infernus
	AddStaticVehicleEx(411, 949.9069, -1391.5989, 654.1215, 180.8280, 6, 6, RESPAWN_TIME); // pp_Infernus
	AddStaticVehicleEx(411, 956.3107, -1382.5273, 654.1231, 359.3093, 6, 6, RESPAWN_TIME); // pp_Infernus
	AddStaticVehicleEx(411, 949.7828, -1382.6814, 654.1215, 0.6219, 0, 1, RESPAWN_TIME); // pp_Infernus
	AddStaticVehicleEx(541, 940.2498, -1372.3344, 654.0193, 180.5178, 1, 7, RESPAWN_TIME); // pp_Bullet
	AddStaticVehicleEx(541, 933.9158, -1372.1423, 654.0194, 181.0151, 0, 6, RESPAWN_TIME); // pp_Bullet
	AddStaticVehicleEx(409, 904.0321, -1375.1405, 654.1932, 181.0304, 0, 0, RESPAWN_TIME); // pp_Stretch
	AddStaticVehicleEx(559, 969.0681, -1402.2852, 654.0507, 359.7656, 176, 176, RESPAWN_TIME); // pp_Jester
	AddStaticVehicleEx(559, 965.8836, -1402.3059, 654.0507, 358.5548, 175, 175, RESPAWN_TIME); // pp_Jester
	AddStaticVehicleEx(457, 930.7847, -1391.7670, 654.0211, 359.5049, 32, 1, RESPAWN_TIME); // pp_Caddy
	AddStaticVehicleEx(457, 927.5911, -1391.7394, 654.0211, 359.5049, 32, 1, RESPAWN_TIME); // pp_Caddy
	AddStaticVehicleEx(457, 924.1359, -1391.7096, 654.0211, 359.5049, 32, 1, RESPAWN_TIME); // pp_Caddy
	AddStaticVehicleEx(411, 914.6725, -1401.7533, 654.1290, 359.7388, 1, 1, RESPAWN_TIME); // pp_Infernus
	AddStaticVehicleEx(411, 911.5115, -1401.8556, 654.1290, 359.7388, 1, 1, RESPAWN_TIME); // pp_Infernus
	AddStaticVehicleEx(411, 908.3181, -1401.8412, 654.1290, 359.7388, 1, 1, RESPAWN_TIME); // pp_Infernus

	// HalfPipe (/hp)
	AddStaticVehicleEx(495, 2851.8349, -1928.5164, 11.6, 270.0, randomColors[random(23)], -1, RESPAWN_TIME); // Sandking
	AddStaticVehicleEx(495, 2851.8349, -1925.0156, 11.6, 270.0, randomColors[random(23)], -1, RESPAWN_TIME); // Sandking
	AddStaticVehicleEx(411, 2851.8349, -1921.2656, 11.0, 270.0, randomColors[random(23)], -1, RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(411, 2851.8349, -1917.4726, 11.0, 270.0, randomColors[random(23)], -1, RESPAWN_TIME); // Infernus
	AddStaticVehicleEx(541, 2851.8317, -1931.9450, 10.8, 271.5, randomColors[random(23)], -1, RESPAWN_TIME); // Bullet
	AddStaticVehicleEx(541, 2851.8310, -1935.3281, 10.8, 271.5, randomColors[random(23)], -1, RESPAWN_TIME); // Bullet

	// Wang / Trans
	AddStaticVehicleEx(559,-1947.2701,270.9846,40.6817,46.0310,130,130, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(562,-1949.3884,262.5764,40.6801,274.9609,132,132, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(541,-1948.1045,256.7387,40.6718,70.7573,0,6, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(415,-1954.7340,256.0838,40.8179,51.0019,154,146, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(402,-1955.0210,266.5862,40.8786,308.9841,1,1, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(451,-1956.7411,278.2663,40.7494,179.0007,166,166, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(411,-1954.8373,292.0865,40.7638,129.0001,171,171, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(560,-1956.6866,301.4495,35.1928,124.0001,176,176, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(451,-1955.2860,294.4709,35.1662,114.0040,175,175, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(506,-1961.7582,282.4230,35.1971,22.9997,6,6, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(559,-1962.5583,272.6157,35.1244,359.9999,7,7, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(411,-1955.1526,267.8657,35.2062,25.0000,1,1, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(402,-1957.2855,257.4947,35.3284,332.0001,0,0, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(475,-1948.7190,258.7628,35.1108,43.0022,6,6, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(402,-1991.7024,249.0482,35.0328,41.0004,130,130, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(411,-1990.1554,257.3638,34.8965,41.0002,166,166, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(475,-1988.9041,266.5693,34.9964,41.0107,7,7, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(545,-1988.1497,274.6410,34.8929,40.9829,1,1, RESPAWN_TIME); // Trans
	AddStaticVehicleEx(451,-1986.8811,303.9938,34.8732,90.4921,166,166, RESPAWN_TIME); // Trans

	//otto
	AddStaticVehicleEx(541,-1669.2303,1206.5509,20.7889,331.9989,0,6, RESPAWN_TIME); // otto
	AddStaticVehicleEx(522,-1676.5463,1205.6644,20.7237,294.0097,132,132, RESPAWN_TIME); // otto
	AddStaticVehicleEx(415,-1655.0062,1210.4509,20.9287,309.5777,130,130, RESPAWN_TIME); // otto
	AddStaticVehicleEx(429,-1662.5756,1219.3075,20.8359,247.1281,154,146, RESPAWN_TIME); // otto
	AddStaticVehicleEx(411,-1654.5081,1212.2430,13.3939,315.3089,166,166, RESPAWN_TIME); // otto
	AddStaticVehicleEx(506,-1667.4081,1206.6486,13.3820,308.0001,171,171, RESPAWN_TIME); // otto
	AddStaticVehicleEx(559,-1662.3716,1220.5264,13.3300,258.3371,158,158, RESPAWN_TIME); // otto
	AddStaticVehicleEx(495,-1660.6531,1215.6719,7.5764,221.0172,176,176, RESPAWN_TIME); // otto
	AddStaticVehicleEx(560,-1654.3833,1214.6912,6.9730,227.9999,7,7, RESPAWN_TIME); // otto

	//loco
	AddStaticVehicleEx(534,2691.2234,-1997.0581,13.2772,275.9992,53,53, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(535,2678.7283,-2011.0602,13.3001,269.9998,55,1, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(536,2659.7671,-1997.3718,13.2736,88.9999,30,96, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(534,2661.6414,-2011.1354,13.2930,269.9998,62,62, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(535,2652.2095,-1997.3884,13.3001,88.9998,66,1, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(536,2637.4272,-2004.6964,13.2926,275.9297,12,1, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(535,2638.1575,-1999.7690,13.3180,254.2335,31,1, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(534,2653.5000,-2036.5527,13.3064,89.0128,7,7, RESPAWN_TIME); // locolow
	AddStaticVehicleEx(536,2654.5247,-2032.8098,13.2833,275.9932,10,10, RESPAWN_TIME); // locolow

	// truckstop (19 vehicles)
	AddStaticVehicleEx(403, -511.124, 2582.796, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(403, -511.124, 2577.572, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(403, -511.124, 2572.923, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(403, -511.205, 2603.936, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(403, -511.205, 2608.838, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(515, -511.205, 2613.511, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(515, -511.205, 2618.385, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(515, -511.205, 2623.234, 54.114, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(515, -511.199, 2568.511, 54.115, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(515, -511.199, 2563.337, 54.115, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(584, -538.518, 2563.077, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(584, -538.518, 2568.152, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(584, -538.518, 2573.376, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(584, -538.518, 2577.876, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(584, -538.518, 2582.701, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(591, -538.518, 2603.701, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(591, -538.518, 2608.500, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(591, -538.518, 2613.600, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(591, -538.518, 2618.549, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(591, -538.518, 2623.199, 54.114, 269.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// Drift SF (cars at the SF drift spot) (7 vehicles)
	AddStaticVehicleEx(451, -2416.3979, -589.3999, 132.3552, 213.9968, 125, 125, RESPAWN_TIME);
	AddStaticVehicleEx(429, -2408.9910, -583.7446, 132.3281, 215.6238, 1, 2, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2401.2761, -587.0637, 132.3755, 125.1008, 123, 1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2397.9214, -592.1757, 132.3556, 124.3323, 16, 16, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2394.6228, -597.0934, 132.3755, 123.7977, 116, 1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2390.9241, -601.6351, 132.3559, 123.4139, 36, 36, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2399.7327, -613.1644, 132.3755, 34.8610, 64, 1, RESPAWN_TIME);
	AddStaticVehicleEx(429, -2392.2251, -608.1451, 132.3281, 35.5882, 14, 14, RESPAWN_TIME);

	// LsDive (cars on top of the giant building in LS) (3 vehicles)
	AddStaticVehicleEx(556, 1545.6943, -1353.6945, 329.8347, 89.9601, 1, 1, RESPAWN_TIME);
	AddStaticVehicleEx(471, 1533.9585, -1365.0375, 328.9550, 4.9892, 120, 113, RESPAWN_TIME);
	AddStaticVehicleEx(522, 1544.4587, -1371.8754, 329.0921, 6.7623, 8, 82, RESPAWN_TIME);

	// parkours
	AddStaticVehicleEx(481, 2088.6504, -1001.2874, 58.0701, 23.8708, 12, 9, RESPAWN_TIME); // /parkour1
	AddStaticVehicleEx(481, 2085.9421, -1004.1553, 58.0723, 33.2676, 14, 1, RESPAWN_TIME); // /parkour2
	AddStaticVehicleEx(481, 2091.5818, -999.7413, 58.0721, 23.8712, 26, 1, RESPAWN_TIME); // /parkour3

	// Bayside vehicles (29 - 6 vehicles)
	/*AddStaticVehicle(522, -2259.1558, 2350.9070, 4.4373, 141.3983, 51, 118);
	AddStaticVehicle(522, -2260.2251, 2351.7305, 4.4442, 144.7059, 39, 106);
	AddStaticVehicle(522, -2261.3369, 2352.5999, 4.4454, 143.1790, 36, 105);
	AddStaticVehicle(522, -2262.5776, 2353.5474, 4.4418, 143.6076, 8, 82);
	AddStaticVehicle(522, -2263.9155, 2354.4822, 4.4412, 143.2689, 7, 79);
	AddStaticVehicle(522, -2264.9565, 2355.4536, 4.4467, 142.4237, 6, 25);
	AddStaticVehicle(522, -2266.1667, 2356.5732, 4.4515, 142.4799, 3, 8);
	AddStaticVehicle(522, -2268.7434, 2280.5762, 4.5387, 0.2422, 8, 82);
	AddStaticVehicle(522, -2267.5879, 2280.4788, 4.5432, 1.7259, 36, 105);
	AddStaticVehicle(522, -2264.1409, 2280.4741, 4.5393, 2.0083, 3, 3);
	AddStaticVehicle(522, -2265.3389, 2280.4810, 4.5412, 2.9231, 51, 118);
	AddStaticVehicle(522, -2266.4587, 2280.5022, 4.5375, 3.8115, 39, 106);
	AddStaticVehicle(603, -2251.8281, 2285.3000, 4.5206, 91.0876, 83, 36);
	AddStaticVehicle(603, -2251.9917, 2291.0178, 4.6562, 88.9464, 45, 45);
	AddStaticVehicle(411, -2251.7527, 2297.0442, 4.5416, 91.6788, 12, 1);
	AddStaticVehicle(475, -2251.9580, 2302.9968, 4.6190, 89.2956, 75, 77);
	AddStaticVehicle(587, -2251.7705, 2309.0117, 4.5399, 90.0751, 53, 1);
	AddStaticVehicle(562, -2251.5103, 2315.0012, 4.4730, 89.4572, 17, 1);
	AddStaticVehicle(541, -2251.5164, 2320.9583, 4.4395, 89.8883, 51, 1);
	AddStaticVehicle(415, -2251.6282, 2326.9280, 4.5858, 89.3579, 0, 1);
	AddStaticVehicle(434, -2251.3389, 2332.9526, 4.7827, 90.5209, 2, 2);
	AddStaticVehicle(411, -2272.2444, 2333.2559, 4.5447, 270.2241, 64, 1);
	AddStaticVehicle(471, -2274.1052, 2327.3206, 4.3023, 270.8045, 120, 112);
	AddStaticVehicle(457, -2273.5063, 2321.4382, 4.4470, 270.4190, 34, 1);
	AddStaticVehicle(545, -2272.7607, 2315.3501, 4.6337, 270.2092, 40, 96);
	AddStaticVehicle(480, -2272.4324, 2309.3442, 4.5952, 270.5706, 53, 53);
	AddStaticVehicle(451, -2272.4575, 2303.4111, 4.5290, 270.2938, 46, 46);
	AddStaticVehicle(506, -2272.4712, 2297.4565, 4.5264, 269.4263, 6, 6);
	AddStaticVehicle(500, -2273.1614, 2291.3696, 4.9309, 270.5457, 40, 110);
	AddStaticVehicle(559, -2272.6091, 2285.3586, 4.4789, 269.3309, 2, 1);*/

	// hippy
	AddStaticVehicleEx(483, -774.293, 2430.316, 157.189, 77.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(483, -776.669, 2436.940, 157.189, 120.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(483, -781.844, 2441.561, 157.189, 149.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(483, -787.919, 2443.364, 157.189, 184.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(483, -794.119, 2442.640, 157.189, 190.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(483, -803.695, 2434.140, 157.189, 242.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// boats
	AddStaticVehicleEx(446, -782.486, 1848.737, 1.011, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(446, -783.255, 1858.828, 1.047, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(446, -785.053, 1870.016, 1.037, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(446, -787.652, 1879.942, 1.001, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(446, -788.539, 1891.081, 1.011, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(446, -789.492, 1903.365, 1.029, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(446, -791.382, 1912.894, 0.993, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(446, -792.799, 1923.402, 1.043, 280.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// bikefun
	AddStaticVehicleEx(481, 2580.591, -2037.811, 10.770, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 2582.667, -2037.760, 10.770, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 2584.566, -2037.760, 10.770, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 2586.589, -2037.760, 10.770, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// wallride
	AddStaticVehicleEx(522, -807.8168, 1808.5197, 6.5852, 0.0000, 36, 105, RESPAWN_TIME); // /wallride
	AddStaticVehicleEx(522, -806.0795, 1810.1029, 6.5852, 0.0002, 8, 82, RESPAWN_TIME); // /wallride
	AddStaticVehicleEx(522, -804.4874, 1811.9873, 6.5843, 358.7650, 7, 79, RESPAWN_TIME); // /wallride
	AddStaticVehicleEx(522, -805.6754, 1816.6229, 6.5852, 359.9998, 3, 8, RESPAWN_TIME); // /wallride
	AddStaticVehicleEx(522, -803.7788, 1818.0988, 6.5893, 0.0001, 3, 3, RESPAWN_TIME); // /wallride
	AddStaticVehicleEx(522, -807.5481, 1814.6140, 6.5852, 0.0000, 6, 25, RESPAWN_TIME); // /wallride

	// Bowl
	AddStaticVehicleEx(411, -458.071, -2669.179, 156.987, 318.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -461.095, -2665.537, 156.987, 318.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, -462.845, -2660.979, 156.987, 273.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, -459.820, -2656.453, 156.987, 220.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, -456.946, -2653.610, 156.987, 230.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, -454.621, -2650.616, 156.987, 240.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, -452.521, -2646.444, 156.987, 240.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -450.621, -2643.121, 156.987, 240.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -448.496, -2638.896, 156.912, 240.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// NRGBowl
	AddStaticVehicleEx(522, 1086.312, 1073.850, 67.528, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1083.412, 1070.674, 67.528, 85.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1086.288, 1067.473, 67.528, 175.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1089.537, 1070.724, 67.528, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1088.686, 1072.925, 67.528, 315.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1083.836, 1072.924, 67.528, 41.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1084.111, 1068.499, 67.528, 127.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1088.810, 1068.401, 67.528, 218.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// Monster
	AddStaticVehicleEx(556, -1213.205, -1038.190, 129.108, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, -1213.464, -1031.506, 128.908, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, -1213.711, -1025.521, 128.807, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, -1213.769, -1019.567, 128.857, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, -1214.095, -1014.629, 128.207, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, -1212.846, -1050.967, 129.232, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, -1212.846, -1056.667, 129.232, 270.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// Racemap
	AddStaticVehicleEx(411, -2907.344, -410.232, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -2901.547, -410.232, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, -2901.547, -403.482, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, -2901.547, -396.407, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(451, -2907.366, -396.407, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(451, -2907.366, -403.307, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -2907.366, -388.557, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -2901.516, -388.557, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, -2901.516, -380.307, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, -2907.489, -380.307, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(451, -2907.489, -371.807, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(451, -2901.462, -371.807, 4.185, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	//qjump
	AddStaticVehicleEx(411,864.935,227.735,587.350,20.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(541,881.237,234.234,587.350,20.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(603,873.811,230.885,587.350,20.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(402,847.777,258.789,587.350,20.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(560,855.394,239.636,587.350,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(487,882.132,249.639,587.350,43.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(568,876.509,269.178,587.350,21.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(522,861.652,255.695,587.350,21.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(468,867.955,258.092,587.350,21.0,randomColors[random(23)],-1, RESPAWN_TIME);

	//slide
	AddStaticVehicleEx(568, 1573.880, -1247.905, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1578.055, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1582.180, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1586.005, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1589.805, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1569.704, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1565.679, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1562.004, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1558.604, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(568, 1555.028, -1247.980, 277.852, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	//--------------------aajump
	AddStaticVehicleEx(429, 414.1776, 3237.1892, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 413.2602, 3233.9607, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(402, 412.4041, 3230.9741, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, 411.1256, 3228.0005, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, 408.3091, 3218.9446, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(402, 406.9417, 3212.7148, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(415, 410.2381, 3224.8438, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(451, 409.3442, 3221.8950, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(506, 407.6285, 3215.8223, 739.2118, 252.8793, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 431.1347, 3251.3528, 739.2118, 163.1363, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(415, 434.0026, 3250.5239, 739.2118, 163.1363, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 428.9727, 3252.0959, 739.2118, 163.1363, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 427.7275, 3252.4692, 739.2118, 163.1363, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 432.5000, 3232.9087, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 432.0802, 3231.3237, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 431.5610, 3229.7109, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 431.2322, 3228.2229, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 445.1833, 3238.7871, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 444.7585, 3237.2402, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 444.2632, 3235.7686, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 443.8994, 3234.4548, 739.2118, 75.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(429, 430.8490, 3225.6807, 739.2118, 73.3269, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(415, 430.0875, 3222.3655, 739.2118, 73.3269, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(451, 428.8524, 3219.3267, 739.2118, 73.3269, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 428.0699, 3216.2324, 739.2118, 73.3269, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(429, 443.4529, 3231.7217, 739.2118, 73.3269, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 442.7407, 3228.4988, 739.2118, 73.3269, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	//--------------------bigjump
	AddStaticVehicleEx(411, -671.916, 2316.940, 134.959, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -675.141, 2316.940, 134.184, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, -678.666, 2316.940, 133.434, 179.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	//-------------------------------TRAMPOLINE CARS--------------------------------
	AddStaticVehicleEx(573,-19.744,1636.493,300.325,273.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(573,-19.094,1644.944,300.325,240.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(573,-11.669,1650.071,300.325,178.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(573,-5.844,1645.245,300.325,127.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(573,-4.769,1636.968,300.325,93.0,randomColors[random(23)],-1, RESPAWN_TIME);

	//SFAIR
	AddStaticVehicleEx(522,-1194.42016602,6.17448044,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1196.92163086,4.04054022,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1199.23339844,1.74337626,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1201.70922852,-0.74273151,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1203.83227539,-3.20222282,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1206.33374023,-5.33543634,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1208.48217773,-7.44238758,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1210.76098633,-9.70119667,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,-1213.10620117,-12.03516674,15.85881424,20.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(487,-1187.14526367,16.59611130,14.41343784,44,randomColors[random(23)],-1,RESPAWN_TIME); //Maverick
	AddStaticVehicleEx(488,-1177.07336426,26.56813240,14.41343784,44,randomColors[random(23)],-1,RESPAWN_TIME); //News Chopper
	AddStaticVehicleEx(558,-1177.52954102,48.47111893,13.64843750,167.0,randomColors[random(23)],-1,RESPAWN_TIME); //Uranus
	AddStaticVehicleEx(559,-1180.92492676,51.78231430,13.90250111,164.0,randomColors[random(23)],-1,RESPAWN_TIME); //Jester
	AddStaticVehicleEx(560,-1184.63427734,55.32886887,13.95341301,164.0,randomColors[random(23)],-1,RESPAWN_TIME); //Sultan
	AddStaticVehicleEx(562,-1187.88476562,58.89232254,13.90198708,168.0,randomColors[random(23)],-1,RESPAWN_TIME); //Elegy
	AddStaticVehicleEx(565,-1191.54785156,61.86003113,13.83483505,168.0,randomColors[random(23)],-1,RESPAWN_TIME); //Flash
	AddStaticVehicleEx(587,-1194.99804688,64.61177826,13.91038895,170.0,randomColors[random(23)],-1,RESPAWN_TIME); //Euros
	AddStaticVehicleEx(549,-1173.92529297,44.68580627,14.00991440,170.0,randomColors[random(23)],-1,RESPAWN_TIME); //Tampa
	/*AddStaticVehicleEx(411,-1235.04345703,11.92868996,13.94885159,274.0,151,151,RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(411,-1235.47424316,16.03010941,13.94885159,274.0,131,131,RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(411,-1235.79846191,19.84115791,13.94885159,274.0,252,252,RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(411,-1236.09521484,23.63043404,13.94885159,274.0,158,158,RESPAWN_TIME); //Infernus*/
	AddStaticVehicleEx(522,-1241.5724,36.4611,13.7389,225.1708,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1240.6383,37.4958,13.7317,226.9641,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1239.7985,38.4723,13.7275,225.6315,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1238.7677,39.5710,13.7141,225.5491,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1237.8767,40.4672,13.7197,225.5702,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1236.8624,41.4519,13.7017,224.4331,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1235.9850,42.3973,13.7184,226.7915,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1235.1077,43.3828,13.7056,226.0818,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1234.2981,44.4518,13.7071,225.6223,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1233.3295,45.4101,13.7053,225.0871,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1232.3506,46.3538,13.7035,224.9116,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	AddStaticVehicleEx(522,-1231.4551,47.3472,13.6969,225.5449,randomColors[random(23)],-1,RESPAWN_TIME); // NRG
	// Boats
	AddStaticVehicleEx(493,-1223.41015625,136.18359375,0.0,313.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Jetmax
	AddStaticVehicleEx(493,-1213.31054688,146.08300781,0.0,313.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Jetmax
	AddStaticVehicleEx(454,-1200.86364746,143.65597534,0.0,133.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Tropic
	AddStaticVehicleEx(454,-1194.96569824,137.58026123,0.0,133.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Tropic
	AddStaticVehicleEx(454,-1188.03906250,130.40429688,0.0,133.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Tropic
	AddStaticVehicleEx(472,-1180.59863281,123.58496094,0.0,133.24768066,randomColors[random(23)],-1,RESPAWN_TIME); //Coastguard
	AddStaticVehicleEx(472,-1188.27355957,116.28497314,0.0,133.24768066,randomColors[random(23)],-1,RESPAWN_TIME); //Coastguard
	AddStaticVehicleEx(484,-1170.70898438,87.19739532,0.0,44,randomColors[random(23)],-1,RESPAWN_TIME); //Marquis
	AddStaticVehicleEx(484,-1175.15893555,82.87226105,0.0,43.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Marquis
	AddStaticVehicleEx(484,-1179.53417969,78.42147064,0.0,43.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Marquis
	AddStaticVehicleEx(493,-1197.22058105,88.18426514,0.0,313.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Jetmax
	AddStaticVehicleEx(484,-1179.66113281,137.58320618,0.0,223.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Marquis
	AddStaticVehicleEx(453,-1155.29650879,123.41561890,0.0,134,randomColors[random(23)],-1,RESPAWN_TIME); //Reefer
	AddStaticVehicleEx(472,-1178.72973633,152.98236084,0.0,225.24768066,randomColors[random(23)],-1,RESPAWN_TIME); //Coastguard
	AddStaticVehicleEx(472,-1170.97949219,145.40646362,0.0,225.24719238,randomColors[random(23)],-1,RESPAWN_TIME); //Coastguard
	AddStaticVehicleEx(484,-1157.88513184,50.44188690,0.0,313.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Marquis
	AddStaticVehicleEx(484,-1150.55847168,42.79136658,0.0,313.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Marquis
	AddStaticVehicleEx(454,-1165.99011230,57.05273438,0.0,313.99438477,randomColors[random(23)],-1,RESPAWN_TIME); //Tropic
	AddStaticVehicleEx(454,-1173.13891602,64.90275574,0.0,313.98925781,randomColors[random(23)],-1,RESPAWN_TIME); //Tropic
	AddStaticVehicleEx(493,-1141.93322754,85.59482574,0.0,43.99475098,randomColors[random(23)],-1,RESPAWN_TIME); //Jetmax

	// carsumo
	AddStaticVehicleEx(573, 3638.425, 1255.178, 10.322, 178.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3643.026, 1254.971, 10.472, 178.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3603.196, 1254.807, 10.694, 178.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3599.103, 1254.620, 10.819, 178.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3646.354, 1178.074, 10.730, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3642.758, 1177.782, 10.730, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3604.178, 1177.683, 10.908, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3600.411, 1177.936, 10.958, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(573, 3622.955, 1180.160, 12.214, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// deathring Removed five - Mave
	AddStaticVehicleEx(457, 1504.025, 2769.233, 10.525, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(457, 1468.475, 2770.638, 10.401, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(457, 1484.511, 2745.072, 10.401, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// LV
	AddStaticVehicleEx(411, 2160.455, 1667.812, 10.620, 88.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, 2157.878, 1663.465, 10.620, 88.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 2163.576, 1687.291, 10.620, 88.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(451, 2162.618, 1691.845, 10.620, 88.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 2160.103, 1695.772, 10.620, 88.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, 2157.202, 1699.573, 10.620, 88.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(468, 2147.794, 1682.891, 10.481, 268.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 2147.352, 1680.775, 10.481, 268.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 2146.585, 1685.525, 10.481, 268.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(468, 2146.748, 1678.402, 10.481, 268.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 2145.860, 1688.152, 10.481, 268.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 2144.838, 1674.192, 10.481, 268.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(468, 2145.864, 1676.182, 10.481, 268.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// LSair
	AddStaticVehicleEx(411, 2076.7444, -2615.6228, 13.1381, 6.1280, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(541, 2072.9827, -2616.0200, 13.1381, 6.1280, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(415, 2081.0225, -2615.1287, 13.1381, 6.1280, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(429, 2085.6426, -2614.5732, 13.1381, 6.1280, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, 2109.0039, -2599.7432, 13.6102, 43.2790, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(556, 2113.0962, -2595.6118, 13.6102, 44.2834, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(487, 2074.2920, -2628.6638, 13.6806, 0.7214, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(487, 2087.8315, -2628.0190, 13.6806, 1.9612, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 2091.4028, -2609.9272, 12.9702, 22.6083, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 2092.7344, -2609.3184, 12.9702, 22.6083, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(521, 2094.4114, -2608.6082, 12.9702, 22.6083, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(521, 2096.1890, -2607.8818, 12.9702, 22.6083, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(471, 2093.7173, -2613.5928, 13.2544, 19.2543, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(471, 2096.6799, -2612.6060, 13.2544, 22.1197, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1998.7465, -2613.0520, 13.0226, 0.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(522, 1996.2921, -2613.0090, 13.0226, 0.0000, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(513, 1934.5646, -2632.1770, 14.3575, 0.7795, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(513, 1949.5939, -2632.2036, 14.3575, 0.7795, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(513, 1963.1796, -2632.4641, 14.3575, 0.7795, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(513, 1975.7382, -2632.9780, 14.3575, 0.7795, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 2121.5798, -2587.3481, 13.1381, 71.6435, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(506, 2123.2644, -2583.5505, 13.1381, 71.6435, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(487,2001.7561,-2458.3337,16.0061,88.7553,3,0, RESPAWN_TIME); // Heli LSAIR


	// Hugejump (24 before, 10 now)
	AddStaticVehicle(411, 869.8128, 2487.6746, 726.1065, 359.9354, 106, 1); // Infernus
	AddStaticVehicle(411, 877.0562, 2517.5615, 726.1065, 148.5329, 80, 1); // Infernus
	AddStaticVehicle(411, 881.5177, 2517.7100, 726.1065, 150.7935, 75, 1); // Infernus
	AddStaticVehicle(411, 885.5358, 2517.6194, 726.1065, 151.0612, 12, 1); // Infernus
	AddStaticVehicle(411, 889.5771, 2517.5979, 726.1065, 153.0783, 64, 1); // Infernus
	AddStaticVehicle(541, 882.5394, 2497.8218, 726.0045, 179.6761, 51, 1); // Bullet
	AddStaticVehicle(541, 882.5671, 2506.6091, 726.0044, 359.9933, 6, 1); // Bullet
	AddStaticVehicle(437, 909.9395, 2498.8657, 726.4933, 90.0142, 98, 20); // Coach
	AddStaticVehicle(437, 909.9376, 2506.4529, 726.4933, 90.0142, 98, 20); // Coach
	AddStaticVehicle(411, 872.9805, 2487.6809, 726.1075, 0.0698, 106, 1); // Infernus

	// Tugfun
	AddStaticVehicleEx(574, 2770.920, -1300.075, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2778.370, -1300.075, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2778.370, -1293.450, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2770.690, -1293.450, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2770.690, -1286.351, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2777.988, -1286.351, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2777.988, -1277.801, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2770.561, -1277.801, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2770.561, -1269.551, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(574, 2777.480, -1269.551, 4316.250, 0.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// pipe
	AddStaticVehicleEx(411, -126.214, -1678.146, 1576.556, 270.0, 6, 6, RESPAWN_TIME); //colors : 6 6
	AddStaticVehicleEx(411, -126.089, -1684.874, 1576.556, 271.0, 126, 126, RESPAWN_TIME); //colors : 126 126
	AddStaticVehicleEx(411, -114.689, -1684.573, 1576.556, 270.0, 93, 93, RESPAWN_TIME); //colors : 93 93
	AddStaticVehicleEx(411, -114.689, -1678.797, 1576.556, 270.0, 1, 1, RESPAWN_TIME); //colors : 1 1

	// karttrack
	AddStaticVehicleEx(571, -2792.502, 2931.710, 9.567, 276.0, randomColors[random(23)], -1, 10);
	AddStaticVehicleEx(571, -2792.452, 2928.212, 9.617, 276.0, randomColors[random(23)], -1, 10);
	AddStaticVehicleEx(571, -2792.452, 2926.312, 9.617, 276.0, randomColors[random(23)], -1, 10);
	AddStaticVehicleEx(571, -2792.452, 2923.235, 9.617, 276.0, randomColors[random(23)], -1, 10);
	AddStaticVehicleEx(571, -2792.452, 2933.684, 9.617, 276.0, randomColors[random(23)], -1, 10);

	// Beach
	AddStaticVehicleEx(411, 507.9995, -1849.2954, 3.9072, 138.1678, 106, 1, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(541, 505.3696, -1846.5250, 4.0375, 130.0203, 68, 8, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(451, 502.9214, -1843.6100, 4.2680, 120.6748, 18, 18, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(522, 488.3159, -1839.7455, 4.2539, 176.6135, 8, 82, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(522, 489.6462, -1839.7292, 4.2733, 177.4093, 36, 105, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(522, 490.9558, -1839.7206, 4.2867, 175.7444, 39, 106, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(522, 492.1526, -1839.7592, 4.2984, 178.1928, 51, 118, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(522, 493.3857, -1839.7959, 4.3106, 177.2349, 3, 3, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(451, 511.3077, -1851.5992, 3.8169, 153.6825, 46, 46, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(541, 514.7314, -1852.9608, 3.7995, 154.9973, 2, 1, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(411, 517.8326, -1854.5127, 3.8617, 155.7549, 80, 1, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(451, 520.6971, -1856.1467, 3.8467, 156.4290, 61, 61, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(541, 523.8621, -1857.2828, 3.8417, 155.3006, 13, 8, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(411, 526.8762, -1858.9620, 3.9010, 151.6116, 75, 1, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(556, 532.8651, -1854.6544, 4.9473, 200.4104, 1, 1, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(556, 538.3834, -1851.7352, 5.1579, 221.6103, 1, 1, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(556, 542.2431, -1847.4724, 5.4742, 235.5860, 1, 1, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(468, 495.2148, -1840.0144, 4.4285, 161.7401, 46, 46, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(468, 496.3193, -1840.6538, 4.3902, 160.6914, 53, 53, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(468, 497.5660, -1840.8737, 4.3911, 160.5590, 3, 3, RESPAWN_TIME); // BEACHCAR
	AddStaticVehicleEx(468, 498.6552, -1841.3125, 4.3729, 162.6971, 6, 6, RESPAWN_TIME); // BEACHCAR

	// BMX
	AddStaticVehicleEx(481, 3356.373, -1939.610, 43.277, 37.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME); // front row start
	AddStaticVehicleEx(481, 3357.444, -1938.734, 43.277, 37.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 3358.614, -1937.733, 43.277, 37.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 3359.710, -1936.782, 43.277, 37.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 3360.656, -1935.831, 43.277, 37.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 3361.528, -1934.930, 43.277, 37.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(481, 3362.524, -1933.954, 43.277, 37.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);

	// lf
	AddStaticVehicleEx(437, 4192.4346, 1894.1066, 2836.2329, 180.1074, 95, 16, RESPAWN_TIME); //
	AddStaticVehicleEx(403, 4206.9297, 1888.9043, 2836.7334, 179.8585, 25, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(462, 4197.0542, 1897.6669, 2835.6985, 175.9262, 1, 3, RESPAWN_TIME); //
	AddStaticVehicleEx(571, 4199.2739, 1897.9971, 2835.3828, 178.6466, 11, 22, RESPAWN_TIME); //
	AddStaticVehicleEx(522, 4201.2617, 1897.8549, 2835.6677, 177.3986, 3, 8, RESPAWN_TIME); //
	AddStaticVehicleEx(468, 4202.7471, 1898.2010, 2835.7673, 182.0678, 6, 6, RESPAWN_TIME); //
	AddStaticVehicleEx(451, 4207.3989, 1873.7778, 2835.8071, 179.5480, 36, 36, RESPAWN_TIME); //
	AddStaticVehicleEx(411, 4192.3262, 1876.3116, 2835.8281, 179.2995, 112, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(515, 4207.2271, 1831.2400, 2836.9893, 179.8684, 54, 77, RESPAWN_TIME); //
	AddStaticVehicleEx(515, 4193.0854, 1829.3533, 2837.0408, 180.7632, 39, 78, RESPAWN_TIME); //
	AddStaticVehicleEx(495, 4192.3843, 1859.3597, 2836.4539, 180.2284, 88, 99, RESPAWN_TIME); //
	AddStaticVehicleEx(573, 4207.3413, 1851.8237, 2836.7361, 181.5821, 79, 7, RESPAWN_TIME); //

	// Drop
	AddStaticVehicleEx(437, 295.2772, 5518.7529, 3426.8425, 179.9044, 98, 20, RESPAWN_TIME); //
	AddStaticVehicleEx(437, 299.9650, 5518.7461, 3426.8142, 179.9592, 105, 20, RESPAWN_TIME); //
	AddStaticVehicleEx(437, 306.0609, 5518.2681, 3426.8396, 182.4004, 123, 20, RESPAWN_TIME); //
	AddStaticVehicleEx(403, 314.0976, 5515.1069, 3427.3162, 181.1478, 40, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(515, 321.8836, 5515.2520, 3427.7051, 182.4097, 39, 78, RESPAWN_TIME); //
	AddStaticVehicleEx(411, 296.2367, 5469.1797, 3426.4128, 214.0033, 116, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(411, 295.5437, 5474.8315, 3426.4172, 214.9778, 112, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(411, 296.0901, 5481.6401, 3426.4116, 212.6263, 106, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(451, 323.3621, 5451.6719, 3426.3926, 88.3324, 36, 36, RESPAWN_TIME); //
	AddStaticVehicleEx(451, 323.8262, 5456.5967, 3426.3931, 87.6806, 16, 16, RESPAWN_TIME); //
	AddStaticVehicleEx(429, 325.5258, 5470.3965, 3426.7083, 119.4173, 1, 53, RESPAWN_TIME); //
	AddStaticVehicleEx(515, 325.3492, 5483.7148, 3427.7334, 158.5261, 11, 76, RESPAWN_TIME); //
	AddStaticVehicleEx(437, 298.5371, 5459.1216, 3426.8149, 201.3065, 125, 21, RESPAWN_TIME); //

	// BC
	AddStaticVehicleEx(539, 1683.484, 2870.186, 135.237, 22.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(539, 1686.705, 2871.931, 135.237, 22.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(539, 1689.725, 2873.777, 135.237, 22.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(539, 1691.959, 2884.243, 135.237, 114.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(539, 1693.547, 2881.117, 135.237, 114.0, random(124), random(124), RESPAWN_TIME);

	// SKC
	AddStaticVehicleEx(411, 2499.052, -1712.752, 714.053, 49.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 2500.020, -1707.464, 714.093, 65.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 2500.474, -1702.088, 714.053, 89.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(411, 2500.639, -1698.139, 714.225, 89.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(495, 2500.695, -1693.667, 714.053, 89.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(495, 2500.743, -1688.841, 714.053, 104.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(495, 2500.727, -1683.444, 714.053, 114.0, randomColors[random(23)], randomColors[random(23)], RESPAWN_TIME);
	AddStaticVehicleEx(495, 2496.7695, -1682.6733, 714.4841, 145.8618, 116, 115, RESPAWN_TIME); // SKC-SANDKING-1
	AddStaticVehicleEx(495, 2492.3821, -1682.1968, 714.4744, 143.5598, 118, 117, RESPAWN_TIME); // SKC-SANDKING-2
	AddStaticVehicleEx(495, 2487.4084, -1682.4930, 714.4854, 140.7898, 88, 99, RESPAWN_TIME); // SKC-SANDKING-3
	AddStaticVehicleEx(495, 2483.0732, -1681.9093, 714.4766, 138.8117, 123, 124, RESPAWN_TIME); // SKC-SANDKING-4
	AddStaticVehicleEx(411, 2492.8040, -1702.8378, 713.8555, 358.7053, 112, 1, RESPAWN_TIME); // SKC-INFERNUS-1
	AddStaticVehicleEx(411, 2489.7368, -1702.1782, 713.8554, 358.9635, 106, 1, RESPAWN_TIME); // SKC-INFERNUS-2
	AddStaticVehicleEx(411, 2489.8560, -1692.7321, 713.8554, 178.3621, 75, 1, RESPAWN_TIME); // SKC-INFERNUS-3
	AddStaticVehicleEx(411, 2493.1553, -1692.8263, 713.8554, 178.3621, 75, 1, RESPAWN_TIME); // SKC-INFERNUS-4
	AddStaticVehicleEx(411, 2486.6213, -1692.8176, 713.8488, 178.4592, 75, 1, RESPAWN_TIME); // SKC-INFERNUS-5
	AddStaticVehicleEx(411, 2486.4668, -1702.1232, 713.8555, 358.6184, 75, 1, RESPAWN_TIME); // SKC-INFERNUS-6

	// Waterjump
	AddStaticVehicleEx(411, 2360.875, -61.132, 366.698, 32.0, 182, 182, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2362.313, -50.216, 366.698, 32.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(411, 2362.079, -38.661, 366.698, 32.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(411, 2336.730, -45.251, 366.698, 330.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(411, 2337.840, -52.867, 366.698, 330.0, random(124), random(124), RESPAWN_TIME);
	AddStaticVehicleEx(411, 2337.458, -64.217, 366.698, 329.0, random(124), random(124), RESPAWN_TIME);

	// Glassjump
	AddStaticVehicleEx(411, 2106.4790, 2531.5889, 514.2835, 272.4342, 116, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(411, 2137.0063, 2531.8806, 514.2835, 89.8856, 112, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(451, 2136.3911, 2538.1021, 514.2625, 90.7610, 46, 46, RESPAWN_TIME); //
	AddStaticVehicleEx(409, 2107.4998, 2524.6316, 514.3549, 181.2722, 1, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(522, 2106.4905, 2546.8992, 514.1199, 275.0043, 6, 25, RESPAWN_TIME); //
	AddStaticVehicleEx(522, 2106.4883, 2550.2693, 514.1267, 272.4620, 7, 79, RESPAWN_TIME); //
	AddStaticVehicleEx(411, 2106.8972, 2537.8145, 514.2835, 269.4319, 80, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(588, 2136.0476, 2524.8823, 514.7932, 183.9044, 3, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(502, 2135.8655, 2550.9941, 514.4494, 89.1656, 58, 67, RESPAWN_TIME); //
	AddStaticVehicleEx(541, 2135.8096, 2563.6575, 514.1815, 87.9459, 68, 8, RESPAWN_TIME); //
	AddStaticVehicleEx(480, 2135.5938, 2576.4851, 514.3284, 91.7081, 2, 2, RESPAWN_TIME); //
	AddStaticVehicleEx(568, 2106.2695, 2556.8926, 514.4244, 275.7083, 21, 1, RESPAWN_TIME); //
	AddStaticVehicleEx(495, 2106.5718, 2563.4021, 514.9056, 270.2839, 101, 106, RESPAWN_TIME); //
	AddStaticVehicleEx(588, 2106.8540, 2569.8445, 514.5861, 270.9199, 1, 16, RESPAWN_TIME); //

	// Bikeskills
	AddStaticVehicleEx(522,-2872.9666,428.5565,4.5550,86.3252,36,105, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2872.9724,429.9486,4.5552,89.0121,39,106, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2872.9973,427.2245,4.5519,90.9003,51,118, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2873.0444,426.0315,4.5489,88.0342,3,3, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2873.1213,424.8421,4.5385,88.9996,3,8, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2873.0901,423.5652,4.5302,90.6830,7,79, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2873.1821,422.1867,4.5178,90.6522,8,82, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2872.9573,431.2225,4.5541,88.3816,36,105, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2872.8564,432.4106,4.5538,89.3254,39,106, RESPAWN_TIME); // BIKESKILLS
	AddStaticVehicleEx(522,-2872.9397,433.4531,4.5548,86.4845,51,118, RESPAWN_TIME); // BIKESKILLS

	// MonsterChallenge
	AddStaticVehicle(556,1279.9567,-2576.2837,6.9096,89.3966,155,255); // mc
	AddStaticVehicle(556,1280.2623,-2570.8213,6.9773,89.7708,147,255); // mc
	AddStaticVehicle(556,1279.3501,-2565.0190,6.8027,93.2127,161,255); // mc
	AddStaticVehicle(556,1280.0494,-2559.6013,6.9488,93.9453,130,255); // mc

	// LVdrift
	AddStaticVehicleEx(559,-314.440,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(560,-317.665,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(587,-320.739,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,-323.839,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(451,-326.864,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,-329.964,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(451,-333.064,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,-336.039,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(451,-339.264,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(541,-342.739,1515.122,75.157,0.0,randomColors[random(23)],-1, RESPAWN_TIME);

	// Quadparkour
	AddStaticVehicleEx(471,-2910.798,882.353,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(471,-2910.795,885.221,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(471,-2910.900,879.340,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(471,-2910.971,888.487,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(471,-2914.128,879.450,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(471,-2914.371,881.921,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(471,-2914.201,885.362,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(471,-2914.342,888.490,5.778,90.0,randomColors[random(23)],-1, RESPAWN_TIME);

	// racetrack
	AddStaticVehicleEx(411,9471.609,-840.704,7.970,269.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,9471.482,-845.227,7.970,269.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,9471.410,-851.019,7.970,269.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,9471.516,-856.507,7.970,269.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,9471.354,-862.892,7.970,269.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,9471.744,-834.148,7.970,269.0,randomColors[random(23)],-1, RESPAWN_TIME);
	AddStaticVehicleEx(411,9471.535,-826.170,7.970,269.0,randomColors[random(23)],-1, RESPAWN_TIME);

	//lvair
	AddStaticVehicleEx(411,1306.25061035,1278.93981934,10.62031269,0.24719238,randomColors[random(23)],-1,RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(411,1309.57360840,1279.07617188,10.56885719,0.24719238,randomColors[random(23)],-1,RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(411,1312.77416992,1279.08898926,10.56885719,0.24719238,randomColors[random(23)],-1,RESPAWN_TIME); //Infernus
	AddStaticVehicleEx(522,1329.80957031,1279.55419922,10.48069000,0.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,1328.10888672,1279.55383301,10.48069000,0.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,1326.20581055,1279.62536621,10.48069000,0.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(522,1324.45275879,1279.59948730,10.48069000,0.0,randomColors[random(23)],-1,RESPAWN_TIME); //NRG-500
	AddStaticVehicleEx(429,1282.96484375,1290.23681641,10.57031250,270.99975586,randomColors[random(23)],-1,RESPAWN_TIME); //Banshee
	AddStaticVehicleEx(451,1283.08300781,1293.23046875,10.68155670,271.99951172,randomColors[random(23)],-1,RESPAWN_TIME); //Turismo
	AddStaticVehicleEx(477,1271.44482422,1290.71228027,10.67031288,270.0,randomColors[random(23)],-1,RESPAWN_TIME); //ZR-350
	AddStaticVehicleEx(506,1283.20556641,1300.58459473,10.65430450,270.0,randomColors[random(23)],-1,RESPAWN_TIME); //Super GT
	AddStaticVehicleEx(541,1283.12548828,1303.69567871,10.54988289,271.74682617,randomColors[random(23)],-1,RESPAWN_TIME); //Bullet
	AddStaticVehicleEx(402,1271.57556152,1294.70288086,10.75295925,272.0,randomColors[random(23)],-1,RESPAWN_TIME); //Buffalo
	AddStaticVehicleEx(559,1271.28588867,1300.21789551,10.56702328,270.0,randomColors[random(23)],-1,RESPAWN_TIME); //Jester
	AddStaticVehicleEx(560,1271.01367188,1304.30175781,10.62528801,271.25000000,randomColors[random(23)],-1,RESPAWN_TIME); //Sultan
	AddStaticVehicleEx(562,1271.05859375,1308.47912598,10.57386208,270.0,randomColors[random(23)],-1,RESPAWN_TIME); //Elegy
	AddStaticVehicleEx(573,1355.50878906,1258.34790039,11.53576088,268.0,randomColors[random(23)],-1,RESPAWN_TIME); //Duneride
	AddStaticVehicleEx(573,1355.60925293,1254.51660156,11.53576088,267.99499512,randomColors[random(23)],-1,RESPAWN_TIME); //Duneride
	AddStaticVehicleEx(557,1356.92687988,1248.36962891,11.31295967,270.0,randomColors[random(23)],-1,RESPAWN_TIME); //Monster B
	AddStaticVehicleEx(557,1356.83752441,1244.00366211,11.31295967,268.49548340,randomColors[random(23)],-1,RESPAWN_TIME); //Monster B
	AddStaticVehicleEx(568,1355.07104492,1239.04028320,10.79531288,270.0,randomColors[random(23)],-1,RESPAWN_TIME); //Bandito
	AddStaticVehicleEx(568,1354.95788574,1235.70642090,10.79531288,270.0,randomColors[random(23)],-1,RESPAWN_TIME); //Bandito
	AddStaticVehicleEx(483,1354.58300781,1232.80212402,10.91590881,272.0,randomColors[random(23)],-1,RESPAWN_TIME); //Camper
	AddStaticVehicleEx(480,1282.87402344,1306.90576172,10.67031288,270.49987793,randomColors[random(23)],-1,RESPAWN_TIME); //Comet

	//Drag Vehicles
	AddStaticVehicleEx(411, 2958.2954, -648.5739, 1.5463, 312.3161, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2970.0745, -649.4385, 1.5463, 312.3161, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2959.1660, -630.1429, 1.5463, 219.9043, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2962.2002, -649.1841, 1.5463, 312.3161, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2966.0835, -649.3376, 1.5463, 312.3161, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2971.0068, -630.1397, 1.5463, 219.7033, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2967.2498, -629.9748, 1.5463, 219.7033, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, 2963.4458, -630.1227, 1.5463, 219.9043, randomColors[random(23)], -1, RESPAWN_TIME);

	//LoopJump Vehicles
	AddStaticVehicleEx(411, -2684.6594, 412.1765, 922.2933, 301.7621, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2687.5938, 404.2379, 922.2933, 301.7621, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2690.8694, 397.3112, 922.2933, 301.7621, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2693.9944, 390.2110, 922.2933, 301.7621, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2697.2212, 384.2079, 922.2933, 301.7621, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(411, -2699.5215, 378.9331, 922.2933, 301.7621, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2659.7839, 401.8220, 922.1671, 0.0000, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2663.2458, 394.2377, 922.1671, 0.0000, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2667.0225, 387.5565, 922.1671, 0.0000, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2670.3765, 381.2830, 922.1671, 0.0000, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2672.6609, 375.0621, 922.1671, 0.0000, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2675.7244, 369.4580, 922.1671, 0.0000, randomColors[random(23)], -1, RESPAWN_TIME);
	AddStaticVehicleEx(451, -2678.0754, 364.1996, 922.1671, 0.0000, randomColors[random(23)], -1, RESPAWN_TIME);

	//WaterPark
	AddStaticVehicle(495, -2095.1272, -2790.2932, 8.4255, 168.4499, 116, 115); //Sandking
	AddStaticVehicle(468, -2104.6079, -2783.1196, 8.9023, 127.8936, 46, 46); //Sanchez
	AddStaticVehicle(493, -2097.9460, -2866.1758, -0.4387, 175.8411, 6, 0); //Jetmax
	AddStaticVehicle(493, -2109.1853, -2851.4963, -0.3850, 179.3839, 0, 3); //Jetmax
	AddStaticVehicle(493, -2089.9565, -2852.4773, -0.2012, 180.7061, 0, 6); //Jetmax
	AddStaticVehicle(493, -2076.6670, -2872.0967, -0.2856, 178.0286, 3, 0); //Jetmax
}


// --------------------------------------------------
// Helmet offsets, rotations and scales
// --------------------------------------------------
new Float:HelmetPos[300][9] =
{
	{0.07, 0.0, 0.0, 88.0, 75.0, 0.0}, //skin 0
	{0.07, 0.0, 0.0, 88.0, 77.0, 0.0}, //skin 1
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 2
	{0.082272, 0.012175, 0.000000, 88.573463, 83.217987, 0.571479, 1.037069}, //skin 3
	{0.106029, 0.020526, 0.000000, 88.573463, 83.217987, 0.571479, 1.011797}, //skin 4
	{0.065514, 0.029894, 0.000000, 88.573463, 83.217987, 0.571479, 1.067914}, //skin 5
	{0.081949, 0.035309, 0.000000, 88.573463, 83.217987, 0.571479, 1.037069}, //skin 6
	{0.09, 0.019999, 0.0, 88.0, 90.0, 0.0}, //skin 7
	{0.07, 0.0, 0.0, 88.0, 77.0, 0.0}, //skin 8
	{0.059999, 0.019999, 0.0, 88.0, 90.0, 0.0}, //skin 9
	{0.090000, 0.019999, 0.0, 88.0, 90.0, 0.0}, //skin 10
	{0.07, 0.019999, 0.0, 88.0, 90.0, 0.0}, //skin 11
	{0.07, 0.019999, 0.0, 88.0, 90.0, 0.0}, //skin 12
	{0.07, 0.019999, 0.0, 88.0, 90.0, 0.0}, //skin 13
	{0.071141, 0.033483, 0.000000, 89.899635, 82.456283, 0.000000}, //skin 14
	{0.059999, 0.0, 0.0, 88.0, 82.0, 0.0}, //skin 15
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 16
	{0.059999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 17
	{0.059999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 18
	{0.071141, 0.033483, 0.000000, 89.899635, 82.456283, 0.000000}, //skin 19
	{0.071141, 0.012607, 0.000000, 89.899635, 82.456283, 0.000000}, //skin 20
	{0.059999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 21
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 22
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 23
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 24
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 25
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 26
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 27
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 28
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 29
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 30
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 31
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 32
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 33
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 34
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 35
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 36
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 37
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 38
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 39
	{0.050000, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 40
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 41
	{0.065985, 0.011633, 0.000000, 88.573463, 83.217987, 0.571479, 1.002084}, //skin 42
	{0.07, 0.0, 0.0, 88.0, 77.0, 0.0}, //skin 43
	{0.07, 0.0, 0.0, 88.0, 77.0, 0.0}, //skin 44
	{0.07, 0.0, 0.0, 88.0, 77.0, 0.0}, //skin 45
	{0.071141, 0.026406, 0.000000, 89.899635, 82.456283, 0.000000}, //skin 46
	{0.071141, 0.026406, 0.000000, 89.899635, 82.456283, 0.000000}, //skin 47
	{0.071141, 0.026406, 0.000000, 89.899635, 82.456283, 0.000000}, //skin 48
	{0.07, 0.0, 0.0, 88.0, 77.0, 0.0}, //skin 49
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 50
	{0.100000, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 51
	{0.100000, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 52
	{0.071141, 0.048094, 0.000000, 89.899635, 82.456283, 0.000000}, //skin 53
	{0.100000, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 54
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 55
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 56
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 57
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 58
	{0.079999, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 59
	{0.079999, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 60
	{0.079999, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 61
	{0.079999, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 62
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 63
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 64
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 65
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 66
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 67
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 68
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 69
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 70
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 71
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 72
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 73
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 74
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 75
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 76
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 77
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 78
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 79
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 80
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 81
	{0.097840, 0.029344, 0.000000, 89.899635, 82.456283, 0.000000, 1.134920, 1.002417, 1.045661}, //skin 82
	{0.097840, 0.029344, 0.000000, 89.899635, 82.456283, 0.000000, 1.134920, 1.002417, 1.045661}, //skin 83
	{0.097840, 0.029344, 0.000000, 89.899635, 82.456283, 0.000000, 1.134920, 1.002417, 1.045661}, //skin 84
	{0.075789, 0.029344, 0.000000, 89.899635, 82.456283, 0.000000, 1.134920, 1.005379, 0.995997}, //skin 85
	{0.060571, 0.013831, 0.000000, 88.573463, 83.217987, 0.571479, 1.002084}, //skin 86
	{0.086140, 0.033741, 0.000000, 89.899635, 82.456283, 0.000000, 1.134920, 1.002417, 1.045661}, //skin 87
	{0.07, 0.039999, 0.0, 88.0, 82.0, 0.0}, //skin 88
	{0.086140, 0.004411, 0.000000, 89.899635, 82.456283, 0.000000, 1.012524, 1.000668, 0.999287}, //skin 89
	{0.054694, 0.021682, 0.007682, 90.191528, 75.430236, 0.296153}, //skin 90
	{0.054694, 0.021682, 0.007682, 90.191528, 75.430236, 0.296153}, //skin 91
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 92
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 93
	{0.050000, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 94
	{0.050000, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 95
	{0.050000, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 96
	{0.050000, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 97
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 98
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 99
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 100
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 101
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 102
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 103
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 104
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 105
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 106
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 107
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 108
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 109
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 110
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 111
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 112
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 113
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 114
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 115
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 116
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 117
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 118
	{0.065985, 0.011633, 0.000000, 88.573463, 83.217987, 0.571479, 1.002084}, //skin 119
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 120
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 121
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 122
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 123
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 124
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 125
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 126
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 127
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 128
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 129
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 130
	{0.079999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 131
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 132
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 133
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 134
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 135
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 136
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 137
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 138
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 139
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 140
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 141
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 142
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 143
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 144
	{0.090000, 0.0, 0.0, 88.0, 82.0, 0.0}, //skin 145
	{0.090000, 0.0, 0.0, 88.0, 82.0, 0.0}, //skin 146
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 147
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 148
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 149
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 150
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 151
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 152
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 153
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 154
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 155
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 156
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 157
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 158
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 159
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 160
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 161
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 162
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 163
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 164
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 165
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 166
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 167
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 168
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 169
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 170
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 171
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 172
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 173
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 174
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 175
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 176
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 177
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 178
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 179
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 180
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 181
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 182
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 183
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 184
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 185
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 186
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 187
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 188
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 189
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 190
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 191
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 192
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 193
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 194
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 195
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 196
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 197
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 198
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 199
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 200
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 201
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 202
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 203
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 204
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 205
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 206
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 207
	{0.060571, 0.013831, 0.000000, 88.573463, 83.217987, 0.571479, 1.002084}, //skin 208
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 209
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 210
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 211
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 212
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 213
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 214
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 215
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 216
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 217
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 218
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 219
	{0.029999, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 220
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 221
	{0.07, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 222
	{0.07, 0.050000, 0.0, 88.0, 82.0, 0.0}, //skin 223
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 224
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 225
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 226
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 227
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 228
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 229
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 230
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 231
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 232
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 233
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 234
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 235
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 236
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 237
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 238
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 239
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 240
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 241
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 242
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 243
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 244
	{0.07, 0.029999, 0.0, 88.0, 82.0, 0.0}, //skin 245
	{0.07, 0.050000, 0.0, 88.0, 82.0, 0.0}, //skin 246
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 247
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 248
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 249
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 250
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 251
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 252
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 253
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 254
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 255
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 256
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 257
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 258
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 259
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 260
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 261
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 262
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 263
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 264
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 265
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 266
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 267
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 268
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 269
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 270
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 271
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 272
	{0.060571, 0.013831, 0.000000, 88.573463, 83.217987, 0.571479, 1.002084}, //skin 273
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 274
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 275
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 276
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 277
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 278
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 279
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 280
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 281
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 282
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 283
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 284
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 285
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 286
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 287
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 288
	{0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, //skin 289
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 290
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 291
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 292
	{0.07, 0.019999, 0.0, 88.0, 82.0, 0.0}, //skin 293
	{0.07, 0.019999, 0.0, 91.0, 84.0, 0.0}, //skin 294
	{0.050000, 0.019998, 0.0, 86.0, 82.0, 0.0}, //skin 295
	{0.064999, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 296
	{0.064999, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 297
	{0.064999, 0.009999, 0.0, 88.0, 82.0, 0.0}, //skin 298
	{0.064998, 0.019999, 0.0, 88.0, 82.0, 0.0} //skin 299
};

new componentName[][] =
{
	"Pro Spoiler",
	"Win Spoiler",
	"Drag Spoiler",
	"Alpha Spoiler",
	"Champ Scoop Hood",
	"Fury Scoop Hood",
	"Roof Scoop",
	"Right Sideskirt",
	"5x Nitro",
	"2x Nitro",
	"10x Nitro",
	"Race Scoop Hood",
	"Worx Scoop Hood",
	"Round Fog Lamps",
	"Champ Spoiler",
	"Race Spoiler",
	"Worx Spoiler",
	"Left Sideskirt",
	"Upswept Exhaust",
	"Twin Exhaust",
	"Large Exhaust",
	"Medium Exhaust",
	"Small Exhaust",
	"Fury Spoiler",
	"Square Fog Lamps",
	"Offroad Wheels",
	"Right Alien Sideskirt", // Sultan
	"Left Alien Sideskirt", // Sultan
	"Alien Exhaust", // Sultan
	"X-Flow Exhaust", // Sultan
	"Left X-Flow Sideskirt", // Sultan
	"Right X-Flow Sideskirt", // Sultan
	"Alien Roof Vent", // Sultan
	"X-Flow Roof Vent", // Sultan
	"Alien Exhaust", // Elegy
	"X-Flow Roof Vent", // Elegy
	"Right Alien Sideskirt", // Elegy
	"X-Flow Exhaust", // Elegy
	"Alien Roof Vent", // Elegy
	"Right X-Flow Sideskirt", // Elegy
	"Left Alien Sideskirt", // Elegy
	"Right X-Flow Sideskirt", // Elegy
	"Right Chrome Sideskirt", // Broadway
	"Slamin Exhaust", // Broadway
	"Chrome Exhaust", // Broadway
	"X-Flow Exhaust", // Flash
	"Alien Exhaust", // Flash
	"Right Alien Sideskirt", // Flash
	"Right X-Flow Sideskirt", // Flash
	"Alien Spoiler", // Flash
	"X-Flow Spoiler", // Flash
	"Left Alien Sideskirt", // Flash
	"Left X-Flow Sideskirt", // Flash
	"X-Flow Roof", // Flash
	"Alien Roof", // Flash
	"Alien Roof", // Stratum
	"Right Alien Sideskirt", // Stratum
	"Right X-Flow Sideskirt", // Stratum
	"Alien Spoiler", // Stratum
	"X-Flow Exhaust", // Stratum
	"X-Flow Spoiler", // Stratum
	"X-Flow Roof", // Stratum
	"Left Alien Sideskirt", // Stratum
	"Left X-Flow Sideskirt", // Stratum
	"Alien Exhaust", // Stratum
	"Alien Exhaust", // Jester
	"X-Flow Exhaust", // Jester
	"Alien Roof", // Jester
	"X-Flow Roof", // Jester
	"Right Alien Sideskirt", // Jester
	"Right X-Flow Sideskirt", // Jester
	"Left Alien Sideskirt", // Jester
	"Left X-Flow Sideskirt", // Jester
	"Shadow Wheels",
	"Mega Wheels",
	"Rimshine Wheels",
	"Wires Wheels",
	"Classic Wheels",
	"Twist Wheels",
	"Cutter Wheels",
	"Switch Wheels",
	"Grove Wheels",
	"Import Wheels",
	"Dollar Wheels",
	"Trance Wheels",
	"Atomic Wheels",
	"Stereo Sound",
	"Hydraulics",
	"Alien Roof", // Uranus
	"X-Flow Exhaust", // Uranus
	"Right Alien Sideskirt", // Uranus
	"X-Flow Roof", // Uranus
	"Alien Exhaust", // Uranus
	"Right X-Flow Sideskirt", // Uranus
	"Left Alien Sideskirt", // Uranus
	"Right X-Flow Sideskirt", // Uranus
	"Ahab Wheels",
	"Virtual Wheels",
	"Access Wheels",
	"Left Chrome Sideskirt", // Broadway
	"Chrome Grill Bullbar", // Remington
	"Left 'Chrome Flames' Sideskirt", // Remington
	"Left 'Chrome Strip' Sideskirt", // Savanna
	"Corvetible Roof", // Blade
	"Chrome Exhaust", // Blade
	"Slamin Exhaust", // Blade
	"Right 'Chrome Arches' Sideskirt", // Remington
	"Left 'Chrome Strip' Sideskirt", // Blade
	"Right 'Chrome Strip' Sideskirt", // Blade
	"Chrome Rear Bullbars", // Slamvan
	"Slamin Rear Bullbars", // Slamvan
	"Little Front Sign", // Slamvan
	"Little Front Sign", // Slamvan
	"Chrome Exhaust", // Slamvan
	"Slamin Exhaust", // Slamvan
	"Chrome Front Bullbars", // Slamvan
	"Slamin Front Bullbars", // Slamvan
	"Chrome Front Bumper", // Slamvan
	"Right 'Chrome Trim' Sideskirt", // Slamvan
	"Right 'Wheelcovers' Sideskirt", // Slamvan
	"Left 'Chrome Trim' Sideskirt", // Slamvan
	"Left 'Wheelcovers' Sideskirt", // Slamvan
	"Right 'Chrome Flames' Sideskirt", // Remington
	"Bullbar Chrome Bars", // Remington
	"Left 'Chrome Arches' Sideskirt", // Remington
	"Bullbar Chrome Lights", // Remington
	"Chrome Exhaust", // Remington
	"Slamin Exhaust", // Remington
	"Vinyl Hardtop", // Blade
	"Chrome Exhaust", // Savanna
	"Hardtop Roof", // Savanna
	"Softtop Roof", // Savanna
	"Slamin Exhaust", // Savanna
	"Right 'Chrome Strip' Sideskirt", // Savanna
	"Right 'Chrome Strip' Sideskirt", // Tornado
	"Slamin Exhaust", // Tornado
	"Chrome Exhaust", // Tornado
	"Left 'Chrome Strip' Sideskirt", // Tornado
	"Alien Spoiler", // Sultan
	"X-Flow Spoiler", // Sultan
	"X-Flow Rear Bumper", // Sultan
	"Alien Rear Bumper", // Sultan
	"Left Oval Vents",
	"Right Oval Vents",
	"Left Square Vents",
	"Right Square Vents",
	"X-Flow Spoiler", // Elegy
	"Alien Spoiler", // Elegy
	"X-Flow Rear Bumper", // Elegy
	"Alien Rear Bumper", // Elegy
	"Alien Rear Bumper", // Flash
	"X-Flow Rear Bumper", // Flash
	"X-Flow Front Bumper", // Flash
	"Alien Front Bumper", // Flash
	"Alien Rear Bumper", // Stratum
	"Alien Front Bumper", // Stratum
	"X-Flow Rear Bumper", // Stratum
	"X-Flow Front Bumper", // Stratum
	"X-Flow Spoiler", // Jester
	"Alien Rear Bumper", // Jester
	"Alien Front Bumper", // Jester
	"X-Flow Rear Bumper", // Jester
	"Alien Spoiler", // Jester
	"X-Flow Spoiler", // Uranus
	"Alien Spoiler", // Uranus
	"X-Flow Front Bumper", // Uranus
	"Alien Front Bumper", // Uranus
	"X-Flow Rear Bumper", // Uranus
	"Alien Rear Bumper", // Uranus
	"Alien Front Bumper", // Sultan
	"X-Flow Front Bumper", // Sultan
	"Alien Front Bumper", // Elegy
	"X-Flow Front Bumper", // Elegy
	"X-Flow Front Bumper", // Jester
	"Chrome Front Bumper", // Broadway
	"Slamin Front Bumper", // Broadway
	"Chrome Rear Bumper", // Broadway
	"Slamin Rear Bumper", // Broadway
	"Slamin Rear Bumper", // Remington
	"Chrome Front Bumper", // Remington
	"Chrome Rear Bumper", // Remington
	"Slamin Front Bumper", // Blade
	"Chrome Front Bumper", // Blade
	"Slamin Rear Bumper", // Blade
	"Chrome Rear Bumper", // Blade
	"Slamin Front Bumper", // Remington
	"Slamin Rear Bumper", // Savanna
	"Chrome Rear Bumper", // Savanna
	"Slamin Front Bumper", // Savanna
	"Chrome Front Bumper", // Savanna
	"Slamin Front Bumper", // Tornado
	"Chrome Front Bumper", // Tornado
	"Chrome Rear Bumper", // Tornado
	"Slamin Rear Bumper" // Tornado
};

stock AddVehicleComponentsFromList(vehicleid, list[])
{
	// DEBUG
	printf("AddVehicleComponentsFromList(%d, %s):", vehicleid, list);

	new modList[14];
	sscanf(list, "p<,>a<d>[14]", modList);

	for(new iter = 0; iter != 15; iter++)
	{
		// VALIDITY CHECK? Should check the data when updating the database instead, or is OnVehicleMod called with AddVehicleComponent as well?

		// DEBUG
		printf(" -> Adding component %d", modList[iter]);

		AddVehicleComponent(vehicleid, modList[iter]);
	}
}

// List of allowed mods for each vehicle
stock const
	// This is a packed array with [modelid - 400]{componentid - 1000}.
	g_LegalMods[][] = {
		{0x08090A0D, 0x12131415, 0x1819494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x00000000, 0x00000000, 0x00000000, 0}, // 400
		{0x01030405, 0x06070809, 0x0A0D1113, 0x1419494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x8E8F9091, 0x00000000, 0}, // 401
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 402
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 403
		{0x00020708, 0x090A0D10, 0x11131415, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x60616200, 0x00000000, 0x00000000, 0}, // 404
		{0x00010809, 0x0A0E1213, 0x14151719, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0}, // 405
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 406
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 407
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 408
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 409
		{0x01030708, 0x090A0D11, 0x13141517, 0x1819494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x00000000, 0x00000000, 0}, // 410
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 411
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 412
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 413
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 414
		{0x01030708, 0x090A1112, 0x13171949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62000000, 0x00000000, 0x00000000, 0}, // 415
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 416
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 417
		{0x02060809, 0x0A101415, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x60616200, 0x00000000, 0x00000000, 0x00000000, 0}, // 418
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 419
		{0x01030405, 0x08090A13, 0x1519494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x00000000, 0x00000000, 0x00000000, 0}, // 420
		{0x0008090A, 0x0E101213, 0x14151719, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0}, // 421
		{0x0708090A, 0x0D111314, 0x1519494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x00000000, 0x00000000, 0x00000000, 0}, // 422
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 423
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 424
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 425
		{0x01030405, 0x0608090A, 0x13151949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62000000, 0x00000000, 0x00000000, 0}, // 426
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 427
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 428
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 429
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 430
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 431
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 432
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 433
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 434
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 435
		{0x01030607, 0x08090A0D, 0x11131415, 0x1619494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x00000000, 0x00000000, 0}, // 436
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 437
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 438
		{0x01030708, 0x090A0D11, 0x1719494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x8E8F9091, 0x00000000, 0x00000000, 0}, // 439
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 440
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 441
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 442
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 443
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 444
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 445
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 446
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 447
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 448
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 449
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 450
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 451
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 452
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 453
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 454
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 455
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 456
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 457
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 458
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 459
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 460
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 461
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 462
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 463
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 464
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 465
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 466
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 467
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 468
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 469
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 470
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 471
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 472
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 473
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 474
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 475
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 476
		{0x06070809, 0x0A111213, 0x14151949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62000000, 0x00000000, 0x00000000, 0}, // 477
		{0x04050809, 0x0A0C0D14, 0x15161819, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0}, // 478
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 479
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 480
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 481
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 482
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 483
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 484
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 485
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 486
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 487
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 488
		{0x00020405, 0x0608090A, 0x0D101213, 0x14181949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62000000, 0x00000000, 0}, // 489
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 490
		{0x03070809, 0x0A0E1112, 0x13141517, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x6061628E, 0x8F909100, 0x00000000, 0}, // 491
		{0x00040506, 0x08090A10, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x60616200, 0x00000000, 0x00000000, 0x00000000, 0}, // 492
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 493
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 494
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 495
		{0x01020306, 0x0708090A, 0x0B111314, 0x1719494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x8E8F0000, 0x00000000, 0}, // 496
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 497
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 498
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 499
		{0x08090A0D, 0x13141518, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x60616200, 0x00000000, 0x00000000, 0x00000000, 0}, // 500
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 501
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 502
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 503
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 504
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 505
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 506
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 507
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 508
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 509
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 510
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 511
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 512
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 513
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 514
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 515
		{0x00020407, 0x08090A0F, 0x10111213, 0x14151949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62000000, 0x00000000, 0}, // 516
		{0x02030708, 0x090A1011, 0x12131417, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x6061628E, 0x8F909100, 0x00000000, 0}, // 517
		{0x01030506, 0x0708090A, 0x0D111214, 0x1719494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x8E8F9091, 0x00000000, 0}, // 518
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 519
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 520
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 521
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 522
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 523
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 524
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 525
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 526
		{0x01070809, 0x0A0E0F11, 0x12141519, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0}, // 527
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 528
		{0x01030607, 0x08090A0B, 0x0C111213, 0x14171949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62000000, 0x00000000, 0}, // 529
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 530
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 531
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 532
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 533
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61626465, 0x6A7A7B7C, 0x7D7E7FB2, 0xB3B4B900, 0x00000000, 0}, // 534
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61626D6E, 0x71727374, 0x75767778, 0x79000000, 0x00000000, 0}, // 535
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61626768, 0x696B6C80, 0xB5B6B7B8, 0x00000000, 0x00000000, 0}, // 536
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 537
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 538
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 539
		{0x01040607, 0x08090A11, 0x12131417, 0x1819494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x8E8F9091, 0x00000000, 0}, // 540
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 541
		{0x08090A0E, 0x0F121314, 0x1519494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x90910000, 0x00000000, 0x00000000, 0}, // 542
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 543
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 544
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 545
		{0x01020406, 0x0708090A, 0x11121317, 0x1819494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x8E8F9091, 0x00000000, 0}, // 546
		{0x00030809, 0x0A101213, 0x14151949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x628E8F00, 0x00000000, 0x00000000, 0}, // 547
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 548
		{0x01030708, 0x090A0B0C, 0x11121314, 0x1719494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x8E8F9091, 0x00000000, 0}, // 549
		{0x01030405, 0x0608090A, 0x12131417, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x6061628E, 0x8F909100, 0x00000000, 0}, // 550
		{0x02030506, 0x08090A10, 0x12131415, 0x1719494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x00000000, 0x00000000, 0}, // 551
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 552
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 553
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 554
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 555
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 556
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 557
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565758, 0x595A5B5C, 0x5D5E5F60, 0x6162A3A4, 0xA5A6A7A8, 0x00000000, 0}, // 558
		{0x08090A19, 0x41424344, 0x45464748, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61629E9F, 0xA0A1A2AD, 0x00000000, 0}, // 559
		{0x08090A19, 0x1A1B1C1D, 0x1E1F2021, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61628A8B, 0x8C8DA9AA, 0x00000000, 0}, // 560
		{0x08090A19, 0x1A1B1E1F, 0x3738393A, 0x3B3C3D3E, 0x3F40494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x9A9B9C9D, 0}, // 561
		{0x08090A19, 0x22232425, 0x26272829, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61629293, 0x9495ABAC, 0x00000000, 0}, // 562
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 563
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 564
		{0x08090A19, 0x2D2E2F30, 0x31323334, 0x3536494A, 0x4B4C4D4E, 0x4F505152, 0x53545556, 0x57606162, 0x96979899, 0x00000000, 0}, // 565
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 566
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61626681, 0x82838485, 0xBABBBCBD, 0x00000000, 0x00000000, 0}, // 567
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 568
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 569
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 570
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 571
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 572
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 573
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 574
		{0x08090A19, 0x2A2B2C49, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x6263AEAF, 0xB0B10000, 0x00000000, 0x00000000, 0}, // 575
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61628687, 0x8889BEBF, 0xC0C10000, 0x00000000, 0x00000000, 0}, // 576
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 577
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 578
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 579
		{0x01060708, 0x090A1112, 0x14171949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62000000, 0x00000000, 0x00000000, 0}, // 580
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 581
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 582
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 583
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 584
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 585
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 586
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 587
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 588
		{0x00040506, 0x0708090A, 0x0D101112, 0x14181949, 0x4A4B4C4D, 0x4E4F5051, 0x52535455, 0x56576061, 0x62909100, 0x00000000, 0}, // 589
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 590
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 591
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 592
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 593
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 594
		{0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 595
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 596
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 597
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 598
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 599
		{0x04050607, 0x08090A0D, 0x11121416, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x60616200, 0x00000000, 0x00000000, 0}, // 600
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 601
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 602
		{0x01060708, 0x090A1112, 0x13141718, 0x19494A4B, 0x4C4D4E4F, 0x50515253, 0x54555657, 0x6061628E, 0x8F909100, 0x00000000, 0}, // 603
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 604
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 605
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 606
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 607
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 608
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 609
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}, // 610
		{0x08090A19, 0x494A4B4C, 0x4D4E4F50, 0x51525354, 0x55565760, 0x61620000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0}  // 611
	}
;

// Valid component iterator
#define iterstart@ValidComponents -1
iterfunc ValidComponents(modelid, start)
{
	static cur;
	static modelidx;

	if (start == -1) {
		if (modelid < 400 || modelid > 611)
			return -1;

		modelidx = modelid - 400;
		cur = 0;
	}

	if (g_LegalMods[modelidx]{cur})
		return 1000 + g_LegalMods[modelidx]{cur++};

	return -1;
}


//=== Global Variables ===
new tmp[128],
	str[150],
	line[512];

new LastLoginRequest[MAX_PLAYERS];
// Player Information
enum Info
{
	pKills,
	pDeaths,
	pSeePMs,
	pEventsWon,
	pRacesWon,
	pParkoursWon,
	pMBFound,
	pSaveSkin,
	pRainbow,
}
new PMSound[MAX_PLAYERS];
new TogAnn[MAX_PLAYERS];
new warStats[10000];
new WarAway[MAX_PLAYERS];
new GangWarMinutes[10000];
new GangWarTimer[10000];
new ParticipatingWar[MAX_PLAYERS];
new OpponentGang[MAX_PLAYERS];
new GangWarRequester[10000];
new Float:GangWarLoc[10000][3];

new pInfo[MAX_PLAYERS][Info];
new pName[MAX_PLAYERS][24];
new pIP[MAX_PLAYERS][25];
new pCountry[MAX_PLAYERS][30];

new pWelcome[MAX_PLAYERS];
new pWelcomeR[MAX_PLAYERS];
new Garage[2];
new bool:GarageStatus[3];

new
	HayclimbChallenge[MAX_PLAYERS],
	ParkourChallenge[MAX_PLAYERS],
	MonsterChallenge[MAX_PLAYERS],
	QuadChallenge[MAX_PLAYERS],
	Bike1Challenge[MAX_PLAYERS],
	Skydive1Challenge[MAX_PLAYERS],
	Skydive2Challenge[MAX_PLAYERS],
	BMXChallenge[MAX_PLAYERS],
	Skydive3Challenge[MAX_PLAYERS],
	MultiPChallenge[MAX_PLAYERS],
	BP1Challenge[MAX_PLAYERS],
	BP2Challenge[MAX_PLAYERS],
	BP3Challenge[MAX_PLAYERS],
	BP4Challenge[MAX_PLAYERS],
	Parkour2Challenge[MAX_PLAYERS],
	BC2Challenge[MAX_PLAYERS],
	Parkour3Challenge[MAX_PLAYERS],
	Skydive4Challenge[MAX_PLAYERS],
	Hayclimb2Challenge[MAX_PLAYERS],
	Hayclimb3Challenge[MAX_PLAYERS],
	BP5Challenge[MAX_PLAYERS],
	BP6Challenge[MAX_PLAYERS],
	BP7Challenge[MAX_PLAYERS],
	Hayclimb4Challenge[MAX_PLAYERS],
	Quad2Challenge[MAX_PLAYERS],
	BP8Challenge[MAX_PLAYERS],
	Hayclimb5Challenge[MAX_PLAYERS],
	Hayclimb6Challenge[MAX_PLAYERS],
	Hayclimb7Challenge[MAX_PLAYERS],
	SanchezChallenge[MAX_PLAYERS],
	Sanchez2Challenge[MAX_PLAYERS],
	BC3Challenge[MAX_PLAYERS],
	Parkour4Challenge[MAX_PLAYERS],
	Skydive5Challenge[MAX_PLAYERS],
	Parkour5Challenge[MAX_PLAYERS],
	Skydive6Challenge[MAX_PLAYERS],
	Parkour6Challenge[MAX_PLAYERS],
	Parkour7Challenge[MAX_PLAYERS],
	BP9Challenge[MAX_PLAYERS],
	BC4Challenge[MAX_PLAYERS],
	Parkour8Challenge[MAX_PLAYERS],
	BP10Challenge[MAX_PLAYERS],
	Quad3Challenge[MAX_PLAYERS],
	Hayclimb8Challenge[MAX_PLAYERS],
	Sanchez3Challenge[MAX_PLAYERS],
	Skydive7Challenge[MAX_PLAYERS],
	MC2Challenge[MAX_PLAYERS],
	BC5Challenge[MAX_PLAYERS];

new bool:pLogged[MAX_PLAYERS],
	bool:togTag[MAX_PLAYERS],
	pGTag[MAX_PLAYERS][40],
	HideTD[MAX_PLAYERS],
	bool:LastTag[MAX_PLAYERS],
	pAdmin[MAX_PLAYERS],
	Helper[MAX_PLAYERS],
	pPremium[MAX_PLAYERS],
	pMapper[MAX_PLAYERS],
	pDeveloper[MAX_PLAYERS],
	pSpawned[MAX_PLAYERS],
	pAutoTune[MAX_PLAYERS],
	pMute[MAX_PLAYERS],
	pBlocked[MAX_PLAYERS],
	pJail[MAX_PLAYERS],
	pWarns[MAX_PLAYERS],
	pScore[MAX_PLAYERS],
	pTotalHours[MAX_PLAYERS],
	pTotalMinutes[MAX_PLAYERS],
	pTotalSeconds[MAX_PLAYERS],
	pCurrHours[MAX_PLAYERS],
	pCurrMinutes[MAX_PLAYERS],
	pCurrSeconds[MAX_PLAYERS],
	pCookies[MAX_PLAYERS],
	pDuelsWon[MAX_PLAYERS],
	pFallouts[MAX_PLAYERS],
	pDerbys[MAX_PLAYERS],
	pWeaponSet[MAX_PLAYERS],
	pCookieJars[MAX_PLAYERS],
	specOFF[MAX_PLAYERS],
	pSpawnPlace[MAX_PLAYERS],
	Float:pSpawnPos[MAX_PLAYERS][4];

new gEveryonesPlaylist;
new PUBG_Wins[MAX_PLAYERS];
new PUBG_KP[MAX_PLAYERS];
new PUBG_RP[MAX_PLAYERS];
new PUBG_Kills[MAX_PLAYERS];
new PUBG_Deaths[MAX_PLAYERS];
new Float:gSpawnPos[MAX_PLAYERS][3];
new enabledMusic[MAX_PLAYERS] = 1;
new lastDM[MAX_PLAYERS];
new dmMessages[MAX_PLAYERS] = 1;
new pRegDate[MAX_PLAYERS][50];
new pLastDate[MAX_PLAYERS][50];
new pTime[MAX_PLAYERS];
new houseID[MAX_PLAYERS];
new pWeather[MAX_PLAYERS];
new admOnTime[MAX_PLAYERS];
new SavedVehicle[MAX_PLAYERS];
new reactionsWon[MAX_PLAYERS];
new mathsWon[MAX_PLAYERS];
new RobberyCount[MAX_PLAYERS];
new pRegID[MAX_PLAYERS];
new pAutoFix[MAX_PLAYERS];
new pSpawnVehicle[MAX_PLAYERS];
new pPlate[MAX_PLAYERS][20];
new pGoTo[MAX_PLAYERS];
new pJoinTick[MAX_PLAYERS];
new pDescription[MAX_PLAYERS][60];
new GOD[MAX_PLAYERS];
new pHidden[MAX_PLAYERS];
new pmhidden[MAX_PLAYERS];
new doingStunt[MAX_PLAYERS];
new pLastVehicle[MAX_PLAYERS];
new LastSeat[MAX_PLAYERS];
new premiumExpired[MAX_PLAYERS];
new hideMSG[MAX_PLAYERS];
new autoLogin[MAX_PLAYERS];
new duelsOFF[MAX_PLAYERS];
new pReportPoints[MAX_PLAYERS];
new bool:PlayerHit[MAX_PLAYERS];
new bool:PurchasedToy[MAX_PLAYERS];
new bool:canUseKey[MAX_PLAYERS];
new bool:Freezed[MAX_PLAYERS];
//new bool:justSpawnedVehicle[MAX_PLAYERS];
new LastStatSave[MAX_PLAYERS];
new housestring[8196];
new afkstring[4096];
// Group System
new pGroupID[MAX_PLAYERS],
	pGroupRank[MAX_PLAYERS],
	pGroupName[MAX_PLAYERS][24],
	pGroupColor[MAX_PLAYERS];

// CnR Stats
new pArrests[MAX_PLAYERS],
	pTakedowns[MAX_PLAYERS],
	pRobberies[MAX_PLAYERS],
	pPlayerRobberies[MAX_PLAYERS],
	pCopKills[MAX_PLAYERS],
	pTimesArrested[MAX_PLAYERS];

new pJailTimer[MAX_PLAYERS];
// Anti-Spam (Chat)
new RepeatMsg[MAX_PLAYERS];
new LastText[MAX_PLAYERS][128];

new PMs[MAX_PLAYERS][MAX_PMS][150];
new Reports[MAX_REPORTS][150];
new Questions[MAX_QUESTIONS][150];//New
// DM Variables
new CnR,
	BattleField,
	WarDM,
	TDM,
	FieldDM,
	Mini,
	OneShotDM,
	Rocket,
	DssDM;

// Warp Hack
new vehxTime[MAX_PLAYERS];
new myzobject;

// Remote Jacking
//new LastState[MAX_PLAYERS];
//new Float:LastFootPos[3][MAX_PLAYERS];

// Objects
new Gate[11];
new Fast_Map[36];

// Player Info
new otherid;
new	PlayerIP[16];
new	PlayerName[24];
new	giveplayer[24];
new Float:POS[3], Float:A;
//new RedCount = 0;
//new BlueCount = 0;

// Limiting flip
new canFlip[MAX_PLAYERS];

// DM check
new InDM[MAX_PLAYERS];

// Time/Weather Update
new TW_Update;

// Custom Vehicle Objects
//new sObjects[25][MAX_PLAYERS];

// Neon
new NeonObject[2][MAX_PLAYERS];

// Bounty System
new bounty[MAX_PLAYERS];

// Random Messages
new msgTDswitch;
new bmsgTDswitch;

// Server Statistics
new serverStartTime;
new joinPlayerCount;
new totalPlayersJoined;
new pRegs;
new RegisteredPlayers;
new telesUsed;
new msgsSent;
new StatsObject;


// [3D Texts]
new Text3D:god3D[MAX_PLAYERS];
new Text3D:admin3D[MAX_PLAYERS];
new Text3D:clan3D[MAX_PLAYERS];
new Text3D:PV_3DLabel[MAX_PLAYERS][2];

// Message Box
new Text:TD_line[4],
	szString_0[60],
	szString_1[60],
	szString_2[60],
	szString_3[60];

// mSelection
new skinlist = mS_INVALID_LISTID,
	toyslist = mS_INVALID_LISTID;

new rampTimer[MAX_PLAYERS] = -1;


new lastEventTime;
// killCam
new killCam[MAX_PLAYERS];
new bool:killCamON[MAX_PLAYERS];
new killCamCounter[MAX_PLAYERS];
new killCamTimer[MAX_PLAYERS];

// Achivements
new pAch1[MAX_PLAYERS], // 150 kills. - Grim Reaper
	pAch2[MAX_PLAYERS], // 20 killstreak. - Mass Killer
	pAch3[MAX_PLAYERS], // Earned 5 million - You're Rich
	pAch4[MAX_PLAYERS], // Played for more than 24 hours. - Official Stunter
	pAch5[MAX_PLAYERS], // Played for more than 200 hours. - No Lifer
	pAch6[MAX_PLAYERS], // Win race more than 10 times - Elite Racer
	pAch7[MAX_PLAYERS], // Find 100 moneybags - Moneybag Hunter
	pAch8[MAX_PLAYERS], // Get 2000 score - Score Whore
	pAch9[MAX_PLAYERS], // Win 20 events. - Event Champion
	pAch10[MAX_PLAYERS], // Answer 50 reaction tests. - TooFast
	pAch11[MAX_PLAYERS], // Earned 20 million - Filthy Rich
	pAch12[MAX_PLAYERS], // Finish 3 skydives in a row. - SkyDiver
	pAch13[MAX_PLAYERS], // Get killed 50 times. - Rest In Peace
	pAch14[MAX_PLAYERS], // 50 cookies. - Cookie Monster
	pAch15[MAX_PLAYERS], // Kill a player with a knife. - Silent Killer
	pAch16[MAX_PLAYERS], // Complete a hit - Hitman
	pAch17[MAX_PLAYERS], // Beat a race record - Pro Racer
	pAch18[MAX_PLAYERS], // Make 50 arrests in CnR - Elite Cop.
	pAch19[MAX_PLAYERS], // Win 50+ duels - Duelist
	pAch20[MAX_PLAYERS], // Pro Biker, complete all 4 bike parkours.
	pAch21[MAX_PLAYERS], // Fallout King, win 50 fallout minigames.
	pAch22[MAX_PLAYERS], // Human Calculator - Answer 80 math questions
	pAch23[MAX_PLAYERS], // Derby Pro - Win 50 derbies.
	pAch24[MAX_PLAYERS], // Pro Cop - Make 50 takedowns in CnR.
	pAch25[MAX_PLAYERS], // Pro Thief - Rob 50 shops in /CnR
	pAch26[MAX_PLAYERS], // Pickpocketer - Rob 50 players in /CnR
	pAch27[MAX_PLAYERS], // Ruthless - Kill 100 cops in /CnR
	pAch28[MAX_PLAYERS]; // CookieJar Hunter - Find 150 cookie bags



// Countdown
new Count = -1;
new countTimer;
new showCD[MAX_PLAYERS];
new CountText[5][5] =
{
	"~r~1",
	"~g~2",
	"~y~3",
	"~g~4",
	"~b~5"
};

// Connection flood
new ipCheck[16], IPfound, IPtime;

// Vehicle Lock
new bool: CarLocked[MAX_VEHICLES] = false;

// Reaction Test
new bool:reactionActive,
	xCharacters[][] =
	{
		"A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "m",
		"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
		"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "$", "."
	},
	xChars[28] = "",
	reactionAward,
	reactionTimeStart,
	reactionWinnerID,
	mathTimeStart;


// Siren
new Siren[MAX_PLAYERS];
new SirenObject[MAX_PLAYERS];

new controlPlayer[MAX_PLAYERS];
new muteSec[MAX_PLAYERS];

new pLastCommandTick[MAX_PLAYERS],
	SpamCount[MAX_PLAYERS],
	SpawnHack[MAX_PLAYERS],
	pLastSpawnTick[MAX_PLAYERS];

new pChallengeCompleted[MAX_PLAYERS];
new pLastCapsed[MAX_PLAYERS];

new ignore[MAX_PLAYERS][MAX_PLAYERS];
new iTemp;

// Vehicle Control
new engine, lights, alarm, doors, bonnet, boot, objective;

new Float:speedBoost[MAX_PLAYERS];
new pSuperJump[MAX_PLAYERS];
new speedBreak[MAX_PLAYERS];
new pColor[MAX_PLAYERS];
new pChatColor[MAX_PLAYERS];
new pIDColor[MAX_PLAYERS];
new pBounce[MAX_PLAYERS];
new RainbowTimer[MAX_PLAYERS];
new RobberyTimer[MAX_PLAYERS];
new bool:pAirbreak[MAX_PLAYERS];
new bool:pInvincible[MAX_PLAYERS];

// Tops
enum e_top_score
{
	E_playerid,
	E_pscore
}
enum e_top_richlist
{
	E_playerid,
	E_money
}
enum e_top_kills
{
	E_playerid,
	E_kills
}
enum e_top_deaths
{
	E_playerid,
	E_deaths
}
enum e_top_time
{
	E_playerid,
	E_time,
	E_time2
}
enum e_top_eventwins
{
	E_playerid,
	E_eWins
}
enum e_top_pubgwins
{
	E_playerid,
	E_pWins
}
enum e_top_racewins
{
	E_playerid,
	E_races
}
enum e_top_mbsfound
{
	E_playerid,
	E_mbs
}
enum e_top_duels
{
	E_playerid,
	E_duels
}
enum e_top_cookies
{
	E_playerid,
	E_cookies
}
enum e_top_ks
{
	E_playerid,
	E_ks
}
enum e_top_rec
{
	E_playerid,
	E_rec
}
enum e_top_math
{
	E_playerid,
	E_math
}
enum e_top_ar
{
	E_playerid,
	E_ar
}

// Race Position Data
enum e_race_position
{
	RP_iPlayer,
	RP_iValue
}

// Save Position Feature
enum SpawnPosENUM { Float:sX, Float:sY, Float:sZ, Float:sA, SpawnSavedPos };
new SpawnPos[MAX_PLAYERS][SpawnPosENUM];

// AFK System
new AFK[MAX_PLAYERS];
new cAFK[MAX_PLAYERS];

// Maths
new mathsAnswered = -1,
	mathsCurrent[14],
	mathsAnswer,
	mathsAward;


// Fake-Kill AntiCheat
new LastKill[ MAX_PLAYERS ];
new DamageVar[ MAX_PLAYERS ];
new LastDeath[ MAX_PLAYERS ];
new DeathSpam[ MAX_PLAYERS char ];

// Kill-Streak
new killStreak[MAX_PLAYERS]; // Kill-Streak
new TotalKillStreak[MAX_PLAYERS]; // Total Kill-Streak

// Speedometer
new Speedo[MAX_PLAYERS];

// Gangzones
new Zone[9];

//new changeHostname;

//=== RoadBlock ===
new block[10][MAX_PLAYERS],
	pblock[MAX_PLAYERS];

new pWheels[MAX_PLAYERS];

//Event System
//=== Locations ===
new CageFight, CageFightOn;
new EventGoingOn;
new EventStarted;
new evcd, ecd, dcd;
new EStartTimer;
new DerbyStartTimer;
new EventDialogPlayer;
new EventDialogTimer;

//=== Counters ===
new NumEventPlayers;
new DerbyPlayers;
new PlayersJoined;

//=== Weapons ===
new EventWeap;

//=== Other ===
new InEvent[MAX_PLAYERS];
new InDerby[MAX_PLAYERS];
new DerbyEvent;

//=== Money System ===
new pCash[MAX_PLAYERS];
new BankMoney[MAX_PLAYERS];

new lsbank;
new bool:CJrunning;