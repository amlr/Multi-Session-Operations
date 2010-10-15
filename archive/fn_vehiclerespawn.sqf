private ["_vehicle"];
_vehicle = _this select 0;
_respawn_delay = _this select 1;
_abandon_respawn = _this select 2;
_destroyed_respawn = _this select 3;
_disabled_respawn = _this select 4;
_nofuel_respawn = _this select 5;
_respawn_ai = _this select 6;

private ["_position", "_direction", "_abandoned", "_destroyed", "_disabled", "_nofuel"];
_position = getpos _vehicle;
_direction = getdir _vehicle;

_abandoned = false;
_destroyed = false;
_disabled = false;
_nofuel = false;

while {true} do {
	if (_abandon_respawn) then {
	sleep _respawn_delay;
};