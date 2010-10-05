#define COLOR_GREEN "#(argb,8,8,3)color(0,1,0,0.3,ca)"
#define COLOR_RED 	"#(argb,8,8,3)color(1,0,0,0.3,ca)"
#define COLOR_GRAY 	"#(argb,8,8,3)color(0,0,0,0.3,ca)"

////////////////////////////////

if (isnil {_this getvariable "RMM_cnstrct_radius"}) then {
	////////////////////////////////

	["Preloading CoIn"] call RMM_fnc_failSafeLS;
	
	////////////////////////////////

	if (isnil {_this getvariable "RMM_cnstrct_supplies"}) then {
		_this setvariable ["RMM_cnstrct_supplies",0,true];
	};
	if (isnil {_this getvariable "RMM_cnstrct_radius"}) then {
		_this setvariable ["RMM_cnstrct_radius",100];
	};
	if (isnil "RMM_cnstrct_buildings") then {
		RMM_cnstrct_buildings = false;
		publicvariable "RMM_cnstrct_buildings";
	};
	//List of items, fixed for OA
	if (isnil {_this getvariable "RMM_cnstrct_categories"}) then {
		_this setvariable ["RMM_cnstrct_categories",["Barriers","Sandbags","HESCO","Bunkers","Trenches","Netting","Misc"]];
	};
	if (isnil {_this getvariable "RMM_cnstrct_items"}) then {
		_this setvariable ["RMM_cnstrct_items",[
			["Fort_RazorWire","Barriers",150],
			["Hedgehog_EP1","Barriers",250],
			["Land_fort_bagfence_long","Sandbags",100],
			["Land_fort_bagfence_round","Sandbags",300],
			["Land_HBarrier1","HESCO",100],
			["Land_HBarrier3","HESCO",300],
			["Land_HBarrier5","HESCO",500],
			["Land_HBarrier_large","HESCO",1000],
			["Land_fortified_nest_small_EP1","Bunkers",800],
			["Land_fortified_nest_big_EP1","Bunkers",1800],
			["Land_Fort_Watchtower_EP1","Bunkers",2000],
			["Fort_EnvelopeSmall_EP1","Trenches",0],
			["Fort_EnvelopeBig_EP1","Trenches",0],
			["Land_CamoNetVar_NATO_EP1","Netting",400],
			["Land_CamoNetB_NATO_EP1","Netting",800],
			["Land_CamoNet_NATO_EP1","Netting",300],
			["CampEast_EP1","Misc",800],
			["MASH_EP1","Misc",1400],
			["HeliH","Misc",200],
			["Land_GuardShed","Misc",600],
			["Land_Antenna","Misc",400],
			["Misc_cargo_cont_net1","Misc",1000],
			["Misc_cargo_cont_net2","Misc",3000],
			["Misc_cargo_cont_net3","Misc",7000]
		]];
	};
	_this setvariable ["RMM_cnstrct_usenvg",false];
	if (isnil "RMM_cnstrct_fnc_create") then {
		RMM_cnstrct_fnc_create = {
			if ((RMM_cnstrct_preview getvariable "RMM_cnstrct_color") != COLOR_GREEN) exitwith {};
			private ["_class"];
			_class = RMM_cnstrct_preview getvariable "RMM_cnstrct_type";
			{
				if ((_x select 0) == _class) exitwith {
					private ["_supplies"];
					_supplies = RMM_cnstrct_center getvariable "RMM_cnstrct_supplies";
					if (_supplies - (_x select 2) >= 0) then {
						RMM_cnstrct_center setvariable ["RMM_cnstrct_supplies", _supplies - (_x select 2),true];
						private ["_direction","_position","_object"];
						_direction = getdir RMM_cnstrct_preview;
						_position = screentoworld [0.5,0.5];
						_object = createvehicle [_class,_position,[],0,"NONE"];
						_object setdir _direction;
						_object setpos _position;
						RMM_cnstrct_buildings = RMM_cnstrct_buildings + [_object];
						publicvariable "RMM_cnstrct_buildings";
					};
					deletevehicle RMM_cnstrct_preview;
				};
			} foreach (RMM_cnstrct_center getvariable "RMM_cnstrct_items");
		};
		RMM_cnstrct_fnc_handler = {
			private ["_terminate"];
			_terminate = false;

			private ["_keyscancel","_keysnvg","_keyssell"];
			_keyscancel	= (actionKeys "MenuBack") + [1];
			_keysnvg = actionKeys "NightVision";
			_keyssell = actionKeys "Compass";
			
			private ["_key","_shift","_ctrl","_alt"];
			_key = _this select 1;
			if (count _this > 5) then {
				//mouse
				//_shift = _this select 4;
				_ctrl = _this select 5;
				//_alt = _this select 6;
			} else {
				//keyboard
				//_shift = _this select 2;
				_ctrl = _this select 3;
				//_alt = _this select 4;
			};
			if !(isnil {RMM_cnstrct_center getvariable "RMM_cnstrct_busy"}) exitwith {
				sleep 0.2;
				RMM_cnstrct_center setvariable ["RMM_cnstrct_busy",nil];
			};
			RMM_cnstrct_center setvariable ["RMM_cnstrct_busy",true];		
			
			////////////////////////////////
			if ((_key == 0) and (not isnull RMM_cnstrct_preview) and (not _ctrl)) then {
				[] call RMM_cnstrct_fnc_create;
				[] call RMM_cnstrct_fnc_refresh;
			} else {
				if (_key in _keyscancel) then {
					switch (tolower(typename RMM_cnstrct_params)) do {
						case "scalar" : {
							[] call RMM_cnstrct_fnc_refresh;
						};
						case "string" : {
							deletevehicle RMM_cnstrct_preview;
							
						};
						default {
							if (not isnull RMM_cnstrct_preview) then {
								[] call RMM_cnstrct_fnc_refresh;
								deletevehicle RMM_cnstrct_preview;
							} else {
								_terminate = true;
							};
						};
					};
				};
				if (_key in _keyssell) then {
					[] call RMM_cnstrct_fnc_sell;
				};
				if (_key in _keysnvg) then {
					if (player hasweapon "NVGoggles") then {
						private ["_bool"];
						_bool = not (RMM_cnstrct_center getvariable "RMM_cnstrct_usenvg");
						RMM_cnstrct_center setvariable ["RMM_cnstrct_usenvg",_bool];
						camusenvg _bool;
					};
				};
			};
			if (_terminate) then {
				if (not isnull RMM_cnstrct_preview) then {
					deletevehicle RMM_cnstrct_preview;
				};
				RMM_cnstrct_center = nil;
				RMM_cnstrct_preview = nil;
			};
		};
		RMM_cnstrct_fnc_refresh = {
			RMM_cnstrct_params = false;
			showcommandingmenu "";
			showcommandingmenu "#USER:RMM_cnstrct_menu_0";
		};
		RMM_cnstrct_fnc_sell = {
			private ["_position","_object"];
			_position = screentoworld [0.5,0.5];
			_object = _position nearestobject "all";
			if (isnull _object) exitwith {};
			if !(_object distance _position < (sizeof (typeof _object))/2) exitwith {};
			if !(_object in RMM_cnstrct_buildings) exitwith {};
			private ["_selected"];
			_selected = RMM_cnstrct_center getvariable "RMM_cnstrct_selected";
			if (isnil "_selected") then {
				private ["_helper","_position"];
				_helper = "Sign_arrow_down_large_EP1" createvehiclelocal [0,0,0];
				RMM_cnstrct_center setvariable ["RMM_cnstrct_selected",[_object,_helper]];
				_position = _object modeltoworld [0,0,(((boundingBox _object) select 1) select 2) + 0.2];
				_helper setpos _position;
				_i = 1; _y = 1;
				while {not isnull _object} do {
					if (((RMM_cnstrct_center getvariable "RMM_cnstrct_selected") select 0) != _object) exitwith {};
					if (_i == 10) then {_y = -1};
					if (_i == 1) then {_y = 1};
					_i = _i + _y;
					_position set [2,(_position select 2) + (_y / 20)];
					_helper setpos _position;
					sleep 0.02;
				};
				deletevehicle _helper;
			} else {
				if (_object == _selected select 0) then {
					private ["_type"];
					_type = typeof _object;
					{
						if ((_x select 0) == _type) exitwith {
							RMM_cnstrct_center setvariable ["RMM_cnstrct_supplies", (RMM_cnstrct_center getvariable "RMM_cnstrct_supplies") + (_x select 2),true];
							RMM_cnstrct_buildings = RMM_cnstrct_buildings - [_object];
							publicvariable "RMM_cnstrct_buildings";
							deletevehicle _object;
						};
					} foreach (RMM_cnstrct_center getvariable "RMM_cnstrct_items");
				} else {
					deletevehicle (_selected select 1);
				};
				RMM_cnstrct_center setvariable ["RMM_cnstrct_selected",nil];
			};
		};
		RMM_cnstrct_fnc_update = {
			private ["_supplies"];
			_supplies = RMM_cnstrct_center getvariable "RMM_cnstrct_supplies";
			((uinamespace getvariable "BIS_CONTROL_CAM_DISPLAY") displayctrl 112224) ctrlsetstructuredtext (parsetext format["<t size='2'>S%1</t>",_supplies]);
			switch (tolower(typename RMM_cnstrct_params)) do {
				case "scalar" : {
					//open menu
					private ["_i"];
					_i = 0;
					{
						private ["_category"];
						_category = _x;
						if (_i == RMM_cnstrct_params) exitwith {
							private ["_types","_names","_enabled"];
							_types = []; _names = []; _enabled = [];
							{
								if (_category == (_x select 1)) then {
									private ["_type","_cost"];
									_type = _x select 0;
									_cost = _x select 2;
									_types = _types + [_type];
									_names = _names + [(gettext (configfile >> "CfgVehicles" >> _type >> "displayName")) + format ["	%1", _cost]];
									_enabled = _enabled + [if (_supplies - _cost >= 0) then {1} else {0}];
								};
							} foreach (RMM_cnstrct_center getvariable "RMM_cnstrct_items");
							[[_category,true],"RMM_cnstrct_menu2",[_types,_names,_enabled],"","RMM_cnstrct_params = '%1'; showcommandingmenu ''"] call BIS_fnc_createmenu;
						};
						_i = _i + 1;
					} foreach (RMM_cnstrct_center getvariable "RMM_cnstrct_categories");
					showcommandingmenu "#USER:RMM_cnstrct_menu2_0";
				};
				case "string" : {
					//create preview
					private ["_class","_position"];
					_class = RMM_cnstrct_params;
					RMM_cnstrct_params = false;
					showcommandingmenu "";
					if (_class == "") exitwith {};
					_position = screentoworld [0.5,0.5];
					if (_position distance RMM_cnstrct_center > (RMM_cnstrct_center getvariable "RMM_cnstrct_radius")) exitwith {};
					private ["_camera","_ghost"];
					_camera = RMM_cnstrct_center getvariable "RMM_cnstrct_camera";
				
					_ghost = gettext (configfile >> "CfgVehicles" >> _class >> "ghostpreview");
					if (_ghost == "") then {_ghost = "Land_fortified_nest_smallPreview"};
					RMM_cnstrct_preview = _ghost createvehiclelocal _position;
					RMM_cnstrct_preview setvariable ["RMM_cnstrct_type",_class];
					RMM_cnstrct_preview setobjecttexture [0,COLOR_GRAY];
					_camera camsettarget RMM_cnstrct_preview;
					_camera camcommit 0;
					((uinamespace getvariable "bis_control_cam_display") displayctrl 112214) ctrlsetstructuredtext (parsetext format["<t size='2'>%1</t>",gettext (configfile >> "cfgvehicles" >> _class >> "displayname")]);
					while {not isnull RMM_cnstrct_preview} do {
						private ["_color","_position"];
						_position = getpos RMM_cnstrct_preview;
						_color = if (/*count (_position isflatempty [(sizeof _class) / 4,0,0.8,(sizeof _class),0,false,RMM_cnstrct_preview]) > 0*/ true) then {COLOR_GREEN} else {COLOR_GRAY};
						RMM_cnstrct_preview setobjecttexture [0,_color];
						if (_position distance RMM_cnstrct_center > (RMM_cnstrct_center getvariable "RMM_cnstrct_radius")) exitwith {
							deletevehicle RMM_cnstrct_preview;
							[] call RMM_cnstrct_fnc_refresh;
						};
						RMM_cnstrct_preview setvariable ["RMM_cnstrct_color",_color];
						sleep 0.2;
					};
					((uinamespace getvariable "bis_control_cam_display") displayctrl 112214) ctrlsetstructuredtext (parsetext "");
				};
				default {
					[] call RMM_cnstrct_fnc_refresh;
				};
			};
		};
	};
	endLoadingScreen;
};

