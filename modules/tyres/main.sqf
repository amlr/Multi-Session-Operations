if (isdedicated) exitwith {};
{
	if (_x iskindof "Car") then {
		_x addaction ["Change Tyres",RMM_fnc_actionargument_path,[0,{[_caller,_target] call tyres_fnc_change}],-1,false,true,"","(vehicle _this == _this) && !(canmove _target)"];
	};
} foreach vehicles;