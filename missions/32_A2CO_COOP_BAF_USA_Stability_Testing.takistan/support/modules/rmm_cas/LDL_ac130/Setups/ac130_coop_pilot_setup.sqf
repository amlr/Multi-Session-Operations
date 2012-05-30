/*	ac130_coop_pilot_setup.sqf by LurchiDerLurch for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

//local variables
private ["_input", "_radius", "_height", "_pos", "_ac130_pilot", "_var"];

_input = _this select 0;
_radius = _this select 1;
_height = _this select 2;

waitUntil {!isNil "LDL_initDone"};
waitUntil {LDL_initDone};

waitUntil{(!LDL_ac130_active)};

LDL_ac130_active = true;
LDL_plane_type = "AC130_COOP_PILOT";

if (typeName _input == "OBJECT") then
{
	LDL_ac130_plane = _input;

	[_radius,_height] call LDL_setVariables;
	
	_pos = LDL_ac130_plane modelToWorld [_radius*-1,0,0];
	
	LDL_cam_rotating_center setPos [_pos select 0,_pos select 1,0];
	LDL_cam_rotating_height = getPosASL LDL_ac130_plane select 2; //TODO: take the height from the call argument
	LDL_cam_rotating_angle = [(getDir LDL_ac130_plane) + 90]call LDL_normalizeAngle;
	LDL_cam_dirh = [LDL_cam_rotating_angle-180]call LDL_normalizeAngle;
};

//Create dialog
//[]call LDL_ac130_createDialog;

//Start all scripts
[]spawn LDL_ac130_coop_pilot_main;
[]spawn LDL_ac130_sound;
[]spawn LDL_ac130_rot_waypoints;
LDL_showWaypoints = true;