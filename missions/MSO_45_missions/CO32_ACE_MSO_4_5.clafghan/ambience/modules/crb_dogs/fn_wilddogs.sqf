#include <crbprofiler.hpp>

private ["_side","_breed","_type","_dog","_grp","_random","_pos","_gs"];

_pos = _this select 0;
_gs = _this select 1;

switch (typeName _gs) do {
        case "SIDE": {
                _side = _gs;
                _grp = creategroup _side;
        };
        case "GROUP": {
                _grp = _gs;
                _side = side _grp;
        };
};

//_grp = creategroup Resistance;

//player sidechat format ["%1 - %2 - %3",_list,_side,_grp];

_random = round(random 4) +3;

for "_i" from 1 to _random do {
        
        _type = round(random 1);
        _breed = "Pastor";
        switch (_type) do {
                case 0: {
                        _breed = "Pastor";
                };
                case 1: {
                        _breed = "Fin";
                };
        };	
        
        _dog = _grp createUnit [_breed, _pos, [], 0, "NONE"];
        _dog setSkill 0.2;
        _dog setSpeedMode "full";
        _dog setbehaviour "safe";
        _dog addrating -1000; 
        _dog setVariable ["_sound1", "dog_01"];
        _dog setVariable ["_sound2", "dog_02"];
        _dog setVariable ["attacking", false, true];
        
        [_dog] joinsilent _grp;
        
        [_grp] spawn {
                CRBPROFILERSTART("Wild dogs Active")
                
                private ["_alive_humans","_nearest","_distance","_near_humans","_grp","_r","_dog","_pos"];
                _grp = _this select 0;
                
                while{count units _grp > 0} do {
                        _near_humans = [];
                        _distance = 1000;
                        _nearest = objNull;
                        _near_humans = nearestObjects [(position leader _grp), ["Man","Car"],100];
                        {
                                _dog = _x;
                                if(alive _dog && !(_dog getVariable "attacking")) then {
                                        _alive_humans = [];
                                        {
                                                if ((side _dog)getFriend (side _x) <0.6) then {
                                                        _alive_humans set [count _alive_humans, _x];
                                                        _dog knowsabout _x;
                                                }
                                        }forEach _near_humans;
                                        
                                        // or attack everything!!!
                                        //{_alive_humans set [count _alive_humans, _x];_dog knowsabout _x;}forEach _near_humans;
                                        
                                        _r = random 1;                        
                                        if (count _alive_humans >0)  then {
                                                _nearest = _alive_humans select 0;
                                                _distance = _dog distance _nearest;
                                                _pos = position _nearest;
                                                if (_distance < 2.5) then {
                                                        [_nearest, _dog] spawn dogs_fnc_dogattack;
                                                } else {
                                                        _dog setSpeedMode "full";
                                                        _dog domove _pos;
                                                };
                	                        if (_r > 0.95) then {
        	                                        [2, _dog,{_this say3D (["dog_01","dog_02","dog_yelp"] call BIS_fnc_selectRandom)}] call mso_core_fnc_ExMP
	                                        };
                                        } else {
                                                if (_r > 0.66 ) then {
                                                        _dog domove ([_dog, 50] call CBA_fnc_randPos);
                                                        _dog setspeedmode (["LIMITED","NORMAL","FULL"]call BIS_fnc_selectRandom);
                                                };
                                        };
                                };
                        } forEach units _grp;
                        sleep (1 + (random 1));
                        
                        CRBPROFILERSTOP
                };
        };
        
};
_grp;
