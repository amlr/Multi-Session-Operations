// Written by EightySix
// Client Initialise

if(isDedicated) exitWith {};
WaitUntil{ Receiving_finish };

// work out what class the player has joined as
	_class = "soldier";
	_sniper = [player,"sniper"] call mps_class_check;	if(_sniper) then {_class = "sniper";};
	_mg = [player,"mg"] call mps_class_check;		if(_mg) then {_class = "mg";};
	_at = [player,"at"] call mps_class_check;		if(_at) then {_class = "at";};
	_engineer = [player,"engineer"] call mps_class_check;	if(_engineer) then {_class = "engineer";};
	_crewman = [player,"crewman"] call mps_class_check;	if(_crewman) then {_class = "crewman";};
	_pilot = [player,"pilot"] call mps_class_check;		if(_pilot) then {_class = "pilot";};

	mps_player_class = _class;

// Error messages when a player tries to enter something the should not
	mps_driver_error_pilot = {
		_vehicleType = typeof (_this select 0);
		_title = "Advanced Vehicles";
		_content = format[localize "STR_Client_Limit_Pilots", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName") ];
		_step = "Pilot Required";
		[_title,_content,_step] spawn mps_adv_hint;
	};
	mps_driver_error_crewman = {
		_vehicleType = typeof (_this select 0);
		_title = "Advanced Vehicles";
		_content = format[localize "STR_Client_Limit_Crew", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName") ];
		_step = "Crewman Required";
		[_title,_content,_step] spawn mps_adv_hint;
	};
	mps_driver_error_rank = {
		_vehicleType = typeof (_this select 0);
		_rank = _this select 1;
		_title = "Advanced Vehicles";
		_content = format[localize "STR_Client_Limit_rank", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName"),_rank];
		_step = "Rank Required";
		[_title,_content,_step] spawn mps_adv_hint;
	};
	mps_error_locked = {
		_vehicleType = typeof (_this select 0);
		_rank = _this select 1;
		_title = "Admin Restrictions";
		_content = format["The Administrator has locked this %1.<br/>If you wish to use this %1, the admin may unlock it for you.", getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName")];
		_step = "Admin Locked";
		[_title,_content,_step] spawn mps_adv_hint;
		(_this select 0) call mps_lock_vehicle;
	};

// Detect ACRE
	[] call compile preprocessFileLineNumbers (mps_path+"func\mps_func_detect_acre.sqf");

// ACE additions
	if(mps_ace_enabled) then {
		[player, _pilot] call ace_fnc_setCrewProtection;
	};

// Begin actions for vehicle Drivers
// Written by BON_IF
// Adapted by EightySix
	[] execFSM (mps_path+"fsm\mps_client_driver.fsm");

// Enable Restriction of 3rd Person
// Written by Xeno
// Adapted by EightySix
	[] execFSM (mps_path+"fsm\mps_client_3rdperson.fsm");

// Setup Client Event Handlers
	[] execVM (mps_path+"func\mps_func_client_eventhandlers.sqf");


// Begin Client Cursor Monitoring for actions on objects
	[] execVM (mps_path+"func\mps_func_client_cursortarget.sqf");

// Remove all gear from a joining player and equip defaults
	[] execVM (mps_path+"config\config_defaultgear.sqf");


waitUntil {!(isNull player)};


// Setup Respawn Variables
	mps_body = player;
	mps_death_effect = [] spawn {};
	mps_current_pos = getPosATL AIS_body;

// Call the Injury System. This is disabled in the event ACE_Wounds is enabled
// Written by BON_IF
// Adapted by EightySix

	player spawn mps_injury_sys_init;

// Setup JIP MHQ and enable mhq status updates
	[] spawn {
		{	_mhq = !isNil {_x getVariable "mhq_side"};
			if(_mhq) then {
				if(_x getVariable "mhq_status") then { [_x,true] call mps_mhq_update };
			};
		} forEach (nearestObjects [ [0,0], ["All"], 40000 ] );	

		"mhq_update" addPublicVariableEventHandler { (_this select 1) call mps_mhq_update; };
	};

// Initialise the Ranking System for players
	player spawn mps_rank_init;
	player spawn mps_rank_proxy;
	player spawn mps_rank_hud;

// Initialise the Player HUDs
	[] spawn mps_func_hud_aimpoint;
	[] spawn mps_func_hud_teamlist;
	[] spawn {
		mps_player_list = []; sleep 10;
		while {true} do {
			{
				if( ((side _x) == (playerSide)) && (_x IN (playableUnits+switchableunits)) && !(_x in mps_player_list) && _x != player ) then {
					mps_player_list = mps_player_list + [_x];
					_x spawn mps_func_hud_3d;
				};
			} foreach allUnits;
			{ if !(_x IN (playableUnits+switchableunits)) then { mps_player_list = mps_player_list - [_x]; }; } forEach mps_player_list;
			sleep 20;
		};
	};

	[] spawn { waitUntil {time > 2}; (findDisplay 46) displayAddEventHandler ["KeyDown","_this call mps_func_keyspressed"]; };

// Setup JIP deployed ammoboxes
	player spawn {

		private["_data","_position","_nearestboxes"];

		waitUntil {!isNil "mps_ammobox_list"};

		{
			_data = _x;
			if( (_data select 0) == side player) then{
				_position = (_data select 1);
				_nearestboxes = nearestObjects [_position,[mission_mobile_ammo],5];
				if(count _nearestboxes == 0) then {
					[_position] call mps_ammobox;
				};
			};

		}forEach mps_ammobox_list;
	};


