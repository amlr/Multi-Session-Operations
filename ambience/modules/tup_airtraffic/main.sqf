if(!isServer) exitWith{};
private ["_debug","_endpoints","_helidest","_planedest","_destinations","_destairfield","_helilandings"];
_debug = true;

// CRB_convertHelipads
//[] spawn {
// (nearestObjects [player,[], 10]) - ((getPos player) nearObjects 10)
        private ["_new","_obj"];
        CRB_HELIPADS_INIT = false;
        for "_i" from 0 to 400000 do {
                _obj = (position player) nearestObject _i;
                if(isNil "_obj") exitWith{};
                switch (str _obj) do {
                        case (str _i + ": heli_h.p3d"): {     
                                _new = createVehicle ["HeliH", position _obj, [],0,'NONE'];     
                                _new setDir (direction _obj);
                        };    
                        case (str _i + ": heli_h_army.p3d"): {     
                                _new = createVehicle ["HeliH", position _obj, [],0,'NONE'];     
                                _new setDir (direction _obj);    
                        };    
                        case (str _i + ": heli_h_rescue.p3d"): {     
                                _new = createVehicle ["HeliHRescue", position _obj, [],0,'NONE'];     
                                _new setDir (direction _obj);    
                        };    
                        case (str _i + ": heli_h_civil.p3d"): {     
                                _new = createVehicle ["HeliHCivil", position _obj, [],0,'NONE'];     
                                _new setDir (direction _obj);    
                        }; 
                }; 
        };
        CRB_HELIPADS_INIT = true;
