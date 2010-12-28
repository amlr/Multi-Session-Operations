if (isdedicated) exitwith {};

RMM_aar_lines = [
	[str (group player)],
	["friendly action","enemy action","non-combat"],
	["ambush","attack","cache found/cleared","checkpoint","direct fire","indirect fire","downed aircraft","medevac","other","patrol","psyops","raid","sniper ops"]
];

if (isnil "RMM_aars") then {
	RMM_aars = [RMM_aar_lines select 0 select 0, RMM_aar_lines select 1 select 0, RMM_aar_lines select 2 select 0];
	publicvariable "RMM_aars";
} else {
	{
		_x call aar_fnc_submit;
	} foreach RMM_aars;
};

["player", [mso_interaction_key], 4, ["modules\aar\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;