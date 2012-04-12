#include <crbprofiler.hpp>

private ["_debug","_d","_pos","_flocks"];
if(isNil "ambientCrows")then{ambientCrows = 0;};
if (!isServer || ambientCrows == 0) exitWith{};

_debug = debug_mso;
_d = 250;

_flocks = ceil(count(bis_functions_mainscope getVariable "locations") / 6);
for "_id" from 0 to _flocks do {
        _pos = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
        missionNamespace setVariable [format["crows%1", _id], _pos];
        
        if (_debug) then {
                [format["crows%1", _id], _pos, "ELLIPSE", [_d,_d], "GLOBAL","PERSIST"] call CBA_fnc_createMarker;
                [format["t_crows%1", _id], _pos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", "Crows",  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
        };
        
        [{
		CRBPROFILERSTART("CRB Crows")

                private ["_params","_id","_d","_debug","_pos","_dest"];
                _params = _this select 0;
                _id = _params select 0;
                _d = _params select 1;
                _debug = _params select 2;
                
                _pos = missionNamespace getVariable format["crows%1", _id];
                _dest = position ((bis_functions_mainscope getVariable "locations") call BIS_fnc_selectRandom);
                _pos = [_pos, _d / 4,[_pos, _dest] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                missionNamespace setVariable [format["crows%1", _id], _pos];
                
                if(_debug)then{
                        format["crows%1", _id] setMarkerPos _pos;
                        format["t_crows%1", _id] setMarkerPos _pos;
                };
                
                [2, [_pos],{if(player distance (_this select 0) < 500)  then {_this call bis_fnc_crows;};}] call mso_core_fnc_ExMP;

		CRBPROFILERSTOP
        }, 60, [_id, _d, _debug]] call mso_core_fnc_addLoopHandler;
};