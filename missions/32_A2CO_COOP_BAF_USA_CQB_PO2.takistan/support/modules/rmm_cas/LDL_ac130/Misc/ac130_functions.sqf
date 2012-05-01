/*	ac130_functions.sqf for AC130-Script
*	@author: LurchiDerLurch
*	@param: nothing
*	@return: nothing
*	@description: 
*/

disableSerialization;

LDL_KeyEvents = 
{
	private["_type","_params","_handled", "_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt","_display", "_objects"];
	
	disableSerialization;
	
	_params = _this select 0;
	_type = _this select 1;
  	_ctrl = _params select 0;
 	_dikCode = _params select 1;
 	_shift = _params select 2;
 	_ctrlKey = _params select 3;
 	_alt = _params select 4;
 	_display = (finddisplay  1000);
 
 	switch (_type) do
	{
		case "down":
		{
			
			LDL_pressedKey = [_dikCode,_ctrl,_shift,_ctrlKey,_alt];
			[_dikCode]call LDL_KeyDown;
		};
		
		case "up":
		{	
			LDL_pressedKey = [-1,false,false,false,false];
			[_dikCode]call LDL_KeyUp;
		};
	};
	 

};

LDL_MouseEvents =
{
	private["_param","_type","_x","_y","_check1","_check2","_type","_button","_shift","_wheel","_zoom","_inversion","_display"];
	
	disableSerialization;
	
	_param = _this select 1;
	_type = _this select 0;
	_x = 0;
	_y = 0;
	_display = (finddisplay  1000);
	
	switch (_type) do 
	{
		case "MouseMoving": 
		{
			_x = ((_param select 1)-0.5);
			_y = ((_param select 2)-0.5)*-1;	
			LDL_mousePosition = [_x,_y];					
		};
		case "MouseButtonDown": 
		{
			_button = _param select 1;
			_shift = _param select 4;
			LDL_mouseButtons set[_button, true];
			LDL_mouseButtons set[4, _shift];
		};	
		case "MouseButtonUp": 
		{
			_button = _param select 1;
			LDL_mouseButtons set[_button, false];
		};	
		case "MouseZChanged": 
		{
			_wheel = _param select 1;
			if (!(LDL_pressedKey select 0 == 42)) then
			{
				//Zoom
				if(_wheel > 0) then
				{
					[(LDL_zoomLevel + 0.5)]spawn LDL_setCamFov;
				}
				else
				{
					[(LDL_zoomLevel - 0.5)]spawn LDL_setCamFov;
				};
			}
			else
			{
				//Flir
				if(LDL_cameraEffect == 2) then
				{
					LDL_inversion = LDL_inversion - _wheel/50;
					if (LDL_inversion > 1.0) then {LDL_inversion = 1.0};
					if (LDL_inversion < 0.1) then {LDL_inversion = 0.1};
					_inversion = LDL_inversion*10;
					(_display displayctrl 1002) ctrlSetText format ["Contrast: %1",_inversion]; 
					[]call LDL_createCamEffects;	
				};
			};
		};	
	};	
};

LDL_setCamFov = 
{
	private["_level","_display", "_range"];
	
	disableSerialization;
	
	_level = _this select 0;
	_display = (finddisplay  1000);
	
	if(LDL_viewMode == 0 && (LDL_AC130_Adjustments select 11) && LDL_plane_type == "AC130_ROTATE") then
	{
		//Optical zoom
		LDL_zoomLevel = _level;
		LDL_camFov = 1 - LDL_zoomLevel/10;
	}
	else
	{
		LDL_zoomLevel = (LDL_maxZoomLevel min _level) max 1;
		(_display displayctrl 1002) ctrlSetText format ["Zoom: %1x",LDL_zoomLevel];
			
		if(LDL_camFov > (1 - LDL_zoomLevel/10)) then
		{
			while{LDL_camFov > (1 - LDL_zoomLevel/10)} do
			{
				sleep 0.001;
				LDL_camFov = LDL_camFov - 0.005;
			};
		}
		else
		{
			while{LDL_camFov < (1 - LDL_zoomLevel/10)} do
			{
				sleep 0.001;
				LDL_camFov = LDL_camFov + 0.005;
			};	
		};
		
		LDL_camFov = 1 - LDL_zoomLevel/10;
	}; 
};

