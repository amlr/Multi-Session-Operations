if (isdedicated) exitwith {};

[] spawn {
	private ["_fnc_between","_fnc_prayer","_towns"];

	_fnc_between = {
		_a = _this select 0;
		_b = _this select 1;
		(daytime >= _a AND daytime < _b)
	};

	_fnc_prayer = {
		private ["_town"];
		_town = _this;
		{
			sleep (random 5);
			_x say3D "muezzin";
		} foreach (_town getvariable "EP1_Minarets");
	};

	_towns = [["CityCenter"]] call BIS_fnc_locations;
	{
		_list = nearestobjects [position _x,["Land_A_Minaret_EP1","Land_A_Minaret_Porto_EP1"],500];
		if (count _list > 0) then {
			_x setvariable ["EP1_Minarets",_list];
		} else {
			_towns = _towns - [_x];
		};
	} foreach _towns;

	waituntil {(round time) mod 10 == 0};
	while {true} do {
		{
			if (_x call _fnc_between) exitwith {
				{
					_x call _fnc_prayer;
				} foreach _towns;
				sleep 120;
			};
		} foreach [[4.25,4.5],[5.25,5.75],[11.75,12],[15.25,15.5],[17.75,18.25],[19,19.25]];
		sleep 10;
	};
};