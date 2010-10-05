/* ----------------------------------------------------------------------------
Function: RMM_fnc_getAlive

Description:
	A function used to find out who is alive in an array or a group.
Parameters:
	Array, Group or Unit
Example:
	_alive = (Units player) call RMM_fnc_getAlive
Returns:
	Array
Author:
	Rommel

---------------------------------------------------------------------------- */

private "_typename";
_typename = tolower (typename _this);
if (_typename == "object") exitwith {alive _this};

private ["_return","_array"];
_array = [];
switch (_typename) do {
	case ("group") : {
		_array = units _this;
	};
	case ("array") :{
		_array =+ _this;
	};
};
{
	if (alive _x) then {
		_return set [count _return, _x];
	}
} foreach _array;
_return