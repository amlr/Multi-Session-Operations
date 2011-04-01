private ["_debug","_types","_name","_pos","_grp","_shepherd","_herd","_dogs"];
if (!isServer) exitWith{};
_debug = true;

waitUntil{!isNil "BIS_fnc_init"};

CRB_fnc_createShepherd = {
        private ["_civfaction","_shepherdClasses","_shepherdClass","_shepherd","_pos","_grp"];
        _pos = _this select 0;
        _grp = if(count _this > 1) then {_this select 1} else {createGroup civilian};
        // Choose shepherd
        _shepherdClasses = [];
        _civfaction = ["BIS_TK_CIV"];
        if(!isNil "BIS_alice_mainscope") then {
                _civfaction = BIS_alice_mainscope getVariable "townsFaction";
        };

        if("CIV" in _civfaction) then {
                _shepherdClasses = _shepherdClasses + [
                        "Villager1",
                        "Villager2",
                        "Villager3",
                        "Villager4",
                        "Woodlander1",
                        "Woodlander2",
                        "Woodlander3",
                        "Woodlander4",
                        "Worker1",
                        "Worker2",
                        "Worker3",
                        "Worker4"
                ];
        };
        
        if("CIV_RU" in _civfaction) then {
                _shepherdClasses = _shepherdClasses + [
                        "RU_Villager1",
                        "RU_Villager2",
                        "RU_Villager3",
                        "RU_Villager4",
                        "RU_Woodlander1",
                        "RU_Woodlander2",
                        "RU_Woodlander3",
                        "RU_Woodlander4",
                        "RU_Worker1",
                        "RU_Worker2",
                        "RU_Worker3",
                        "RU_Worker4"
                ];
        };
        
        if("BIS_TK_CIV" in _civfaction) then {
                _shepherdClasses = _shepherdClasses + [
                        "TK_CIV_Takistani01_EP1",
                        "TK_CIV_Takistani02_EP1",
                        "TK_CIV_Takistani03_EP1",
                        "TK_CIV_Takistani04_EP1",
                        "TK_CIV_Takistani05_EP1",
                        "TK_CIV_Takistani06_EP1"
                ];
        };
        
        _shepherdClass = _shepherdClasses call BIS_fnc_selectRandom;
        _shepherd = (createGroup civilian) createUnit [_shepherdClass, _pos, [], 0, "NONE"];
        [_shepherd] joinSilent _grp;
        _shepherd setSkill 0.5 + (random 0.5);
        _shepherd allowFleeing 0;
        _shepherd setSpeedMode "LIMITED";
        _shepherd setBehaviour "SAFE";
        _shepherd setRank "CORPORAL";
        
        _shepherd addMPEventHandler ["MPKilled",{[([position (_this select 0), group (_this select 0)] call CRB_fnc_createShepherd)] call CRB_fnc_armShepherd;}];        
        _shepherd;
};

CRB_fnc_armShepherd = {
        private ["_shepherd","_arm"];
        // Arm shepherd
        _shepherd = _this select 0;
        _arm = [
                ["Huntingrifle","5x_22_LR_17_HMR"],
                ["AK_47_M", "30Rnd_762x39_AK47"]
        ] call BIS_fnc_selectRandom;
        for "_i" from 0 to 5 do {
                _shepherd addMagazine (_arm select 1);
        };
        _shepherd addWeapon (_arm select 0);
        _shepherd action ["WeaponOnBack", _shepherd];
};

