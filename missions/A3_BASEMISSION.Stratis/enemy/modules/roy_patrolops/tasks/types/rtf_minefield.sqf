diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Clear Minefield Initialise"];

private["_location","_position","_taskid","_allroads","_roads","_allmines","_mine","_troops","_b","_grp","_car_type","_vehgrp"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_position = [(position _location) select 0,(position _location) select 1, 0];
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_allroads = _position nearRoads 150;
	_roads = [];
	_allmines = [];

	{ if(count roadsconnectedto _x > 1) then { _roads = _roads + [_x]; }; } foreach _allroads;

	_MINE_CHECKER = {
		_this addEventHandler ["HandleDamage", {
			_damage = _this select 2;
			_projectile = _this select 4;		
			if(_projectile == "PipeBomb" || _projectile == "ACE_PipebombExplosion") then { 1 } else { 0 };
		}];
	};

	if(count _roads > 0) then {
		{
			if(random 1 <= 0.4) then {
				_randompos_on_road = [(getpos _x select 0) + 2.5 - random 5, (getpos _x select 1) + 2.5 - random 5, 0];
				_mine = createMine ["MineMine", _randompos_on_road, [], 0];
				_mine spawn _MINE_CHECKER;
				_allmines = _allmines + [_mine];
			};
			if( count _allmines >= 6 ) exitWith{};
		} foreach _roads;
	} else {
		_pos = [_position,100,0.1,2] call mps_getFlatArea;
		for "_i" from 1 to 6 do {
			_randompos = [(_pos select 0) + 25 - random 50, (_pos select 1) + 25 - random 50, 0];
			_mine = createMine ["MineMine", _randompos, [], 0];
			_mine spawn _MINE_CHECKER;
			_allmines = _allmines + [_mine];
		};
	};

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = _allmines; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[ format["TASK%1",_taskid],
		"Clear Minefield",
		format["Civillians in %1 are reporting injuries caused by enemy mines. Locate the suspected mines and destroy 6 using C4 or an ENGINEER.", text _location],
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Target"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------WAIT FOR AMBUSH---------------------------------*/

	while{ {isPlayer _x} count nearestObjects[ _position, ["CAManBase","LandVehicle"], 150] == 0 } do { sleep 10 };

/*--------------------CREATE AMBUSH-----------------------------------*/

	if( random 1 > 2 ) then {
		_spawnpos = [(_position select 0),(_position select 1)+2500];
		_troops = [_spawnpos,"INF",(8 + random 4),50] call CREATE_OPFOR_SQUAD;
		[_troops,_spawnpos,_position,true] spawn CREATE_OPFOR_PARADROP;
	}else{
		_spd = -500; if( random 1 > 0.5 ) then { _spd = 500; };
		_troops = [ [ (_position select 0) + _spd, (_position select 1) + _spd, 0 ] ,"INS",(15 + random 15),50] call CREATE_OPFOR_SQUAD;
		(_troops addWaypoint [_position,10]) setWaypointType "SAD";
	};

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { { isNull _x || (vectorUp _x select 2) < 1} count _allmines < count _allmines && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	{ deleteVehicle _x; }forEach _allmines;

	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};