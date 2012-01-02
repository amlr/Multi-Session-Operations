// Script used by the Client to trigger a change in the HQ State
// The server listens for this event and begins the unDeploy actions
// Author: WobbleyheadedBob aka CptNoPants

// Event No. 0 - Reset
// Event No. 1 - Deploy
// Event No. 2- Undeploy
private ["_hqObject"];
_hqObject = _this select 0;

if isServer then {
	[_hqObject] call fn_undeployHQ;
} else {
	PV_Server_SyncHQState = [2, _hqObject];
	publicvariable "PV_Server_SyncHQState";
};