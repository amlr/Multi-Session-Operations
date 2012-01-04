#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

waitUntil{!isNil "BIS_fnc_init"};

diag_log format["MSO version: %1", "4.0e"];

execNow "core\init.sqf";
execNow "ambience\init.sqf";
execNow "support\init.sqf";
execNow "enemy\init.sqf";

execNow "init-custom.sqf";

"Completed" call mso_core_fnc_initStat;
execNow "core\scripts\intro.sqf";
