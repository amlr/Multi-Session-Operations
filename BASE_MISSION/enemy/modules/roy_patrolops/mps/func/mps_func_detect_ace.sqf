// Written by EightySix

if(!isServer) exitWith{};

	mps_ace_enabled = isClass(configFile/"CfgPatches"/"ace_main"); publicVariable "mps_ace_enabled";
	if(isNil "mps_ace_wounds") then {mps_ace_wounds = false}; publicVariable "mps_ace_wounds";

if(!mps_ace_enabled) exitWith {};

	ace_sys_aitalk_radio_enabled = true;		publicVariable "ace_sys_aitalk_radio_enabled";
	ace_sys_repair_default_tyres = true;		publicVariable "ace_sys_repair_default_tyres";
	ace_sys_tracking_markers_enabled = false;	publicVariable "ace_sys_tracking_markers_enabled";

	if (mps_ace_wounds) then {
		ACE_IFAK_Capacity = 4;				publicVariable "ACE_IFAK_Capacity";
		ace_wounds_prevtime = 300;			publicVariable "ace_wounds_prevtime";
		ace_sys_wounds_noai = true;			publicVariable "ace_sys_wounds_noai";
		ace_sys_wounds_leftdam = 0;			publicVariable "ace_sys_wounds_leftdam";
		ace_sys_wounds_all_medics = true;		publicVariable "ace_sys_wounds_all_medics";
		ace_sys_wounds_no_rpunish = true;		publicVariable "ace_sys_wounds_no_rpunish";
		ace_sys_wounds_ai_movement_bloodloss = true;	publicVariable "ace_sys_wounds_ai_movement_bloodloss";
		ace_sys_wounds_player_movement_bloodloss = false;	publicVariable "ace_sys_wounds_player_movement_bloodloss";

		ace_sys_wounds_enabled = true;			publicVariable "ace_sys_wounds_enabled";
	};