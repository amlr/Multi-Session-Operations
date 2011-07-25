/*	ac130_client.sqf for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

//local variables
private["_plane", "_var", "_copilot","_action1", "_action2", "_action3"];

/*
[]spawn
{
	while {true} do
	{
		sleep 0.5;
		titleText[format ["Scripts: %1\nActive: %2\nAbort: %3\nMap: %4",LDL_scriptTerminated, LDL_ac130_active, LDL_ac130_abort, LDL_MapShown], "PLAIN"];	
	};	
};
*/

_plane = objNull;
_var = nil;


while {true} do
{
	sleep 1;
	
	_plane = vehicle player;
	_var = (_plane getVariable "LDL_planeInUse");
	
	//Copilot
	if(player != driver _plane && !isNil "_var") then
	{
		if(!LDL_ac130_active) then
		{
			LDL_ac130_plane = _plane;
			
			_copilot = ((_plane worldToModel (positionCameraToWorld [0,0,0]) distance [0.5, 12.33, -2.06])<5);
			
			if(_copilot) then
			{
				LDL_ac130_plane setVariable ["LDL_planeCoPilot", player, true];	
				
				if(LDL_inGameActions select 0) then
				{
					_action1 = _plane addAction ["<t color=""#FA1845"">"+"AC130 Camera", "support\modules\cas\LDL_ac130\Actions\ac130_action_copilot.sqf",[2], 99, false, true];
				};
				
				if(LDL_inGameActions select 3) then
				{	
					_action2 = _plane addAction ["<t color=""#FA1845"">"+"Activate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_coop_copilot.sqf",[2], 99, false, true];
					//hint format ["%1",_plane getVariable "LDL_planePilot"];	
				};

				while{(((_plane worldToModel (positionCameraToWorld [0,0,0]) distance [0.5, 12.33, -2.06])<5) && (player != driver _plane) && (player in _plane))} do
				{
					sleep 0.5;
					if(LDL_ac130_active) then
					{
						LDL_ac130_plane setVariable ["LDL_planeInUse", true, true];	
						waitUntil{(!LDL_ac130_active)};
						LDL_ac130_plane setVariable ["LDL_planeInUse", false, true];	
					};
				};
				
				_copilot = false;
				_plane removeAction _action1;
				_plane removeAction _action2;
				LDL_ac130_plane setVariable ["LDL_planeCoPilot", objNull, true];	
			};
		};
	};
	
	//Pilot
	if(player == driver _plane && !isNil "_var") then
	{
		if(!LDL_ac130_active) then
		{
			LDL_ac130_plane setVariable ["LDL_planePilot", player, true];	
			
			LDL_ac130_plane = _plane;
			
			if(LDL_inGameActions select 1) then
			{
				_action1 = _plane addAction ["<t color=""#FA1845"">"+"AC130 Autopilot", "support\modules\cas\LDL_ac130\Actions\ac130_action_pilot.sqf",[1], 99, false, true];
			};
			
			if(LDL_inGameActions select 3) then
			{
				_action2 = _plane addAction ["<t color=""#FA1845"">"+"Activate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_systems_pilot.sqf",[1], 99, false, true];
				//hint format ["%1",_plane getVariable "LDL_planeCoPilot"];	
			};

			while{((player == driver _plane) && (player in _plane))} do
			{
				sleep 0.5;
				
				//Rearm
				_truck = nearestObject [_plane, "MtvrReammo"];
				
				if(!isNull _truck) then
				{
					[_plane]call LDL_ac130_rearm;	
				};
				
				if(LDL_SystemsActivated) then
				{
					_plane removeAction _action1;
					_plane removeAction _action2;
					
					_action2 = _plane addAction ["<t color=""#FA1845"">"+"Deactivate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_systems_pilot.sqf",[1], 99, false, true];
										
					waitUntil{(!LDL_SystemsActivated) || !((player == driver _plane) && (player in _plane))};
					
					_plane removeAction _action2;
					
					if(LDL_inGameActions select 1) then
					{
						_action1 = _plane addAction ["<t color=""#FA1845"">"+"AC130 Autopilot", "support\modules\cas\LDL_ac130\Actions\ac130_action_pilot.sqf",[1], 99, false, true];
					};
				
					if(LDL_inGameActions select 3) then
					{
						_action2 = _plane addAction ["<t color=""#FA1845"">"+"Activate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_systems_pilot.sqf",[1], 99, false, true];
					};
				
				};

				if(LDL_ac130_active) then
				{
					LDL_ac130_plane setVariable ["LDL_planeInUse", true, true];	
					waitUntil{(!LDL_ac130_active)};
					LDL_ac130_plane setVariable ["LDL_planeInUse", false, true];	
				};
			};
			
			_plane removeAction _action1;
			_plane removeAction _action2;

			LDL_SystemsActivated = false;
			LDL_ac130_plane setVariable ["LDL_planePilot", objNull, true];	
		};
	};
	
	//Lasermarker
	if(LDL_ac130_active && LDL_plane_type == "AC130_AI") then
	{
		if(LDL_inGameActions select 2) then
		{
			_action1 = player addAction ["<t color=""#FA1845"">"+"AC130 Cease/Open Fire", "support\modules\cas\LDL_ac130\AC130\ac130_AI_ceaseFire.sqf",[1], 99, false, true];
			_action2 = player addAction ["<t color=""#FA1845"">"+"AC130 Attack Position", "support\modules\cas\LDL_ac130\AC130\ac130_AI_assignTarget.sqf",[1], 99, false, true];
			_action3 = player addAction ["<t color=""#FA1845"">"+"AC130 Return Home", "support\modules\cas\LDL_ac130\AC130\ac130_AI_returnHome.sqf",[1], 99, false, true];
		};

		while{(LDL_ac130_active && LDL_plane_type == "AC130_AI")} do
		{
			sleep 0.5;
			
			_objects = (nearestObjects [screenToWorld[0.5,0.5], ["LandVehicle","Air","Ship"], 10]);

			if(count _objects > 0) then
			{
				LDL_fixPos = (_objects select 0);
				
				player removeAction _action2;
				_action2 = player addAction ["<t color=""#FA1845"">"+format["AC130 Attack %1", getText (configFile/"CfgVehicles"/(typeOf (_objects select 0))/"displayName")], "support\modules\cas\LDL_ac130\AC130\ac130_AI_assignTarget.sqf",[1], 99, false, true];
				
				waitUntil{(count(nearestObjects [screenToWorld[0.5,0.5], ["LandVehicle","Air","Ship"], 10]) < count _objects)};
				
				player removeAction _action2;
				_action2 = player addAction ["<t color=""#FA1845"">"+"AC130 Attack Position", "support\modules\cas\LDL_ac130\AC130\ac130_AI_assignTarget.sqf",[1], 99, false, true];
			}
			else
			{
				LDL_fixPos = screenToWorld[0.5,0.5];
			};
		};
			
		player removeAction _action1;
		player removeAction _action2;
		player removeAction _action3;
	};
};
