private ["_delay"];

_delay = 15;

[_delay] spawn {
	private ["_m","_repeat","_delay","_markers"];
	_delay = _this select 0;
	_repeat = true;
	_markers = [];
	while{_repeat} do {
		{
			deleteMarkerLocal _x;
		} forEach _markers;

		_markers = [];

		{
		        if(side _x == civilian) then {
				_m = createMarkerLocal [str _x, position _x];
				//_m setMarkerShapeLocal "ICON";
				_m setMarkerTypeLocal "mil_dot";
             			_m setMarkerColorLocal "ColorGreen";
				//_m setMarkerTextLocal typeof _x;
				_markers set [count _markers, _m];
			};
		} forEach allUnits;
				
		if(_delay == 0) then {
			_repeat = false
		} else {
			sleep _delay;
		};
	};
};
