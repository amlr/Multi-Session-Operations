/* 
* Filename:
* playerDisconnected.sqf 
*
* Description:
* Called from init.sqf
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

private ["_id", "_pname", "_puid", "_player", "_missionid", "_thisPlayerData", "_thisdata", "_thisWeaponData", "_thisACEData", "_params", "_parameters", "_i", "_procedureName", "_response", "_thisObject", "_landVehicles", "_landVehicleCount", "_missionLandVehicles", "_vDir", "_vUp", "_vDam", "_vPosition", "_vObject", "_vFuel", "_vLocked", "_vWeaponCargo", "_vEngine", "_result", "_thisObjectData", "_object", "_date"];

_id = _this select 0; 
_pname = _this select 1; 
_puid  = _this select 2; 

_missionid = (MISSIONDATA select 1);

saveOnQuit = {	
	
	if (_pname != "__SERVER__") then {

		_player = objNull;
		{
			
			if (pdb_log_enabled) then {
				diag_log format["SERVER MSG: Loop. %1", getPlayerUID _x];
			};	
			
			if (getPlayerUID _x == _puid) exitWith {
				
				if (pdb_log_enabled) then {		
					diag_log format["SERVER MSG: Loop break. %1", getPlayerUID _x];
				};
				
				_player = _x;
			};

		} forEach playableUnits; // Return a list of playable units (occupied by both AI or players) in a multiplayer game. 
		
		if !(isNull _player) then {	
					
			// for each persistence type get and save data
			{
				private ["_type","_typestring","_procedure"];
				// Get data for object from client
				_typestring = _x;
				call compile format ["_type = %1",_typestring];
				_thisClientData = [_player, _type] call persistent_fnc_getData;
				// Set stored procedure to be called
				call compile format["_procedure = %1_PROCEDURE",_typestring];
				// Set parameters to be passed to stored procedure
				call compile format["_params = %1_PARAMS",_typestring];
				// Set id params for client get data call
				_idparams = format["tpid=%1,tna=%2,tmid=%3", _puid, _pname, _missionid];
				// Save Data to DB
				_response = [_thisClientData,_params,_procedure,_idparams] call persistent_fnc_saveData;
			} foreach PDB_CLIENT_GET_DATA;
	
		} else {
			// player not found!
			if (pdb_log_enabled) then {
				diag_log format["SERVER MSG: Player %1, not found in playableUnits!, frame Number: %2, Tick: %3, Time: %4", _pname, diag_frameno, diag_tickTime, time];
			};
		};
		
	} else {
		
	// __SERVER__ : 
	// This is a bit of a mess right now

	_missionid = (MISSIONDATA select 1);

	if (pdb_landvehicles_enabled) then {
		
		// START remove mission's current LandVehicles data				
		
		_procedureName = "RemoveLandVehicles"; 
		_parameters = format["[tmid=%1]",_missionid];
		
		if (pdb_log_enabled) then {
			diag_log format["SERVER MSG: SQL output: %1", _parameters];
		};
	
		_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
		
		// END remove mission's current LandVehicles data						
		
		// START save mission's LandVehicles data
		_procedureName = "InsertLandVehicles"; 
				
		// get LandVehicle data
		_thisObject = objNull;
		_landVehicles = [];
		_landVehicleCount = 1;
		_missionLandVehicles = "";
		{
			_thisObject = _x;
							
			_vDir = [0,0,0];
			_vUp = [0,0,0];
			_vDam = 0;
			_vPosition = [];
			
			if ([str(_thisObject),"REMOTE"] call CBA_fnc_find == -1) then {

				_vObject = str _thisObject;

				_vPosition = str(getPosATL _thisObject); // setPosATL
				_vDam = str(getDammage _thisObject); // setDammage
				_vDir = str(vectorDir _thisObject); // setVectorDirAndUp
				_vUp = str(vectorUp _thisObject); //   setVectorDirAndUp
				_vFuel = str(fuel _thisObject);  // setFuel
				_vLocked = str(locked _thisObject); // Lock  || setVehicleLock ?
				_vWeaponCargo = str(getWeaponCargo _thisObject); // addWeaponCargo 
				_vEngine = str(isEngineOn _thisObject); // engineOn
				_vMagazineCargo = str(getMagazineCargo _thisObject); // addMagazineCargo	
				
				_vPosition = [_vPosition, ",", "|"] call CBA_fnc_replace;
				_vDir = [_vDir, ",", "|"] call CBA_fnc_replace;
				_vUp = [_vUp, ",", "|"] call CBA_fnc_replace;
				_vWeaponCargo = [_vWeaponCargo, ",", "|"] call CBA_fnc_replace; 	
				_vMagazineCargo = [_vMagazineCargo, ",", "|"] call CBA_fnc_replace; 		
								
				_parameters = format["[tobj=%1,tpos=%2,tdir=%3,tup=%4,tdam=%5,tfue=%6,tlkd=%7,twcar=%8,teng=%9,twmag=%10,tmid=%11,tintid=%12]",_vObject, _vPosition, _vDir, _vUp, _vDam, _vFuel, _vLocked, _vWeaponCargo, _vEngine, _vMagazineCargo, _missionid, _landVehicleCount];
				
				if (pdb_log_enabled) then {
					diag_log format["SERVER MSG: SQL output: %1", _parameters];
				};
				
				//	diag_log ("callExtension->Arma2NETMySQL: InsertLandVehicles");		
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
				
				_landVehicleCount =_landVehicleCount+1;
			};
			
		} forEach vehicles; 
		
		// END save mission's LandVehicles data			
		
	};
			
	// Store Mission Objects
	// For each object, get object data, convert to DB format, store in array to be passed to DB function
	if (pdb_objects_enabled) then {
		
		// START remove mission's current objects data				
		
		_procedureName = "RemoveObjects"; 
		_parameters = format["[tmid=%1]",_missionid];
		
		if (pdb_log_enabled) then {
			diag_log format["SERVER MSG: SQL output: %1", _parameters];
		};
	
		_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
		
		// END remove mission's current object data						
		
		// START save mission's Object data
		_procedureName = "InsertObjects"; 
		
		// Set list of objects to look for (based on R3F)
		_objectType = "static";
		
		// get Object data
		_thisObject = objNull;
		_objects = [];
		_objectCount = 1;
		_missionObjects = "";
		{

			_thisObject = _x;
			// Check to see if object should be persisted (i.e. a var name has been set)
			if ([str(_thisObject),"REMOTE"] call CBA_fnc_find == -1) then {

				_vDir = [0,0,0];
				_vUp = [0,0,0];
				_vDam = 0;
				_vPosition = [];
				
				_vObject = str(_thisObject);
				//if ([_vObject,"p3d"] call CBA_fnc_find != -1) then {
					// object has been created since mission start and does not have varname - store class instead
				//	_vObject = typeof _thisObject;
				//};
				_vPosition = str(getPosATL _thisObject); // setPosATL
				_vDam = str(getDammage _thisObject); // setDammage
				_vDir = str(vectorDir _thisObject); // setVectorDirAndUp
				_vUp = str(vectorUp _thisObject); //   setVectorDirAndUp
				_vWeaponCargo = str(getWeaponCargo _thisObject); // addWeaponCargo 
				_vMagazineCargo = str(getMagazineCargo _thisObject); // addMagazineCargo
				//_vR3FTransportedBy = _thisObject getVariable "R3F_LOG_est_transporte_par";
				//_vR3FMovedBy = _thisObject getVariable "R3F_LOG_est_deplace_par";
		
				_vPosition = [_vPosition, ",", "|"] call CBA_fnc_replace;
				_vDir = [_vDir, ",", "|"] call CBA_fnc_replace;
				_vUp = [_vUp, ",", "|"] call CBA_fnc_replace;
				_vWeaponCargo = [_vWeaponCargo, ",", "|"] call CBA_fnc_replace; 	
				_vMagazineCargo = [_vMagazineCargo, ",", "|"] call CBA_fnc_replace; 			
						
				_parameters = format["[tobj=%1,tpos=%2,tdir=%3,tup=%4,tdam=%5,twcar=%6,twmag=%7,tmid=%8,tintid=%9]",_vObject, _vPosition, _vDir, _vUp, _vDam, _vWeaponCargo, _vMagazineCargo, _missionid,_ObjectCount];
				
				if (pdb_log_enabled) then {
					diag_log format["SERVER MSG: SQL output: %1", _parameters];
				};
				
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
				
				_objectCount =_objectCount+1;
			};
		} forEach allmissionobjects _objectType; 
		
		// END save mission's Object data			
		
	};
		
	// START save the time and date
	if (pdb_date_enabled) then {
		
		_date = [date, "write"] call persistent_fnc_convertFormat;
		
		_procedureName = "UpdateDate";
		_parameters = format["[tda=%1,tmid=%2]",_date,_missionid]; 
		
		if (pdb_log_enabled) then {
			diag_log format["SERVER MSG: SQL output: %1", _parameters];
		};
				
		//	diag_log ("callExtension->Arma2NETMySQL: UpdateDate");		
		_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
		
	};
	// END save the time and date		

	// __SERVER__ exit

	if (pdb_log_enabled) then {
		diag_log format["SERVER MSG: %1 exiting, frame Number: %2, Tick: %3, Time: %4", _pname, diag_frameno, diag_tickTime, time];
	};
	exit;	
			
	};
};
// ====================================================================================
// MAIN	

if (pdb_log_enabled) then {
	diag_log format["SERVER MSG: Player %1, is leaving the server, frame Number: %2, Tick: %3, Time: %4", _pname, diag_frameno, diag_tickTime, time];
};

call saveOnQuit;



// ====================================================================================