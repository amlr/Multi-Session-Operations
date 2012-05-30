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

/* Necessary for proper start */
waituntil {!isnil "bis_fnc_init"};
waituntil {BIS_MPF_InitDone};
  
if (!isDedicated) then
{
	// make sure player object exists i.e. not dead
	waitUntil {!isNull player};
	waitUntil {player == player};

	_location = _this select 0; // this will be the location of the task (String - optional - default: "GPS unknown")
	_loc_marker = _this select 1; // this will be marker of that location (String - optional - default: "GPS unknown")
	_show_receive = _this select 2; // this will display mission date and time when task is given (optional)
	_task_title = _this select 3; // task title
	_task_body = _this select 4; // task message
	_task_assign = _this select 5; // assign this task uppon creation (yes or no, default no)
	_side = _this select 6; // gets the side
	
	if ((_side == "") or (_side == "all")) then {_side = str(side player)};
	
	if (_side == str(side player)) then
	{	
		if ((_task_title != "") and (_task_body != "")) then
		{
			if ((_show_receive == "") or ((_show_receive != "yes") and (_show_receive != "no"))) then {_show_receive = "no"};
			if ((_task_assign == "") or ((_task_assign != "yes") and (_task_assign != "no"))) then {_task_assign = "no"};
				
			//Impossible to have two exact the same task numbers :)
			_taskNumber1 = str(round(random 99)); _taskNumber2 = str(round(random 99)); _taskNumber3 = str(round(daytime)); _taskNumber4 = str(round(daytime + random 10));
			_taskNumber = composeText [_taskNumber1, _taskNumber2, _taskNumber3, _taskNumber4];
			
			call compile format ["tskObj%1 = player createSimpleTask [""%2""];",_taskNumber,_task_title];
			if ((_loc_marker != "") and ((getMarkerType _loc_marker) !="")) then {call compile format ["tskObj%1 setSimpleTaskDestination (getMarkerPos ""%2"");",_taskNumber,_loc_marker];};
			
			// Building up task text
			_task_text = "";
			
			if (_location != "") then {_task_text = composeText [_task_text,"Location : ",_location, "<br/>"];};
			
			if ((_loc_marker != "") and (_show_receive == "yes")) then
			{ 
				if ((getMarkerType _loc_marker) !="") then 
					{
					//thank you zapat for nearest settlements :)
					_city = (nearestLocations[(getMarkerPos _loc_marker), ["NameCity","NameVillage","NameCityCapital"],7000]) select 0;
					_cityPos = position _city;
					_cityName = text _city;
					_cityDirection = [getMarkerPos _loc_marker, _cityPos] call BIS_fnc_DirTo;			
					if (_cityDirection < 0) then {_cityDirection = 360 + _cityDirection};
					_cityDir = "";
					
					if ((_cityDirection >= 0) and (_cityDirection < 22.5)) then {_cityDir = "S"};
					if ((_cityDirection >= 22.5) and (_cityDirection < 67.5)) then {_cityDir = "SW"};			
					if ((_cityDirection >= 67.5) and (_cityDirection < 112.5)) then {_cityDir = "W"};
					if ((_cityDirection >= 112.5) and (_cityDirection < 157.5)) then {_cityDir = "NW"};
					if ((_cityDirection >= 157.5) and (_cityDirection < 202.5)) then {_cityDir = "N"};
					if ((_cityDirection >= 202.5) and (_cityDirection < 247.5)) then {_cityDir = "NE"};
					if ((_cityDirection >= 247.5) and (_cityDirection < 292.5)) then {_cityDir = "E"};
					if ((_cityDirection >= 292.5) and (_cityDirection < 337.5)) then {_cityDir = "SE"};
					if ((_cityDirection >= 337.5) and (_cityDirection < 360)) then {_cityDir = "S"};
					 
					_cityDistance = str((round((getMarkerPos _loc_marker) distance _cityPos)/1000));
					
					_task_text = composeText [_task_text,"<marker name='",_loc_marker,"'>GPS grid reference : ",(mapGridPosition getMarkerPos _loc_marker),"</marker>, ",_cityDistance," klicks ",_cityDir," from ",_cityName,".<br/><br/>"];
				};
			};
			
			if (_show_receive == "yes") then 
			{
				// Making realistic military report
				_DateStamp=Date;
				
				_task_text = composeText [_task_text,"Task has been received by "];
				
				_rank = rank player; _rank = [_rank] call KRON_StrLower;
				
				_name = name player;
				
				_task_text = composeText [_task_text,_rank," ",_name," at "];
			
				if ((_DateStamp select 3) < 10) then
				{
					_task_text = composeText [_task_text,"0",str(_DateStamp select 3)];
				}
				else
				{
					_task_text = composeText [_task_text,str(_DateStamp select 3)];
				};
				
				if ((_DateStamp select 4) < 10) then
				{
					_task_text = composeText [_task_text,"0",str(_DateStamp select 4),"Hr"," "];
				}
				else
				{
					_task_text = composeText [_task_text,str(_DateStamp select 4),"Hr"," "];
				};
				
				_city = (nearestLocations[(getPos player), ["NameCity","NameVillage","NameCityCapital"],7000]) select 0;
				_cityPos = position _city;
				_cityName = text _city;
				_cityDirection = [getPos player, _cityPos] call BIS_fnc_DirTo;			
				if (_cityDirection < 0) then {_cityDirection = 360 + _cityDirection};
				_cityDir = "";
				
				if ((_cityDirection >= 0) and (_cityDirection < 22.5)) then {_cityDir = "S"};
				if ((_cityDirection >= 22.5) and (_cityDirection < 67.5)) then {_cityDir = "SW"};			
				if ((_cityDirection >= 67.5) and (_cityDirection < 112.5)) then {_cityDir = "W"};
				if ((_cityDirection >= 112.5) and (_cityDirection < 157.5)) then {_cityDir = "NW"};
				if ((_cityDirection >= 157.5) and (_cityDirection < 202.5)) then {_cityDir = "N"};
				if ((_cityDirection >= 202.5) and (_cityDirection < 247.5)) then {_cityDir = "NE"};
				if ((_cityDirection >= 247.5) and (_cityDirection < 292.5)) then {_cityDir = "E"};
				if ((_cityDirection >= 292.5) and (_cityDirection < 337.5)) then {_cityDir = "SE"};
				if ((_cityDirection >= 337.5) and (_cityDirection < 360)) then {_cityDir = "S"};
							 
				_cityDistance = str((round((getPos player) distance _cityPos)/1000));
				
				_targetDistance = str((round((getPos player) distance (getMarkerPos _loc_marker))/1000));
				
				_targetDirection = [(getPos player), (getMarkerPos _loc_marker)] call BIS_fnc_DirTo;			
				if (_targetDirection < 0) then {_targetDirection = 360 + _targetDirection};
				_targetDir = "";
				
				if ((_targetDirection >= 0) and (_targetDirection < 22.5)) then {_targetDir = "S"};
				if ((_targetDirection >= 22.5) and (_targetDirection < 67.5)) then {_targetDir = "SW"};			
				if ((_targetDirection >= 67.5) and (_targetDirection < 112.5)) then {_targetDir = "W"};
				if ((_targetDirection >= 112.5) and (_targetDirection < 157.5)) then {_targetDir = "NW"};
				if ((_targetDirection >= 157.5) and (_targetDirection < 202.5)) then {_targetDir = "N"};
				if ((_targetDirection >= 202.5) and (_targetDirection < 247.5)) then {_targetDir = "NE"};
				if ((_targetDirection >= 247.5) and (_targetDirection < 292.5)) then {_targetDir = "E"};
				if ((_targetDirection >= 292.5) and (_targetDirection < 337.5)) then {_targetDir = "SE"};
				if ((_targetDirection >= 337.5) and (_targetDirection < 360)) then {_targetDir = "S"};
				
				_task_text = composeText [_task_text,_cityDistance," klicks ",_cityDir," from ",_cityName," and ",_targetDistance," klicks ",_targetDir," from objective. <br/><br/>"];
			};
			
			_task_text = composeText [_task_text,_task_body];
			
			call compile format ["tskObj%1 setSimpleTaskDescription[""%2"",""%3"",""%3""];",_taskNumber,_task_text,_task_title];
			
			if (_task_assign == "yes") then 
			{
				call compile format ["player setCurrentTask tskObj%1;",_taskNumber]; // assign a task to the player

				call compile format ["[tskObj%1] execVM ""enemy\modules\WICT_enemypop\WICT\sandbox\fTaskHint.sqf""",_taskNumber]; // apprise the player that the task has been assigned
			};
			
			// Now here comes a script that will wait for the change in the task status
			// i.e. wait for the task to be "mentioned"...
			
			_null = [_task_title,_taskNumber] execVM (WICT_PATH + "WICT\sandbox\taskMonitor.sqf");
		};
	};
};