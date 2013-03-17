diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Defend Camp Initialise"];

private["_location","_position","_taskid","_camptype","_newComp","_lobjects","_troops","_b","_spd","_tempos","_grp","_car_type","_vehgrp"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["hills",3000]] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],400,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_camptype = "CityBase04"; if(mps_oa) then {_camptype = "CityBase04_EP1";};
	_newComp = [_position,random 360,_camptype] call BIS_fnc_dyno;
	_lobjects = nearestObjects[_position,["All"],100];

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[ format["TASK%1",_taskid],
		"Defend Outpost",
		"A key outpost has a large force about to over run its position. Secure the location and keep any hostiles away.",
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"defend","ColorBlue"," Defend Outpost"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------WAIT TILL PLAYERS ARRIVE---------------------------------*/

	while{ { side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle"],50] == 0 && mps_mission_deathcount > 0 } do { sleep 5 };

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

	while{ {alive _x && side _x == (SIDE_B select 0)} count nearestObjects[_position,["CAManBase","LandVehicle","Air"],16] == 0 && mps_mission_deathcount > 0 && { alive _x } count _troops > 3 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if(mps_mission_deathcount > 0 && mps_mission_deathcount > 0 && { alive _x } count _troops <= 3 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	[_troops,_position,_lobjects] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		{ deleteVehicle _x }forEach (_this select 2);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};