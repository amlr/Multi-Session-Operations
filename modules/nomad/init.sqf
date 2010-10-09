if (isserver) then {
	rmm_nomad_respawns = paramsArray select 0;
	publicVariable "rmm_nomad_respawns";
};
if (isdedicated) exitwith {};

waituntil {not isnull player};
waituntil {getplayeruid player != ""};
waituntil {not isnil "rmm_nomad_respawns"};

[
	[
		/*{deaths player} //auto-integrated*/
		{typeof player;},
		{magazines player;},
		{weapons player;},
		{typeof (unitbackpack player);},
		{getmagazinecargo (unitbackpack player);},
		{getweaponcargo (unitbackpack player);},
		{
			private "_pos";
			_pos = getpos player;
			if (_pos distance _this > 1) then {
				_pos;
			} else {
				_this;
			};
		},
		{damage player;},
		{rating player;},
		{viewdistance;},
		{if(isnil "terraindetail")then{1;}else{terraindetail;};},
#ifdef RMM_REVIVE
		{lifestate player;},
#endif
		{[assignedVehicle player, assignedVehicleRole player]},
		{getDir player;}
	],
	[
		{
			if (_this > rmm_nomad_respawns) then {_disconnect = true;};
		},
		{
			if (typeof player != _this) then {_disconnect = true;};
		},
		{
			{player removemagazine _x;} foreach (magazines player);
			{player addmagazine _x;} foreach _this;
		},
		{
			{player removeweapon _x;} foreach ((weapons player) + (items player));
			{player addweapon _x;} foreach _this;
			player selectweapon (primaryweapon player);
		},
		{
			if (_this != "") then {
				player addbackpack _this;
				clearweaponcargo (unitbackpack player);
				clearmagazinecargo (unitbackpack player);
			};
		},
		{
			for "_i" from 0 to ((count (_this select 0))-1) do {
				(unitbackpack player) addmagazinecargo [(_this select 0) select _i,(_this select 1) select _i];
			};
		},
		{
			for "_i" from 0 to ((count (_this select 0))-1) do {
				(unitbackpack player) addweaponcargo [(_this select 0) select _i,(_this select 1) select _i];
			};
		},
		{player setpos _this;},
		{player setdamage _this;},
		{player addrating (-(rating player) + _this);},
		{setviewdistance _this;},
		{
			setterraingrid ((-10 * _this + 50) max 1);
			terraindetail = _this;
		},
#ifdef RMM_REVIVE
		{
			if (tolower(_this) == "unconscious") then {
				[1,player] call revive_fnc_handle_events;
			};
		},
#endif
		{
			private ["_vehicle", "_vehpos", "_tp"];
			_vehicle = _this select 0;
			_vehpos = _this select 1;
			if (count _vehpos != 0) then {
				switch(_vehpos select 0) do {
					case "Driver": {
						player moveInDriver _vehicle;
					};
					case "Cargo": {
						player moveInCargo _vehicle;
					};
					case "Turret": {
						_tp = _vehpos select 1;
						player moveInTurret [_vehicle, _tp];
					};
				};
			};
		},
		{player setdir _this;}
	]
] execfsm "modules\nomad\nomad.fsm";