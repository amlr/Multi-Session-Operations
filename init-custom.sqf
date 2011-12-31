// Custom improvements that you may wish to implement

// ACE configuration
if (isClass(configFile>>"CfgPatches">>"ace_main")) then {
	enableEngineArtillery false;  //disable BI arty comp
	Ace_sys_wounds_no_medical_gear = true;  //disable ACE adding medical items
	ace_sys_wounds_noai = true;  //disable wounds for AI for performance
	ace_sys_eject_fnc_weaponcheck = {};  //disable aircraft weapon removal
};

// ACRE Config and sync
if (isClass(configFile>>"CfgPatches">>"acre_main")) then {

//	[0] call acre_api_fnc_setLossModelScale;  // Description: Specify any value between 1.0 and 0. Setting it to 0 means the loss model is disabled, 1 is default.

	runOnPlayers = {
		[] spawn
		{
			waitUntil {!isNil "mso_interaction_key"};
			["player", [mso_interaction_key], 4, ["scripts\callAcreSync.sqf", "main"]] call CBA_ui_fnc_add;
		};
	};

	if (!isDedicated) then {
		if (!isNull player) then  // non JIP
		{
			call runOnPlayers;
		}
		else 
		{
			[] spawn {
				waitUntil {!isNull player};
				call runOnPlayers;
			};
		};
	};
};