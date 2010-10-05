/* ----------------------------------------------------------------------------
Function: RMM_fnc_randPos

Description:
	A function used to randomize a position around a given center
Parameters:
	Marker, Object, Location, Group or Position, Radius
Example:
	_position =  [position, radius] call RMM_fnc_randPos
Returns:
	Position - [X,Y,Z]
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_position","_radius"];
_position = +((_this select 0) call RMM_fnc_getpos);
_radius = _this select 1;

_position set [0,(_position select 0) + (_radius - (random (2*_radius)))];
_position set [1,(_position select 1) + (_radius - (random (2*_radius)))];
_position