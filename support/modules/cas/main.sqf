if (isdedicated) exitwith {};

RMM_cas_types = [
	"A10",
	"AH64D",
	"AH1Z"
];
RMM_cas_lines = [
	{[mapGridPosition player]},
	{[str (group player)]},
	{RMM_cas_types}
];
RMM_cas_missiontime = 540;
RMM_cas_flyinheight = 500;
RMM_cas_frequency = 10800;

if (isnil "RMM_cas_lastTime") then {
	RMM_cas_lastTime = -RMM_cas_frequency;
	publicvariable "RMM_cas_lastTime";
};

waitUntil{!isNil "MSO_R_Leader"};
["player", [mso_interaction_key], 4, ["support\modules\cas\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
["CAS","if(call mso_fnc_hasRadio && ((getPlayerUID player) in MSO_R_Leader)) then {createDialog ""RMM_ui_cas""}"] call mso_core_fnc_updateMenu;