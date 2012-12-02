/* ----------------------------------------------------------------------------
File: init.sqf

Description:
Top level init.sqf for MSO

Author:
Wolffy.au
---------------------------------------------------------------------------- */

#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

execNow "core\init.sqf";
execNow "enemy\init.sqf";

"Completed" call mso_fnc_initialising;
titleText ["", "BLACK IN"];
