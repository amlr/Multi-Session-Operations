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
	private ["_allGroups","_grp","_units","_dead","_side","_waypoints","_vehicles","_skip","_skipgrp","_stay"];

	_stay = "yes";
	
	

	
	/* Will I stay here cleaning or will I continue spawning after one cycle of cleaning??? */
	while {((_stay == "yes") and (WICT_state == "start"))} do 
	{
		_allGroups = allGroups;
		
		if ((count allGroups) <= WICT_jam) then {_stay = "no";};
		
		sleep 5;
		
		if (WICT_debug == "yes") then {hint format ["Clearing memory: number of groups is: %1 and the limit is: %2",count allGroups,WICT_numAIg];};

		
		
		
		/* Let's clear some wrecks */
		_vehicles = vehicles;
		
		if (count _vehicles > 0 ) then
		{
			{
				_check_vehicle = _x;
				
						if (not alive _check_vehicle) then	{	
							deleteVehicle _check_vehicle;
						};
						
						
			} foreach _vehicles;
		};


		
		
		
		
		/* Let's clear groups */
		{
			_skip = "no";
			
			_grp = _x;
			
			_units = units _grp;
			
			/* ...dead ones first... */
			if ({alive _x} count units _grp == 0) then 
			{
				_waypoints = waypoints _grp;
				{deleteWaypoint _x} foreach _waypoints;
				{deletevehicle _x} foreach _units;
				waitUntil {count units _grp == 0};
				sleep .5;
				deleteGroup _grp;
			}
			else
			{
				/* Not dead? Ok... */
				/* Is there a reason to skip some group when cleaning? */
				
				/* ...yes if player is in the group... */
				{if ((alive _x) and (_x == player)) then {_skip = "yes"}} foreach _units;
				
				/* ...yes if soldier has a name... */
				{
					if (alive _x) then
					{
						if (not(isNil (vehicleVarName vehicle _x))) then {_skip = "yes"}
					}
					else
					{
						/* ...remove far, far away nameless units... */
						if (((position _x) distance WICT_playerPos) > WICT_removeMan) then {deleteVehicle _x;};
					};
				} foreach _units;
				
				
				
				/* If I am not skipping and group is alive, let's move them */
				if (_skip == "no") then 
				{	
					/* ...heal soldiers that cannot stand... */
					{if ((alive _x) and (not canStand _x)) then {_x setDamage 0}} foreach _units;
				
					_side = side _grp;
					

					{if (_x in playableunits) then {_skipgrp = true} else {_skipgrp = false};} foreach units _grp;
					
					if ((_side == west) and (!(WICT_eb == "none")) and (!(_skipgrp))) then
					{	
						_waypoints = waypoints _grp;
						{deleteWaypoint _x} foreach _waypoints;
						_wp1 = _grp addWaypoint [(getMarkerPos WICT_eb), 30];
						_wp1 setWaypointType "MOVE";
						[_grp, 1] setWaypointSpeed "NORMAL";
						[_grp, 1] setWaypointBehaviour "AWARE";
						[_grp, 1] setWaypointCombatMode "YELLOW";
						[_grp, 1] setWaypointCompletionRadius 50;
						_grp setCurrentWaypoint [_grp, 1];
						[_grp, 1] setWaypointVisible false;
					};
					
					if ((_side == east) and (!(WICT_wb == "none"))) then
					{
						_waypoints = waypoints _grp;
						{deleteWaypoint _x} foreach _waypoints;
						_wp1 = _grp addWaypoint [(getMarkerPos WICT_wb), 30];
						_wp1 setWaypointType "MOVE";
						[_grp, 1] setWaypointSpeed "NORMAL";
						[_grp, 1] setWaypointBehaviour "AWARE";
						[_grp, 1] setWaypointCombatMode "YELLOW";
						[_grp, 1] setWaypointCompletionRadius 50;
						_grp setCurrentWaypoint [_grp, 1];
					};
					
					if (_side == resistance) then
					{
						_waypoints = waypoints _grp;
						{deleteWaypoint _x} foreach _waypoints;
						_wp1 = _grp addWaypoint [WICT_playerPos, 50];
						_wp1 setWaypointType "MOVE";
						[_grp, 1] setWaypointSpeed "NORMAL";
						[_grp, 1] setWaypointBehaviour "AWARE";
						[_grp, 1] setWaypointCombatMode "YELLOW";
						[_grp, 1] setWaypointCompletionRadius 70;
						_grp setCurrentWaypoint [_grp, 1];
					};
					
					
					
				};	
			};
		} foreach _allGroups;
		
		
		
		
		sleep 5;
	};
};