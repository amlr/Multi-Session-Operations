// ACE DATA MODEL

// Get ACE Data
G_ACE_DATA_PROCEDURE = "UpdatePlayerACE"; 

G_ACE_PARAMS = ["tawb","tarc","taw","tarm"];

G_ACE_DATA = [
	{(_this select 0) getVariable ["WOB",""];},
	{(_this select 0) getVariable ["RUCK",""];},  //[(_this select 0)] call ACE_fnc_FindRuck;
	{(_this select 0) getVariable ["WEAPON",""];},
	{(_this select 0) getVariable ["MAGAZINE",""];}
	/* OTHER ACE SETTINGS THAT COULD BE STORED
	{(_this select 0) getVariable ["ace_sys_goggles_earplugs",false];},
	{(_this select 0) getVariable ["ace_sys_goggles_identity",""];},
	{EMP_RF_BAT;}, // Rangefinder
	{(_this select 0) getVariable "ace_w_head_hit";}, // ACE Wounds
	{(_this select 0) getVariable "ace_w_body";},
	{(_this select 0) getVariable "ace_w_hands";},
	{(_this select 0) getVariable "ace_w_legs";},
	{(_this select 0) getVariable ["ace_w_state",0];},
	{(_this select 0) getVariable "ace_sys_wounds_uncon";},
	{(_this select 0) getVariable "ace_w_bleed";},
	{(_this select 0) getVariable "ace_w_bleed_add";},
	{(_this select 0) getVariable "ace_w_pain";},
	{(_this select 0) getVariable "ace_w_pain_add";},
	{(_this select 0) getVariable "ace_w_epi";},
	{(_this select 0) getVariable "ace_w_nextuncon";},
	{(_this select 0) getVariable "ace_w_unconlen";},
	{(_this select 0) getVariable "ace_w_stab";},
	{(_this select 0) getVariable "ace_w_cutofftime";},
	{(_this select 0) getVariable "ace_w_carry";},
	{(_this select 0) getVariable "ace_w_revive";},
	{(_this select 0) getVariable "ace_w_wakeup";}*/
];

// Set ACE Data
S_ACE_DATA_PROCEDURE = "GetPlayerACE"; 

S_ACE_DATA = [
	{ 	(_this select 1) setVariable ["WOB", _this select 0, true];         
		(_this select 1) addWeapon (_this select 0);
        [(_this select 1), (_this select 0)] call ACE_fnc_PutWeaponOnBack;}, // ACE Weapon on Back

	{	if (_this != "") then {
			(_this select 1) addWeapon (_this select 0);
			[(_this select 1), "ALL"] call ACE_fnc_RemoveGear;
        };}, // ACE Ruck
		
	{ 	(_this select 1) setVariable ["WEAPON", _this select 0, true];
		{
			[(_this select 1), (_this select 0) select 0, (_this select 0) select 1] call ACE_fnc_PackWeapon;
        } forEach (_this select 0);}, // ACE Ruck Weapons
	
	{ 	(_this select 1) setVariable ["MAGAZINE", _this select 0, true];         
        {
			[(_this select 1), (_this select 0) select 0, (_this select 0) select 1] call ACE_fnc_PackMagazine;
        } forEach (_this select 0);} // ACE Ruck Mags
];








