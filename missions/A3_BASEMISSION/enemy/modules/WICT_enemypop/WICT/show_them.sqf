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

Script by zapat that draws icons for units in Debug mode. It is fun to watch WICT working on the map... [zapat]

Soldiers are represented with dot, vehicles with square and air units with triangle.
*/

/* Waiting for debug in order to run on the server properly */
waitUntil {!(isnil "WICT_debug")};

if ((isServer) and (WICT_debug == "yes")) then
{	
	
	/* Waits here for the first run of WICT, no need to run earlier */
	waitUntil {WICT_state == "start"};
	
	/* Sleeps for the first round of spawning */
	sleep 2.2 + WICT_time;
	
	while {true} do
	{
		sleep 0.8;
		
		_targets = + position player nearEntities 10000; 
		sleep 0.2;
			
		if (count _targets>0) then
		{    
			//create markers
			_n = 0;
			{
				if (_x isKindof "LandVehicle" || _x isKindof "Air" || _x isKindof "CAManBase") then
				{                        
					//_err = [str(_x), "p3d"] call CBA_fnc_find;
					//if (_err == -1) then
					//{
						_m = format["u%1",_n];
						createMarker[_m,position _x];
						_n = _n+1;
						
						_m setMarkerShape "ICON";
						
						if (_x isKindof "CAManBase") then {_m setMarkerType "mil_dot";};
						if (_x isKindof "LandVehicle") then {_m setMarkerType "mil_box";};                    
						if (_x isKindof "Air") then {_m setMarkerType "mil_triangle";};
						
						if (side _x == east) then {_m setMarkerColor "ColorRed";};
						if (side _x == west) then {_m setMarkerColor "ColorBlue";};
						
						if (_x in units group player) then {_m setMarkerColor "ColorYellow";};
						if (_x == player) then {_m setMarkerColor "ColorGreen";};
					//};
				};
			}foreach _targets;
		};
		
		sleep 2;
		
		//delete markers
		_n = 0;
		while {getmarkertype format["u%1",_n] != ""} do
		{
			deleteMarker format["u%1",_n];
			_n = _n + 1;
		};
		
	}; //endwhile
};	