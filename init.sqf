#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

waitUntil{!isNil "BIS_fnc_init"};

execNow "core\init.sqf";
execNow "init-custom.sqf";

"Completed" call mso_core_fnc_initStat;
execNow "core\scripts\intro.sqf";