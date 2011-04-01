if (isdedicated) exitwith {};

["player", [mso_interaction_key], 4, ["core\modules\debug\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
["Debug","if((getPlayerUID player) in MSO_R_Admin) then {createDialog ""RMM_ui_debug""};"] call mso_core_fnc_updateMenu;
