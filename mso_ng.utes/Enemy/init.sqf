/* ----------------------------------------------------------------------------
File: init.sqf

Description:
Top level init.sqf for Enemy

Author:
Wolffy.au
---------------------------------------------------------------------------- */

#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

#ifdef MSO_FACTIONS
"Enemy Factions" call mso_fnc_initialising;
execNow "Enemy\modules\MSO_FACTIONS\main.sqf";
#endif

#ifdef MSO_CQBPOP
"CQB Populator" call mso_fnc_initialising;
execNow "Enemy\modules\MSO_CQBPOP\main.sqf";
#endif
