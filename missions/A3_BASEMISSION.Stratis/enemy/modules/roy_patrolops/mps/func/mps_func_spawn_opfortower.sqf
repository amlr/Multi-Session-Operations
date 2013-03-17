// Written by EightySix
// Inspired by Xeno

private["_position","_tower","_type","_grp","_timer"];

_position = [(_this select 0),150,0.1,2] call mps_getFlatArea;

_type = ["Land_TTowerBig_1_F","Land_telek1"] call mps_getRandomElement;
_tower = _type createVehicle _position;

_grp = [_position,"INF",(2 + random 3),50] call CREATE_OPFOR_SQUAD;
(_grp addWaypoint [_position,20]) setWaypointType "HOLD";
_grp setFormation "DIAMOND";

[_position,_tower,_grp] spawn {
	private["_pos","_tower","_spawnpos","_regrp"];
	_pos = _this select 0;
	_tower = _this select 1;
	_observer = leader (_this select 2);
	_spawnpos = format["respawn_%1",(SIDE_B select 0)];

	while{ alive _tower && alive _observer} do {
		if( !(toupper (behaviour _observer) IN ["CARELESS","SAFE","AWARE"]) ) then {
			_regrp = [_spawnpos,"INF",(8 + random 4),50] call CREATE_OPFOR_SQUAD;
			[_regrp,_spawnpos,_pos,true] spawn CREATE_OPFOR_PARADROP;

			mission_globalchat = "An Enemy Observer has requested reinforcements"; publicVariable "mission_commandchat";
			player commandChat mission_globalchat;

			_timer = 90;
			while{ alive _tower && alive _observer && _timer > 0 } do { sleep 10; _timer = _timer - 1;};
		};
		sleep 10;
	};

	if(!alive _observer) then {
		mission_globalchat = "Enemy Radio Operator Killed - Now they can't call in further Support"; publicVariable "mission_globalchat";
		player commandChat mission_globalchat;
	};
};

mission_globalchat = format["Enemy air tower detected near target area. If alerted, they may call reinforcements.",mapGridPosition _position]; publicVariable "mission_globalchat";
player commandChat mission_commandchat;

While{ damage _tower < 1 && mps_mission_status == 1} do { sleep 10; };

if(damage _tower >= 1) then {
	mission_globalchat = "Enemy Tower Destroyed - Now they can't call in further Support"; publicVariable "mission_globalchat";
	player globalChat mission_globalchat;
};

sleep 10;
deleteVehicle _tower;
deleteMarker _marker;