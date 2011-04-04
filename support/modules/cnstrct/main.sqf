if (isdedicated) exitwith {};
{
	if (not isnil {_x getvariable "construction"}) then {
		_x addaction ["Construction",CBA_fnc_actionargument_path,[0,{_target call cnstrct_fnc_open}],-1,false,true,"","vehicle _this == _this"];
	};
} foreach vehicles;