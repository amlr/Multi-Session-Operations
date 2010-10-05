/* ----------------------------------------------------------------------------
Function: RMM_fnc_taskAttack

Description:
	A function for a group to attack a parsed location.
Parameters:
	- Group (Group or Object)
	- Position (XYZ, Object, Location or Group)
	Optional:
	- Search Radius (Scalar)
Example:
	[group player, getpos (player findNearestEnemy player), 100] call RMM_fnc_taskAttack
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_group","_position","_radius"];
_group = _this select 0;
_position = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {0};

[_group, _position, _radius, "SAD", "COMBAT", "RED"] call RMM_fnc_addwaypoint;