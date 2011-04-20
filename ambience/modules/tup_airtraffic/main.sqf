private ["_debug","_mapsize","_helidest","_planedest","_destinations","_destairfield","_helilandings","_center","_airports","_planelandings"];
if(!isServer) exitWith{};
if (isNil "factionsMask") then {factionsMask = 1;};
if (factionsMask == 2) exitWith{};
_debug = true;

switch toLower(worldName) do {		
	case "zargabad": {
		{
			private["_new"];
			_new = createVehicle ["HeliHEmpty", (_x select 0), [],0,'NONE'];     
			_new setDir (_x select 1);
		} forEach [
			[[3534.1, 3939.4], 270],
			[[4568,4124], 110]
		];
	};
};

// CRB_convertHelipads
/*[] spawn 
{
        //(nearestObjects [player,[], 10]) - ((getPos player) nearObjects 10)
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
};*/

// Get center of map
_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");

// Calculate size of map
_mapsize = ((_center select 0) * 2);
if (_debug) then 
{
        diag_log format ["MSO-%1 Air Traffic: Mapsize is %2", time, _mapsize];
};

_destairfield = [];
_helilandings = [];
_helidest = [];
_planedest = [];

waitUntil{!isNil "BIS_fnc_init"};

// Define airports-hangars-Helipads from the Map
// Find airport locations
_airports = ["Airport"];  
_destairfield = [_airports,_debug,"ColorGreen","airport"] call mso_core_fnc_findLocationsByType;

//Find hangars at airport locations
_planelandings = ["Land_Hangar_2","Land_SS_hangar","Land_SS_hangarD","Land_Mil_hangar_EP1"];
_planedest = [_planelandings, _destairfield, 1500,_debug,"ColorGreen","Airport"] call mso_core_fnc_findObjectsByType;

// Find helipads on the map
_helilandings = ["HeliH","HeliHRescue","HeliHCivil"];
_helidest = [_helilandings, [], _mapsize, _debug,"ColorBlack","heliport"] call mso_core_fnc_findObjectsByType;

// Total number of landing points - hangars and helipads
_destinations = count _planedest + count _helidest;

