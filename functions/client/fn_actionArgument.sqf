//captive addaction ["rescue",RMM_fnc_actionargument,[[],{[_target] join (group _caller)},true]] //captive joins action callers group, action is removed (true)

private ["_target","_caller","_id","_arguments"];
_target = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_arguments = _this select 3;

(_arguments select 0) call (_arguments select 1);

if (count _arguments > 2) then {
	if (_arguments select 2) then {
		_target removeAction _id;
	};
};