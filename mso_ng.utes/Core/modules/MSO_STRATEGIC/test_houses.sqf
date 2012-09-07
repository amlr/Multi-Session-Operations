// ----------------------------------------------------------------------------

#include <script_macros_core.hpp>
SCRIPT(test_clusters);

// ----------------------------------------------------------------------------

private ["_err","_obj_array","_house","_maxpos","_expected"];

LOG("Testing Clusters");

// UNIT TESTS (initStrings.sqf - stringJoin)
ASSERT_DEFINED("MSO_fnc_getEnterableHouses","");
ASSERT_DEFINED("MSO_fnc_getBuildingPositions","");

// find nearest house
_house = (getPosATL player) nearestObject "House";
_err = "no house found";
ASSERT_DEFINED("_house",_err);
ASSERT_TRUE(typeName _house == "OBJECT",_err);
[str _house, getPosATL _house, "Icon", [1, 1],"TYPE:", "Dot"] call CBA_fnc_createMarker;

// get number of building positions for an object
_maxpos = count ([_house] call MSO_fnc_getBuildingPositions);
_err = "max positions invalid";
ASSERT_DEFINED("_maxpos",_err);
ASSERT_TRUE(typeName _maxpos == "SCALAR",_err);

// confirm not [0,0,0]
_maxpos = _house buildingPos _maxpos;
_expected = "[0,0,0]";
_err = "max house positions incorrect";
ASSERT_DEFINED("_maxpos",_err);
ASSERT_TRUE(typeName _maxpos == "ARRAY",_err);
ASSERT_TRUE(str _maxpos != _expected,_err);

// get number of building positions for a non-building
_maxpos = [player] call MSO_fnc_getBuildingPositions;
_err = "no positions check invalid";
ASSERT_DEFINED("_maxpos",_err);
ASSERT_TRUE(typeName _maxpos == "SCALAR",_err);
ASSERT_TRUE(_maxpos == -1,_err);

// get array of all enterable houses around the player
_obj_array = [getPosATL player, 300] call MSO_fnc_getEnterableHouses;
_err = "no enterable houses";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array > 0,_err);
{
	[str _x, getPosATL _x, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorBlue"] call CBA_fnc_createMarker;
} forEach _obj_array;

// get array of all enterable houses across the map
_obj_array = call MSO_fnc_getAllEnterableHouses;
_err = "no enterable houses";
ASSERT_DEFINED("_obj_array",_err);
ASSERT_TRUE(typeName _obj_array == "ARRAY", _err);
ASSERT_TRUE(count _obj_array > 0,_err);
{
	[str _x, getPosATL _x, "Icon", [1, 1],"TYPE:", "Dot", "COLOR:", "ColorYellow"] call CBA_fnc_createMarker;
} forEach _obj_array;

nil;
