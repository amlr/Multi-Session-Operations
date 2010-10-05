/* ----------------------------------------------------------------------------
Function: RMM_fnc_getNearest

Description:
	A function used to find out the nearest entity parsed in an array to a position. Compares the distance between entity's in the parsed array.
Parameters:
	_position - Marker, Object, Location, Group or Position
	_array - Array of [Marker, Object, Location, Group and or Positions]
	_radius - Maximum distance from _position
	_code - Condition to meet (Code)
Example:
	_nearestVeh = [player, vehicles] call RMM_fnc_getNearest
	_nearestGroup = [[0,0,0], allGroups, 50, {count (units _x) > 1}] call RMM_fnc_getNearest
Returns:
	Nearest given entity or List of entities within given distance
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_position","_array"];

_position = _this select 0;
_array = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {10^5};
_code = if (count _this > 3) then {_this select 3} else {{true}};

private "_return";
_return = [];
{
	_distance = [_position,_x] call RMM_fnc_getDistance;
	if (_distance < _radius) then {
		if !(call _code) exitwith {};
		if (count _this > 2) then {
			_return set [count _return, _x];
		} else {
			_radius = _distance;
			_return = _x;
		};
	};
} foreach _array;
_return