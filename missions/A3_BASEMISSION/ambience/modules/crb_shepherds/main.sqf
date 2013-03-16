#include <crbprofiler.hpp>

if(isNil "ambientShepherds")then{ambientShepherds = 1;};
if (ambientShepherds == 0) exitWith{};

// Exit if not HC and not a server
if(isnil "ShepherdsLocality") then {ShepherdsLocality = 0;};
if(
	switch (ShepherdsLocality) do {
	        case 0: {!isServer};
        	case 1: {!isHC};
	}
) exitWith{};

private ["_types","_name","_pos","_shepherds"];
crb_shepherds_debug = false;

waitUntil{!isNil "BIS_fnc_init"};

CRB_fnc_createShepherd = {
        CRBPROFILERSTART("CRB Shepherds createShepherd")
        
        private ["_civfaction","_shepherdClasses","_shepherdClass","_shepherd","_pos","_grp","_dist"];
        _pos = _this select 0;
        _dist = 0;
        _grp = createGroup civilian;
        if(count _this > 1) then {
                _grp = _this select 1;
                _dist = 500;
        };
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
        
        if("cwr2_civ" in _civfaction) then {
                _shepherdClasses = _shepherdClasses + [
			"cwr2_civilian5",
			"cwr2_civilian7",
			"cwr2_Civilian8"
                ];
        };

	if (count _shepherdClasses < 1) then {_shepherdClasses = _shepherdClasses + ["TK_CIV_Takistani01_EP1"]};
        
        _shepherdClass = _shepherdClasses call BIS_fnc_selectRandom;
        _shepherd = (createGroup civilian) createUnit [_shepherdClass, _pos, [], _dist, "NONE"];
        [_shepherd] joinSilent _grp;
        _shepherd setSkill 0.5 + (random 0.5);
        _shepherd allowFleeing 0;
        _shepherd setSpeedMode "LIMITED";
        _shepherd setBehaviour "CARELESS";
        _shepherd setRank "CORPORAL";
        _shepherd setVariable ["attacking", false];
        
        if(isDedicated) then {
                _shepherd addMPEventHandler ["MPKilled",{[([position (_this select 0), group (_this select 0)] call CRB_fnc_createShepherd)] call CRB_fnc_armShepherd;}];
        } else {
                _shepherd addEventHandler ["Killed",{[([position (_this select 0), group (_this select 0)] call CRB_fnc_createShepherd)] call CRB_fnc_armShepherd;}];
        };
        
        if(count _this > 1) then {
                {_x setVariable ["Shepherd", _shepherd];} forEach units _grp;
        };
        
        CRBPROFILERSTOP
        _shepherd;
};

CRB_fnc_armShepherd = {
        CRBPROFILERSTART("CRB Shepherds armShepherd")
        
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
        
        CRBPROFILERSTOP
};

CRB_fnc_shepherdAttack = {
        CRBPROFILERSTART("CRB Shepherds shepherdAttack")
        
        private ["_shepherd","_target","_delaytime","_unit"];
        _unit = _this select 0;
        _shepherd = _unit getVariable "Shepherd";
        _target = _this select 1;
        _target addRating -400;
        if(_shepherd getVariable "attacking") exitWith{};
        _shepherd setVariable ["attacking", true];
        diag_log format["MSO-%1 shepherds: %2 Attacking %3!", time, _shepherd, _target];
        
        _delaytime = time + 30;
        _shepherd setUnitPos "UP";
        _shepherd setSpeedMode "FULL";
        _shepherd setBehaviour "CARELESS";
        _shepherd reveal _target;
	_dogs = [];

	{
		if(typeOf _x == "Pastor" || typeOf _x == "Fin") then {  
			_x setspeedmode "FULL";
			_x domove position _target;
			_dogs set [count _dogs, _x];
		}
	} forEach units _shepherd;

        while{alive _shepherd && alive _target && time < _delaytime} do {
                _shepherd doWatch position _target;
                _shepherd doTarget _target;
                {_shepherd doFire _target;} count [1,2,3];
		{
			_x domove position _target;
			if(_x distance _target < 2.5) then {[_target, _x] spawn dogs_fnc_dogattack;};
		} forEach _dogs;
                sleep (1 + random 2);
        };
        _shepherd setUnitPos "AUTO";
        _shepherd setSpeedMode "LIMITED";
        _shepherd setBehaviour "CARELESS";
        _shepherd setVariable ["attacking", false];
        _shepherd action ["WeaponOnBack", _shepherd];
        
        CRBPROFILERSTOP
};

