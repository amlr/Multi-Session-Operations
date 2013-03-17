diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Capture Vehicle Initialise"];

private["_location","_position","_taskid","_vehicles","_object","_vehtype","_type","_b","_troops","_grp","_car_type","_vehgrp"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_position = [(position _location) select 0,(position _location) select 1, 0];
	_position = [_position,250,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_vehicles = (mps_opfor_apc+mps_opfor_armor+mps_opfor_atkh);
	_object = (_vehicles) select (random ((count _vehicles) - 1)) createVehicle _position;
	_vehtype = getText (configFile >> "CfgVehicles" >> typeof _object >> "displayName");

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 3)))) * mps_mission_factor;

	_troops = [];

	_grp = [_position,"INF",(5 + random 5),50] call CREATE_OPFOR_SQUAD;
	_troops = _troops + (units _grp);

	for "_i" from 1 to _b do {
		_grp = [_position,"INF",(5 + random 5),50,"patrol"] call CREATE_OPFOR_SQUAD;
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

	[format["TASK%1",_taskid],
		format["Capture a %1", _vehtype],
		format["The enemy have been intergrating unknown technology onto a %1. Locate and capture the %1 then get it safely back to the return point at base to be examined.", _vehtype],
		true,
		[format["MARK%1",_taskid],(_position),"tank","ColorRed"," Vehicle",[2,2]],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { alive _object && _object distance (getMarkerPos format["return_point_%1",(SIDE_A select 0)]) > 10 || alive _object && (position _object) select 2 > 3 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( alive _object && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	sleep 5;	{ _x action ["eject",_object] }foreach (crew _object);
	sleep 2;	deleteVehicle _object;

	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};