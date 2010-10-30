private ["_cidx", "_cpos", "_i"];
_cidx = 0;
_cpos = [0,0,0];
_i=0;
{
	if ((_x select 2) distance RMM_tasks_position < _cpos distance RMM_task_position)then{
		_cpos = _x select 2;
		_cidx = _i;
	};
	_i=_i+1;
} foreach RMM_tasks;
[2,_cidx,{RMM_mytasks = RMM_mytasks - [RMM_mytasks select _cname]; player removeSimpleTask (RMM_mytasks select _cname);}] call RMM_fnc_ExMP;
RMM_tasks set [_cidx, objnull];
RMM_tasks = RMM_tasks - [objnull];
publicvariable "RMM_tasks";