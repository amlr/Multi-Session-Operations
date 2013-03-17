diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Destroy Scuds Initialise"];

private["_location","_position","_taskid","_object","_vehtype","_target1"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_markerpos = [(position _location) select 0,(position _location) select 1, 0];
	_position = [[(position _location) select 0,(position _location) select 1, 0],800,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGETS----------------------------------*/

	_vehtype = "GRAD_RU"; if(mps_oa) then {_vehtype = "MAZ_543_SCUD_TK_EP1"};

	_scudgrp = createGroup east;
	_target1 = ([_position,random 350,_vehtype,_scudgrp] call BIS_fnc_spawnVehicle) select 0;
	_target2 = ([_position,random 350,_vehtype,_scudgrp] call BIS_fnc_spawnVehicle) select 0; 

	_vehtype = getText (configFile >> "CfgVehicles" >> typeof _target1  >> "displayName");

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_troops = [];
	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;

	for "_i" from 1 to _b do {
		_grp = [_position,"INF",(5 + random 5),50,"patrol"] call CREATE_OPFOR_SQUAD;
		if(random 1 > 0.5) then {
			_car_type = (mps_opfor_car+mps_opfor_apc+mps_opfor_armor) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_position,100] call mps_spawn_vehicle;
			(units _vehgrp) joinSilent _grp;
		};
		_troops = _troops + (units _grp);
	};

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [_target1,_target2]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		format["Urgent! Destroy: %2 spotted near %1", text _location,_vehtype],
		format["Witnesses report a couple of %2 near %1. Clear the area and destroy them before they can launch.",text _location,_vehtype],
		true,
		[format["MARK%1",_taskid],(_markerpos),"hd_objective","ColorRed"," Last Known"],
		"created",
		_markerpos
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	scudcount = 0;
	fired = false;

	While { { canmove _x } count [_target1,_target2] > 0 && scudcount < 90 && mps_mission_deathcount > 0 } do {
		sleep 10;
		scudcount = scudcount + 1;
		if( canmove _target1 ) then {
			switch (scudcount) do {
				case 30 : { fire = _target1 action ["scudLaunch",_target1]; };
				case 80 : { fire = _target1 action ["scudStart",_target1]; };
			};
		};
		if( canmove _target2 ) then {
			switch (scudcount) do {
				case 40 : { fire = _target2 action ["scudLaunch",_target2]; };
				case 90 : { fire = _target2 action ["scudStart",_target2]; };
			};
		};
		mps_progress_bar_update = [ (90 - scudcount), 90, east, "Scud Launch"]; publicVariable "mps_progress_bar_update";
	};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if ( !canmove _target1 && !canmove _target2 && scudcount < 90 && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	[_troops,_position,[_target1,_target2]] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		{ deleteVehicle _x; }forEach (_this select 2);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};