#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

#ifdef CRB_CROWS
"Crows" call mso_core_fnc_initStat;
execNow "ambience\modules\crb_crows\main.sqf";
#endif
#ifdef CRB_DOGS
"Dogs" call mso_core_fnc_initStat;
[east] execNow "ambience\modules\crb_dogs\main.sqf";
#endif
#ifdef CRB_FLIES
"Flies" call mso_core_fnc_initStat;
execNow "ambience\modules\crb_flies\main.sqf";
#endif
#ifdef CRB_SANDSTORM
"Sandstorms" call mso_core_fnc_initStat;
execNow "ambience\modules\crb_sandstorms\main.sqf";
#endif
#ifdef RMM_CTP
"Call To Prayer" call mso_core_fnc_initStat;
execNow "ambience\modules\rmm_ctp\main.sqf";
#endif
#ifdef CRB_EMERGENCY
"Civilian Emergency Services" call mso_core_fnc_initStat;
execNow "ambience\modules\crb_emergency\main.sqf";
#endif
#ifdef CRB_CIVILIANS
"Ambient Civilians" call mso_core_fnc_initStat;
execNow "ambience\modules\crb_civilians\main.sqf";
#endif
#ifdef CRB_SHEPHERDS
"Shepherds" call mso_core_fnc_initStat;
execNow "ambience\modules\crb_shepherds\main.sqf";
#endif
#ifdef TUP_AIRTRAFFIC
"Ambient Airports" call mso_core_fnc_initStat;
execNow "ambience\modules\tup_airtraffic\main.sqf";
#endif