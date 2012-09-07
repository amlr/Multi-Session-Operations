#include <script_macros_core.hpp>
SCRIPT(findIndoorHousePositions);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_findIndoorHousePositions

Description:
Provide a list of house positions in the area excluding rooftops

Parameters:
Array - Position
Number - Radius to search

Returns:
Array - A list of building positions

Examples:
(begin example)
// find nearby houses
_bldgpos = [_pos,50] call MSO_fnc_findIndoorHousePositions;
(end)

See Also:
- <MSO_fnc_getBuildingPositions>
- <MSO_fnc_findNearHousePositions>

Author:
Highhead
---------------------------------------------------------------------------- */

private ["_pos","_radius","_positions","_nearbldgs","_highest","_lowest","_tmppositions"];

PARAMS_2(_pos,_radius);
_positions = [];
_nearbldgs = nearestObjects [_pos, ["House"], _radius];
{
	_highest = [0,0,0];
	_lowest = [0,0,99];
	_tmpPositions = [_x] call MSO_fnc_getBuildingPositions;
	{
		if((_x select 2) > (_highest select 2)) then {
			_highest = _pos;
		};
		if((_x select 2) < (_lowest select 2)) then {
			_lowest = _pos;
		};
	} forEach _tmpPositions;
	
	if(_lowest select 2 < _highest select 2) then {
		{
			if((_x select 2) < (_highest select 2)) then {
				_positions set [count _positions, _x];
			};
		} forEach _tmppositions;
	} else {
		_positions = _tmppositions;
	};
} forEach _nearbldgs;

_positions;
