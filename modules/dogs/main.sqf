if (!isServer) exitWith{};

[] spawn {
	_debug = true;
	
	private ["_towns"];
	waitUntil{!isNil "BIS_fnc_init"};
	_towns = [["FlatArea"]] call BIS_fnc_locations;
	_i = floor(random 3);
	{
		if (_i mod 3 == 0) then {
			_name = format["wdtrg_%1", _i];
			
			// randomise wild dog positions
			_d = 500;
			_dx = (random _d) - (_d/2);
			_dy = (random _d) - (_d/2);
			_pos = position _x;
			_pos = [(_pos select 0) + _dx, (_pos select 1) + _dy];
			
			_tarea = 200;	
			_trg = createTrigger["EmptyDetector", _pos];
			call compile format["%1 = _trg;", _name];
			_trg setTriggerActivation ["WEST", "PRESENT", true];
			_trg setTriggerArea [_tarea, _tarea, 0, false];
			_trg setTriggerStatements ["this", format["[%1, thislist] spawn dogs_fnc_wilddogs;", _name], ""];
			
			if (_debug) then {
				_m = createMarker ["m_" + _name, _pos];
				_m setMarkerShape "ELLIPSE";
				_m setMarkerSize [_tarea,_tarea];
			};
		};
		_i = _i + 1;
	} foreach _towns;
};
