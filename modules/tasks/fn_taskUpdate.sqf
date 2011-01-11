[2,_this,{
	[missionnamespace getvariable (_this select 0), _this select 1] call RMM_fnc_taskUpdate;
}] call RMM_fnc_ExMP;

{
	if (((_x select 0) select 0) == (_this select 0)) then {
		_x set [1, _this select 1];
	};
} foreach MP_tasks;
publicvariable "MP_tasks";

_task
