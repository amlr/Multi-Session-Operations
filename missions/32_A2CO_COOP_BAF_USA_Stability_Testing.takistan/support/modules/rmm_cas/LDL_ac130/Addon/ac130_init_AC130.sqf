/*	ac130_init_AC130.sqf for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

waitUntil {!isNil "LDL_initDone"};
waitUntil {LDL_initDone};

(_this select 0) setVariable ["LDL_planeInUse", false, true];
(_this select 0) setVariable ["LDL_planePilot", ObjNull, true];
(_this select 0) setVariable ["LDL_planeCoPilot", ObjNull, true];
(_this select 0) setVariable ["LDL_Ammo25", 0, true];
(_this select 0) setVariable ["LDL_Ammo40", 0, true];
(_this select 0) setVariable ["LDL_Ammo105", 0, true];

[(_this select 0)]spawn
{
	waitUntil{(LDL_initDone)};
	(_this select 0) setVariable ["LDL_Ammo25", (LDL_AC130_Adjustments select 2), true];
	(_this select 0) setVariable ["LDL_Ammo40", (LDL_AC130_Adjustments select 3), true];
	(_this select 0) setVariable ["LDL_Ammo105",(LDL_AC130_Adjustments select 4), true];	
};
	
sleep 3;