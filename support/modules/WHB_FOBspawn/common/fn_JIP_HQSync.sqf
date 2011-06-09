// Function used to Add all the necessary actions to HQs that are active on the server
// this needs to be done as HQ's could have been deployed/undeployed while the client was offline
// Author: WobbleyheadedBob aka CptNoPants

private ["_vehicles"];
_vehicles = _this select 0;

{
	switch (typeOf _x) do
	{
	//-------------------------------------------------------------------------------------------------
		case "LAV25_HQ":
		{
			_x addAction [("<t color=""#dddd00"">" + "Deploy FOB HQ" + "</t>"), "support\modules\WHB_FOBspawn\common\fn_addAction_Deploy.sqf"]; 
		};
	//-------------------------------------------------------------------------------------------------
		case "LAV25_HQ_unfolded":
		{
			_x addAction [("<t color=""#dddd00"">" + "Sign in at FOB" + "</t>"), "support\modules\WHB_FOBspawn\common\fn_addAction_SignInFOB.sqf"];
			_x addAction [("<t color=""#dddd00"">" + "Pack up FOB HQ" + "</t>"), "support\modules\WHB_FOBspawn\common\fn_addAction_unDeploy.sqf"];
		};
	//-------------------------------------------------------------------------------------------------
		Default 
		{
			//Do nothing for all other vehicles
		};
	};
} forEach _vehicles;