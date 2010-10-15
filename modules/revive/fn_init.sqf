if (isnil "revive_initdone") then {
	"revive_pv" addpublicvariableeventhandler {(_this select 1) call revive_fnc_handle_events};
	revive_initdone = true;
};

if (local _this) then {
	if (not isnil {_this getvariable "revive_eh_damage"}) then {_this removeeventhandler ["handledamage",_this getvariable "revive_eh_damage"]};
	_this setvariable ["revive_eh_damage", _this addeventhandler ["handledamage", "_this call revive_fnc_damage"]];
	//allow for respawn
	if (_this in playableunits) then {
		if (not isnil {_this getvariable "revive_eh_killed"}) then {_this removeeventhandler ["handledamage",_this getvariable "revive_eh_killed"]};
		_this setvariable ["revive_eh_killed", _this addeventhandler ["killed", "0 = [2,_this select 0] spawn revive_fnc_handle_events"]];
	};
};