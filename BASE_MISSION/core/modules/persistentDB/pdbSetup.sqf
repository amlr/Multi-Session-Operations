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
	pdb_author = "MSO Development Team"; // for BIS_fnc_infoText
	
	// The following are overridden by the mission DB vars...
	pdb_date_enabled = true;
	pdb_persistentScores_enabled = true;
	pdb_globalScores_enabled = true;
	pdb_log_enabled = true;
	pdb_weapons_enabled = true;
	pdb_ace_enabled = true;
	pdb_landvehicles_enabled = false;  // not yet fully implemented.
	pdb_man_enabled = false; // not yet implemented.
	pdb_air_enabled = false; // not yet implemented.
	pdb_ship_enabled = false; // not yet implemented.
	pdb_building_enabled = false; // not yet implemented.
	pdb_marker_enabled = false; // not yet implemented.
	pdb_bans_enabled = false; // not yet implemented.
	

	


// ====================================================================================
