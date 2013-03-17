diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Escort Officer Initialise"];

private["_location","_position","_taskid","_grp","_type","_object"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],1000,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_camptype = "FuelDepot_US"; if(mps_oa) then {_camptype = "FuelDepot_US_EP1";};
	_newComp = [_position,random 360,_camptype] call BIS_fnc_dyno;
	_lobjects = nearestObjects[_position,["All"],100];

	_grp = createGroup (SIDE_A select 0);
	_type = mps_blufor_leader call mps_getRandomElement;
	_object = _grp createUnit [ _type, ( getMarkerPos format["return_point_%1",(SIDE_A select 0)] ), [], 0, "NONE"];
	_object setRank "PRIVATE";

	[nil, _object, "per", rADDACTION, (format ["<t color=""#00FF00"">Request %1 to follow</t>",name _object]),(mps_path+"action\mps_unit_join.sqf"), [], 1, true, true, "", ""] call RE;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [ _object ]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[ format["TASK%1",_taskid],
		format["Transport Officer %1 to FOB", name _object],
		format["An Officer requires an escort to an FOB near %1. %2 is waiting at the Return Point Marker. Ensure he arrives alive and well.", text _location, name _object],
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"hd_flag","ColorBlue"," FOB"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------WAIT TILL PLAYERS ARRIVE---------------------------------*/

	while{ { side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle"],900] == 0 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

	_troops = [];
	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;

	for "_i" from 1 to _b do {

		_spd = -400; if( random 1 > 0.5 ) then { _spd = 400; };

		_tempos = [ (_position select 0) + _spd, (_position select 1) + _spd, 0 ];
		_grp = [ _tempos,"INF",(7 + random 5),50 ] call CREATE_OPFOR_SQUAD;
		if(random 1 > -10) then {
			_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_tempos,100] call mps_spawn_vehicle;
			sleep 1;
			(units _vehgrp) joinSilent _grp;
			deleteGroup _vehgrp;
		};
		_troops = _troops + (units _grp);
		sleep 1;
		(_grp addWaypoint [_position,10]) setWaypointType "SAD";
		sleep 1;
	};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { alive _object && _object distance _position > 15 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( alive _object && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	_object action ["eject",vehicle _object];
	sleep 5;
	deleteVehicle _object;
	deleteGroup _grp;

	[_troops,_position,_lobjects] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		{ deleteVehicle _x }forEach (_this select 2);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};