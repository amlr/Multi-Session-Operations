diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Destroy Facility Initialise"];

private["_location","_markerpos","_position","_taskid","_camptype","_building","_troops","_b","_grp","_car_type","_vehgrp"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns","StrongpointArea"]] call mps_getNewLocation;
	_markerpos = [(position _location) select 0,(position _location) select 1, 0];
	_position = [[(position _location) select 0,(position _location) select 1, 0],900,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_camptype = "Land_Cargo_HQ_V2_F"; if(mps_oa) then {_camptype = "Land_Cargo_HQ_V2_F";};
	_building = _camptype createVehicle _position;
	[_building] call mps_object_c4only;

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_troops = [];
	_b = (2 max (round (random (playersNumber (SIDE_A select 0) / 4)))) * mps_mission_factor;

	for "_i" from 1 to _b do {
		_grp = [_position,"INF",(5 + random 5),50,"patrol"] call CREATE_OPFOR_SQUAD;
		if(random 1 > 0.5) then {
			_car_type = (mps_opfor_car+mps_opfor_apc+mps_opfor_armor) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_position,100] call mps_spawn_vehicle;
			sleep 1;
			(units _vehgrp) joinSilent _grp;
		};
		_troops = _troops + (units _grp);
	};

	for "_i" from 1 to 3 do { [_position] call CREATE_OPFOR_STATIC; };

	if( playersNumber (SIDE_A select 0) > (6 + random 4) ) then { [_position] spawn CREATE_OPFOR_SNIPERS; };

	_position spawn {
		waitUntil{ {isPlayer _x} count nearestObjects[_this,["CAManBase","LandVehicle"],200] > 0 };
		_spawnpos = [(_this select 0),(_this select 1)+2500];
		_troops = [_spawnpos,"INF",(8 + random 4),50] call CREATE_OPFOR_SQUAD;
		[_troops,_spawnpos,_this,true] spawn CREATE_OPFOR_PARADROP;
	};

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [_building]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		"Locate Chemical Factory",
		format["An enemy chemical weapons development facility is somewhere in this area of %1. Locate and destroy it with C4 explosives.",text _location],
		true,
		[format["MARK%1",_taskid],(_markerpos),"hd_objective","ColorRed"," Chemicals Detected"],
		"created",
		_markerpos
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { damage _building < 1 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

	[_troops,_position,_building] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		deleteVehicle (_this select 2);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};