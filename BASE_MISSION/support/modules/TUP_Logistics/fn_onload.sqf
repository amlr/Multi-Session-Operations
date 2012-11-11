private ["_i","_name","_logisticType"];
_i = 0;

tup_logistics_order = [];

{
	{
		lbAdd [_i, _x];
	} foreach (call _x);
	_i = _i + 1;
} foreach TUP_logistics_lines;


{
	lbAdd [11,_x];
} foreach TUP_logistics_delivery;

_logisticType = [tup_logistics_air,tup_logistics_land,tup_logistics_crate,tup_logistics_static,tup_logistics_defence];
_i = 5;
{
	{
		_name = format ["%1 (%2)", getText(configFile >> "CfgVehicles" >> _x >> "displayname"), str _x];
		lbAdd [_i, _name];
	} foreach _x;
	_i = _i + 1;
} foreach _logisticType;