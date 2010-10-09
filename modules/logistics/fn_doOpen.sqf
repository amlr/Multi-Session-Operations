createDialog "RMM_ui_logistics";

lbClear 1;
lbClear 3;

private ["_target","_typeof"];
_target = _this;
_typeof = typeof _target;

private ["_volume"];
_volume = _target getvariable "logistics_volume";
if (isnil "_volume") then {
	_volume = ([_target] call RMM_fnc_getvolume) ^ 0.5;
	_target setvariable ["logistics_volume",_volume];
	{
		private ["_volume_o"];
		_volume_o = [_x] call RMM_fnc_getvolume;
		_target setvariable ["logistics_volume",_volume - _volume_o];
	} foreach (_target getvariable "logistics_contents");
};

ctrlsettext [2,format ["%1 (%2m3 remaining)", gettext (configfile >> "cfgvehicles" >> _typeof >> "displayname"),floor(_volume)]];

private ["_nearby"];
_nearby = nearestobjects [_target,["LandVehicle","M1030_US_DES_EP1","reammobox","staticweapon","barrelbase","land_fort_bagfence_corner","TargetEpopup","land_tires_ep1","land_fort_bagfence_long","land_fort_bagfence_round","land_bagfencecorner","roadbarrier_light","roadcone","rubberboat","land_camonet_nato","land_camonet_east","helih"],sizeof _typeof];
{
	private ["_type","_text","_tvolume","_icon"];
	_type = typeof _x;
	_text = gettext (configfile >> "cfgvehicles" >> _type >> "displayname");
	//_icon = gettext (configfile >> "cfgvehicles" >> _type >> "icon");
	_tvolume = [_x] call RMM_fnc_getvolume;
	if (_volume > _tvolume) then {
		lbadd [1, format[_text + " (%1m3)",ceil _tvolume]];
	};
} foreach _nearby;

private ["_array"];
_array = _target getvariable "logistics_contents";
{
	private ["_type","_text","_icon"];
	_type = typeof _x;
	_text = gettext (configfile >> "cfgvehicles" >> _type >> "displayname");
	//_icon = gettext (configfile >> "cfgvehicles" >> _type >> "icon");
	lbadd [3, format[_text + " (%1m3)",ceil ([_x] call RMM_fnc_getvolume)]];
} foreach _array;

player setvariable ["logistics_target",_target];
player setvariable ["logistics_nearby",_nearby];