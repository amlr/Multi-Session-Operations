//Simple Vehicle Restriction script running locally. No FSMs or permanent loops needed.
//RestrictionArray: Vehicle (select 0) may only be driven by the units defined (select 1)
//Just run this script on init. Vehicle must exist on map.

if (isDedicated) exitwith {};
RestrictionArray = [
	["ACE_BCS_HMMV",["BAF_Soldier_AMG_MTP"]],
	["ACE_MTVRReammo_DES_EP1",["USMC_Soldier_SL","BAF_Soldier_AMG_MTP"]]
];

RestrictFunction = {
	_vehicle = _this select 0;
	_vehPos = _this select 1;
	_unit = _this select 2;
    _allowedUnits = _vehicle getvariable "allowedDrivers";
	
	while {!(_unit == vehicle _unit)} do {
		if ((_unit == driver vehicle _unit) && !(typeof _unit in _allowedUnits)) then {
			hint "You are not allowed to drive this vehicle!";
			_unit action ["EJECT", _vehicle];
	    };
	    sleep 0.5;
	};
};

for "_i" from 0 to ((count RestrictionArray)-1) do {
    _carType = (RestrictionArray select _i) select 0;
    _allowedUnits = (RestrictionArray select _i) select 1;
    
    {    
        if (typeof _x == _carType) then {
            _x setvariable ["allowedDrivers",_allowedUnits];
	        _x addEventHandler ["GetIn", {
				if ((_this select 2) == player) then {[_this select 0,_this select 1,_this select 2] spawn RestrictFunction};
	        }];
    	};
	} foreach vehicles;
};