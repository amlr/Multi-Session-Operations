createDialog "RMM_ui_logbook";

waituntil {dialog};

lbClear 1;

private ["_vehicle", "_log"];
_vehicle = _this select 0;

if (isnil {_vehicle getvariable "RMM_logbook"}) then {_vehicle setvariable ["RMM_logbook",[],true]};
_log = _vehicle getvariable "RMM_logbook";
{
	lbadd [1, format ["%1, %2", _x select 0, _x select 1]];
} foreach _log;