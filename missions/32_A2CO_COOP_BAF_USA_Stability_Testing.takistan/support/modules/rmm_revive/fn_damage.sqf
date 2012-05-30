private ["_unit","_dmg"];
_unit = _this select 0;
_dmg = _this select 2;
if (_dmg > 6) exitwith {_dmg};
if (_this select 4 == "" and _dmg > 10) exitwith {_dmg};
if (_this select 1 == "head_hit") exitwith {_dmg};
if (damage _unit + _dmg <= 0.89) exitwith {_dmg};
if (lifestate _unit == "alive") exitwith {
	[0,_unit,{_this call revive_fnc_unconscious}] call mso_core_fnc_ExMP;
	0
};
_dmg