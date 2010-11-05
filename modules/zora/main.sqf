if (not isserver) exitwith {};

private ["_group","_logic"];
_group = createGroup sideLogic;
_logic = _group createUnit ["Logic",[0,0,0],[],0,"NONE"];

#include <settings.hpp>

/*
	File: main.sqf
	Author: Karel Moricky

	Description:
	Init script of Zora system.
	Will initialize some of SOM variables of SOM is not running.
*/
BIS_Zora_path = "modules\zora\";
BIS_Zora_Mainscope = _logic;
_logic setvariable ["unitslist",[]];
_logic setvariable ["grp",units _logic - [_logic]];
_logic setpos [1000,10,0];
//[_logic] join grpnull;

//--- Execute Functions
if (isnil "bis_fnc_init") then {
	createcenter sidelogic;
	_logicGrp = creategroup sidelogic;
	_logicFnc = _logicGrp createunit ["FunctionsManager",[0,0,0],[],0,"NONE"];
};

//--- Functions loaded
waituntil {!isnil "BIS_fnc_init"};
_fsm = [_logic] execFSM (BIS_Zora_path + "zora.fsm");
_logic setvariable ["fsm",_fsm];

if (isnil "BIS_Zora_pause") then {BIS_Zora_pause = true};
