#include <script_macros_core.hpp>
SCRIPT(deleteLink);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_deleteLink

Description:
Used for removing debugging lines between two objects on the map

Parameters:
Array - Two objects with drawn line on map

Examples:
(begin example)
[_x, _x getVariable "neighbour1"] call mso_fnc_deleteLink;
(end)

See Also:
- <MSO_fnc_createLink>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private ["_obj1","_obj2"];
_obj1 = _this select 0;
_obj2 = _this select 1;

if(isNil "_obj2") exitWith{};

deleteMarker format ["%1_%2",_obj1,_obj2];
