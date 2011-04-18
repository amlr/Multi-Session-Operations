/*  
=========================================================
  Based on Simple Vehicle Respawn Script v1.6
  by Tophe of �stg�ta Ops [OOPS]
  
  Put this in the vehicles init line:
  veh = [this, Delay] execVM "respawn.sqf"

  Default respawn delay is 30 seconds, to set a custom
  respawn delay time, put that in the init as well. 
  Like this:
  veh = [this, 15] execVM "vehicle.sqf"

=========================================================
*/

private ["_hasname","_delay","_unit","_weapons","_mags","_unitname","_dir","_position","_type","_id"];
if (!isServer) exitWith {};

// Define variables
_unit = _this select 0;
_delay = if (count _this > 1) then {_this select 1} else {30};

_hasname = false;
_unitname = vehicleVarName _unit;
if (_unitname == "") then {_hasname = false;} else {_hasname = true;};

if (_delay < 0) then {_delay = 0};

_dir = getDir _unit;
_position = getPosASL _unit;
_type = typeOf _unit;
_weapons = getWeaponCargo _unit;
_mags = getMagazineCargo _unit;
_id = floor(random 10000);
missionNamespace setVariable[format["resupply_%1",_id], time +  _delay];


// Start monitoring the vehicle
[{
        private ["_unit","_max","_params","_id","_position","_type","_dir","_weapons","_mags","_hasname","_unitname"];
        _params = _this select 0;
        _id = _params select 0;
        _unit = _params select 1;
        _position = _params select 2;
        _type = _params select 3;
        _dir = _params select 4;
        _weapons = _params select 5;
        _mags = _params select 6;
        _hasname = _params select 7;
        _unitname = _params select 8;
        
        if(
                getPosASL _unit distance _position > 10 && 
                missionNamespace getVariable format["resupply_%1",_id] < time
        ) then {
                _unit = _type createVehicle _position;
                _unit setPosASL _position;
                _unit setDir _dir;
                
                clearWeaponCargo _unit;
                clearMagazineCargo _unit;
                
                _max = count(_weapons select 0);
                for "_i" from 0 to _max do {
                        _unit addWeaponCargo [(_weapons select 0) select _i, (_weapons select 1) select _i];
                };
                
                _max = count(_mags select 0);
                for "_i" from 0 to _max do {
                        _unit addMagazineCargo [(_mags select 0) select _i, (_mags select 1) select _i];
                };
                
                if (_hasname) then {
                        _unit setVehicleVarName _unitname;
                };

                missionNamespace setVariable[format["resupply_%1",_id], time +  _delay];
        };
}, 5, [_id, _unit, _position, _type, _dir, _weapons, _mags, _hasname, _unitname]] call CBA_fnc_addPerFrameHandler;

