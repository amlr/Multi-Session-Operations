/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

_getFlat = GVAR(position) isflatempty [
	10,	//--- Minimal distance from another object
	0,				//--- If 0, just check position. If >0, select new one
	0.5,			//--- Max gradient
	10,	//--- Gradient area
	0,			//--- 0 for restricted water, 2 for required water,
	false,		//--- True if some water can be in 25m radius
	objNull		//--- Ignored object
];

if (count _getFlat == 0) exitwith {hint "Invalid (Select another)"};

[QUOTE(GVAR(groupchat)),[player,[QUOTE(GVAR(STR_request_insert)), mapGridPosition GVAR(position)]]] call CBA_fnc_globalEvent;

sleep 4;
if (GVAR(helicopterAvailable)) then {
	[QUOTE(GVAR(execute_insert)),[playerSide,GVAR(position)]] call CBA_fnc_globalEvent;
} else {
	[QUOTE(GVAR(sidechatHQ)),[playerSide,[QUOTE(GVAR(STR_busy))]]] call CBA_fnc_globalEvent;
};