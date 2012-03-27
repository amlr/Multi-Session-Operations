
private ["_name"];

hint "Loading available recruits...";

tup_recruit_classes = [0, faction player,"Man"] call mso_core_fnc_findVehicleType;

hint "Recruit information ready.";

{
	_name = format ["%1 (%2)", getText(configFile >> "CfgVehicles" >> _x >> "displayname"), str _x];
	lbAdd [1, _name];
} foreach tup_recruit_classes;
