if (isDedicated) exitWith{};
waituntil {not isnull player};

////////////////////////////////////////////////////////////
// Respawn Handling
////////////////////////////////////////////////////////////

player setskill 0;
{player disableAI _x} foreach ["move","anim","target","autotarget"];

player addeventhandler ["killed", {
	player setVariable ["respawn", [
		magazines player,
		weapons player,
		typeof (unitbackpack player),
		getmagazinecargo (unitbackpack player),
		getweaponcargo (unitbackpack player)
	], true];

	diag_log format["Killed: %1", player getVariable "respawn"];

	removeallweapons player; removeallitems player;
	removebackpack player;

}];

player addeventhandler ["respawn", {
	diag_log format["Respawn: %1", player getVariable "respawn"];
	private["_obj", "_mags","_weps","_bp","_bpm","_bpw"];
	_obj = player getVariable "respawn";
	_mags = _obj select 0;
	_weps = _obj select 1;
	_bp = _obj select 2;

	{player removeweapon _x;} foreach ((weapons player) + (items player));
	{player removemagazine _x;} foreach (magazines player);

	{player addmagazine _x;} foreach _mags;
	{player addweapon _x;} foreach _weps;
	player selectweapon (primaryweapon player);
	if (_bp != "") then {
		_bpm = _obj select 3;
		_bpw = _obj select 4;

		player addbackpack _bp;
		clearweaponcargo (unitbackpack player);
		clearmagazinecargo (unitbackpack player);

		for "_i" from 0 to ((count (_bpm select 0))-1) do {
			(unitbackpack player) addmagazinecargo [(_bpm select 0) select _i,(_bpm select 1) select _i];
		};
		for "_i" from 0 to ((count (_bpw select 0))-1) do {
			(unitbackpack player) addweaponcargo [(_bpw select 0) select _i,(_bpw select 1) select _i];
		};
	};
}];
