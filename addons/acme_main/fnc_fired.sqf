/* 
 * Filename:
 * playerFired.sqf 
 *
 * Description:
 * 
 * 
 * Created by Tupolov
 * Creation date: 19/05/2012
 * 
 * */

// ====================================================================================
// MAIN

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_shotsfired"];
PARAMS_1(_player);

//diag_log["playerFired: ", _this];

_player = _this select 0;                              

if (_player == player) then {
	
	_shotsfired = (_player getvariable "pshotsfired") + 1;
	
	//hintsilent format["%1", _shotsfired];

	_player setVariable ["pshotsfired", _shotsfired, true];

};
		
// ====================================================================================