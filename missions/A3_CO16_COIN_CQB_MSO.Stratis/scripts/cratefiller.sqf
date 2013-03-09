/*
	@file Version: v0.1
	@file name: fillCrate.sqf
	@file Author: TAW_Tonic
	@file edit: 3/5/2013
	@file Description: Automatically fill ammo box with everything in the game.
	@usage: put in a ammoboxes init field: nul = [this] execVM "fillCrate.sqf";
*/

if(!isServer) exitWith {};
private["_box","_CfgWeapons","_weapons","_items","_wep","_wep_type","_mags","_misc","_mag"];
_box = _this select 0;

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

_CfgWeapons = configFile >> "cfgWeapons";
_weapons = [];
_items = [];
_misc = [];

for "_i" from 0 to (count _Cfgweapons)-1 do
{
	_weapon = _CfgWeapons select _i;

	if(isClass _weapon) then
	{
		_wep = configName _weapon;
		_wep_type = getNumber(_weapon >> "type");
		_scope = getNumber(_weapon >> "scope");

		if(_scope == 2 && _wep_type != 65536) then
		{
		if(_wep_type in [1,2,4,5,4096] && _wep != "NVGoggles") then
		{
			_weapons set[count _weapons,_wep];
		}
			else
		{
			_items set[count _items,_wep];
		};
		};
	};
};

//Build Throw/Put magazine array
{_misc=_misc+getArray (configFile/"CfgWeapons"/"Throw"/_x/"magazines")} forEach getArray (configFile/"CfgWeapons"/"Throw"/"muzzles");  
{_misc=_misc+getArray (configFile/"CfgWeapons"/"Put"/_x/"magazines")} forEach getArray (configFile/"CfgWeapons"/"Put"/"muzzles");

{
	_box addMagazineCargoGlobal [_x,100];
} foreach _misc;

//Add weapons & Mags
{
	_box addWeaponCargoGlobal [_x,100];
	diag_log format["Weapon %1 added", _x];

	_mags = getArray(configFile >> "CfgWeapons" >> _x >> "magazines");

	if(count _mags > 0) then
	{
		{
			if(!(_x in ((getMagazineCargo _box) select 0))) then
			{
				_box addMagazineCargoGlobal [_x,100];
				diag_log format["Magazine %1 added", _x];
			};
		} foreach _mags;
	};
} foreach _weapons;

//Add Items
{
	_box addItemCargoGlobal [_x,100];
} foreach _items;