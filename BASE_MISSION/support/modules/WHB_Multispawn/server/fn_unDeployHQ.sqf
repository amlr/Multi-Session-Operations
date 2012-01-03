// Function that the Server will call on FOB objects to unDeploy them into MHQs
// Author: WobbleyheadedBob aka CptNoPants
	
// Event No. 0 - Reset
// Event No. 1 - Start Deployment
// Event No. 2- Finnished Deployment
// Event No. 3 - Pack up
// Event No. 4 - finnished packup
private ["_fobHQ", "_locationHQ"];
_fobHQ = _this select 0;
_locationHQ = position _fobHQ;

// 3 - Pack up (Tell the clients)
PV_Client_SyncHQState = [3, _fobHQ];
publicvariable "PV_Client_SyncHQState";

if !isDedicated then {
	player sideChat format ["Packing up FOB HQ now..."];
};
_fobHQ removeAction 0;
_fobHQ removeAction 1;

[_fobHQ, _locationHQ] spawn {
	private ["_fobHQ","_mhq","_mhqType","_locationHQ","_deployAction"];
	_fobHQ = _this select 0;
	_locationHQ = _this select 1;
	_mhqType = switch(typeOf _fobHQ) do {
		case "LAV25_HQ_unfolded": {
			"LAV25_HQ";
		};
		case "M1130_HQ_unfolded_Base_EP1": {
			"M1130_CV_EP1";
		};
	};
	
	//Wait a while...
	sleep undeployment_Time;
	
	//Delete the FOBHQ and Remove from the list of active HQs
	deleteVehicle _fobHQ;
	PV_hqArray = PV_hqArray - [_fobHQ];
	publicvariable "PV_hqArray";

	//Create MHQ again and add it to the list of active HQs
	_mhq = createVehicle [_mhqType, _locationHQ, [], 0, "NONE"];
	_mhq setPos _locationHQ;
	_mhq setDir direction _fobHQ;
	PV_hqArray = PV_hqArray + [_mhq];
	publicvariable "PV_hqArray";

	// 4 - finnished packup (Tell the clients)
	PV_Client_SyncHQState = [4, _mhq];
	publicvariable "PV_Client_SyncHQState";
		
	if !isDedicated then {
		player sideChat format ["FOB HQ has now been packed up..."];
	};
	_deployAction = (_mhq addAction [("<t color=""#dddd00"">" + "Deploy FOB HQ" + "</t>"), "support\modules\WHB_Multispawn\common\fn_addAction_Deploy.sqf"]);

	// 0 - Reset (All done now tell the clients to reset their state listeners)
	sleep 1;
	PV_Client_SyncHQState = [0, ""];
	PV_Server_SyncHQState = [0, ""];
	publicvariable "PV_Client_SyncHQState";
};