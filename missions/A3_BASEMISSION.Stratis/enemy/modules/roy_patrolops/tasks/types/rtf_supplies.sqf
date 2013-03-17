diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Deliver Supplies Initialise"];

private["_location","_position","_taskid","_camptype","_newComp","_lobjects","_troops","_b","_spd","_tempos","_grp","_car_type","_vehgrp","_cont1","_cont2"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"],6000] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],1000,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_cont1 = [format["return_point_%1",(SIDE_A select 0)]] call CREATE_MOVEABLE_CONTAINER;
	_cont2 = [format["return_point_%1",(SIDE_A select 0)]] call CREATE_MOVEABLE_CONTAINER;

	_camptype = "FuelDepot_US"; if(mps_oa) then {_camptype = "FuelDepot_US_EP1";};
	_newComp = [_position,random 360,_camptype] call BIS_fnc_dyno;
	_lobjects = nearestObjects[_position,["All"],100];

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [_cont1,_cont2]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		format["Deliver Supplies to %1", text _location],
		format["Two Shipping Containers full of supplies have been delivered to the Fuel Base. Transport them safely by truck to %1.<br/><br/>To Transport: move a truck close to the containers and you will get the option to load them. Beware when unloading as Containers will unload right side of the truck and can crush you.", text _location],
		true,
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Target"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------WAIT TILL PLAYERS ARRIVE---------------------------------*/

	while{ { side _x == (SIDE_A select 0)} count nearestObjects[_position,["CAManBase","LandVehicle"],800] == 0 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CREATE ENEMY NEAR LOCATION---------------------------------*/

	_troops = [];
	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;

	for "_i" from 1 to _b do {

		_spd = -400; if( random 1 > 0.5 ) then { _spd = 400; };

		_tempos = [ (_position select 0) + _spd, (_position select 1) + _spd, 0 ];
		_grp = [ _tempos,"INF",(5 + random 3),50 ] call CREATE_OPFOR_SQUAD;
		_troops = _troops + (units _grp);
		sleep 1;
		(_grp addWaypoint [_position,10]) setWaypointType "SAD";
		sleep 1;
	};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { { damage _x < 1 } count [_cont1,_cont2] > 0 && count nearestObjects[_position,["Land_CargoBox_V1_F","Land_CargoBox_V1_F"],30] < 2 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( { damage _x < 1 } count [_cont1,_cont2] == 2 && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	sleep 2;
	detach _cont1;	deleteVehicle _cont1;
	detach _cont2;	deleteVehicle _cont2;

	[_troops,_position,_lobjects] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		{ deleteVehicle _x }forEach (_this select 2);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};