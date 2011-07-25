/*	ac130_client.sqf for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

/*
[]spawn
{
	while {true} do
	{
		sleep 0.5;
		titleText[format ["Pilot: %1 Copilot: %2 Active: %3 Systems: %4\nPilot: %5",LDL_isPilot, LDL_isCopilot, LDL_ac130_active, LDL_SystemsActivated, LDL_ac130_plane getVariable "LDL_planePilot"], "PLAIN"];	
	};	
};
*/

[]spawn
{
	private["_truck"];
	
	while{true} do
	{
		sleep 1;	
		//Rearm
		if(!isNull LDL_ac130_plane) then
		{
			_truck = nearestObject [LDL_ac130_plane, "MtvrReammo"];
		
			if(!isNull _truck && (LDL_isPilot || LDL_isCopilot)) then
			{
				[LDL_ac130_plane]call LDL_ac130_rearm;	
			};
		};
	};
};

[]spawn
{
	private["_action1", "_action2", "_action3", "_objects"];
	
	while{true} do
	{
		sleep 1;
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
};

[]spawn
{
	private["_plane", "_var"];
	
	_plane = objNull;
	_var = nil;
	LDL_isPilot = false;
	LDL_isCopilot = false;

	while{true} do
	{
		sleep 0.2;
		
		_plane = vehicle player;
		_var = (_plane getVariable "LDL_planeInUse");
		
		if(!isNil "_var") then
		{
			LDL_ac130_plane = _plane;
			
			//Pilot?
			LDL_isPilot = (player == driver _plane && !LDL_ac130_active);	
			
			//Copilot?
			LDL_isCopilot = ((_plane worldToModel (positionCameraToWorld [0,0,0]) distance [0.5, 12.33, -2.06])<5 && !LDL_ac130_active && player != driver _plane);	
		}
		else
		{
			LDL_isPilot = false;
			LDL_isCopilot = false;
			LDL_ac130_plane setVariable ["LDL_planePilot", objNull, true];
			LDL_ac130_plane setVariable ["LDL_planeCoPilot", objNull, true];	
		};
	};
};

[]spawn
{
	while{true} do
	{
		sleep 1;
		
		//Active
		if(LDL_ac130_active) then
		{
			LDL_ac130_plane setVariable ["LDL_planeInUse", true, true];	
			waitUntil{(!LDL_ac130_active)};
			LDL_ac130_plane setVariable ["LDL_planeInUse", false, true];	
		};		
	};	
};

[]spawn
{
	private["_action1", "_action2"];
	
	while {true} do
	{
		sleep 1;
		
		//Pilot
		if(LDL_isPilot && !LDL_ac130_active) then
		{
			//Actions
			if(LDL_inGameActions select 1) then
			{
				_action1 = LDL_ac130_plane addAction ["<t color=""#FA1845"">"+"AC130 Autopilot", "support\modules\cas\LDL_ac130\Actions\ac130_action_pilot.sqf",[1], 99, false, true];
			};
				
			if(LDL_inGameActions select 3) then
			{
				_action2 = LDL_ac130_plane addAction ["<t color=""#FA1845"">"+"Activate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_systems_pilot.sqf",[1], 99, false, true];
			};
			
			//Variable
			LDL_ac130_plane setVariable ["LDL_planePilot", player, true];

			while{LDL_isPilot} do
			{
				sleep 0.5;
				
				//LDL-Systems
				if(LDL_SystemsActivated) then
				{
					LDL_ac130_plane removeAction _action1;
					LDL_ac130_plane removeAction _action2;
					
					_action2 = LDL_ac130_plane addAction ["<t color=""#FA1845"">"+"Deactivate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_systems_pilot.sqf",[1], 99, false, true];
										
					waitUntil{(!LDL_SystemsActivated) || !LDL_isPilot};
					
					LDL_ac130_plane removeAction _action2;
					
					if(LDL_inGameActions select 1) then
					{
						_action1 = LDL_ac130_plane addAction ["<t color=""#FA1845"">"+"AC130 Autopilot", "support\modules\cas\LDL_ac130\Actions\ac130_action_pilot.sqf",[1], 99, false, true];
					};
				
					if(LDL_inGameActions select 3) then
					{
						_action2 = LDL_ac130_plane addAction ["<t color=""#FA1845"">"+"Activate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_systems_pilot.sqf",[1], 99, false, true];
					};
				
				};
			};
			
			LDL_ac130_plane removeAction _action1;
			LDL_ac130_plane removeAction _action2;

			LDL_SystemsActivated = false;	
		};
		
		//Copilot
		if(LDL_isCopilot && !LDL_ac130_active) then
		{
			//Actions
			if(LDL_inGameActions select 0) then
			{
				_action1 = LDL_ac130_plane addAction ["<t color=""#FA1845"">"+"AC130 Camera", "support\modules\cas\LDL_ac130\Actions\ac130_action_copilot.sqf",[2], 99, false, true];
			};
			
			if(LDL_inGameActions select 3) then
			{	
				_action2 = LDL_ac130_plane addAction ["<t color=""#FA1845"">"+"Activate LDL-Systems", "support\modules\cas\LDL_ac130\Actions\ac130_action_coop_copilot.sqf",[2], 99, false, true];
			};
				
			//Variable
			LDL_ac130_plane setVariable ["LDL_planeCoPilot", player, true];	
			
			while{LDL_isCopilot} do
			{
				sleep 0.5;
				
				//LDL-Systems
				if(LDL_SystemsActivated) then
				{
					waitUntil{(!LDL_SystemsActivated) || !LDL_isCopilot};
				};
			};
			
			LDL_ac130_plane removeAction _action1;
			LDL_ac130_plane removeAction _action2;
			
			LDL_SystemsActivated = false;	
		};
	};
};