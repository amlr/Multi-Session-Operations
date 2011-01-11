private ["_side"];
_side = sideLogic;
if (!isnil "_this") then {
	_side = _this;
};

switch (_side) do {
	case west : {playersnumber west};
	case east : {playersnumber east};
	case resistance : {playersnumber resistance};
	case civilian : {playersnumber civilian};
	default {(playersnumber west) + (playersnumber east) + (playersnumber resistance) + (playersnumber civilian)};
};