/* ----------------------------------------------------------------------------
File: init.sqf

Description:
Top level init.sqf for Core

Author:
Wolffy.au
---------------------------------------------------------------------------- */

#include <script_macros_core.hpp>
#include <modules\modules.hpp>

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

createCenter east;
createCenter west;
createCenter resistance;
createCenter civilian;
createCenter sideLogic;

east setFriend [west, 0];

east setFriend [resistance, 0];
west setFriend [east, 0];

west setFriend [resistance, 1];
resistance setFriend [east, 0];

resistance setFriend [west, 1];

ISNILS(sideLogic,createCenter sideLogic);
ISNILS(MSO_FNC_GROUP,createGroup sideLogic;publicVariable "MSO_FNC_GROUP";);

//All client should have the Functions Manager initialized, to be sure.
if (isnil "BIS_functions_mainscope") then {
        BIS_functions_mainscope = MSO_FNC_GROUP createUnit ["FunctionsManager", [0,0,0], [], 0, "NONE"];
        BIS_fnc_locations = compile preprocessFileLineNumbers "CA\modules\functions\systems\fn_locations.sqf";
};

waitUntil{!isNil "BIS_fnc_init"};

"BIS Garbage Collector" call mso_fnc_initialising;

mso_version = "NG";
format["Version: %1", mso_version] call mso_fnc_initialising;

//--- Is Garbage collector running?
if (isnil "BIS_GC") then {
        BIS_GC = MSO_FNC_GROUP createUnit ["GarbageCollector", getPosATL BIS_functions_mainscope, [], 0, "NONE"];
};
if (isnil "BIS_GC_trashItFunc") then {
        BIS_GC_trashItFunc = compile preprocessFileLineNumbers "ca\modules\garbage_collector\data\scripts\trashIt.sqf";
};
waitUntil{!isNil "BIS_GC"};
BIS_GC setVariable ["auto", true, true];

"BIS Comms Menu" call mso_fnc_initialising;
//Create the comms menu on all machines.
[] call BIS_fnc_commsMenuCreate; 

//http://community.bistudio.com/wiki/enableSaving
enableSaving [false, false];

mso_menuname = "Multi-Session Operations";
mso_interaction_key = [221,[false,false,false]];

#ifdef RMM_DEBUG
"Debug" call mso_fnc_initialising;
execNow "core\modules\rmm_debug\main.sqf";
#endif

"View Distance" call mso_fnc_initialising;
setViewDistance 2500;
setTerrainGrid 25;
