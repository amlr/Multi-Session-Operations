/* 
 * Filename:
 * pdbSetup.sqf
 *
 * Description:
 * Setup file for PDB
 * 
 * Created by [KH]Jman
 * Creation date: 31/12/2011
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */

// ====================================================================================


	pdb_fullmissionName = missionName;   // the full unique mission name that will appear in the database
	pdb_shortmissionName = format["MSO %1", mso_version]; // for BIS_fnc_infoText
	pdb_author = "Thanks to the PDB Dev Team"; // for BIS_fnc_infoText
	
	// The following are set initially with a mission param or by default and then overridden by the mission DB vars if mission exists
	// mpdb = mission param variable
	// pdb = setting used by pdb
	if (isnil"mpdb_date_enabled" || mpdb_date_enabled == 1) then {pdb_date_enabled = true;} else {pdb_date_enabled = false;};
	if (isnil"mpdb_persistentScores_enabled" || mpdb_persistentScores_enabled == 1) then { pdb_persistentScores_enabled = true;} else { pdb_persistentScores_enabled = false;};
	if (isnil"mpdb_globalScores_enabled" || mpdb_globalScores_enabled == 1) then { pdb_globalScores_enabled = true;} else {pdb_globalScores_enabled = false;};
	if (isnil"mpdb_log_enabled" || mpdb_log_enabled == 1) then {pdb_log_enabled = true;} else {pdb_log_enabled = false;};
	if (isnil"mpdb_weapons_enabled" || mpdb_weapons_enabled == 1) then { pdb_weapons_enabled = true;} else {pdb_weapons_enabled = false;};
	if (isClass(configFile>>"CfgPatches">>"ace_main")) then {mpdb_ace_enabled = 1; pdb_ace_enabled = true;} else {mpdb_ace_enabled = 0; pdb_ace_enabled = false;};
	
	if (isnil"mpdb_landvehicles_enabled" || mpdb_landvehicles_enabled == 1) then { pdb_landvehicles_enabled = true;} else {pdb_landvehicles_enabled = false;};  // not yet fully implemented.
	
	if (isnil"pdb_man_enabled" || pdb_man_enabled == 0) then { pdb_man_enabled = false;} else {pdb_man_enabled = true;}; // not yet implemented.
	if (isnil"pdb_air_enabled" || pdb_air_enabled == 0) then {pdb_air_enabled = false;} else {pdb_air_enabled = true;}; // not yet implemented.
	if (isnil"pdb_ship_enabled" || pdb_ship_enabled == 0) then {pdb_ship_enabled = false;} else {pdb_ship_enabled = true;}; // not yet implemented.
	if (isnil"pdb_building_enabled" || pdb_building_enabled == 0) then {pdb_building_enabled = false;} else {pdb_building_enabled = true;}; // not yet implemented.
	if (isnil"pdb_marker_enabled" || pdb_marker_enabled == 0) then {pdb_marker_enabled = false;} else {pdb_marker_enabled = true;}; // not yet implemented.
	if (isnil"pdb_bans_enabled" || pdb_bans_enabled == 0) then {pdb_bans_enabled = false;} else {pdb_bans_enabled = true;}; // not yet implemented.
	
// ====================================================================================
