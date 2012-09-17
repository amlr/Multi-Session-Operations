#include <script_macros_core.hpp>
SCRIPT(CQB);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQB
Description:
Creates an instance of CQB class

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Boolean - debug - Debug enabled
Boolean - state - Save and restore state
Array - groups - List of AI groups performing CQB
Array - factions - specific factions used by CQB (defaults MSO_FACTIONS)
Number - spawnDistance - distance when AI will spawn for buildings.
Array - houses - List of uncleared strategic CQB buildings

Once a house is cleared, it is removed from the houses list and the group removed from groups.
If there are no players left in the area, the group is despawned and removed from groups.
Each house tracks its associated group and the units that make up that group, while
each associated group tracks its assigned house.

Examples:
(begin example)
// Create CQB instance
_logic = call MSO_fnc_CQB;

// Enable debugging markers and logging
[_logic, "debug", true] call MSO_fnc_CQB;

// Restore instance to a previously saved state
[_logic, "state", _restored_data] call MSO_fnc_CQB;
// Set spawn distance
[_logic, "spawnDistance", 800] call MSO_fnc_CQB;
// Set enemy factions
[_logc, "factions", ["BIS_TK_INS"]] call MSO_fnc_CQB;

// Provide list of houses to populate
[_logic, "houses", [_myhouse]] call MSO_fnc_CQB;

// Get current houses
_hses = [_logic, "houses"] call MSO_fnc_CQB;
// Replace list of houses
_newhses = [_newhse1,_newhse2];
_hses = [_logic, "houses", _newhses] call MSO_fnc_CQB;
// Remove a house
_hses = [_logic, "clearHouse", _oldhse] call MSO_fnc_CQB;
(end)

See Also:
- <MSO_fnc_CQBsortStrategicHouses>

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */
private ["_logic","_operation","_args","_mtemplate"];

#define SUPERCLASS MSO_fnc_Base
#define DEFAULT_SPAWNDISTANCE 800

// Create a new instance
if(isNil "_this") exitWith {
        // Create a module object from Base
        _logic = call SUPERCLASS;
        
        _logic setVariable ["super", SUPERCLASS];
        _logic setVariable ["class", MSO_fnc_CQB];
        
        _logic;
};

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

_mtemplate = "MSO_CQB_%1";