//};
/*
// This may not work on some islands as center is bottom left
_endpoints = [
        [0,10000,1000],
        [10000,10000,1000],
        [10000,0,1000],
        [0,0,1000]
]; // corners of maps for aircraft to fly away to
_destairfield = [];
_helilandings = [];
_helidest = [];
_planedest = [];

waitUntil{!isNil "BIS_fnc_init"};

if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

TUP_findAirports = {
        _airports = ["Airport"];        
        // Define airports-hangars-Helipads from the Map
        {
                private["_t","_m"];
                if (type _x in _airports) then {
                        _destairfield = _destairfield + [_x];
                        // Mark the airports
                        if (_debug) then {
                                _t = format["airtraffic_d%1", floor(random 10000)];
                                _m = [_t, position _x, "Icon", [1,1], "TYPE:", "Airport", "TEXT:", _t, "COLOR:", "ColorOrange", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                        };
                };
        } forEach CRB_LOCS;
};

TUP_findHangars = {
        //Find hangars at airports
        _planelandings = ["Land_Hangar_2","Land_SS_hangar","Land_SS_hangarD","Land_Mil_hangar_EP1"];
        {
                _planedest = _planedest + nearestObjects [position _x, _planelandings, 1500];
        } forEach _destairfield;
        
        if (_debug) then {
                {
                        [str _x, position _x, "Icon", [0.5,0.5], "TYPE:", "Airport", "COLOR:", "ColorOrange", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                        diag_log format ["MSO-%1 Air Traffic: Hangar: %2 - %3", time, TypeOf _x, position _x];
                } foreach _planedest;
        };
};

TUP_findHelipads = {
        // Find helipads on the map
        _helilandings = ["HeliH","HeliHRescue","HeliHCivil"];
        _center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
        _helidest = _helidest + nearestObjects [_center, _helilandings, 100000];
        
        if (_debug) then {
                {
                        [str _x, position _x, "Icon", [0.5,0.5], "TYPE:", "Heliport", "COLOR:", "ColorOrange", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
                        diag_log format ["MSO-%1 Air Traffic: Helipad: %2 - %3", time, TypeOf _x, position _x];
                } foreach _helidest;
        };
};

_destinations = count _planedest + count _helidest;

// Spawn a process for each destination (each hangar and each helipad)
for "_j" from 0 to (_destinations-1) do {
        
        [_j, _helidest, _planedest, _debug, _endpoints] spawn {
                private ["_vehicle","_destination","_aircraftVehicle","_aircraftCrew","_timeout","_sleep","_startpos","_destpos","_endpos","_grp","_front","_facs","_wp","_j","_spawnpos","_debug","_afactions","_endpoints","_airfield","_currentairfield","_currentFactionCount","_currentFaction","_units","_name","_currentSideCount","_maxSideCount","_airfieldSide","_factions","_factionsCount","_stopTime","_landEnd","_planedest","_helidest","_isPlane","_aircraft","_vehiclelist"];
                _j = _this select 0;
                _helidest = _this select 1;
                _planedest = _this select 2;
                _debug = _this select 3;
                _endpoints = _this select 4;
                _isPlane = false;
                
                // Work out if current destination is for a plane or helicopter
                if (_j < count _planedest) then {
                        _currentairfield = _planedest select _j;
                        _isPlane = true;
                } else {
                        _currentairfield = _helidest select (_j - count _planedest);
                        _isPlane = false;
                };
                
                _timeout = if(_debug) then {[30, 30, 30];} else {[30, 60, 90];};
                
                //Loop continuously and create aircraft for the destination		
                while{true} do {
                        // Create a random spawn point near the airport
                        x = (position _currentairfield select 0) + 2000 - (random 4000);
                        y = (position _currentairfield select 1) + 2000 - (random 4000);
                        z = (position _currentairfield select 2) + 500 + (random 200);
                        _spawnpos = [x,y,z];
                        // Mark the spawn points
                        if (_debug) then {
                                private["_t","_m"];
                                _t = format["AirTraffic_s%1", floor(random 10000)];
                                _m = [_t, _spawnpos, "Icon", [1,1], "TYPE:", "mil_triangle", "GLOBAL"] call CBA_fnc_createMarker;
                                [_m, true] call CBA_fnc_setMarkerPersistent;
                        };
                        
                        // Create a safe startpoint
                        _startpos = [_spawnpos, 0, 0, 0, 1, 0, 0] call BIS_fnc_findSafePos;
                        
                        // Set a safe destination point at airfield
                        
                        If (!_isPlane) then {
                                //                                _destpos = [position _currentairfield, 0, 20, 10, 0, 0, 0] call BIS_fnc_findSafePos;
                                _destpos = position _currentairfield;
                                _destination = "HeliPad";
                        } else {
                                _destpos = position _currentairfield;
                                _destination = "Hangar";
                        };
                        
                        if (_debug) then {
                                diag_log format ["MSO-%1 Air Traffic: %4 #%2 Landing point at: %3", time, _j, _destpos, _destination];
                        };
                        
                        if (_debug) then {
                                private["_t","_m"];
                                _t = format["AirTraffic_s%1", floor(random 10000)];
                                _m = [_t, _destpos, "Icon", [1,1], "TYPE:", "mil_pickup", "GLOBAL"] call CBA_fnc_createMarker;								
                                [_m, true] call CBA_fnc_setMarkerPersistent;
                        };
                        
                        // Define a corner of the map to fly away to as the end point
                        _endpos = _endpoints call BIS_fnc_selectRandom;
                        //                        _endpos = [_endpos, 0, 0, 0, 1, 0, 0] call BIS_fnc_findSafePos;
                        
                        // Set faction based on units at destinations
                        _name = format["Airport_%1", floor(random 10000)];
                        _airfield = createTrigger ["EmptyDetector", position _currentairfield];
                        call compile format["%1 = _airfield;", _name];
                        _airfield setTriggerActivation ["ANY", "PRESENT", true];
                        _airfield setTriggerArea [1000,1000,0,false];
                        
                        _currentFactionCount = 0;
                        _factions = [];
                        _factionsCount = [];
                        sleep 1;
                        _units = list _airfield;
                        sleep 1;
                        deleteVehicle _airfield;
                        
                        _airfieldside = civilian;
                        _currentSideCount = 0;
                        _maxSideCount = 0;
                        
                        if (_debug) then {
                                diag_log format ["MSO-%1 Air Traffic: %4 #%2 has %3 units", time, _j, str(count _units), _destination];
                        };
                        
                        // Work out side that controls destination (based on unit numbers)
                        {
                                _currentSideCount = _x countSide _units;
                                if ((_debug) && (_currentSideCount > 0)) then {
                                        diag_log format ["MSO-%1 Air Traffic: %5 #%2 side %3 has %4 units", time, _j, _x, _currentSideCount, _destination];
                                };
                                If (_currentSideCount > _maxSideCount) then {
                                        _airfieldside = _x;
                                        _maxSideCount = _currentSideCount;
                                };
                        } foreach [WEST,EAST,resistance];
                        
                        
                        if (_debug) then {
                                diag_log format ["MSO-%1 Air Traffic: %5 #%2 Dominant side %3 has %4 units", time, _j, _airfieldside, _maxSideCount, _destination];
                        };
                        
                        // Set factions to count
                        switch (_airfieldside) do {
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
                                        diag_log format ["MSO-%1 Air Traffic: %5 #%2 will have this split: %3 , %4", time, _j, _factions, _factionsCount, _destination];
                                };
                                
                                // Create aircraft 
                                _aircraft = [];
                                _front = "";
                                
                                if (_isPlane) then {
                                        _front = "Plane";
                                } else {
                                        _front = "Helicopter";
                                };
                                
                                _facs = [_factions,_factionsCount] call CRB_fnc_selectRandomBias;
                                _vehiclelist =  [0, _facs,_front] call mso_ambience_fnc_findVehicleType; 
                                //                _vehiclelist =  [0, _facs,_front] call CRB_fnc_findVehicleType; 
                                
                                if (count _vehiclelist > 0) then {
                                        if (_debug) then {
                                                diag_log format ["MSO-%1 Air Traffic: %4 %2 Faction: %5 Vehicle list: %3", time, _j, _vehiclelist, _destination, _facs];
                                        };
                                        _vehicle = (_vehiclelist) call BIS_fnc_selectRandom;
                                } else {
                                        _facs = ["BIS_TK_CIV","BIS_CIV_special","CIV", "CIV_RU"];
                                        _vehicle =  ([0, _facs,_front] call mso_ambience_fnc_findVehicleType) call BIS_fnc_selectRandom;
                                        //			_vehicle =  ([0, _facs,_front] call CRB_fnc_findVehicleType) call BIS_fnc_selectRandom;
                                        
                                        _airfieldside = civilian;
                                        if (_debug) then {
                                                diag_log format ["MSO-%1 Air Traffic: %4 %2  Could not find suitable military aircraft, civilian aircraft found: %3", time, _j, _vehicle, _destination];
                                        };
                                };
                                
                                if (_debug) then {
                                        diag_log format ["MSO-%1 Air Traffic: %4 %2  Found Aircraft %3", time, _j, _vehicle, _destination];
                                };
                                
                                _aircraft = [[_startpos, 10] call CBA_fnc_randPos, 0,_vehicle, _airfieldside] call BIS_fnc_spawnVehicle;         
                                
                                _aircraftVehicle = _aircraft select 0;
                                _aircraftCrew = _aircraft select 1;
                                _grp = _aircraft select 2;
                                _stoptime = time + 300 + random 300;
                                
                                sleep 0.01;
                                
                                diag_log format["MSO-%1 Air Traffic: %10 #%2, Vehicle: %6 Group: %9 Faction: %7 Start: %3 Landing: %4 End: %5 Stop: %8", time, _j, _startpos, _destpos, _endpos, typeOf _aircraftVehicle, _facs, _stopTime, _grp, _destination];
                                
                                // Set aircraft waypoints
                                _wp = _grp addwaypoint [_startpos, 0];
                                _wp setWayPointType "MOVE";
                                _wp setWaypointFormation "FILE";
                                _wp setWaypointBehaviour "SAFE";
                                _wp setWaypointCombatMode "BLUE";
                                
                                _wp = _grp addwaypoint [_destpos, 0];
                                _wp setWayPointType "MOVE";
                                
                                waitUntil{(_aircraftVehicle distance _destpos < 500) || (time > _stopTime) || !(_grp call CBA_fnc_isAlive)};
                                
                                _landEnd = "HeliHEmpty" createVehicle _destpos;
                                if (_aircraftVehicle iskindof "Helicopter") then {
                                        _aircraftVehicle land "LAND";
                                        waitUntil{((position _aircraftVehicle) select 2 <= 5) || (time > _stopTime) || !(_grp call CBA_fnc_isAlive)};
                                } else {
                                        _aircraftVehicle action ["Land", _aircraftVehicle];
                                        waitUntil{(_aircraftVehicle distance _destpos < 30)  && ((position _aircraftVehicle) select 2 <= 2) || (time > _stopTime)  || !(_grp call CBA_fnc_isAlive) };
                                };			
                                
                                If ((TypeOf _aircraftVehicle) == "MV22") then {
                                        _wp = _grp addwaypoint [_destpos, 0];
                                        _wp setWayPointType "MOVE";
                                        waitUntil{(_aircraftVehicle distance _destpos < 5)  && ((position _aircraftVehicle) select 2 <= 2) || (time > _stopTime)  || !(_grp call CBA_fnc_isAlive) };
                                };
                                
                                _aircraftVehicle engineOn false;
                                
                                deleteVehicle _landEnd;
                                
                                sleep (_timeout select (random 2));
                                
                                _wp = _grp addwaypoint [_endpos, 0];
                                _wp setWaypointType "MOVE";
                                _wp setWaypointTimeout _timeout;                                 
                                
                                waitUntil{ (time > _stopTime) || !(_grp call CBA_fnc_isAlive)};
                                
                                // Remove aircraft and crew
                                
                                if (_debug) then {
                                        diag_log format["MSO-%1 Air Traffic: %3 %4 deleting %2", time, TypeOf _aircraftVehicle, _destination, _j];
                                };
                                
                                { deleteVehicle _x } forEach _aircraftCrew;
                                deleteVehicle _aircraftVehicle;
                                deletegroup _grp;
                                
                                _sleep = if(_debug) then {10;} else {random 300;};
                                sleep _sleep;
                        };
                };
        };
        */