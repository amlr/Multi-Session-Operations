if (isdedicated) exitwith {};
waitUntil{!isNil "bis_fnc_init"};
{
	if (_x iskindof "Car") then {
		_x addaction ["Change Tyres",CBA_fnc_actionargument_path,[0,{[_caller,_target] call tyres_fnc_change}],-1,false,true,"","(vehicle _this == _this) && !(canmove _target)"];
	};
} foreach vehicles;