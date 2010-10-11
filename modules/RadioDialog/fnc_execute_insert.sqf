/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

#define __PILOT_TYPE	"USMC_Soldier_Pilot"
#define __TIMEOUT	1200

_available = false;
_helicopter = objNull;
{
	if (alive _x) then {
		// Can move, ie not disabled
		if (canMove _x) then {
			// Now check if it is away from its spawn
			if ((getPosATL _x) distance (_x getVariable QUOTE(GVAR(START_POSITION))) < 20) then {
				// It is, therefore does it have any crew
				if ({alive _x} count (crew _x) == 0) then {
					_available = true;
					_helicopter = _x;
				};
			};
		};
	};
	if (_available) exitwith {};
} foreach GVAR(helicopters);

if (isnull _helicopter) exitwith {
	[QUOTE(GVAR(sidechatHQ)),[playerSide,[QUOTE(GVAR(STR_unavailable))]]] call CBA_fnc_globalEvent;
};

if !(GVAR(helicopterAvailable)) exitwith {};

GVAR(helicopterAvailable) = false;
publicVariable QUOTE(GVAR(helicopterAvailable));

_insert_position = _this select 1;
[QUOTE(GVAR(sidechatHQ)),[playerSide,[QUOTE(GVAR(STR_insert_confirm)), mapGridPosition _insert_position]]] call CBA_fnc_globalEvent;

_side = _this select 0;
_group = createGroup _side;
_start_position = getposATL _helicopter;
_start_direction = getDir _helicopter;
_pilot = _group createunit [__PILOT_TYPE, _start_position, [], 0, "FORM"];
_gunner = _group createunit [__PILOT_TYPE, _start_position, [], 0, "FORM"];
if (isnull _pilot) exitwith {};

_pilot spawn {
	sleep __TIMEOUT;
	deletevehicle _this;
};

_pilot assignAsDriver _helicopter;
_gunner assignAsGunner _helicopter;

_pilot moveInDriver _helicopter;
_gunner moveInGunner _helicopter;

_pilot allowDamage false;

//sleep 2;

_helicopter engineOn true;

//sleep 2;

[_group, _insert_position, 0, "MOVE"] call CBA_fnc_addWaypoint;
[_group, _insert_position, 0,  "MOVE", "CARELESS", "YELLOW", "FULL", "STAG COLUMN", "(vehicle (leader this)) spawn CBA_fnc_landUnload"] call CBA_fnc_addWaypoint;
[_group, _start_position, 0, "MOVE"] call CBA_fnc_addWaypoint;

_helicopter flyInHeight 200;
/*
while {alive _vehicle} do {
	sleep 1;
	if (currentWaypoint _group == count (waypoints _group)) exitwith {
		waituntil {_vehicle distance _start_position < 200 OR !alive _vehicle};
		waituntil {velocity _vehicle distance [0,0,0] < 20};
	};
};

deletevehicle _pilot;
deletevehicle _gunner;

if (alive _vehicle) then {
	_vehicle engineOn false;
	_vehicle setposATL _start_position;
	_vehicle setdir _start_direction;
};*/