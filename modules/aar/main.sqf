if (isdedicated) exitwith {};

RMM_aar_lines = [
	[str (group player)],
	["friendly action","enemy action","non-combat"],
	["ambush","attack","cache found/cleared","checkpoint","direct fire","indirect fire","downed aircraft","medevac","other","patrol","psyops","raid","sniper ops"]
];

if (isnil "RMM_aars") then {
	RMM_aars = [];
	publicvariable "RMM_aars";
} else {
	{
		[3,_x] call aar_fnc_submit;
	} foreach RMM_aars;
};