private ["_debug","_d"];
if (!isServer) exitWith{};

_debug = true;

_d = 500;

[_d, _debug] spawn {
        private ["_m","_pos","_sleep","_d","_debug","_mt","_dest"];
        _d = _this select 0;
        _debug = _this select 1;
        _pos = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
        
        if (_debug) then {
                _m = ["crows", _pos, "ELLIPSE", [_d,_d], "GLOBAL"] call CBA_fnc_createMarker;
                [_m, true] call CBA_fnc_setMarkerPersistent;
                _mt = ["t_crows", _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", "Crows", "GLOBAL"] call CBA_fnc_createMarker;
                [_mt, true] call CBA_fnc_setMarkerPersistent;
                
        };
        
        while{true} do {
                _dest = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
                
                _sleep = if(_debug) then {10} else {60};
                while {_pos distance _dest > _d} do {
                        _pos = [_pos, _d / 2,[_pos, _dest] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                        [2, [_pos],{_this call bis_fnc_crows;}] call RMM_fnc_ExMP;
                        
                        if(_debug)then{
                                "crows" setMarkerPos _pos;
                                "t_crows" setMarkerPos _pos;
                        };
                        sleep _sleep;
                };
        };
};
