#include <script_macros_core.hpp>
SCRIPT(CQBspawnRandomgroup);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQBspawnRandomgroup

Description:
Spawn up to 4 units in a specific house

Parameters:
Object - An enterable house

Returns:
Object - The spawned group

Examples:
(begin example)
[_house] call MSO_fnc_CQBspawnRandomgroup;
(end)

See Also:
- <MSO_fnc_findVehicleType>
- <MSO_fnc_getBuildingPositions>

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_unittype","_house","_debug","_types","_unittypes","_group","_units","_logic","_factions"];

PARAMS_1(_house);
_logic = GVAR(mainscope);
_debug = _logic getVariable "debug";
_factions = _logic getVariable "factions";

_types = [0, _factions call BIS_fnc_selectRandom,"Man"] call MSO_fnc_findVehicleType;
_unittypes = [];
for "_i" from 0 to (1 + floor(random 3)) do {
        _unittype = _types call BIS_fnc_selectRandom;
        _unittypes set [count _unittypes, _unittype];
};

_group = [position _house, east, _unittypes] call BIS_fnc_spawnGroup;
_units = units _group;

if (count _units < 1) exitWith {
        if (_debug) then {
                 format["CQB Population: Group %1 deleted on creation - no units...", _group] call MSO_fnc_logger;
        };
        deleteGroup _group;
        _house setVariable ["group", nil];
};

{
        private["_max","_pos"];
        _max = count ([_house] call MSO_fnc_getBuildingPositions);
        _pos = _house buildingPos floor(random _max);
        _x setPos _pos;
} forEach _units;
_group setVariable ["house",_house];

if (_debug) then {
        format["CQB Population: Created group name %1 with %2 units...", _group, count units _group] call MSO_fnc_logger;
};

_group;