LDL_createCam =
{
	private ["_cam"];
	
	_cam = "camera" camcreate [0, 0, 0];
	_cam cameraeffect ["internal", "back"];
	_cam camSetFov LDL_camFov;
	_cam setDir 0;
	
	showCinemaBorder false;

	_cam camSetTarget LDL_cam_rotating_center;
	_cam camCommit 0;
	
	[LDL_cameraEffect]call LDL_createCamEffects;
	
	[LDL_zoomLevel]spawn LDL_setCamFov;
	
      _cam;
};

LDL_createCamEffects =
{
	private ["_mode"];
	
	_mode = LDL_cameraEffect; //0: Nothing, 1: Blue, 2: FLIR white, 3: FLIR black, 4: NVG Green
	
	ppEffectDestroy LDL_ppccor;
	ppEffectDestroy LDL_ppcinv;
	ppEffectDestroy LDL_ppfilm;
	ppEffectDestroy LDL_ppdyblur;
	setAperture -1;
	//Operation Arrowhead
	if (isClass(configfile >> "cfgpatches" >> "ca_E")) then 
	{ 
		[false, 0]call LDL_OAH_setCamUseTi;
		[false, 1]call LDL_OAH_setCamUseTi;
	};
	camUseNVG false;
	
	if(LDL_viewMode == 0) then
	{
		#include "ac130_ppEffects.sqf"; 
	};   
};

LDL_changeView = 
{
	private["_display"];
	
	disableSerialization;
	
	_display = (finddisplay  1000);

	if (LDL_viewMode == 1) then
	{
		//interior
		LDL_viewMode = 0;
		(_display displayctrl 1007) ctrlSetPosition [SafeZoneX + SafeZoneW/2 - SafeZoneW/8,SafeZoneY + SafeZoneH/2 - SafeZoneH/8,SafeZoneW/4,SafeZoneH/4];
		(_display displayctrl 1007) ctrlCommit 0;
		[LDL_equippedWeapon]call LDL_switchWeapon;
		if(LDL_Adjustments select 3) then
		{
			(_display displayctrl 1000) ctrlShow true;
		}
		else
		{
			(_display displayctrl 1000) ctrlShow false;
		};
		LDL_cameraEffect = 1;
		[]call LDL_createCamEffects;
		
		//Camera
		LDL_min_difh = 90;
		LDL_max_difh = 270;
		LDL_min_difv = 100;
		LDL_max_difv = 190;
		LDL_set_min_dirv = 10; 
		LDL_set_max_dirv = 280;
	}
	else
	{
		//exterior
		if(LDL_Adjustments select 4) then
		{
			LDL_viewMode = 1;
			(_display displayctrl 1007) ctrlSetPosition [SafeZoneX + SafeZoneW/2 - SafeZoneW/12,SafeZoneY + SafeZoneH/2 - SafeZoneH/12,SafeZoneW/6,SafeZoneH/6];			
			(_display displayctrl 1007) ctrlCommit 0;
			(_display displayctrl 1000) ctrlShow false;
			[LDL_equippedWeapon]call LDL_switchWeapon;
			LDL_cameraEffect = 0;
			[]call LDL_createCamEffects;
			
			//Camera
			LDL_min_difv = 80;
			LDL_max_difv = 179;
			LDL_set_min_dirv = 359; 
			LDL_set_max_dirv = 260;
		};
	}; 	
};

