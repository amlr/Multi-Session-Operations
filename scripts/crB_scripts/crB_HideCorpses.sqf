//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Inspired by:  Mr Murray Gravedigger
// Created: 20090930
// Contact: http://creobellum.org
// Purpose: Hide corpses
///////////////////////////////////////////////////////////////////
if (!isServer) exitWith{};

waitUntil{!isNil "bis_fnc_init"};

_this spawn {
	private ["_obj","_timeuntilhide","_dist"];
        _timeuntilhide = _this select 0;
	_dist = _this select 1;

	while{true} do {
		sleep _timeuntilhide;
		{
			_obj = _x;
			private["_x"];
			if (!(_obj call CBA_fnc_isAlive) && {_obj distance _x < _dist} count ([] call BIS_fnc_listPlayers) == 0) then {
				_obj call CBA_fnc_deleteEntity;
			};
		} forEach nearestObjects [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Man","Car","Tank","Air"], 20000];

		{
			if (not isnull _x) then {
				if !(_x call CBA_fnc_isAlive) then {
					_x call CBA_fnc_deleteEntity;
				};
			};
		} foreach allGroups;
	};
};