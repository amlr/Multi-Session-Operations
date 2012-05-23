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
	//sleep 5;
	sleep 0.01;

	_id = _this select 0; 
	_pname = _this select 1; 
	_puid  = _this select 2; 
	
// ====================================================================================	

// This is done only once for the __SERVER__ ...


		// START MISSIONDATA CALL
		if (( MISSIONDATA_LOADED == "false") && (_pname == "__SERVER__")) then {
		
		if (isNil "MISSIONDATA") then { MISSIONDATA = [];};
		if (isNil "PDB_PLAYERS_CONNECTED") then { PDB_PLAYERS_CONNECTED = ["000000"];  PDB_PLAYER_IS_READY = []; publicVariable "PDB_PLAYERS_CONNECTED"; publicVariable "PDB_PLAYER_IS_READY"; };
		if (pdb_log_enabled) then {
				diag_log format["SERVER MSG: count MISSIONDATA, %1", count MISSIONDATA];
		};
			private["_conn", "_handler", "_thisMissionID", "_thisMissionName", "_thisMissionDate","_thisSQL", "_missionArray","_write","_databaseName","_procedureName","_parameters","_databaseProcedure","_found","_retPipe","_result","_temp","_response","_return_response","_landVehicleData","_landVehicleCountInDB","_vObject", "_vPosition", "_vDir", "_vUp", "_vDam", "_vFuel", "_vLocked", "_vWeaponCargo", "_vEngine"];
			
		   MISSIONDATA set [0, pdb_fullmissionName]; //  array position 0
		   
		   _serverData = format["Mission: %1", pdb_fullmissionName];
		   	PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
		   	
		   _procedureName = "GetMissionByName"; _parameters = format["[tna=%1]",pdb_fullmissionName];
		   	// diag_log ("callExtension->Arma2NETMySQL: GetMissionByName");		
		   	_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;
			// diag_log ["callExtension->Arma2NETMySQL: GetMissionByName _response: ",  _response, typeName _response];
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
								_parameters = format["[tna=%1,ttd=%2,tsc=%3,tgsc=%4,tlog=%5,twea=%6,tace=%7,tlv=%8]",pdb_fullmissionName,mpdb_date_enabled,mpdb_persistentScores_enabled,mpdb_globalScores_enabled,mpdb_log_enabled,mpdb_weapons_enabled,mpdb_ace_enabled,mpdb_landvehicles_enabled];	
								
							//	diag_log ("callExtension->Arma2NETMySQL: NewMission");		
							   	_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;
							  
							  			  _serverData = format["Mission: %1 created an entry...", pdb_fullmissionName];
			   								 PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
								
							_procedureName = "GetMissionByName"; _parameters = format["[tna=%1]",pdb_fullmissionName];
						//	diag_log ("callExtension->Arma2NETMySQL: GetMissionByName");		
							_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;
						//	diag_log ["callExtension->Arma2NETMySQL: GetMissionByName _response: ",  _response, typeName _response];
							   		
						    			
							_missionArray = _response select 0;    // copy the returned row into array
						
						 // END mission name not found in database
					}; 
							
							
