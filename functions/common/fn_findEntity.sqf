/* ----------------------------------------------------------------------------
Function: RMM_fnc_findEntity

Description:
	A function used to find out the first entity of parsed type in a nearEntitys call
Parameters:
	- Type (Classname, Object)
	- Position (XYZ, Object, Location or Group)
	Optional:
	- Radius (Scalar)
Example:
	_veh = ["LaserTarget", player] call RMM_fnc_findEntity
Returns:
	First entity; nil return if nothing
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_type","_position","_radius"];
_type = _this select 0;
_position = _this select 1;
_radius = if (count _this > 2) then {_this select 2} else {50};

{
	if (_x iskindof _type) exitwith {
		_x
	};
	nil
} foreach (_position nearentities _radius);