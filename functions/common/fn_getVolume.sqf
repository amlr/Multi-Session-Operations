/* ----------------------------------------------------------------------------
Function: RMM_fnc_getVolume

Description:
	Return the volume of an object
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:
	Rommel
---------------------------------------------------------------------------- */

private ["_object","_bounds"];
_object = _this select 0;
_bounds = (boundingBox _object) select 1;

private ["_x","_y","_z"];
_x = _bounds select 0;
_y = _bounds select 1;
_z = _bounds select 2;
(_x * _y * _z);