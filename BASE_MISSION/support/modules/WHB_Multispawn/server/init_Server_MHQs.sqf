// Script used by the Server to build an array of all available MHQs
// Static HQ buildings will need the relevant actions manually added in the editor
// Author: WobbleyheadedBob aka CptNoPants

private ["_vehicles","_array1","_array2"];
_vehicles = _this select 0;
PV_hqArray = [];

{
	switch (typeOf _x) do
	{
	//-------------------------------------------------------------------------------------------------
		case "LAV25_HQ":
		{
			//player sideChat format ["PV HQ Array: %1", PV_hqArray];
			//player sideChat format ["Adding object: %1", _x];
			PV_hqArray set [count PV_hqArray, _x];
		};
	//-------------------------------------------------------------------------------------------------
		case "LAV25_HQ_UNFOLDED":
		{
			//player sideChat format ["PV HQ Array: %1", PV_hqArray];
			//player sideChat format ["Adding object: %1", _x];
			PV_hqArray set [count PV_hqArray, _x];
		};
	//-------------------------------------------------------------------------------------------------
		case "M1130_CV_EP1":
		{
			//player sideChat format ["PV HQ Array: %1", PV_hqArray];
			//player sideChat format ["Adding object: %1", _x];
			PV_hqArray set [count PV_hqArray, _x];
		};
	//-------------------------------------------------------------------------------------------------
		case "M1130_HQ_unfolded_Base_EP1":
		{
			//player sideChat format ["PV HQ Array: %1", PV_hqArray];
			//player sideChat format ["Adding object: %1", _x];
			PV_hqArray set [count PV_hqArray, _x];
		};
	//-------------------------------------------------------------------------------------------------
		Default 
		{
			//Do nothing for all other vehicles
		};
	};
	
	//Broadcast the new list out to everyone.
} forEach _vehicles;
publicvariable "PV_hqArray";
