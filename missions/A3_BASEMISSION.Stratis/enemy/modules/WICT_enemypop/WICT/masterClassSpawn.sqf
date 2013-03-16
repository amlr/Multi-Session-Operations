/*
__          __        _     _   _          _____             __ _ _      _     _______          _ 
\ \        / /       | |   | | (_)        / ____|           / _| (_)    | |   |__   __|        | |
 \ \  /\  / /__  _ __| | __| |  _ _ __   | |     ___  _ __ | |_| |_  ___| |_     | | ___   ___ | |
  \ \/  \/ / _ \| '__| |/ _` | | | '_ \  | |    / _ \| '_ \|  _| | |/ __| __|    | |/ _ \ / _ \| |
   \  /\  / (_) | |  | | (_| | | | | | | | |___| (_) | | | | | | | | (__| |_     | | (_) | (_) | |
    \/  \/ \___/|_|  |_|\__,_| |_|_| |_|  \_____\___/|_| |_|_| |_|_|\___|\__|    |_|\___/ \___/|_|

  ,---.                     ,---.  ,--.,--.,--.            ,--.,--.      
 /  O  \ ,--.--.,--,--,--. /  O  \ |  ||  ||  ,---.  ,---. |  |`--' ,---.
|  .-.  ||  .--'|        ||  .-.  ||  ||  ||  .-.  || .-. ||  |,--.| .--'
|  | |  ||  |   |  |  |  ||  | |  ||  ||  ||  | |  |' '-' '|  ||  |\ `--.
`--' `--'`--'   `--`--`--'`--' `--'`--'`--'`--' `--' `---' `--'`--' `---'
*/

