diag_log format["MSO-%1 CQB Population: starting to load functions...", time];

CQB_findnearhousepos = {
private ["_pos","_radius"];

_pos = _this select 0;
_radius = _this select 1;

_nearbldgs = nearestObjects [_pos, ["Building"], _radius];
{
	private["_housepos", "_poscount","_i","_y"];
    _poscount = 0;
    _i = 0;
	_housepos = _x buildingPos _poscount;
    _y = _x buildingPos _i;
	
    while {format["%1", _housepos] != "[0,0,0]"} do {
        _poscount = _poscount + 1;
        _housepos = _x buildingPos _poscount;
        
    }; 
    
    if (_poscount > 2) then {
    		for "_z" from 0 to (_poscount - 2) do {
				if ((_y select 2 < 3) && (_i > 0)) then {
					_bldgpos set [count _bldgpos, _y];
				};
				_i = _i + 1;
				_y = _x buildingPos _i;
			};
    };
} forEach _nearbldgs;
_bldgpos;
};

CQB_setposgroup = {
private ["_leader","_unit","_spawnpos","_units"];
    
	_group = _this select 0;
	_bldgpos = _this select 1;
	_leader = leader _group;
	_units = units _group;

	for "_i" from 0 to ((count _units)-1) do {
		_spawnpos = _bldgpos select floor(random count _bldgpos);
		_unit = (_units select _i);
		_unit setpos _spawnpos;
		_unit setUnitPos "Middle";
	if ((getposATL _unit select 2) > 3) then {
        _unit setUnitPos "DOWN"};
	};
    
    [_units] spawn {
		{
        	sleep 20;
        	_x setUnitPos "AUTO";
		} foreach (_this select 0);
	};
};


CQB_houseguardloop = {

_pos = _this select 0;
_group = _this select 1;
_house = _this select 2;
_bldgpos = _this select 3;
_despawn = _this select 4;
_debug = debug_mso;
  
_cleared = false;
_suspended = false;
_patrol = false;
_movehome = false;

while {!(_cleared) && !(_suspended) && ({_pos distance _x < 2500} count ([] call BIS_fnc_listPlayers) > 0)} do {
sleep 2;   
	_near = ({_pos distance _x < _despawn} count ([] call BIS_fnc_listPlayers) > 0);
    
    if ((_near) && !(_patrol)) then {
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Telling group %2 to guard house...", time, _group]};
        
        {
        	_x setUnitPos "AUTO";
        	_x setbehaviour "AWARE";
        	dostop _x;
            0 = [_x, 50, true, 300, _pos,_despawn] spawn MSO_fnc_CQBhousepos;
        } foreach units _group;

        _patrol = true;
        _movehome = false;
    };
    
    if (!(_near) && !(_movehome)) then {
        _patrol = false;
        _movehome = true;
        
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Sending group %2 home...", time, _group]};
		while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
		_endpos = _bldgpos select floor(random count _bldgpos);

        {
            _x domove _endpos;
		} foreach units _group;
    };
    
	if (_movehome) then {
		{
			if (_x distance _endpos < 4) then {
        	    _x setdamage 1;
       			deletevehicle _x;
      		};
    	} foreach units _group;
    };
if ((count (units _group) == 0) && (_patrol)) then {_house setvariable ["c", true, true]; _cleared = true};
if ((count (units _group) == 0) && (_movehome)) then {_suspended = true};
};

};

CQB_patrolloop = {

_pos = _this select 0;
_group = _this select 1;
_house = _this select 2;
_bldgpos = _this select 3;
_despawn = _this select 4;
_debug = debug_mso;
    
_cleared = false;
_suspended = false;
_patrol = false;
_movehome = false;

while {!(_cleared) && !(_suspended) && ({_pos distance _x < 2500} count ([] call BIS_fnc_listPlayers) > 0)} do {
sleep 2;   
	_near = ({_pos distance _x < _despawn} count ([] call BIS_fnc_listPlayers) > 0);
    
    if ((_near) && !(_patrol)) then {
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Sending group %2 on patrol...", time, _group]};
        [_group, _pos, 150] spawn BIN_fnc_taskPatrol;
    	_patrol = true;
        _movehome = false;
    };
    
    if (!(_near) && !(_movehome)) then {
        _patrol = false;
        _movehome = true;
        if (_debug) then {diag_log format["MSO-%1 CQB Population: Sending group %2 home...", time, _group]};
		while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
		_endpos = _bldgpos select floor(random count _bldgpos);

        {
            _x domove _endpos;
		} foreach units _group;
    };
    
if (_movehome) then {
	{
		if (_x distance _endpos < 4) then {
            _x setdamage 1;
       		deletevehicle _x;
        };
    } foreach units _group;
};
if ((count (units _group) == 0) && (_patrol)) then {_house setvariable ["c", true, true]; _cleared = true};
if ((count (units _group) == 0) && (_movehome)) then {_suspended = true};
};

};

