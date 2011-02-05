if (isDedicated) exitWith{};
waituntil {not isnull player};

////////////////////////////////////////////////////////////
// Respawn Handling
////////////////////////////////////////////////////////////

player setskill 0;
{player disableAI _x} foreach ["move","anim","target","autotarget"];

/*
player addeventhandler ["killed", {
	_unit = _this select 0;
	_unit setVariable ["respawn", [
		magazines _unit,
		weapons _unit,
		typeof (unitbackpack _unit),
		getmagazinecargo (unitbackpack _unit),
		getweaponcargo (unitbackpack _unit)
	], true];

	diag_log format["Killed: %1", _unit getVariable "respawn"];

	removeallweapons _unit; removeallitems _unit;
	removebackpack _unit;

}];

player addeventhandler ["respawn", {
	_unit = _this select 0;
	_corpse = _this select 1;
	diag_log format["Respawn: %1", _unit getVariable "respawn"];
	private["_obj", "_mags","_weps","_bp","_bpm","_bpw"];
	_obj = _unit getVariable "respawn";
	_mags = _obj select 0;
	_weps = _obj select 1;
	_bp = _obj select 2;

	{_unit removeweapon _x;} foreach ((weapons _unit) + (items _unit));
	{_unit removemagazine _x;} foreach (magazines _unit);

	{_unit addmagazine _x;} foreach _mags;
	{_unit addweapon _x;} foreach _weps;
	_unit selectweapon (primaryweapon _unit);
	if (_bp != "") then {
		_bpm = _obj select 3;
		_bpw = _obj select 4;

		_unit addbackpack _bp;
		clearweaponcargo (unitbackpack _unit);
		clearmagazinecargo (unitbackpack _unit);

		for "_i" from 0 to ((count (_bpm select 0))-1) do {
			(unitbackpack _unit) addmagazinecargo [(_bpm select 0) select _i,(_bpm select 1) select _i];
		};
		for "_i" from 0 to ((count (_bpw select 0))-1) do {
			(unitbackpack _unit) addweaponcargo [(_bpw select 0) select _i,(_bpw select 1) select _i];
		};
	};
}];
*/
player addeventhandler ["respawn", {
	_unit = _this select 0;
	_corpse = _this select 1;
	diag_log format["Respawn: %1", _unit];

	{_unit removeweapon _x;} foreach ((weapons _unit) + (items _unit));
	{_unit removemagazine _x;} foreach (magazines _unit);

	{_unit addmagazine _x;} foreach (magazines _corpse);
	{_unit addweapon _x;} foreach ((weapons _corpse) + (items _corpse));
	_unit selectweapon (primaryweapon _unit);

	_bp = typeof (unitbackpack _corpse);
	if (_bp != "") then {
		_bpm = getmagazinecargo (unitbackpack _corpse);
		_bpw = getweaponcargo (unitbackpack _corpse);

		_unit addbackpack _bp;
		clearweaponcargo (unitbackpack _unit);
		clearmagazinecargo (unitbackpack _unit);

		for "_i" from 0 to ((count (_bpm select 0))-1) do {
			(unitbackpack _unit) addmagazinecargo [(_bpm select 0) select _i,(_bpm select 1) select _i];
		};
		for "_i" from 0 to ((count (_bpw select 0))-1) do {
			(unitbackpack _unit) addweaponcargo [(_bpw select 0) select _i,(_bpw select 1) select _i];
		};
	};

	removeallweapons _corpse;
	removeallitems _corpse;
	removebackpack _corpse;

}];
