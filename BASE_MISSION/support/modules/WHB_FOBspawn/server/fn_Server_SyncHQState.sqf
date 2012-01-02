// Determines what action to call based on the State passed in by a client
// Simple and slightly redundant but I've done it this way as I will be adding 
// more actions to the MHQ at a later date and this simplifies the code a little...
// Author: WobbleyheadedBob aka CptNoPants

private ["_hqObject","_hqState"];
_hqState = _this select 0;
_hqObject = _this select 1;

// Event No. 0 - Reset
// Event No. 1 - Deploy
// Event No. 2- Undeploy

switch (_hqState) do
{
//-------------------------------------------------------------------------------------------------
	case 0: // Reset
	{
		//Do nothing, we're just resetting the state, don't think I actually need to do this... :P
	};
//-------------------------------------------------------------------------------------------------
	case 1: // Deploy
	{
		[_hqObject] call fn_deployHQ;
	};
//-------------------------------------------------------------------------------------------------
	case 2: // Undeploy
	{
		[_hqObject] call fn_undeployHQ;
	};
//-------------------------------------------------------------------------------------------------
	Default 
	{
		//Do nothing but... wtf state did you enter???
	};
};