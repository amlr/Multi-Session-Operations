#include <crbprofiler.hpp>
private ["_seadest","_mapsize","_LHD","_dummy","_LHDLand","_group","_logic","_unit","_lhdpos","_center"];

tup_seatraffic_debug = false;

if (isNil "tup_seatraffic_factions") then {tup_seatraffic_factions = 1;};
if (tup_seatraffic_factions == 0) exitWith{};

// Exit if not HC and not a server
if(isnil "tup_seatraffic_locality") then {tup_seatraffic_locality = 0;};
if(
	switch (tup_seatraffic_locality) do {
	        case 0: {!isServer};
        	case 1: {!isHC};
	}
) exitWith{};

if (isNil "tup_seatraffic_amount") then {tup_seatraffic_amount = 0;};
if (isNil "tup_seatraffic_ROE") then {tup_seatraffic_ROE = 2;};
if (isNil "tup_seatraffic_LHD") then {tup_seatraffic_LHD = 2;};

switch(tup_seatraffic_ROE) do {
	case "1": {
		tup_seatraffic_combatMode = "BLUE";
	};
	case "2": {
		tup_seatraffic_combatMode = "GREEN";
	};
	case "3": {
		tup_seatraffic_combatMode = "WHITE";
	};
	case "4": {
		tup_seatraffic_combatMode = "YELLOW";
	};
	case "5": {
		tup_seatraffic_combatMode = "RED";
	};
};

if(isNil "TUP_CIVFACS") then {
	TUP_CIVFACS = [civilian] call mso_core_fnc_getFactions;
};

waitUntil{!isNil "BIS_fnc_init"};

// Calculate size of map
tup_seatraffic_getMapSize = {
	private ["_center","_mapsize"];
	// Get center of map
	_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	// Calculate size of map
	_mapsize = ((_center select 0) max (_center select 1)) * 1.2;
	if (tup_seatraffic_debug) then {
		diag_log format ["MSO-%1 Sea Traffic: Mapsize is %2", time, _mapsize];
		["tup_seatraffic_mapsize", _center, "Rectangle", [_mapsize,_mapsize], "BRUSH:", "Border", "GLOBAL"] call CBA_fnc_createMarker;
	};
	_mapsize;
};

// Find all sea destinations
tup_seatraffic_getSeaDestinations = {
	private ["_sealandings","_mapsize"];
	_mapsize = _this select 0;
	_sealandings = [];
	//Find boathouses, piers , fuelling stations on map. tup_seatraffic_amount = 0 reduced, tup_seatraffic_amount = 1 full
	_sealandings = ["land_nav_boathouse","land_nav_pier_m_end","Land_Nav_Boathouse_PierT","BuoyBig","Land_cwr2_nabrezi_najezd"];
	if (tup_seatraffic_amount == 1) then {
		_sealandings = _sealandings + ["land_nav_pier_m_fuel","land_nav_pier_c2_end","land_nav_pier_c_t15","BuoySmall"];
	};
	[_sealandings, [], _mapsize, tup_seatraffic_debug,"ColorBlack","boat"] call mso_core_fnc_findObjectsByType;
};

_mapsize = call tup_seatraffic_getMapSize;
_seadest = [_mapsize] call tup_seatraffic_getSeaDestinations;
// Check there are some piers and boathouses, if not exit
if (count _seadest < 1) exitWith {
	diag_log format ["MSO-%1 Sea Traffic: Cannot find any sea landing objects. Exiting.", time];
};

