
private ["_name"];

{
	if (getText(configFile >> "CfgVehicles" >> _x >> "faction") == faction player) then {
		_name = format ["%1 (%2)", getText(configFile >> "CfgVehicles" >> _x >> "displayname"), str _x];
		lbAdd [1, _name];
	};
} foreach tup_recruit_classes;
