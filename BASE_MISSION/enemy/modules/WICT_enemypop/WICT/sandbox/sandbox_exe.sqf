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

_exePath = _this select 0;
_exeScript = _this select 1;

if (isServer) then
{
	if (_exeScript != "taskCreator") then
	{
		_doExecute = true;
		//If there is no such script ID (which is the name of the script) then doExecute
		{
			if (_x == _exeScript) then {_doExecute = false;};
		} forEach WICT_exe_list;
		
		if (_doExecute) then
		{
			WICT_exe_list set [count WICT_exe_list, _exeScript];
			
			//Copy/paste all parameters you specified
			if (count _this > 3) then 
			{
				_parameters = "_this select 3";
				for "_i" from 4 to (count _this - 1) do
				{
					_parameters = composeText [_parameters,",_this select ",str(_i)];
				};
				call compile format ["[nil,nil,rEXECVM,""%1%2.sqf"",%3] call RE;",_exePath,_exeScript,_parameters];
			}
			else
			{
				call compile format ["[nil,nil,rEXECVM,""%1%2.sqf""] call RE;",_exePath,_exeScript];
			};
		};
		
		/* Removes ID from the list after sleep time */
		_restart = if (count _this > 2) then {_this select 2;} else {0}; //hint format ["%1",(typeName _restart)];
		if !(typeName _restart == "SCALAR") then {_restart = 0;};
		if (_restart > 0) then 
		{
			sleep _restart;
			WICT_exe_list = WICT_exe_list - [_exeScript];
		};
	}
	else
	{
		//If there is no such task ID (which is the task title) then doExecute
		_doExecute = true;
		private ["_tsk_title","_tsk_entry"];
		_tsk_title = _this select 5;
		_tsk_entry = [];

		{
			if ((_x select 0) == _tsk_title) then {_doExecute = false;};
		} forEach WICT_tasks_list;
		
		if (_doExecute) then
		{
			_tsk_entry = [_tsk_title,"a"];
			WICT_tasks_list set [count WICT_tasks_list, _tsk_entry];
			
			//diag_log WICT_tasks_list;
			publicVariable "WICT_tasks_list";
			
			//Copy/paste all parameters you specified
			_parameters = "_this select 2";
				for "_i" from 3 to (count _this - 1) do
				{
					_parameters = composeText [_parameters,",_this select ",str(_i)];
				};
				call compile format ["[nil,nil,rEXECVM,""%1%2.sqf"",%3] call RE;",_exePath,_exeScript,_parameters];
		};
	};
};

// This script can be run ONLY ON SERVER for SPECIFIC SCRIPT ID = ONLY ONCE AND ONLY ON SERVER!!!
// Exception is script called taskCreator and also all cases when you use optional parameter "restart".
// However, it runs the specified script on all clients!!!