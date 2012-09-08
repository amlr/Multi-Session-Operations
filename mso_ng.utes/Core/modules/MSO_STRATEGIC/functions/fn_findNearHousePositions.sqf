#include <script_macros_core.hpp>
SCRIPT(findNearHousePositions);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_findNearHousePositions

Description:
Provide a list of house positions in the area

Parameters:
Array - Position
Number - Radius to search

Returns:
Array - A list of building positions

Examples:
(begin example)
// find nearby houses
_bldgpos = [_pos,50] call MSO_fnc_findNearHousePositions;
(end)

See Also:
- <MSO_fnc_getBuildingPositions>
- <MSO_fnc_findIndoorHousePositions>

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_pos","_radius","_positions","_nearbldgs"];

PARAMS_2(_pos,_radius);
_positions = [];
_nearbldgs = nearestObjects [_pos, ["House"], _radius];
{
	_positions = _positions + ([_x] call MSO_fnc_getBuildingPositions);
} forEach _nearbldgs;

_positions;