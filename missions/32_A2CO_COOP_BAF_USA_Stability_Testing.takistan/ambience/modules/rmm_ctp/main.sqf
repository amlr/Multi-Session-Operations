#include <crbprofiler.hpp>

waitUntil{!isNil "BIS_fnc_init"};

if(isServer) then  {
        private ["_towns","_list"];
        
        waitUntil{!isNil "bis_functions_mainscope"};
        waitUntil{typeName (bis_functions_mainscope getVariable "locations") == "ARRAY"};
        
        _towns = BIS_functions_mainscope getVariable "locations";
        {
                _list = nearestobjects [position _x,["Land_A_Minaret_EP1","Land_A_Minaret_Porto_EP1"],500];
                if (count _list > 0) then {
                        _x setvariable ["EP1_Minarets",_list,true];
                } else {
                        _towns = _towns - [_x];
                };
        } foreach _towns;
};

[] spawn {
        while{true} do {
                CRBPROFILERSTART("RMM Call To Prayer")
                
                private ["_fnc_between","_fnc_prayer","_towns"];
                _towns = BIS_functions_mainscope getVariable "locations";
                
                _fnc_between = {
                        private ["_a","_b"];
                        _a = _this select 0;
                        _b = _this select 1;
                        (daytime >= _a AND daytime < _b)
                };
                
                _fnc_prayer = {
                        private ["_town"];
                        _town = _this;
                        {
                                _x say3D "muezzin";
                        } foreach (_town getvariable "EP1_Minarets");
                };
                
                {
                        if (_x call _fnc_between) exitwith {
                                {
                                        _x call _fnc_prayer;
                                } foreach _towns;
                        };
                } foreach [[4.25,4.5],[5.25,5.75],[11.75,12],[15.25,15.5],[17.75,18.25],[19,19.25]];
                
                CRBPROFILERSTOP
                
                sleep 60;
        };
};
