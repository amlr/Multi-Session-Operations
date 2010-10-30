if (isdedicated) exitwith {};

RMM_mytasks = [];
if (isnil "RMM_tasks") then {
	RMM_tasks = [];
	publicvariable "RMM_tasks";
} else {
	{
		RMM_mytasks = [count RMM_mytasks, _x call RMM_fnc_taskAdd];
	} foreach RMM_tasks;
};