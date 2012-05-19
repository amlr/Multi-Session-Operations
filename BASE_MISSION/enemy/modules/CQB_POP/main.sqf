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
if (isnil "MSO_fnc_CQBspawnRandomgroup") then {MSO_fnc_CQBspawnRandomgroup = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\spawngroup.sqf"};
if (isnil "MSO_fnc_CQBmovegroup") then {MSO_fnc_CQBmovegroup = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\movegroup.sqf"};
if (isnil "MSO_fnc_CQBspawnpositions") then {MSO_fnc_CQBspawnpositions = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\getspawnpositions.sqf"};
if (isnil "MSO_fnc_CQBclientloop") then {MSO_fnc_CQBclientloop = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\clientloop.sqf"};
if (isnil "MSO_fnc_CQBhousepos") then {MSO_fnc_CQBhousepos = compile preprocessFileLineNumbers "enemy\modules\CQB_POP\CQB_HousePos.sqf"};

CQBspawnscript = 0;

if (isServer) then {
CQBpositions = [] call MSO_fnc_CQBspawnpositions;
Publicvariable "CQBpositions";
};

if !(isDedicated) then {
	[_debug] spawn MSO_fnc_CQBclientloop;
};
