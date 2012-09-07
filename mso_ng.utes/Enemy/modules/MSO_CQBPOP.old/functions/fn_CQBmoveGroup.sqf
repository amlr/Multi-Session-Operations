#include <script_macros_core.hpp>
SCRIPT(CQBmovegroup);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQBmovegroup

Description:
Patrol or defend houses in an area

Parameters:
Object - An enterable house
Object - Group of units

Examples:
(begin example)
[_house, _grp] spawn MSO_fnc_CQBmovegroup;
(end)

See Also:
- <MSO_fnc_findVehicleType>
- <MSO_fnc_getMaxBuildingPositions>

Author:
Highhead
---------------------------------------------------------------------------- */

if (isDedicated) exitWith {};

private ["_bldgpos","_group","_pos","_house","_debug"];
waitUntil {!isNil "bis_fnc_init"};

PARAMS_2(_house,_group);
_pos = position _house;
_debug = GVAR(mainscope) getVariable "debug";
_bldgpos = [];

// find indoor positions in nearby houses
_bldgpos = [_pos,50]  call MSO_fnc_findIndoorHousePositions;
// enlarge the search if none found
// TODO - will this ever occur considering the 1st param is a house?
if ((count _bldgpos) < 1) then {_bldgpos = [_pos,100]  call MSO_fnc_findIndoorHousePositions;};

if (_debug) then {format["CQB Population: Found %1 buildingpositions...", count _bldgpos] call MSO_fnc_logger;};

// randomly position units inside nearby buildings
[_group, _bldgpos] call MSO_fnc_CQBsetGroupPositions;

// Randomly choose to guard house
//  TODO - if strategic, maybe guard by default
if ((random 1 > 0.35)) then {
        [_house,_group,_bldgpos] call MSO_fnc_CQBhouseGuardLoop;
} else {
//        [_pos,_group,_house,_bldgpos,_despawn] call CQB_patrolloop;
};

true;
