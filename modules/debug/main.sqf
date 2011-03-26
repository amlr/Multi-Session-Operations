if (isdedicated) exitwith {};

waitUntil{!isNil "MSO_R_Admin"};
["player", [mso_interaction_key], 4, ["modules\debug\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
["Debug","if((getPlayerUID player) in MSO_R_Admin) then {createDialog ""RMM_ui_debug""};"] call fnc_updateMenu;

#include "cfg_groups.sqf"