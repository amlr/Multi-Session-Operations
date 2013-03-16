/* 
 * Filename:
 * aim.sqf 
 *
 * Description:
 * Called from persistentDB\pdbsetup.sqf
 * runs on client/server
 * 
 * Created by [KH]Jman
 * Creation date: 11/01/20130
 * Email: jman@kellys-heroes.eu
 * Web: http://www.kellys-heroes.eu
 * 
 * */
// ====================================================================================

// AIM DATA MODEL

// Get AIM Data
G_AIM_DATA_PROCEDURE = "UpdatePlayerAIM"; 
G_AIM_DATA_PARAMS = ["taim"]; 
G_AIM_DATA = [
	{(_this select 0) getVariable ["AIM_RATIONS",""];}
];


// Set AIM Data
S_AIM_DATA_PROCEDURE = "GetPlayerAIM"; 
S_AIM_DATA = [
{
		(_this select 1) setVariable ["AIM_RATIONS", _this select 0, true];
		if (typename (_this select 0) == "ARRAY") then {
			(_this select 1) setVariable ["gbl_drink_status", (_this select 0) select 0, true];
			(_this select 1) setVariable ["gbl_food_status", (_this select 0) select 1, true];
			(_this select 1) setVariable ["gbl_camelbak_state", (_this select 0) select 2, true];
		};
} //  AIM_RATIONS
];



