#include <script_macros_core.hpp>
SCRIPT(CQB_debug);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_CQB_debug

Description:
Enable or disable debug markers and logging

Parameters:
Object - CQB logic

Optional Parameters:
Boolean - Enable or disable debug

Returns:
Boolean - The current debug state

Examples:
(begin example)
// Set debug to true
[_logic, true] call MSO_fnc_CQB_debug;
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

private ["_logic","_debug","_houses"];

PARAMS_1(_logic);
DEFAULT_PARAM(1,_debug,_logic getVariable "debug");

if(_debug != _logic getVariable "debug") then {
        
        _houses = _logic getVariable "houses";
        
        if (_debug) then {
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

_debug;
