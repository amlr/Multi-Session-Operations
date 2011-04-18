
private ["_fac","_allvehs","_vehx","_sx","_fx","_cx","_cargoslots","_grpx","_type","_nonconfigs","_nonsims","_tx","_scope"];
_cargoslots = _this select 0;
_fac = nil;
_type = nil;
_nonConfigs = ["StaticWeapon","CruiseMissile1","CruiseMissile2","Chukar_EP1","Chukar_AllwaysEnemy_EP1"];
_nonSims = ["parachute"];

if(count _this > 1) then {
    _fac = _this select 1;
};

if(count _this > 2) then {
    _type = _this select 2;
};

_allvehs = [];
_grpx = count(configFile >> "CfgVehicles");
for "_y" from 1 to _grpx - 1 do {
    _vehx = (configFile >> "CfgVehicles") select _y;
    _sx = getText(_vehx >> "simulation");
    _fx = getText(_vehx >> "faction");
    _tx = getNumber(_vehx >> "TransportSoldier");
	_scope = getNumber (_vehx >> "scope");
    _cx = configName _vehx;
    //hint str _fx;
    //hint str typeName _fac;
    if (_tx >= _cargoslots && !(_cx in _nonconfigs) && !(_sx in _nonsims) && (_scope > 1)) then {
        if (!isNil "_fac") then {
            switch(typeName _fac) do {
                case "STRING": {
                    if(_fx == _fac) then {
                        if (!isnil "_type") then {
                            if (_cx isKindOf _type) then {
                                _allvehs = _allvehs + [_cx]; 
                            };
                        } else {
                            _allvehs = _allvehs + [_cx]; 
                        };
                    };
                };
                case "ARRAY": {
                    if(_fx in _fac) then {
                        if (!isnil "_type") then {
                            if (_cx isKindOf _type) then {
                                _allvehs = _allvehs + [_cx]; 
                            };
                        } else {
                            _allvehs = _allvehs + [_cx]; 
                        };
                    };
                };
            };
        };
    };
};

_allvehs;