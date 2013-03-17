diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Build Tower Initialise"];

private["_location","_position","_taskid","_camptype","_newComp","_lobjects","_troops","_spd","_tempos","_grp","_car_type","_vehgrp","_container"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["hills"],6000] call mps_getNewLocation;
	_position = [ [(position _location) select 0,(position _location) select 1, 0] ,50,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_container = [format["return_point_%1",(SIDE_A select 0)]] call CREATE_MOVEABLE_TOWER;

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_grp = [_position,"INF",(5 + random 5),50,"patrol" ] call CREATE_OPFOR_SQUAD;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [_container]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		"Deploy Communications Tower",
		format["Enemy have destroyed communications. A hill nearby is ideal to deploy a new Comms Tower to reconnect the locals.<br/><br/> Move the container at base to the location, unload it and deploy the comms tower.", text _location],
		true,
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorBlue"," Deploy Tower"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------WAIT TILL PLAYERS ARRIVE---------------------------------*/

	while{ { side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle"],200] == 0 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

	_troops = [];

	for "_i" from 1 to 2 do {

		_spd = -400; if( random 1 > 0.5 ) then { _spd = 400; };
		_tempos = [ (_position select 0) + _spd, (_position select 1) + _spd, 0 ];
		_grp = [ _tempos,"INF",(5 + random 3),50 ] call CREATE_OPFOR_SQUAD;
		_troops = _troops + (units _grp);
		sleep 1;
		(_grp addWaypoint [_position,10]) setWaypointType "SAD";
		sleep 1;
	};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { count nearestObjects[ _position, ["Land_TTowerBig_1_F"], 80] == 0 && damage _container < 1 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( count nearestObjects[ _position, ["Land_TTowerBig_1_F"], 80] > 0 && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	sleep 2;

	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		{ deleteVehicle _x }forEach (nearestObjects[(_this select 1), ["Land_TTowerBig_1_F"], 80] select 0);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};