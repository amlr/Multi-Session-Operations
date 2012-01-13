private ["_gcdist","_pos","_units","_unit","_timeout"];
_gcdist = 600;
diag_log format["MSO-%1 Test Garbage Collector Start", time];

_pos = player modelToWorld [0, _gcdist];

//--- Is Garbage collector running?
waitUntil{!isNil "BIS_functions_mainscope"};
if (isnil "BIS_GC_trashItFunc") then {
	(group BIS_functions_mainscope) createUnit ["GarbageCollector", position BIS_functions_mainscope, [], 0, "NONE"];
};
waitUntil{!isNil "BIS_GC"};
diag_log format["MSO-%1 Test Garbage Collector - GC loaded - %2", time, !isNil "BIS_GC"];
//BIS_GC setVariable ["auto", false];
diag_log format["MSO-%1 Test Garbage Collector - GC auto-scavenge - %2", time, BIS_GC getVariable "auto"];

// Create empty vehicles
_units = [];
_unit = createVehicle ["MTVR", _pos, [], 50, "NONE"];
_units set [count _units, _unit];

_unit = createVehicle ["M1A1", _pos, [], 50, "NONE"];
_units set [count _units, _unit];

_unit = createVehicle ["MH60S", _pos, [], 50, "NONE"];
_units set [count _units, _unit];

// Create units
_unit = (createGroup west) createUnit ["USMC_Soldier", _pos, [], 500, "NONE"];
_units set [count _units, _unit];

//--- Execute Functions
if (isnil "bis_fnc_init") then {
	(group BIS_GC) createunit ["FunctionsManager",[0,0,0],[],0,"none"];
};
waituntil {!isnil "BIS_fnc_init"};
_unit = [player modelToWorld [0, _gcdist + 20], 0, "MTVR", west] call BIS_fnc_spawnVehicle;
_units set [count _units, _unit select 0];

_unit = [player modelToWorld [20, _gcdist], 0, "M1A1", west] call BIS_fnc_spawnVehicle;
_units set [count _units, _unit select 0];

_unit = [player modelToWorld [-20, _gcdist], 0, "MH60S", west] call BIS_fnc_spawnVehicle;
_units set [count _units, _unit select 0];

{
	{_x setDamage 1} forEach units _x;
	_x setDamage 1;
} forEach _units;
diag_log format["MSO-%1 Test Garbage Collector - Creating destroyed unit(s) & vehicle(s) - %2", time, count _units];

_timeout = time + 600;

while{time < _timeout && {!isNull _x} count _units > 0} do {
	sleep 5;
};

if ({isNull _x} count _units > 0) then {
	diag_log format["MSO-%1 Test Successful Garbage Collector", time];
	true;
} else {
	diag_log format["MSO-%1 Test ***Failed*** Garbage Collector", time];
	false;
};
