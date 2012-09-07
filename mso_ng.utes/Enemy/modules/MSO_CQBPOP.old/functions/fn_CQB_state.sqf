#include <script_macros_core.hpp>
SCRIPT(CQB_state);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQB_state

Description:
Enable or disable state markers and logging

Parameters:
Object - CQB logic

Optional Parameters:
Boolean - Enable or disable state

Returns:
Boolean - The current state state

Examples:
(begin example)
// Set state to true
[_logic, true] call MSO_fnc_CQB_state;
(end)

See Also:
- <MSO_fnc_CQB_create>
- <MSO_fnc_CQB_state>
- <MSO_fnc_CQB_spawnDistance>
- <MSO_fnc_CQB_groups>
- <MSO_fnc_CQB_factions>
- <MSO_fnc_CQB_houses>

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_logic","_state","_houses"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_state,_logic getVariable "state");

if(_state != _logic getVariable "state") then {
        
        _houses = _logic getVariable "houses";
        
        if (_state) then {
                // mark all strategic and non-strategic houses
                {
                        [str _x, position _x, "Icon", [1,1], "TYPE:", "Dot", "COLOR:", "ColorGreen", "TEXT:", "CQB"] call CBA_fnc_createMarker;
                } forEach _houses;
        } else {
                {
                        deleteMarker str _x;
                } forEach _houses;                
        };
};

_state;
