if (isnil "MP_tasks") then {
	MP_tasks = [];
	publicvariable "MP_tasks";
};

{
	[
		(_x select 0) call RMM_fnc_taskAdd,
		(_x select 1)
	] call RMM_fnc_taskUpdate;
} foreach MP_tasks;