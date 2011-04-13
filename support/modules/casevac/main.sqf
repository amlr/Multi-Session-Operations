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

["player", [mso_interaction_key], 4, ["support\modules\casevac\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;
["CASEVAC","if(call mso_fnc_hasRadio && ((getPlayerUID player) in MSO_R_Leader)) then {createDialog ""RMM_ui_casevac""}"] call mso_core_fnc_updateMenu;
