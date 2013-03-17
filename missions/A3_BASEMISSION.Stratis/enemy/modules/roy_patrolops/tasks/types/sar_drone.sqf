diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Recover Drone Intel Initialise"];

private["_location","_position","_taskid","_grp","_stance"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],900,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_choptype = "O_Ka60_Unarmed_F";
	if(mps_oa) then { _choptype = "O_Ka60_Unarmed_F_US_EP1"; };
	_crashchopper = _choptype createvehicle (_position);
	_crashchopper setDamage 0.9;
	_crashchopper setFuel 0;
	_crashchopper lock true;

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [_crashchopper]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		"Ka60 Down, Recover Data, Destroy Wreckage",
		"A enemy Ka60 has been shot down after doing surveillance of possible insurgent activites. Move to the crash site, Download the Data using your Wifi repeater and once complete use a sachel to destroy the wreckage to prevent it falling into enemy hands.<br /> - To start the download, move close to the UAV to begin the WiFi signal hack.",
		true,
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorBlue"," Ka60 crash site"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	_intelpercent = 0;
	_fired1 = false;
	_fired2 = false;
	_fired3 = false;
	_fired4 = false;
	_troops = [];

	While{ _intelpercent < 3 && damage _crashchopper < 1 && mps_mission_deathcount > 0 } do {

		sleep 1;

		if( _intelpercent > 0.1 && !_fired1 ) then {
			_spd = -500; if( random 1 > 0.5 ) then { _spd = 500; };
			_grp = [ [ (position _location select 0) + _spd, (position _location select 1) + _spd, 0 ] ,"INS",(15 + random 15),50] call CREATE_OPFOR_SQUAD;
			(_grp addWaypoint [_position,10]) setWaypointType "SAD";
			_troops = _troops + (units _grp);
			_fired1 = true;
		};

		if( _intelpercent > 0.5 && !_fired2 ) then {
			_spawnpos = [(_position select 0),(_position select 1)+2500];
			_grp = [_spawnpos,"INF",(8 + random 4),50] call CREATE_OPFOR_SQUAD;
			[_grp,_spawnpos,_position,true] spawn CREATE_OPFOR_PARADROP;
			_troops = _troops + (units _grp);
			_fired2 = true;
		};

		if( _intelpercent > 1.5 && !_fired4 ) then {
			_spd = -500; if( random 1 > 0.5 ) then { _spd = 500; };
			_grp = [ [ (position _location select 0) + _spd, (position _location select 1) + _spd, 0 ] ,"INS",(15 + random 15),50] call CREATE_OPFOR_SQUAD;
			(_grp addWaypoint [_position,10]) setWaypointType "SAD";
			_troops = _troops + (units _grp);
			_fired4 = true;
		};

		if( {isPlayer _x} count nearestObjects[(position _crashchopper),["CAManBase","LandVehicle"],20] > 0 ) then {

			_intelpercent = _intelpercent + 0.01;
			mps_progress_bar_update = [ _intelpercent, 3, west, "Downloading Intel..."]; publicVariable "mps_progress_bar_update"; mps_progress_bar_update call mps_progress_update;

		};

	};

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if(  _intelpercent >= 3 && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	[_troops,_position,_crashchopper] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		deleteVehicle (_this select 2);
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};