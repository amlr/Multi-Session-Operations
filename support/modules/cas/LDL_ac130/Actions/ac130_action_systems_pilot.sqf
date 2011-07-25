/*	ac130_action_systems_pilot.sqf for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

if(isNil "LDL_initDone") exitWith
{
	hintc "LDL Init not initialized or 'LDL AC-130 Init' ('Logics' -> 'LDL Logics') missing";
};

if(LDL_ac130_plane getVariable "LDL_planeInUse" || LDL_ac130_active) then
{
	hint "AC-130 is unavailable! Unable to activate LDL-Systems.";
}
else
{
	if(!LDL_SystemsActivated) then
	{
		LDL_SystemsActivated = true;
		playSound "LDL_beep_short";
		hintSilent "LDL-Systems activated.";
		
		while{LDL_SystemsActivated} do
		{
			sleep 0.5;
		};
		
		playSound "LDL_beep_short";
		hintSilent "LDL-Systems deactivated.";
	}
	else
	{
		LDL_SystemsActivated = false;
	};
	
	/*
	if((getPos LDL_ac130_plane select 2) < 400) then
	{
		hint format ["Altitude must be over 400m. (Currently: %1)",floor(getPos LDL_ac130_plane select 2)];
	}
	else
	{
		//[OBJECT, RADIUS, HEIGHT]
		[LDL_ac130_plane,LDL_AC130_Adjustments select 0,LDL_AC130_Adjustments select 1]call LDL_ac130_coop_pilot_setup;
	};
	*/	
};

	