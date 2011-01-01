if (!isServer) exitWith{};

private["_debug","_types","_d","_tarea","_dogs", "_side"];
_debug = true;

waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call CRB_fnc_initLocations;
};

_types = ["FlatArea","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
_d = 100;
_tarea = 250;
_dogs = [];
_side = "WEST";
if(count _this > 0) then {
	_side = _this select 0;
};

{
	if(type _x in _types) then {
		if (random 1 > 0.75) then {
			private["_name","_dx","_dy","_pos","_trg","_m"];
			_name = format["wdtrg_%1", floor(random 10000)];
			diag_log format["MSO-%1 Dog Packs: createTrigger %2", time, _name];
			
			// randomise wild dog positions
			_pos = position _x;
			_pos = [_pos, 0, _d, 1, 0, 50, 0] call bis_fnc_findSafePos;			
			_trg = createTrigger["EmptyDetector", _pos];
			call compile format["%1 = _trg;", _name];
			_trg setTriggerActivation [_side, "PRESENT", true];
			_trg setTriggerArea [_tarea, _tarea, 0, false];
			_trg setTriggerStatements ["this", format["[%1, thislist] spawn dogs_fnc_wilddogs;", _name], ""];
			
			if (_debug) then {
				hint format["Dogs: creating m_%1",  _name];
				_m = ["m_" + _name, _pos, "ELLIPSE", [_tarea,_tarea], "GLOBAL"] call CBA_fnc_createMarker;
				[_m, true] call CBA_fnc_setMarkerPersistent;
			};
			_dogs = _dogs + [[_name, _trg]];
		};
	};
} forEach CRB_LOCS;


[_dogs, _d, _debug] spawn {
	private["_dogs","_dx","_dy","_pos","_d","_sleep","_name","_trg"];
	_dogs = _this select 0;
	_d = _this select 1;
	_debug = _this select 2;
	while{true} do {
		{
			_name = _x select 0;
			_trg = _x select 1;
			_sleep = if(_debug)then{30;}else{random (60 * 45);};
			sleep _sleep;
			// randomise wild dog positions
			_pos = position _trg;
			_pos = [_pos, 0, _d, 1, 0, 50, 0] call bis_fnc_findSafePos;			
			_trg setPos _pos;
			if(_debug)then{
				hint format["Dogs: moving %1 to %2", _name, _pos];
				format["m_%1", _name] setMarkerPos _pos;
			};
		} foreach _dogs;
	};
};

diag_log format["MSO-%1 Dog Packs # %2", time, count _dogs];