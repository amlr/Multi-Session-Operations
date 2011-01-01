if (isdedicated) exitwith {};

//http://forums.bistudio.com/showthread.php?t=92142
RMM_casevac_lines = [
	{[mapGridPosition player]},
	{[str (group player)]},
	{["Alpha","Bravo","Charlie","Delta","Echo"]},
	{["Alpha"]},
	{["Alpha","Lima"]},
	{["November","Papa","Echo","X-Ray"]},
	{["Alpha","Bravo","Charlie","Delta"]},
	{["Alpha","Bravo","Charlie","Delta","Echo"]},
	{["November","Bravo","Charlie","None"]}
];

if (MSO_R_Leader) then {
	["player", [mso_interaction_key], 4, ["modules\casevac\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
	["CASEVAC","createDialog ""RMM_ui_casevac"""] call fnc_updateMenu;
};