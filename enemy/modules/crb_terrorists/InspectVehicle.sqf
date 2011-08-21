/* Code to determine what happens if a terrorist detects BLUFOR when in a vehicle
Code is called when BLUFOR get within 700m of vehicle and are detected
Expected behaviour is that if a Terrorist Cell travelling by car detects BLUFOR that their behaviour is different than normal civilians. Options could include:
	1. Attempt to drive car away quickly (set new waypoint - return to town)
	2. Detonate a bomb
	3. Get out and fight
	4. Surrender */
	
private ["_terrorist","_debug","_vehicle","_grp","_fate","_pos","_trg","_targets","_destpos","_waittime"];

if(!isServer) exitWith{};

_debug = false;
	
// Get the terrorist vehicle
_pos = getpos (_this select 0);
_vehicle = nearestObject [_pos,"Car"];       

_waittime = time + 180;

// Get the list of vehicles that set off the trigger
_targets = _this select 1;

 if (_debug) then {
	diag_log format ["MSO-%1 Terrorists Cells: West Detected near %2 at %3:%4", time, typeof _vehicle, _pos, mapgridposition _pos];
};

// Check to see if vehicle has a driver
If !(isNull driver _vehicle) then {
	
	_terrorist = driver _vehicle;	
	_grp = group _terrorist;
	{_x disableAI "MOVE"; _x disableAI "ANIM"} foreach units _grp;
	
	// Stop Terrorists from doing anything
	_grp setBehaviour "CARELESS";
	leader _grp stop stop;

	_fate = round(random 6); // roll the dice!
	
	 if (_debug) then {
		diag_log format ["MSO-%1 Terrorists Cells: Terrorist in car %2 and fate rolls a %3", time, typeof _vehicle, _fate];
	};
	
	// Decide on Terrorist action

	//	1. Attempt to drive car away quickly (set new waypoint - return to town)
	If (_fate > 4) then {
		// Select a place to drive to
		_destpos = [position leader _grp, _debug] call CRB_fnc_GetNearestTown;
		if (_debug) then {
			diag_log format ["MSO-%1 Terrorists Cells: Terrorist car %2 at %3 is running away to %4 (Activated by %5)", time, typeof _vehicle, mapgridposition _vehicle, mapgridposition _destpos, typeof (_targets select 0)];
		};
		// Set waypoint
		_wp = _grp addwaypoint [position _destpos, 75];
		_grp setSpeedMode "FULL";
		_grp setCombatMode "BLUE";
		_wp setWaypointSpeed "FULL"; 
		_wp setWaypointCombatMode "BLUE";
		_wp setWaypointBehaviour "CARELESS";
		{_x enableAI "MOVE"; _x enableAI "ANIM"} foreach units _grp;
	};
	
	//	2. Approach BLUFOR then Detonate a bomb
	If (_fate == 4) then {
		if (_debug) then {
			diag_log format ["MSO-%1 Terrorists Cells: Terrorist car %2 at %3 is now suicide car bomb (Activated by %4)", time, typeof _vehicle, mapgridposition _vehicle, typeof (_targets select 0)];
		};	
		_trg = createTrigger["EmptyDetector",getPos _vehicle]; 
		_trg setTriggerArea[15,15,0,false];
		_trg setTriggerActivation["WEST","PRESENT",false];
		_trg setTriggerStatements["this && ({vehicle _x in thisList} count ([] call BIS_fnc_listPlayers) > 0)", "_bomb = nearestObject [getPos (thisTrigger), 'Car']; boom = 'Bo_MK82' createVehicle position _bomb;", ""]; 
		_trg attachTo [_vehicle,[0,0,0]];
		
		_grp setBehaviour "CARELESS";
		_grp setCombatMode "BLUE";
		_grp setSpeedMode "FULL";
		{_x enableAI "MOVE"; _x enableAI "ANIM"} foreach units _grp;
		while {_terrorist distance (_targets select 0) > 10} do {
			sleep 1; 
			_terrorist move getpos (_targets select 0);
		};
	};	
	
	//	4. Surrender 
	If (_fate == 3) then {
	
		_grp setBehaviour "CARELESS";
		if (_debug) then {
			diag_log format ["MSO-%1 Terrorists Cells: Terrorist car %2 at %3 will surrender if approached by %4 (Activated by %5)", time, typeof _vehicle, mapgridposition _vehicle, _waittime, typeof (_targets select 0)];
		};	
		waitUntil {sleep 1; _vehicle distance (_targets select 0) < 25 || _waittime < time};
		
		{_x enableAI "MOVE"; _x enableAI "ANIM"} foreach units _grp;
		
		if (_waittime > time) then {
			// Get the group out of the car if BLUFOR gets within 25m
			_grp leaveVehicle _vehicle;
			
			{
				_x setCaptive true;
				_x action ["DROPWEAPON", _x, primaryWeapon _x];
				_x switchmove "";
				_x playActionNow "Surrender";
				sleep (random 1);
			} foreach units _grp;
		};	
		
		//	3. Get out and fight
		If (_fate < 3) then {
			_grp setBehaviour "COMBAT";
			{_x enableAI "MOVE"; _x enableAI "ANIM"} foreach units _grp;
		};
	
	};
} else {
	// No driver
	// Check to see if it is booby trapped
	 if (_debug) then {
		diag_log format ["MSO-%1 Terrorists Cells: No driver in Terrorist car %2", time, typeof _vehicle];
	};
	_fate = 4; //round(random 6); // roll the dice!
	if (_fate > 3) then {
		// create trigger to detonate bomb - convertto SR5IED when its MP Compatible
		_trg = createTrigger["EmptyDetector",getPos _vehicle]; 
		_trg setTriggerArea[3,3,0,false];
		_trg setTriggerActivation["WEST","PRESENT",false];
		_trg setTriggerStatements["this && ({vehicle _x in thisList} count ([] call BIS_fnc_listPlayers) > 0)", "_bomb = nearestObject [getPos (thisTrigger), 'Car']; boom = 'Sh_100_HE' createVehicle position _bomb;", ""]; 
		_trg attachTo [_vehicle,[0,0,0]];
		 if (_debug) then {
			diag_log format ["MSO-%1 Terrorists Cells: Terrorist car %2 at %3 is boobytrapped", time, typeof _vehicle, mapgridposition _vehicle];
		};
	};	
		
};

