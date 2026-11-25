#if defined MAIN_H
	#endinput
#else
	#define MAIN_H
#endif


//=== Other Includes ===
#include "base\server\AntiDialogSpoof.pwn"

#include "base_houses.pwn" 	 // House System
//#include "base_fireworks.pwn" // Fireworks (Bugged)
#include "base_textdraws.pwn" // Textdraws
#include "base_fallout.pwn" 	// Fallout
#include "base_Derby.pwn" 	// Derby
#include "base_LMS.pwn" 		// LMS
#include "base_Group.pwn" 	// Group System
#include "base_snow.pwn" 	// base Snow FS
#include "mod_anticheat.pwn" 	//
#include "base_HG.pwn"

//DeathMatch arenas
#include "modules/deagledm"
#include "modules/sawndm"
#include "base\minigames\cbug.pwn"

//anticheat
#include "base\server\antiAdvertise.pwn"
#include "base\server\AntiAim.pwn"

// Duels
#include "base\minigames\duels.pwn"

//player country information
#include "base\server\playercountry.pwn"

// baseserver.com/map/
#include "base_LiveMap.pwn"

// base Anti cheat
#include "base_AC.pwn"