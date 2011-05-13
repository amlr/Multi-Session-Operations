private ["_debug","_mapsize","_helidest","_planedest","_center","_destairfields","_forEachIndex"];
if(!isServer) exitWith{};

if (isNil "factionsMask") then {factionsMask = 0;};
if (factionsMask == 2) exitWith{};

if(isNil "AirIntensity")then{AirIntensity = 1;};

_debug = true;

// Initialise map embedded helipads
{
        private["_new"];
        _new = createVehicle ["HeliHEmpty", (_x select 0), [],0,'NONE'];     
        _new setDir (_x select 1);
} forEach (switch toLower(worldName) do {		
        case "takistan": {
                [
                        [[8263,1800.54], 150.567],
                        [[8222.98,1776.7,0.0101013],150.358],
                        [[8180.42,1752.3,0.0100098],151.828]
                ];
        };
        case "zargabad": {
                [
                        [[3534.1, 3939.4], 270],
                        [[4568,4124], 110]
                ];
        };
        default {[]};
});

/*
// CRB_convertHelipads
[] spawn {
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
};
*/

// Get center of map
_center = getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition");
// Calculate size of map
_mapsize = ((_center select 0) * 2);
if (_debug) then {
        diag_log format ["MSO-%1 Air Traffic: Mapsize is %2", time, _mapsize];
};

waitUntil{!isNil "BIS_fnc_init"};

// Define airports-hangars-Helipads from the Map
_destairfields = [];
_helidest = [];
_planedest = [];

TUP_AIRDESTS = [];  // array of [destpos, isPlane, startpos, endpos, vehicle]

// Find airport locations
_destairfields = [["Airport"],_debug,"ColorGreen","airport"] call mso_core_fnc_findLocationsByType;
//Find hangars at airport locations
_planedest = [["Land_Hangar_2","Land_SS_hangar","Land_SS_hangarD","Land_Mil_hangar_EP1"], _destairfields, 1500,_debug,"ColorGreen","Airport"] call mso_core_fnc_findObjectsByType;
{
        TUP_AIRDESTS set [count TUP_AIRDESTS, [position _x, true]]; 
} forEach _planedest;
// Find helipads on the map
_helidest = [["HeliH","HeliHRescue","HeliHCivil","HeliHEmpty"], [], _mapsize, _debug,"ColorBlack","heliport"] call mso_core_fnc_findObjectsByType;
{
        TUP_AIRDESTS set [count TUP_AIRDESTS, [position _x, false]]; 
} forEach _helidest;

//TUP_AIRDESTS = [TUP_AIRDESTS select 0,TUP_AIRDESTS select 1,TUP_AIRDESTS select 2];

