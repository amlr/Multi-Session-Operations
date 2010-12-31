
private ["_fac","_allvehs","_vehx","_sx","_fx","_cx","_cargoslots","_grpx"];
_cargoslots = _this select 0;
_fac = nil;
if(count _this > 1) then {
	_fac = _this select 1;
};

_allvehs = [];
_grpx = count(configFile >> "CfgVehicles");
for "_y" from 1 to _grpx - 1 do {
	_vehx = (configFile >> "CfgVehicles") select _y;
	_sx = getNumber(_vehx >> "transportSoldier");
	_fx = getText(_vehx >> "faction");
	_cx = configName _vehx;
//	hint str _fx;
	if (_sx > _cargoslots) then {
		if (!isNil "_fac") then {
			if ((typeName _fac == "STRING" && _fx == _fac) || (typeName _fac == "ARRAY" && _fx in _fac)) then {
				_allvehs = _allvehs + [_cx];
			};
		};
	};
};

_allvehs;