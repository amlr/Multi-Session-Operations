/* 
* Filename:
* initPlayerConnection.sqf 
*
* Description:
* Called from playerConnected.sqf
* Runs on server only
* 
* Created by [KH]Jman
* Creation date: 17/10/2010
* Email: jman@kellys-heroes.eu
* Web: http://www.kellys-heroes.eu
* 
* */

// ====================================================================================
// INCLUDES
#include "\x\cba\addons\main\script_mod.hpp"
//http://dev-heaven.net/docs/cba/files/extended_eventhandlers/script_macros_common-hpp.html#DEBUG_MODE_FULL
#define DEBUG_MODE_FULL
#define DEBUG_SETTINGS DEBUG_SETTINGS_MAIN
#include "\x\cba\addons\main\script_macros.hpp"
#define COMPONENT arma2mysql
#define PREFIX asff
// ====================================================================================
// MAIN
// This is done for all players connecting...

// ====================================================================================		
// START addPublicVariableEventHandler
// ====================================================================================	
"PDB_PLAYER_READY" addPublicVariableEventHandler { 
	
	private ["_data", "_puid", "_player", "_pname", "_playerSide", "_missionid", "_response", "_dataRead", "_i", "_serverData", "_procedure", "_params", "_dataArray", "_d", "_thisdata", "_pposition", "_pside", "_procedureName", "_parameters"];

	_data = _this select 1;
	_puid = _data select 0;
	_player = _data select 1;
	_pname = _data select 2; 
	_playerSide = _data select 3;

	if (pdb_log_enabled) then { 
		diag_log["PersistentDB: SERVER MSG: PDB_PLAYER_READY: _player: ", _player];
		diag_log["PersistentDB: SERVER MSG: PDB_PLAYER_READY: _puid: ", _puid];
		diag_log["PersistentDB: SERVER MSG: PDB_PLAYER_READY: _pname: ", _pname];
		diag_log["PersistentDB: SERVER MSG: PDB_PLAYER_READY: _playerSide: ", _playerSide];
	};
	// Set player connection time
	_player setVariable ["LastConnected", "Arma2Net.Unmanaged" callExtension "DateTime ['utcnow',]", true];
	
	_missionid = (MISSIONDATA select 1);
	
	if (pdb_log_enabled) then {
		diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Mission ID (ARRAY) is %1", _missionid];
		diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Player connected %1, puid %2", _pname, _puid];
	};
	
	 _dataRead =[];
	// If Player found in DB then read in data else initialise player
	_response = ["GetPlayer", format["[tmid=%1,tpid=%2]",_missionid,_puid]] call persistent_fnc_callDatabase;	
	_dataRead = _response select 0;


	if(isNil "_dataRead") then {_dataRead = [];};
	
	
	if (count _dataRead > 0) then {
		
		if (_dataRead select 2 == _puid) then {
			
			// Log Player details as returned from DB -----------------------------------------------------------------------------------------------------------------------------------
			if (pdb_log_enabled) then {	
				diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Welcome back, %1", _dataRead select 1];
				diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Database player: %1 id: %2", _dataRead select 1, _dataRead select 0];
				diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Database player: %1 puid: %2", _dataRead select 1, _dataRead select 2];
				diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Database player: %1 name: %2", _dataRead select 1, _dataRead select 1];
				diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Database player: %1 score: %2", _dataRead select 1, _dataRead select 4];
				diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY: Database player: %1 mission id: %2", _dataRead select 1, _dataRead select 3];
			};
			
			// For each client data object, load from database and set data on server and to be passed back to client
			_i = 0;
			{
				private ["_type","_message","_typestr"];
				
				_typestr = _x;

				// Keep client updated on what is going on
				_message = [_typestr,"S_",""] call CBA_fnc_replace; 
				_message = tolower([_message,"_DATA",""] call CBA_fnc_replace);					
				_serverData = format["Loading %1 data...",_message];
				PDB_CLIENT_LOADERSTATUS = [_player,_serverData]; publicVariable "PDB_CLIENT_LOADERSTATUS";
				
				// Get data model type
				call compile format ["_type = %1",_typestr];
				// Set stored procedure to be called to load data from db
				call compile format["_procedure = %1_PROCEDURE",_typestr];
				// Set id params for loading data from db
				_params = format["[tmid=%1,tpid=%2]",_missionid,_puid];
				// Load Data from DB
				_response = [_procedure,_params] call persistent_fnc_callDatabase;
				_dataArray = _response select 0;
				// Set data on server and return array to client - does this need to be a fn_setdata?	
				_d = 0;
				{
					private "_data";
					// Convert from string to SQF
					_data = _x;
					_thisdata = [_data, "read"] call persistent_fnc_convertFormat;
					// Store in array to be passed to client
					_dataRead set [_i, _thisdata];
					// Set data on server
					[_thisdata, _player] call (_type select _d);
				
					if (pdb_log_enabled) then {	
						diag_log format["PersistentDB: SERVER MSG: PDB_PLAYER_READY:: Database %3: %1 - Data: %2", _dataRead select 1, _thisdata, _message];
					};
					// Next attribute
					_d = _d + 1;
					_i = _i + 1;
				} foreach _dataArray;
				
			} foreach PDB_CLIENT_SET_DATA;
			
			//diag_log format ["DataRead = %1", _dataRead];
			// Send data to client
			PDB_PLAYER_HANDLER = _dataRead;
			publicVariable "PDB_PLAYER_HANDLER";
			[_player, _pname, _puid, "true"] call persistent_fnc_getScore;
		};  // end if player in DB	
		
	
	
	} else { // if new player initialize
		
		_serverData = format["Creating player entry in database..."];
		PDB_CLIENT_LOADERSTATUS = [_player,_serverData]; publicVariable "PDB_CLIENT_LOADERSTATUS";
		
		// Initialise Player object values
		if (pdb_globalScores_enabled) then {
			_player setVariable ["loadedPlayerScore", 0, true]; 
		};
		
		// set the players shots fired, kills, deaths, suicides - these variables are updated during game by eventhandlers or interaction
		_player setVariable ["damage", 0, true];
		_player setVariable ["head_hit", 0, true];
		_player setVariable ["body", 0, true];
		_player setVariable ["hands", 0, true];
		_player setVariable ["legs", 0, true];
		_player setVariable ["pshotsfired", 0, true]; 
		_player setVariable ["penemykills", 0, true]; 
		_player setVariable ["pcivkills", 0, true]; 
		_player setVariable ["pfriendlykills", 0, true]; 
		_player setVariable ["psuicides", 0, true]; 
		_player setVariable ["pdeaths", 0, true]; 
		_player setVariable ["pviewdistance", 1600, true]; 
		_player setVariable ["pterraindetail", 2, true];
		_player setVariable ["prank",rank _player, true];
		_player setVariable ["TimePlayed", 0, true];
		_player setVariable ["connectTime", time, true];
		_player setVariable ["playerSide", (side _player), true];
		
		// get the player's spawn position
		_pposition = [getPosATL _player, "write"] call persistent_fnc_convertFormat;
		// get the player's side
		_pside =  side _player;
		
		_procedureName = "InsertPlayer"; _parameters = format["[tpid=%1,tna=%2,tmid=%3,tsid=%4,tpos=%5]",_puid,_pname,_missionid,_pside,_pposition];
		_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
		 [_player, _pname, _puid, "false"] call persistent_fnc_getScore;
	}; // end  if new player

};  // END addPublicVariableEventHandler