if (_missionArray select 1 == pdb_fullmissionName) then {  // START mission name found
	
							// if mission name found
							_thisMissionID = _missionArray select 0;   //  returned mission id held at index 0 
							_thisMissionName = _missionArray select 1;  //  returned mission name

							 if (_missionArray select 2 == "1") then { pdb_date_enabled = true; } else { pdb_date_enabled = false; }; // returned enable time of day?    
							 if (_missionArray select 4 == "1") then { pdb_persistentScores_enabled = true; } else { pdb_persistentScores_enabled = false; };  // returned enable persistent scores?
							 if (_missionArray select 5 == "1") then { pdb_globalScores_enabled = true; } else { pdb_globalScores_enabled = false; };  // returned 	enable persistent global scores?
							 if (_missionArray select 6 == "1") then { pdb_log_enabled = true; } else { pdb_log_enabled = false; };  //  // returned enable script logging?
							 if (_missionArray select 7 == "1") then { pdb_weapons_enabled = true; } else { pdb_weapons_enabled = false; };  // returned enable save/load player weapon loadouts?
							 if (_missionArray select 8 == "1") then { pdb_ace_enabled = true; } else { pdb_ace_enabled = false; };  // returned enable save/load player ACE weapon loadouts?
							 if (_missionArray select 9 == "1") then { pdb_landvehicles_enabled = true; } else { pdb_landvehicles_enabled = false; };  // returned enable persistent land vehicle data?
							 if (_missionArray select 10 == "1") then { pdb_man_enabled = true; } else { pdb_man_enabled = false; };  // returned enable persistent man data?
							 if (_missionArray select 11 == "1") then { pdb_air_enabled = true; } else { pdb_air_enabled = false; };   // returned enable persistent air data?	
							 if (_missionArray select 12 == "1") then { pdb_ship_enabled = true; } else { pdb_ship_enabled = false; };  // returned enable persistent ship data?
							 if (_missionArray select 13 == "1") then { pdb_building_enabled = true; } else { pdb_building_enabled = false; };  // returned enable persistent building data?
							 if (_missionArray select 14 == "1") then { pdb_marker_enabled = true; } else { pdb_marker_enabled = false; };   // returned enable persistent marker data?
							 if (_missionArray select 15 == "1") then { pdb_bans_enabled = true; } else { pdb_bans_enabled = false; };  // returned enable player bans?	
									 											
if (pdb_date_enabled) then {	
							// reformat mission date
							_thisMissionDate = [(_missionArray select 3), "|", ","] call CBA_fnc_replace; // returned current mission time of day
							_thisMissionDate = "[" + _thisMissionDate + "]";
							_thisMissionDate = call compile _thisMissionDate;
						  	MISSIONDATA set [1, _thisMissionID];  // array position 1
						
						if ((count _thisMissionDate) == 5) then {
							diag_log["setdate:  _thisMissionDate: ", _thisMissionDate];
							setdate _thisMissionDate;
						};
};				
						

						   _missionid = _thisMissionID;
						   
							if (pdb_log_enabled) then {
								diag_log format["SERVER MSG: Database mission id: %1", _thisMissionID]; 
								diag_log format["SERVER MSG: Database mission name selected: %1", _thisMissionName];
								diag_log format["SERVER MSG: Mission ID (SELECTED) is %1", _missionid];
							 };
							 if (pdb_date_enabled) then {	
								diag_log format["SERVER MSG: Database mission date selected: %1", _thisMissionDate];
							 };		
							 
					
								_serverData = format["Reading: %1...", pdb_fullmissionName];
		   						 PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
					
				
if (pdb_landvehicles_enabled) then {	
				
						// START load the landVehicle data
						
 
						// Count the number of land vehicles associated with this mission id
						_procedureName = "CountLandVehicleIDsByMission"; 
						_parameters = format["[tmid=%1]",_missionid];
						  
					//	diag_log ("callExtension->Arma2NETMySQL: CountLandVehicleIDsByMission");		
						_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
					//    diag_log ["callExtension->Arma2NETMySQL: CountLandVehicleIDsByMission _response: ",  _response, typeName _response];
					    			
						   
						  
					 if (pdb_log_enabled) then {
						diag_log format["SERVER MSG: SQL output: %1", _parameters];
					 };
					 

						_landVehicleCountInDB = _response select 0;    // copy the returned row into array
						
						 diag_log ["CountLandVehicleIDsByMission _landVehicleCountInDB: ",  _landVehicleCountInDB, typeName _landVehicleCountInDB];
						 
	
							_serverData = format["Getting land vehicles from database..."];
		   					PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
	
						 // now get the vehicledata per id
						 
						 _procedureName = "GetLandVehicleByInitid"; 

						 _countInDB = parseNumber (_landVehicleCountInDB select 0);

// START LOOP
						   for [{_z=0},{_z < _countInDB},{_z=_z+1}] do {
						   	
						   	
										_thisID = _z+1;
										
										//   	_thisID = _landVehicleCountInDB select _z;
									//		_thisID = _thisID select 0;
											
			//								if (_thisID != "") then {	
											
											_parameters = format["[tintid=%1,tmid=%2]", _thisID,_missionid];
											
											 if (pdb_log_enabled) then {
													diag_log format["SERVER MSG: SQL output: %1", _parameters];
											 };
											 
											 
								//	diag_log ("callExtension->Arma2NETMySQL: GetLandVehicleByInitid");		
									_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
								//	diag_log ["callExtension->Arma2NETMySQL: GetLandVehicleByInitid _response: ",  _response, typeName _response];
													 
											
													
									_landVehicleData	= _response select 0;    // copy the returned row into array
												
			//								diag_log ["GetLandVehicleByInitid _landVehicleData: ",  _landVehicleData, typeName _landVehicleData];
											

											_vObject =_landVehicleData select 1;
											_vObject = [_vObject, "|", ","] call CBA_fnc_replace; 
											_vObject = [_vObject, "?", ":"] call CBA_fnc_replace; 	
											
											
											
											
											diag_log ["_vObject: ",  _vObject, typeName _vObject];
											
											

											// Convert string to Object
											private "_tmp";
											call compile format ["_tmp = %1", _vObject];
											_thisVehicle = _tmp;
											diag_log ["_thisVehicle: ",  _thisVehicle, typeName _thisVehicle];
					
								
							//	 	 _thisVehicle = objNull;
								//		{
									
									//			if ( str(_x) == _vObject) exitWith {
														
										//			    _thisVehicle = _x;
															
															
										//		diag_log ["_thisVehicle: ",  _thisVehicle, typeName _thisVehicle];
						 					
						 					_serverData = format["Loading land vehicle: %1...", _thisVehicle];
		   									 PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
							 			    
											_vPosition =_landVehicleData select 2;
											_vPosition = [_vPosition, "|", ","] call CBA_fnc_replace; 
											_vPosition = call compile _vPosition;
											
	//										diag_log ["_vPosition: ",  _vPosition, typeName _vPosition];
											 
											_vDir = _landVehicleData select 3;
											_vDir = [_vDir, "|", ","] call CBA_fnc_replace;
											_vDir = call compile _vDir;
											
	//										diag_log ["_vDir: ",  _vDir, typeName _vDir];
											
											_vUp = _landVehicleData select 4;
											_vUp = [_vUp, "|", ","] call CBA_fnc_replace;
											_vUp = call compile _vUp;
											
//											diag_log ["_vUp: ",  _vUp, typeName _vUp];
											
											_vDam = _landVehicleData select 5;
											_vDam = parseNumber _vDam;
											
	//										diag_log ["_vDam: ",  _vDam, typeName _vDam];
											
											
											_vFuel = _landVehicleData select 6;
											_vFuel = parseNumber _vFuel;
											
	//										diag_log ["_vFuel: ",  _vFuel, typeName _vFuel];
									
											_vLocked = _landVehicleData select 7;
											
										     if (_vLocked == "false") then { _vLocked = false; } else{ _vLocked = true; };
	//										 diag_log ["_vLocked: ",  _vLocked, typeName _vLocked];
										
											
											_vWeaponCargo = _landVehicleData select 8;
											_vWeaponCargo = [_vWeaponCargo, "|", ","] call CBA_fnc_replace; 
											_vWeaponCargo = call compile _vWeaponCargo;	
											
	//										diag_log ["_vWeaponCargo: ",  _vWeaponCargo, typeName _vWeaponCargo];
											  
											_vEngine = _landVehicleData select 9;
										     if (_vEngine == "false") then { _vEngine = false; } else{ _vEngine = true; };
											
	//										diag_log ["_vEngine: ",  _vEngine, typeName _vEngine];
											
											
								
											// set the vehicles position
											_thisVehicle setPosATL _vPosition;
											// set the vehicles direction
											_thisVehicle setVectorDirAndUp [_vDir,_vUp];
										   // set the vehicles damage
											_thisVehicle setDammage _vDam;
										   // set the vehicles fuel 
										    _thisVehicle setFuel _vFuel;
										   // set the vehicles lock 
										    _thisVehicle lock _vLocked;
										   // set the vehicles WeaponCargo 
										   _thisVehicle addWeaponCargo _vWeaponCargo;
										   // set the vehicles engine 
										   _thisVehicle engineOn _vEngine;
			 						
			 						
			 				//		};
			 			//	} 
		    		//	forEach allMissionObjects "LandVehicle"; 
// END LOOP		    			
	//				};
				};
						   
};
		
						// END load the landVehicle data	
						
						
						MISSIONDATA_LOADED = "true";
						publicVariable "MISSIONDATA_LOADED"; // update the global array	
						
								
}; // END  if _missionArray
			
					//Stop and close pipe
	//				[GVAR(arma2mysqlPipeHandle)] call jayarma2lib_fnc_closepipe;
	//				GVAR(arma2mysqlPipeHandle) = nil;
	//				diag_log ("GetMission Pipe closed.");		
						
						
					
		}; // END MISSIONDATA CALL



