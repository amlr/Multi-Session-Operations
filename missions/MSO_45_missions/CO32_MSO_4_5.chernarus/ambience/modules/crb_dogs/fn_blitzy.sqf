#include <crbprofiler.hpp>

private ["_breed","_leader","_vari","_type","_grp","_dogname","_dog"];
_leader = _this select 0;

if (isServer) then {
        _vari = _leader getvariable 'K-9Unit';
        if (!isnull _vari) then {
                deletevehicle _vari;
        };
        
        _type = round(random 1);
        _breed = "Pastor";
        switch (_type) do {
                case 0:
                {
                        _breed = "Pastor";
                };
                case 1:
                {
                        _breed = "Fin";
                };
        };	
        _grp = group _leader;
        
        
        _dogname = format ["k9%1",round (random 1000)];
        call compile format ['"%2" createUnit [getpos _leader, _grp,"%1=this;
        this setSkill 0.2; 
        this disableAI ""AUTOTARGET"" ; 
        this disableAI ""TARGET"" ; 
        this setCombatMode ""BLUE"";
        this setbehaviour ""aware""",1]',_dogname,_breed];
        _dog = call compile format ["%1",_dogname];
        _dog setVariable ["_sound1", "dog_01"];
        _dog setVariable ["_sound2", "dog_02"];
        _dog setVariable ["attacking", false];
        _dog setIdentity "blitzk9";
        [_dog] joinsilent _grp;
        _leader setvariable ['K-9Unit',_dog];
};

[_leader] spawn {
        CRBPROFILERSTART("Blitzy")
        
        private ["_alive_humans","_nearest","_distance","_near_humans","_dog","_leader","_pos","_r"];
        _leader = _this select 0;
        _dog = _leader getvariable 'K-9Unit';
        _dog setspeedmode "FULL";
        
        while{alive _dog} do {        
                if(!(_dog getVariable "attacking")) then {
                        _near_humans = [];
                        _alive_humans = [];
                        _distance = 1000;
                        _nearest = objNull;
                        _near_humans = nearestObjects [(position _dog), ["Man","Car"],100];
                        
                        {
                                if ((side _dog)getFriend (side _x) < 0.6) then {
                                        _alive_humans set [count _alive_humans, _x];
                                        _dog knowsabout _x;
                                }
                        }forEach _near_humans;
                        
                        _r = random 1;                        
                        if (count _alive_humans >0)  then {
                                _nearest = _alive_humans select 0;
                                _distance = _dog distance _nearest;
                                _pos = position _nearest;
                                if (_distance < 2.5) then {
                                        [_nearest, _dog] spawn dogs_fnc_dogattack;
                                } else {
                                        _dog domove _pos;
                                };
                	        if (_r > 0.95) then {
        	                        [2, _dog,{_this say3D (["dog_01","dog_02","dog_yelp"] call BIS_fnc_selectRandom)}] call mso_core_fnc_ExMP
	                        };
                        } else {
                                if (_r > 0.5) then {
                                        _dog domove (_leader modelToWorld [0,10,0]);
                                };
                        };
                };
                
                CRBPROFILERSTOP
                sleep 1;
        };
};