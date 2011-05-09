// Script used by the Client to trigger a change in the HQ State
// The server listens for this event and begins the Deploy actions
// Author: WobbleyheadedBob aka CptNoPants

// Event No. 0 - Reset
// Event No. 1 - Deploy
// Event No. 2- Undeploy
private ["_hqObject","_locationHQ","_validSpeed","_validLocation"];
_hqObject = _this select 0;
_locationHQ = position _hqObject;

// Check that MHQ is NOT moving
if (speed _hqObject > 0) then {
	_validSpeed = false;
	player sideChat format ["MHQ must be stationary to deploy!"];
} else {
	_validSpeed = true;
};

// Check MHQ is NOT on the Water
if (surfaceIsWater _locationHQ) then {
	_validLocation = false;
	player sideChat format ["You cannot setup an HQ in the water!!!"];
} else {
	_validLocation = true;
};

// Check validation and perfom required actions.
if (_validSpeed && _validLocation) exitWith {
	if isServer then {
		[_hqObject] call fn_deployHQ;
	} else {
		PV_Server_SyncHQState = [1, _hqObject];
		publicvariable "PV_Server_SyncHQState";
	};
};