if (isServer) then
{
	/* "Initialize and format" these arrays */
	_spawn_pool = [];
	_soldiers = [];
	_vehicles = [];
	_soldier_element = [];
	
	_side = _this select 0;
	_spawn_pool = _this select 1;
	_drive = _this select 2;
	_AI = _this select 3;
	
	
/* PART FOR THE BLUFOR */
	if (_side == "west") then
	{
		/* First we create a group for given side */
		_Wg= createGroup WEST;
		
		/* If there is a vehicle(s) in the array let's extract it and separate from soldiers */
		if (_drive != "none") then
		{
			_vehicles = [] + _spawn_pool select 0;
			/* Deleting nested array elements didn't work here, even with substitution for nested arrays!!!
			...don't ask me why!!! */
			for [{_s=1}, {_s < count _spawn_pool}, {_s=_s+1}] do
			{
				_soldier_element = [];
				call compile format ["_soldier_element = _spawn_pool select %1;",_s];
				_soldiers set [count _soldiers, _soldier_element];
			};
		}
		else
		{
			for [{_s=0}, {_s < count _spawn_pool}, {_s=_s+1}] do
			{
				_soldier_element = [];
				call compile format ["_soldier_element = _spawn_pool select %1;",_s];
				_soldiers set [count _soldiers, _soldier_element];
			};
		};
		
		//hint format ["Spawn pool: %1, vehicles: %2, soldiers: %3",_spawn_pool,_vehicles,_soldiers];
		
		/* Now for each memeber of a team create a soldier */
		_m = 0;
		{
			_m = _m + 1;
			call compile format ["_Unit%1 = _Wg createUnit [_x,[WICT_spwnPos select 0,WICT_spwnPos select 1,0],[],0,""FORM""];",_m];
		} forEach _soldiers;
		
		_Unit2 setunitrank "CORPORAL"; 
		_Unit1 setunitrank "SERGEANT"; 
		_Unit1=leader _Wg;

		_Unit1 setDir WICT_angleW;
		
		/* If there is vehicle(s)... */
		if (!(_drive == "none")) then
		{		
			_funcMountW = 
			{
				/* Let me explain:
					Now we spawn a vehicle, "probe" all available positions, select a crew, select vehicle type etc.
					...and we recalculate the crew for every new vehicle.
					File: spawnCrew.sqf
						Author: Joris-Jan van 't Land 
						Modification: ArmAIIholic */
				
				/* Some PRIVATE variables for this function!!! */
				private ["_vehicle","_crew","_seat_number"];
				_vehicle = _this select 0;
				_crew = _this select 1;
					
					_groundloc = WICT_spwnPos;
					_safepos = getMarkerPos WICT_wb;
					_groundloc = [_groundloc,0,20,20,0,45*(pi / 180),0,[],[_safepos]] call BIS_fnc_findSafePos;
					
					if (_drive == "ground") then {_vehicle = createVehicle [_vehicle, _groundloc, [],0,"FORM"];};
					if (_drive == "heli" || _drive == "winged") then {_vehicle = createVehicle [_vehicle, _groundloc, [],0,"FLY"];};
					_vehicle setDir WICT_angleW;
					_vehicle engineOn true;
					_Wg addVehicle _vehicle;
					
					_seat_number = (_vehicle emptyPositions "Commander") + (_vehicle emptyPositions "Driver") + (_vehicle emptyPositions "Gunner") + (_vehicle emptyPositions "Cargo");
					
					private ["_k","_crew_unit"];
					_k = 0;
					while {_k < _seat_number} do
					{
						_crew_unit = _crew select 0;
						if ((_vehicle emptyPositions "Commander") > 0) then {_crew_unit moveInCommander _vehicle; _crew = _crew - [_crew_unit];};
						if ((_vehicle emptyPositions "Driver") > 0) then {_crew_unit moveInDriver _vehicle; _crew = _crew - [_crew_unit];};
						if ((_vehicle emptyPositions "Gunner") > 0) then {_crew_unit moveInGunner _vehicle; _crew = _crew - [_crew_unit];};
						if ((_vehicle emptyPositions "Cargo") > 0) then {_crew_unit moveInCargo _vehicle; _crew = _crew - [_crew_unit];};
						_k = _k + 1;
					};
					
						private ["_type", "_entry","_crew_unit"];
						_type = typeOf _vehicle;
						_entry = configFile >> "CfgVehicles" >> _type;
						
						_turrets = [_entry >> "turrets"] call BIS_fnc_returnVehicleTurrets;
						
						_funcSpawnTurrets =
						{
							private ["_turrets", "_path"];
							_turrets = _this select 0;
							_path = _this select 1;

							private ["_j"];
							_j = 0;
							while {_j < (count _turrets)} do
							{
								private ["_turretIndex", "_thisTurret"];
								_turretIndex = _turrets select _j;
								_thisTurret = _path + [_turretIndex];
								
								if (isNull (_vehicle turretUnit _thisTurret)) then 
								{
									_crew_unit = _crew select 0; 
									_crew_unit moveInTurret [_vehicle, _thisTurret]; 
									_crew = _crew - [_crew_unit];
								};
								 
								[_turrets select (_j + 1), _thisTurret] call _funcSpawnTurrets;

								_j = _j + 2;
							};
						};
												
						[_turrets, []] call _funcSpawnTurrets;
					
					/* Only ground vehicles have initial speed */
					_vel = velocity _vehicle;
					_dir = direction _vehicle; 
					_dir = _dir - 180;
					if ((_dir > 360) || (_dir < 0)) then {_dir = abs (abs (_dir) - 360);};
					
					if (_drive == "ground") then
					{
						/* JTD direction normalization function	by Trexian; credits: OFPEC, DMarkwick, for math.
						The purpose of the JTD direction normalization function is to take a number and adapt it so that it is between 0 and 360.  
						Adapted by ArmAIIholic */						
						_speed = 12;
						_vehicle setVelocity [(_vel select 0)-(sin _dir*_speed),(_vel select 1)-(cos _dir*_speed),(_vel select 2)];
					};
					
					if (_drive == "winged") then
					{
						_speed = 60;
						_vehicle setVelocity [0-(sin _dir*_speed),0-(cos _dir*_speed),0];
					};
					
					if (_drive == "heli") then
					{
						_speed = 12;
						_vehicle setVelocity [0-(sin _dir*_speed),0-(cos _dir*_speed),0];
					};

						/* This is THE RETURN VALUE of the function - the rest of the crew!!! */
						_crew
					
			};
		
			/* Run function for each vehicle with a new crew, starting with whole crew = _Wg */
			_crew = units _Wg;
			{
				_crew = [_x,_crew] call _funcMountW;
			} forEach _vehicles;
		};
				
		/* Executes _AI script */
		call compile format ["_Unit1 doFSM [""enemy\modules\WICT_enemypop\WICT\AI\%1.fsm"", [0,0,0], _Unit1];",_AI];
		
		/* This line uses script that removes corpses after specified amount of time */
		_null = [_Wg,WICT_removeBody] execVM (WICT_PATH + "WICT\removeBody.sqf");
	};
	
/* PART FOR THE OPFOR */
	if (_side == "east") then
	{
		/* First we create a group for given side */
		_Eg= createGroup EAST;
		
		/* If there is a vehicle(s) in the array let's extract it and separate from soldiers */
		if (_drive != "none") then
		{
			_vehicles = [] + _spawn_pool select 0;
			/* Deleting nested array elements didn't work here, even with substitution for nested arrays!!!
			...don't ask me why!!! */
			for [{_s=1}, {_s < count _spawn_pool}, {_s=_s+1}] do
			{
				_soldier_element = [];
				call compile format ["_soldier_element = _spawn_pool select %1;",_s];
				_soldiers set [count _soldiers, _soldier_element];
			};
		}
		else
		{
			for [{_s=0}, {_s < count _spawn_pool}, {_s=_s+1}] do
			{
				_soldier_element = [];
				call compile format ["_soldier_element = _spawn_pool select %1;",_s];
				_soldiers set [count _soldiers, _soldier_element];
			};
		};
		
		/* Now for each memeber of a team create a soldier */
		_m = 0;
		{
			_m = _m + 1;
			call compile format ["_Unit%1 = _Eg createUnit [_x,[WICT_spwnPos select 0,WICT_spwnPos select 1,0],[],0,""FORM""];",_m];
		} forEach _soldiers;
		
		_Unit2 setunitrank "CORPORAL"; 
		_Unit1 setunitrank "SERGEANT"; 
		_Unit1=leader _Eg;

		_Unit1 setDir WICT_angleE;
		
		/* If there is vehicle(s)... */
		if (!(_drive == "none")) then
		{		
			_funcMountE = 
			{
				/* Let me explain:
					Now we spawn a vehicle, "probe" all available positions, select a crew, select vehicle type etc.
					...and we recalculate the crew for every new vehicle.
					File: spawnCrew.sqf
						Author: Joris-Jan van 't Land 
						Modification: ArmAIIholic */
				
				/* Some PRIVATE variables for this function!!! */
				private ["_vehicle","_crew","_seat_number"];
				_vehicle = _this select 0;
				_crew = _this select 1;
					
					_groundloc = WICT_spwnPos;
					_safepos = getMarkerPos WICT_eb;
					_groundloc = [_groundloc,0,20,20,0,45*(pi / 180),0,[],[_safepos]] call BIS_fnc_findSafePos;
					
					if (_drive == "ground") then {_vehicle = createVehicle [_vehicle, _groundloc, [],0,"FORM"];};
					if (_drive == "winged" || _drive == "heli") then {_vehicle = createVehicle [_vehicle, _groundloc, [],0,"FLY"];};
					_vehicle setDir WICT_angleE;
					_vehicle engineOn true;
					_Eg addVehicle _vehicle;
					
					_seat_number = (_vehicle emptyPositions "Commander") + (_vehicle emptyPositions "Driver") + (_vehicle emptyPositions "Gunner") + (_vehicle emptyPositions "Cargo");
					
					private ["_k","_crew_unit"];
					_k = 0;
					while {_k < _seat_number} do
					{
						_crew_unit = _crew select 0;
						if ((_vehicle emptyPositions "Commander") > 0) then {_crew_unit moveInCommander _vehicle; _crew = _crew - [_crew_unit];};
						if ((_vehicle emptyPositions "Driver") > 0) then {_crew_unit moveInDriver _vehicle; _crew = _crew - [_crew_unit];};
						if ((_vehicle emptyPositions "Gunner") > 0) then {_crew_unit moveInGunner _vehicle; _crew = _crew - [_crew_unit];};
						if ((_vehicle emptyPositions "Cargo") > 0) then {_crew_unit moveInCargo _vehicle; _crew = _crew - [_crew_unit];};
						_k = _k + 1;
					};
					
						private ["_type", "_entry","_crew_unit"];
						_type = typeOf _vehicle;
						_entry = configFile >> "CfgVehicles" >> _type;
						
						_turrets = [_entry >> "turrets"] call BIS_fnc_returnVehicleTurrets;
						
						_funcSpawnTurrets =
						{
							private ["_turrets", "_path"];
							_turrets = _this select 0;
							_path = _this select 1;

							private ["_j"];
							_j = 0;
							while {_j < (count _turrets)} do
							{
								private ["_turretIndex", "_thisTurret"];
								_turretIndex = _turrets select _j;
								_thisTurret = _path + [_turretIndex];
								
								if (isNull (_vehicle turretUnit _thisTurret)) then 
								{
									_crew_unit = _crew select 0; 
									_crew_unit moveInTurret [_vehicle, _thisTurret]; 
									_crew = _crew - [_crew_unit];
								};
								 
								[_turrets select (_j + 1), _thisTurret] call _funcSpawnTurrets;

								_j = _j + 2;
							};
						};
												
						[_turrets, []] call _funcSpawnTurrets;
					
					/* Only ground vehicles have initial speed */
					_vel = velocity _vehicle;
					_dir = direction _vehicle; 
					_dir = _dir - 180;
					if ((_dir > 360) || (_dir < 0)) then {_dir = abs (abs (_dir) - 360);};
					
					if (_drive == "ground") then
					{
						/* JTD direction normalization function	by Trexian; credits: OFPEC, DMarkwick, for math.
						The purpose of the JTD direction normalization function is to take a number and adapt it so that it is between 0 and 360.  
						Adapted by ArmAIIholic */						
						_speed = 12;
						_vehicle setVelocity [(_vel select 0)-(sin _dir*_speed),(_vel select 1)-(cos _dir*_speed),(_vel select 2)];
					};
					
					if (_drive == "winged") then
					{
						_speed = 60;
						_vehicle setVelocity [0-(sin _dir*_speed),0-(cos _dir*_speed),0];

					};
					
					if (_drive == "heli") then
					{
						_speed = 12;
						_vehicle setVelocity [0-(sin _dir*_speed),0-(cos _dir*_speed),0];
					};
					
						/* This is THE RETURN VALUE of the function - the rest of the crew!!! */
						_crew
			};
		
			/* Run function for each vehicle with a new crew, starting with whole crew = _Eg */
			_crew = units _Eg;
			{
				_crew = [_x,_crew] call _funcMountE;
			} forEach _vehicles;
		};
				
		/* Executes _AI script */
		call compile format ["_Unit1 doFSM [""enemy\modules\WICT_enemypop\WICT\AI\%1.fsm"", [0,0,0], _Unit1];",_AI];
		
		/* This line uses script that removes corpses after specified amount of time */
		_null = [_Eg,WICT_removeBody] execVM (WICT_PATH + "WICT\removeBody.sqf");
	};
	
	sleep .5;
	WICT_clutch = 1;
};