LDL_getObjectAngles = 
{
	private["_input1","_input2","_x1","_x2","_y1","_y2","_z1", "_z2", "_angH","_c","_a","_b","_q","_p","_h","_angV"];
	
	_input1 = _this select 0;
	_input2 = _this select 1;
	
	if (typeName (_this select 0) == "ARRAY") then
	{
		_x1 = _input1 select 0;
		_y1 = _input1 select 1;
		_z1 = _input1 select 2;
	}
	else
	{
		_x1 = getPosASL _input1 select 0;
		_y1 = getPosASL _input1 select 1;
		_z1 = getPosASL _input1 select 2;
	};
	
	if (typeName (_this select 1) == "ARRAY") then
	{
		_x2 = _input2 select 0;
		_y2 = _input2 select 1;
		_z2 = _input2 select 2;
	}
	else
	{
		_x2 = getPosASL _input2 select 0;
		_y2 = getPosASL _input2 select 1;
		_z2 = getPosASL _input2 select 2;
	};
	
	_angH = (_x2-_x1) atan2 (_y2-_y1);
	
	_c = _input1 distance _input2;
	_a = _z1 - _z2;
	_b = sqrt(_c^2 - _a^2);
	_q = _a^2/_c;
	_p = _c - _q;
	_h = sqrt(_p*_q);
	_angV = atan(_h/_p);
	if(_a > 0) then
	{
		_angV = 360 - _angV;
	};	
	
	[_angH,_angV];
};

LDL_normalizeAngle = 
{
	private["_angle"];
	
	_angle = _this select 0;
	if (_angle > 360) then {_angle = _angle - 360;};
	if (_angle < 0) then {_angle = 360 + _angle;};
	_angle; 
};

LDL_switchWeapon = 
{
	private["_weapon","_display", "_vis"];
	
	disableSerialization;
	
	_weapon = _this select 0;
	_display = (finddisplay  1000);
	
	if (_weapon < 0) then
	{
		
		if (LDL_equippedWeapon + 1 >= count LDL_weaponSlots) then
		{
			LDL_equippedWeapon = 0;
		}
		else
		{
			LDL_equippedWeapon = LDL_equippedWeapon + 1;
		};
	}
	else
	{
		LDL_equippedWeapon = _weapon min ((count LDL_weaponSlots)-1);
	};
	
	_vis = (LDL_weaponSlots select LDL_equippedWeapon)select 5;
	
	(_display displayctrl 1007) ctrlSetText _vis; 
	(_display displayctrl 1007) ctrlCommit 0;
	
	LDL_maxZoomLevel = (LDL_weaponSlots select LDL_equippedWeapon)select 6;		
	[LDL_zoomLevel]spawn LDL_setCamFov;
};

