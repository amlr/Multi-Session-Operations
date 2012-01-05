// Initialises the FOB Multi-Spawn System
// Author: WobbleyheadedBob aka CptNoPants

// Server


if isServer then {
	private ["_initMHQs"];
        if (isNil "PV_Server_SyncHQState") then {
		// set the nil variable with a default value for server and both JIP & 'join at mission start' 
		PV_Server_SyncHQState = [0, ""]; 
	};
	publicvariable "PV_Server_SyncHQState";
	//_initMHQs = [vehicles] execVM "support\modules\WHB_Multispawn\server\init_Server_MHQs.sqf";

	_initMHQs = [vehicles] call compile preprocessFile "support\modules\WHB_Multispawn\server\init_Server_MHQs.sqf";
	
	//Removing this as I dont think its necessary here, need to test !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	//publicvariable "PV_hqArray";
	
	// Function that the Server will call on MHQ objects to deploy them into Static FOB HQs
	fn_DeployHQ = compile preprocessFileLineNumbers "support\modules\WHB_Multispawn\server\fn_DeployHQ.sqf";
	
	// Function that the Server will call on FOB objects to unDeploy them into MHQs
	fn_unDeployHQ = compile preprocessFileLineNumbers "support\modules\WHB_Multispawn\server\fn_unDeployHQ.sqf";
	
	// Simple and slightly redundant function that determines which HQ Fuction to call based on the 'State' sent in from a client
	// I've done it this way as I will be adding more actions to the MHQ at a later date and this simplifies the code a little...
	fn_Server_SyncHQState = compile preprocessFileLineNumbers "support\modules\WHB_Multispawn\server\fn_Server_SyncHQState.sqf";
	
	"PV_Server_SyncHQState" addPublicVariableEventHandler {(_this select 1) call fn_Server_SyncHQState;};
	
    if !isDedicated then {
		// Initialise the default spawn location
		[] execvm "support\modules\WHB_Multispawn\common\init_Client_DefaultSpawnLocations.sqf";
		
		//local player
		//_dummy = [] execvm "support\modules\WHB_Multispawn\common\init_Client_DefaultSpawnLocations.sqf"
		
		// Event Handler that calls the player relocation on respawn (For host machines)
		player addEventhandler ["respawn", {[player] call fn_playerRespawn}];
    };

// Non-server clients
} else {
	// Initialise the default spawn location
	[] execvm "support\modules\WHB_Multispawn\common\init_Client_DefaultSpawnLocations.sqf";
	
	if (isNil "PV_Client_SyncHQState") then
	{
	  // set the nil variable with a default value for server and both JIP & 'join at mission start' 
	  PV_Client_SyncHQState = [0, ""]; 
	};
	
	// Function that gets called on Client when the Server updates the state of an HQ
	fn_Client_SyncHQState = compile preprocessFileLineNumbers  "support\modules\WHB_Multispawn\common\fn_Client_SyncHQState.sqf";
	
	// PublicVariable eventhandler to catch the message sent by the server.
	"PV_Client_SyncHQState" addPublicVariableEventHandler {(_this select 1) call fn_Client_SyncHQState};
	
	// Event Handler that calls the player relocation on respawn (for Clients)
	player addEventhandler ["respawn", {[player] call fn_playerRespawn}];
};

// All Machines
fn_playerRespawn = compile preprocessFileLineNumbers "support\modules\WHB_Multispawn\common\fn_playerRespawn.sqf";