private ["_man", "_types"];
_man = _this select 0;

{_man disableAI _x} foreach ["autotarget","target"];

if (local _man) then {
	_man setskill 0;
	_man setunitpos "up";
	removeAllWeapons _man;
	removeAllItems _man;
	if (random 1 > 0.8) then {
		_man addweapon "itemWatch";
	};
};