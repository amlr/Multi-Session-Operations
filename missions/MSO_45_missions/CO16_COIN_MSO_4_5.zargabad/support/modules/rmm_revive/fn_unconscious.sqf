if (not isnil {_this getvariable "revive_eh_heal"}) then {_this removeeventhandler ["handleheal",_this getvariable "revive_eh_heal"]};
_this setvariable ["revive_eh_heal",_this addeventhandler ["handleheal", "0 = _this spawn revive_fnc_heal"]];

if (not isnil {_this getvariable "revive_act_drag"}) then {_this removeaction (_this getvariable "revive_act_drag")};
if (isnil {_this getvariable "revive_dragged"}) then {_this setvariable ["revive_dragged", false]};
_this setvariable ["revive_act_drag",(_this addaction [localize "BC_addActions.sqf13", revive_fnc_drag_path, nil, -1, false, true, "", "(_this distance _target < 3) and (lifestate _target == ""unconscious"") and not (_target getvariable ""revive_dragged"")"])];

if ((vehicle _this) != _this) then {
	private ["_vehicle"];
	_vehicle = vehicle _this;
	if (isnil {_vehicle getvariable "revive_takeout"}) then {
		_vehicle setvariable ["revive_takeout",_vehicle addaction [localize "str_agonytakeoutaction", revive_fnc_takeout_path, nil, -1, true, true, "", "{lifestate _x == ""unconscious""} count crew _target > 0"]];
	};
};

_this setunconscious true;
if not (isplayer _this) then {
	_this disableAI "anim";
};

_this spawn {
	if ((vehicle _this) != _this) then {
		_this playaction "gestureagonycargo";
		while {(vehicle _this) != _this} do {
			if (not alive (vehicle _this)) exitwith {
				dogetout _this;
				_this action ["eject", (vehicle _this)];
			};
			sleep 0.1;
		};
		waituntil {sleep 0.5;(vehicle _this) == _this || isnull _this};
		_this playaction "gesturenod";
	};
	if not (alive _this) exitwith {};
	_this playaction "agonystart";
	waituntil {sleep 0.5;animationstate _this == "ainjppnemstpsnonwrfldnon" or not alive _this};
	_this playaction "gesturespasm" + str floor random 7;
	waituntil {sleep 0.5;animationstate _this != "ainjppnemstpsnonwrfldnon" or not alive _this};
	_this playaction "gesturenod";
};