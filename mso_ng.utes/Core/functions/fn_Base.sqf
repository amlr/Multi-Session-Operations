#include <script_macros_core.hpp>
SCRIPT(Base);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_Base
Description:
Base class

Parameters:
Nil or Object - If Nil, return a new instance. If Object, reference an existing instance.
String - The selected function
Array - The selected parameters

Returns:
Any - The new instance or the result of the selected function and parameters

Attributes:
Nil - destroy - Destroy instance
Boolean - debug - Debug enabled
Array - state - Save and restore sta

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
Wolffy.au
---------------------------------------------------------------------------- */
private ["_logic","_operation","_args"];

// Constructor - create a new instance
if(isNil "_this") exitWith {
	// Create a module object for settings and persistence
	ISNILS(sideLogic,createCenter sideLogic);
	ISNILS(MSO_FNC_GROUP,createGroup sideLogic; publicVariable "MSO_FNC_GROUP";);
	_logic = MSO_FNC_GROUP createUnit ["LOGIC", [0,0], [], 0, "NONE"];
	
	_logic setVariable ["class", MSO_fnc_Base];
	
	_logic;
};

PARAMS_1(_logic);
DEFAULT_PARAM(1,_operation,"");
DEFAULT_PARAM(2,_args,nil);

switch(_operation) do {
	default {
		format["%1 does not support %2 operation", _logic getVariable ["class", "unknown Class"], _operation] call MSO_fnc_logger;
	};
	
	case "destroy": {
		deleteVehicle _logic;
	};
};
