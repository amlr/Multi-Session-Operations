// zapat's and ArmAIIholic's modified troop reinforcements script

waitUntil {!(isnil "WICT_reinforce_check")};

if (!isMultiplayer) then
{
	private ["_dropPos","_vehicle","_direction","_spawnDistance","_cargo","_altitude1","_altitude","_rDir","_spawnPos","_dropDest","_vehicle","_pilot","_vv","_HeliCrew","_Huey"];
		
	_dropPos = _this select 0;
	_vehicle = _this select 1; //diag_log _vehicle;
	_direction = _this select 2;
	_spawnDistance = _this select 3; 
	_cargo = _this select 4;
	_support = if (count _this > 5) then {_this select 5;} else {true};
	_eject = if (count _this > 6) then {_this select 6;} else {false};
	
	/* Player must exist and there is a limit to number of units -- only one script is running at the time*/

	if ((!(isNull player)) and (count units group player) < 3 and (WICT_reinforce_check == "none")) then
	{	
		[[(side player),"HQ"],nil,rSIDECHAT,'REINFORCEMENTS ARE COMING!'] call RE;
		WICT_reinforce_check = "going";
		
		_altitude = 60;
		_altitude1 = 150; 
		
		// ****** spawnpos
		_rDir = _direction + 180;
		 if (_rDir > 360) then {_rDir = _rDir - 360};
		_spawnPos = [(_dropPos select 0)+(sin _direction)*_spawnDistance,(_dropPos select 1)+(cos _direction)*_spawnDistance, _altitude1];

		_dropDest = [(_dropPos select 0)+(sin _rDir)*250,(_dropPos select 1)+(cos _rDir)*250, _altitude]; // Destination, just beyond droppos.
		
		_HeliCrew = creategroup west;
		_Huey = ([_spawnPos, _rDir, _vehicle, _HeliCrew] call BIS_fnc_spawnVehicle) select 0;
		
		_Huey flyInHeight _altitude;
			
		// ****** CREATE CARGO UNITS
		_Wg1 = createGroup WEST;
		{
			_Unit = _Wg1 createUnit [_x, [_spawnPos select 0,_spawnPos select 1,0], [], 0,"FORM"];
			_Unit moveInCargo _Huey;
		} forEach _cargo;

			_HeliCrew addVehicle _Huey;
			
			_null = [_HeliCrew,60] execVM (WICT_PATH + "WICT\removeBody.sqf");
			_null = [_Wg1,60] execVM (WICT_PATH + "WICT\removeBody.sqf");
			
			_pilot = driver _Huey;
			_pilot disableAI "TARGET";
			_pilot disableAI "AUTOTARGET";  
			_HeliCrew setCombatMode "red";
			_HeliCrew setBehaviour "combat";
			
			_pilot doMove _dropDest;
			
			sleep 5;
			
			if (_eject) then {_approachDist = 250;} else {_approachDist = 100;};
			
			while {(player distance leader _Wg1 > _approachDist) and ({alive _x} count units _Wg1 > 0)} do
			{	
				_wplayer = _HeliCrew addwaypoint[_dropDest,10];
				[_HeliCrew,1] setWaypointBehaviour "AWARE";
				[_HeliCrew,1] setWaypointSpeed "FULL";
				[_HeliCrew,1] setWaypointType "MOVE";
				[_HeliCrew,1] setWaypointCombatMode "GREEN";
				[_HeliCrew,1] setWaypointCompletionRadius 50;
				_HeliCrew setCurrentWaypoint [_HeliCrew,1];
				
				sleep random 3;
			};
			
			sleep random 5;
			
			_Huey flyInHeight 100;
			
			/* Last known position */
				_wplayer = _HeliCrew addwaypoint[_dropDest,0];
				[_HeliCrew,1] setWaypointBehaviour "AWARE";
				[_HeliCrew,1] setWaypointSpeed "FULL";
				[_HeliCrew,1] setWaypointType "MOVE";
				[_HeliCrew,1] setWaypointCombatMode "GREEN";
				[_HeliCrew,1] setWaypointCompletionRadius 0;
				_HeliCrew setCurrentWaypoint [_HeliCrew,1];
				
			
			if ({alive _x} count units _Wg1 > 0) then
			{	
				/* Reset movement */
				_wplayer = _HeliCrew addwaypoint[_dropDest,0];
				[_HeliCrew,1] setWaypointBehaviour "AWARE";
				[_HeliCrew,1] setWaypointSpeed "FULL";
				[_HeliCrew,1] setWaypointType "MOVE";
				[_HeliCrew,1] setWaypointCombatMode "RED";
				[_HeliCrew,1] setWaypointCompletionRadius 10;
				_HeliCrew setCurrentWaypoint [_HeliCrew,1];
				
				/* Climb up */
				_Huey flyInHeight 150;
				
				if (_eject) then 
				{
					sleep 7.5;
					{
						 unassignVehicle (_x);

						 (_x) action ["EJECT", vehicle _x];

						  sleep 0.02;
					} foreach units _Wg1;
					
					{addSwitchableUnit _x;} forEach units _Wg1;
					{[_x] joinSilent (group player);} forEach units _Wg1;
					_null = deleteGroup _Wg1;
				}
				else
				{
					{addSwitchableUnit _x;} forEach units _Wg1;
					{[_x] joinSilent (group player);} forEach units _Wg1;
					_null = deleteGroup _Wg1;
					
					titleText ["NEW UNITS HAVE ARRIVED. They have to TOUCH & GO (4>1) or HALO (6>2 altitude 150m)!!!", "PLAIN"]; titleFadeOut 50;
					waitUntil {(_Huey emptyPositions "Cargo") >= (count _cargo)};
				};
				WICT_reinforce_check = "none";
			
				/* Helicopter will protect you */
				if (_support) then
				{
					if ({alive _x} count units _HeliCrew > 0) then
					{
						_pilot enableAI "TARGET";
						_pilot enableAI "AUTOTARGET"; 
						_Huey flyInHeight 35;
						_wplayer = _HeliCrew addwaypoint[_dropDest,10];
						[_HeliCrew,1] setWaypointBehaviour "AWARE";
						[_HeliCrew,1] setWaypointSpeed "NORMAL";
						[_HeliCrew,1] setWaypointType "MOVE";
						[_HeliCrew,1] setWaypointCombatMode "RED";
						[_HeliCrew,1] setWaypointCompletionRadius 5;
						_HeliCrew setCurrentWaypoint [_HeliCrew,1];
						
						[[(side player),"HQ"],nil,rSIDECHAT,'Providing immediate air support!'] call RE;
					};
				
					sleep 45;
					
					if ({alive _x} count units _HeliCrew > 0) then
					{
						[[(side player),"HQ"],nil,rSIDECHAT,'Bird is OM!'] call RE;
						_Huey flyInHeight 65;
						_wplayer = _HeliCrew addwaypoint[_dropDest,150];
						[_HeliCrew,1] setWaypointBehaviour "AWARE";
						[_HeliCrew,1] setWaypointSpeed "NORMAL";
						[_HeliCrew,1] setWaypointType "SAD";
						[_HeliCrew,1] setWaypointCombatMode "RED";
						[_HeliCrew,1] setWaypointCompletionRadius 50;
						_HeliCrew setCurrentWaypoint [_HeliCrew,1];
					};
				}
				else
				{
					//RTB
					sleep 2; 
					[[(side player),"HQ"],nil,rSIDECHAT,'We are RTB!'] call RE;
					//****** order the plane to climb and continue straight
					_dropDest = [(_dropPos select 0)+(sin _rDir)*950,(_dropPos select 1)+(cos _rDir)*950, _altitude1];
					_pilot doMove _dropDest;
					sleep 1;
					_Huey flyInHeight _altitude1;
					
					_vv = 0;
					while {(_vv == 0)} do {
						 sleep random 2;
						 if (((not alive _Huey) || (_Huey distance player) > 600)) then {_vv = 2};
					};

					if (_vv == 2) then 
					{
						sleep 5;
						{deleteVehicle _x;}forEach units _HeliCrew; 
						deleteVehicle _Huey;
						deleteGroup _HeliCrew;
					};
				};
			};		
	}
	else
	{
		[[(side player),"HQ"],nil,rSIDECHAT,'Reinforcements unavailable at this moment!!!'] call RE;
	};
};