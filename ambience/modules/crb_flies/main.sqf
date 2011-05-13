#include <crbprofiler.hpp>

private ["_debug","_d","_pos","_swarms"];
if (!isServer) exitWith{};

_debug = false;
_d = 500;
_swarms = ceil(count(bis_functions_mainscope getVariable "locations") / 6);

for "_id" from 0 to _swarms do { 
        _pos = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
        missionNamespace setVariable [format["flies%1", _id], _pos];
        if (_debug) then { 
                [format["flies%1", _id], _pos, "ELLIPSE", [_d,_d], "GLOBAL","PERSIST"] call CBA_fnc_createMarker; 
                [format["t_flies%1", _id], _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", "Flies",  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
        };                
        
        [{
		CRBPROFILERSTART("CRB Flies")

                private ["_params","_id","_d","_debug","_pos","_dest"];
                _params = _this select 0;
                _id = _params select 0;
                _d = _params select 1;
                _debug = _params select 2;
                
                _pos = missionNamespace getVariable format["flies%1", _id];
                
                if(random 1 > 0.5) then {
                        _dest = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
                        _pos = [_pos, _d / 10,[_pos, _dest] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                        missionNamespace setVariable [format["flies%1", _id], _pos];
                        
                        if(_debug)then{
                                format["flies%1", _id] setMarkerPos _pos;
                                format["t_flies%1", _id] setMarkerPos _pos;
                        };
                };
                
                {
                        if(_x distance _pos < _d) then {
                                [2, [_x,_debug],{
                                        //if(local (_this select 0)) then {
		                                if(_this select 1)then{hint "Flies!";};
                                                [position (_this select 0)] call BIS_fnc_flies;
                                        //};
                                }] call mso_core_fnc_ExMP;
                        };
                } forEach ([] call BIS_fnc_listPlayers);

		CRBPROFILERSTOP                
        }, 60, [_id, _d, _debug]] call mso_core_fnc_addLoopHandler;
};