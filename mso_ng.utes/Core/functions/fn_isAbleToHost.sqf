#include <script_macros_core.hpp>
SCRIPT(isAbleToHost);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_isAbleToHost

Description:
Returns true if the local client is able to host more AI

Returns:
Boolean - Returns true if the local client is able to host more AI

Examples:
(begin example)
if (call MSO_fnc_isAbleToHost) then {hint "Give me more AI!";};
(end)

Author:
Wolffy.au
---------------------------------------------------------------------------- */

(({local _x} count allUnits) <= ceil(count allUnits / count ([] call BIS_fnc_listPlayers))) && (!isServer);
