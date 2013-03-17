diag_log [diag_frameno, diag_ticktime, time, "#PO2 TASK: Search and Destroy Cache Initialise"];

private["_location","_position","_taskid","_grp","_stance"];

/*--------------------CREATE LOCATION---------------------------------*/

	_location = [["towns","hills"]] call mps_getNewLocation;
	_position = [[(position _location) select 0,(position _location) select 1, 0],800,0.1,2] call mps_getFlatArea;
	_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

/*--------------------CREATE TARGET-----------------------------------*/

	_cachetype = "Box_East_WpsSpecial_F";
	if(mps_oa) then {_cachetype = "TKVehicleBox_EP1"};

	TARGET_CACHE = _cachetype createVehicle _position;
	[TARGET_CACHE] spawn mps_object_c4only;

/*--------------------MOVE TARGET TO LOCATION-------------------------*/

	_houses = [_position,800] call mps_getEnterableHouses;
	_house = [];
	_hideout = [];

	for "_i" from 1 to 10000 do {
		_house = _houses call mps_getRandomElement;
		_buildingpos = round random (_house select 1);
		_house = (_house select 0);
		_hideout = (_house buildingPos _buildingpos);
		if(count (_hideout - [0]) > 0) exitWith{};
	};

	TARGET_CACHE setPos _hideout;

	if(mps_debug) then {
		_marker = createMarkerLocal [format["Debug%1",_taskid],position TARGET_CACHE];
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerColorLocal "ColorGreen";
	};

/*--------------------Setup Intel Handler-------------------------*/

	objective_intel = 0;
	objective_marker = [];
	objective_location = position TARGET_CACHE;

	objective_intel_KILLED = {
		if(side _this == (SIDE_B select 0) && random 3 < 1) then {
			_this addEventHandler ["Killed",{
				_unit = _this select 0;
				_pos = [(getPos _unit select 0) + 1 - random 2,(getPos _unit select 1) + 1 - random 2,0];
				_ev = (["EvMap","EvMoscow","EvPhoto"] call mps_getRandomElement) createvehicle _pos;
				_ev setPosATL _pos;
				_ev spawn {
					while{alive TARGET_CACHE && {isPlayer _x && side _x == (SIDE_A select 0)} count nearestObjects[position _this,["All"],3] == 0} do {sleep 2};
					if(!alive TARGET_CACHE) exitWith {deleteVehicle _this};
					deleteVehicle _this;
					mission_sidechat = "Gained new intel about the caches possible location."; publicVariable "mission_sidechat"; player sideChat mission_sidechat;
					objective_intel = objective_intel + 150;
					_markername = format["objective_int_%1",objective_intel];
					_markeraccuracy = 50 max (1500 - objective_intel);
					_markerpos = [objective_location,random 360,random _markeraccuracy,false,2] call mps_new_position;
					_marker = createMarker [_markername,_markerpos];
					_marker setMarkerType "hd_unknown";
					_marker setMarkerSize [0.75,0.75];
					_marker setMarkerText format["%1m",_markeraccuracy];
					objective_marker = objective_marker + [_markername]; publicVariable "objective_marker";
				};
			}];
		};
	};

/*--------------------CREATE ENEMY AT LOCATION------------------------*/

	_troops = [];

	for "_i" from 1 to 2 do {
		_stance = ["patrol","standby","hide"] call mps_getRandomElement;
		_grp = [_position,"INF",(5 + random 5),50,_stance ] call CREATE_OPFOR_SQUAD;
		_troops = _troops + (units _grp);
	};

/*--------------------CREATE ENEMY NEARBY LOCATION------------------------*/

	{
		_loc = position _x;
		_grp = [_loc,"INS",(5 + random 5),50,"patrol"] call CREATE_OPFOR_SQUAD;
		_troops = _troops + (units _grp);
		if(random 1 > 0.5) then {
			_car_type = (mps_opfor_car+mps_opfor_apc) call mps_getRandomElement;
			_vehgrp = [_car_type,(SIDE_B select 0),_loc,100] call mps_spawn_vehicle;
			[_vehgrp,_loc,"patrol"] spawn mps_patrol_init;
			_troops = _troops + (units _vehgrp);
		};
		sleep 0.125;
	} forEach (nearestLocations [_position,["Name","NameLocal","NameVillage","NameCity","NameCityCapital"],3000]);

	if( playersNumber (SIDE_A select 0) > (4 + random 4) ) then { [_position] spawn CREATE_OPFOR_TOWER; };
	if( playersNumber (SIDE_A select 0) > (6 + random 4) ) then { [_position] spawn CREATE_OPFOR_SNIPERS; };

	{_x spawn objective_intel_KILLED;} foreach _troops;

/*--------------------CREATE INTEL MARKERS------------------------*/

	[] spawn {
		While{alive TARGET_CACHE} do {
			{
				_xmarkerposition = getMarkerPos _x;
				_xmarkercolor = getMarkerColor _x;
				_xmarkerType = getMarkerType _x;
				_xmarkertext = markerText _x;
				objective_marker = objective_marker - [_x];
				deleteMarker _x;
				_xmarker = createMarker [format["INTEL_%1",random 99999],_xmarkerposition];
				_xmarker setMarkerType _xmarkerType;
				_xmarker setMarkerSize [0.75,0.75];
				_xmarker setMarkerColor _xmarkercolor;
				_xmarker setMarkerText _xmarkertext;
				objective_marker = objective_marker + [_xmarker];
			} forEach objective_marker;
			sleep 30;
		};
	};

/*--------------------CREATE INTEL, RESET DEATHCOUNT---------------------------------*/

	mps_civilian_intel = [TARGET_CACHE]; publicVariable "mps_civilian_intel";
	mps_mission_deathcount = mps_mission_deathlimit; publicVariable "mps_mission_deathcount";

/*--------------------CREATE TASK OBJECTIVE---------------------------------*/

	[format["TASK%1",_taskid],
		"Search and Destroy Weapons Cache",
		format["Enemy have taken delivery of a large weapons cache and stored it in a town somewhere in %1. Locate and Destroy the weapons cache using C4.<br/><br/>Hostile insurgent and government troops patrolling random towns will be the key. <br/>Gather Intel from the enemies located in towns to narrow down the cache location.",worldname],
		true,
		[],
		"created"
	] call mps_tasks_add;

/*--------------------MISSION CRITERIA TO PASS---------------------------------*/

	while { damage TARGET_CACHE < 1 && mps_mission_deathcount > 0 } do { sleep 5 };

/*--------------------CHECK IF SUCCESSFUL---------------------------------*/

	if( damage TARGET_CACHE >= 1 && mps_mission_deathcount > 0 ) then {
		[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	}else{
		[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	};

/*--------------------CLEAN UP AFTER MISSION---------------------------------*/

	{deleteMarker _x} forEach objective_marker;

	[_troops,_position] spawn {
		while{ {isPlayer _x} count nearestObjects[(_this select 1),["CAManBase","LandVehicle","Plane"],1500] > 0} do { sleep 10 };
		{ _x setDamage 1}forEach (_this select 0);
		deleteVehicle TARGET_CACHE;
	};

/*--------------------RESET INTEL---------------------------------*/

	mps_civilian_intel = []; publicVariable "mps_civilian_intel";

/*--------------------FORCE SCRIPT END---------------------------------*/

if(true)exitWith{};