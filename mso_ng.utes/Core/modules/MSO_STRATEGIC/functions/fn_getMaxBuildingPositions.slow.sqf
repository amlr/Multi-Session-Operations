#include <script_macros_core.hpp>
SCRIPT(getMaxBuildingPosititions);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_getMaxBuildingPositions

Description:
Returns number of positions for a given object

Parameters:
Object - Building object

Returns:
Number - Maximum number of building positions for the given object

Examples:
(begin example)
// get number of building positions for an object
_maxpos = [_house] call MSO_fnc_getMaxBuildingPositions;
(end)

See Also:
- <MSO_fnc_getEnterableHouses>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_hash","_house","_buildingPos","_pos"];

PARAMS_1(_house);

if (!isNil "GVAR(getMaxBuildingPosititions)") then {
	_hash = GVAR(getMaxBuildingPosititions);
} else {
	_hash = [[],-1] call CBA_fnc_hashCreate;
};

_buildingPos = [_hash, typeOf _house] call CBA_fnc_hashGet;

if(_buildingPos == -1) then {
	private["_result","_err"];
	_buildingPos = 0;
	_pos = _house buildingPos _buildingPos;
	while {str _pos != "[0,0,0]"} do {
		_buildingPos = _buildingPos + 1;
		_pos = _house buildingPos _buildingPos;
	};
	_buildingPos = _buildingPos - 1;
	
	if(_buildingPos != -1) then {
		_result = str (_house buildingPos _buildingPos) != "[0,0,0]";
		_err = format["max positions (%1) invalid", _buildingPos];
		ASSERT_TRUE(_result,_err);
	
		[_hash, typeOf _house, _buildingPos] call CBA_fnc_hashSet;
	};
};

_buildingPos;
