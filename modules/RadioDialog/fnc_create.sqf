/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

if !(_this select 2) exitwith {};
if ((_this select 1) != __DISPLAY_KEY) exitwith {};

if (dialog) exitWith {};
if (visibleMap) exitwith {};

if !([player] call ACE_fnc_HasRadio) exitwith {};

createDialog QUOTE(ADDON);