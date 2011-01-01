if (isdedicated) exitwith {};

if (MSO_R_Admin) then {
	["player", [mso_interaction_key], 4, ["modules\debug\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
	["Debug","createDialog ""RMM_ui_debug"""] call fnc_updateMenu;
};