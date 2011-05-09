// Function that the Server will call on MHQ objects to deploy them into Static FOB HQs
// Author: WobbleyheadedBob aka CptNoPants

// Event No. 0 - Reset
// Event No. 1 - Start Deployment
// Event No. 2- Finnished Deployment
// Event No. 3 - Pack up
// Event No. 4 - finnished packup
private ["_mhq","_locationHQ","_camotype","_camo"];

_mhq = _this select 0;
_locationHQ = position _mhq;
_camotype = "Land_CamoNetB_NATO";

// 1 - Start Deployment (Tell the clients)
PV_Client_SyncHQState = [1, _mhq];
publicvariable "PV_Client_SyncHQState";

//Remove the deploy action to prevent double-deployment and empty the fuel
if !isDedicated then {
	player sideChat format ["Setting up FOB HQ now..."];
	_mhq removeAction 0;
};

_mhq setFuel 0;

//Create the Cammo Net
_camo = createVehicle [_camotype, _locationHQ, [], 0, "NONE"];
_camo setPos _locationHQ;
_camo setDir direction _mhq;
_camo allowDamage false;

//Wait a while...
[_mhq, _locationHQ, _camo] spawn {
	private ["_mhq","_locationHQ","_camo","_fobHQtype","_signInAction","_undeployAction","_fobHQ"];
	_mhq = _this select 0;
	_locationHQ = _this select 1;
	_camo = _this select 2;
	_fobHQtype = "LAV25_HQ_unfolded";
	
	//Wait a while - Parameter Specified Setup Delay
	sleep deployment_Time;

	//Delete the Cammo Net and MHQ, then create the static FOB HQ
	deleteVehicle _camo;
	deleteVehicle _mhq;
	
	//Remove the MHQ from the list of active HQs
	PV_hqArray = PV_hqArray - [_mhq];
	publicvariable "PV_hqArray";
	
	_fobHQ = createVehicle [_fobHQtype, _locationHQ, [], 0, "NONE"];
	_fobHQ setPos _locationHQ;
	_fobHQ setDir direction _mhq;
	
	//Add the new FOB to the list of active HQ's
	PV_hqArray = PV_hqArray + [_fobHQ];
	publicvariable "PV_hqArray";

	// 2 - Finnished Deployment (Tell the clients)
	PV_Client_SyncHQState = [2, _fobHQ];
	publicvariable "PV_Client_SyncHQState";
	
	//##ifdef##
	//[_fobHQ, 20.025, 81.025, 20000] call acre_api_fnc_attachRxmtToObj;

	if !isDedicated then {
	player sideChat format ["FOB HQ has now been setup..."];
	_signInAction = (_fobHQ addAction [("<t color=""#dddd00"">" + "Sign in at FOB" + "</t>"), "support\modules\FOB_spawn\common\fn_addAction_SignInFOB.sqf"]);
	_undeployAction = (_fobHQ addAction [("<t color=""#dddd00"">" + "Pack up FOB HQ" + "</t>"), "support\modules\FOB_spawn\common\fn_addAction_unDeploy.sqf"]);
	};
	
	// 0 - Reset (All done now tell the clients to reset their state listeners)
	sleep 1;
	PV_Client_SyncHQState = [0, ""];
	PV_Server_SyncHQState = [0, ""];
	publicvariable "PV_Client_SyncHQState";
};