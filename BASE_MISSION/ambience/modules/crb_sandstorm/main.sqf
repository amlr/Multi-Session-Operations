#include <crbprofiler.hpp>

private ["_debug","_d","_pos","_storms"];
if(isNil "ambientSandstorms")then{ambientSandstorms = 0;};
if (!isServer || ambientSandstorms == 0) exitWith{};

_debug = debug_mso;
_d = 500;
_storms = ceil(count(bis_functions_mainscope getVariable "locations") / 8);

for "_id" from 0 to _storms do { 
        _pos = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
        missionNamespace setVariable [format["sandstorms%1", _id], _pos];
        if (_debug) then { 
                [format["sandstorms%1", _id], _pos, "ELLIPSE", [_d,_d], "GLOBAL","PERSIST"] call CBA_fnc_createMarker; 
                [format["t_sandstorms%1", _id], _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", "Sandstorms",  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
        };                
        
        [{
		CRBPROFILERSTART("CRB Sandstorms")

                private ["_params","_id","_d","_debug","_pos","_dest"];
                _params = _this select 0;
                _id = _params select 0;
                _d = _params select 1;
                _debug = _params select 2;
                
                _pos = missionNamespace getVariable format["sandstorms%1", _id];
                if(random 1 > 0.9) then {
                        _dest = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
                        _pos = [_pos, _d / 2,[_pos, _dest] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                        missionNamespace setVariable [format["sandstorms%1", _id], _pos];
                        
                        if(_debug)then{
                                format["sandstorms%1", _id] setMarkerPos _pos;
                                format["t_sandstorms%1", _id] setMarkerPos _pos;
                        };
                };
                
                {
                        if(_x distance _pos < _d) then {
                                [2, [_x,_debug],{
	                                if(_this select 1)then{hint "Sandstorm!";};
                                        [_this select 0] call BIS_fnc_sandstorm;
                                }] call mso_core_fnc_ExMP;
                        };
                } forEach ([] call BIS_fnc_listPlayers);

		CRBPROFILERSTOP
        }, 60, [_id, _d, _debug]] call mso_core_fnc_addLoopHandler;
};
