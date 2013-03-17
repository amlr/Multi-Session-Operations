diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Destroy Convoy Initialise"];

private["_location","_position","_taskid","_startloc","_startpos","_radius","_nearRoads","_vehicles"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_position = [(position _location) select 0,(position _location) select 1, 0];
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------Get nearby Locations-----------------------------------*/

	_nearlocations = [];
	_radius = 2000;
	While{count _nearlocations < 2} do {
		_nearlocations = (nearestLocations [_position,["Name","NameVillage","NameCity","NameCityCapital"],_radius] - [_location]);
		_radius = _radius + 100;
	};
	_nearlocations = _nearlocations call mps_getArrayPermutation;

	_radius = 200;
	_nearRoads = [];
	While{count _nearRoads == 0} do {
		_nearRoads = _position nearRoads _radius;
		_radius = _radius + 100;
	};

/*--------------------CREATE TARGET-----------------------------------*/

	_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
	_vehgrp1 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
	_vehgrp2 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;
	_vehgrp3 = [_car_type,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle; sleep 1;

	_vehicles = [];
	{ _vehicles = _vehicles + [vehicle (leader _x)]; }forEach [_vehgrp1,_vehgrp2,_vehgrp3];

	(units _vehgrp2 + units _vehgrp3) joinSilent _vehgrp1;
	sleep 1;
	{ deleteGroup _x; }forEach [_vehgrp2,_vehgrp3];

/*--------------------MOVE TARGET TO LOCATIONS------------------------*/

	_vehgrp1 addWaypoint [_position,100];
	_vehgrp1 setBehaviour "SAFE";
	_vehgrp1 setSpeedMode "LIMITED";
	_vehgrp1 setFormation "COLUMN";

	{
		_vehgrp1 addWaypoint [position _x,100];
	} foreach _nearlocations;
	(_vehgrp1 addWaypoint [_position,100]) setWaypointtype "CYCLE";

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = _vehicles; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[ format["TASK%1",_taskid],
		"Disable Supply Coloumn",
		format["A supply coloumn is distributing weapons around %1. Locate and ambush the coloumn, disabling any vehicles.", text _location],
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Column Spotted"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { { canMove _x; } count _vehicles > 0 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( mps_mission_deathcount > 0 && { canMove _x; }count _vehicles == 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	{ _x setDamage 1; } forEach _vehicles;

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};