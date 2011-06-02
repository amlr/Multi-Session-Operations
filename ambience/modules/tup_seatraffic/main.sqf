#include <crbprofiler.hpp>

private ["_debug","_sealandings","_center","_seadest","_destinations","_mapsize"];
if(!isServer) exitWith{};

if (isNil "amount") then {amount = 1;};
if (amount == 2) exitWith{};

if(isNil "SeaROE")then{SeaROE = 1;};

_debug = false;

waitUntil{!isNil "BIS_fnc_init"};
// Get center of map
_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

// Calculate size of map
_mapsize = ((_center select 0) * 2);
if (_debug) then 
{
        diag_log format ["MSO-%1 Sea Traffic: Mapsize is %2", time, _mapsize];
};

_sealandings = [];
_seadest = [];

//Find boathouses, piers , fuelling stations on map. Amount = 1 reduced, amount = 0 full
if (amount == 1) then {
        _sealandings = ["land_nav_boathouse","land_nav_pier_m_fuel","land_nav_pier_m_end","land_nav_pier_c2_end"];
} else {
        _sealandings = ["land_nav_boathouse","land_nav_pier_m_fuel","land_nav_pier_m_end","land_nav_pier_c2_end","land_nav_pier_c","land_nav_pier_c2","land_nav_pier_m_1","land_nav_pier_m_2"];
};
_seadest = [_sealandings, [], _mapsize, _debug,"ColorBlack","heliport"] call mso_core_fnc_findObjectsByType;

// Check there are some piers and boathouses, if not exit
if (count _seadest < 1) exitWith {
        diag_log format ["MSO-%1 Sea Traffic: Cannot find any sea landing objects. Exiting.", time];
};

_destinations = count _seadest;

if(isNil "TUP_CIVFACS") then {
        TUP_CIVFACS = [civilian] call mso_core_fnc_getFactions;
};

