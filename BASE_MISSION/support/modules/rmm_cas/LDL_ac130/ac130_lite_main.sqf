/*	ac130_lite_main.sqf by LurchiDerLurch for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

//local variables
private["_id", "_display", "_screen", "_secTotal", "_logic", "_angles"];

_id = LDL_foreignScriptIdentifier;

disableSerialization;

waitUntil {sleep 0.1; (LDL_ac130_active)};

_display = (finddisplay 1000);

while {dialog && alive LDL_ac130_plane && alive player && !LDL_ac130_abort} do
{
	sleep 0.005;
	
	if(_id != LDL_foreignScriptIdentifier) exitWith{};
	
	//Countdown
	if(LDL_endTime > 0) then
	{
		_secTotal = LDL_endTime-(time-LDL_startTime);
		
		if(_secTotal <= 0) then
		{
			LDL_ac130_abort = true;
		};
	};
	
	//Center
	_screen = worldToScreen (getPos LDL_cam_rotating_center);

	if (count _screen != 2) then
	{                              
		_screen = [-1,-1];
	};
	     
	(_display displayCtrl 1005) ctrlSetPosition [(_screen select 0)-SafeZoneW/32,(_screen select 1)-SafeZoneH/32];
	(_display displayCtrl 1005) ctrlCommit 0;
	
	//Gun Direction
	_angles = [LDL_gunPosition,screenToWorld [0.5,0.5]]call LDL_getObjectAngles;
	LDL_guns_dirh = [_angles select 0]call LDL_normalizeAngle;
	LDL_guns_dirv = [_angles select 1]call LDL_normalizeAngle;
	
	//HUD
	#include "AC130\ac130_HUD.sqf"
	
	//Shooting
	if (LDL_mouseButtons select 0 && !(LDL_mouseButtons select 4)) then 
	{
		if((LDL_guns_enabled && LDL_viewMode == 1) || LDL_viewMode == 0) then
		{
			[getPos LDL_gunPosition,LDL_cam_dirh,LDL_cam_dirv]spawn LDL_ac130_guns;
		};
	};
};

camDestroy LDL_ac130_cam;
setAperture -1;
LDL_ac130_cam cameraeffect ["terminate", "back"];

ppEffectDestroy LDL_ppccor;
ppEffectDestroy LDL_ppcinv;
ppEffectDestroy LDL_ppfilm;
ppEffectDestroy LDL_ppdyblur;
setAperture -1; 

//Remove DEH again on exit
(findDisplay 46) displayRemoveEventHandler ["keyDown",LDL_KeyDownDEH];
(findDisplay 46) displayRemoveEventHandler ["keyUp",LDL_KeyUpDEH];

while{dialog} do
{
	closeDialog 0;	
};

LDL_ac130_plane setVariable ["LDL_Ammo25", (LDL_weaponSlots select 0)select 2, true];
LDL_ac130_plane setVariable ["LDL_Ammo40", (LDL_weaponSlots select 1)select 2, true];
LDL_ac130_plane setVariable ["LDL_Ammo105",(LDL_weaponSlots select 2)select 2, true];

0 fadeSound 0; 
0 fadeSound 1; 

LDL_ac130_abort = true;

LDL_ac130_active = false;