#include <script_macros_core.hpp>
SCRIPT(CQBhouseGuardLoop);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQBhouseGuardLoop

Description:
Patrol or defend houses in an area

Parameters:
Object - An enterable house
Object - Group of units

Examples:
(begin example)
[_house,_group,_bldgpos] call MSO_fnc_CQBhouseGuardLoop;
(end)

See Also:
- <MSO_fnc_findVehicleType>
- <MSO_fnc_getMaxBuildingPositions>

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_patrol","_movehome","_endpos","_cleared","_suspended","_near","_pos","_group","_house","_bldgpos","_despawn","_debug"];
PARAMS_3(_house,_group,_bldgpos);
_pos = position _house;
_despawn = (GVAR(mainscope) getVariable "spawnDistance") * 1.65;
_debug = GVAR(mainscope) getVariable "debug";

_cleared = false;
_suspended = false;
_patrol = false;
_movehome = false;


while {!(_cleared) && !(_suspended)} do {
        sleep 2;
        _near = (([_pos, _despawn] call MSO_fnc_anyPlayersInRange) > 0);
        
        if (_near) then {
                if (!_patrol) then {
                        if (_debug) then {diag_log format["MSO-%1 CQB Population: Telling group %2 to guard house...", time, _group]};
                        
                        {
                                _x setUnitPos "AUTO";
                                _x setBehaviour "AWARE";
                                doStop _x;
                                0 = [_x, 50, true, 300, _pos,_despawn] spawn MSO_fnc_CQBhousepos;
                        } forEach units _group;
                        
                        _patrol = true;
                        _movehome = false;
                };
        } else {
                if (!_movehome) then {
                        _patrol = false;
                        _movehome = true;
                        
                        if (_debug) then {diag_log format["MSO-%1 CQB Population: Sending group %2 home...", time, _group]};
                        while {(count (waypoints (_group))) > 0} do {deleteWaypoint ((waypoints (_group)) select 0);};
                        _endpos = _bldgpos select floor(random count _bldgpos);
                        
                        {
                                _x doMove _endpos;
                        } forEach units _group;
                };
        };
        if (_movehome) then {
                {
                        if (_x distance _endpos < 4) then {
                                _x setDamage 1;
                                deleteVehicle _x;
                        };
                } forEach units _group;
        };
        if ((count (units _group) == 0) && (_patrol)) then {_house setVariable ["c", true, true]; _cleared = true};
        if ((count (units _group) == 0) && (_movehome)) then {_suspended = true};
};