CRB_fnc_shepherdAttack = {
        private ["_shepherd","_target","_delaytime","_unit"];
        _unit = _this select 0;
        _shepherd = _unit getVariable "Shepherd";
        _shepherd setVariable ["attacking", true, true];
        _target = _this select 1;
        _shepherd reveal _target;
        _shepherd setSpeedMode "FULL";
        _shepherd setBehaviour "ALERT";
        
        _target addRating -2400;
        _delaytime = time + 30;
        while{alive _shepherd && alive _target && time < _delaytime} do {
                _shepherd doMove position _unit;
                sleep 3 + random 3;
                _shepherd doWatch _target;
                _shepherd doTarget _target;
                sleep 3 + random 3;
        };
        _target addRating +2000;
        _shepherd setSpeedMode "LIMITED";
        _shepherd setBehaviour "SAFE";
        sleep 2;
        _shepherd setVariable ["attacking", false, true];
        _shepherd action ["WeaponOnBack", _shepherd];
};

CRB_fnc_createDogs = {
        private ["_dogClass","_dog","_pos","_dogs"];
        _pos = _this select 0;
        _dogs = [];
        // Create dogs
        for "_i" from 0 to floor(random 2) do {
                _dogClass = [
                        "Fin",
                        "Pastor"
                ] call BIS_fnc_selectRandom;
                _dog = (createGroup civilian) createUnit [_dogClass, _pos, [], 10, "NONE"];
                _dog setSkill (random 0.5);
                _dog allowFleeing 0;
                _dog addMPEventHandler ["MPKilled",{_this spawn CRB_fnc_shepherdAttack;}];
                _dogs = _dogs + [_dog];
        };
        
        _dogs;
};

CRB_fnc_createHerd = {
        private ["_herdClass","_h","_herd","_pos","_herdType"];
        // Create herd       
        _pos = _this select 0;
        _herd = [];
        
        // Choose herd type
        _herdType = floor(random 3);                        
        _herdClass = [];
        switch(_herdType) do {
                case 0: {
                        _herdClass = [
                                "Cow01",
                                "Cow02",
                                "Cow03",
                                "Cow04"
                        ];
                };                        
                case 1: {
                        _herdClass = [
                                "Goat"
                        ];
                };
                case 2: {
                        _herdClass = [                                        
                                "Sheep"
                        ];
                };
        };
        
        // Create animals
        for "_i" from 0 to 6 + floor(random 12) do {
                _h = (createGroup civilian) createUnit [(_herdClass call BIS_fnc_selectRandom), _pos, [], 30, "NONE"];
                _h setSkill 0;
                _h allowFleeing 1;
                _h setBehaviour "SAFE";
                _h addMPEventHandler ["MPKilled",{_this spawn CRB_fnc_shepherdAttack;}];
                _herd = _herd + [_h];
        };
        
        _herd;
};

if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

