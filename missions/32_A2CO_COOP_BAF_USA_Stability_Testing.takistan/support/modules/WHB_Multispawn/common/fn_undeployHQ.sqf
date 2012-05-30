/********************************************************************************************************
Name: fn_undeployHQ 
Parameters: HQ Object
Example: [hqObject] call fn_undeployHQ;
Return Value: Array of Error/Success Strings
Description: Packs the static structure up back into a mobile vehicle.
Author: WobbleyheadedBob aka CptNoPants
********************************************************************************************************/
private ["_fobHQ","_returnMessage","_fobHQState"];

_fobHQ = _this select 0;
_fobHQState = _fobHQ getVariable "MHQState";
_returnMessage = [];

// DEBUG - Check for null stateVariable
if (isNil "_fobHQState") exitWith
{
	_returnMessage = ["MHQState is null..."];
	_returnMessage;
};

switch (_fobHQState) do
{
	case 0: // State No. 0 - Mobile/Undeployed
	{
		_returnMessage = ["MHQ is already Mobile!"];
	};
	//-------------------------------------------------------------------------------------------------
	case 1: // State No. 1 - Deployed
	{
		//Set state to packing up 
		_fobHQ setVariable ["MHQState", 3, true];
		_returnMessage = ["Packing up FOB HQ now..."];
		
		//Use createFOB locally if you're a hosting player else, use PV service bus
		if isServer then {
			[_fobHQ] spawn 
			{
				private ["_fobHQ"];
				_fobHQ = _this select 0;
				[_fobHQ] call fn_removeFOB;
			};
		} else {
			PV_server_syncHQState = [3, _fobHQ];
			publicvariable "PV_server_syncHQState";
		};
	};
	//-------------------------------------------------------------------------------------------------
	case 2: // State No. 2 - Deploying
	{
		_returnMessage = ["MHQ is currently deploying!"];
	};
	//-------------------------------------------------------------------------------------------------
	case 3: // State No. 3 - Undeploying/Packing up
	{
		_returnMessage = ["MHQ is already packing up!"];
	};
	//-------------------------------------------------------------------------------------------------
	Default 
	{
		_returnMessage = ["Unrecognised MHQState"];
	};
};

_returnMessage