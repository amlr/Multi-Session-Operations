// Written by EightySix

sleep 1;
if(!isServer) exitWith{};
if(isNil "mps_ambient_airpatrols") then {mps_ambient_air = false};
if(!mps_ambient_airpatrols) exitWith{};

private["_radarlocation","_site","_location"];

_location = [["hills"]] call mps_getNewLocation;
_radarlocation = [position _location,250,0.1,2] call mps_getFlatArea;

_site = switch (SIDE_B select 0) do {
	case east : {"RadarSite1_RU"};
	case west : {"RadarSite1_US"};
	default     {"RadarSite1_RU"};
};

if(mps_oa) then {
	_site = switch (SIDE_B select 0) do {
		case east : {"RadarSite1_TK_EP1"};
		case west : {"RadarSite1_TK_EP1"};
		default     {"RadarSite1_TK_EP1"};
	};
};


_newComp = [_radarlocation, random 360,_site] call BIS_fnc_dyno;
{ if(typeOf _x IN ["76n6ClamShell","76n6ClamShell_EP1","BASE_WarfareBAntiAirRadar"]) then {heli_radar = _x;}; }forEach _newcomp;

if(isNil "heli_radar") exitWith{ hint "No Radar"; };

hint format["Radar %1 at %2", heli_radar , _radarlocation ];

if(mps_debug) then {
	_marker = createMarkerLocal ["masarkerh",_radarlocation];
	_marker setMarkerTypeLocal "mil_triangle";
	_marker setMarkerColorLocal "ColorRed";
	mission_sidechat = format["OPFOR Radar created at grid %1.",mapGridPosition _radarlocation]; publicVariable "mission_sidechat";
	[WEST,"HQ"] sideChat mission_sidechat;
};

patrol_helo_radarlocations = nearestLocations [ [0,0], ["Name","NameCity","NameCityCapital","NameVillage","NameLocal"], 50000];

_script = [] spawn {
	While { damage heli_radar < 1 } do{
		_helo1 = nil;
		_helo2 = nil;

		_groupgrp1 = createGroup east;

		_types = mps_opfor_atkh + mps_opfor_atkp;
		_helotype = _types call mps_getRandomElement;

		_helo1 = ([[(position heli_radar select 0)+10000,(position heli_radar select 1)+10000,100], 180, _helotype, _groupgrp1] call BIS_fnc_spawnVehicle) select 0;
		_helo1 = ([[(position heli_radar select 0)+10000,(position heli_radar select 1)+10000,300], 180, _helotype, _groupgrp1] call BIS_fnc_spawnVehicle) select 0;

		if(mps_mission_factor > 2) then {
			_helo2 = ([[(position heli_radar select 0)+10100,(position heli_radar select 1)+10100,100], 180, _helotype, _groupgrp1] call BIS_fnc_spawnVehicle) select 0;
		};

		sleep 10;

		_radarlocations = patrol_helo_radarlocations call mps_getArrayPermutation;
		{
			if(position _x distance getMarkerPos format["respawn_%1",(SIDE_A select 0)] > 4000) then {
				_wp = _groupgrp1 addWaypoint [position _x,100];
			};

		} foreach _radarlocations;

		_wp = _groupgrp1 addWaypoint [waypointPosition [_groupgrp1,0],100];
		_wp setWaypointType "CYCLE";

		while { if(!isNil "_helo1") then { damage _helo1 < 1 }else{false} || if(!isNil "_helo2") then { damage _helo2 < 1 }else{false} } do {sleep 30;};

		sleep 60;

		if(!isNil "_helo1") then { deleteVehicle _helo1; };
		if(!isNil "_helo2") then { deleteVehicle _helo2; };

		{ deleteVehicle _x }forEach (units _groupgrp1);
		deletegroup _groupgrp1;

		sleep 300;
	};
};

While{ damage heli_radar < 1 } do { sleep 10 };

terminate _script;

mission_commandchat = "Enemy Radar Destroyed - Enemy can't call in further Air Support"; publicVariable "mission_commandchat";
player commandChat mission_commandchat;