////////////////////////////////

disableserialization;

hint format ["CONSTRUCTION MODULE\nNote: %1 to sell", keyName ((actionKeys "Compass") select 0)];

private ["_position","_viewdistance"];
_position = getpos _this;
_viewdistance = viewdistance;
setviewdistance ((_this getvariable "RMM_cnstrct_radius") max 50);

_camera = "camconstruct" camcreate [_position select 0, _position select 1, 5];
_camera cameraeffect ["internal","back"];
_camera campreparefov 0.900;
_camera campreparefocus [-1,-1];
_camera camcommitprepared 0;
cameraeffectenablehud true;
_camera camConstuctionSetParams ([_position] + [_this getvariable "RMM_cnstrct_radius",10]);
BIS_CONTROL_CAM = _camera;

showcinemaborder false;
1122 cutrsc ["constructioninterface","plain"];

////////////////////////////////

RMM_cnstrct_center = _this;
RMM_cnstrct_params = "";
RMM_cnstrct_preview = objnull;
RMM_cnstrct_center setvariable ["RMM_cnstrct_camera",_camera];
RMM_cnstrct_center setvariable ["RMM_cnstrct_usenvg",false];

////////////////////////////////

private ["_display"];
_display = findDisplay 46;

private ["_keydown","_keyup","_mousedown"];
_keydown = _display displayaddeventhandler ["KeyDown","0 = _this spawn RMM_cnstrct_fnc_handler;"];
_keyup = _display displayaddeventhandler ["KeyUp","0 = _this spawn RMM_cnstrct_fnc_handler;"];
_mousedown = _display displayaddeventhandler ["MouseButtonDown","0 = _this spawn RMM_cnstrct_fnc_handler;"];

////////////////////////////////

[["Categories",true],"RMM_cnstrct_menu",_this getvariable "RMM_cnstrct_categories","","RMM_cnstrct_params = %2"] call BIS_fnc_createmenu;
[] call RMM_cnstrct_fnc_refresh;
	
////////////////////////////////

while {not isnil "RMM_cnstrct_center"} do {
	[] call RMM_cnstrct_fnc_update;
	sleep 0.2;
};

////////////////////////////////

if (not isnil {_this getvariable "RMM_cnstrct_selected"}) then {
	deletevehicle ((_this getvariable "RMM_cnstrct_selected") select 1);
	_this setvariable ["RMM_cnstrct_selected",nil];
};
_camera cameraeffect ["terminate","back"];
camdestroy _camera;
1122 cuttext ["","plain"];
BIS_CONTROL_CAM = nil;
showcommandingmenu "";

setviewdistance _viewdistance;

_display displayremoveeventhandler ["KeyDown",_keydown];
_display displayremoveeventhandler ["KeyUp",_keyup];
_display displayremoveeventhandler ["MouseButtonDown",_mousedown];