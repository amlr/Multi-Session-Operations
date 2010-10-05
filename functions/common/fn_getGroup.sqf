/* ----------------------------------------------------------------------------
Function: RMM_fnc_getGroup

Description:
	A function used to find out the group of an object.
Parameters:
	Group or Unit
Example:
	_group = player call RMM_fnc_getGroup
Returns:
	Group
Author:
	Rommel

---------------------------------------------------------------------------- */

if (tolower (typeName _this) == "group") exitwith {_this};
group _this