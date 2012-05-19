/* 
 * Filename:
 * init.sqf 
 *
 * Description:
 * Runs on server and client
 * 
 * Created by [KH]Jman
 * Creation date: 31/12/2011
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */
 

if(isNil "persistentDBHeader")then{persistentDBHeader = 1;};

if(persistentDBHeader == 0) exitWith{diag_log format ["MSO-%1 Persistent DB Disabled - Exiting.",time];};

// ====================================================================================
// DEFINES
	#define PP preprocessfilelinenumbers
	#define VAR_DEFAULT(var,val) if (isNil #var) then {var=(val);}
// ====================================================================================	
// PDB SETUP	
	_pdbsettings = [] execVM "core\modules\persistentDB\pdbSetup.sqf";
	waitUntil {scriptDone _pdbsettings};
	diag_log["PersistentDB: pdb settings loaded"];
	PDB_PLAYER_HANDLED = false;
	diag_log format ["############################# %1 #############################", pdb_fullmissionName];
	[] call compile PP "core\modules\persistentDB\system.sqf";
	pdb_serverError = 0;
	pdb_clientError = 0;
	if (isdedicated) then {	ENV_dedicated = true; publicVariable "ENV_dedicated"; onPlayerConnected {[_id, _name, _uid] call compile PP "core\modules\persistentDB\playerConnected.sqf"}; onPlayerDisconnected { [_id, _name, _uid] call compile PP "core\modules\persistentDB\playerDisconnected.sqf" }; };
	if (isServer) then { publicVariable "MISSIONDATA_LOADED";  if (isNil "MISSIONDATA_LOADED") then {	MISSIONDATA_LOADED = "false";  publicVariable "MISSIONDATA_LOADED"; 	}; };
    persistent_fnc_playerDamage = compile PP "core\modules\persistentDB\playerDamage.sqf";
    persistent_fnc_playerHeal = compile PP "core\modules\persistentDB\playerHeal.sqf";
    persistent_fnc_playerRespawn = compile PP "core\modules\persistentDB\playerRespawn.sqf";
	if (!isdedicated) then { VAR_DEFAULT(ENV_dedicated, false); };
// ====================================================================================
// PDB STARTUP
   if ((!isServer) && (player != player)) then { waitUntil {player == player};};
	if ((!isServer) || (!isdedicated)) then {	
		[] spawn {  
	    	waitUntil { !(isNull player) };			
			sleep 0.2;
			diag_log["PersistentDB: SPAWN"];
			if  (ENV_dedicated) then { startLoadingScreen ["Please wait setting up client...", "PDB_loadingScreen"];	 };
			player setVariable ["BIS_noCoreConversations", true];
			player addeventhandler ["Dammaged", { _this call persistent_fnc_playerDamage; } ];
			player addeventhandler ["animChanged", { _this call persistent_fnc_playerHeal; } ];
			player addeventhandler ["Respawn", { _this call persistent_fnc_playerRespawn; } ];
			player allowdamage false;
		    processInitCommands;
			finishMissionInit;
			waituntil { (PDB_PLAYERS_CONNECTED select 0 == "000000") };  // wait until server has finished loading data
			waituntil {time > 3};
			_thistime = time; waituntil { time > (random 5) + _thistime };
			diag_log["PersistentDB: FINISHED MISSION INIT, time: ", time];
			if  (ENV_dedicated) then { startLoadingScreen ["Server is loading persistent mission data please standby...", "PDB_loadingScreen"]; };
			waituntil { (MISSIONDATA_LOADED == "true") };
			PDB_PLAYER_READY = [getPlayerUID player, player, name player, playerside];
			publicVariable "PDB_PLAYER_READY";
			if  (ENV_dedicated) then { startLoadingScreen ["Client is loading persistent player data...", "PDB_loadingScreen"]; };
			diag_log["PersistentDB: PLAYER READY"];
		};
	};
// ====================================================================================