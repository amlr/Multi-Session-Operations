// Load Mission on Server

// This is done only once for the __SERVER__ ...

private ["_pname", "_serverData", "_procedureName", "_parameters", "_response", "_missionArray", "_thisMissionID", "_thisMissionName", "_thisMissionDate", "_missionid"];

if (isNil "MISSIONDATA") then { MISSIONDATA = [];};
if (isNil "PDB_PLAYERS_CONNECTED") then { PDB_PLAYERS_CONNECTED = ["000000"];  PDB_PLAYER_IS_READY = []; publicVariable "PDB_PLAYERS_CONNECTED"; publicVariable "PDB_PLAYER_IS_READY"; };
if (pdb_log_enabled) then {
	diag_log format["SERVER MSG: count MISSIONDATA, %1", count MISSIONDATA];
};

MISSIONDATA set [0, pdb_fullmissionName]; //  array position 0

_serverData = format["Mission: %1", pdb_fullmissionName];
PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";

// Check to see if mission exists in DB
_procedureName = "GetMissionByName"; _parameters = format["[tna=%1]",pdb_fullmissionName];	
_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;
_missionArray = [];
_missionArray = _response select 0;    // copy the returned row into array

if (isNil "_missionArray") then {
	// START mission name not found in database so create a new record
	
	if (pdb_log_enabled) then {
		diag_log format["SERVER MSG: MissionName: %1 not found", pdb_fullmissionName]; 
	};
	
	_serverData = format["Mission: %1 not found...", pdb_fullmissionName];
	PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
	
	// Set new mission details
	_procedureName = "NewMission"; 
	_parameters = format["[tna=%1,ttd=%2,tsc=%3,tgsc=%4,tlog=%5,twea=%6,tace=%7,tlv=%8,tobj=%9]",pdb_fullmissionName,mpdb_date_enabled,mpdb_persistentScores_enabled,mpdb_globalScores_enabled,mpdb_log_enabled,mpdb_weapons_enabled,mpdb_ace_enabled,mpdb_landvehicles_enabled,mpdb_objects_enabled];		
	_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;
	
	_serverData = format["Mission: %1 created an entry...", pdb_fullmissionName];
	PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
	
	// Get new mission default details back (id etc)
	_procedureName = "GetMissionByName"; _parameters = format["[tna=%1]",pdb_fullmissionName];
	_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;
	_missionArray = _response select 0;    // copy the returned row into array
}; 

if (_missionArray select 1 == pdb_fullmissionName) then {  // START mission name found
	
	// if mission name found
	_thisMissionID = _missionArray select 0;   //  returned mission id held at index 0 
	_thisMissionName = _missionArray select 1;  //  returned mission name
	
	MISSIONDATA set [1, _thisMissionID];  // array position 1 
	
	if (_missionArray select 2 == "1") then { pdb_date_enabled = true; } else { pdb_date_enabled = false; }; // returned enable time of day?    
	if (_missionArray select 4 == "1") then { pdb_persistentScores_enabled = true; } else { pdb_persistentScores_enabled = false; };  // returned enable persistent scores?
	if (_missionArray select 5 == "1") then { pdb_globalScores_enabled = true; } else { pdb_globalScores_enabled = false; };  // returned 	enable persistent global scores?
	if (_missionArray select 6 == "1") then { pdb_log_enabled = true; } else { pdb_log_enabled = false; };  //  // returned enable script logging?
	if (_missionArray select 7 == "1") then { pdb_weapons_enabled = true; } else { pdb_weapons_enabled = false; };  // returned enable save/load player weapon loadouts?
	if (_missionArray select 8 == "1") then { pdb_ace_enabled = true; } else { pdb_ace_enabled = false; };  // returned enable save/load player ACE weapon loadouts?
	if (_missionArray select 9 == "1") then { pdb_landvehicles_enabled = true; } else { pdb_landvehicles_enabled = false; };  // returned enable persistent land vehicle data?
	if (_missionArray select 10 == "1") then { pdb_objects_enabled = true; } else { pdb_objects_enabled = false; };  // returned enable persistent objects data?
	if (_missionArray select 11 == "1") then { pdb_air_enabled = true; } else { pdb_air_enabled = false; };   // returned enable persistent air data?	
	if (_missionArray select 12 == "1") then { pdb_ship_enabled = true; } else { pdb_ship_enabled = false; };  // returned enable persistent ship data?
	if (_missionArray select 13 == "1") then { pdb_building_enabled = true; } else { pdb_building_enabled = false; };  // returned enable persistent building data?
	if (_missionArray select 14 == "1") then { pdb_marker_enabled = true; } else { pdb_marker_enabled = false; };   // returned enable persistent marker data?
	if (_missionArray select 15 == "1") then { pdb_bans_enabled = true; } else { pdb_bans_enabled = false; };  // returned enable player bans?	
	
	if (pdb_date_enabled) then {	
		
		_thisMissionDate = [(_missionArray select 3),"read"] call persistent_fnc_convertFormat;
		
		if (typename _thisMissionDate == "ARRAY") then {
			
			if ((count _thisMissionDate) == 5) then {
				diag_log["setdate:  _thisMissionDate: ", _thisMissionDate];
				setdate _thisMissionDate;
			};
		
		};

	};				
	
	_missionid = _thisMissionID;
	
	if (pdb_log_enabled) then {
		diag_log format["SERVER MSG: Database mission id: %1", _thisMissionID]; 
		diag_log format["SERVER MSG: Database mission name selected: %1", _thisMissionName];
		diag_log format["SERVER MSG: Mission ID (SELECTED) is %1", _missionid];
		if (pdb_date_enabled) then {	
			diag_log format["SERVER MSG: Database mission date selected: %1", _thisMissionDate];
		};	
	};
	
	_serverData = format["Reading: %1...", pdb_fullmissionName];
	PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
	
};

_missionid;