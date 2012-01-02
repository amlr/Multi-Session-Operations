if (isdedicated) exitwith {};
{
	if (not isnil {_x getvariable "logistics"}) then {
		_x addaction ["Logistics",CBA_fnc_actionargument_path,[0,{_target call logistics_fnc_open}],-1,false,true,"","(vehicle _this == _this)"];
	};
} foreach vehicles;