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
	while {WICT_state == "start"} do
	{	
		/* Clear memory if there are too many groups */
		if ((count allGroups) > WICT_numAIg) then
		{
			_null = [] spawn {wait_clearing = [] execVM (WICT_PATH + "WICT\clearMemory.sqf")};
			waitUntil {scriptDone wait_clearing};
		};

		/* Find the average position of the group - "center of the mass" */
		if ((alive player) and (!(isNull player))) then {WICT_playerPos = position player;} else {WICT_playerPos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");};
		
		private ["_posA","_posB","_other_x","_other_y","_other_z","_posOther"];
		_posA = 0;
		_posB = 0;
		
		if (!isMultiplayer) then
		{
			_switchable = switchableUnits;
			_n = count _switchable;
			
			if (_n > 0) then
			{
				{
					if ((alive _x) and (!(isNull _x))) then
					{
						_posOther = position _x;
						_other_x = (_posOther) select 0;
						_other_y = (_posOther) select 1;
						
						_posA = _posA + _other_x;
						_posB = _posB + _other_y;
					};
				} foreach _switchable;
			};
			
			_posA = _posA/(_n);
			_posB = _posB/(_n);
			
			WICT_playerPos set [0, _posA];
			WICT_playerPos set [1, _posB];
		}
		else
		{
			_playable = playableUnits;
			_n = count _playable;
			if (_n > 0) then
			{
				{
					if ((alive _x) and (!(isNull _x))) then
					{
						_posOther = position _x;
						_other_x = (_posOther) select 0;
						_other_y = (_posOther) select 1;
						
						_posA = _posA + _other_x;
						_posB = _posB + _other_y;
					};
				} foreach _playable;
				
				_posA = _posA/(_n);
				_posB = _posB/(_n);
				
				WICT_playerPos set [0, _posA];
				WICT_playerPos set [1, _posB];
			} else {
				WICT_state = "stop";
			};
		};
				
		WICT_time = WICT_time + (round (random WICT_timeRand));

		WICT_dice = round(random 100);

		/* Find nearest base >>> */
		
		_temp_dist1 = WICT_scandist;

		waitUntil {(WICT_flag select 3) == 0};
		
		WICT_wb = "none";
		{
			_temp_pos = getMarkerPos(_x);
			_temp_dist = WICT_playerPos distance _temp_pos;
			if ((_temp_dist < _temp_dist1) and (WICT_sd < _temp_dist)) then 
			{
				WICT_wb = _x; 
				_temp_dist1 = _temp_dist
			};
		} forEach WICT_wbl;

		_temp_dist1 = WICT_scandist;

		WICT_eb = "none";
		{
			_temp_pos = getMarkerPos(_x);
			_temp_dist = WICT_playerPos distance _temp_pos;
			if ((_temp_dist < _temp_dist1) and (WICT_sd < _temp_dist)) then 
			{
				WICT_eb = _x;
				_temp_dist1 = _temp_dist
			};
		} forEach WICT_ebl;

		_temp_dist1 = WICT_scandist + 500;

		WICT_nb = "none";
		{
			_temp_pos = getMarkerPos(_x);
			_temp_dist = WICT_playerPos distance _temp_pos;
			if ((_temp_dist < _temp_dist1) and (WICT_sd < _temp_dist)) then 
			{
				WICT_nb = _x;
				_temp_dist1 = _temp_dist
			};
		} forEach WICT_nbl;
		
		
		if (WICT_debug == "yes") then 
		{
			_null =	deleteMarker "battlefront";
			_marker = createMarker ["battlefront", WICT_playerPos];
			"battlefront" setMarkerColor "ColorOrange";
			"battlefront" setMarkerSize [WICT_sd,WICT_sd];
			"battlefront" setMarkerShape "ELLIPSE";
			"battlefront" setMarkerBrush "SOLID";
			"battlefront" setMarkerAlpha 0.3;
		};
		
		WICT_clutch = 0;

		execFSM (WICT_PATH + "WICT\exeSpawnW.fsm");

		waitUntil {WICT_clutch == 1};

		WICT_clutch = 0;

		execFSM (WICT_PATH + "WICT\exeSpawnE.fsm");

		waitUntil {WICT_clutch == 1};

		if (WICT_debug == "yes") then {diag_log format ["Number of AI groups: %4, west base: %1, east base: %2, neutral base: %3",WICT_wb,WICT_eb,WICT_nb,(count allGroups)];};

		sleep WICT_time;
	};
};