switch(_operation) do {
        default {
                _args = [_logic, _operation, if(isNil "_args") then {nil}] call SUPERCLASS;
                
                _args;
        };
        case "destroy": {
                [_logic, "active", false] call MSO_fnc_CQB;
                [_logic, "debug", false] call MSO_fnc_CQB;
                {
                        [_logic,"delGroup",_x] call MSO_fnc_CQB;
                } foreach ([_logic, "groups"] call MSO_fnc_CQB);
                {
                        [_logic,"clearHouse",_x] call MSO_fnc_CQB;
                } foreach ([_logic, "houses"] call MSO_fnc_CQB);
                
                [_logic, _operation, if(isNil "_args") then {nil}] call SUPERCLASS;
        };
        
        case "debug": {
                if(isNil "_args") exitWith {
                        _logic getVariable ["debug", false];
                };
                
                ASSERT_TRUE(typeName _args == "BOOL",str _args);		
                
                if(
                        // xor check args is different to current debug setting
                        (_args || (_logic getVariable ["debug", false])) &&
                        {!(_args && (_logic getVariable ["debug", false]))}
                ) then {
                        _logic setVariable ["debug", _args];
                        private["_houses"];
                        
                        private["_activecount","_remaincount","_cqbai"];
                        _remaincount = count ([_logic, "houses"] call MSO_fnc_CQB);
                        _activecount = count ([_logic, "groups"] call MSO_fnc_CQB);
                        _cqbai = 0;
                        {
                                if (local leader _x) then {
                                        _cqbai = _cqbai + count units _x;
                                };
                        } forEach ([_logic, "groups"] call MSO_fnc_CQB);
                        format["CQB Population: %1 remaing positions | %2 active positions | %3 local CQB AI...", _remaincount, _activecount, _cqbai] call MSO_fnc_logger;
                };
                _args;
        };

        case "state": {
                private["_state","_data"];
                
                if(isNil "_args") then {
                        _state = [] call CBA_fnc_hashCreate;
                        // Save state
                        {
                                [_state, _x, _logic getVariable _x] call CBA_fnc_hashSet;
                        } forEach ["spawnDistance", "factions"];
                        
                        _data = [];
                        {
                                _data set [count _data,[
                                        getPosATL _x,
                                        typeOf _x,
                                        _x getVariable "unittypes"
                                ]];
                        } forEach (_logic getVariable "houses");
                        
                        [_state, "houses", _data] call CBA_fnc_hashSet;                        
                        
                        _state;
                } else {
                        if (isServer) then {
                                // Restore state
                                _logic setVariable ["spawnDistance", [_args, "spawnDistance"] call CBA_fnc_hashGet, true];
                                _logic setVariable ["factions", [_args, "factions"] call CBA_fnc_hashGet, true];
                                
                                // Un-initialise any previous settings for
                                {
                                        [_logic, "clearHouse", _x] call MSO_fnc_CQB;
                                } forEach ([_logic, "houses"] call MSO_fnc_CQB);
                                {
                                        [_logic, "delGroup", _x] call MSO_fnc_CQB;
                                } forEach ([_logic, "groups"] call MSO_fnc_CQB);
                                
                                // houses and groups
                                _data = [];
                                {
                                        private["_house"];
                                        _house = (_x select 0) nearestObject (_x select 1);
                                        _house setVariable ["unittypes", _x select 2, true];
                                        _data set [count _data, _house];
                                } forEach ([_args, "houses"] call CBA_fnc_hashGet);
                                _logic setVariable ["houses", _data, true];
                        };
                };		
        };
        case "factions": {
                if(isNil "_args") then {
                        // if no new faction list was provided return current setting
                        _args = _logic getVariable ["factions", []];		
                } else {
                        if(isServer) then {
                                // if a new faction list was provided set factions settings
                                ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
                                _logic setVariable ["factions", _args, true];
                        };
                };
                _args;
        }; 
        case "spawnDistance": {
                if(isNil "_args") then {
                        // if no new distance was provided return spawn distance setting
                        _args = _logic getVariable ["spawnDistance", DEFAULT_SPAWNDISTANCE];
                } else {
                        if(isServer) then {
                                // if a new distance was provided set spawn distance settings
                                ASSERT_TRUE(typeName _args == "SCALAR",str typeName _args);			
                                if(_args != _logic getVariable ["spawnDistance", DEFAULT_SPAWNDISTANCE]) then {
                                        _logic setVariable ["spawnDistance", _args, true];
                                };
                        };
                };
                _args;
        }; 
        
        case "houses": {
                private["_houses"];
                _houses = _logic getVariable ["houses", []];
                
                if(isNil "_args") then {
                        _args = _houses;
                } else {
                        if(isServer) then {
                                ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
                                _logic setVariable ["houses", _args, true];
                        };
                };
                
                if ([_logic, "debug"] call MSO_fnc_CQB) then {
                        {
                                deleteMarker format[_mtemplate, _x];
                        } forEach _houses;
                        
                        _houses = _args;
                        
                        // mark all strategic and non-strategic houses
                        {
                                [format[_mtemplate, _x], getPosATL _x, "Icon", [1,1], "TYPE:", "Dot", "COLOR:", _logic getVariable ["debugColor","ColorGreen"], "TEXT:", _logic getVariable ["debugPrefix","CQB"]] call CBA_fnc_createMarker;
                                if (!isNil {_x getVariable "group"}) then {
                                        // mark active houses
                                        format[_mtemplate, _x] setMarkerType "Waypoint";
                                };
                        } forEach _houses;
                };
                
                _args;
        };
        case "addHouse": {
                if(!isNil "_args") then {
                        ASSERT_TRUE(typeName _args == "OBJECT",str typeName _args);
                        private ["_house"];
                        _house = _args;
                        if(isServer) then {
                                [_logic,"houses",[_house],true,true] call BIS_fnc_variableSpaceAdd;
                        };
                        if ([_logic, "debug"] call MSO_fnc_CQB) then {
                                format["CQB Population: Adding house %1...", _house] call MSO_fnc_logger;
                                [format[_mtemplate, _house], getPosATL _house, "Icon", [1,1], "TYPE:", "Dot", "COLOR:", _logic getVariable ["debugColor","ColorGreen"], "TEXT:", _logic getVariable ["debugPrefix","CQB"]] call CBA_fnc_createMarker;
                        };
                        _logic getVariable ["houses", []];
                };
        };
        case "clearHouse": {
                if(!isNil "_args") then {
                        ASSERT_TRUE(typeName _args == "OBJECT",str typeName _args);
                        private ["_house","_grp"];
                        _house = _args;
                        // delete the group
                        _grp = _house getVariable "group";
                        if(isServer) then {
                                if(!isNil "_grp") then {
                                        [_logic, "delGroup", _grp] call MSO_fnc_CQB;
                                };
                                
                                [_logic,"houses",[_house],true] call BIS_fnc_variableSpaceRemove;
                        };
                        if ([_logic, "debug"] call MSO_fnc_CQB) then {
                                format["CQB Population: Clearing house %1...", _house] call MSO_fnc_logger;
                                deleteMarker format[_mtemplate, _house];
                        };
                        _logic getVariable ["houses", []];
                };
        };
        
        case "groups": {
                if(isNil "_args") then {
                        // if no new groups list was provided return current setting
                        _args = _logic getVariable ["groups", []];
                } else {
                        if(isServer) then {
                                // if a new groups list was provided set groups list
                                ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
                                _logic setVariable ["groups", _args, true];
                        };
                };
                _args;
        };	 
        
        case "addGroup": {
                if(!isNil "_args") then {
                        private ["_house","_grp"];
                        ASSERT_TRUE(typeName _args == "ARRAY",str typeName _args);
                        _house = ARG_1(_args,0);
                        ASSERT_TRUE(typeName _house == "OBJECT",str typeName _house);
                        _grp = ARG_1(_args,1);
                        ASSERT_TRUE(typeName _grp == "GROUP",str typeName _grp);
                        if(isServer) then {				
                                if (!([_house] call MSO_fnc_isHouseEnterable)) exitWith {
                                        [_logic, "clearHouse", _house] call MSO_fnc_CQB;
                                };
                                
                                [_logic,"groups",[_grp],true,true] call BIS_fnc_variableSpaceAdd;
                                _house setVariable ["group", _grp, true];
                                _grp setVariable ["house",_house, true];
                        };
                        if ([_logic, "debug"] call MSO_fnc_CQB) then {
                                format["CQB Population: Group %1 created on %2", _grp, owner leader _grp] call MSO_fnc_logger;
                        };
                        // mark active houses
                        format[_mtemplate, _house] setMarkerType "Waypoint";
                        
                        _logic getVariable ["groups", []];
                };
        };
        
        case "delGroup": {
                if(!isNil "_args") then {
                        ASSERT_TRUE(typeName _args == "GROUP",str typeName _args);
                        private ["_grp","_house"];
                        _grp = _args;
                        _house = _grp getVariable "house";
                        if(isServer) then {
                                // Update house that group despawned
                                _house setVariable ["group",nil, true];
                                // Despawn group
                                _grp setVariable ["house", nil, true];
                                [_logic,"groups",[_grp],true] call BIS_fnc_variableSpaceRemove;
                                {
                                        _x setDamage 1;
                                        deleteVehicle _x;
                                } forEach units _grp;
                        };
                        if ([_logic, "debug"] call MSO_fnc_CQB) then {
                                format["CQB Population: Group %1 deleted from %2...", _grp, owner leader _grp] call MSO_fnc_logger;
                        };
                        format[_mtemplate, _house] setMarkerType "Dot";
                        if(isServer) then {
                                deleteGroup _grp;
                        };
                        
                        _logic getVariable ["groups", []];
                };
        };
        
        case "active": {
                if(isNil "_args") exitWith {
                        _logic getVariable ["active", false];
                };
                
                ASSERT_TRUE(typeName _args == "BOOL",str _args);		
                
                // xor check args is different to current debug setting
                if(
                        ((_args || (_logic getVariable ["active", false])) &&
                        !(_args && (_logic getVariable ["active", false])))
                ) then {
                        ASSERT_TRUE(typeName _args == "BOOL",str _args);
                        _logic setVariable ["active", _args];
                        
                        // if active
                        if (_args) then {
                                
                                // spawn loop
                                _logic spawn {
                                        private ["_logic","_units","_grp","_positions","_house","_debug","_spawn","_maxgrps","_leader","_createUnitTypes","_despawnGroup"];
                                        _logic = _this;
                                        
                                        // default functions - can be overridden
                                        _createUnitTypes = {
                                                private ["_factions"];
                                                PARAMS_1(_factions);
                                                [_factions, ceil(random 2)] call MSO_fnc_chooseRandomUnits;
                                        };
                                        
                                        _despawnGroup = {
                                                private["_logic","_grp"];
                                                PARAMS_2(_logic,_grp);
                                                // update central CQB group listing
                                                [_logic, "delGroup", _grp] call MSO_fnc_CQB;
                                        };
                                        
                                        // over-arching spawning loop
                                        waitUntil{
                                                sleep 3;
                                                {
                                                        // if conditions are right, spawn a group and place them
                                                        _house = _x;
                                                        _debug = [_logic, "debug"] call MSO_fnc_CQB;
                                                        _spawn = [_logic, "spawnDistance"] call MSO_fnc_CQB;
                                                        
                                                        // Maximum number of groups per client
                                                        _maxgrps = 5;
                                                        
                                                        // Check: house doesn't already have AI AND
                                                        // Check: if any players within spawn distance AND
                                                        if (
                                                                (isNil {_house getVariable "group"}) &&
                                                                {([getPosATL _house, _spawn] call MSO_fnc_anyPlayersInRange) != 0}
                                                        ) then {
                                                                
                                                                // Action: spawn AI
                                                                // this just flags the house as beginning spawning
                                                                // and will be over-written in MSO_fnc_CQBspawnRandomgroup
                                                                _house setVariable ["group", "preinit", true];
                                                                
                                                                _units = _house getVariable ["unittypes", []];
                                                                if(count _units == 0) then {
                                                                        // identify AI unit types
                                                                        _units = [([_logic, "factions"] call MSO_fnc_CQB)] call (_logic getVariable ["_createUnitTypes", _createUnitTypes]);
                                                                        _house setVariable ["unittypes", _units, true];
                                                                };
                                                                
                                                                // that the player isn't already hosting too many AI AND
                                                                // that the player isn't already hosting too many groups simultaneously
                                                                if (
                                                                        (call MSO_fnc_isAbleToHost) &&
                                                                        {{local leader _x} count ([_logic, "groups"] call MSO_fnc_CQB) < _maxgrps}
                                                                ) then {
                                                                        // restore AI
                                                                        _grp = [getPosATL _house, east, _units] call BIS_fnc_spawnGroup;
                                                                        
                                                                        if (count units _grp == 0) exitWith {
                                                                                if (_debug) then {
                                                                                        format["CQB Population: Group %1 deleted on creation - no units...", _grp] call MSO_fnc_logger;
                                                                                };
                                                                                [_logic, "delGroup", _grp] call MSO_fnc_CQB;
                                                                        };
                                                                        // position AI
                                                                        _positions = [_house] call MSO_fnc_getBuildingPositions;
                                                                        {
                                                                                _x setPosATL (_positions call BIS_fnc_selectRandom);
                                                                        } forEach units _grp;
                                                                        [_logic, "addGroup", [_house, _grp]] call MSO_fnc_CQB;
                                                                        
                                                                        // TODO Notify controller to start directing
                                                                        // TODO this needs to be refactored
                                                                        //[_house, _grp] spawn MSO_fnc_CQBmovegroup;
                                                                        {
                                                                                private["_fsm","_hdl"];
                                                                                _fsm = "Enemy\scripts\HousePatrol.fsm";
                                                                                _hdl = [_x, 20, true, 120] execFSM _fsm;
                                                                                _x setVariable ["FSM", [_hdl,_fsm], true];
                                                                        } forEach units _grp;
                                                                };
                                                        };
                                                } forEach (_logic getVariable ["houses", []]);
                                                
                                                {
                                                        _grp = _x;
                                                        // get house in question
                                                        _house = _x getVariable "house";
                                                        
                                                        // if group are all dead
                                                        // mark house as cleared
                                                        if (count (units _grp) == 0) then {
                                                                // update central CQB house listings
                                                                [_logic, "clearHouse", _house] call MSO_fnc_CQB;
                                                        } else {
                                                                // if CQB-units are local (orphaned to server or clientside) and
                                                                // all players are out of range and house is still active
                                                                // despawn group but house not cleared
                                                                _leader = leader _grp;
                                                                if (
                                                                        local _leader &&
                                                                        {([getPosATL _house, _spawn * 1.1] call MSO_fnc_anyPlayersInRange) == 0}
                                                                ) then {
                                                                        // HH to over-ride to send back to home and delete
                                                                        // default is to delete
                                                                        [_logic,_grp] call (_logic getVariable ["_despawnGroup", _despawnGroup]);
                                                                };
                                                        };
                                                } forEach ([_logic, "groups"] call MSO_fnc_CQB);
                                                !([_logic,"active"] call MSO_fnc_CQB);
                                        }; // end over-arching spawning loop
                                        
                                        // clean up groups if deactivated
                                        {
                                                [_logic, "delGroup", _x] call MSO_fnc_CQB;
                                        } forEach ([_logic, "groups"] call MSO_fnc_CQB);
                                        
                                }; // end spawn loop
                        }; // end if active
                };
        };
};
