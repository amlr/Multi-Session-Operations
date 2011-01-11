if (isdedicated) exitwith {};

waituntil {!isnull player};
waituntil {!isMultiplayer || getplayeruid player != ""};

[
	[
		{
			if (count units (group player) > 1) then {
				[player] joinsilent (createGroup playerSide);
				(group player) selectLeader player;
			};
			_this + 1;
		},
		{typeof player;},
		{magazines player;},
		{weapons player;},
		{typeof (unitbackpack player);},
		{getmagazinecargo (unitbackpack player);},
		{getweaponcargo (unitbackpack player);},
		{[group player, leader player == player];},
		{
			private ["_group","_pos"];
			_group = group player;
			_pos = getpos player;
			if (leader (group player) == player) then {
				if (_pos distance (_group getvariable ["position",[0,0,0]]) > 10) then {
					_group setvariable ["position",_pos,true];
				};	
			} else {
				if (_pos distance (_group getvariable ["position",[0,0,0]]) > 500) then {
					[player] joinsilent (createGroup playerSide);
					(group player) selectLeader player;
				};
			};				
			if (_pos distance _this > 1) then {_pos;} else {_this;};	
		},
		{damage player;},
		{rating player;},
		{score player;},
		{viewdistance;},
		{if(isnil "terraindetail")then{1;}else{terraindetail;};},
		{getDir player;},
		{[vehicle player, driver (vehicle player) == player, gunner (vehicle player) == player, commander (vehicle player) == player];},
		{lifestate player;},
		{rank player;},
		#include <mods\aaw_g.hpp>
		#include <mods\ace_sys_wounds_g.hpp>
	],
	[
		{
			if (_this > nomadRespawns) then {_disconnect = true;};
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
		{
			[player] joinSilent (_this select 0);
			if (_this select 1) then {(_this select 0) selectLeader player;};
		},
		{
			private ["_group","_gpos","_pos"];
			_group = group player;
			_gpos = _group getvariable ["position",_this];
			_pos = if (_gpos distance _this > 200) then {_gpos;} else {_this;};
			player setpos _pos;
		},
		{player setdamage _this;},
		{player addrating (-(rating player) + _this);},
		{player addscore _this;},
		{setviewdistance _this;},
		{
			setterraingrid ((-10 * _this + 50) max 1);
			terraindetail = _this;
		},
		{player setdir _this;},
		{
			private ["_vehicle"];
			_vehicle = _this select 0;
			if (!isnull _vehicle || _vehicle != player) then {
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
			if (_this == "UNCONCONSCIOUS") then {
				player setUnconscious true;
			};
		},
		{player setunitrank _this;},
		#include <mods\aaw_s.hpp>
		#include <mods\ace_sys_wounds_s.hpp>
	]
] execfsm "modules\nomad\nomad.fsm";
