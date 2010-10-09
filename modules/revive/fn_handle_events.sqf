// 0 : concious
// 1 : unconscious

private "_unit";
_unit = _this select 1;

switch (_this select 0) do {
	case 0 : {
		if (local _unit) then {_unit call revive_fnc_conscious};
	};
	case 1 : {
		_unit call revive_fnc_unconscious;
	};
	case 2 : {
		if (local _unit) then {
			waituntil {alive player};
			_unit = player;
		};
		_unit call revive_fnc_init;
	};
};
if (count _this == 2) then {
	revive_pv = _this + [0];
	publicvariable "revive_pv";
};