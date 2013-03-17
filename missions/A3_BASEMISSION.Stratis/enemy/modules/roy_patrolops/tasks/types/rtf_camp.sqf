diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Clear Camp Initialise"];

private["_location","_markerpos","_position","_taskid","_camptype","_newComp","_lobjects","_troops","_b","_grp","_car_type","_vehgrp"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_markerpos = [(position _location) select 0,(position _location) select 1, 0];
	_position = [[(position _location) select 0,(position _location) select 1, 0],1000,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_camptype = "Camp1_RU"; if(mps_oa) then {_camptype = "Camp1_TK_EP1";};
	_newComp = [_position,random 360,_camptype] call BIS_fnc_dyno;
	_lobjects = nearestObjects[_position,["All"],100];

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_troops = [];
	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 4)))) * mps_mission_factor;

	for "_i" from 1 to _b do {
		_grp = [_position,"INS",(5 + random 5),50,"patrol"] call CREATE_OPFOR_SQUAD;
		if(random 1 > -10) then {
			_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_position,100] call mps_spawn_vehicle;
			sleep 1;
			(units _vehgrp) joinSilent _grp;
		};
		_troops = _troops + (units _grp);
		sleep 1;
	};

	for "_i" from 1 to 3 do { [_position] call CREATE_OPFOR_STATIC; };

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [ _position ]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		"Locate Insurgent Camp",
		format["Insurgent movement has been observed near %1. Locate any camps and clear them out.",text _location],
		true,
		[format["MARK%1",_taskid],(_markerpos),"hd_objective","ColorRed"," Target"],
		"created",
		_markerpos
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { {alive _x} count _troops > 3 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( mps_mission_deathcount > 0 ) then {
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