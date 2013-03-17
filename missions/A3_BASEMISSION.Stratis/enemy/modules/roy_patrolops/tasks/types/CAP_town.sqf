diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Capture Town Initialise"];

private["_location","_position","_taskid","_troops"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns"]] call mps_getNewLocation;
	_position = [(position _location) select 0,(position _location) select 1, 0];
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_troops = [];

	[_position] call CREATE_OPFOR_ARMY;

	for "_i" from 1 to 3 do { [_position] call CREATE_OPFOR_STATIC; };

	if( playersNumber (SIDE_A select 0) > (4 + random 4) ) then { [_position] spawn CREATE_OPFOR_TOWER; };
	if( playersNumber (SIDE_A select 0) > (6 + random 4) ) then { [_position] spawn CREATE_OPFOR_SNIPERS; };

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[ format["TASK%1",_taskid],
		format["Capture %1", toUpper(text _location)],
		format["%1 is host to a large enemy force. Secure the town and drive out any hostiles.", toUpper(text _location)],
		(SIDE_A select 0),
		[format["MARK%1",_taskid],(_position),"hd_objective","ColorRed"," Occupied"],
		"created",
		_position
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while{ {alive _x && side _x == (SIDE_B select 0)} count nearestObjects[_position,["CAManBase","LandVehicle","Air"],250] > 3 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if(mps_mission_deathcount > 0) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};


/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	// Inherited in creation of called functions above

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};