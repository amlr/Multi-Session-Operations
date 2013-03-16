/* 
 * Filename:
 * playerRespawn.sqf 
 *
 * Description:
 * Called from init.sqf
 * 
 * Created by [KH]Jman
 * Creation date: 19/01/2011
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */

// ====================================================================================
// MAIN

//	 diag_log["playerRespawn: ", _this];

	_player = _this select 0;                              
	_corpse = _this select 1;

		_player setVariable ["damage", 0, true];
		_player setVariable ["head_hit", 0, true];
		_player setVariable ["body", 0, true];
		_player setVariable ["hands", 0, true];
		_player setVariable ["legs", 0, true];
		
		if (pdb_ace_enabled) then {[player,"Player is being respawned."] call PDB_FNC_ACE_WOUNDS;	};
		
		if (pdb_aim_enabled) then { 
		    _player setVariable ["gbl_drink_status", 100, true];
		    _player setVariable ["gbl_food_status", 100, true];
		    _player setVariable ["gbl_camelbak_state", 100, true];
			[player,"Player AIM is being reset."] call PDB_FNC_AIM; 
		};

// ====================================================================================