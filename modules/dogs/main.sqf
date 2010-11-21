if (!isServer) exitWith{};

[] spawn {
	_debug = true;
	
	private ["_towns"];
	waitUntil{!isNil "BIS_fnc_init"};
	_towns = [["FlatArea"]] call BIS_fnc_locations;
	_istart = floor(random 3);
	_i = _istart;
	_d = 500;
	_tarea = 150;	
	{
		if (_i mod 3 == 0) then {
			_name = format["wdtrg_%1", _i];
			
			// randomise wild dog positions
			_dx = (random _d) - (_d/2);
			_dy = (random _d) - (_d/2);
			_pos = position _x;
			_pos = [(_pos select 0) + _dx, (_pos select 1) + _dy];
			
			_trg = createTrigger["EmptyDetector", _pos];
			call compile format["%1 = _trg;", _name];
			_trg setTriggerActivation ["WEST", "PRESENT", true];
			_trg setTriggerArea [_tarea, _tarea, 0, false];
			_trg setTriggerStatements ["this", format["[%1, thislist] spawn dogs_fnc_wilddogs;", _name], ""];
			
			if (_debug) then {
				_m = ["m_" + _name, _pos, "ELLIPSE", [_tarea,_tarea], "GLOBAL"] call CBA_fnc_createMarker;
				[_m, true] call CBA_fnc_setMarkerPersistent;
			};
		};
		_i = _i + 1;
	} foreach _towns;
	
	while{true} do {
		_i = _istart;
		{
			if (_i mod 3 == 0) then {
				_name = format["wdtrg_%1", _i];

				// randomise wild dog positions
				_dx = (random _d) - (_d/2);
				_dy = (random _d) - (_d/2);
				_pos = position _x;
				_pos = [(_pos select 0) + _dx, (_pos select 1) + _dy];

				call compile format["_trg = %1;", _name];
				_trg setPos _pos;

				if (_debug) then {
					_m setMarkerPos _pos;
				};
			};
			_i = _i + 1;
		} foreach _towns;
		sleep (60 * 15) + random (60 * 30);
	};
};