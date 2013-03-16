// zapat's modified supplyDrop script

if (isServer) then
{
	private ["_dropPos","_vehicle","_direction","_spawnDistance","_cargo","_altitude1","_altitude","_chuteType","_rDir","_spawnPos","_dropDest", "_HeliP","_Huey","_pilot","_vv","_dropPos","_chute","_box"];


	_dropPos = _this select 0;
	_vehicle = _this select 1;
	_direction = _this select 2;
	_spawnDistance = _this select 3; 
	_cargo = _this select 4;
	_side 		= if (count _this > 5) then {_this select 5} else {"west"};
	_crateFiller = if (count _this > 6) then {_this select 6} else {false};
	_game 		= if (count _this > 7) then {_this select 7} else {"arma"};
	_refill 	= if (count _this > 8) then {_this select 8} else {false};
	_amountw 	= if (count _this > 9) then {_this select 9} else {30};
	_amountm 	= if (count _this > 10) then {_this select 10} else {75};
	_amounte 	= if (count _this > 11) then {_this select 11} else {30};

	if !(_side == "west" or _side == "east" or _side == "all") then {hint "Universal Box Filler:\n Side setting must be West/East/All \n \n It is now changed to West \n Set it in the map editor"; _side = "west"};
	if !(typename _crateFiller == "BOOL") then {"Warining!" hintC "Universal Box Filler:\n This must be set to True/False \n \n It is now changed to False\n Set it in the map editor";_crateFiller = false};
	
	_altitude = 60;
	_altitude1 = 150; 


	_chuteType = "ParachuteMediumWest";
	_chutes = [];

	// ****** spawnpos
	if (_spawnDistance < 400) then {_spawnDistance = 400;};
	
	_rDir = _direction + 180;
	 if (_rDir > 360) then {_rDir = _rDir - 360};
	_spawnPos = [(_dropPos select 0)+(sin _direction)*_spawnDistance,(_dropPos select 1)+(cos _direction)*_spawnDistance, _altitude1];

	_dropDest = [(_dropPos select 0)+(sin _rDir)*250,(_dropPos select 1)+(cos _rDir)*250, _altitude]; // Destination, just beyond droppos.
	
	if (_side == "west") then {[[WEST,"HQ"],nil,rSIDECHAT,'SUPPLY DROP INBOUND!'] call RE;};
	if (_side == "east") then {[[EAST,"HQ"],nil,rSIDECHAT,'SUPPLY DROP INBOUND!'] call RE;};
	
	// ****** create plane
	_HeliP = creategroup west;
	_Huey = ([_spawnPos, _rDir, _vehicle, _HeliP] call BIS_fnc_spawnVehicle) select 0;

	_pilot = driver _Huey;

	_HeliP setCombatMode "blue";
	_HeliP setBehaviour "careless";

	// ****** Give orders to reduce altitude and wait for arrival at dropzone
	_pilot doMove _dropDest;
	_Huey flyInHeight _altitude;

	_vv = 0;
	while {((alive _Huey) and (_vv == 0))} do
	{
		 sleep random 1;
		 if ((_Huey distance _dropDest) < 333) then {_vv = 2};
	};

	// ****** release parachute:
	if ((alive _Huey) and (_vv == 2)) then
	{
		{
			if (alive _Huey) then
			{
				if (_x isKindOf "LandVehicle") then {_chuteType = "ParachuteBigWest";} else {_chuteType = "ParachuteMediumWest";};
				
				_dropPos = (getposATL _Huey); _setHeight = (_dropPos select 2) + 25; _dropPos set [2, _setHeight];
				_chute = _chuteType createvehicle _dropPos;
				_dropPos = (getposATL _Huey); _setHeight = (_dropPos select 2) - 15; _dropPos set [2, _setHeight];
				_box = _x createVehicle _dropPos;
				
				_dropPos = (getposATL _Huey); _setHeight = (_dropPos select 2) + 25; _dropPos set [2, _setHeight];
				_chute setpos _dropPos;
				
				_box attachTo [_chute, [0,0,0]];

				//****** using a different thread: Wait for parachute to land and then reset cargo position.
				[_chute, _box, _x,_side,_game,_refill,_amountw, _amountm, _amounte,_crateFiller] spawn 
				{
					private ["_chuteP","_realBox","_realBoxName","_visualBox","_hang","_timer","_visualBoxPos","_side","_game","_refill","_amountw","_amountm","_amounte","_crateFiller"];
					_chuteP = _this select 0;
					_visualBox = _this select 1;
					_realBoxName = _this select 2;
					_side = _this select 3;
					_game = _this select 4;
					_refill = _this select 5;
					_amountw = _this select 6;
					_amountm = _this select 7;
					_amounte = _this select 8;
					_crateFiller = _this select 9;
					
					sleep 5;
					//wait for the chute to collapse OR for two minutes
					_timer = 0;
					_hang = false;

					while{(getPosATL _visualBox) select 2 > 2} do
					{
						sleep 0.5;
						_timer = _timer + 1;

						if (_timer > 240) exitWith {_hang = true;}
					};

					//all ok, delete eyecandy box, and create a real one, which is not closed by a bug
					if (!_hang) then
					{
						_visualBoxPos = getPos _visualBox;

						deleteVehicle _visualBox;

						_realBox = _realBoxName createVehicle [_visualBoxPos select 0,_visualBoxPos select 1,0];
						_realBox setDir getDir _visualBox;
						_realBox setpos [_visualBoxPos select 0, _visualBoxPos select 1, 0];
						
						if (_crateFiller) then {null = [_realBox,_side,_game,_refill,_amountw, _amountm, _amounte] execVM (WICT_PATH + "WICT\support\crateFiller.sqf")};

						"SmokeShellYellow" createVehicle (_visualBoxPos);
					}
					else //chute is caught somewhere, delete it if player is away.
					{
						waitUntil {player distance _visualBox > 500};
						deleteVehicle _visualBox;
						deleteVehicle _chuteP;
					};
				};//end of spawn

				sleep 0.2;
			};
		} foreach _cargo;
	};
	
	if (_side == "west") then {[[WEST,"HQ"],nil,rSIDECHAT,'SUPPLY DROPPED!'] call RE;};
	if (_side == "east") then {[[EAST,"HQ"],nil,rSIDECHAT,'SUPPLY DROPPED!'] call RE;};
	
	if (alive _Huey) then
	{
		//****** order the plane to climb and continue straight
		_dropDest = [(_dropPos select 0)+(sin _rDir)*950,(_dropPos select 1)+(cos _rDir)*950, _altitude1];
		_pilot doMove _dropDest;
		sleep 1;
		_Huey flyInHeight _altitude1;
	};
			
	// Wait for plane to go away or crash.
	_vv = 0;
	while {(_vv == 0)} do {
		 sleep random 1;
		 if (not alive _Huey || (_Huey distance _dropDest) > 850) then {_vv = 2};
	};
			
	if (_vv == 2) then 
	{
		{deleteVehicle _x;}forEach units _HeliP;
		sleep 0.5;
		deleteVehicle _Huey;
		deleteGroup _HeliP;
		if (_side == "west") then {[[WEST,"HQ"],nil,rSIDECHAT,'SUPPLY DROP RTB!'] call RE;};
		if (_side == "east") then {[[EAST,"HQ"],nil,rSIDECHAT,'SUPPLY DROP RTB!'] call RE;};
	};

};