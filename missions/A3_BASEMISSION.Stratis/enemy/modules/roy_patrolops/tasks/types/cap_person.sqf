diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Capture Target Initialise"];

private["_location","_position","_taskid","_grp","_object","_houses","_house","_hideout","_buildingpos","_marker","_troops","_b","_stance","_car_type","_vehgrp"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns","StrongpointArea"]] call mps_getNewLocation;
	_position = [(position _location) select 0,(position _location) select 1, 0];
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_grp = [_position,"TARGET",1,10] call CREATE_OPFOR_SQUAD; sleep 1;
	_object = (units _grp) select 0;
	_object setRank "PRIVATE";
	_object setCaptive true;
	removeAllWeapons _object;

	[nil, _object, "per", rADDACTION, (format ["<t color=""#FF0000"">Arrest %1</t>",name _object]),(mps_path+"action\mps_unit_join.sqf"), [], 1, true, true, "", ""] call RE;

/*--------------------MOVE TARGET TO LOCATION-------------------------*/

	[(group _object),_position,"hide"] spawn mps_patrol_init;

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_troops = [];
	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;

	for "_i" from 1 to _b do {
		_stance = ["patrol","standby","hide"] call mps_getRandomElement;
		_grp = [_position,"INF",(5 + random 5),50,_stance ] call CREATE_OPFOR_SQUAD;
		if(random 1 > -10) then {
			_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_position,100] call mps_spawn_vehicle;
			sleep 1;
			(units _vehgrp) joinSilent _grp;
			deleteGroup _vehgrp;
		};
		_troops = _troops + (units _grp);
		sleep 1;
	};

	if( playersNumber (SIDE_A select 0) > (4 + random 4) ) then { [_position] spawn CREATE_OPFOR_TOWER; };
	if( playersNumber (SIDE_A select 0) > (6 + random 4) ) then { [_position] spawn CREATE_OPFOR_SNIPERS; };

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [ _object ]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[ format["TASK%1",_taskid],
		format["Priority Target: Capture %1", name _object],
		format["A high profile target has been spotted in %1. Capture %2 alive and transport him back to base asap.", text _location, name _object],
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Target"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { alive _object && _object distance (getMarkerPos format["return_point_%1",(SIDE_A select 0)]) > 10 && mps_mission_deathcount > 0 } do { sleep 5 };

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

	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};