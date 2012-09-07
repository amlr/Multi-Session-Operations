#include <script_macros_core.hpp>
SCRIPT(CQB_create);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQB_create
Description:
Creates an instance of CQB class
Returns:
Object - The class instance

Attributes:
Boolean - debug - Debug enabled
Array - groups - List of AI groups performing CQB
Array - factions - specific factions used by CQB (defaults MSO_FACTIONS)
Number- spawnDistance - distance when AI will spawn for buildings.
Array - houses - List of uncleared strategic CQB buildings

Once a house is cleared, it is removed from the houses list and the group removed from groups.
If there are no players left in the area, the group is despawned and removed from groups.
Each house tracks its associated group, and each associated group tracks its assigned house.

Examples:
(begin example)
// Create CQB instance
_logic = call MSO_fnc_CQB_create;
// Enable debugging markers and logging
[_logic, true] call MSO_fnc_CQB_debug;
// Restore instance to a previously saved state
[_logic, _restored_data] call MSO_fnc_CQB_state;
// Set spawn distance
[_logic, 800] call MSO_fnc_CQB_spawnDistance;
// Set enemy factions
[_logc, ["BIS_TK_INS"]] call MSO_fnc_CQB_factions;
// Provide list of houses to populate
[_logic, [_myhouse]] call MSO_fnc_CQB_houses;
(end)

See Also:
- <MSO_fnc_CQB_debug>
- <MSO_fnc_CQB_state>
- <MSO_fnc_CQB_spawnDistance>
- <MSO_fnc_CQB_groups>
- <MSO_fnc_CQB_factions>
- <MSO_fnc_CQB_houses>

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_logic"];

// Create a module object for settings and persistence
_logic = (createGroup sideLogic) createUnit ["LOGIC", [0,0], [], 0, "NONE"];

// Initialise default settings
_logic setVariable ["debug", false];
_logic setVariable ["groups", []];
_logic setVariable ["spawnDistance", 800];
_logic setVariable ["factions", MSO_FACTIONS];
_logic setVariable ["houses", []];

_logic;
