private ["_debug","_d"];
if (!isServer) exitWith{};

_debug = true;

_d = 500;

[_d, _debug] spawn {
        private ["_m","_pos","_sleep","_d","_debug","_mt","_dest","_sleeptime"];
        _d = _this select 0;
	_debug = _this select 1;
        _pos = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);

	if (_debug) then {
		_m = ["sandstorm", _pos, "ELLIPSE", [_d,_d], "GLOBAL"] call CBA_fnc_createMarker;
		[_m, true] call CBA_fnc_setMarkerPersistent;
                _mt = ["t_sandstorm", _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", "Sandstorm", "GLOBAL"] call CBA_fnc_createMarker;
                [_mt, true] call CBA_fnc_setMarkerPersistent;
	};


	while{true} do {
                _dest = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
                
		_sleep = if(_debug)then{30;}else{random (60 * 5);};
		_sleeptime = time + _sleep;

                while {_pos distance _dest > _d} do {
                        _pos = [_pos, _d/2,[_pos, _dest] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                        _sleeptime = time + _sleep;
                        
			if(_debug)then{
				"sandstorm" setMarkerPos _pos;
                                "t_sandstorm" setMarkerPos _pos;
                        };
                        

	                while{time < _sleeptime} do {
        	                {
                	                if(_x distance _pos < _d) then {
                        	                [2, _x,{if(local _this) then {[player] call BIS_fnc_sandstorm;};}] call RMM_fnc_ExMP;
	                                };
        	                } forEach ([] call BIS_fnc_listPlayers);
                	        sleep 30;
	                };
		};
	};
};
