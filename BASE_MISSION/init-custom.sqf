// Custom improvements that you may wish to implement - currently supporting ACE, ACRE, EOD and CIM

// ACE configuration
if (isClass(configFile>>"CfgPatches">>"ace_main")) then {
	enableEngineArtillery true;  //disable BI arty comp
	Ace_sys_wounds_no_medical_gear = true;  //disable ACE adding medical items
	ace_sys_wounds_noai = true;  //disable wounds for AI for performance
	ace_sys_eject_fnc_weaponcheck = {};  //disable aircraft weapon removal
	[player,"ACE_KeyCuffs"] call CBA_fnc_addWeapon;
	[player,"ACE_GlassesLHD_glasses"] call CBA_fnc_addWeapon;
	[player,"ACE_Earplugs"] call CBA_fnc_addWeapon;
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
if (isNil "tup_ied_eod")then{tup_ied_eod = 1;};
if (isServer) then {
	if ((isClass(configFile>>"CfgPatches">>"reezo_eod")) && (tup_ied_eod == 1)) then {
		
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
			} foreach _thors;
		} foreach _crates;
		diag_log format ["Added %1 THOR III devices to %2 crate(s)", (count _thors) * (count playableunits), count _crates];
		
		// Add Loudspeaker to any vehicles nearby ammo markers
		_speakernum = 1;
		{
			private ["_prob","_tits","_posx","_list"];
			_tits = 0;
			_posx = markerPos _x;
			if !(str (markerPos _x) == "[0,0,0]") then {
				_prob = 0.7 + random 0.3;
				// Create Loudspeaker logic
				"reezo_eod_loudspeaker" createUnit [_posx, group BIS_functions_mainscope,
					format["loudspeaker_%2 = this; this setVariable ['reezo_eod_range',[0,50]];
					this setVariable ['reezo_eod_probability',%1];
					this setVariable ['reezo_eod_interval',20];",_prob, _speakernum], 
					0, ""];
				// Find cars nearby
				_list = nearestObjects [_posx, ["Car"], 150];
				// Sync cars to loudspeaker
				{
					if ((_x isKindOf "Wheeled_APC") || (_x isKindOf "LandRover_Base") || (_x isKindOf "HMMWV_Base") || (_x isKindOf "BAF_Jackal2_BASE_D") || (_x isKindOf "UAZ_Base")) then {
						call compile format ["loudspeaker_%1 synchronizeObjectsadd [_x];",_speakernum];
						_tits = _tits + 1;
					};
				} foreach _list;
				diag_log format ["Synchronised %2 out of %1 possible cars to EOD Loudspeaker.", count _list, _tits];
				_speakernum = _speakernum + 1;
			};
		} foreach _boxmarkers;
	};
};

// Civilian Interaction Module Configuration

if (isClass(configFile>>"CfgPatches">>"nielsen_cim")) then {

	if (isServer) then {
		// Place Interaction Module
		if (isClass(configFile>>"CfgPatches">>"ace_main")) then {
			"nielsen_cim" createUnit [position BIS_functions_mainscope,group BIS_functions_mainscope,"
				this setVariable ['nielsen_cim_disableAUDIO',false]; 
				this setVariable ['nielsen_cim_authority',0.92]; 
				this setVariable ['nielsen_cim_enableACE',true];", 0, ""];
		} else {
			"nielsen_cim" createUnit [position BIS_functions_mainscope,group BIS_functions_mainscope,"
				this setVariable ['nielsen_cim_disableAUDIO',false]; 
				this setVariable ['nielsen_cim_authority',0.92];", 0, ""];
		};
		
		// Create extraction helipad
		_pos = [getmarkerpos "hospital", 0, 100, 20, 0, 3, 0] call BIS_fnc_findSafePos;
		"HeliHCivil" createvehicle _pos;
		_extractmarker = ["extraction", _pos, "Icon", [1, 1], "GLOBAL"] call CBA_fnc_createMarker;
		
		// Place Extraction Module
		("nielsen_cem" createUnit [position BIS_functions_mainscope,group BIS_functions_mainscope,"
			this setVariable ['nielsen_cEm_marker','extraction']; 
			this setVariable ['nielsen_cEm_disableSmoke',false]; 
			this setVariable ['nielsen_cEm_SmokeType',['SmokeShellRed']]; 
			this synchronizeObjectsadd ([] call bis_fnc_listPlayers);", 0, ""]);

		// Set up CRM markers for each location
		_i = 0;
		{
			_i = _i +1;
			_markername = format ["crm_marker_%1", _i];
			_marker = [_markername, position _x, "Icon", [1, 1], "GLOBAL"] call CBA_fnc_createMarker;
		} foreach (bis_functions_mainscope getvariable "locations");
		
		// Place CRM module and sync to players
		("nielsen_crm" createUnit [position BIS_functions_mainscope,group BIS_functions_mainscope,"
			this setVariable ['nielsen_crm_events_range',300]; 
			this setVariable ['nielsen_crm_events_chance',0.66]; 
			this setVariable ['nielsen_crm_events',['gathering','intel','ambush']];
			this setVariable ['nielsen_crm_evidence',true];
			this setVariable ['nielsen_crm_evidence_time',180];
			this setVariable ['nielsen_crm_evidence_chance',0.25];
			this setVariable ['nielsen_crm_Locations', count (bis_functions_mainscope getvariable 'locations')];
			this synchronizeObjectsAdd ([] call bis_fnc_listPlayers);", 0, ""]);
			
			waituntil {sleep 1; count CRM_AllGroups > 0};
			
			publicvariable "CRM_AllGroups";
	};
	
	// Create text hint over extraction chopper so players aren't confused.
	["HVT Extraction Team", getmarkerpos "extraction", 10, 0.5] spawn BIS_fnc_3Dcredits;
	
	// Add JIP Code - add player group to CRM_ALLGroups
	if !(isNull player) then {
		_grp = group player;
		if !(_grp in CRM_AllGroups) then {
			CRM_AllGroups = CRM_AllGroups + [_grp];
			publicvariable "CRM_AllGroups";
		};
	};
			
};