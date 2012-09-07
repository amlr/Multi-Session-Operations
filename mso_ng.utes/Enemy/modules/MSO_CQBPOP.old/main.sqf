#include <script_macros_core.hpp>

/* ----------------------------------------------------------------------------
Description:
The main script for MSO CQB Populator

MSO_CQB_mainscope - setVariables:
- debug - Debug enabled [Boolean] 
- groups - List of AI groups performing CQB [Array]
- factions - specific factions used by CQB (defaults MSO_FACTIONS) [Array]
- spawnDistance - distance when AI will spawn for non-strategic buildings. Strategic buildings will spawn at 1.5x this value [Number]
- strategicHouses - List of uncleared strategic CQB buildings [Array]
- nonStrategicHouses - List of uncleared non-strategic CQB buildings [Array]
Once a house is cleared, it is removed from strategicHouses & nonStrategicHouses
and the group removed from groups.

Group objects -setVariable:
- house

strategicHouse & nonStrategicHouse objects - setVariables:
- group - If a group is despawned as there are no players left in the area, group is set to nil

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_debug","_logic","_spawnhouses","_result"];

// Single player setting
if (isNil "CQB_spawn") then {CQB_spawn = 1};
// Exit if not enabled
if (CQB_spawn == 0) exitWith {"CQB Population turned off! Exiting..." call MSO_fnc_logger;};

_debug = true; //debug_mso;
if (isServer) then {
        // Create common module object for settings and persistence
	if(isNil {GVAR(mainscope)} || {typeName GVAR(mainscope) != "OBJECT"}) then {
	        GVAR(mainscope) = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];
	};
        _logic = GVAR(mainscope);
        // Initialise default settings
        _logic setVariable ["debug", _debug];
        _logic setVariable ["groups", []];
        _logic setVariable ["spawnDistance", 800];
        _logic setVariable ["factions", MSO_FACTIONS];
        _logic setVariable ["strategicTypes", [
                "Land_A_TVTower_Base",
                "Land_Dam_ConcP_20",
                "Land_Ind_Expedice_1",
                "Land_Ind_SiloVelke_02",
                "Land_Mil_Barracks",
                "Land_Mil_Barracks_i",
                "Land_Mil_Barracks_L",
                "Land_Mil_Guardhouse",
                "Land_Mil_House",
                "Land_trafostanica_velka",
                "Land_Ind_Oil_Tower_EP1",
                "Land_A_Villa_EP1",
                "Land_Mil_Barracks_EP1",
                "Land_Mil_Barracks_i_EP1",
                "Land_Mil_Barracks_L_EP1",
                "Land_Barrack2",
                "Land_fortified_nest_small_EP1",
                "Land_fortified_nest_big_EP1",
                "Land_Fort_Watchtower_EP1",
                "Land_Ind_PowerStation_EP1",
                "Land_Ind_PowerStation"
        ]];
        
        // Get all enterable houses across the map
        _spawnhouses = call MSO_fnc_getAllEnterableHouses;
        // Sort and store strategic and non-strategic objects
        _result = [_spawnhouses] call MSO_fnc_CQBsortStrategicHouses;
        _logic setVariable ["strategicHouses", _result select 0];
        _logic setVariable ["nonStrategicHouses", _result select 1];
        _logic setVariable ["totalHouses", count (_result select 0) + count (_result select 1)];
        _logic setVariable ["init_done", true];
        
        if (_debug) then {
                // mark all strategic and non-strategic houses
                private["_lhs","_shs"];
                _lhs = _logic getVariable "nonStrategicHouses";
                _shs = _logic getVariable "strategicHouses";
                format["CQB Population: Total positions found %1", count _lhs + count _shs] call MSO_fnc_logger;
                
                {
                        [str _x, position _x, "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorRed"] call CBA_fnc_createMarker;
                } forEach _lhs;
                
                {
                        [str _x, position _x, "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorGreen"] call CBA_fnc_createMarker;
                } forEach _shs;
        };
};

"CQB Population: starting to load functions..." call MSO_fnc_logger;

waitUntil{!isNil {GVAR(mainscope)}};
waitUntil{!isNil {GVAR(mainscope) getVariable "init_done"}};

// Spawn AI de-spawn and empty group garbage collection loop
// executed on both server and clients
[] spawn {
        private ["_logic","_leader","_debug","_groups","_house"];
        _logic = GVAR(mainscope);
        // Cycle in a waitUntil for better performance
        waitUntil{
                sleep 5;
                _groups = _logic getVariable "groups";
                _debug = _logic getVariable "debug";
                {
                        // get house in question
                        _house = _x getVariable "house";
                        // if CQB-unit group is empty then house is cleared
                        if (count (units _x) == 0) then {
                                if (_debug) then {
                                        format["CQB Population: Deleting CQB-group %1 from %2...", _x, player] call MSO_fnc_logger;
                                        deleteMarker str _house;
                                };
                                // remove the house from the list
                                _house setVariable ["group",nil];
                                // update central CQB house listings
                                [_logic,"strategicHouses",[_house]] call BIS_fnc_variableSpaceRemove;
                                [_logic,"nonStrategicHouses",[_house]] call BIS_fnc_variableSpaceRemove;
                                // delete the group
                                _x setVariable ["house",nil];
                                [_logic,"groups",[_x]] call BIS_fnc_variableSpaceRemove;
                                deleteGroup _x;
                        } else {
                                // if CQB-units are local (server or clientside) and
                                // all players are out of range then house is still active
                                // despawn group but house not cleared
                                _leader = leader _x;
                                if (local _leader) then {
                                        if  (([position _leader, (_logic getVariable "spawnDistance") * 3] call MSO_fnc_anyPlayersInRange) == 0) then {
                                                if (_debug) then {
                                                        format["CQB Population: Deleting orphaned CQB-group %1 from %2...", _x, player] call MSO_fnc_logger;
                                                        str _house setMarkerType "Dot";
                                                };
                                                // Update house that group despawned
                                                _house setVariable ["group",nil];
                                                // Despawn group
                                                _x setVariable ["house",nil];
                                                {
                                                        _x setDamage 1;
                                                        deleteVehicle _x;
                                                } forEach units _x;
                                                // update central CQB group listing
                                                [_logic,"groups",[_x]] call BIS_fnc_variableSpaceRemove;
                                                deleteGroup _x;
                                        };
                                };
                        };
                } forEach _groups;
                // end with false for waitUntil loop
                false;
        };
};

if !(isDedicated) then {
        if (isNil "BIN_fnc_taskDefend") then {BIN_fnc_taskDefend = compile preprocessFileLineNumbers "MSO\Enemy\scripts\BIN_taskDefend.sqf"};
        if (isNil "BIN_fnc_taskPatrol") then {BIN_fnc_taskPatrol = compile preprocessFileLineNumbers "MSO\Enemy\scripts\BIN_taskPatrol.sqf"};
        if (isNil "BIN_fnc_taskSweep") then {BIN_fnc_taskSweep = compile preprocessFileLineNumbers "MSO\Enemy\scripts\BIN_taskSweep.sqf"};
        
        if (isNil "CQB_patrolloop") then {CQB_patrolloop = compile preprocessFileLineNumbers "MSO\Enemy\modules\MSO_CQBPOP\functions\CQB_patrolloop.sqf"};
        if (isNil "MSO_fnc_CQBhousepos") then {MSO_fnc_CQBhousepos = compile preprocessFileLineNumbers "MSO\Enemy\modules\MSO_CQBPOP\functions\MSO_fnc_CQBhousepos.sqf"};
        if (isNil "getGridPos") then {getGridPos = compile preprocessFileLineNumbers "MSO\Enemy\modules\MSO_CQBPOP\functions\getGridPos.sqf"};
        
        [] spawn compile preprocessFileLineNumbers "MSO\Enemy\modules\MSO_CQBPOP\functions\MSO_fnc_CQBclientloop.sqf";
};

"CQB Population: loaded functions..." call MSO_fnc_logger;
