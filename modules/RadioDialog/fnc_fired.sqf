/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

#define __TIMEOUT 15

if !(local (_this select 0)) exitwith {};
if !((_this select 4) in __SIGNAL_SMOKE) exitwith {};

_projectile = nearestObject [_this select 0,_this select 4];
while {velocity _projectile distance [0,0,0] > 2} do {
	sleep 1;
};
_landingpad = createvehicle ["HeliHEmpty", getposATL _projectile, [], 0, "NONE"];
while {not isnull _projectile} do {
	sleep 1;
};
sleep __TIMEOUT;
deletevehicle _landingpad;