/* ----------------------------------------------------------------------------
Function: RMM_fnc_isAlive

Description:
	A function used to find out if the group or object is alive.
Parameters:
	Array, Group or Unit
Example:
	_alive = (Units player) call RMM_fnc_getAlive
Returns:
	Boolean
Author:
	Rommel

---------------------------------------------------------------------------- */

private "_typename";
_typename = tolower(typename _this);

switch (_typename) do {
	case ("array") : {
		{
			if (_x call RMM_fnc_isalive) exitwith {true};
			false;
		} foreach _this;
	};
	case ("object") : {
		alive _this;
	};
	case ("group") : {
		if (isnull (leader _this)) then {
			false;
		} else {
			(units _this) call RMM_fnc_isalive;
		};
	};
	default {alive _this};
};