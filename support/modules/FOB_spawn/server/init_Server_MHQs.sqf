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
			_array1 = PV_hqArray;
			//player sideChat format ["PV HQ Array: %1", _array1];
			_array2 = [_x];
			//player sideChat format ["Adding object: %1", _array2];
			PV_hqArray = _array1 + _array2;
		};
	//-------------------------------------------------------------------------------------------------
		case "LAV25_HQ_UNFOLDED":
		{
			_array1 = PV_hqArray;
			//player sideChat format ["PV HQ Array: %1", _array1];
			_array2 = [_x];
			//player sideChat format ["Adding object: %1", _array2];
			PV_hqArray = _array1 + _array2;
		};
	//-------------------------------------------------------------------------------------------------
		Default 
		{
			//Do nothing for all other vehicles
		};
	};
	
	//Broadcast the new list out to everyone.
	publicvariable "PV_hqArray";
} forEach _vehicles;