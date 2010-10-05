waituntil {not isnull player};
waituntil {getplayeruid player != ""};
waituntil {not isnil "RMM_NOMAD_RESPAWNS"};

{
	_x call TK_fnc_vehicle;
} foreach vehicles;

player call revive_fnc_init;

onMapSingleClick "if (_shift && _alt) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";};";
RMM_jipmarkers_types = ["mil_objective","mil_marker","mil_flag","mil_ambush","mil_destroy","mil_start","mil_end","mil_pickup","mil_join","mil_warning","mil_unknown"];

player setskill 0;
{player disableAI _x} foreach ["move","anim","target","autotarget"];

player addeventhandler ["killed", {
	(_this select 0) spawn {
		waituntil {alive player};
		removeallweapons player;
		removeallitems player;
		player switchmove "";
		player setskill 0;
		{player disableAI _x} foreach ["move","anim","target","autotarget"];
	};
}];

//custom weapons per signups
private ["_uid","_string","_default"];
_uid = getplayeruid player;
_string = format ["RMM_nomad_%1",_uid];
_default = ["itemwatch","itemmap","itemcompass","itemradio"];

MSO_R = [];
MSO_R_Admin = false;
MSO_R_Leader = false;
MSO_R_Officer = false;

private "_exit";
_exit = false;
{
	if (_uid == (_x select 0)) exitwith {
		if (count _x < 2) then {_x set [1,["BAF_L85A2_RIS_ACOG"]]};
		if (count _x < 3) then {_x set [2,"PRIVATE"]};
		if (rank player != (_x select 2)) exitwith {_exit = true;};
		MSO_R_Weapons = _x select 1;
		if (isnil _string) then {
			removeallweapons player;
			removeallitems player;
			{player addweapon _x} foreach ((_x select 1) + _default);
			player selectweapon ((_x select 1) select 0);
			player switchmove ""; //stop animation
		
			//give them a sidearm
			player addWeapon "Colt1911";
			player addBackpack "BAF_AssaultPack_RifleAmmo";
		};
		if (count _x > 1) then {
			MSO_R = _x select 3;
			MSO_R_Admin = "admin" in MSO_R;
			MSO_R_Leader = (_x select 2) in ["CORPORAL","LIEUTENANT"];
			MSO_R_Officer = (_x select 2) == "LIEUTENANT";
		};
	};
} foreach [
	["822401", ["BAF_L85A2_RIS_ACOG","Laserdesignator"],"CORPORAL"], //Ryan
	["1022977", ["BAF_L85A2_UGL_ACOG","Binocular_Vector","ItemGPS"]], //Glenn
	["1027329"], //Medel
	["1062145", ["BAF_L85A2_UGL_ACOG","Binocular_Vector"],"CORPORAL"], //Antipop
	["1065345", ["BAF_L85A2_UGL_ACOG","Binocular_Vector"],"CORPORAL"], //Tank
	["1326785"], //Chimpy
	["1555398"], //Stalks
	["1675206"], //Stalkz
	["1769798"], //Mike
	["2194502"], //CQBSam
	["3048774",["BAF_L85A2_UGL_ACOG","Binocular_Vector"],"LIEUTENANT",["admin"]], //Rommel
	["3049670"], //A6-Intruder
	["3050822"], //Greasy Trigger
	["3051014"], //Spoon
	["3051654"], //Winston
	["3053638"], //Snowcat
	["3059270"], //Sealquest
	["3059526"], //Azza
	["3075398"], //Recon
	["3077638"], //Ordeal
	["3088582"], //Drifit
	["3093319"], //Kdog
	["3095110"], //Akuras
	["912385"], //Dozza
	["932353"], //Dagger
	["940417"] //Jukeheavy
];

//default weapons
if (isnil _string) then {
	if (primaryweapon player == "") then {
		{player addweapon _x} foreach (["BAF_L85A2_RIS_ACOG"] + _default);
		player addBackpack "BAF_AssaultPack_RifleAmmo";
	};
};

//settings dialog
private "_trigger";
_trigger = createtrigger ["emptydetector", [0,0]];
_trigger settriggeractivation ["DELTA", "PRESENT", true];
_trigger settriggertext "Settings";
_trigger settriggerstatements ["this","createDialog ""RMM_ui_settings""",""];

if (MSO_R_Admin) then {
	_trigger = createtrigger ["emptydetector", [0,0]];
	_trigger settriggeractivation ["ECHO", "PRESENT", true];
	_trigger settriggertext "Debug";
	_trigger settriggertype "none";
	_trigger settriggerstatements ["this","createDialog ""RMM_ui_debug""",""];
};

//initalise nomad module
[
	[
		/*{deaths player} //auto-integrated*/
		{typeof player;},
		{magazines player;},
		{weapons player;},
		{typeof (unitbackpack player);},
		{getmagazinecargo (unitbackpack player);},
		{getweaponcargo (unitbackpack player);},
		{
			private "_pos";
			_pos = getpos player;
			if (_pos distance _this > 1) then {
				_pos;
			} else {
				_this;
			};
		},
		{damage player;},
		{rating player;},
		{viewdistance;},
		{if(isnil "terraindetail")then{1;}else{terraindetail;};},
		{lifestate player;},
		{vehicle player;}
	],
	[
		{
			if (_this > RMM_NOMAD_RESPAWNS) then {_disconnect = true;};
		},
		{
			if (typeof player != _this) then {_disconnect = true;};
		},
		{
			{player removemagazine _x;} foreach (magazines player);
			{player addmagazine _x;} foreach _this;
		},
		{
			{player removeweapon _x;} foreach ((weapons player) + (items player));
			{player addweapon _x;} foreach _this;
			player selectweapon (primaryweapon player);
		},
		{
			if (_this != "") then {
				player addbackpack _this;
				clearweaponcargo (unitbackpack player);
				clearmagazinecargo (unitbackpack player);
			};
		},
		{
			for "_i" from 0 to ((count (_this select 0))-1) do {
				(unitbackpack player) addmagazinecargo [(_this select 0) select _i,(_this select 1) select _i];
			};
		},
		{
			for "_i" from 0 to ((count (_this select 0))-1) do {
				(unitbackpack player) addweaponcargo [(_this select 0) select _i,(_this select 1) select _i];
			};
		},
		{player setpos _this;},
		{player setdamage _this;},
		{player addrating (-(rating player) + _this);},
		{setviewdistance _this;},
		{
			setterraingrid ((-10 * _this + 50) max 1);
			terraindetail = _this;
		},
		{
			if (tolower(_this) == "unconscious") then {
				[1,player] call revive_fnc_handle_events;
			};
		},
		{
			if !((typeof _this) iskindof "camanbase") then {
				player moveincargo _this;
			};
		}
	]
] execfsm "fsm\nomad.fsm";