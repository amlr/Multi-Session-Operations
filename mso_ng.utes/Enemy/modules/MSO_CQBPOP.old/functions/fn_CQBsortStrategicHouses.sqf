#include <script_macros_core.hpp>
SCRIPT(CQBsortStrategicHouses);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQBsortStrategicHouses

Description:
Sort buildings into strategic and non-strategic arrays

Parameters:
Array - List of all enterable houses

Returns:
Array - An array containing randomly selected strategic and non strategic
buidlings including the maximum number of building positions for 
the building.

Examples:
(begin example)
_spawnhouses = call MSO_fnc_getAllEnterableHouses;
_result = [_spawnhouses] call MSO_fnc_CQBsortStrategicHouses;
CQBpositionsStrat = _result select 0; // [strathouse1, strathouse2];
CQBpositionsReg = _result select 1; // [nonstrathouse1, nonstrathouse2];
(end)

See Also:
- <MSO_fnc_getEnterableHouses>
- <MSO_fnc_getAllEnterableHouses>

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_spawnhouses","_BuildingTypeStrategic","_base1","_base2","_nonstrathouses","_strathouses","_cqb_spawn_intensity"];

PARAMS_1(_spawnhouses);

_base1 = markerPos "ammo_1";
_base2 = markerPos "ammo";
if ((str(_base1) == "[0,0,0]") && (str(_base2) == "[0,0,0]")) then {_base1 = markerPos "respawn_west"};
if (isNil "rmm_ep_safe_zone") then {rmm_ep_safe_zone = 1000};

_cqb_spawn_intensity = 1 - (cqb_spawn / 10);
_strathouses = [];
_nonstrathouses = [];
_BuildingTypeStrategic = MSO_CQB_mainscope getVariable ["strategicTypes", []];

{
        if (
                ((_x distance _base1) > rmm_ep_safe_zone) &&
                ((_x distance _base2) > rmm_ep_safe_zone)
        ) then {
               if (typeOf _x in _BuildingTypeStrategic) then {
                        if ((random 1) > 0.3) then {
                                _strathouses set [count _strathouses, _x];
                        };
                } else {        
                        if ((random 1) > _cqb_spawn_intensity) then {
                                _nonstrathouses set [count _nonstrathouses, _x];
                        };
                };
        };
} forEach _spawnhouses;

[_strathouses, _nonstrathouses];
