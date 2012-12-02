#include <script_macros_core.hpp>
SCRIPT(updateMenu);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_updateMenu

Description:
Initalises and adds to interaction menu for MSO

Parameters:
String - Menu entry
Code - Menu code to execute

Examples:
(begin example)
["Debug","if((getPlayerUID player) in MSO_R_Admin) then {createDialog ""RMM_ui_debug""};"] call MSO_fnc_updateMenu;
(end)

See Also:
- <MSO_fnc_initialising>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private["_name","_exp"];
PARAMS_2(_name,_exp);

if(isNil "BIS_MENU_GroupCommunication") then {
	//Create the comms menu on all machines.
	[] call BIS_fnc_commsMenuCreate;
};

BIS_MENU_GroupCommunication = BIS_MENU_GroupCommunication + [
	[_name,[count BIS_MENU_GroupCommunication + 1],"",-5,[["expression",_exp]],"1","1"]
];