// Spawn a process for each destination
for "_j" from 0 to (_destinations-1) do {
        
        [_j, _seadest, _mapsize, _debug] spawn {
                private ["_timeout","_sleep","_startpos","_destpos","_grp","_front","_wp","_j","_spawnpos","_debug","_factions","_stopTime","_seadest","_vehiclelist","_seaportside","_ship","_shipVehicle","_shipCrew","_currentseadest","_endpos","_mapsize","_shipClass","_combatMode"];
                _j = _this select 0;
                _seadest = _this select 1;
                _mapsize = _this select 2;
                _debug = _this select 3;
                
                _currentseadest = _seadest select _j;           
                _timeout = if(_debug) then {[0, 0, 0];} else {[30, 60, 90];};
                _spawnpos = [];
				
				switch(SeaROE) do {
						case "1": {
								_combatMode = "BLUE";
						};
						case "2": {
								_combatMode = "GREEN";
						};
						case "3": {
								_combatMode = "WHITE";
						};
						case "4": {
								_combatMode = "YELLOW";
						};
						case "5": {
								_combatMode = "RED";
						};
				};
                
                //Loop continuously and create ships for the destination		
                while{true} do {
                        CRBPROFILERSTART("TUP Sea Traffic")
                        
                        // Work out side that controls destination (based on unit numbers)
                        _seaportside =  [_currentseadest, 1000, format["%1 %2",_currentseadest,_j],_debug] call mso_core_fnc_getDominantSide;
                        
                        // Get the factions for the controlling side and count their units
                        _factions = [_seaportside, _currentseadest, 1000,"factions",_debug,format["Seaport %2",_j]] call mso_core_fnc_getFactions;
                        //_factionsCount = [_seaportside, _currentseadest, 1000,"count",_debug,format["Seaport %2",_j]] call mso_core_fnc_getFactions;
                        
                        // Use the destination's position as the first waypoint
                        x = (position _currentseadest select 0) ;
                        y = (position _currentseadest select 1) ;
                        z = (position _currentseadest select 2) ;
                        _startpos = [x,y,z];
                        
                        // Spawn the ship near dest on water
                        _spawnpos = [_startpos, 200, 1000, 10, 2, 0, 0] call BIS_fnc_findSafePos;
                        
                        // Mark the spawn point
                        if (_debug) then {
                                private["_t","_m"];
                                _t = format["SeaTraffic_s%1", floor(random 10000)];
                                _m = [_t, _spawnpos, "Icon", [1,1], "TYPE:", "mil_dot", "GLOBAL"] call CBA_fnc_createMarker;
                                [_m, true] call CBA_fnc_setMarkerPersistent;
                        };
                        
                        // Set a safe destination for the 2nd waypoint (make it another sea port)
                        _destpos = [position (_seadest call BIS_fnc_selectRandom), 15, 50, 10, 2, 0, 0] call BIS_fnc_findSafePos;
                        
                        if (_debug) then {
                                diag_log format ["MSO-%1 Sea Traffic: #%2 Landing point at: %3", time, _j, _destpos];
                        };
                        
                        if (_debug) then {
                                private["_t","_m"];
                                _t = format["SeaTraffic_s%1", floor(random 10000)];
                                _m = [_t, _destpos, "Icon", [1,1], "TYPE:", "hd_pickup", "GLOBAL"] call CBA_fnc_createMarker;								
                                [_m, true] call CBA_fnc_setMarkerPersistent;
                        };
                        // Define a random place at the edge of the map to fly to
                        _endpos = [_startpos, _mapsize-10, _mapsize, 10, 2, 0, 0] call BIS_fnc_findSafePos;
                        
                        // Create ship
                        _ship = [];
                        _front = "Ship";
                        
                        //_facs = [_factions,_factionsCount] call CRB_fnc_selectRandomBias;
                        _vehiclelist =  [0, _factions,_front] call mso_core_fnc_findVehicleType; 
                        _shipClass = "";
                        
                        // Make sure a suitable vehicle has been found, if not spawn a civilian ship
                        if (count _vehiclelist > 0) then {
                                if (_debug) then {
                                        diag_log format ["MSO-%1 Sea Traffic: %2 Faction: %4 Vehicle list: %3", time, _j, _vehiclelist, _factions];
                                };
                                _shipClass = (_vehiclelist) call BIS_fnc_selectRandom;
                        } else {
                                _shipClass =  ([0, TUP_CIVFACS,_front] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;                   
                                _seaportside = civilian;
                                if (_debug) then {
                                        diag_log format ["MSO-%1 Sea Traffic: %2  Could not find suitable faction/ship, civilian ship found: %3", time, _j, _shipClass];
                                };
                        };
                        
                        if (_debug) then {
                                diag_log format ["MSO-%1 Sea Traffic: %2  Found Ship %3", time, _j, _shipClass];
                        };
                        
                        _ship = [_spawnpos, 0,_shipClass, _seaportside] call BIS_fnc_spawnVehicle;         
                        
                        _shipVehicle = _ship select 0;
                        _shipCrew = _ship select 1;
                        _grp = _ship select 2;
                        _stoptime = time + 600 + random 300;
                        
                        if (_debug) then {
                                diag_log format["MSO-%1 Sea Traffic: #%2, Vehicle: %5 Group: %8 Faction: %6 Start: %3 Landing: %4 Stop: %7", time, _j, _startpos, _destpos, typeOf _shipVehicle, _factions, _stopTime, _grp];
                        };
                        
                        // Set ship waypoints
                        _wp = _grp addwaypoint [_destpos, 0];
                        _wp setWayPointType "MOVE";
                        _wp setWaypointFormation "FILE";
                        _wp setWaypointBehaviour "SAFE";
						_wp setWaypointBehaviour _combatMode;
                        _wp setWaypointTimeout _timeout;   
                        
                        _wp = _grp addwaypoint [_endpos, 0];
                        _wp setWayPointType "MOVE";
                        _wp setWaypointTimeout _timeout;   
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWayPointType "MOVE";
                        _wp setWaypointTimeout _timeout;                                 
                        
                        _wp = _grp addwaypoint [_startpos, 0];
                        _wp setWaypointType "CYCLE";
                        
                        CRBPROFILERSTOP
                        
                        waitUntil{ (time > _stopTime)};
                        
                        // Remove ship and crew
                        
                        if (_debug) then {
                                diag_log format["MSO-%1 Sea Traffic: %3 deleting %2", time, TypeOf _shipVehicle, _j];
                        };
                        
                        { deleteVehicle _x } forEach _shipCrew;
                        deleteVehicle _shipVehicle;
                        deletegroup _grp;
                        
                        _sleep = if(_debug) then {10;} else {random 300;};
                        sleep _sleep;
                };
        };
};