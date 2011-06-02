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
        _dog setVariable ["_sound1", "dog_01", true];
        _dog setVariable ["_sound2", "dog_02", true];
        _dog setVariable ["attacking", false, true];
        _dog setIdentity "blitzk9";
        [_dog] joinsilent _grp;
        _leader setvariable ['K-9Unit',_dog, true];
};

[{
	CRBPROFILERSTART("Blitzy")

        private ["_alive_humans","_nearest","_distance","_near_humans","_dog","_leader","_params","_pos","_r"];
        _params = _this select 0;
        _leader = _params select 0;
        _dog = _leader getvariable 'K-9Unit';
        
        if(alive _dog && !(_dog getVariable "attacking")) then {
                _near_humans = [];
                _alive_humans = [];
                _distance = 1000;
                _nearest = objNull;
                _near_humans = (position _dog nearEntities ["Man",100]) + (position _dog nearEntities ["Car",100]);
                
                {
                        if ((side _dog)getFriend (side _x) < 0.6) then {
                                _alive_humans = _alive_humans + [_x];
                                _dog knowsabout _x;
                        }
                }forEach _near_humans;
                
                if (count _alive_humans >0)  then {
                        _nearest = _alive_humans select 0;
                        _distance = _dog distance _nearest;
                        _pos = position _dog;
                        if ((_distance > 75) && (_distance < 100)) then {
                                //                                _pos = [position _nearest, 80,[position _nearest, _pos] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                                //                                _dog domove _pos;
                                //                                _dog setspeedmode "NORMAL";
                                
                                [2, _dog,{_this say3D "dog_01";}] call mso_core_fnc_ExMP
                        };
                        if ((_distance > 50) && (_distance < 75)) then {
                                //                                _pos = [position _nearest, 55,[position _nearest, _pos] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                                //                                _dog domove _pos;
                                //                                _dog setspeedmode "NORMAL";
                                [2, _dog,{_this say3D "dog_01";}] call mso_core_fnc_ExMP
                        };
                        if ((_distance > 15) && (_distance < 50)) then {
                                //                                _pos = [position _nearest, 20,[position _nearest, _pos] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                                //                                _dog domove _pos;
                                //                                _dog setspeedmode "NORMAL";
                                [2, _dog,{_this say3D "dog_yelp";}] call mso_core_fnc_ExMP
                        };
                        if ((_distance > 10) && (_distance < 15)) then {
                                _pos = [position _nearest, 12,[position _nearest, _pos] call BIS_fnc_dirTo] call BIS_fnc_relPos;
                                _dog domove _pos;
                                _dog setspeedmode "NORMAL";
                                [2, _dog,{_this say3D "dog_02";}] call mso_core_fnc_ExMP
                        };
                        if (_distance < 10) then {
                                _dog domove position _nearest;
                                _dog setspeedmode "FULL";
                                [_nearest, _dog] spawn dogs_fnc_dogattack;
                        };	
                } else {
                        _r = random 1;
                        if (_r > 0.75) then {
                                _dog domove position _leader;
                        };
                        if (_r > 0.85) then {
                                [2, _dog,{_this say3D "dog_01";}] call mso_core_fnc_ExMP
                        };
                };
        };

	CRBPROFILERSTOP
}, 1, [_leader]] call mso_core_fnc_addLoopHandler;