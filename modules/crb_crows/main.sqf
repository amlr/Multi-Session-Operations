private ["_debug","_d"];
if (!isServer) exitWith{};

_debug = false;

_d = 100;

[_d, _debug] spawn {
	private ["_m","_pos","_sleep","_d","_debug"];
        _d = _this select 0;
	_debug = _this select 1;
	_pos = [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), CRB_LOC_DIST/3] call CBA_fnc_randPos;

	if (_debug) then {
		_m = ["crows", _pos, "ELLIPSE", [_d,_d], "GLOBAL"] call CBA_fnc_createMarker;
		[_m, true] call CBA_fnc_setMarkerPersistent;
	};

	while{true} do {
		_sleep = 30;
		sleep _sleep;
		_pos = [_pos, _d] call CBA_fnc_randPos;
		while {_pos distance getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition") > CRB_LOC_DIST/3} do {
			_pos = [_pos, _d] call CBA_fnc_randPos;
		};

                [2, [_pos],{_this call bis_fnc_crows;}] call RMM_fnc_ExMP;
                
                if(_debug)then{
			"crows" setMarkerPos _pos;
		};
	};
};