_types = ["FlatArea","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
{
        if(type _x in _types) then {
                if (random 1 > 0.9) then {        
                        _name = format["shepherd_%1", floor(random 10000)];
                        if(_debug) then {
                                diag_log format["MSO-%1 shepherds: create %2", time, _name];
                                hint format["MSO-%1 shepherds: create %2", time, _name];
                        };
                        
                        // Choose random position
                        _pos = position _x;
                        _pos = [_pos, 0, 50, 1, 0, 50, 0] call bis_fnc_findSafePos;
                        _grp = createGroup civilian;
                        
                        _herd = [_pos] call CRB_fnc_createHerd;
                        _dogs = [_pos] call CRB_fnc_createDogs;
                        _shepherd = [_pos] call CRB_fnc_createShepherd;
                        [_shepherd] call CRB_fnc_armShepherd;
                        
                        [_shepherd] joinSilent _grp;
                        (_herd + _dogs ) joinSilent _grp;
                        
                        {_x setVariable ["Shepherd", _shepherd, true];} forEach units _grp;
                        _shepherd setPos _pos;
                        
                        if (_debug) then {
                                hint format["shepherds: creating m_%1",  _name];
                                ["m_" + _name, _pos,  "Icon", [1,1], "TYPE:", "Dot", "TEXT:", _name,  "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                                //player setPos _pos;
                        };                      
                        
                        _shepherd setSpeedMode "LIMITED";
                        _shepherd setBehaviour "SAFE";
                        _shepherd setFormation "DELTA";
                        
                        _grp enableAttack true;
                        _grp selectLeader _shepherd;
                        
                        [{
                                private ["_h","_leader","_pos","_params","_maxdist","_grp"];
                                _params = _this select 0;
                                _grp = _params select 0;
                                _name = _params select 1;
                                _debug = _params select 2;
                                _maxdist = 30;
                                _leader = leader _grp;
                                
                                if(_leader getVariable "attacking") exitWith{};
                                
                                {
                                        _h = _x;
                                        
                                        _wait = _h getVariable "wait";
                                        if(isNil "_wait") then {
                                                _h setVariable ["wait", time, true];
                                        };
                                        
                                        
                                        if(_leader distance _h < _maxdist && typeOf _h != "Pastor" && typeOf _h != "Fin") then {  
                                                // limited speed
                                                //if(_debug) then {player globalChat format["Limited %1", _h];};
                                                _h setSpeedMode "LIMITED";
                                        } else {
                                                // full speed
                                                //if(_debug) then {player globalChat format["Full %1", _h];};
                                                _h setSpeedMode "FULL";
                                        };
                                        
                                        // Not Man  && unit near leader && unit ready (stopped units are never ready)
                                        if (_leader != _h && _h distance _leader < _maxdist * 0.1 && unitReady _h) then {
                                                //if(_debug) then {player globalChat format["Stop %1", _h];};
                                                doStop _h;
                                                _h setVariable ["wait", time + 30 + random 180, true];
                                        };
                                        
                                        // Dog and no longer waiting
                                        // Move to furthest animal
                                        if((typeOf _h == "Pastor" || typeOf _h == "Fin") && _h getVariable "wait" < time) then {  
                                                _dist = 0;
                                                _last = _h;
                                                { 
                                                        if (typeOf _x != "Pastor" && typeOf _x != "Fin" && _x distance _leader > _dist) then {                                                                 
                                                                _last = _x;                                                                
                                                                _dist = _x distance _leader;
                                                        };
                                                } forEach units _grp;
                                                
                                                _pos = [_last, 3] call CBA_fnc_randPos;
                                                _h doMove _pos;
                                                _h setVariable ["wait", time + _dist * 1.5, true];
                                        };
                                        
                                        // Man && unit ready (stopped units are never ready)
                                        if(_leader == _h && unitReady _h) then {
                                                if(_debug) then {
                                                        //player globalChat format["Action %1", _h];
                                                        format["m_%1", _name] setMarkerPos _pos;
                                                };
                                                doStop _h;
                                                _actions = [
                                                        "SitDown",
                                                        "StrokeFist",
                                                        "StrokeGun"
                                                ];
                                                if(random 1 > 0.5) then {_h action [_actions call BIS_fnc_selectRandom, _h];};
                                                _h setVariable ["wait", time + 30 + random 180, true];
                                        };
                                        
                                        // Time is up OR animals are too far away OR animals are right next to leader
                                        if (_h getVariable "wait" < time || (_leader != _h && _leader distance _h > _maxdist) || (_leader != _h && _h distance _leader < _maxdist * 0.1)) then {
                                                _pos = [position _leader, if(_leader == _h) then{_maxdist * 10} else { _maxdist}] call CBA_fnc_randPos;
                                                //if(_debug) then {player globalChat format["Move %1", _h];};
                                                _h domove _pos;
                                                _h action ["WeaponOnBack", _h];
                                                _h setVariable ["wait", time + (_h distance _pos) * 1.5, true];
                                        };                                        
                                } forEach units _grp;
                                
                                if(_grp call CBA_fnc_getAlive) then {[_grp getVariable "handle"] call CBA_fnc_removePerFrameHandler;};
                        },  1, [_grp, _name, _debug]] call CBA_fnc_addPerFrameHandler;
                };
        };
} forEach CRB_LOCS;
