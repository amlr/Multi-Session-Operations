if (isdedicated) exitwith {};

RMM_mytasks = [];
if (isnil "RMM_tasks") then {
	RMM_tasks = [];
	publicvariable "RMM_tasks";
} else {
	{
		RMM_mytasks set [count RMM_mytasks, _x call tasks_fnc_taskAdd];
	} foreach RMM_tasks;
};

["player", [ace_sys_interaction_key_self], 4, ["modules\tasks\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;