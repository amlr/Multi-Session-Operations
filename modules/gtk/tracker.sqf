private ["_groups", "_range", "_type", "_sleep", "_array", "_ref"];

if (tolower(typename _this) == "object") then {
	_groups = synchronizedObjects _this;
	_range = _this getvariable "range";
	_type = _this getvariable ["type",-1];
	_sleep = _this getvariable ["sleep",30];
} else {
	_groups = _this select 0;
	_range = _this select 1;
	_type = _this select 2;
	_sleep = 30;
	if (count _this > 2) then {
		_sleep = _this select 2;
	};
};

private ["_functions","_fnc_sync","_fnc_active","_fnc_inactive"];
_functions = _type call {
	#include <config.hpp>
};
_fnc_sync = _functions select 0;
_fnc_active = _functions select 1;
_fnc_inactive = _functions select 2;

_array = [];
{
	_ref = createlocation ["strategic", _x call CBA_fnc_getpos, 1, 1];
	_ref setside (side _x);
	_ref setvariable ["active", true];
	_ref setvariable ["group", group _x];
	_ref setvariable ["forced", false];
	_array set [count _array,_ref];
} foreach _groups;

while {count _array > 0} do {
	{
		_x call _fnc_sync;
		if (isnull _x) then {
			_array = _array - [_x];
		} else {
			if !(_x getvariable "forced") then {
				if (_x getvariable "active") then {
					if !([_x,_range] call CBA_fnc_nearPlayer) then {
						_x setvariable ["active",false];
						_x call _fnc_inactive;
					};
				} else {
					if ([_x,_range] call CBA_fnc_nearPlayer) then {
						_x setvariable ["active",true];
						_x call _fnc_active;
					};
				};
			};
		};
	} foreach _array;
	if (count (call 
	sleep (call RMM_fnc_playersNumber);
};