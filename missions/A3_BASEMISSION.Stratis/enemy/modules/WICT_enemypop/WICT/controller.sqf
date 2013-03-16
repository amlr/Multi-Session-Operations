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

waitUntil {WICT_init};

if (isServer) then
{
	while {true} do
	{
		private ["_n","_playable"];
		
		/* Checks the state of the WICT_state variable - whether it is START or STOP */
		_currentState = WICT_state;
		
		// Check to see if there are playable units
		_playable = playableUnits;
		_n = count _playable;
		
		if (_n == 0) then 
		{
			WICT_state = "stop";
		} else {
			WICT_state = "start";
		};
		
		/* It waits for a change in the state */
		waitUntil {!(WICT_state == _currentState)};
		
		if (WICT_state == "start") then
		{
			diag_log "Starting WICT Controller";
			_null = [] spawn {controllerH = [] execVM (WICT_PATH + "WICT\corescript.sqf")};
			sleep 1;
		};
		
		if (WICT_state == "stop") then
		{
			diag_log "Stopping WICT Controller";
			_null = terminate controllerH;
			sleep 1;
		};
	};
};