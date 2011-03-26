private ["_typeof", "_position", "_velocity", "_vehicle"];
_typeof = lbText [2,lbCurSel 2];
RMM_cas_available = RMM_cas_available - [_typeof];
publicvariable "RMM_cas_available";

_position = [0,0,0];
_velocity = [0,0,2];
if (_typeof iskindof "Air") then {
	_position set [2, 1500]; _velocity set [1, 800];
};
_vehicle = ([_position, 0, _typeof, group player] call BIS_fnc_spawnVehicle) select 0;
_vehicle setvelocity _velocity;
_vehicle lockdriver true;

if (_typeof iskindof "Air") then {
	private "_height";
	_height = parseNumber (lbText [4,lbCurSel 4]);
	_vehicle flyinheight _height;
};

[1,[_vehicle, (parseNumber (lbText [3,lbCurSel 3])) * 60],{
	_this spawn {
		private ["_vehicle","_typeof","_duration"];
		_vehicle = _this select 0;
		_typeof = typeof _vehicle;
		_duration = _this select 1;
		sleep (_duration + random 70);
		if (alive _vehicle) then {
			waituntil {{isplayer _x} count (crew _vehicle) == 0};
			(crew _vehicle) join (createGroup (side (driver _vehicle)));
			{
				_x setskill 0;
				_x disableai "TARGET";
				_x disableai "AUTOTARGET";
			} foreach (units (group _vehicle));
			(group _vehicle) addwaypoint [[-1000,-1000,1000],0];
			sleep (_duration * 0.2);
			_vehicle call CBA_fnc_deleteEntity;
			sleep 3600;
			RMM_cas_available set [count RMM_cas_available, _typeof];
			publicvariable "RMM_cas_available";
		};
} else {
	hint format["CAS not available until %1", [if(daytime < 21)then{daytime+3}else{daytime-21}] call BIS_fnc_timeToString];
};