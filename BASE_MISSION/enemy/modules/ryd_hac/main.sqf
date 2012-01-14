#include <crbprofiler.hpp>

if(!isServer) exitWith{};

if (isNil ("Ryd_header")) then {Ryd_header = 1;};
if (Ryd_header == 0) exitWith{};

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

RYD_HAC_PATH = "enemy\modules\RYD_HAC\";

// Set HETMAN variables 
If (isNil ("RydHQ_Order_param")) then {RydHQ_Order_param = 0};
switch (RydHQ_Order_param) do {
	case 0 : {RydHQ_Order = "ATTACK"};
	case 1 : {RydHQ_Order = "DEFEND"};
};

If (isNil ("RydHQ_Fast_param")) then {RydHQ_Fast_param = 0};
switch (RydHQ_Fast_param) do {
	case 0 : {RydHQ_Fast = false};
	case 1 : {RydHQ_Fast = true};
};

If (isNil ("RydHQ_CommDelay_param")) then {RydHQ_CommDelay_param = 1};
switch (RydHQ_CommDelay_param) do {
	case 0 : {RydHQ_CommDelay = 1};
	case 1 : {RydHQ_CommDelay = 2};
};

If (isNil ("RydHQ_Personality_param")) then {RydHQ_Personality_param = 8};
switch (RydHQ_Personality_param) do {
	case 0 : {RydHQ_Personality = "GENIUS"};
	case 1 : {RydHQ_Personality = "IDIOT"};
	case 2 : {RydHQ_Personality = "COMPETENT"};
	case 3 : {RydHQ_Personality = "EAGER"};
	case 4 : {RydHQ_Personality = "DILATORY"};
	case 5 : {RydHQ_Personality = "SCHEMER"};
	case 6 : {RydHQ_Personality = "BRUTE"};
	case 7 : {RydHQ_Personality = "CHAOTIC"};
	case 8 : {RydHQ_Personality = "RANDOM"};
};

If (isNil ("RydHQ_Debug_param")) then {RydHQ_Debug_param = 0};
switch (RydHQ_Debug_param) do {
	case 0 : {RydHQ_Debug = false};
	case 1 : {RydHQ_Debug = true};
};

// Edit as necessary
RydHQ_Excluded = [];

If (isNil ("RydHQ_Wait")) then {RydHQ_Wait = 15};

RydHQ_Surrender = false;
RydHQB_Surrender = false;
RydHQ_Done = true;
RydHQB_Done = true;

// Pick Enemy HQ position
_leaderLoc = [["Strategic"],false,"colorRed","o_hq"] call mso_core_fnc_findLocationsByType;
_leaderPos = (_leaderLoc) call BIS_fnc_selectRandom;
_leaderHQPos = position _leaderPos;

if ( _leaderHQPos distance hospital < 2000) then {
	_leaderHQPos = [0,0,0];
};

// Create leaderHQ unit
_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[8,6,3,1]] call mso_core_fnc_selectRandomBias;
_group = createGroup east;
_pos2 = [_leaderHQPos, 10, 100, 10, 0, 5, 0] call bis_fnc_findSafePos;
_group = [_pos2, _type, MSO_FACTIONS] call mso_core_fnc_randomGroup;
leaderHQ = leader _group;
leaderHQ addweapon "EvMoney";
leaderHQ addweapon "PMC_documents";
leaderHQ addweapon "Kostey_photos";
leaderHQ addweapon "acre_prc148";
leaderHQ addweapon "itemgps";
leaderHQ setskill 1;
(group leaderHQ) allowFleeing 1;

if (RydHQ_Debug) then {
	diag_log format ["MSO-%1 HETMAN: leaderHQ is %2 - %3 located at %4", time, name leaderHQ, typeOf leaderHQ, _leaderHQPos];
};

if not (isNil ("leaderHQ")) then {
	nul = [] execvm (RYD_HAC_PATH + "A\HQSitRep.sqf");
} else{
	diag_log format ["MSO-%1 HETMAN: leaderHQ is invalid - %2", time, leaderHQ];
};
