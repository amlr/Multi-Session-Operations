/*	ac130_coop_pilot_main.sqf by LurchiDerLurch for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

//local variables
private["_id", "_display", "_bank", "_dis", "_yaw", "_x", "_y", "_w", "_h", "_secTotal"];

_id = LDL_foreignScriptIdentifier;

disableSerialization;

waitUntil {sleep 0.1; (LDL_ac130_active)};

_display = (UINameSpace GetVariable "LDL_HUD_pilot_disp");

5 cutRsc["LDL_HUD_pilot", "PLAIN"];

while {alive LDL_ac130_plane && alive player && !LDL_ac130_abort && player == driver LDL_ac130_plane} do
{
	sleep 0.005;
	
	if(_id != LDL_foreignScriptIdentifier) exitWith{};
	
	_display = (UINameSpace GetVariable "LDL_HUD_pilot_disp");
	
	if (isNull _display) then 
	{
		LDL_RscLayer cutRsc["LDL_HUD_pilot", "PLAIN"];
	};
	
	//_length = 0.2;
	//_center = [SafeZoneX+SafeZoneW/4+_length/2,SafeZoneY+SafeZoneH/4+_length/2]; 
	//_x = (_center select 0)-_length/2;
	//_y = (_center select 1)-_length/2;
	//_w = _length;
	//_h = _length;
	//_x = _x + cos(_bank)*_w;
	//_y = _y + sin(_bank)*_h;
	//_w = _w - 2*cos(_bank)*_w;
	//_h = _h - 2*sin(_bank)*_h;
	//(_display DisplayCtrl 104) CtrlSetPosition [_x, _y, _w, _h];
	//(_display DisplayCtrl 101) CtrlSetPosition [_x + cos(_bank)*_w, _y + sin(_bank)*_h, -2*cos(_bank)*_w, -2*sin(_bank)*_h];
	//(_display DisplayCtrl 104) CtrlCommit 0.00;
	
	_bank = floor(LDL_ac130_plane call LDL_getPitchBank select 1);
	_yaw = floor(([LDL_ac130_plane, LDL_cam_rotating_center]call LDL_mando_angles) select 1)+90;
	_dis = floor([getPos LDL_cam_rotating_center select 0, getPos LDL_cam_rotating_center select 1, 0] distance [getPos LDL_ac130_plane select 0, getPos LDL_ac130_plane select 1, 0]);
	
	(_display DisplayCtrl 101) CtrlSetText format["Roll: %1'", _bank];
	(_display DisplayCtrl 102) CtrlSetText format["Yaw: %1'", _yaw];
	(_display DisplayCtrl 103) CtrlSetText format["Dis: %1m", _dis];
	
	//Countdown
	if(LDL_endTime > 0) then
	{
		_secTotal = LDL_endTime-(time-LDL_startTime);
		
		if(_secTotal <= 0) then
		{
			LDL_ac130_abort = true;
		};
	};
	
	hintSilent format["%1",LDL_ac130_plane call LDL_getPitchBank select 1];
};

ppEffectDestroy LDL_ppccor;
ppEffectDestroy LDL_ppcinv;
ppEffectDestroy LDL_ppfilm;
ppEffectDestroy LDL_ppdyblur;
setAperture -1; 

LDL_ac130_abort = true;

LDL_ac130_active = false;