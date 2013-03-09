// Advanced Interaction Module Configuration

//Init AIM
if (isClass(configFile>>"CfgPatches">>"gbl_advanced_interaction")) then {
	_AIMinit = [] execVM "\gbl_advanced_interaction\scripts\init_interaction.sqf";
};

//Init Rations and Water
if (isClass(configFile>>"CfgPatches">>"gbl_field_rations")) then {
    
   private ["_descentratedrink", "_descentratefood"];

	  switch (aim_descentratedrink) do
	{
		case 0: { _descentratedrink = 0; };
		case 1: { _descentratedrink = (aim_descentratedrink / 100); }; // 0.01
		case 2: { _descentratedrink = ( 0.06 / aim_descentratedrink); }; // 0.03
		case 3: { _descentratedrink = (aim_descentratedrink / 30); }; // 0.1
		case 4: { _descentratedrink = (aim_descentratedrink / 20); }; // 0.2
		case 5: { _descentratedrink = (aim_descentratedrink / 10); }; // 0.5
	};
	
	  switch (aim_descentratefood) do
	{
		case 0: { _descentratefood = 0; };
		case 1: { _descentratefood = (aim_descentratefood / 100); }; // 0.01
		case 2: { _descentratefood = ( 0.06 / aim_descentratefood); }; // 0.03
		case 3: { _descentratefood = (aim_descentratefood / 30); }; // 0.1
		case 4: { _descentratefood = (aim_descentratefood / 20); }; // 0.2
		case 5: { _descentratefood = (aim_descentratefood / 10); }; // 0.5
	};

    if !(isHC) then {_AIMFRinit = [] execVM "\gbl_field_rations\scripts\Init_FRM.sqf"; gbl_descentRateDrink = _descentratedrink; gbl_descentRateFood = _descentratefood; };
  
    // Add Fieldrations box near current ammo boxes - GBL_UK_rationsbox
    if (isServer) then {
        private ["_rationsmarkers"];
        _rationsmarkers = ["ammo","ammo_1","ammoger"];
        {
                private ["_pos","_newpos","_crate"];
                if !(str (markerPos _x) == "[0,0,0]") then {
                        _pos = markerPos _x;
                        if (count nearestObjects [_pos, ["GBL_ItemsCrate"], 10] == 0) then {
                                _newpos = [_pos, 0, 10, 2, 0, 0, 0] call BIS_fnc_findSafePos;
                                _crate = "GBL_ItemsCrate" createVehicle _newpos;
                                _crate allowDamage false;
                                diag_log format ["Creating GBL itemsbox at %1", _newpos];
                                 [_crate, 2700] execVM "support\scripts\resupply.sqf";;
                        };
                };
        } foreach _rationsmarkers;
    };
};