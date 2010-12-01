if (not isserver) exitwith {};

private ["_group","_logic"];
_group = createGroup sideLogic;
_logic = _group createUnit ["Logic",[0,0,0],[],0,"NONE"];

#define NIGHT_POSSIBILITY 0.2 //Percentage (0.2 == 20%)
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

[] spawn {
	_fnc_status = {
		if (BIS_Zora_Mainscope getvariable "debug") then {
			hint format["ZORA Pause: %1\nMaxGroups: %2", BIS_Zora_pause, BIS_Zora_mainscope getvariable "maxgroups"];
		};
	};
			
	while {true} do {
		if (count playableUnits > 0) then {
			BIS_Zora_mainscope setvariable ["maxgroups",round (((8+random 4) / (count playableUnits)) min 5) max 1];
		};
		if ((random 1 > NIGHT_POSSIBILITY) && (daytime < 5 || daytime > 18)) then {
			BIS_Zora_pause = true;
			call _fnc_status;
			sleep (60 * 60) + (random 60 * 60);
		} else {
			if(BIS_Zora_pause) then {
				BIS_Zora_pause = false;
				call _fnc_status;
				sleep (60 * 15) + (random 60 * 45);
			} else {
				BIS_Zora_pause = true;
				call _fnc_status;
				sleep (60 * 30) + (random 60 * 90);
			};
		};
	};
};