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

["player", [ace_sys_interaction_key_self], 4, ["modules\cas\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;