// Written by BON_IF
// Adapted by Tupolov

_objects = _this;

{
	_x addEventHandler ["HandleDamage", {
		_target = _this select 0;
		_source = _this select 3;

		if (_source iskindof "Air") then { 1 } else { 0 };
	}];

} foreach _objects;
