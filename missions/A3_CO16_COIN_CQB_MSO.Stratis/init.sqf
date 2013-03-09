#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

CBA_ui_fnc_add = {};
cba_fnc_replace = {};

titleCut ["", "BLACK FADED", 999];
titleText ["Initialising...", "BLACK"];
waitUntil{!isNil "BIS_fnc_init"};
call mso_core_fnc_isHC;

execNow "init-mods.sqf";

execNow "core\init.sqf";
execNow "ambience\init.sqf";
execNow "support\init.sqf";
execNow "enemy\init.sqf";

execNow "init-custom.sqf";

"Completed" call mso_core_fnc_initStat;
diag_log format["MSO-%1 Initialisation Completed", time];
titleCut ["", "BLACK IN", 3];
titleText ["Initialisation Completed", "BLACK IN"];
execNow "core\scripts\intro.sqf";
