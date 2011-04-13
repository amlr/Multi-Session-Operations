
private ["_debug","_sealandings","_center","_seadest","_destinations","_t","_m"];
if(!isServer) exitWith{};

_debug = true;

waitUntil{!isNil "BIS_fnc_init"};

_sealandings = [];
_seadest = [];
_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

//Find boathouses, piers , fuelling stations on map
_sealandings = ["land_nav_boathouse","land_nav_pier_m_fuel","land_nav_pier_m_end","land_nav_pier_c2_end"]; //"land_nav_pier_c","land_nav_pier_c2","land_nav_pier_m_1","land_nav_pier_m_2",

{
    _seadest = _seadest + (_center nearObjects  [_x, 20000]);
} forEach _sealandings;

// Mark the seaports
if (_debug) then {
    for "_i" from 0 to (count _seadest)-1 do {
        _t = format["seatraffic_d%1", floor(random 10000)];
        _m = [_t, position (_seadest select _i), "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorOrange", "GLOBAL"] call CBA_fnc_createMarker;
        [_m, true] call CBA_fnc_setMarkerPersistent;
    };
};

if (count _seadest < 1) exitWith {
    diag_log format ["MSO-%1 Sea Traffic: Cannot find any sea landing objects. Exiting.", time];
};

if (_debug) then {
    {
        diag_log format ["MSO-%1 Sea Traffic: Sea Landing: %2 - %3", time, TypeOf _x, position _x];
    } foreach _seadest;
};

_destinations = count _seadest;

