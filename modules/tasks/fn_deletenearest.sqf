private ["_pos", "_cidx", "_cpos", "_i"];
_pos = _this;
_cidx = 0;
_cpos = [0,0,0];
_i=0;
{
	if ((_x select 2) distance _pos < _cpos distance _pos)then{
		_cpos = _x select 2;
		_cidx = _i;
	};
	_i=_i+1;
} foreach RMM_tasks;
[2,_cidx,{player removeSimpleTask (RMM_mytasks select _this); RMM_mytasks = RMM_mytasks - [RMM_mytasks select _this];}] call RMM_fnc_ExMP;
RMM_tasks set [_cidx, objnull];
RMM_tasks = RMM_tasks - [objnull];
publicvariable "RMM_tasks";