// Spawn a process for each destination (each hangar and each helipad)
for "_j" from 0 to (_destinations-1) do 
{
        
        [_j, _helidest, _planedest, _debug, _mapsize] spawn 
        {
                private ["_vehicle","_destination","_aircraftVehicle","_aircraftCrew","_timeout","_sleep","_startpos","_destpos","_endpos","_grp","_front","_facs","_wp","_j","_debug","_mapsize","_currentairfield","_airfieldSide","_factions","_factionsCount","_stopTime","_landEnd","_planedest","_helidest","_isPlane","_aircraft","_vehiclelist","_startHeight","_controltowers","_controlTowerTypes","_controltw","_housepos","_scrambleTime"];
                _j = _this select 0;
                _helidest = _this select 1;
                _planedest = _this select 2;
                _debug = _this select 3;
                _mapsize = _this select 4;
                
                _isPlane = false;
                _startHeight = 500 + (random 200);
                
                // Work out if current destination is for a plane or helicopter
                if (_j < count _planedest) then 
                {
                        _currentairfield = _planedest select _j;
                        _isPlane = true;
                } else {
                        _currentairfield = _helidest select (_j - count _planedest);
                        _isPlane = false;
                };
                
                // Set timeout for waypoints
                _timeout = if(_debug) then {[30, 30, 30];} else {[30, 60, 90];};
                
                //Loop continuously and create aircraft for the destination		
                while{true} do 
                {
                        // Wait a random amount of time before starting
                        sleep (random 90);
                        
                        //Create a random spawn point along the edge of the map				
                        _startpos = [_mapsize,_startHeight,_debug,str _j,"ColorBlack","Dot"] call mso_core_fnc_randomEdgePos;    
                        
                        // Set a safe destination point at airfield and destination type for debugging.
                        If (!_isPlane) then 
                        {
                                //  _destpos = [position _currentairfield, 0, 20, 10, 0, 0, 0] call BIS_fnc_findSafePos;
                                _destpos = position _currentairfield;
                                _destination = "HeliPad";
                        } else {
                                _destpos = position _currentairfield;
                                _destination = "Hangar";
                        };
                        
                        // Define a random place at the edge of the map to fly to
                        _endpos = [_mapsize,_startheight,_debug, str _j,"ColorRed","Dot"] call mso_core_fnc_randomEdgePos;
                        
						// If we are counting all factions then work out controlling side, otherwise default to civilian
						if (factionsMask == 0) then 
						{
							// Work out side that controls destination (based on unit numbers)
							_airfieldside =  [_currentairfield, 1000, format["%1 %2",_destination,_j],_debug] call mso_core_fnc_getDominantSide;
						} else {
							//Set default side to civilian 
							_airfieldside = civilian;
						};
                        
						// Get the factions for the controlling side and count their units
						_factions = [_airfieldside, _currentairfield, 1000,"factions",_debug,format["%1 %2",_destination,_j]] call mso_core_fnc_getFactions;
						_factionsCount = [_airfieldside, _currentairfield, 1000,"count",_debug,format["%1 %2",_destination,_j]] call mso_core_fnc_getFactions;
						
						// Mark Destination on Map
												if (_debug) then 						{								private["_t","_m"];								_t = format["AirTraffic_s%1", floor(random 10000)];								_m = [_t, _destpos, "Icon", [1,1], "TYPE:", "Dot", "TEXT:", str _j, "COLOR:", "ColorBlack", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;							
						};						
						// Create aircraft 
						_aircraft = [];
						_front = "";
						
						// Check to see if we need a plane or helicopter
						if (_isPlane) then 
						{
								_front = "Plane";
						} else {
								_front = "Helicopter";
						};
						
						// Select the faction based on unit count bias and get a list of possible vehicles
						_facs = [_factions,_factionsCount] call mso_core_fnc_selectRandomBias;
						_vehiclelist =  [0, _facs,_front] call mso_core_fnc_findVehicleType; 
						
						// Select a vehicle from the list - if no valid vehicle selet a civilian aircraft
						if (count _vehiclelist > 0) then 
						{
								if (_debug) then 
								{
										diag_log format ["MSO-%1 Air Traffic: %4 %2 Faction: %5 Vehicle list: %3", time, _j, _vehiclelist, _destination, _facs];
								};
								_vehicle = (_vehiclelist) call BIS_fnc_selectRandom;
						} else {
								_facs = ["BIS_TK_CIV","BIS_CIV_special","CIV", "CIV_RU"];
								_vehicle =  ([0, _facs,_front] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;
								
								_airfieldside = civilian;
								if (_debug) then 
								{
										diag_log format ["MSO-%1 Air Traffic: %4 %2  Could not find suitable military aircraft, civilian aircraft found: %3", time, _j, _vehicle, _destination];
								};
						};
						
						if (_debug) then 
						{
								diag_log format ["MSO-%1 Air Traffic: %4 %2  Found Aircraft %3", time, _j, _vehicle, _destination];
						};
						
						// Create aircraft
						_aircraft = [[_startpos, 10] call CBA_fnc_randPos, 0,_vehicle, _airfieldside] call BIS_fnc_spawnVehicle;         
						_aircraftVehicle = _aircraft select 0;
						_aircraftCrew = _aircraft select 1;
						_grp = _aircraft select 2;
						_stoptime = time + 300 + random 600;
						sleep 0.01;						
						diag_log format["MSO-%1 Air Traffic: %10 #%2, Vehicle: %6 Group: %9 Faction: %7 Start: %3 Landing: %4 End: %5 Stop: %8", time, _j, _startpos, _destpos, _endpos, typeOf _aircraftVehicle, _facs, _stopTime, _grp, _destination];
						
						// Set aircraft waypoints
						
						// Starting waypoint
						_wp = _grp addwaypoint [_startpos, 0];
						_wp setWayPointType "MOVE";
						_wp setWaypointFormation "FILE";
						_wp setWaypointBehaviour "SAFE";
						_wp setWaypointCombatMode "BLUE";
						
						// Destination Waypoint
						_wp = _grp addwaypoint [_destpos, 0];
						_wp setWayPointType "MOVE";
						// Wait until the aircraft is close to the airfield
						waitUntil{(_aircraftVehicle distance _destpos < 500) || (time > _stopTime) || !(_grp call CBA_fnc_isAlive)};
						// Once near destination, action a landing.
						_landEnd = "HeliHEmpty" createVehicle _destpos;
						if (_aircraftVehicle iskindof "Helicopter") then 
						{
								_aircraftVehicle land "LAND";
								waitUntil{((position _aircraftVehicle) select 2 <= 5) || (time > _stopTime) || !(_grp call CBA_fnc_isAlive)};
						} else {
								_aircraftVehicle action ["Land", _aircraftVehicle];
								waitUntil{(_aircraftVehicle distance _destpos < 5)  && ((position _aircraftVehicle) select 2 <= 2) || (time > _stopTime)  || !(_grp call CBA_fnc_isAlive) };
						};			
						deleteVehicle _landEnd;
						
						// As the MV22 does not taxi, make sure it moves off the runway
						If ((TypeOf _aircraftVehicle) == "MV22") then 
						{
								_wp = _grp addwaypoint [_destpos, 0];
								_wp setWayPointType "MOVE";
								waitUntil{(_aircraftVehicle distance _destpos < 5)  && ((position _aircraftVehicle) select 2 <= 1) || (time > _stopTime)  || !(_grp call CBA_fnc_isAlive) };
						};
						
						// Turnoff the aircraft engines
						_aircraftVehicle engineOn false;
						
						sleep (_timeout select (random 2));
						
						// Check to see if aircraft is near Control Tower, if so, crew may get out and go for a chat
						_controlTowerTypes = ["Land_Mil_ControlTower","Land_Mil_ControlTower_EP1"];
						_controltowers = nearestObjects [position _aircraftVehicle, _controlTowerTypes, 200]; 
						diag_log format ["MSO-%1 Air Traffic: %5 %2 %3 Found ControlTowers: %4", time, _j, typeOf _aircraftVehicle, count _controltowers, _destination];
						If (count _controltowers > 0) then 
						{
								if (random 1 > 0.6) then 
								{
										// Set time for pilots to leave
										_scrambleTime = time + random 180;
										
										// Get Crew out of vehicle
										_wp = _grp addwaypoint [position _aircraftVehicle, 0];
										_wp setWayPointType "GETOUT";
										
										sleep 1;
										// Move crew to Control Tower room
										_controltw = _controltowers call BIS_fnc_selectRandom;
										_housepos = round (random 15); //Control tower positions are 0-15
										_wp = _grp addwaypoint [(_controltw buildingPos _housepos), 0];
										_wp setWayPointType "MOVE";
										
										// Get crew to chat once at controltower
										_wp setWayPointStatements ["true","{_x playMove 'AidlPercSnonWnonDnon_talk1'} foreach _aircraftCrew;"];
										
										// Pause then send the crew back to the vehicle
										sleep (_timeout select (random 2));
										_wp = _grp addwaypoint [position _aircraftVehicle, 0];
										_wp setWayPointType "GETIN";
								};
						};
						
						// Pause before moving to end position
						sleep (_timeout select (random 2));
						
						// Create end position waypoint
						_wp = _grp addwaypoint [_endpos, 0];
						_wp setWaypointType "MOVE";                               
						
						waitUntil{(_aircraftVehicle distance _endpos < 50) || (time > _stopTime) || !(_grp call CBA_fnc_isAlive)};
						
						// Check to see if vehicle was killed/died/crashed
						if (!(_grp call CBA_fnc_isAlive) && (_debug)) then {
								diag_log format["MSO-%1 Air Traffic: %3 %4, %2 Died!", time, TypeOf _aircraftVehicle, _destination, _j];
						};
						
						// Remove aircraft and crew
						if (_debug) then 
						{
								diag_log format["MSO-%1 Air Traffic: %3 %4 deleting %2", time, TypeOf _aircraftVehicle, _destination, _j];
						};
						{
							deleteVehicle _x;
						} forEach _aircraftCrew;
						deleteVehicle _aircraftVehicle;
						deletegroup _grp;
						
						// Pause before creating another aircraft for destination
						_sleep = if (_debug) then {10;} else {random 300;};
						sleep _sleep;
				};
        };
};