//Ranged Ordinance Seeking/Sniffing Canine Operational Entity - ROSCOE

//EODD - Explosive Ordnance Detection Dog
_EODD = createVehicle ["Pastor",getmarkerpos "dogspawn",[],0,"NONE"];
private ["_action"];
_EODD addaction ["EODD Orders","dialogs\EODDopen.sqf"];
player setvariable ["EODD_canmove",true];
player setvariable ["EODD",_EODD];

private "_i";
_i = 30;

while {alive _EODD} do {
	private ["_distance","_dir","_dir2","_anim"];
	_distance = _EODD distance player;
	_dir = [_EODD,player] call BIS_fnc_relativeDirTo;
	_anim = animationstate _EODD;
	if (abs _dir > 6) then {
		private ["_newdir"];
		if (_dir > 180) then {_dir = _dir - 360};
		_newdir = (getdir _EODD) + (_dir min 15);
		_EODD setdir _newdir;
		if (_anim == "Dog_Stop") then {
			private ["_turnanim"];
			_turnanim = switch (true) do {
				case (_dir > 0) : {"Dog_TurnR"};
				case (_dir < 0) : {"Dog_TurnL"};
				default {""};
			};
			if (_anim != _turnanim) then {
				_EODD switchmove _turnanim;
				for "_i" from 0 to 9 do {
					_EODD setdir ((getdir _EODD) + (_dir/10));
					sleep 0.06;
				};
				_EODD setdir ([_EODD,player] call BIS_fnc_dirTo);
				_EODD switchMove "Dog_Stop";
			};
		};
	};
	if (player getvariable "EODD_canmove") then {
		if (_distance > 1.5 && _distance < 100) then {
			private ["_moveanim"];
			_moveanim = switch (true) do {
				case (_distance > 9) : {"Dog_Sprint"};
				case (_distance > 3) : {"Dog_Run"};
				default {"Dog_Walk"};
			};
			if (_anim != _moveanim) then {
				_i = _i + 1;
				if (_i > 30) then {
					_i = 0;
					_EODD switchmove _moveanim;
				};
			};
			sleep 0.005;
		} else {
			if (random 1 > 0.5) then {
				_EODD switchMove "Dog_StopV1";
			} else {
				_EODD switchMove "Dog_StopV2";
			};
			sleep 2;
			_EODD switchMove "Dog_Stop";
		};
	} else {
		if (_anim != "Dog_Siting") then {
			_EODD switchmove "Dog_Sit1";
			_EODD switchmove "Dog_Siting";
		};
		sleep 3;
	};
};

_EODD removeaction _action;