MSO_fnc_CQBspawnRandomgroup = {
if (({(local _x) && ((faction _x) in MSO_FACTIONS)} count allunits) > CQBaicap) exitwith {diag_log format["MSO-%1 CQB Population: Local AI unitcount above limits. Exiting...", time]};

_pos = _this select 0;
_house = _this select 1;
_despawn = _this select 2;

_group = creategroup EAST;
_units = [];

for "_i" from 0 to (1 + floor(random 2)) do {
	_unittype = [0, MSO_FACTIONS,"Man"] call mso_core_fnc_findVehicleType;
	_unittype = _unittype call BIS_fnc_selectRandom;
	_unit = _group createUnit [_unittype,[0,0,0],[],0,"NONE"];
    _units set [count _units,_unit];
};

CQBgroupsLocal set [count CQBgroupsLocal, _group];
diag_log format["MSO-%1 CQB Population: Created group name %2 with %3 units...", time, _group, count units _group];

[_pos, _house, _group, _units, _despawn] spawn MSO_fnc_CQBmovegroup;
_group;
};

MSO_fnc_CQBmovegroup = {
if (isDedicated) exitwith {};

private ["_bldgpos","_nearbldgs","_unittype","_spawnpos","_endpos","_unit","_leader","_group","_count","_units","_cleared","_suspended","_patrol","_movehome","_near","_houseguards"];
waitUntil {!isNil "bis_fnc_init"};

_pos = _this select 0;
_house = _this select 1;
_group = _this select 2;
_units = _this select 3;
_despawn = _this select 4;
_debug = debug_mso;
_bldgpos = [];

_house setVariable ["s", true, CQBaiBroadcast];

_bldgpos = [_pos,100]  call CQB_findnearhousepos;
if (_debug) then {diag_log format["MSO-%1 CQB Population: Found %2 buildingpositions...", time, count _bldgpos]};

[_group, _bldgpos] call CQB_setposgroup;

if ((random 1 > 0.35)) then {_houseguards = true;} else {_houseguards = false;};
waituntil {!(isnil "_houseguards")};

if (_houseguards) then {
	[_pos,_group,_house,_bldgpos,_despawn] call CQB_houseguardloop;
} else {
    [_pos,_group,_house,_bldgpos,_despawn] call CQB_patrolloop;
};

{
      _x setdamage 1;
      deletevehicle _x;
} foreach _units;
       
waituntil {count (units _group) == 0};
diag_log format["MSO-%1 CQB Population: Group %2 deleted - script end...", time, _group];
deletegroup _group;
_house setvariable ["s",nil, CQBaiBroadcast];

true;
};

MSO_fnc_getEnterableHouses = {
private ['_position','_radius'];

_position = _this select 0;
_radius = _this select 1;
_houses = nearestObjects[_position,["House"],_radius];
_houses_enterable=[];
{	_house = _x;
	_i = 0;
	While{count ((_house buildingPos _i)-[0]) > 0} do {_i = _i+1};
	_maxbuildingpos = _i - 1;

	if(_maxbuildingpos>0) then{_houses_enterable = _houses_enterable + [[_house,_maxbuildingpos]]};
} foreach _houses;

_houses_enterable
};

getGridPos = { 		
    private ["_pos","_x","_y"];
    
 	_pos = getPosATL _this; 
 	_x = _pos select 0;
 	_y = _pos select 1;
 	_x = _x - (_x % 100); 
 	_y = _y - (_y % 100);
	[_x + 50, _y + 50, 0]
};

