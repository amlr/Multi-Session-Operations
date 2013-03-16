private ["_hcData","_serverData"];

//Default values for params and needed variables
if (isnil "CQB_spawn") then {CQB_spawn = 10};
//Set default values and check if turned on
if (CQB_spawn == 0) exitwith {diag_log format["MSO-%1 CQB Population turned off! Exiting...", time]};
if (isnil "isHC") then {call mso_core_fnc_isHC};
if (isnil "CQBlocality") then {CQBlocality = 1};
if (isnil "CQBspawnrange") then {CQBspawnrange = 500};
if (isnil "CRB_LOC_DIST") then {CRB_LOC_DIST = (getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition") select 0) * 2.8};

//Static params
CQBmaxgrps = 144;
CQB_AUTO = true;
CQBaiBroadcast = true;
_debug = debug_mso;

switch (CQBlocality) do {
    case 0: {CQB_HC_active = false; CQBclientside = false};
    case 1: {CQB_HC_active = false; CQBclientside = true};
	case 2: {CQB_HC_active = true; CQBclientside = true;};
	default {CQB_HC_active = false; CQBclientside = true};
};

//Starting
diag_log format["MSO-%1 CQB Population: starting to load functions...", time];
if (persistentDBHeader == 1 && {isHC}) then {
	// CQB
	if (CQBlocality > 1) then {
		diag_log format["MSO-%1 Headless Client: %2, waiting for PDB_CQB_positionsloaded...", time, player];
		waituntil {!(isnil "PDB_CQB_positionsloaded")};
	};	
};
if (((CQBlocality > 1) && (isHC) && (persistentDBHeader == 1))) then {
	_hcData = format["Headless client is loading CQB functions please wait..."];
	PDB_HEADLESS_LOADERSTATUS = [_hcData]; publicVariable "PDB_HEADLESS_LOADERSTATUS";
};
	
if (isnil "BIN_fnc_taskDefend") then {BIN_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskDefend.sqf"};
if (isnil "BIN_fnc_taskPatrol") then {BIN_fnc_taskPatrol = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskPatrol.sqf"};
if (isnil "BIN_fnc_taskSweep") then {BIN_fnc_taskSweep = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskSweep.sqf"};
if (isnil "MSO_fnc_CQBclientloop") then {MSO_fnc_CQBclientloop = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\MSO_fnc_CQBclientloop.sqf"};
if (isnil "CQB_findnearhousepos") then {CQB_findnearhousepos = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\CQB_findnearhousepos.sqf"};
if (isnil "CQB_setposgroup") then {CQB_setposgroup = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\CQB_setposgroup.sqf"};
if (isnil "CQB_houseguardloop") then {CQB_houseguardloop = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\CQB_houseguardloop.sqf"};
if (isnil "CQB_patrolloop") then {CQB_patrolloop = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\CQB_patrolloop.sqf"};
if (isnil "MSO_fnc_CQBspawnRandomgroup") then {MSO_fnc_CQBspawnRandomgroup = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\MSO_fnc_CQBspawnRandomgroup.sqf"};
if (isnil "MSO_fnc_CQBmovegroup") then {MSO_fnc_CQBmovegroup = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\MSO_fnc_CQBmovegroup.sqf"};
if (isnil "MSO_fnc_getEnterableHouses") then {MSO_fnc_getEnterableHouses = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\MSO_fnc_getEnterableHouses.sqf"};
if (isnil "MSO_fnc_CQBgetSpawnpos") then {MSO_fnc_CQBgetSpawnpos = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\MSO_fnc_CQBgetSpawnpos.sqf"};
if (isnil "MSO_fnc_CQBhousepos") then {MSO_fnc_CQBhousepos = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\MSO_fnc_CQBhousepos.sqf"};
if (isnil "getGridPos") then {getGridPos = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\getGridPos.sqf"};
if (isnil "CQB_GCS") then {CQB_GCS = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\CQB_GCS.sqf"};
if (isnil "CQB_PlayersGroundCheck") then {call compile preprocessFileLineNumbers "enemy\modules\CQB_POP\functions\CQB_PlayersGroundCheck.sqf"};
diag_log format["MSO-%1 CQB Population: loaded functions...", time];

if (CQB_HC_active) then {

	if (isDedicated) exitwith {[] spawn CQB_GCS; diag_log format ["MSO-%1 CQB Populator exiting on server (HC active - GCS activated)... - HC is active!",time]};
	if !(player in headlessClients) exitwith {diag_log format ["MSO-%1 CQB Populator running on client - Exiting...",time]};

	if (persistentDBHeader == 1) then {	
			waituntil {!(isnil "PDB_CQB_positionsloaded")};
	};

	if (((CQBlocality > 1) && (isHC) && (persistentDBHeader == 1))) then {
			_hcData = format["Headless client is registering CQB positions please wait..."];
		   PDB_HEADLESS_LOADERSTATUS = [_hcData]; publicVariable "PDB_HEADLESS_LOADERSTATUS";
	};

	if ((isnil "CQBpositionsReg") || (isnil "CQBpositionsStrat")) then {
			CQBpositionsStrat = ["strategic"] call MSO_fnc_CQBgetSpawnpos;
			CQBpositionsReg = ["regular"] call MSO_fnc_CQBgetSpawnpos;
		
		Publicvariable "CQBpositionsStrat";
		Publicvariable "CQBpositionsReg";
	} else {
		if ((count CQBpositionsReg + count CQBpositionsReg) == 0) then {
			CQBpositionsStrat = ["strategic"] call MSO_fnc_CQBgetSpawnpos;
			CQBpositionsReg = ["regular"] call MSO_fnc_CQBgetSpawnpos;
			
			Publicvariable "CQBpositionsStrat";
			Publicvariable "CQBpositionsReg";
		};
	};

	[_debug] spawn MSO_fnc_CQBclientloop;
    
    // Output sidechat to inform admin that CQB has finished (as it is called after clicking continue on mapscreen)
	[-1, {if (servercommandavailable "#kick") then {player sidechat _this}}, format["MSO CQB INIT FINISHED! Collected %1 spawnpositions!",((count CQBpositionsStrat) + (count CQBpositionsReg))]] call CBA_fnc_globalExecute;

} else {

	if (isServer) then {

		if (persistentDBHeader == 1) then {	
				waituntil {!(isnil "PDB_CQB_positionsloaded")};
		};

				if ((CQBlocality == 0) && (persistentDBHeader == 1)) then {
						_serverData = format["Server is registering CQB positions please wait..."];
						PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
				};
		

		if ((isnil "CQBpositionsReg") || (isnil "CQBpositionsStrat")) then {
			CQBpositionsStrat = ["strategic"] call MSO_fnc_CQBgetSpawnpos;
			CQBpositionsReg = ["regular"] call MSO_fnc_CQBgetSpawnpos;
			
			Publicvariable "CQBpositionsStrat";
			Publicvariable "CQBpositionsReg";
		} else {
			if ((count CQBpositionsReg + count CQBpositionsReg) == 0) then {
				CQBpositionsStrat = ["strategic"] call MSO_fnc_CQBgetSpawnpos;
				CQBpositionsReg = ["regular"] call MSO_fnc_CQBgetSpawnpos;
					
				Publicvariable "CQBpositionsStrat";
				Publicvariable "CQBpositionsReg";
			};
		};

		[] spawn CQB_GCS;
        
        // Output sidechat to inform admin that CQB has finished (as it is called after clicking continue on mapscreen)
		[-1, {if (servercommandavailable "#kick") then {player sidechat _this}}, format["MSO CQB INIT FINISHED! Collected %1 spawnpositions!",((count CQBpositionsStrat) + (count CQBpositionsReg))]] call CBA_fnc_globalExecute;
	};

	//Locality Check
	if (CQBclientside) then {
		if !(isDedicated) then {
			[_debug] spawn MSO_fnc_CQBclientloop;
		};
	} else {
		if (isServer) then {
			[_debug] spawn MSO_fnc_CQBclientloop;
		};
	};
};
