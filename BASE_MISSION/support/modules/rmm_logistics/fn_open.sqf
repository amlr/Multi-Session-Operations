createDialog "RMM_ui_logistics";

lbClear 1;
lbClear 3;

private ["_target","_typeof"];
_target = _this;
_typeof = typeof _target;

private ["_volume"];
_volume = _target getvariable "logistics_volume";
if (isnil "_volume") then {
	_volume = ([_target] call CBA_fnc_getvolume) ^ 0.5;
	_target setvariable ["logistics_volume",_volume];
	{
		private ["_volume_o"];
		_volume_o = [_x] call CBA_fnc_getvolume;
		_target setvariable ["logistics_volume",_volume - _volume_o];
	} foreach (_target getvariable "logistics_contents");
};

ctrlsettext [2,format ["%1 (%2m3 remaining)", gettext (configfile >> "cfgvehicles" >> _typeof >> "displayname"),(round (_volume * 10^4))/10^4]];

private ["_nearby"];
_nearby = (nearestobjects [_target,[
	"LandVehicle","M1030_US_DES_EP1","reammobox",
	"staticweapon","barrelbase","land_fort_bagfence_corner",
	"TargetEpopup","land_tires_ep1","land_fort_bagfence_long",
	"land_fort_bagfence_round","land_bagfencecorner","roadbarrier_light",
	"roadcone","rubberboat","land_camonet_nato",
	"land_camonet_east","helih",
	"Land_HBarrier_large", "Land_Misc_Cargo1Ao_EP1", "Land_Misc_Cargo1E_EP1",
	"Misc_cargo_cont_small", "Misc_cargo_cont_small2", "Misc_cargo_cont_tiny",
	"Misc_cargo_cont_net1", "Misc_cargo_cont_net2", "Misc_cargo_cont_net3"
],sizeof _typeof]) - [_target];
{
	private ["_type","_text","_tvolume","_icon"];
	_type = typeof _x;
	_text = gettext (configfile >> "cfgvehicles" >> _type >> "displayname");
	//_icon = gettext (configfile >> "cfgvehicles" >> _type >> "icon");
	_tvolume = [_x] call CBA_fnc_getvolume;
	if (_volume > _tvolume) then {
		lbadd [1, format[_text + " (%1m3)",(round (_tvolume * 10^4))/10^4]];
	} else {
		_nearby = _nearby - [_x];
	};
} foreach _nearby;

private ["_array"];
_array = _target getvariable "logistics_contents";
{
	private ["_type","_text","_icon"];
	_type = typeof _x;
	_text = gettext (configfile >> "cfgvehicles" >> _type >> "displayname");
	//_icon = gettext (configfile >> "cfgvehicles" >> _type >> "icon");
	lbadd [3, format[_text + " (%1m3)",(round (([_x] call CBA_fnc_getvolume) * 10^4))/10^4]];
} foreach _array;

player setvariable ["logistics_target",_target];
player setvariable ["logistics_nearby",_nearby];