CRB_fnc_createDogs = {
        CRBPROFILERSTART("CRB Shepherds createDogs")
        
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
                if(isDedicated) then {
                        _dog addMPEventHandler ["MPKilled",{_this spawn CRB_fnc_shepherdAttack;}];
                        _dog addMPEventHandler ["MPHit",{_this spawn CRB_fnc_shepherdAttack;}];
                } else {
                        _dog addEventHandler ["Killed",{_this spawn CRB_fnc_shepherdAttack;}];
                        _dog addEventHandler ["Hit",{_this spawn CRB_fnc_shepherdAttack;}];
                };
                _dogs set [count _dogs, _dog];
        };
        
        CRBPROFILERSTOP
        _dogs;
};

CRB_fnc_createHerd = {
        CRBPROFILERSTART("CRB Shepherds createHerd")
        
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
                                "Goat",
				"Goat01_EP1",
				"Goat02_EP1"
                        ];
                };
                case 2: {
                        _herdClass = [                                        
                                "Sheep"
                        ];
                };
        };
        
        // Create animals
        for "_i" from 0 to 5 + floor(random 3) do {
                _h = (createGroup civilian) createUnit [(_herdClass call BIS_fnc_selectRandom), _pos, [], 30, "NONE"];
                _h setSkill 0;
                _h allowFleeing 1;
                _h setBehaviour "SAFE";
                if(isDedicated) then {
                        _h addMPEventHandler ["MPKilled",{_this spawn CRB_fnc_shepherdAttack;}];
                        _h addMPEventHandler ["MPHit",{_this spawn CRB_fnc_shepherdAttack;}];
                } else {
                        _h addEventHandler ["Killed",{_this spawn CRB_fnc_shepherdAttack;}];
                        _h addEventHandler ["Hit",{_this spawn CRB_fnc_shepherdAttack;}];
                };
                _herd set [count _herd, _h];
        };
        
        CRBPROFILERSTOP
        _herd;
};

if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

waitUntil{!isNil "CRB_LOCS"};

