if(count mps_loc_towns < 1) exitWith{};

diag_log [diag_frameno, diag_ticktime, time, "MISSION TASK SAD_convoy.sqf"];

private["_location","_position","_taskid","_object","_grp","_stance ","_b"];

_location = (mps_loc_towns call mps_getRandomElement);

while {_location == mps_loc_last} do {
	_location = (mps_loc_towns call mps_getRandomElement); 
    sleep 0.1;
};

mps_loc_last = _location;

_position = [(position _location) select 0,(position _location) select 1, 0];
_position = [_position,10,0.1,2] call mps_getFlatArea;
_spawnpos = getMarkerPos format["respawn_%1",(SIDE_B select 0)];

_spawnpos = [_position,(-20 + random 40),2400] call mps_new_position;
_spawnpos = position ([_spawnpos] call mps_getnearestroad);

_taskid = format["%1%2%3",round (_position select 0),round (_position select 1),(round random 999)];

_radius = 200;
_nearRoads = [];
While{count _nearRoads < 3} do {
	_nearRoads = _spawnpos nearRoads _radius;
	_radius = _radius + 100;
};

_truckgroup = [mps_opfor_ncov call mps_getRandomElement,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle;
WaitUntil{vehicle leader _truckgroup != leader _truckgroup};
_truck = vehicle leader _truckgroup;
leader _truckgroup setRank "COLONEL";

_armorgroup = [mps_opfor_armor call mps_getRandomElement,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle;
WaitUntil{vehicle leader _armorgroup != leader _armorgroup};
_armor = vehicle leader _armorgroup;

_apcgroup = [mps_opfor_apc call mps_getRandomElement,(SIDE_B select 0),position (_nearRoads call mps_getRandomElement),0] call mps_spawn_vehicle;
WaitUntil{vehicle leader _apcgroup != leader _apcgroup};
_apc = vehicle leader _apcgroup;

(units _apcgroup + units _armorgroup) joinSilent _truckgroup;
(units _truckgroup + [_truck,_armor,_apc]) spawn mps_cleanup;

sleep 2;
deleteGroup _apcgroup;
deleteGroup _armorgroup;

_truckgroup addWaypoint [_position,200];
_truckgroup setBehaviour "SAFE";
_truckgroup setSpeedMode "LIMITED";
_truckgroup setFormation "COLUMN";

[format["TASK%1",_taskid],
	"Destroy Weapons Convoy",
	format["A weapons supply convoy is moving towards %1. Destroy it before it reaches the town.", _location],
	true,
	[format["MARK%1",_taskid],(_position),"hd_objective","ColorRedAlpha"," Target"],
	"created",
	_position
] call mps_tasks_add;

While{!ABORTTASK_PO && (canMove _truck || canMove _armor || canMove _apc) && _truck distance _position > 100 && _armor distance _position > 100 && _apc distance _position > 100 } do { sleep 5 };

if(!ABORTTASK_PO && !canMove _truck && !canMove _armor && !canMove _apc) then {
	[format["TASK%1",_taskid],"succeeded"] call mps_tasks_upd;
	mps_mission_status = 2;
}else{
	[format["TASK%1",_taskid],"failed"] call mps_tasks_upd;
	mps_mission_status = 3;
};