/*	ac130_action_coop_copilot.sqf for AC130-Script
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
	hint "AC-130 is unavailable!";
}
else
{

};

	