LDL_showHelp = 
{
	private["_display"];
	
	disableSerialization;
	
	_display = (finddisplay  1000);
	
	titleText [format 
	["
		Move your Mouse to aim\n
		L MOUSE: Fire\n
		R MOUSE: Change Position\n 
		MOUSE WHEEL: Zoom\n 
		1 2 3 or ^: Change Weapons\n
		M: Map\n
		Shift: Fix Camera\n
		F1: Help\n
		F2: Toggle View\n 
		F3: Infantry Strobe\n 
		F4: Vehicle Detection\n 
		F5: Normal Mode\n 
		F6: FLIR\n 
		F7: NVG\n 
		F8: Toggle Mode\n 
		F9: Show Waypoints\n 
		F10: Sound\n
		ESC: Abort\n
	"], "BLACK OUT",2];
	
	for [{_i = 1;},{_i < 17},{_i = _i + 1;}] do 
	{
		(_display displayctrl (1000 + _i)) ctrlShow false;
	};
	
	for [{_i = 0;},{_i < 12},{_i = _i + 1;}] do 
	{
		(_display displayctrl (2000 + _i)) ctrlShow false;
	};
	
	sleep 4;
	titleFadeOut 1;
	
	for [{_i = 1;},{_i < 17},{_i = _i + 1;}] do 
	{
		(_display displayctrl (1000 + _i)) ctrlShow true;
	};
	
	for [{_i = 0;},{_i < 12},{_i = _i + 1;}] do 
	{
		(_display displayctrl (2000 + _i)) ctrlShow true;
	};
};

LDL_hellfire =
{
	private["_targetInput","_modelToWorld","_number","_angH","_distance","_altitude","_target","_missleSpawn","_warhead","_speed","_shell","_smoketrail1","_smoketrail2"];

	_targetInput = _this select 0;
	_modelToWorld = _this select 1;
	_startPos = _this select 2;
	_number = _this select 3;
	_warhead = _this select 4;
	_speed = _this select 5;

	if (typeName _targetInput == "ARRAY") then
	{
		_target = (createGroup (createCenter sideLogic)) createUnit ["LOGIC", [0, 0, 0], [], 0, ""];
		_target setPos [_targetInput select 0,_targetInput select 1,_targetInput select 2];
		_target setPos [(getPos _target select 0)+sin(random 360)*random 10,(getPos _target select 1)+cos(random 360)*random 10,(getPos _target select 2)];
	};

	if (typeName _targetInput == "OBJECT") then
	{
		//target is object
		_target = _targetInput;
	};

	for [{_i = 0;},{_i < _number;},{_i = _i + 1;}] do 
	{
		_shell = _warhead createvehicle _startPos;
		_smoketrail1 = "#particlesource" createVehicleLocal getPos _shell;
		_smoketrail1 setParticleParams ["\ca\data\koulesvetlo","","Billboard",100,0.2,[0,0,0],[0,0,0],0,1.27,1.0,0.05,[1,2,1.5,0.5],[[1,0.5,0,0.6],[1,1,1,0.5],[1,1,1,0.1]],[0],0,0,"","", _shell];
		_smoketrail1 setDropInterval 0.002;
		_smoketrail2 = "#particlesource" createVehicleLocal getPos _shell;
		_smoketrail2 setParticleParams ["\ca\data\missileSmoke","","Billboard",100,0.5,[0,0,0],[0,0,0],0,1.27,1.0,0.05,[1,2.5,3,3.5],[[0.5,0.5,0.5,1],[0.7,0.7,0.7,0.5],[0.8,0.8,0.8,0]],[0],0,0,"","",_shell];
		_smoketrail2 setDropInterval 0.002;
		[_shell,_target,_modelToWorld,_speed,1,true,false]spawn LDL_float;
		
		sleep 1;
	};	
};

LDL_confirmButton = 
{
	private["_radius", "_height"];
	
	_radius = parseNumber(ctrlText 2002);
	_height = parseNumber(ctrlText 2003);
	
	if(_radius <= 0 || _height <= 0) then
	{
		["Bad input", false]call LDL_ac130_warning;
	}
	else
	{
		if(_radius > 0) then
		{
			LDL_cam_rotating_set_radius = _radius;	
		};
		
		if(_height > 0) then
		{
			LDL_cam_rotating_set_height = _height;	
		};
	};
};

LDL_transformNumber =
{
	private["_num", "_string"];
	
	_num = _this select 0;
	_string = "";
	
	if (_num <= 9) then 
	{
		_string = format["0%1", _num];
	}
	else
	{
		_string = str _num;
	};
	
	_string;
};

LDL_secondsToTime =
{
	private["_secTotal", "_h", "_m", "_s"];
	
	_secTotal = _this select 0;
	
	_s = [floor(_secTotal MOD 60)]call LDL_transformNumber;
	_m = [floor((_secTotal/60) MOD 60)]call LDL_transformNumber;
	_h = [floor((_secTotal/60/60) MOD 24)]call LDL_transformNumber;
	
	_string = format["%1:%2:%3", _h, _m, _s];
	
	_string;
};

LDL_setCirclePosition =
{
	//[obj, center, radius, angle, height]call LDL_setCirclePosition
	private["_center"];
	if (typeName (_this select 1) == "ARRAY") then
	{
		_center = (_this select 1);
	}
	else
	{
		_center = getPos (_this select 1);
	};
	(_this select 0) setPosASL [(_center select 0)+sin(_this select 3)*(_this select 2),(_center select 1)+cos(_this select 3)*(_this select 2), (_this select 4)];	
};

LDL_getCirclePosition =
{
	//[center, radius, angle]call LDL_getCirclePosition
	private["_center", "_pos"];
	if (typeName (_this select 0) == "ARRAY") then
	{
		_center = (_this select 0);
	}
	else
	{
		_center = getPos (_this select 0);
	};
	
	_pos = [(_center select 0)+sin(_this select 2)*(_this select 1),(_center select 1)+cos(_this select 2)*(_this select 1), (_center select 2)];
	
	_pos;	
};

LDL_setSphericPosition =
{
	//[obj, center, angle horizontal, angle vertical, radius]call LDL_setSphericPosition
	private["_center"];
	if (typeName (_this select 1) == "ARRAY") then
	{
		_center = (_this select 1);
	}
	else
	{
		_center = getPosASL (_this select 1);
	};
	(_this select 0) setPosASL [(_center select 0)+sin(_this select 2)*(sqrt((_this select 4)^2 - ((_this select 4)* cos(_this select 3))^2)),(_center select 1)+cos(_this select 2)*(sqrt((_this select 4)^2 - ((_this select 4)* cos(_this select 3))^2)),(_center select 2)+(_this select 4)* cos(_this select 3)];
};

LDL_setVariables = 
{
	private["_var", "_current25mm", "_current40mm", "_current105mm"];
	
	//Foreign Script Identifier
	LDL_foreignScriptIdentifier = LDL_foreignScriptIdentifier + 1;
	
	//Always the same
	setMousePosition [0.5,0.5];
	setAccTime 1;
	LDL_mousePosition = [0,0];
	LDL_mouseButtons = [false,false,false,false,false];
	LDL_pressedKey = [-1,false,false,false,false];
	LDL_equippedWeapon = 0;
	LDL_guns_enabled = false;
	LDL_camFov = 1;
	LDL_viewMode = 0;
	LDL_cam_rotating_angle = 180;
	LDL_cam_dirh = 0;
	LDL_cam_dirv = 300;
	LDL_guns_dirh = 0;
	LDL_guns_dirv = 300;
	LDL_cam_set_dirh = 0;
	LDL_cam_set_dirv = 300;
	LDL_flyMode = 0;
	LDL_zoomLevel = 1;
	LDL_startTime = time;
	LDL_ac130_abort = false;
	LDL_scriptTerminated = 0;
	LDL_heightASL = true;
	LDL_inversion = 0.1;
	LDL_MapShown = false;
	LDL_warnings = false;
	LDL_plane_roll = -15;
	LDL_plane_pitch = 0;
	LDL_plane_set_roll = -15;
	LDL_plane_set_pitch = 0;
	LDL_fixCam = false;	
	LDL_fixPos = [0,0,0];
	LDL_AI_ceaseFire = false;
	LDL_AI_targetAssigned = false;
	LDL_cam_zoom = 0;
	LDL_min_difh = 90;
	LDL_max_difh = 270;
	LDL_min_difv = 100;
	LDL_max_difv = 190;
	LDL_set_min_dirv = 10; 
	LDL_set_max_dirv = 280;
	
	if(LDL_plane_type == "AC130_ATTACH") then
	{
		LDL_cam_dirh = 270;
	};
	
	//Taken from LDL_Adjustments
	if(LDL_plane_type == "UAV") then
	{
		_var = (LDL_ac130_plane getVariable "LDL_AmmoStrikes");
		if (isNil "_var") then
		{
			_currentStrikes = LDL_UAV_Adjustments select 3;
		}
		else
		{
			_currentStrikes = _var;
		};

		//LDL_weaponSlots = [["Name", max, current, shooting, ammo, picture, max Zoom], [Weapon 2]];
		LDL_weaponSlots = 
		[
			//["Hellfire (Mounted)", LDL_UAV_Adjustments select 2, LDL_ac130_plane ammo "HellfireLauncher", false, "", "support\modules\rmm_cas\LDL_ac130\Pictures\VisTV.paa", LDL_UAV_Adjustments select 4], 
			["Hellfire (Mounted)", LDL_UAV_Adjustments select 2, (LDL_ac130_plane ammo "HellfireLauncher") min (LDL_UAV_Adjustments select 2), false, "", "support\modules\rmm_cas\LDL_ac130\Pictures\VisTV.paa", LDL_UAV_Adjustments select 4], 
			["Hellfire Strike", LDL_UAV_Adjustments select 3, _currentStrikes, false, "", "support\modules\rmm_cas\LDL_ac130\Pictures\VisTV.paa", LDL_UAV_Adjustments select 5]
		];
	}
	else
	{
		_var = (LDL_ac130_plane getVariable "LDL_Ammo25");
		if (isNil "_var") then
		{
			_current25mm = LDL_AC130_Adjustments select 2;
		}
		else
		{
			_current25mm = _var;
		};
		
		_var = (LDL_ac130_plane getVariable "LDL_Ammo40");
		if (isNil "_var") then
		{
			_current40mm = LDL_AC130_Adjustments select 3;
		}
		else
		{
			_current40mm = _var;
		};
		
		_var = (LDL_ac130_plane getVariable "LDL_Ammo105");
		if (isNil "_var") then
		{
			_current105mm = LDL_AC130_Adjustments select 4;
		}
		else
		{
			_current105mm = _var;
		};
		
		//LDL_weaponSlots = [["Name", max, current, shooting, ammo, picture, max Zoom], [Weapon 2]];
		LDL_weaponSlots = 
		[
			["25mm", (LDL_AC130_Adjustments select 2), _current25mm, false, LDL_ammo select 0, "support\modules\rmm_cas\LDL_ac130\Pictures\Vis25mm.paa", LDL_AC130_Adjustments select 6], 
			["40mm", (LDL_AC130_Adjustments select 3), _current40mm, false, LDL_ammo select 1, "support\modules\rmm_cas\LDL_ac130\Pictures\Vis40mm.paa", LDL_AC130_Adjustments select 7], 
			["105mm", (LDL_AC130_Adjustments select 4), _current105mm, false, LDL_ammo select 2, "support\modules\rmm_cas\LDL_ac130\Pictures\Vis105mm.paa", LDL_AC130_Adjustments select 8]
		];
	};
	

	
	LDL_showStrobes = ((LDL_Adjustments select 0)select 1);
	LDL_showVehicles = ((LDL_Adjustments select 1)select 1);
	LDL_showWaypoints = LDL_Adjustments select 9;
	LDL_enableSound = LDL_Adjustments select 5;
	LDL_view360 = LDL_AC130_Adjustments select 5;
	LDL_enableVehicles = ((LDL_Adjustments select 1)select 0);
	LDL_enableStrobes = ((LDL_Adjustments select 0)select 0);
	LDL_enable3rdPers = LDL_Adjustments select 4;
	LDL_showParticles = LDL_Adjustments select 2;
	LDL_maxZoomLevel = LDL_AC130_Adjustments select 6;
	LDL_endTime = LDL_Adjustments select 8;
	LDL_endTimeAI = LDL_AC130_Adjustments select 9;
	LDL_cameraEffect = LDL_Adjustments select 7;
	LDL_opticalZoom = LDL_AC130_Adjustments select 11;
	
	//Taken from the argument
	LDL_cam_rotating_radius = _this select 0;	
	LDL_cam_rotating_height = _this select 1;	
	LDL_cam_rotating_set_radius = _this select 0;	
	LDL_cam_rotating_set_height = _this select 1;
	
	if(LDL_plane_type != "AC130_AI" && LDL_plane_type != "AC130_COOP_PILOT") then
	{
		sleep 1;
		LDL_KeyDownDEH = (findDisplay 46) displayAddEventHandler ["keyDown","[_this,'down'] call LDL_KeyEvents"];
		LDL_KeyUpDEH = (findDisplay 46) displayAddEventHandler ["keyUp","[_this,'up'] call LDL_KeyEvents"];
		
		LDL_ppccor = ppEffectCreate ["ColorCorrections", 1];
	      LDL_ppcinv = ppEffectCreate ["colorInversion", 2];
	      LDL_ppfilm = ppEffectCreate ["filmGrain", 3];
	      LDL_ppdyblur = ppEffectCreate ["dynamicBlur", 0];
      };
      
      []call LDL_userInit;
};
