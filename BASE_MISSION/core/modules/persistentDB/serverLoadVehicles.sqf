// Load Vehicles

private ["_procedureName", "_parameters", "_missionid", "_response", "_landVehicleCountInDB", "_serverData", "_countInDB", "_z", "_thisID", "_landVehicleData", "_vObject", "_tmp", "_thisVehicle", "_vPosition", "_vDir", "_vUp", "_vDam", "_vFuel", "_vLocked", "_vWeaponCargo", "_vEngine"];

_missionid = _this select 0;

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
	
	_parameters = format["[tintid=%1,tmid=%2]", _thisID,_missionid];
	
	if (pdb_log_enabled) then {
		diag_log format["SERVER MSG: SQL output: %1", _parameters];
	};
	
	//	diag_log ("callExtension->Arma2NETMySQL: GetLandVehicleByInitid");		
	_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
	//	diag_log ["callExtension->Arma2NETMySQL: GetLandVehicleByInitid _response: ",  _response, typeName _response];
		
	_landVehicleData	= _response select 0;    // copy the returned row into array
	
	//	diag_log ["GetLandVehicleByInitid _landVehicleData: ",  _landVehicleData, typeName _landVehicleData];
	
	_vObject =_landVehicleData select 1;
	
	//diag_log ["_vObject: ",  _vObject, typeName _vObject];
	
	// Convert string to Object
		private "_tmp";
		call compile format ["_tmp = %1",_vObject];
		_thisVehicle = _tmp;

		//diag_log ["_thisVehicle: ",  _thisVehicle, typeName _thisVehicle];
		
		//_serverData = format["Loading land vehicle: %1...", _thisVehicle];
		//PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
		
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
		
		//										diag_log ["_vEngine: ",  _vEngine, typeName _vEngine]
		
		_vMagazineCargo = _objectData select 10;
		_vMagazineCargo = [_vMagazineCargo, "|", ","] call CBA_fnc_replace; 
		_vMagazineCargo = call compile _vMagazineCargo;	
		
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
		_thisObject addMagazineCargo _vMagazineCargo;
		// set the vehicles engine 
		_thisVehicle engineOn _vEngine;

	
};