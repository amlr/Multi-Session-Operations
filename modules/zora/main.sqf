/*
	File: main.sqf
	Author: Karel Moricky

	Description:
	Init script of Zora system.
	Will initialize some of SOM variables of SOM is not running.

	Parameter(s):
	_this: the Zora logic unit which triggered this script.
*/
BIS_Zora_path = "modules\zora\";

_logic = _this select 0;
BIS_Zora_Mainscope = _logic;
_logic setvariable ["unitslist",[]];
_logic setvariable ["grp",units _logic - [_logic]];
_logic setpos [1000,10,0];
//[_logic] join grpnull;

//--- Execute Functions
if (isnil "bis_fnc_init") then {
	createcenter sidelogic;
	_logicGrp = creategroup sidelogic;
	_logicFnc = _logicGrp createunit ["FunctionsManager",position player,[],0,"none"];
};

//--- Functions loaded
waituntil {!isnil "BIS_fnc_init"};
_fsm = _this execFSM (BIS_Zora_path + "zora.fsm");
_logic setvariable ["fsm",_fsm];

if (isnil "BIS_Zora_pause") then {BIS_Zora_pause = false};

private ["_centerW", "_centerE", "_centerG", "_centerC"];
_centerW = createCenter west;
_centerE = createCenter east;
_centerG = createCenter resistance;
_centerC = createCenter civilian;
/*
west setFriend [east, 0];
east setFriend [west, 0];
east setFriend [resistance, 0];
resistance setFriend [east, 0];
*/
