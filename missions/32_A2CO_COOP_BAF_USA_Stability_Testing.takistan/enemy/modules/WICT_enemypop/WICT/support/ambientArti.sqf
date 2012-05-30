waituntil {!isnil "bis_fnc_init"};
waituntil {BIS_MPF_InitDone};

// random mortar fire function by Igneous01, modified by ArmAIIholic
//[nil,nil,rEXECVM,"WICT\sandbox\sandbox_exe.sqf","WICT\support\","ambientArti",5,"ARTY_Sh_81_HE", "mort1", 100, 150, 17, 5] call RE;
// where, "ARTY_Sh_81_HE" is the classname of the shell, "mort1" is the name of a marker, and the rest are in order, x y radius of where the shells will go off, max random time to fire, number of shells

if (isServer) then 
{
	private ["_ammo", "_marker", "_xcoord", "_ycoord", "_timer", "_fire","_i","_addition"];
	_ammo = _this select 0;
	_marker = _this select 1;
	_xcoord = _this select 2;
	_ycoord = _this select 3;
	_timer = _this select 4;
	_rounds = _this select 5;
	_i = 0;
	while {_i < _rounds} do 
	{
		_addition = round (random 4);
		if ((_addition == 0) or (_addition == 4)) then { _firerun = _ammo createvehicle [(getmarkerpos _marker select 0) + random _xcoord, (getmarkerpos _marker select 1) + random _ycoord, getmarkerpos _marker select 2]; };
		if (_addition == 1) then { _firerun = _ammo createvehicle [(getmarkerpos _marker select 0) - random _xcoord, (getmarkerpos _marker select 1) + random _ycoord, getmarkerpos _marker select 2]; };
		if (_addition == 2) then { _firerun = _ammo createvehicle [(getmarkerpos _marker select 0) + random _xcoord, (getmarkerpos _marker select 1) - random _ycoord, getmarkerpos _marker select 2]; };
		if (_addition == 3) then { _firerun = _ammo createvehicle [(getmarkerpos _marker select 0) - random _xcoord, (getmarkerpos _marker select 1) - random _ycoord, getmarkerpos _marker select 2]; };
		
		_firerun spawn 
		{
			_firerun = _this;
			_soundsource = "HeliHEmpty" createVehicle position _firerun;
			WaitUntil{(position _firerun select 2)<30};
			_soundsource setPos position _firerun;
			_soundsource setVehicleInit format["this say 'bon_Shell_In_v0%1'",[1,2,3,4,5,6,7] select round random 6];
			processInitCommands;
			sleep 5;
			deleteVehicle _soundsource;
		};
		_i = _i + 1;
		sleep (random _timer);
	};
};