private ["_debug","_d"];
if (!isServer) exitWith{};

_debug = false;

_d = 500;

[_d, _debug] spawn {
        private ["_m","_pos","_sleep","_d","_debug","_activated","_sleeptime"];
        _d = _this select 0;
	_debug = _this select 1;
	_pos = [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), CRB_LOC_DIST/2] call CBA_fnc_randPos;

	if (_debug) then {
		_m = ["sandstorm", _pos, "ELLIPSE", [_d,_d], "GLOBAL"] call CBA_fnc_createMarker;
		[_m, true] call CBA_fnc_setMarkerPersistent;
	};


	while{true} do {
		_sleep = if(_debug)then{30;}else{random (60 * 5);};
		_sleeptime = time + _sleep;
		_pos = [_pos, _d] call CBA_fnc_randPos;
		while {_pos distance getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition") > CRB_LOC_DIST/2} do {
			_pos = [_pos, _d] call CBA_fnc_randPos;
		};

                _activated = [];
                while{time < _sleeptime} do {
                        {
                                if(_x distance _pos < _d && !(_x in _activated) && local _x) then {
                                        [2, [],{[_x] call bis_fnc_sandstorm;}] call RMM_fnc_ExMP;
                                        _activated = _activated + [_x];
                                };
                        } forEach ([] call BIS_fnc_listPlayers);
                        sleep 5;
                };

		if(_debug)then{
			"sandstorm" setMarkerPos _pos;
		};
	};
};
