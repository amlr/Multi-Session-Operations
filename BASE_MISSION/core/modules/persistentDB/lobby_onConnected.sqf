/* 
 * Filename:
 * lobby_onConnected.sqf 
 *
 * Description:
 * Called from main.sqf

 * 
 * Created by [KH]Jman
 * Creation date: 30/09/2012
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */


// ====================================================================================
// MAIN

if ((isServer) || (isdedicated)) then {	
waituntil { (missionNameSpace getvariable "server_initcomplete" == 1) };
						if ( MISSIONDATA_LOADED == "false") then {	// only do this once
									[nil, "__SERVER__", nil] execVM "core\modules\persistentDB\initPlayerConnection.sqf";	 
									[nil, "__SERVER__", nil] execVM "core\modules\persistentDB\initServerConnection.sqf";					
						};			
};