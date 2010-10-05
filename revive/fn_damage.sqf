private ["_unit","_dmg"];
_unit = _this select 0;
_dmg = _this select 2;
if (_dmg > 6) exitwith {_dmg};
if (_this select 4 == "" and _dmg > 10) exitwith {_dmg};
if (_this select 1 == "head_hit") exitwith {_dmg};
if (damage _unit + _dmg <= 0.89) exitwith {_dmg};
if (lifestate _unit == "alive") exitwith {
	[1,_unit] call revive_fnc_handle_events;
	0
};
_dmg