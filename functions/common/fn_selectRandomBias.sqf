private ["_choices","_bias", "_result", "_j", "_i"];
_choices = _this select 0;
_bias = _this select 1;

waitUntil{!isNil "bis_fnc_init"};

_result = [];
_j = 0;
{
	for "_i" from 1 to _x do {
		_result = _result + [_choices select _j];
	};
	_j = _j + 1;
} forEach _bias;

//hint str _result;

_result call BIS_fnc_selectRandom;
