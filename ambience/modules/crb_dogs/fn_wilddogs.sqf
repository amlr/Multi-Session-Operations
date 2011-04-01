private ["_side","_breed","_type","_dogname","_dog","_list","_grp","_random","_leader","_handle"];

_leader = _this select 0;
_list = _this select 1;
_list = side (_list select 0);
_side = east;
switch (_list) do {
        case west: {
                _side = east;
        };
        case east: {
                _side = west;
        };
};	

_grp = creategroup _side;
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
        
        _dogname = format ["k9%1",round (random 1000)];
        call compile format ['"%2" createUnit [position _leader, _grp,"%1=this;
        this setSpeedMode ""full"";
        this setbehaviour ""safe""",1]',_dogname,_breed];
        _dog = call compile format ["%1",_dogname];
        _dog addrating -1000; 
        _dog setVariable ["_sound1", "dog_01"];
        _dog setVariable ["_sound2", "dog_02"];
        _dog setVariable ["attacking", false, true];
        
        [_dog] joinsilent _grp;
};

_handle = [{
        private ["_alive_humans","_nearest","_distance","_near_humans","_grp","_params","_r","_dog"];
        _params = _this select 0;
        _grp = _params select 0;
        
        {
                _dog = _x;
                if(alive _dog && !(_dog getVariable "attacking")) then {
                        _near_humans = [];
                        _alive_humans = [];
                        _distance = 1000;
                        _nearest = objNull;
                        _near_humans = (position _dog nearEntities ["Man",100]) + (position _dog nearEntities ["Car",100]);
                        
                        {
                                if ((side _dog)getFriend (side _x) <0.6) then {
                                        _alive_humans = _alive_humans + [_x];
                                        _dog knowsabout _x;
                                }
                        }forEach _near_humans;
                        
                        // or attack everything!!!
                        //{_alive_humans = _alive_humans + [_x];_dog knowsabout _x;}forEach _near_humans;
                        
                        if (count _alive_humans >0)  then {
                                _nearest = _alive_humans select 0;
                                _distance = (position _dog) distance (_nearest);
                                if (_distance < 100 && random 1 > 0.33) then {
                                        _dog domove position _nearest;
                                        _dog setspeedmode "FULL";
                                };
                                if ((_distance > 75) && (_distance < 100) && random 1 > 0.5) then {
                                        [_dog, _nearest] say3D "dog_01";
                                };
                                if ((_distance > 50) && (_distance < 75) && random 1 > 0.5) then {
                                        [_dog, _nearest] say3D "dog_01";
                                };
                                if ((_distance > 15) && (_distance < 50) && random 1 > 0.5) then {
                                        [_dog, _nearest] say3D "dog_yelp";
                                };
                                if ((_distance > 10) && (_distance < 15) && random 1 > 0.5) then {
                                        [_dog, _nearest] say3D "dog_02";
                                };
                                if (_distance < 2) then {
                                        [_dog, _nearest] say3D "dog_maul01";
                                        [_nearest, _dog] spawn dogs_fnc_dogattack;
                                };	
                        } else {
                                _r = random 1;
                                if (_r > 0.66 ) then {
                                        _dog domove ([_dog, 50] call CBA_fnc_randPos);
                                        _dog setspeedmode (["LIMITED","NORMAL","FULL"]call BIS_fnc_selectRandom);
                                };
                                if (_r > 0.5) then {
                                        _dog say3D "dog_01";
                                };
                        };
                };
        } forEach units _grp;
}, 5, [_grp]] call CBA_fnc_addPerFrameHandler;

_grp setVariable ["handle", _handle, true];
_grp;