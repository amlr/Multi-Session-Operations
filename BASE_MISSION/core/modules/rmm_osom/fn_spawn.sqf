private ["_data","_group","_logic","_type","_position","_weapons","_magazines","_vehicle","_damage","_skill","_rank","_unit","_vehicle_pos"];
_data = _this select 0;
_group = _this select 1;
_logic = _this select 2;

_type = _data select 0;
_position = _data select 1;
_weapons = _data select 2;
_magazines = _data select 3;
_vehicle = _data select 4;
_vehicle_pos = _data select 5;
_damage = _data select 6;
_skill = _data select 7;
_rank = _data select 8;

_unit = _group createUnit [_type, _position, [], 0, "NONE"];
_unit setpos _position;
_unit setskill _skill;
_unit setrank _rank;
removeallweapons _unit;
removeallitems _unit;
{_unit addweapon _x} foreach _weapons;
{_unit addmagazine _x} foreach _magazines;
_unit setdamage _damage;

if (count _vehicle_pos > 0) then {
	switch(_vehicle_pos select 0) do {
	case "Driver": {
			_unit moveInDriver _vehicle;
		};
	case "Commander": {
			_unit moveInCommander _vehicle;
		};
	case "Cargo": {
			_unit moveInCargo _vehicle;
		};
	case "Turret": {
			_unit moveInGunner _vehicle;
		};
	};
};