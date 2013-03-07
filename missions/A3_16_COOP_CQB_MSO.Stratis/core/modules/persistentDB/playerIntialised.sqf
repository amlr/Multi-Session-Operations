/* 
 * Filename:
 * playerIntialised.sqf 
 *
 * Description:
 * Called from persistentDB\main.sqf
 * runs on client
 * 
 * Created by [KH]Jman
 * Creation date: 10/01/2013
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */

// ====================================================================================
// MAIN

//	 diag_log["playerIntialised: ", _this];

	_player = _this select 0;  
	                           
  if (player != _player) exitWith { }; // Im not the player so I shouldn't continue

	[player,"Player is fully intialised."] call PDB_FNC_PLAYER_INTIALISED;

// ====================================================================================