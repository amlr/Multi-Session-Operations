/* ----------------------------------------------------------------------------
Function: RMM_fnc_setHeight

Description:
	A function used to set the height of an object
Parameters:
	_object - Object or Location
	_height - Height in metres
	_type - Optional parameter, 0 is getpos, 1 is getpos ASL, 2 is getposATL (Default: 1)
Example:
	[this, 10] call RMM_fnc_setHeight
Returns:
	Nothing
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_object","_height","_type"];
_object = _this select 0;
_height = _this select 1;
_type = if (count _this > 2) then {_this select 2} else {1};

private "_position";
_position = switch (_type) do {
	case 0 : {getpos _object};
	case 1 : {getposasl _object};
	case 2 : {getposatl _object};
};
_position set [2, _height];

switch (_type) do {
	case 0 : {_object setpos _position};
	case 1 : {_object setposasl _position};
	case 2 : {_object setposatl _position};
};
_object setdir (getdir _object);