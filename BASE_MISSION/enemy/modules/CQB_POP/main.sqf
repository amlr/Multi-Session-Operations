if (isnil "CQB_spawn") then {CQB_spawn = 1};
if (CQB_spawn == 0) exitwith {diag_log format["MSO-%1 CQB Population turned off! Exiting...", time]};

if (isnil "CQBaicap") then {CQBaicap = 2};
switch (CQBaicap) do {
    case 0: {CQBaicap = 0; CQBaiBroadcast = true};
    case 1: {CQBaicap = 15; CQBaiBroadcast = false};
    case 2: {CQBaicap = 25; CQBaiBroadcast = false};
    case 3: {CQBaicap = 50; CQBaiBroadcast = false};
    case 4: {CQBaicap = 100; CQBaiBroadcast = false};
    case 5: {CQB_AUTO = true; CQBaiBroadcast = false};
	default {CQBaicap = 15; CQBaiBroadcast = false};
};

_debug = debug_mso;

if (isnil "BIN_fnc_taskDefend") then {BIN_fnc_taskDefend = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskDefend.sqf"};
if (isnil "BIN_fnc_taskPatrol") then {BIN_fnc_taskPatrol = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskPatrol.sqf"};
if (isnil "BIN_fnc_taskSweep") then {BIN_fnc_taskSweep = compile preprocessFileLineNumbers "enemy\scripts\BIN_taskSweep.sqf"};
if (isnil "CQB_functions") then {call compile preprocessFileLineNumbers "enemy\modules\CQB_POP\CQB_functions.sqf"};
waituntil {!isnil "CQB_functions"};

if (isServer) then {
_spawnhouses = [markerpos "ammo_1",CRB_LOC_DIST] call MSO_fnc_getEnterableHouses;
CQBpositionsStrat = [_spawnhouses] call MSO_fnc_CQBgetSpawnposStrategic;
CQBpositionsReg = [_spawnhouses] call MSO_fnc_CQBgetSpawnposRegular;

Publicvariable "CQBpositionsStrat";
Publicvariable "CQBpositionsReg";
};

if !(isDedicated) then {
	[_debug] spawn MSO_fnc_CQBclientloop;
};
