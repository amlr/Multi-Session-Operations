private ["_taskname", "_description", "_destination"];
_taskname = _this select 0;
_description = _this select 1;
_destination = _this select 2;

[2,_this,{_this call RMM_fnc_taskAdd;}] call RMM_fnc_ExMP;
RMM_tasks set [count RMM_tasks, _this];
publicvariable "RMM_tasks";