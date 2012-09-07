#include <script_macros_core.hpp>

private ["_debug","_logic","_spawn","_spawnAI","_oldvalues","_localai"];

waitUntil{!isNil {GVAR(mainscope)}};
_logic = GVAR(mainscope);
_debug = _logic getVariable "debug";

if (pdb_locations_enabled) then {
        waitUntil {!(isNil "PDB_CQB_positionsloaded")};
        sleep 5;
};

waitUntil{!isNil {_logic getVariable "init_done"}};
// if conditions are right, spawn a group and place them
_spawnAI = {
        private ["_house","_spawn","_grp"];
        PARAMS_2(_house,_spawn);
        // check if local player is within spawn distance AND
        // that house doesn't already have AI AND
        // that player is not above 5m height AND
        // that the player isn't already hosting too many AI AND
        // that the player isn't already hosting too many groups simultaneously
        if (
                (_house distance player < _spawn) &&
                isNil {_house getVariable "group"} &&
                (((position player) select 2) < 5) &&
                call MSO_fnc_isAbleToHost &&
                ({local leader _x} count (GVAR(mainscope) getVariable "groups") < 5)
        ) then {
                // this just flags the house as beginning spawning
                // and will be over-written in MSO_fnc_CQBspawnRandomgroup
                _house setVariable ["group", player];
                str _house setMarkerType "Waypoint";
                // spawn AI
                _grp = [_house] call MSO_fnc_CQBspawnRandomgroup;
                [GVAR(mainscope), "groups", [_grp]] call BIS_fnc_variableSpaceAdd;
                // TODO this needs to be refactored
                [_house, _grp] spawn MSO_fnc_CQBmovegroup;
        };
};

// over-arching spawning loop, with increased spawn distance for strategic objects
_oldvalues = [0,0,0,0,0];
waitUntil{
        sleep 1;
        {
                _spawn = _logic getVariable "spawnDistance";
                [_x,_spawn] call _spawnAI;
        } forEach (_logic getVariable "nonStrategicHouses");
        
        {
                _spawn = (_logic getVariable "spawnDistance") * 1.5;
                [_x,_spawn] call _spawnAI;
        } forEach (_logic getVariable "strategicHouses");
        
        if (_debug) then {
                private["_activecount","_remaincount","_clearcount","_cqbai"];
                _activecount = count (_logic getVariable "groups");
                _remaincount = count (_logic getVariable "nonStrategicHouses") + count (_logic getVariable "strategicHouses");
                _clearcount =  (_logic getVariable "initDone") - _remaincount;                
                if (
                        _oldvalues select 0 != _remaincount ||
                        _oldvalues select 1 != _activecount ||
                        _oldvalues select 2 != _clearcount
                ) then {                        
                        format["CQB Population: %1 remaing | %2 active | %3 cleared positions...", _remaincount, _activecount, _clearcount] call MSO_fnc_logger;
                        _oldvalues set [0, _remaincount];
                        _oldvalues set [1, _activecount];
                        _oldvalues set [2, _clearcount];
                };
                
                _cqbai = [];
                {
                        _cqbai = _cqbai + units _x;
                } forEach (_logic getVariable "groups");
                _localai = {local _x} count _cqbai;
                if (
                        _oldvalues select 3 != count _cqbai ||
                        _oldvalues select 4 != _localai
                ) then {                                        
                        format["CQB Population: %1 local AI of %2 total CQB AI...", _localai, count _cqbai] call MSO_fnc_logger;
                        _oldvalues set [3, count _cqbai];
                        _oldvalues set [4, _localai];
                };                
        };
        false;
};
