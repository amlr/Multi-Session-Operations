/* (C)Rommel Von Richtofen // http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#define DELAY 1
#define DIFF_XY 10
#define DIFF_Z 5
#define DIFF_ZM 20
#define HELO_ALLOWSPEED 20
#define HELO_MAXSPEED 300
#define HELO_MAXBANK 0.8
#define CLASSES ["Tank", "Car", "Ship"];

#define ATTACH_FILEPATH "functions\f_attachToHelo.sqf"

if (typeName _this != "OBJECT") exitwith {};

_this addeventhandler ["GetIn", {_this spawn {
	private ["_helo", "_unit"];
	_helo = _this select 0;
	_unit = _this select 2;
	if ((_this select 1) != "driver") exitwith {};
	if ((_this select 2) != player) exitwith {};
	private ["_pos1", "_actionVeh"];
	_actionVeh = objNull;
	RMM_airLift_action = 0;
	RMM_airLift_attached = false;
	RMM_airLift_attached_vehicle = objnull;
	
	while {_unit == driver _helo} do {
		if !(alive _helo) exitwith {};
		if !(alive _unit) exitwith {};
		if !(RMM_airLift_attached) then {
			if (speed _helo < HELO_ALLOWSPEED) then {
				_pos1 = getposASL _helo;
				private "_veh";
				_veh = [_pos1, vehicles - [_helo]] call CBA_fnc_getNearest;
				if (_veh != _actionVeh) then {
					_bool = false;
					{
						if(_veh isKindOf _x)exitwith{_bool=true};
					} foreach CLASSES;
					if !(_bool) exitwith {};
					private ["_pos2", "_diffXY", "_diffZ"];
					_pos2 = getposASL _veh;
					_diffXY = abs((_pos1 select 0) - (_pos2 select 0)) + abs((_pos1 select 1) - (_pos2 select 1));
					_diffZ = abs((_pos1 select 2) - (_pos2 select 2));
					if (_diffXY < DIFF_XY and _diffZ > DIFF_Z and _diffZ < DIFF_ZM) then {
						_helo removeaction RMM_airLift_action;
						RMM_airLift_action = _helo addAction [format["Attach %1", typeof _veh],ATTACH_FILEPATH, _veh, 0, false, true];
						_actionVeh = _veh;
					};
				} else {
					private ["_pos2", "_diffXY", "_diffZ"];
					_pos2 = getposASL _actionVeh;
					_diffXY = abs((_pos1 select 0) - (_pos2 select 0)) + abs((_pos1 select 1) - (_pos2 select 1));
					_diffZ = abs((_pos1 select 2) - (_pos2 select 2));
					if (_diffXY > DIFF_XY or _diffZ < DIFF_Z or _diffZ > DIFF_ZM) then {
						_helo removeaction RMM_airLift_action;
						_actionVeh = objNull;
					};
				};
			};
		} else {
			private "_vec";
			_vec = vectorUp _helo;
			_vec set [2, (_vec select 2) - 1];
			_bool = false;
			{
				if(abs(_x)> HELO_MAXBANK)exitwith{_bool=true};
			} foreach _vec;
			if (_bool) then {
				detach RMM_airLift_attached_vehicle;
				RMM_airLift_attached = false;
				_helo removeAction RMM_airLift_action;
			};
		};
		sleep DELAY;
	};
	if !(isnil "RMM_airLift_action") then {
		_helo removeAction RMM_airLift_action;
	};
	if !(isnull RMM_airLift_attached_vehicle) then {
		detach RMM_airLift_attached_vehicle;
	};
	RMM_airLift_action = nil;
	RMM_airLift_attached = nil;
	RMM_airLift_attached_vehicle = nil;
}}];