// Spawn a loop for each destination (each hangar and each helipad)
{
        // Reserve empty variables for startpos, endpos and vehicle
        TUP_AIRDESTS set [_forEachIndex , _x + [nil,nil,nil,nil]];
        // Mark Destination on Map
        if (_debug) then{
                private["_t","_m"];
                _t = format["AirTraffic_s%1", _forEachIndex];
                _m = [_t, (_x select 0), "Icon", [1,1], "TYPE:", "Dot", "TEXT:", _t, "COLOR:", "ColorBlack", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
        };                                
} forEach TUP_AIRDESTS;

TUP_CIVFACS= [civilian] call mso_core_fnc_getFactions;

[{
        private ["_startpos","_destpos","_endpos","_j","_debug","_mapsize","_airfieldSide","_isPlane","_startHeight","_dest","_front","_facs","_factions","_factionsCount","_aircraft","_vehiclelist","_aircraftVehicle","_grp","_stoptime","_wp","_mv22pos","_landEnd","_timeout","_aircraftClass","_params"];
        _params = _this select 0;
        _mapsize = _params select 0;
        _debug = _params select 1;
        
        {
                _dest = _x;
                _j = _forEachIndex;
                
                _destpos = _dest select 0;
                _isPlane = _dest select 1;
                _startpos = _dest select 2;
                _endpos = _dest select 3;
                _aircraftVehicle = _dest select 4;
                _stoptime = _dest select 5;
                
                if(count (nearestObjects [_destpos, ["Helicopter"], 5]) > 0) exitWith {};
                
                if (if(isNil "_aircraftVehicle") then { true} else {!alive _aircraftVehicle}) then {
                        // set startheight
                        _startHeight = 500 + (random 200);
                        // Set timeout for waypoints
                        _timeout = if(_debug) then {[0, 0, 0];} else {[30, 60, 90];};
                        //Create a random spawn point along the edge of the map				
                        _startpos = [_mapsize,_startHeight,_debug, str _j,"ColorBlack","Dot"] call mso_core_fnc_randomEdgePos;
                        _dest set [2, _startpos];
                        TUP_AIRDESTS set [_j, _dest];
                        // Define a random place at the edge of the map to fly to
                        _endpos = [_mapsize,_startHeight,_debug, str _j,"ColorRed","Dot"] call mso_core_fnc_randomEdgePos;
                        _dest set [3, _endpos];
                        TUP_AIRDESTS set [_j, _dest];
                        // Work out side that controls destination (based on unit numbers)
                        _airfieldSide = [_destpos, 1000, format["%1 %2",_destpos,_j],_debug] call mso_core_fnc_getDominantSide;                        
                        // If we are counting all factions then work out controlling side, otherwise default to civilian
                        if (factionsMask == 0 || _airfieldSide == civilian) then {
                                if (random 1 < AirIntensity) then {
                                        // Get the factions for the controlling side and count their units
                                        _factions = [_airfieldSide, _destpos, 1000,"factions",_debug,format["%1 %2",_destpos,_j]] call mso_core_fnc_getFactions;
                                        _factionsCount = [_airfieldSide, _destpos, 1000,"count",_debug,format["%1 %2",_destpos,_j]] call mso_core_fnc_getFactions;
                                        
                                        // Create aircraft 
                                        _aircraft = [];
                                        _front = "";
                                        
                                        // Check to see if we need a plane or helicopter
                                        if (_isPlane) then {
                                                _front = "Plane";
                                        } else {
                                                _front = "Helicopter";
                                        };
                                        
                                        // Select the faction based on unit count bias and get a list of possible vehicles
                                        //_facs = [_factions,_factionsCount] call mso_core_fnc_selectRandomBias;
                                        // Select a vehicle from the list - if no valid vehicle selet a civilian aircraft
                                        _vehiclelist =  [0, _factions,_front] call mso_core_fnc_findVehicleType; 
                                        _aircraftClass = "";
                                        
                                        if (count _vehiclelist > 0 || random 1 > 0.5) then {
                                                if (_debug) then {
                                                        diag_log format ["MSO-%1 Air Traffic: %4 %2 Faction: %5 Vehicle list: %3", time, _j, _vehiclelist, _destpos, _facs];
                                                };
                                                _aircraftClass = (_vehiclelist) call BIS_fnc_selectRandom;
                                        } else {
//                                                while{_aircraftClass == ""} do {
                                                        _aircraftClass =  ([0, TUP_CIVFACS,_front] call mso_core_fnc_findVehicleType) call BIS_fnc_selectRandom;
//                                                };
                                                
                                                _airfieldSide = civilian;
                                                if (_debug) then {
                                                        diag_log format ["MSO-%1 Air Traffic: %4 %2  Could not find suitable military aircraft, civilian aircraft found: %3", time, _j, _aircraftClass, _destpos];
                                                };
                                        };
                                        
                                        if (_debug) then {
                                                diag_log format ["MSO-%1 Air Traffic: %4 %2  Found Aircraft %3", time, _j, _aircraftClass, _destpos];
                                        };
                                        
                                        // Create aircraft
                                        _aircraft = [[_startpos, 10] call CBA_fnc_randPos, 0,_aircraftClass, _airfieldSide] call BIS_fnc_spawnVehicle;
                                        _aircraftVehicle = _aircraft select 0;
                                        //_aircraftCrew = _aircraft select 1;
                                        _grp = _aircraft select 2;
                                        _dest set [4, _aircraftVehicle];
                                        TUP_AIRDESTS set [_j, _dest];
                                        _stoptime = time + 300 + random 600;
                                        _dest set [5, _stoptime];
                                        TUP_AIRDESTS set [_j, _dest];
                                        
                                        diag_log format["MSO-%1 Air Traffic: %10 #%2, Vehicle: %6 Group: %9 Faction: %7 Start: %3 Landing: %4 End: %5 Stop: %8", time, _j, _startpos, _destpos, _endpos, typeOf _aircraftVehicle, _facs, _stoptime, _grp, _destpos];
                                        
                                        // Set aircraft waypoints                                      
                                        // Destination Waypoint
                                        _wp = _grp addWaypoint [_destpos, 0];
                                        _wp setWaypointBehaviour "SAFE";
                                        _wp setWaypointCombatMode "BLUE";
                                };
                        };
                };
                
                // Wait until the aircraft is close to the airfield
                if(((_aircraftVehicle distance _destpos < 500) || (time > _stoptime) || !(_aircraftVehicle call CBA_fnc_isAlive)) && (_aircraftVehicle getVariable ["status", ""]) != "landing") then {
                        player groupChat "Landing";
                        // Once near destination, action a landing.
                        if (typeOf _aircraftVehicle == "MV22") then {
                                _mv22pos = [_destpos, 0, 45, 15, 0, 0, 0] call BIS_fnc_findSafePos;
                                _landEnd = "HeliHEmpty" createVehicle _mv22pos;
                        };
                        if (_aircraftVehicle isKindOf "Helicopter" || typeOf _aircraftVehicle == "MV22") then {
                                _aircraftVehicle land "LAND";
                        } else {
                                _aircraftVehicle action ["Land", _aircraftVehicle];
                        };
                        _aircraftVehicle setVariable ["status","landing"];
                        player groupChat format["%1 %2 Landing", _j, typeOf _aircraftVehicle];
                };
                player groupChat format["%1 %2 Checking", _j, typeOf _aircraftVehicle, _destpos];
        } forEach TUP_AIRDESTS;
}, 3, [_mapsize, _debug]] call mso_core_fnc_addLoopHandler;
player globalChat "Finished";

/*                if ((!_isPlane || typeOf _aircraftVehicle == "MV22") &&
((position _aircraftVehicle) select 2 <= 5) &&
(_aircraftVehicle distance _destpos < 5)  ||
(time > _stoptime) ||
!(_grp call CBA_fnc_isAlive)) then {
        if (typeOf _aircraftVehicle == "MV22") then {
                deleteVehicle _landEnd;
        };
        // Turnoff the aircraft engines
        _aircraftVehicle engineOn false;
        player globalChat "Engine Off";
};
*/               
/*                        
sleep (_timeout select (random 2));

// Check to see if aircraft is near Control Tower, if so, crew may get out and go for a chat
_controlTowerTypes = ["Land_Mil_ControlTower","Land_Mil_ControlTower_EP1"];
_controltowers = nearestObjects [position _aircraftVehicle, _controlTowerTypes, 200]; 
if (_debug) then {diag_log format ["MSO-%1 Air Traffic: %5 %2 %3 Found ControlTowers: %4", time, _j, typeOf _aircraftVehicle, count _controltowers, _destpos];};
if (count _controltowers > 0) then 
{
        if (random 1 > 0.5) then 
        {
                // Set time for pilots to leave
                _scrambleTime = time + random 180;
                
                // Get Crew out of vehicle
                _wp = _grp addWaypoint [position _aircraftVehicle, 0];
                _wp setWaypointType "GETOUT";
                
                sleep 1;
                // Move crew to Control Tower room
                _controltw = _controltowers call BIS_fnc_selectRandom;
                _housepos = round (random 15); //Control tower positions are 0-15
                _wp = _grp addWaypoint [(_controltw buildingPos _housepos), 0];
                _wp setWaypointType "MOVE";
                
                // Get crew to chat once at controltower
                _wp setWaypointStatements ["true","{_x playMove 'AidlPercSnonWnonDnon_talk1'} foreach _aircraftCrew;"];
                
                // Pause then send the crew back to the vehicle
                sleep (_timeout select (random 2));
                _wp = _grp addWaypoint [position _aircraftVehicle, 0];
                _wp setWaypointType "GETIN";
        };
};

// Pause before moving to end position
sleep (_timeout select (random 2));

// Create end position waypoint
_wp = _grp addWaypoint [_endpos, 0];
_wp setWaypointType "MOVE";                               

waitUntil{(_aircraftVehicle distance _endpos < 50) || (time > _stoptime) || !(_grp call CBA_fnc_isAlive)};

// Check to see if vehicle was killed/died/crashed
if (!(_grp call CBA_fnc_isAlive) && (_debug)) then {
        diag_log format["MSO-%1 Air Traffic: %3 %4, %2 Died!", time, typeOf _aircraftVehicle, _destpos, _j];
};

// Remove aircraft and crew
if (_debug) then {
        diag_log format["MSO-%1 Air Traffic: %3 %4 deleting %2", time, typeOf _aircraftVehicle, _destpos, _j];
};
{ deleteVehicle _x } forEach _aircraftCrew;
deleteVehicle _aircraftVehicle;
deleteGroup _grp;
};   
// Pause before creating another aircraft for destination
_sleep = if(_debug) then {10;} else {random 300;};
sleep _sleep;	
*/
