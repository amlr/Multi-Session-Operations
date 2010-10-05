_old = player;
_pos = getposasl player;

selectPlayer ((createGroup playerSide) createUnit ["BAF_Soldier_Sniper_MTP",[0,0,0],[],0,"NONE"]);
removeallweapons player;
removeallitems player;
{player addmagazine _x} foreach (magazines _old);
{player addweapon _x} foreach (weapons _old);
player setdir (getdir _old);

player switchmove "";
player selectweapon (primaryWeapon player);

player setskill 0;
{player disableAI _x} foreach ["move","anim","target","autotarget"];

_backpack = typeof (unitBackpack _old);
_mags = getMagazineCargo (unitBackpack _old);
_weps = getWeaponCargo (unitBackpack _old);
if (_backpack != "") then {
	player addbackpack _backpack;
	clearweaponcargo (unitbackpack player);
	clearmagazinecargo (unitbackpack player);

	for "_i" from 0 to ((count (_mags select 0))-1) do {
		(unitBackpack player) addMagazineCargo [(_mags select 0) select _i,(_mags select 1) select _i];
	};

	for "_i" from 0 to ((count (_weps select 0))-1) do {
		(unitBackpack player) addWeaponCargo [(_weps select 0) select _i,(_weps select 1) select _i];
	};
};

player setvehicleinit "[] spawn {waituntil{not (isplayer this)}; deletevehicle this;};"; processinitcommands;

_old setpos [0,0,0];
player setvariable ["playerUnit",_old];
player addeventhandler ["killed",{((_this select 0) getvariable "playerUnit") setposatl (getmarkerpos "respawn_west"); selectPlayer (player getvariable "playerUnit"); player setdamage 1; _grp = group (_this select 0); deletevehicle (_this select 0); deletegroup _grp;}];
player setposasl _pos;