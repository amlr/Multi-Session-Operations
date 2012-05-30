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

if (!isDedicated) then
{		
	private ["_tsk_title","_tsk_status","_tskNum"];
	
	_tsk_title = _this select 0;;
	_tskNum = _this select 1;
	
	waitUntil {!isnil "task_report"};
	waitUntil {((task_report select 0) == _tsk_title)};
	
	_tsk_status = task_report select 1;
	
	if ((_tsk_status != "s") and (_tsk_status != "f") and (_tsk_status != "c")) then {_tsk_status = "c"};
	
	if (_tsk_status == "s") then 
	{
		call compile format ["tskObj%1 setTaskState ""SUCCEEDED""; [tskObj%1] execVM ""enemy\modules\WICT_enemypop\WICT\sandbox\fTaskHint.sqf"");",_tskNum];
		{
			if ((_x select 0) == _tsk_title) then {_x set [1,"s"];};
		} forEach WICT_tasks_list;
	};
	if (_tsk_status == "f") then 
	{
		call compile format ["tskObj%1 setTaskState ""FAILED""; [tskObj%1] execVM ""enemy\modules\WICT_enemypop\WICT\sandbox\fTaskHint.sqf"";",_tskNum];
		{
			if ((_x select 0) == _tsk_title) then {_x set [1,"f"];};
		} forEach WICT_tasks_list;
	};
	if (_tsk_status == "c") then 
	{
		call compile format ["tskObj%1 setTaskState ""CANCELED""; [tskObj%1] execVM ""enemy\modules\WICT_enemypop\WICT\sandbox\fTaskHint.sqf"";",_tskNum];
		{
			if ((_x select 0) == _tsk_title) then {_x set [1,"c"];};
		} forEach WICT_tasks_list;
	};
	
	//diag_log WICT_tasks_list;
	publicVariable "WICT_tasks_list";
	
	sleep 20;
	_null = call compile format ["player removeSimpleTask tskObj%1;",_tskNum];
};