////////////////////////
// Randomly place LHD
////////////////////////
if (((random 1 < 0.5) && (tup_seatraffic_LHD == 2)) || (tup_seatraffic_LHD == 1)) then {
	_logic = createCenter sideLogic;
	_group = createGroup _logic;
	// Get center of map
	_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	_lhdpos = [_center, 2000, _mapsize, 500, 2, 0, 0] call BIS_fnc_findSafePos;
	while {_lhdpos distance _center > _mapsize} do {
		_lhdpos = [_center, 2000, _mapsize, 500, 2, 0, 0] call BIS_fnc_findSafePos;
	};
	if(str _lhdpos == str _center) exitWith{};
	_LHD = _group createUnit ["LOGIC",_lhdpos, [], 0, ""];
	_LHD setdir (random 359);
	
	_LHD call bis_ew_fnc_createLHD;
	
	// Add Heli pad and crewman for each LHD 
	_LHDLand = [["Land_LHD_6"], [], _mapsize * 1.4, tup_seatraffic_debug,"ColorGreen","Airport"] call mso_core_fnc_findObjectsByType;
	{
		_dummy = createVehicle ["HeliH", getposASL _x, [], 0, 'NONE'];
		_dummy setDir (direction _x);
		_dummy setPosASL (_x modelToWorld [0,0,18]);
		_unit = (group _LHD) createUnit ["USMC_LHD_Crew_Yellow", getPosASL _x, [], 0, "NONE"];
		_unit setDir (direction _dummy - 180);
		_unit setPosASL (_dummy modelToWorld [0,7,1]);
		doStop _unit;
	} foreach _LHDLand;
	
	if (tup_seatraffic_debug) then {
		diag_log format ["MSO-%1 Sea Traffic: LHD at: %2", time, mapgridposition _LHD];
	};
};

