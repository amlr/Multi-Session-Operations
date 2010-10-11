/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

#define __MAX_TIMEOUT	240

private "_template";
_template = [GVAR(selectedTimerType),GVAR(selectedType),GVAR(roundsDelay),GVAR(roundsNumber)];

private ["_string1", "_string2"];
if (GVAR(selectedTimerType) == "IMMEDIATE") then {
	_string1 = QUOTE(GVAR(STR_local));
	_string2 = QUOTE(GVAR(STR_confirm))
} else {
	_string1 = QUOTE(GVAR(STR_localt));
	_string2 = QUOTE(GVAR(STR_confirmt))
};

[QUOTE(GVAR(groupchat)),[player,[_string1, mapGridPosition GVAR(position), _template select 1, _template select 3]]] call CBA_fnc_globalEvent;

sleep 4;
if (([GVAR(battery), _template] call BIS_ARTY_F_Available) AND GVAR(artilleryAvailable)) then {
	if ([GVAR(battery), GVAR(position), _template select 1] call BIS_ARTY_F_PosInRange) then {
		GVAR(artilleryAvailable) = false;
		publicVariable QUOTE(GVAR(artilleryAvailable));
		[QUOTE(GVAR(sidechat)),[playerSide,[_string2, mapGridPosition GVAR(position), _template select 1, _template select 3]]] call CBA_fnc_globalEvent;
		sleep 2;
		[QUOTE(GVAR(execute)),[GVAR(battery), GVAR(position), _template]] call CBA_fnc_globalEvent;
		waitUntil {GVAR(battery) getVariable "ARTY_ONMISSION"};
		_shot = false;
		_splash = false;
		_complete = false;
		_time2wait = time + __MAX_TIMEOUT;
		while {(!_shot or !_splash or !_complete) or time>_time2wait} do {
			if (!_shot) then {
				if (GVAR(battery) getVariable "ARTY_SHOTCALLED") then {
					[QUOTE(GVAR(sidechat)),[playerSide,[QUOTE(GVAR(STR_shot))]]] call CBA_fnc_globalEvent;
					_shot = true;
				};
			};
			if (!_splash) then {
				if (GVAR(battery) getVariable "ARTY_SPLASH") then {
					[QUOTE(GVAR(sidechat)),[playerSide,[QUOTE(GVAR(STR_splash))]]] call CBA_fnc_globalEvent;
					_splash = true;
				};
			};
			if (!_complete) then {
				if (GVAR(battery) getVariable "ARTY_COMPLETE") then {
					[QUOTE(GVAR(sidechat)),[playerSide,[QUOTE(GVAR(STR_rounds))]]] call CBA_fnc_globalEvent;
					_complete = true;
				};
			};
			sleep 1;
		};
		sleep 3;
		[QUOTE(GVAR(sidechat)),[playerSide,[QUOTE(GVAR(STR_complete))]]] call CBA_fnc_globalEvent;
		GVAR(artilleryAvailable) = true;
		publicVariable QUOTE(GVAR(artilleryAvailable));
	} else {
		[QUOTE(GVAR(sidechat)),[playerSide,[QUOTE(GVAR(STR_range))]]] call CBA_fnc_globalEvent;
	};
} else {
	[QUOTE(GVAR(sidechat)),[playerSide,[QUOTE(GVAR(STR_busy))]]] call CBA_fnc_globalEvent;
};