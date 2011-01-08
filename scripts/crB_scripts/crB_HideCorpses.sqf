//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Inspired by:  Mr Murray Gravedigger
// Created: 20090930
// Contact: http://creobellum.org
// Purpose: Hide corpses
///////////////////////////////////////////////////////////////////
if (!isServer) exitWith{};

[_this select 0] spawn {
	_timeuntilhide = _this select 0;

	while{true} do {
		sleep _timeuntilhide;
		{
			if !(_x call CBA_fnc_isAlive) then{
				_x call CBA_fnc_deleteEntity;
			};
		} forEach nearestObjects [getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Man","Car","Tank","Air"] , 20000] + allGroups;
	};
};