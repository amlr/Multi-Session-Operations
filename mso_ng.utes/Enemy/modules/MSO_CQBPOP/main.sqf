#include <script_macros_core.hpp>

/* ----------------------------------------------------------------------------
Description:
The main script for MSO CQB Populator

Author:
Highhead
Wolffy.au
---------------------------------------------------------------------------- */

private ["_debug","_logic","_spawnhouses","_result","_strategicTypes","_strategicHouses","_nonStrategicHouses"];

// Single player setting
if (isNil "CQB_spawn") then {CQB_spawn = 1};
// Exit if not enabled
if (CQB_spawn == 0) exitWith {"CQB Population turned off! Exiting..." call MSO_fnc_logger;};

_debug = true; //debug_mso;

if(isServer) then {
	// Get all enterable houses across the map
	_spawnhouses = call MSO_fnc_getAllEnterableHouses;
	// Sort and store strategic and non-strategic objects
	_strategicTypes = [
		"Land_A_TVTower_Base",
		"Land_Dam_ConcP_20",
		"Land_Ind_Expedice_1",
		"Land_Ind_SiloVelke_02",
		"Land_Mil_Barracks",
		"Land_Mil_Barracks_i",
		"Land_Mil_Barracks_L",
		"Land_Mil_Guardhouse",
		"Land_Mil_House",
		"Land_trafostanica_velka",
		"Land_Ind_Oil_Tower_EP1",
		"Land_A_Villa_EP1",
		"Land_Mil_Barracks_EP1",
		"Land_Mil_Barracks_i_EP1",
		"Land_Mil_Barracks_L_EP1",
		"Land_Barrack2",
		"Land_fortified_nest_small_EP1",
		"Land_fortified_nest_big_EP1",
		"Land_Fort_Watchtower_EP1",
		"Land_Ind_PowerStation_EP1",
		"Land_Ind_PowerStation"
	];
	// Exclude BIS_ZORA_x blacklist zones
	_result = [_spawnhouses, _strategicTypes, "BIS_ZORA_%1"] call MSO_fnc_CQBsortStrategicHouses;
	_strategicHouses = _result select 0;
	_nonStrategicHouses = _result select 1;
	
	// Create strategic CQB instance
	_logic = call MSO_fnc_CQB;
	[_logic, "houses", _strategicHouses] call MSO_fnc_CQB;
	[_logic, "factions", MSO_FACTIONS] call MSO_fnc_CQB;
	[_logic, "spawnDistance", 800] call MSO_fnc_CQB;
	_logic setVariable ["debugColor","ColorRed",true];
	_logic setVariable ["debugPrefix","Strategic",true];
	[_logic, "debug", _debug] call MSO_fnc_CQB;
	GVAR(strategic) = _logic;
	publicVariable "MSO_CQB_strategic";

	// Create nonstrategic CQB instance
	_logic = call MSO_fnc_CQB;
	[_logic, "houses", _nonStrategicHouses] call MSO_fnc_CQB;
	[_logic, "factions", MSO_FACTIONS] call MSO_fnc_CQB;
	[_logic, "spawnDistance", 500] call MSO_fnc_CQB;
	_logic setVariable ["debugPrefix","Regular",true];
	[_logic, "debug", _debug] call MSO_fnc_CQB;
	GVAR(regular) = _logic;
	publicVariable "MSO_CQB_regular";
};


waitUntil{!isNil {GVAR(strategic)}};
[GVAR(strategic), "active", true] call MSO_fnc_CQB;
diag_log ([GVAR(strategic), "state"] call MSO_fnc_CQB);

waitUntil{!isNil {GVAR(regular)}};
[GVAR(regular), "active", true] call MSO_fnc_CQB;
diag_log ([GVAR(regular), "state"] call MSO_fnc_CQB);
