diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Rescue POW Initialise"];

private["_location","_position","_taskid"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_position = [(position _location) select 0,(position _location) select 1, 0];
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_powtype = "FR_Commander";
	if(count mps_blufor_leader > 0) then { _powtype = mps_blufor_leader call mps_getRandomElement };
	_powgrp = createGroup west;
	_pow1 = _powgrp createUnit [_powtype,_position,[],0,"FORM"];
	_pow1 setRank "private";
	_pow1 allowFleeing 0;
	_pow1 setDamage 0.5;
	_pow1 setCaptive true;
	removeAllWeapons _pow1;
	[nil, _pow1, "per", rADDACTION, (format ["<t color=""#00FFFF"">Rescue %1</t>",name _pow1]),(mps_path+"action\mps_unit_join.sqf"), [], 1, true, true, "", ""] call RE;

	(_powgrp addWaypoint [position _pow1,0]) setWaypointType "HOLD";

/*--------------------MOVE TARGET TO LOCATION-------------------------*/

	[(group _pow1),_position,"hide"] spawn mps_patrol_init;

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;

	for "_i" from 1 to _b do {
		_grp = [position _pow1,"INF",(5 + random 5),50,"patrol"] call CREATE_OPFOR_SQUAD;
		if(random 1 > 0.5) then {
			_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_position,100] call mps_spawn_vehicle;
			(units _vehgrp) joinSilent _grp;
		};
		_troops = _troops + (units _grp);
	};

	for "_i" from 1 to 3 do { [_position] call CREATE_OPFOR_STATIC; };

	if( playersNumber (SIDE_A select 0) > (4 + random 4) ) then { [_position] spawn CREATE_OPFOR_TOWER; };
	if( playersNumber (SIDE_A select 0) > (6 + random 4) ) then { [_position] spawn CREATE_OPFOR_SNIPERS; };

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [_pow1]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		"Rescue POW",
		format["An Officer has been captured after an attack on a convoy. It is believed he is being held in %1. Locate and rescue the officer",text _location],
		true,
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," POW"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	While{ _pow1 distance getMarkerPos format["return_point_%1",(SIDE_A select 0)] > 15 && alive _pow1 && mps_mission_deathcount > 0 } do {sleep 1};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( alive _pow1 && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	_pow1 action ["eject",vehicle _object];
	sleep 2;
	deleteVehicle _pow1;
	deleteGroup _powgrp;

	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};