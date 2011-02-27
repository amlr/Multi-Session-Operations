//execVM "modules\crb_terrorists\main.sqf";
//[position player, 1] call CRB_fnc_FindVehicle;
//[position player, 1] call CRB_fnc_SpawnVehicle
//(group player) setVariable ["Ammunition", [position player] call CRB_fnc_SpawnRandomAmmo, true];
//[units player, CIVAMMO] spawn CRB_fnc_ArmFromAmmo;
//[position player] call CRB_fnc_GetNearestTown;
//[[position ((group player) getVariable "Ammunition")] call CRB_fnc_GetNearestTown] call CRB_fnc_GetBuildingPosForTown;
//[group player, true] spawn CRB_fnc_RecruitMember;

private ["_spawnpoints","_debug","_spawn","_classMan","_terrorcrgo","_terrorlead","_vehicle","_vcargo","_twn","_grp","_terrorunit"];
if(!isServer) exitWith{};

_debug = true;

// Thanks to Pogoman's Insurgency for this code
#define intelMarkerType "hd_unknown"
#define intelRadius 750
PGM_fnc_CreateIntel = { 
        private ["_i","_sign","_sign2","_radius","_cache","_pos","_range"];
        
        _cache  = _this;	
        _i      = 0; 
        while{ (getMarkerPos format["%1intel%2", _cache, _i] select 0) != 0}do{ _i = _i + 1; sleep 0.1;}; 	
        _sign   = 1; 
        if (random 100 > 50) then { _sign = -1; }; 
        _sign2  = 1; 
        if (random 100 > 50) then { _sign2 = -1; }; 
        _radius = intelRadius - _i*50;
        if (_radius < 50) then { _radius = 50; };
        _pos    = [
                (getPosATL _cache select 0) + _sign *(random _radius),
                (getPosATL _cache select 1) + _sign2*(random _radius)
        ]; 
        _range  = round sqrt(_radius^2*2);
        _range  = _range - (_range % 50);
        [format["%1intel%2", _cache, _i], _pos, "Icon", [0.5,0.5], "TEXT:", format["%1m", _range], "TYPE:", intelMarkerType, "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
}; 

CRB_fnc_FindVehicle = {
        private ["_newveh","_vdist","_pos","_vcargo"];
        _pos = _this select 0;
        _vcargo = _this select 1;
        _vdist = 500;
        _newveh = objNull;
        {
                if((_x emptyPositions "cargo") >= _vcargo && ((_x distance _pos) < _vdist) && isNull (assignedDriver _x)) then {
                        _newveh = _x;
                        _vdist = _x distance _pos;
                };
        } forEach nearestObjects [_pos, ["Car"], 500];
        
        if(!isNull _newveh) then {
                //DEBUG:player sideChat format["Found vehicle: %1", _newveh];
                _newveh lock false;
                _newveh setDamage 0;
        } else {
                //DEBUG:player sideChat "No vehicle found";
        };
        
        _newveh;
};

CRB_fnc_SpawnVehicle = {
        private ["_vehicle","_vcargo","_tmp","_pos","_crew"];
        _pos = _this select 0;
        _crew = 1;
        if(count _this > 1) then {
                _crew = _this select 1;
        };
        _vcargo = 0;
        _vehicle = objNull;
        waitUntil{!isNil "bis_alice_mainscope"};
        while{_vcargo < _crew} do {
                deleteVehicle _vehicle;
                _tmp = (bis_alice_mainscope getvariable "ALICE_classesVehicles") call BIS_fnc_selectRandom;
                if(_tmp isKindOf "Car") then {
                        _vehicle = _tmp createVehicle _pos;
                        _vcargo = _vehicle emptyPositions "cargo";
                };
                sleep 0.1;
        };
        //DEBUG:player sideChat format["Spawned vehicle: %1", _vehicle];
        _vehicle;
};

CRB_fnc_SpawnRandomAmmo = {
        /*
        ["BAF_IEDBox","GuerillaCacheBox_EP1","GuerillaCacheBox","LocalBasicWeaponsBox","LocalBasicAmmunitionBox"],
        [1,1,5,5,10]
        */
        // Randomly pick and create ammo box
        private ["_aclass","_ammo","_pos"];
        _pos = _this select 0;
        _aclass = [
                ["GuerillaCacheBox_EP1","GuerillaCacheBox","LocalBasicWeaponsBox"],
                [1,5,5]
        ] call CRB_fnc_selectRandomBias;
        _ammo = createVehicle [_aclass, _pos, [], 0, "NONE"];
        _ammo setPos _pos;
        _ammo setVectorUp [0, 0, 1];
        _ammo;
};

CRB_fnc_ArmFromAmmo = {
        // Arm with weapons
        private ["_srcwep","_ammo","_units"];
        _units = _this select 0;
        _ammo = _this select 1;
        _srcwep = "";
        {
                // Pick a random weapon from crate
                while{alive _x && !(_x isKindOf "Woman_EP1") && !(_x isKindOf "Woman") && primaryWeapon _x == "" && count((getWeaponCargo _ammo) select 0) != 0} do {
                        _srcwep = ([(getWeaponCargo _ammo) select 0] call CBA_fnc_shuffle) select 0;
                        // Arm civilian with weapon
                        //DEBUG:hint str _srcwep;
                        _x action ["takeweapon", _ammo, _srcwep];
                        sleep 5;
                };
                _x selectWeapon _srcwep;
                _x setBehaviour "ALERT";
                _x setSpeedMode "FULL";
        } forEach _units;
};

CRB_fnc_GetBuildingPosForTown = {
        private ["_i","_j","_twn","_bldgpos","_nearbldgs"];
        _twn = _this select 0;
        _bldgpos = _twn getVariable "BuldingPositions";
        if(!isNil "_bldgpos") then {
                _bldgpos = _twn getVariable "BuldingPositions";
        } else {
                _bldgpos = [];
                _i = 0;
                _j = 0;
                _nearbldgs = nearestObjects [position _twn, ["Building"], 500];
                {
                        if(!surfaceIsWater position _x) then {
                                private["_y"];
                                _y = _x buildingPos _i;
                                while {format["%1", _y] != "[0,0,0]"} do {
                                        _bldgpos set [_j, _y];
                                        _i = _i + 1;
                                        _j = _j + 1;
                                        _y = _x buildingPos _i;
                                        sleep 0.1;
                                };
                                _i = 0;
                        };
                } forEach _nearbldgs;
                _twn setVariable ["BuldingPositions", _bldgpos];
        };
        _bldgpos;
};

CRB_fnc_GetNearestTown = {
        private ["_twn","_pos"];
        _pos = _this select 0;
        
        waitUntil{!isNil "bis_alice_mainscope"};
        _twn = (bis_alice_mainscope getvariable "townlist") select 0;
        {
                if(_twn distance _pos > _x distance _pos) then {
                        _twn = _x;
                };
        } forEach (bis_alice_mainscope getvariable "townlist");
        _twn;
};

CRB_fnc_InitClassLists = {
        private ["_class","_faction","_woman","_classlist"];
        waitUntil{!isNil "bis_alice_mainscope"};
        waitUntil{typeName (bis_alice_mainscope getvariable "ALICE_classes") == "ARRAY"};
        waitUntil{count (bis_alice_mainscope getvariable "ALICE_classes")  > 0};
        waitUntil{typeName (bis_alice_mainscope getvariable "townsFaction") == "ARRAY"};
        
        //--- Select driver
        _classlist = bis_alice_mainscope getvariable "ALICE_classes";
        CRB_classlistMen = [];
        CRB_classListFaction = [];
        {
                _class = _x select 0;
                //	_rarity = _x select 1;
                _faction = _x select 2;
                _woman = _x select 3;
                if (_faction in (BIS_alice_mainscope getVariable "townsFaction")) then {
                        CRB_classListFaction = CRB_classListFaction + [_class];
                        if (_woman == 0) then {
                                CRB_classlistMen = CRB_classlistMen + [_class];
                        };
                };
        } foreach _classlist;
};

CRB_fnc_GetUnitClass = {
        private ["_classMan","_classList","_rarity","_bldgposcount","_twnRarityUrban","_rarityRange","_unitrarity"];
        _classList = _this select 0;
        _bldgposcount = _this select 1;
        //        _twnRarityUrban = [_twn,["RARITY"]] call bis_fnc_locations;
        _twnRarityUrban = sqrt (_bldgposcount / 400);
        _rarityRange = 0.3 + (0.2 * _twnRarityUrban);
        
        _classMan = "";
        _rarity = 10;
        _unitrarity = bis_alice_mainscope getvariable "ALICE_classes";
        //DEBUG:hint format["%1 %2 %3 %4", _twnRarityUrban, _rarityRange];
        while{abs(_twnRarityUrban - _rarity) > _rarityRange} do {
                _classMan = _classList call BIS_fnc_selectRandom;
                _rarity = _unitrarity select ((_unitrarity find _classMan)+1);
                sleep 0.1;
        };
        
        _classMan;
};


CRB_fnc_RecruitMember = {
        private ["_t","_tcrm","_tcid","_bldgpos","_ammo","_grp","_debug","_recpos","_classMan","_recruit","_pos","_twn"];
        _grp = _this select 0;
        _debug = _this select 1;
        _ammo = _grp getVariable "Ammunition";
        if(isNil "_ammo") then { 
                _ammo = [position leader _grp] call CRB_fnc_SpawnRandomAmmo;
                _grp setVariable ["Ammunition", _ammo, true];
        };
        _tcid = _grp getVariable "ID";
        if(isNil "_tcid") then {_tcid = 0;};
        _pos = position _ammo;
        _twn = [_pos] call CRB_fnc_GetNearestTown;
        _bldgpos = [_twn] call CRB_fnc_GetBuildingPosForTown;
        _recpos = _bldgpos select floor(random count _bldgpos);
        if(isNil "_recpos") exitWith {hint "No recruit spawn position";};
        _tcrm = "";
        if (_debug) then {
                _t = format["tcell_r%1", _tcid];
                hint format["Cell#%1 - recruiting %2", _tcid, _t];
                _tcrm = [_t, _recpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorBlue", "GLOBAL"] call CBA_fnc_createMarker;
        };
        
        if(isNil "CRB_classlistFaction") then {
                [] call CRB_fnc_InitClassLists;
        };
        waitUntil{typeName CRB_classlistFaction == "ARRAY"};
        
        _classMan = CRB_classlistFaction call BIS_fnc_selectRandom;        
        _recruit = (createGroup civilian) createUnit [_classMan, _recpos, [], 0, "NONE"];
        _recruit setSkill (random 0.5);
        _recruit allowDamage false;
        _recruit move position _ammo;
        waitUntil{unitReady _recruit};
        _recruit allowDamage true;
        
        // Pick a random weapon from crate
        [[_recruit], _ammo] call CRB_fnc_ArmFromAmmo;
        [_recruit] joinSilent _grp;
        if (_debug) then {
                deleteMarker _tcrm;
        };
};

CRB_fnc_SplitCell = {
        private ["_newveh","_t","_tcrm","_tcid","_grp","_debug","_terrorlead","_pos","_count","_split","_newcell","_newtwn","_str","_newlead"];
        _grp = _this select 0;
        _debug = _this select 1;
        
        _tcid = _grp getVariable "ID";
        if(isNil "_tcid") then {_tcid = 0;};
        _terrorlead = leader _grp;
        _pos = position _terrorlead;
        _count = count(units _grp);
        _tcrm = "";
        // split
        _split = (ceil(random (_count / 2))) max 2;
        
        _newcell  = createGroup east;
        for "_i" from 0 to _split do {
                [(units _grp - [_terrorlead]) call BIS_fnc_selectRandom] joinSilent _newcell;
        };
        _newveh = [_pos, (count units _newcell) - 1] call CRB_fnc_FindVehicle;
        
        if(isNull _newveh) then {
                _newveh = [_pos, (count units _newcell) - 1] call CRB_fnc_SpawnVehicle;
        };
        
        if (_debug) then {
                _t = format["tcell_r%1", _tcid];
                _str = format["MSO-%1 Cell#%2 - splitting %3 %4", time, _tcid, _t, _newveh];
                hint _str;
                diag_log _str;
                _tcrm = [_t, position _newveh, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorYellow", "GLOBAL"] call CBA_fnc_createMarker;
        };
        
        _newlead = leader _newcell;
        _newlead setSkill 1;
        _newlead setBehaviour "ALERT";
        _newlead setSpeedMode "FULL";
        _newlead allowFleeing 0;
        _newlead assignAsDriver _newveh;
        _newcell addVehicle _newveh;
        _newlead move position _newveh;
        waitUntil{_newlead distance _newveh < 15};
        [_newlead] orderGetIn true;
        _newlead move _pos;
        waitUntil{_newlead distance _pos < 50};
        sleep 15;
        
        _newtwn = [];
        waitUntil{!isNil "bis_alice_mainscope"};
        {
                if(_pos distance _x < (BIS_alice_mainscope getvariable "trafficDistance")) then {
                        _newtwn = _newtwn + [_x];
                };
        } forEach (bis_alice_mainscope getvariable "townlist");
        
        _newtwn = _newtwn call BIS_fnc_selectRandom;
        
        if (_debug) then {
                deleteMarker _tcrm;
        };
        
        [_newlead, _newveh, _newtwn, _debug] call CRB_fnc_SpawnNewCell;      
};

CRB_fnc_SpawnNewCell = {
        private ["_terrorcrgo","_pos","_count","_terrorlead","_maxgroupsize","_ammo","_spawn","_vehicle","_twn","_bldgpos","_grp","_debug","_t","_tcid","_tcsm","_tcdm","_forcesplit"];
        _terrorlead = _this select 0;
        _vehicle = _this select 1;
        _twn = _this select 2;
        _debug = _this select 3;
        
        _spawn = position _terrorlead;
        _tcid = floor(random 10000);
        (group _terrorlead) setVariable ["ID", _tcid, true];
        _tcsm = "";
        _tcdm = "";
        if (_debug) then {
                _t = format["tcell_s%1", _tcid];
                _tcsm = [_t, _spawn, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorGreen", "GLOBAL"] call CBA_fnc_createMarker;
        };
        
        _terrorlead setSkill 1;
        _terrorlead setBehaviour "ALERT";
        _terrorlead setSpeedMode "FULL";
        _terrorlead allowFleeing 0;
        (group _terrorlead) setVariable ["CEP_disableCache", true, true];
        _maxgroupsize = 6 + floor(random 9);
        
        _ammo = [_spawn] call CRB_fnc_SpawnRandomAmmo;
        (group _terrorlead) setVariable ["Ammunition", _ammo, true];
        [units _terrorlead, _ammo] call CRB_fnc_ArmFromAmmo;
        
        // Get in car
        _terrorlead assignAsDriver _vehicle;
        
        _terrorcrgo = units _terrorlead - [_terrorlead];
        {
                _x assignAsCargo _vehicle;
                _x setSkill (random 0.5);
                _x setBehaviour "ALERT";
                _x setSpeedMode "FULL";
        } forEach _terrorcrgo;        
        
        units _terrorlead orderGetIn true;
        waitUntil{{!unitReady _x} count units _terrorlead == 0};
        _terrorlead setBehaviour "SAFE";
        
        _ammo setPos [0,0,0];
        
        _bldgpos = [_twn] call CRB_fnc_GetBuildingPosForTown;
        _pos = _bldgpos select floor(random count _bldgpos);
        if (_debug) then {
                _t = format["tcell_d%1", _tcid];
                _tcdm = [_t, _pos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
        };
        
        _terrorlead move _pos;
        
        waitUntil{_terrorlead distance _pos < 50};
        sleep 15;
        
        _ammo setPos _pos;
        _ammo setVectorUp [0,0,1];
        
        _terrorlead setBehaviour "ALERT";
        (group _terrorlead) leaveVehicle _vehicle;
        
        if (_debug) then {
                deleteMarker _tcsm;
        };
        
        [group _terrorlead, _pos] execVM "scripts\BIN_taskDefend.sqf";
        
        _grp = group _terrorlead;
        //{alive _x} count units _grp> 0 && 
        while{count((getWeaponCargo _ammo) select 0) != 0 || count((getMagazineCargo _ammo) select 0) != 0} do {
                _forcesplit = false;
                if(_debug) then {sleep 30} else {sleep 120 + random 180};
                if(count units _grp < _maxgroupsize) then {
                        [_grp, _debug] call CRB_fnc_RecruitMember;
                } else {
                        _forcesplit = true;
                };
                
                _count = count(units _grp);
                if((random 3 > 2  && _count >= 6) || _forcesplit) then {
                        _ammo call PGM_fnc_CreateIntel;
                        [_grp, _debug] spawn CRB_fnc_SplitCell;
                };                
        };
        
        _ammo call PGM_fnc_CreateIntel;
        
        if (_debug) then {
                hint format["Cell#%1 - no longer recruiting", _tcid];
                deleteMarker _tcdm;
        };
};

// Identify all random spawn points
waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

_spawnpoints = [];
{
        if(type _x == "BorderCrossing") then {
                _spawnpoints = _spawnpoints + [position _x];
        };
} forEach CRB_LOCS;

// Pick a spawn point
_spawn =  _spawnpoints call BIS_fnc_selectRandom;

//DEBUG:player setPos _spawn;
//DEBUG:sleep 15;

waitUntil{!isNil "bis_alice_mainscope"};
// Pick a civilian class and civilian vehicle class
if(isNil "CRB_classlistMen") then {
        [] call CRB_fnc_InitClassLists;
};        
waitUntil{typeName CRB_classlistMen == "ARRAY"};

// Create terrorist leader and vehicle
_classMan = CRB_classlistMen call BIS_fnc_selectRandom;
_grp  = createGroup east;
_terrorlead = (createGroup civilian) createUnit [_classMan, _spawn, [], 0, "NONE"];
[_terrorlead] joinSilent _grp;

//DEBUG:_vehicle = "Ikarus" createVehicle _spawn;
_vehicle = [_spawn] call CRB_fnc_SpawnVehicle;
_grp addVehicle _vehicle;

_vcargo = _vehicle emptyPositions "cargo";
//DEBUG:_twn = nearestLocation [_spawn, "CityCenter"];
_twn = (bis_alice_mainscope getvariable "townlist") call BIS_fnc_selectRandom;

if(isNil "CRB_classlistFaction") then {
        [] call CRB_fnc_InitClassLists;
};        
waitUntil{typeName CRB_classlistFaction == "ARRAY"};

_terrorcrgo = [];
for "_i" from 1 to floor(random _vcargo) do {
        _classMan  = CRB_classlistFaction call BIS_fnc_selectRandom;
	_terrorunit = (createGroup civilian) createUnit [_classMan, _spawn, [], 0, "NONE"];
        [_terrorunit] joinSilent _grp;
        _terrorcrgo = _terrorcrgo + [_terrorunit];
};

[_terrorlead, _vehicle, _twn, _debug] call CRB_fnc_SpawnNewCell;

/*
// Count max weapon and magazine slots in vehicle
_dstmags = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "transportMaxMagazines");
_dstweps = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "transportMaxWeapons");
// Remember original terrorlead weapon loadout
_tlmags = magazines _terrorlead;
_tlweps = weapons _terrorlead;
*/

/*
// Wait for weapon to transfer
waitUntil{count(weapons _terrorlead) > count(_tlweps)};
player globalChat str (count(weapons _terrorlead) > count(_tlweps));
// Check weapon and mag capacity in vehicle not yet reached
//if(_dstwep == 0) then { //skip to end

if(_dstmags < count((magazines _terrorlead) - _tlmags)) then {
        // Remove extra mags
        _extra = count((magazines _terrorlead) - _tlmags) - _dstmags;
        for "_i" from 0 to _extra do {
                _tlmagsx = magazines _terrorlead;
                _terrorlead action ["dropweapon", _ammo, ((magazines _terrorlead) - _tlmags) select 0];
                waitUntil{count(magazines _terrorlead) < count(_tlmagsx)};
        };
};
player globalChat str _dstmags;

// Transfer weapon to vehicle
_dstmags = _dstmags - count((magazines _terrorlead) - _tlmags);
player globalChat str _dstmags;
_dstweps = _dstweps - count((weapons _terrorlead) - _tlweps);
player globalChat str _dstweps;

sleep 10;
player globalChat str [_vehicle, _srcwep];
_terrorlead action ["dropweapon", _vehicle, _srcwep];
player globalChat str (weapons _terrorlead);
*/
