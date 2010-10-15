execvm "nightpatrol.sqf"

---

_night = false;
_spawned = false;
_patrol = false;

while { (some condition?) } do {
	if (daytime < 6 or daytime > 20) then {
		_night = true;
	} else {
		_night = false;
	};
	if (_night) then {
		if (not _spawned) then {
			if ({[_x,_position] call cba_fnc_getdistance < 800} count playableunits == 0) then { // no player within 800m
				_spawned = true;
				_group = [getpos _position, east, 12] call BIS_fnc_spawngroup; // create group
				_group execvm "buildAnimations.sqf";
				sleep 20;
				_position execvm "createcamp.sqf";
				sleep 900; // 15 minutes will do for camp setup
			};
		} else {
			if (not _patrol) then { // only do it once
				_patrol = true;
				if (random 1 > 0.5) then {
					[_group, _group, 500] call cba_fnc_taskpatrol; //patrol them around
				};
			};
		};
	} else {
		if (_spawned) then {
			if ({[_x,_position] call cba_fnc_getdistance < 800} count playableunits == 0) then { // no player within 800m
				{deletevehicle _x} foreach (units _group);
			};
			_spawned = false;
		};
		_patrol = false;
	};
	sleep 60;
};