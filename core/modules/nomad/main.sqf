//#squint filter Code-block is never called
//#squint filter Expected ; or operator but got ,

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
		{getposATL player;},
		{damage player;},
		{rating player;},
		{score player;},
		{viewdistance;},
		{if(isnil "terraindetail")then{1;}else{terraindetail;};},
		{getDir player;},
		{[vehicle player, driver (vehicle player) == player, gunner (vehicle player) == player, commander (vehicle player) == player];},
		{lifestate player;},
		{[group player, (leader player == player)];},
		#include <mods\aaw_g.hpp>
		{rank player;}
	] + [
		if(!isNil "ace_main") then {
			#include <mods\ace_sys_ruck_g.hpp>
			#include <mods\ace_sys_wounds_g.hpp>
		}
	],
	[
		{
			_dayspassed = 1 + time / 86400;
			_maxLives = nomadRespawns * (nomadReinforcements * _dayspassed);
			if (_this > _maxLives) then {_disconnect = true;};
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
		{player setposATL _this;},
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
				player assignAsCargo _vehicle;
				player moveInCargo _vehicle;
				if ((_this select 1) and (isnull(driver _vehicle))) exitwith {
					player assignAsDriver _vehicle;
					player moveInDriver _vehicle;
				};
				if ((_this select 2) and (isnull(gunner _vehicle))) exitwith {
					player assignAsGunner _vehicle;
					player moveInGunner _vehicle;
				};
				if ((_this select 3) and (isnull(commander _vehicle))) exitwith {
					player assignAsCommander _vehicle;
					player moveInCommander _vehicle;
				};
			};
		},
		{
			if (tolower(_this) == "unconscious") then {
				player setUnconscious true;
			};
		},
		{
			if (_this select 1) then {
				[player] joinSilent (createGroup playerSide);
				(group player) selectLeader player;
				{
					if !(isplayer _x) then {
						[_x] joinsilent (group player);
					};
				} foreach units (_this select 0);
			} else {
				[player] joinSilent (_this select 0);
			};
		},
		#include <mods\aaw_s.hpp>
		{player setunitrank _this;}
	] + [
		if(!isNil "ace_main") then {
			#include <mods\ace_sys_ruck_s.hpp>
			#include <mods\ace_sys_wounds_s.hpp>
		}
	]
] execfsm "core\modules\nomad\nomad.fsm";