_types = ["FlatArea","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","NameVillage","NameLocal","ViewPoint","Hill"];
_shepherds = [];
{
        // find a spawn area
        if(type _x in _types) then {
                if (random 1 > 0.9) then {
                        _name = format["shepherd_%1", floor(random 10000)];
                        if(crb_shepherds_debug) then {
                                diag_log format["MSO-%1 shepherds: start %2", time, _name];
                                //hint format["MSO-%1 shepherds: create %2", time, _name];
                        };
                        
                        // Choose random position
                        _pos = position _x;
                        _pos set [2, 0];
                        //_pos = [_pos, 0, 50, 1, 0, 50, 0] call BIS_fnc_findSafePos;
                        _shepherds set [count _shepherds, _name];
                        
                        if (crb_shepherds_debug) then {
                                ["m_" + _name, _pos,  "Icon", [1,1], "TYPE:", "mil_dot", "TEXT:", _name,  "GLOBAL"] call CBA_fnc_createMarker;
                                //player setPos _pos;
                        };                      
                        
                        [_name, _pos] spawn {
                                CRBPROFILERSTART("CRB Shepherds")
                                
                                private ["_pos","_maxdist","_grp","_wait","_herd","_dogs","_shepherd","_name"];
                                _name = _this select 0;
                                _pos = _this select 1;
                                _grp = nil;
                                _maxdist = 20;
                                _wait = time + 60 + random 60;                                
                                
                                while{true} do {
                                        if({_pos distance _x < 800} count ([] call BIS_fnc_listPlayers) > 0) then {
                                                if(isNil "_grp") then {
                                                        if(crb_shepherds_debug) then {diag_log format["MSO-%1 Shepherds creating %2", time, _name];};
                                                        _grp = createGroup civilian;
                                                        _herd = [_pos] call CRB_fnc_createHerd;
                                                        _dogs = [_pos] call CRB_fnc_createDogs;
                                                        _shepherd = [_pos] call CRB_fnc_createShepherd;
                                                        [_shepherd] call CRB_fnc_armShepherd;
                                                        
                                                        [_shepherd] joinSilent _grp;
                                                        (_herd + _dogs ) joinSilent _grp;
                                                        
                                                        {_x setVariable ["Shepherd", _shepherd];} forEach units _grp;
                                                        _shepherd setPos _pos;
                                                        
                                                        _shepherd setSpeedMode "LIMITED";
                                                        _shepherd setBehaviour "CARELESS";
                                                        _shepherd setFormation "DELTA";
                                                        
                                                        _grp enableAttack true;
                                                        _grp selectLeader _shepherd;
                                                };
                                                if(!isNil "_grp") then {
                                                        _leader = leader _grp;
                                                        
                                                        if(!(_leader getVariable "attacking")) then {
                                                                if(crb_shepherds_debug) then {
                                                                        //player globalChat format["Checking %1", _name];
                                                                        if(alive _leader) then {format["m_%1",_name] setMarkerPos position _leader;};
                                                                }; 
                                                                
                                                                {
                                                                        _h = _x;
                                                                        
                                                                        _wait = _h getVariable "wait";
                                                                        if(isNil "_wait") then {
                                                                                _h setVariable ["wait", time];
                                                                        };
                                                                        
                                                                        // Not Man  && unit near leader && unit ready (stopped units are never ready)
                                                                        if (_leader != _h && _h distance _leader < _maxdist * 0.1 && unitReady _h) then {
                                                                                //if(crb_shepherds_debug) then {player globalChat format["Stop cow %1", _h];};
                                                                                doStop _h;
                                                                                _h setVariable ["wait", time + 30 + random 180];
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
                                                                                
                                                                                //if(crb_shepherds_debug) then {player globalChat format["Move dog %1", _h];};
                                                                                _h doMove ([position _last, 3] call CBA_fnc_randPos);
                                                                                _h setVariable ["wait", time + (_h distance _last) * random 0.5];
                                                                        };
                                                                        
                                                                        // Man && unit ready (stopped units are never ready)
                                                                        if(_leader == _h && unitReady _h) then {
                                                                                if(crb_shepherds_debug) then {player globalChat format["Stop man %1", _h];};
                                                                                doStop _h;
                                                                                _actions = [
                                                                                        "SitDown",
                                                                                        "StrokeFist",
                                                                                        "StrokeGun"
                                                                                ];
                                                                                if(random 1 > 0.5) then {_h action [_actions call BIS_fnc_selectRandom, _h];};
                                                                                _h setVariable ["wait", time + 5 + random 60];
                                                                        };
                                                                        
                                                                        // Time is up OR animals are too far away OR animals are right next to leader
                                                                        if (
                                                                                (_h getVariable "wait" < time ||
                                                                                (_leader != _h && _leader distance _h > _maxdist) ||
                                                                                (_leader != _h && _h distance _leader < _maxdist * 0.1)) &&
                                                                                (typeOf _x != "Pastor" && typeOf _x != "Fin")
                                                                        ) then {
                                                                                if(_leader == _h || unitReady _h) then{
	                                                                                _pos = [_leader modelToWorld [0,_maxdist,0], _maxdist * 5] call CBA_fnc_randPos;
										} else {
											_pos = [_leader modelToWorld [0,_maxdist,0], _maxdist] call CBA_fnc_randPos;
										};
                                                                                _h doMove _pos;
                                                                                if(_leader == _h) then {
                                                                                        if(crb_shepherds_debug) then {
                                                                                                player globalChat format["Move leader %1", _h];
                                                                                        };
                                                                                        _h action ["WeaponOnBack", _h];
                                                                                } else {
                                                                                        //player globalChat format["Move herd %1", _h];
                                                                                };
                                                                                
                                                                                _h setVariable ["wait", time + (_h distance _pos) * random 1.5];
                                                                        };

                                                                        if (_leader distance _h < _maxdist / 2 && typeOf _h != "Pastor" && typeOf _h != "Fin" || _leader == _h ) then {  
                                                                                // limited speed
                                                                                //if(crb_shepherds_debug) then {player globalChat format["Limited %1", _h];};
                                                                                _h setSpeedMode "LIMITED";
                                                                        } else {
                                                                                // full speed
                                                                                //if(crb_shepherds_debug) then {player globalChat format["Full %1", _h];};
                                                                                _h setSpeedMode "FULL";
                                                                        };
                                                                        
                                                                } forEach units _grp;
                                                        };
                                                };
                                        };
                                        
                                        if({_pos distance _x < 800} count ([] call BIS_fnc_listPlayers) == 0 && !isNil "_grp") then {
                                                if(crb_shepherds_debug) then {diag_log format["MSO-%1 Shepherds destroying %2", time, _name];};
                                                {deleteVehicle _x} foreach units _grp;
                                                deleteGroup _grp;
                                                _grp = nil;
                                        };
                                        
                                        if (_wait < time && isNil "_grp") then {
                                                private["_oldpos"];
                                                _oldpos = _pos;
                                                _pos = [_pos, _maxdist * 5] call CBA_fnc_randPos;
                                                _wait = time + (_oldpos distance _pos) * 1.5;
                                                if(crb_shepherds_debug) then {
                                                        diag_log format["MSO-%1 Shepherds moving %2", time, _name];
                                                        format["m_%1",_name] setMarkerPos _pos;
                                                };
                                        };
                                        
                                        CRBPROFILERSTOP
                                        sleep 5;
                                };
                        };
                };
        };
} forEach CRB_LOCS;
diag_log format["MSO-%1 Shepherds # %2", time, count _shepherds];
if(crb_shepherds_debug) then {hint format["MSO-%1 Shepherds # %2", time, count _shepherds];};