// Spawn a process for each destination
for "_j" from 0 to (_destinations-1) do {
    
    [_j, _seadest, _debug] spawn {
        private ["_vehicle","_timeout","_sleep","_startpos","_destpos","_grp","_front","_facs","_wp","_j","_spawnpos","_debug","_afactions","_currentFactionCount","_currentFaction","_units","_name","_currentSideCount","_maxSideCount","_factions","_factionsCount","_stopTime","_seadest","_vehiclelist","_seaportside","_seaport","_ship","_shipVehicle","_shipCrew","_currentseadest"];
        _j = _this select 0;
        _seadest = _this select 1;
        _debug = _this select 2;
        
        _currentseadest = _seadest select _j;           
        _timeout = if(_debug) then {[30, 30, 30];} else {[30, 60, 90];};
        _spawnpos = [];
        
        //Loop continuously and create ships for the destination		
        while{true} do {
            
            // Set faction based on units at destinations
            _name = format["Seaport_%1", floor(random 10000)];
            _seaport = createTrigger ["EmptyDetector", position _currentseadest];
            call compile format["%1 = _seaport;", _name];
            _seaport setTriggerActivation ["ANY", "PRESENT", true];
            _seaport setTriggerArea [1500,1500,0,false];
            
            _currentFactionCount = 0;
            _factions = [];
            _factionsCount = [];
            sleep 1;
            _units = list _seaport;
            sleep 1;
            deleteVehicle _seaport;
            
            _seaportside = civilian;
            _currentSideCount = 0;
            _maxSideCount = 0;
            
            if (_debug) then {
                diag_log format ["MSO-%1 Sea Traffic: #%2 has %3 units", time, _j, str(count _units)];
            };
            
            // Work out side that controls destination (based on unit numbers)
            {
                _currentSideCount = _x countSide _units;
                if ((_debug) && (_currentSideCount > 0)) then {
                    diag_log format ["MSO-%1 Sea Traffic: #%2 side %3 has %4 units", time, _j, _x, _currentSideCount];
                };
                If (_currentSideCount > _maxSideCount) then {
                    _seaportside = _x;
                    _maxSideCount = _currentSideCount;
                };
            } foreach [WEST,EAST,resistance];
            
            
            if (_debug) then {
                diag_log format ["MSO-%1 Sea Traffic: #%2 Dominant side %3 has %4 units", time, _j, _seaportside, _maxSideCount];
            };
            
            // Set factions to count
            switch (_seaportside) do {
                case WEST: {_afactions = ["USMC","BIS_US","CDF","BIS_CZ","BIS_GER","BIS_BAF"]}; //
                case EAST: {_afactions = ["RU","INS","BIS_TK","BIS_TK_INS"]};
                case resistance: {_afactions = ["GUE","BIS_UN","PMC_BAF","BIS_TK_GUER"]};
                case civilian: {_afactions = ["BIS_TK_CIV","BIS_CIV_special","CIV", "CIV_RU"]};
            };
            
            // Count factions at destination for dominant side
            {
                _currentFaction = _x;	
                _currentFactionCount = {faction _x == _currentFaction} count _units;
                sleep 0.01;
                //              if ((_debug) && (_currentFactionCount > 0)) then {
                    //                  diag_log format ["MSO-%1 Air Traffic: %5 #%2 has %3 %4 units", time, _j, str(_currentFactionCount), _currentFaction, _destination];
                    //              };
                    // Use the faction count as the bias for selecting aircraft - count factions
                    If (_currentFactionCount > 0) then {
                        _factions = _factions + [_currentFaction];
                        _factionsCount = _factionsCount + [_currentFactionCount];
                    };
                } foreach _afactions;
                
                // If there are no factions then set factions to civilian (default side)
                if (count _factions == 0) then {
                    _factions = _afactions;
                    {
                        _factionsCount = _factionsCount + [1];
                    } forEach _afactions;
                };
                
                if (_debug) then {
                    diag_log format ["MSO-%1 Sea Traffic: #%2 will have this split: %3 , %4", time, _j, _factions, _factionsCount];
                };
                
                // Use the destination's position as the first waypoint
                x = (position _currentseadest select 0) ;
                y = (position _currentseadest select 1) ;
                z = (position _currentseadest select 2) ;
                _startpos = [x,y,z];
                
                // Spawn the ship near the start point
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
                
                // Create ship
                _ship = [];
                _front = "Ship";
                
                _facs = [_factions,_factionsCount] call CRB_fnc_selectRandomBias;
                _vehiclelist =  [0, _facs,_front] call compile preprocessFileLineNumbers "modules\SeaTraffic\fn_findVehicleType2.sqf"; 
                
                // Make sure a suitable vehicle has been found, if not spawn a civilian ship
                if (count _vehiclelist > 0) then {
                    if (_debug) then {
                        diag_log format ["MSO-%1 Sea Traffic: %2 Faction: %4 Vehicle list: %3", time, _j, _vehiclelist, _facs];
                    };
                    _vehicle = (_vehiclelist) call BIS_fnc_selectRandom;
                } else {
                    _facs = ["BIS_TK_CIV","BIS_CIV_special","CIV", "CIV_RU"];
                    _vehicle =  ([0, _facs,_front] call compile preprocessFileLineNumbers "modules\SeaTraffic\fn_findVehicleType2.sqf") call BIS_fnc_selectRandom;                   
                    _seaportside = civilian;
                    if (_debug) then {
                        diag_log format ["MSO-%1 Sea Traffic: %2  Could not find suitable faction/ship, civilian ship found: %3", time, _j, _vehicle];
                    };
                };
                
                if (_debug) then {
                    diag_log format ["MSO-%1 Sea Traffic: %2  Found Ship %3", time, _j, _vehicle];
                };
                
                _ship = [_spawnpos, 0,_vehicle, _seaportside] call BIS_fnc_spawnVehicle;         
                
                _shipVehicle = _ship select 0;
                _shipCrew = _ship select 1;
                _grp = _ship select 2;
                _stoptime = time + 600 + random 300;
                
                sleep 0.01;
                
                diag_log format["MSO-%1 Sea Traffic: #%2, Vehicle: %5 Group: %8 Faction: %6 Start: %3 Landing: %4 Stop: %7", time, _j, _startpos, _destpos, typeOf _shipVehicle, _facs, _stopTime, _grp];
                
                // Set ship waypoints
                _wp = _grp addwaypoint [_startpos, 0];
                _wp setWayPointType "MOVE";
                _wp setWaypointFormation "FILE";
                _wp setWaypointBehaviour "SAFE";
                _wp setWaypointTimeout _timeout;   
                
                _wp = _grp addwaypoint [_destpos, 0];
                _wp setWayPointType "MOVE";
                                          
                _wp = _grp addwaypoint [_startpos, 0];
                _wp setWaypointType "CYCLE";
                _wp setWaypointTimeout _timeout;                                 
                
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