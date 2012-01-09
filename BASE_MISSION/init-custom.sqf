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

	// Add ACRE box near current ammo boxes - ACRE_RadioBox
	if (isServer) then {
		private ["_radiomarkers"];
		_radiomarkers = ["ammo","ammo_1"];
		{
			private ["_pos","_newpos"];
			if !(str (markerPos _x) == "[0,0,0]") then {
				_pos = markerPos _x;
				if (count nearestObjects [_pos, ["ACRE_RadioBox"], 10] == 0) then {
					_newpos = [_pos, 0, 10, 2, 0, 0, 0] call BIS_fnc_findSafePos;
					"ACRE_RadioBox" createVehicle _newpos;
					diag_log format ["Creating ACRE Radio Box at %1", _newpos];
				};
			};
		} foreach _radiomarkers;
	};

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

// EOD Mod Configuration
if (isClass(configFile>>"CfgPatches">>"reezo_eod")) then {
	
	// Add THOR 3 backpacks to ammo crates or ACRE_RadioBox
	private ["_thors","_boxes","_crates","_boxmarkers","_crate","_number"];
	_boxmarkers = ["ammo","ammo_1"];
	_thors = ["SR5_THOR3", "SR5_THOR3_MAR", "SR5_THOR3_ACU"];
	_boxes = ["ACRE_RadioBox","ACE_RuckBox","BAF_BasicWeapons","USBasicWeaponsBox","USBasicWeapons_EP1"];
	_number = (count playableunits) * 3;
	_crates = [];
	{
		_crates = _crates + nearestObjects [markerPos _x, _boxes, 20];
	} foreach _boxmarkers;
	{
		_crate = _x;
		{
			_crate addweaponcargo [_x, _number];
			diag_log format ["Adding %1 to %2 at %3", _x, _crate, position _crate];
		} foreach _thors;
	} foreach _crates;

};