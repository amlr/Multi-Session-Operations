#include <crbprofiler.hpp>

//0, All
//1, Server
//2, Clients
//3, Local
private ["_locality","_params","_code"];

CRBPROFILERSTART("mso_core_fnc_ExMP")

_locality = _this select 0;
_params = _this select 1;
_code = _this select 2;

// All: -2, ClientsOnly: -1, ServerOnly: 0 [Integer]
switch (_locality) do{
        case 0: {
                [-2, _code, _params] call CBA_fnc_globalExecute;
        };
        
        case 1: {
                [0, _code, _params] call CBA_fnc_globalExecute;
        };
        
        case 2: {
                [-1, _code, _params] call CBA_fnc_globalExecute;
        };
        
        case 2: {
                if (isnil "_params") then {call _code} else {_params call _code};
        };
};

CRBPROFILERSTOP
