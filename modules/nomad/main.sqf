if (isdedicated) exitwith {};

waituntil {not isnull player};
waituntil {!isMultiplayer || getplayeruid player != ""};

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
		{score player;},
		{viewdistance;},
		{if(isnil "terraindetail")then{1;}else{terraindetail;};},
		{getDir player;},
		{[vehicle player, driver (vehicle player) == player, gunner (vehicle player) == player, commander (vehicle player) == player];},
		{lifestate player;},
		{[group player, (leader player == player)];},
		#include <mods\ace_sys_wounds_g.hpp>
		{rank player;}
	],
	[
		{
			if (_this > (nomadRespawns)) then {_disconnect = true;};
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
		{player addscore (-(score player) + _this);},
		{setviewdistance _this;},
		{
			setterraingrid ((-10 * _this + 50) max 1);
			terraindetail = _this;
		},
		{player setdir _this;},
		{
			private ["_vehicle"];
			_vehicle = _this select 0;
			if (not isnull _vehicle || _vehicle != player) then {
				if ((_this select 1) and (isnull(driver _vehicle))) exitwith {
					player moveInDriver _vehicle;
				};
				if ((_this select 2) and (isnull(commander _vehicle))) exitwith {
					player moveInCommander _vehicle;
				};
				if ((_this select 3) and (isnull(gunner _vehicle))) exitwith {
					player moveInGunner _vehicle;
				};
				player moveInCargo _vehicle;
			};
		},
		{
			if (tolower(_this) == "unconscious") then {
				player setUnconscious true;
			};
		},
		{
			[player] joinSilent (_this select 0);
			if (_this select 1) then {
				(_this select 0) selectLeader player;
			};
		},
		#include <mods\ace_sys_wounds_s.hpp>
		{player setunitrank _this;}
	]
] execfsm "modules\nomad\nomad.fsm";
