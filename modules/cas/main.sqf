if (isdedicated) exitwith {};

if (isnil "RMM_cas_available") then {
	RMM_cas_available = ["A10","AH64D","AH64D","AH1Z"];
	publicvariable "RMM_cas_available";
};

RMM_cas_lines = [
	{[mapGridPosition player]},
	{[str (group player)]},
	{RMM_cas_available},
	{["10 min","15 min","30 min","60 min"]},
	{["300m","400m","500m","600m","800m","1200m"]}
];
RMM_cas_missiontime = 540;
RMM_cas_flyinheight = 500;
RMM_cas_frequency = 10800;

["player", [ace_sys_interaction_key_self], 4, ["modules\cas\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
if (isnil "RMM_cas_lastTime") then {
	RMM_cas_lastTime = -RMM_cas_frequency;
	publicvariable "RMM_cas_lastTime";
};

waitUntil{!isNil "MSO_R_Leader"};
["player", [mso_interaction_key], 4, ["modules\cas\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
["CAS","if(call mso_fnc_hasRadio && ((getPlayerUID player) in MSO_R_Leader)) then {createDialog ""RMM_ui_cas""}"] call fnc_updateMenu;