MSO_fnc_CQBgetSpawnposRegular = {
private ["_spawnhouses","_positions","_t","_m","_cqb_spawn_intensity","_BuildingTypeStrategic"];

_spawnhouses = _this select 0;

_base1 = markerpos "ammo_1";
_base2 = markerpos "ammo";
if (isnil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 1000};

_positions = [];
_cqb_spawn_intensity = 1 - (cqb_spawn / 10);

_BuildingTypeStrategic = [
"Land_A_TVTower_Base",
"Land_Dam_ConcP_20",
"Land_Ind_Expedice_1",
"Land_Ind_SiloVelke_02",
"Land_Mil_Barracks",
"Land_Mil_Barracks_i",
"Land_Mil_Barracks_L",
"Land_Mil_Guardhouse",
"Land_Mil_House",
"Land_trafostanica_velka",
"Land_Ind_Oil_Tower_EP1",
"Land_A_Villa_EP1",
"Land_Mil_Barracks_EP1",
"Land_Mil_Barracks_i_EP1",
"Land_Mil_Barracks_L_EP1",
"Land_Barrack2",
"Land_fortified_nest_small_EP1",
"Land_fortified_nest_big_EP1",
"Land_Fort_Watchtower_EP1",
"Land_Ind_PowerStation_EP1",
"Land_Ind_PowerStation"];

{
    if (!(typeof (_x select 0) in _BuildingTypeStrategic) && ((random 1) > _cqb_spawn_intensity) && (((position (_x select 0)) distance _base1) > rmm_ep_safe_zone) && (((position (_x select 0)) distance _base2) > rmm_ep_safe_zone)) then {
    	_positions set [count _positions,_x];
    };
} foreach _spawnhouses;

if (_debug) then {
    diag_log format["MSO-%1 CQB Population: Regular positions found %2", time, count _positions];
    
    _i = 0;
	for "_i" from 0 to ((count _positions) - 1) do {
         _t = format["op%1",_i];
    	_m = [_t, position ((_positions select _i) select 0), "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorRed","GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
    };
};

_positions;
};

MSO_fnc_CQBgetSpawnposStrategic = {
    private ["_spawnhouses","_housecount","_positions","_position","_t","_m","_cqb_spawn_intensity","_BuildingTypeStrategic"];

_spawnhouses = _this select 0;

_base1 = markerpos "ammo_1";
_base2 = markerpos "ammo";
if (isnil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 1000};

_positions = [];
_positionsStrategic = [];
_cqb_spawn_intensity = 1 - (cqb_spawn / 10);

_BuildingTypeStrategic = [
"Land_A_TVTower_Base",
"Land_Dam_ConcP_20",
"Land_Ind_Expedice_1",
"Land_Ind_SiloVelke_02",
"Land_Mil_Barracks",
"Land_Mil_Barracks_i",
"Land_Mil_Barracks_L",
"Land_Mil_Guardhouse",
"Land_Mil_House",
"Land_trafostanica_velka",
"Land_Ind_Oil_Tower_EP1",
"Land_A_Villa_EP1",
"Land_Mil_Barracks_EP1",
"Land_Mil_Barracks_i_EP1",
"Land_Mil_Barracks_L_EP1",
"Land_Barrack2",
"Land_fortified_nest_small_EP1",
"Land_fortified_nest_big_EP1",
"Land_Fort_Watchtower_EP1",
"Land_Ind_PowerStation_EP1",
"Land_Ind_PowerStation"];

{
    if ((typeof (_x select 0) in _BuildingTypeStrategic) && (((position (_x select 0)) distance _base1) > rmm_ep_safe_zone) && (((position (_x select 0)) distance _base2) > rmm_ep_safe_zone)) then {
    	_positionsStrategic set [count _positionsStrategic,_x];
    };
} foreach _spawnhouses;

if (_debug) then {
    diag_log format["MSO-%1 CQB Population: Strategic positions found %2", time, count _positionsStrategic];
    
    _i = 0;
	for "_i" from 0 to ((count _positionsStrategic) - 1) do {
         _t = format["sp%1",_i];
    	_m = [_t, position ((_positionsStrategic select _i) select 0), "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorGreen","GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
    };
};

_positionsStrategic;
};

MSO_fnc_CQBclientloop = {
    	private ["_debug","_idx","_loopcounter","_localEnemyCount"];

        waituntil {!(isnil "CQBpositionsReg") && !(isnil "CQBpositionsStrat")};
		CQBpositionsRegLocal = CQBpositionsReg;
		CQBpositionsStratLocal = CQBpositionsStrat;
        CQBpositionsLocal = CQBpositionsRegLocal + CQBpositionsStratLocal;
		{(_x select 0) setVariable ["reg", true, false]} foreach CQBpositionsRegLocal;
        {(_x select 0) setVariable ["strat", true, false]} foreach CQBpositionsStratLocal;
        CQBgroupsLocal = [];
        
		_debug = _this select 0;
		
		while {true} do {
                _activecount = 0;
                _suspendedcount = 0;
                _clearcount = 0;
        		{
                    _strategic = (_x select 0) getVariable "strat";
                    _regular = (_x select 0) getVariable "reg";
                    _clear = (_x select 0) getVariable "c";
                    _suspend = (_x select 0) getVariable "s";
                    _pos = position (_x select 0);
                    
                    if ((isnil "_suspend") && (isnil "_clear")) then {_activecount = _activecount + 1};
                    if (!(isnil "_suspend")) then {_suspendedcount = _suspendedcount + 1};
                    if (!(isnil "_clear")) then {_clearcount = _clearcount + 1};
                    if (CQB_AUTO) then {CQBaicap = (count allUnits / count playableUnits)};
	
                    if (((_x select 0) distance player < 800) && (((position player) select 2) < 5) && (({(local _x) && ((faction _x) in MSO_FACTIONS)} count allunits) < CQBaicap)) then {
                        
                        if (((_x select 0) distance player < 800) && _strategic) then {
                        	if ((isnil "_suspend") && (isnil "_clear")) then {
                    			[(_pos),(_x select 0),1000] call MSO_fnc_CQBspawnRandomgroup;
                    		};
                        };
                        
                        if (((_x select 0) distance player < 500) && ((_x select 0) distance player > 100) && _regular) then {
                        	if ((isnil "_suspend") && (isnil "_clear")) then {
                    			[(_pos),(_x select 0),600] call MSO_fnc_CQBspawnRandomgroup;
                    		};
                        };
                    };
				} foreach CQBpositionsLocal;
			sleep 1;
        	{
            	if (count (units _x) == 0) then {
		   			if (_debug) then {diag_log format["MSO-%1 CQB Population: Garbage collecter deleting Group %2...", time, _x]};
            	    CQBgroupsLocal = CQBgroupsLocal - [_x];
           		    deletegroup _x;
                };
        	} foreach CQBgroupsLocal;
            if (_debug) then {
                diag_log format["MSO-%1 CQB Population: %2 total | %3 suspended |%4 cleared positions...", time, _activecount, _suspendedcount, _clearcount];
                diag_log format["MSO-%1 CQB Population: Count %2 local AI in %4 CQB-groups (%3 total AI overall)...", time, {local _x} count allUnits, count allUnits, count CQBgroupsLocal];
            };
		};
};

MSO_fnc_CQBhousepos = {
    //////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: (AEF)Wolffy.au
// Created: 20100705
// Modified: 20100706
// Contact: http://creobellum.org
// Purpose: Move or patrol a unit to random house positions
//
// The following code is an extract from Random Building Position Script v1.0 by Tophe of Östgöta Ops
// Usage:
// Move unit to random house position within 10m
// 0 = [this] execVM  "scripts\crb_scripts\crB_HousePos.sqf";
//
// Move unit to random house position within 50m
// 0 = [this, 50] execVM "scripts\crb_scripts\crB_HousePos.sqf";
//
// Patrol unit to random house positions within 50m with a maximum
// 	wait time 300 sec between positions
// 0 = [this, 50, true] execVM "scripts\crb_scripts\crB_HousePos.sqf";
//
// Patrol unit to random house positions within 50m with a maximum
// 	wait time 600 sec between positions
// 0 = [this, 50, true, 600] execVM "scripts\crb_scripts\crB_HousePos.sqf";
//////////////////////////////////////////////////////////////////
//if (!isServer) exitwith {};
private["_obj","_radius","_patrol","_maxwait","_pos","_bldgpos","_i","_nearbldgs"];
_obj = _this select 0;
_radius = 10;
if(count _this > 1) then {_radius = _this select 1;};
_patrol = false;
if(count _this > 2) then {_patrol = _this select 2;};
_maxwait = 300;
if(count _this > 3) then {_maxwait = _this select 3;};
_pos = getPos _obj;
if(count _this > 4) then {_pos = _this select 4;};
_despawn = 500;
if(count _this > 5) then {_despawn = _this select 5;};

_bldgpos = [];
_i = 0;
_nearbldgs = nearestObjects [_pos, ["Building"], _radius];
{
	private["_y"];
	_y = _x buildingPos _i;
	while {format["%1", _y] != "[0,0,0]"} do {
		_bldgpos set [count _bldgpos, _y];
		_i = _i + 1;
		_y = _x buildingPos _i;
	};
	_i = 0;
} forEach _nearbldgs;

_pos = _bldgpos select floor(random count _bldgpos);
if(_patrol) then {
	_obj setSpeedMode "LIMITED";
};
_obj setCombatMode "YELLOW";
_obj doMove _pos;

if(_obj isKindOf "Man") then {
	[_obj, 360, "SAFE", "UP", false, 30] call compile preprocessFileLineNumbers "support\scripts\GuardPost.sqf";
} else {
	_obj setDir (random 360);
};

//waitUntil{unitReady _obj;};
while{_patrol && alive _obj && ({_pos distance _x < _despawn} count ([] call BIS_fnc_listPlayers) > 0)} do {
	sleep (5 + (random _maxwait));
	_pos = _bldgpos select floor(random count _bldgpos);
	_obj doMove _pos;
//	waitUntil{unitReady _obj;};
//	_obj setDirection (random 360);
};
//////////////////////////////////////////////////////////////////
};
diag_log format["MSO-%1 CQB Population: loaded functions...", time];
CQB_functions = true;
