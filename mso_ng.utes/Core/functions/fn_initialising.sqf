#include <script_macros_core.hpp>
SCRIPT(initialising);

/* ----------------------------------------------------------------------------
Function: MSO_fnc_initialising

Description:
Initialisation message logger for MSO.

Output messages on-screen, Diary record and RPT.

Parameters:
String - Message to log 

Examples:
(begin example)
"BIS Garbage Collector" call mso_fnc_initialising;
(end)

See Also:
- <MSO_fnc_logger>

Author:
Wolffy.au
---------------------------------------------------------------------------- */

private["_text","_stage"];
PARAMS_1(_text);
_stage = format["Initialising: %1", _text];

player createDiaryRecord ["msoPage", ["Initialisation", _stage]]; 
titleText [_stage, "BLACK"];
_stage call mso_fnc_logger;