// Spawn a process for each destination
{
	
	[_forEachIndex, _x, _seadest, _mapsize] spawn {
		private ["_timeout","_destpos","_j","_spawnpos","_seadest","_currentseadest","_mapsize","_maxdist","_shipClass","_seaportside","_factions","_ship","_front","_vehiclelist","_shipVehicle","_shipCrew","_grp","_wp","_center","_p1","_p2","_cargoMan","_classManx","_cargo"];
		_j = _this select 0;
		_currentseadest = _this select 1;
		_seadest = _this select 2;
		_mapsize = _this select 3;
		_maxdist = 3000;
		
		_timeout = if(tup_seatraffic_debug) then {[0, 0, 0];} else {[30, 60, 90];};
		_spawnpos = [];
		_destpos = [];
		
		//Loop continuously and create ships for the destination		
		while {true} do {
			// Wait a random amount of time before starting
			waitUntil{
				sleep (30 + random 30);
				{(_x distance _currentseadest < _maxdist)} count ([] call BIS_fnc_listPlayers) > 0
			};
			
			CRBPROFILERSTART("TUP Sea Traffic")
			
			// Spawn the ship near dest on water
			_spawnpos = [position _currentseadest, 200, _maxdist, 10, 2, 0, 0] call BIS_fnc_findSafePos;
			
			// Define a random sea port
			_destpos = [position (_seadest call BIS_fnc_selectRandom), 200, 1000, 10, 2, 0, 0] call BIS_fnc_findSafePos;
			if (str _destpos == "[0,0,0]" || random 1 > 0.75) then {
				_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
				// Define a random place at the edge of the map to fly to
				_destpos = [_center, _mapsize-10, _mapsize, 10, 2, 0, 0] call BIS_fnc_findSafePos;
			};
			
			// Mark the spawn point
			if (tup_seatraffic_debug) then {
				private["_t","_m"];
				_t = format["SeaTraffic_s%1", _j];
				_m = [_t, _spawnpos, "Icon", [0.5,0.5], "TYPE:", "hd_start", "GLOBAL"] call CBA_fnc_createMarker;
				
				_t = format["SeaTraffic_d%1", _j];
				_m = [_t, _destpos, "Icon", [0.5,0.5], "TYPE:", "hd_end", "GLOBAL"] call CBA_fnc_createMarker;
				//diag_log format ["MSO-%1 Sea Traffic: #%2 Moving from %3 to %4", time, _j, _spawnpos, _destpos];
			};
			
			// Create ship
			// Work out side that controls destination (based on unit numbers)
			_seaportside = [_currentseadest, 1000, format["%1 %2",_currentseadest,_j],tup_seatraffic_debug] call mso_core_fnc_getDominantSide;
			// Get the factions for the controlling side and count their units
			if (tup_seatraffic_factions == 1) then {
			};
			// Work out side that controls destination (based on unit numbers)
			switch(tup_seatraffic_factions) do {
				case 1: {
					_factions = TUP_CIVFACS;
					_seaportside = civilian;
				};
				case 2: {
					_factions = ([_seaportside, _currentseadest, 1000,"factions",tup_seatraffic_debug,format["Seaport %2",_j]] call mso_core_fnc_getFactions) - TUP_CIVFACS;
				};
				case 3: {
					_factions = [_seaportside, _currentseadest, 1000,"factions",tup_seatraffic_debug,format["Seaport %2",_j]] call mso_core_fnc_getFactions;
				};
			};

			_ship = [];
			_front = "Ship";
			
			_vehiclelist = [0, _factions,_front] call mso_core_fnc_findVehicleType; 
			_shipClass = "";
			
			// Make sure a suitable vehicle has been found, if not spawn a civilian ship
			if (count _vehiclelist > 0) then {
				if (tup_seatraffic_debug) then {
					diag_log format ["MSO-%1 Sea Traffic: %2 Faction: %4 Vehicle list: %3", time, _j, _vehiclelist, _factions];
				};
				_shipClass = (_vehiclelist) call BIS_fnc_selectRandom;
			} else {
				_shipClass = ([0, TUP_CIVFACS,_front] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;
				_seaportside = civilian;
				if (tup_seatraffic_debug) then {
					diag_log format ["MSO-%1 Sea Traffic: %2 Could not find suitable faction/ship, civilian ship found: %3", time, _j, _shipClass];
				};
			};
			
			_ship = [_spawnpos, 0,_shipClass, _seaportside] call BIS_fnc_spawnVehicle;
			_shipVehicle = _ship select 0;
			_shipCrew = _ship select 1;
			{_x setSkill 0.1} forEach _shipCrew;
			_grp = _ship select 2;

			_shipVehicle lock true;

			_classManx = [_seaportside, configFile >> "CfgVehicles" >> _shipClass] call BIS_fnc_selectCrew;
			_cargo = getNumber(configFile >> "CfgVehicles" >> _shipClass >> "transportSoldier");
			for "_i" from 1 to floor(random _cargo) do {
				_cargoMan = _grp createunit [_classManx,position _shipVehicle,[],0,"none"];
				_cargoMan setSkill 0;
				{_cargoMan disableAI _x} count ["AUTOTARGET","TARGET"];

				_cargoMan assignascargo _shipVehicle;
				_cargoMan moveincargo _shipVehicle;
			};
			
			if (tup_seatraffic_debug) then {
				diag_log format["MSO-%1 Sea Traffic: #%2, Vehicle: %5 Group: %7 Faction: %6 Start: %3 Landing: %4", time, _j, _spawnpos, _destpos, typeOf _shipVehicle, _factions, _grp];
			};
			
			// Set ship waypoints
			if(random 1 > 0.5) then {
				_p1 = _currentseadest;
				_p2 = _destpos;
			} else {
				_p1 = _destpos;

				_p2 = _currentseadest;
			};
			
			_wp = _grp addwaypoint [_p1, 0];
			_wp setWayPointType "MOVE";
			_wp setWaypointSpeed (["LIMITED", "NORMAL", "FULL"] call BIS_fnc_selectRandom);
			_wp setWaypointFormation "FILE";
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointCombatMode tup_seatraffic_combatMode;
			_wp setWaypointTimeout _timeout; 
			
			_wp = _grp addwaypoint [_p2, 0];
			_wp setWayPointType "MOVE";
			_wp setWaypointTimeout _timeout;
			
			_wp = _grp addwaypoint [_spawnpos, 0];
			_wp setWayPointType "MOVE";
			_wp setWaypointTimeout _timeout;
			
			_wp = _grp addwaypoint [_spawnpos, 0];
			_wp setWaypointType "CYCLE";
			
			CRBPROFILERSTOP
			
			// if all players are 1.2 * maxdist away from seadest or vehicle, delete and restart
			waitUntil{
				sleep 60; 
				{(_x distance _shipVehicle < _maxdist * 1.2)} count ([] call BIS_fnc_listPlayers) == 0 ||
				(damage _shipVehicle > 0.3) ||
				!(_grp call CBA_fnc_isAlive)
			};
			
			// Remove ship and crew
			if (tup_seatraffic_debug) then {
				private["_t","_m"];
				diag_log format["MSO-%1 Sea Traffic: %3 deleting %2", time, TypeOf _shipVehicle, _j];
				_t = format["SeaTraffic_s%1", _j];
				deleteMarker _t;
				_t = format["SeaTraffic_d%1", _j];
				deleteMarker _t;
			};
			{ deleteVehicle _x } forEach units _grp;
			deleteVehicle _shipVehicle;
			deletegroup _grp;
			// Pause before creating another aircraft for destination
			_sleep = if(tup_seatraffic_debug) then {10;} else {random 300;};
			sleep _sleep;
		};
	};
} forEach _seadest;