// ====================================================================================		
// START addPublicVariableEventHandler
// ====================================================================================	
	"PDB_PLAYER_READY" addPublicVariableEventHandler { 
	
	_data = _this select 1;
	_puid = _data select 0;
	_player = _data select 1;
	_pname = _data select 2; 
	_playerSide = _data select 3;
	
	
	diag_log["PASS: _player: ", _player];
	diag_log["PASS: _puid: ", _puid];
	diag_log["PASS: _pname: ", _pname];
	diag_log["PASS: _playerSide: ", _playerSide];
	
	private["_x","_ace", "_playerwea", "_write","_databaseName","_procedureName","_parameters","_databaseProcedure","_found","_retPipe","_result","_temp","_response","_return_response","_thisPposition", "_thisweapons", "_thismagazines", "_newscore", "_thispdamage", "_this_pdamage_head_hit", "_this_pdamage_body", "_this_pdamage_hands", "_this_pdamage_legs", "_length_weapons", "_length_position", "_length_damage", "_length_pdamage_head_hit", "_length_pdamage_body", "_length_pdamage_hands", "_length_pdamage_legs", "_dbScore", "_length_aceruckweapons", "_length_aceruckmagazines","_thisPlayerGlobalscore","_globalPlayerScore", "_pscore", "_connectedplayer","_seen","_thispvehicle","_thispseat","_length_pvehicle","_length_pseat","_status","_bypassed"];
	
			 _missionid = (MISSIONDATA select 1);
			 if (pdb_log_enabled) then {
				 	diag_log format["SERVER MSG: Mission ID (ARRAY) is %1", _missionid];
				 	diag_log format["SERVER MSG: Player connected %1, puid %2", _pname, _puid];
			};
	
			
			_seen = false;  // leave this. boolean for player exists in db
				// defaults	
				_this_pdamage_head_hit = "''";
				_this_pdamage_body = "''";
				_this_pdamage_hands = "''";
				_this_pdamage_legs = "''";
				_thispdirection = getDir _player;
				_this_aceweapononback = "''";
				_this_aceruckweapons = [];
				_this_aceruckmagazines = [];
				_thispvehicle = "''";
				_thispseat = "''";
				
				_thisptype = typeof _player;
				_thisprating = rating _player;
				_thispviewdistance = 1600;
				_thispterraindetail = 2;
				_thisprank = rank _player;
				_thispshotsfired = 0;
				_thispenemykills = 0;
				_thispcivkills = 0;
				_thispfriendlykills = 0;
				_thispsuicides = 0;
				_thisplifestate = lifestate _player;
				_thispdeaths = 0;
				
				// stance start
				_animState = animationState _player;
				
				_animStateChars = toArray _animState;
				_animP = toString [_animStateChars select 5, _animStateChars select 6, _aniMStateChars select 7];
				_thispstance = "";
				
				switch (_animP) do
						{
						   case "erc":
							{
								_thispstance = "Stand"; 
							};
						   case "knl":
							{
								_thispstance = "Crouch"; 
							};
						   case "pne":
							{
								_thispstance = "Lying"; 
							};
						};
				// stance end
				
				/*_length_pdamage_head_hit = [_this_pdamage_head_hit] call CBA_fnc_strLen;
				_length_pdamage_body = [_this_pdamage_body] call CBA_fnc_strLen;
			    _length_pdamage_hands = [_this_pdamage_hands] call CBA_fnc_strLen;
				_length_pdamage_legs = [_this_pdamage_legs] call CBA_fnc_strLen;
				_length_pdirection  = [str(_thispdirection)] call CBA_fnc_strLen;
				_length_pstance = [_thispstance] call CBA_fnc_strLen;
				_length_pvehicle = [_thispvehicle] call CBA_fnc_strLen;
				_length_pseat = [_thispseat] call CBA_fnc_strLen;
				_length_aceweapononback  = [_this_aceweapononback] call CBA_fnc_strLen;
				_length_aceruckweapons  = [str(_this_aceruckweapons)] call CBA_fnc_strLen;
				_length_aceruckmagazines  = [str(_this_aceruckmagazines)] call CBA_fnc_strLen;*/

				
				//	diag_log ["callExtension->Arma2NETMySQL: GetPlayer _missionid: ",  _missionid, typeName _missionid];
				//	diag_log ["callExtension->Arma2NETMySQL: GetPlayer _puid: ",  _puid, typeName _puid];
				_procedureName = "GetPlayer"; _parameters = format["[tmid=%1,tpid=%2]",_missionid,_puid];	
			   // diag_log ["callExtension->Arma2NETMySQL: GetPlayer _parameters: ",  _parameters, typeName _parameters];
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
				//diag_log ["callExtension->Arma2NETMySQL: GetPlayer _response: ",  _response, typeName _response];
			    			
					    
				
				_x = _response select 0;    // copy the returned row into array
						

			// if player found in database...
			if(_x select 2 == _puid) then {
				
						/*
						id 0
						na 1
						pid 2
						sc 3
						pos 4
						
						mid 5
						dam 6
						dhe 7
						dbo 8
						dha 9
						dle 10
						dir 11
						sta 12
						sid 13
						
						veh 14
						sea 15
								
						typ 16
						rat 17
						vd 18
						td 19
						ran 20
						fir 21
						ek 22
						ck 23
						fk 24
						sui 25
						lif 26
						dea 27
						
						wea 28
						mag 29
						
						awb 30
						aw 31
						arm 32

						
						*/




// START get player's vanilla weapons and ammo
if (pdb_weapons_enabled) then {

		   _serverData = format["Loading player weapons..."];
		   	PDB_CLIENT_LOADERSTATUS = [_player,_serverData]; publicVariable "PDB_CLIENT_LOADERSTATUS";
		   	
		   	
		   		 _procedureName = "GetPlayerWeapons"; _parameters = format["[tmid=%1,tpid=%2]",_missionid,_puid];
				// diag_log ("callExtension->Arma2NETMySQL: GetPlayerWeapons");		
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;
				// diag_log ["callExtension->Arma2NETMySQL: GetPlayerWeapons _response: ",  _response, typeName _response];	
			    		
		   	
		   	
						_playerwea = _response select 0;    // copy the returned row into array

						_x set [28, _playerwea select 0];
						_x set [29, _playerwea select 1];
// END get player's vanilla weapons and ammo
};

		
// START get player's ACE weapons and ammo
if (pdb_ace_enabled) then {				

   _serverData = format["Loading player ACE weapons..."];
	PDB_CLIENT_LOADERSTATUS = [_player,_serverData]; publicVariable "PDB_CLIENT_LOADERSTATUS";
				
	 _procedureName = "GetPlayerACE"; _parameters = format["[tmid=%1,tpid=%2]",_missionid,_puid];
	// diag_log ("callExtension->Arma2NETMySQL: GetPlayerACE");		
	_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
	// diag_log ["callExtension->Arma2NETMySQL: GetPlayerACE _response: ",  _response, typeName _response];	
			
	_ace = _response select 0;    // copy the returned row into array

	_x set [30, _ace select 0];
	_x set [31, _ace select 1];
	_x set [32, _ace select 2];		
						
};
// END get player's ACE weapons and ammo

			
 	    _seen = true;
						// _thisid = _x select 0;     //  returned player id
						// _thispname = _x select 1;   //  returned player name held at index 1 
						//	_thispuid = _x select 2;  //  returned player uid
						_thispscore = _x select 3;  //  returned player score	
						
						if (pdb_globalScores_enabled) then {
							_loadedPlayerScore = parseNumber _thispscore;
							_player setVariable ["loadedPlayerScore", _loadedPlayerScore, true]; 
						};
						
					    // _thisposition = _x select 4; //  returned player position
					    // _thisweapons = _x select 14;  // returned player weapons
					    // _thismagazines = _x select 15;  // returned player magazines
					    // _thisMissionid = _x select 5; // return mission id
						_thispdamage = _x select 6; // return player damage
						_this_pdamage_head_hit = _x select 7; // return player head_hit damage					
						_this_pdamage_body = _x select 8; // return player body damage
						_this_pdamage_hands = _x select 9; // return player hands damage	
						_this_pdamage_legs = _x select 10; // return player legs damage	
						_thispdirection = _x select 11; // return player direction
						_thispstance = _x select 12; // return player stance
						_thispside = _x select 13; // return player side					
						_thispvehicle = _x select 14; // return players vehicle
						_thispseat = _x select 15; // return players vehicle seat
						
						_thisptype = _x select 16;							// returned type
						_thisprating = _x select 17;							// returned rating
						_thispviewdistance = _x select 18;					// viewdistance
						_thispterraindetail = _x select 19;					// terrain details
						_thisprank = _x select 20;							// rank
						_thispshotsfired = _x select 21;						// shots fired
						_thispenemykills = _x select 22;						// enemy kills
						_thispcivkills = _x select 23;						// civ kills
						_thispfriendlykills = data select 24;					// friendly kills
						_thispsuicides = data select 25;						// Suicide
						_thisplifestate = _data select 26;						// lifestate
						_thispdeaths = _data select 27;
						
						if (pdb_ace_enabled) then {
							_this_aceweapononback = _x select 30; // return player ace wob
							_this_aceruckweapons = _x select 31; // return player ace ruck weapons
							_this_aceruckmagazines = _x select 32; // return player ace ruck magazines
						};
						
						_length_position = [_x select 4] call CBA_fnc_strLen;  
					    _length_damage = [_x select 6] call CBA_fnc_strLen;	 
						_length_pdamage_head_hit = [_x select 7] call CBA_fnc_strLen; 
						_length_pdamage_body = [_x select 8] call CBA_fnc_strLen; 
					    _length_pdamage_hands = [_x select 9] call CBA_fnc_strLen; 
						_length_pdamage_legs = [_x select 10] call CBA_fnc_strLen;
						_length_pdirection = [_x select 11] call CBA_fnc_strLen; 
						_length_pstance = [_x select 12] call CBA_fnc_strLen; 
						_length_pside = [_x select 13] call CBA_fnc_strLen; 
						_length_pvehicle =  [_x select 14] call CBA_fnc_strLen; 
						_length_pseat =  [_x select 15] call CBA_fnc_strLen; 
						
						_length_ptype = [_x select 16] call CBA_fnc_strLen;						
						_length_prating = [_x select 17] call CBA_fnc_strLen;						
						_length_pviewdistance = [_x select 18] call CBA_fnc_strLen;			
						_length_pterraindetail = [_x select 19] call CBA_fnc_strLen;
						_length_prank = [_x select 20] call CBA_fnc_strLen;							
						_length_pshotsfired = [_x select 21] call CBA_fnc_strLen;				
						_length_penemykills = [_x select 22] call CBA_fnc_strLen;			
						_length_pcivkills = [_x select 23] call CBA_fnc_strLen;	
						_length_pfriendlykills = [_x select 24] call CBA_fnc_strLen;	
						_length_psuicides = [_x select 25] call CBA_fnc_strLen;	
						_length_plifestate = [_x select 26] call CBA_fnc_strLen;
						_length_pdeaths = [_x select 27] call CBA_fnc_strLen;							
						
						_length_weapons = [_x select 28] call CBA_fnc_strLen; 
						_length_magazines = [_x select 29] call CBA_fnc_strLen; 
						
						_length_aceweapononback = [_x select 30] call CBA_fnc_strLen; 
						_length_aceruckweapons = [_x select 31] call CBA_fnc_strLen; 
						_length_aceruckmagazines = [_x select 32] call CBA_fnc_strLen; 
				
						if (_length_damage > 2) then { _x set [6, parseNumber (_x select 6)]; _player setVariable ["damage", _x select 6, true]; } else {_x set [6, -1];};
						if (_length_pdamage_head_hit >2) then { _x set [7, parseNumber (_x select 7)]; _player setVariable ["head_hit", _x select 7, true]; } else {_x set [7, -1];};	
						if (_length_pdamage_body >2) then {  _x set [8, parseNumber (_x select 8)]; _player setVariable ["body", _x select 8, true]; } else {_x set [8, -1];};
						if (_length_pdamage_hands >2) then { _x set [9, parseNumber (_x select 9)]; _player setVariable ["hands", _x select 9, true]; } else {_x set [9, -1];};
						if (_length_pdamage_legs >2) then {	_x set [10, parseNumber (_x select 10)]; _player setVariable ["legs", _x select 10, true]; } else {_x set [10, -1];};
						if (_length_pdirection > 2) then { _x set [11, parseNumber (_x select 11)];} else {_x set [11, -1];};
						if (_length_pstance > 2) then { } else {_x set [12, "Stand"];};
						if (_length_pside > 2) then { } else {_x set [13, str(_playerSide)];};
						
						if (_length_pvehicle > 2) then { } else {_x set [14, ""];};
						if (_length_pseat > 2) then { } else {_x set [15, ""];};
						
						if (_length_position >2) then { _x set [4, [(_x select 4), "|", ","] call CBA_fnc_replace]; _x set [4, "[" + (_x select 4) + "]"]; _x set [4, call compile (_x select 4)];};	
						if (_length_position <2) then {  _x set [4, call compile (_x select 4)];  };	

						if  (_length_ptype > 2) then { } else {_x set [16,  typeof _player];};						
						if  (_length_prating > 2) then { _x set [17, parseNumber (_x select 17)];} else {_x set [17,0];};						
						if  (_length_pviewdistance > 2) then { _player setVariable ["viewdistance", parseNumber (_x select 18), true]; _x set [18, parseNumber (_x select 18)];} else {_x set [18,1600];};				
						if  (_length_pterraindetail > 0) then { _player setVariable ["pterraindetail", parseNumber (_x select 19), true]; _x set [19, parseNumber (_x select 19)];} else {_x set [19,2];};				
						if  (_length_prank > 2) then { _player setVariable ["prank", _x select 20, true];} else {_x set [20,  rank _player];};								
						if  (_length_pshotsfired > 0) then { _player setVariable ["_thispshotsfired", parseNumber (_x select 21), true]; _x set [21, parseNumber (_x select 21)]; } else {_x set [21,0];};			
						if  (_length_penemykills > 0) then { _player setVariable ["_thispenemykills", parseNumber (_x select 22), true];_x set [22, parseNumber (_x select 22)];} else {_x set [22,0];};		
						if  (_length_pcivkills > 0) then {_player setVariable ["_thispcivkills", parseNumber (_x select 23), true]; _x set [23, parseNumber (_x select 23)];} else {_x set [23,0];};
						if  (_length_pfriendlykills > 0) then {_player setVariable ["_thispfriendlykills", parseNumber (_x select 24), true]; _x set [24, parseNumber (_x select 24)];} else {_x set [24,0];};
						if  (_length_psuicides > 0) then {_player setVariable ["_thispsuicides", parseNumber (_x select 25), true]; _x set [25, parseNumber (_x select 25)];} else {_x set [25,0];};
						if  (_length_plifestate > 2) then { } else {_x set [26,  lifestate _player];};
						if  (_length_pdeaths > 0) then {_player setVariable ["_thispdeaths", parseNumber (_x select 27), true]; _x set [27, parseNumber (_x select 27)];} else {_x set [27,0];};
						
						if (_length_weapons > 2) then { _x set [28, [(_x select 28), "|", ","] call CBA_fnc_replace]; _x set [28, "[" + (_x select 28) + "]"]; _x set [28, call compile (_x select 28)];}else {_x set [28, []];};
						if (_length_magazines > 2) then { _x set [29, [(_x select 29), "|", ","] call CBA_fnc_replace]; _x set [29, "[" + (_x select 29) + "]"];_x set [29, call compile (_x select 29)];}else {_x set [29, []];};
						
						if (pdb_ace_enabled) then {
							if (_length_aceweapononback > 2) then { _player setVariable ["WOB", _x select 30, true]; }else {_x set [30, ""];};
							if (_length_aceruckweapons > 2) then { 	_player setVariable ["WEAPON", (_x select 30), true];  _x set [30, [(_x select 30), "|", ","] call CBA_fnc_replace]; _x set [30, "[" + (_x select 30) + "]"];_x set [30, call compile (_x select 30)]; }else {_x set [30, []];};
							if (_length_aceruckmagazines > 2) then { _player setVariable ["MAGAZINE", (_x select 31), true]; _x set [31, [(_x select 31), "|", ","] call CBA_fnc_replace]; _x set [31, "[" + (_x select 31) + "]"];_x set [31, call compile (_x select 31)];  }else {_x set [31, []];};
						};
						
						if (pdb_log_enabled) then {
							
							diag_log format["SERVER MSG: Welcome back, %1", _x select 1];
							diag_log format["SERVER MSG: Database player: %1 id: %2", _x select 1, _x select 0];
							diag_log format["SERVER MSG: Database player: %1 puid: %2", _x select 1, _x select 2];
							diag_log format["SERVER MSG: Database player: %1 name: %2", _x select 1, _x select 1];
							diag_log format["SERVER MSG: Database player: %1 score: %2", _x select 1, _x select 3];
							diag_log format["SERVER MSG: Database player: %1 mission id: %2", _x select 1, _x select 5];
							  
							if (_length_position >2) then { diag_log format["SERVER MSG: Database player: %1 teleported to coords, %2", _x select 1, _x select 4];};
							if (_length_damage > 2) then {	 diag_log format["SERVER MSG: Database player: %1 overall damage, %2", _x select 1, _x select 6];}; 
							if (_length_pdamage_head_hit > 2) then {	 diag_log format["SERVER MSG: Database player: %1 head damage, %2", _x select 1, _x select 7];};
							if (_length_pdamage_body > 2) then {	diag_log format["SERVER MSG: Database player: %1 body damage, %2", _x select 1, _x select 8];};
							if (_length_pdamage_hands > 2) then { diag_log format["SERVER MSG: Database player: %1 hand damage, %2", _x select 1, _x select 9];};
							if (_length_pdamage_legs > 2) then { diag_log format["SERVER MSG: Database player: %1 leg damage, %2", _x select 1, _x select 10];};
							if (_length_pdirection > 2) then { diag_log format["SERVER MSG: Database player: %1 direction: %2", _x select 1, _x select 11];};
							if (_length_pstance > 2) then {	diag_log format["SERVER MSG: Database player: %1 stance: %2", _x select 1, _x select 12];};
							if (_length_pside > 2) then { diag_log format["SERVER MSG: Database player: %1 side: %2", _x select 1, _x select 13];};
							if (_length_pvehicle > 2) then { diag_log format["SERVER MSG: Database player: %1 in vehicle: %2", _x select 1, _x select 14];};
							if (_length_pseat > 2) then { diag_log format["SERVER MSG: Database player: %1 in vehicle seat: %2", _x select 1, _x select 15];};
							
							if  (_length_ptype > 2) then {diag_log format["SERVER MSG: Database player: %1 type: %2", _x select 1, _x select 16];};	
							diag_log format["SERVER MSG: Database player: %1 rating: %2", _x select 1, _x select 17];
							diag_log format["SERVER MSG: Database player: %1 view distance: %2", _x select 1, _x select 18];
							diag_log format["SERVER MSG: Database player: %1 terrain detail: %2", _x select 1, _x select 19];
							//if  (_length_prating > 2) then {diag_log format["SERVER MSG: Database player: %1 rating: %2", _x select 1, _x select 22];};							
							//if  (_length_pviewdistance > 2) then {diag_log format["SERVER MSG: Database player: %1 viewdistance: %2", _x select 1, _x select 23];};				
							//if  (_length_pterraindetail > 2) then {diag_log format["SERVER MSG: Database player: %1 terraindetail: %2", _x select 1, _x select 24];};					
							if  (_length_prank > 2) then {diag_log format["SERVER MSG: Database player: %1 rank: %2", _x select 1, _x select 20];};	
							diag_log format["SERVER MSG: Database player: %1 shots fired: %2", _x select 1, _x select 21];
							diag_log format["SERVER MSG: Database player: %1 enemy kills: %2", _x select 1, _x select 22];
							diag_log format["SERVER MSG: Database player: %1 civilian kills: %2", _x select 1, _x select 23];
							//if  (_length_pshotsfired > 2) then {diag_log format["SERVER MSG: Database player: %1 shots fired: %2", _x select 1, _x select 26];};			
							//if  (_length_penemykills > 2) then {diag_log format["SERVER MSG: Database player: %1 enemy kills: %2", _x select 1, _x select 27];};			
							//if  (_length_pcivkills > 2) then {diag_log format["SERVER MSG: Database player: %1 civilian kills: %2", _x select 1, _x select 28];};					
							if  (_length_plifestate > 2) then {diag_log format["SERVER MSG: Database player: %1 lifestate: %2", _x select 1, _x select 24];};	
							
							if (_length_weapons >2) then {diag_log format["SERVER MSG: Database player: %1 weapons: %2", _x select 1, _x select 28];};	 
							if (_length_magazines >2) then { diag_log format["SERVER MSG: Database player: %1 magazines: %2", _x select 1, _x select 29];};
							
							if (_length_aceweapononback > 2) then {	diag_log format["SERVER MSG: Database player: %1 ace weapon on back: %2", _x select 1, _x select 30];};
							if (_length_aceruckweapons > 2) then { diag_log format["SERVER MSG: Database player: %1 ace ruck weapons: %2", _x select 1, _x select 31];};
							if (_length_aceruckmagazines > 2) then {	 diag_log format["SERVER MSG: Database player: %1 ace ruck magazines: %2", _x select 1, _x select 32];};
						
						};
						
						if (pdb_persistentScores_enabled) then {
							// convert player's score to number
							_dbScore =  _x select 3;
							_dbScore = parseNumber _dbScore;
							_newscore =  _dbScore;
						} else {
							_newscore = score _player; 
						};

						PDB_PLAYER_HANDLER = _x;
						publicVariable "PDB_PLAYER_HANDLER";
				};  // end if player in DB
						
			
			
			if (!_seen) then {  // if new player

		   _serverData = format["Creating player entry in database..."];
		   	PDB_CLIENT_LOADERSTATUS = [_player,_serverData]; publicVariable "PDB_CLIENT_LOADERSTATUS";
		   	
		   	if (pdb_globalScores_enabled) then {
		   		_player setVariable ["loadedPlayerScore", 0, true]; 
		   	};
		   	
			// set the players shots fired, kills, deaths, suicides - this variables are updated during game by eventhandlers or interaction
			_player setVariable ["_thispshotsfired", 0, true]; 
			_player setVariable ["_thispenemykills", 0, true]; 
			_player setVariable ["_thispcivkills", 0, true]; 
			_player setVariable ["_thispfriendlykills", 0, true]; 
			_player setVariable ["_thispsuicides", 0, true]; 
			_player setVariable ["_thispdeaths", 0, true]; 
			_player setVariable ["viewdistance", 1600, true]; 
			_player setVariable ["pterraindetail", 2, true];
			_player setVariable ["prank",rank _player, true];
			
		   	_newscore = score _player; 
		   	
		   	// get the player's spawn position
		   	_thisposition = str(getPosASL _player);
			_thisposition = [_thisposition, "[", ""] call CBA_fnc_replace; 
			_thisposition = [_thisposition, "]", ""] call CBA_fnc_replace; 
			_thisposition = [_thisposition, ",", "|"] call CBA_fnc_replace; 
			_pposition = _thisposition;
		   	
		   	// get the player's side
		   	_pside =  side _player;
		   	
				 _procedureName = "InsertPlayer"; _parameters = format["[tpid=%1,tna=%2,tmid=%3,tsid=%4,tpos=%5]",_puid,_pname,_missionid,_pside,_pposition];
					
			//	diag_log ("callExtension->Arma2NETMySQL: InsertPlayer");	
			  _response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
		
						
		}; // end  if new player


		_globalPlayerScore = 0;	
		if (pdb_globalScores_enabled) then {

		   _serverData = format["Loading player global score..."];
		   	PDB_CLIENT_LOADERSTATUS = [_player,_serverData]; publicVariable "PDB_CLIENT_LOADERSTATUS";
		   	
				 _procedureName = "GetGlobalScoreByPlayer"; _parameters = format["[tpid=%1]",_puid];
			//	diag_log ("callExtension->Arma2NETMySQL: GetGlobalScoreByPlayer");		
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
			//	diag_log ["callExtension->Arma2NETMySQL: GetGlobalScoreByPlayer _response: ",  _response, typeName _response];	
			    		
				

					_thisPlayerGlobalscore = _response;
				   _thisPSCount = count _thisPlayerGlobalscore;	
				   
				   	 for [{_r=0},{_r < _thisPSCount},{_r=_r+1}] do 	// START loop through all records
					{
					  _thisPSArray = _thisPlayerGlobalscore select _r ;    // copy the returned row into array
						  _thisPScore = _thisPSArray select 0;     //  returned pscore
						  _thisPScore = parseNumber _thisPScore;
						  _globalPlayerScore = _globalPlayerScore + _thisPScore;
					};
					
					_player setVariable ["globalPlayerScore", _globalPlayerScore, true];  
				
		  };
		  
		if (pdb_date_enabled) then {
				MISSIONDATE = date;
				publicvariable "MISSIONDATE";
		};
  _player setVariable ["playerSide", (side _player), true];
 [_player, _pname, _puid, _newscore, _globalPlayerScore, _seen] execVM "core\modules\persistentDB\updateScore.sqf";



	};  // END addPublicVariableEventHandler
	

	
		