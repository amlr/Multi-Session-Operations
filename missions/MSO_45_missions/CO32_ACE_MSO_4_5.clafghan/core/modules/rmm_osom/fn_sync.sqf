if ((_this getvariable "active") && !(_this getvariable "forced")) then {
	private "_group";
	_group = _this getvariable "group";
	if (isnil {_group}) exitwith {deletelocation _this};
	if (isnull _group) exitwith {deletelocation _this};
	if ({alive _x} count (units _group) == 0) exitwith {deletelocation _this};
	_this setPosition (getpos (leader _group));
};