if (local _this) then {
	if (not isnil {_this getvariable "revive_eh_damage"}) then {_this removeeventhandler ["handledamage",_this getvariable "revive_eh_damage"];};
	_this setvariable ["revive_eh_damage", _this addeventhandler ["handledamage", "_this call revive_fnc_damage"]];
	//allow for respawn
	if (not isnil {_this getvariable "revive_eh_killed"}) then {_this removeeventhandler ["killed",_this getvariable "revive_eh_killed"];};
	_this setvariable ["revive_eh_killed", _this addeventhandler ["killed", "if (player == (_this select 0)) then {[] spawn {waituntil {sleep 0.5;alive player;}; player call revive_fnc_init;};};"]];
};