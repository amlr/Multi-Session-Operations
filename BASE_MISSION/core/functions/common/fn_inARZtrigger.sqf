private ["_posCheck","_quit","_exitcheck"];

_posCheck = _this select 0;
_quit = false;
_exitcheck = 0;

for [{_n = 0},{_n < 10},{_n = _n + 1}] do {
    if (_quit || _n > _exitcheck + 1) exitwith {};
	if !(isnil format ["BIS_ARZ_%1",_n]) then {
        _exitcheck = _n;
        _trigger = call compile format  ["BIS_ARZ_%1",_n];
        if ([_trigger, _posCheck] call BIS_fnc_inTrigger) exitwith {_quit = true};
    };
};
_quit;