if (isnil "PO2_ON") then {
    PO2_ON = true;
} else {
    PO2_ON = switch PO2_ON do {
        case 1: {true};
        case 0: {false};
    };
};

if (!(PO2_ON)) exitwith {
	diag_log [diag_frameno, diag_ticktime, time, "PO 2 Module turned off! Exiting..."];
};

diag_log format ["###### %1 ######", missionName];
diag_log [diag_frameno, diag_ticktime, time, "Executing init.sqf"];

PO_Path = "enemy\modules\roy_patrolops\";
 
Receiving_finish = false;

if(isNil "paramsArray") then {
// Mission Parameters (set directly by class to allow module)
	MISSIONTIME	= 9;
	MISSIONCOUNT	= 3;
	MISSIONDIFF	= 1;
	AMBAIRPARTOLS	= 0;
    MISSIONTYPE_PO = 4;
    MISSIONTYPE_AIR = 0;
    PO2_EFACTION = 0;
    PO2_IFACTION = 0;
};

if (isnil "fPlayersInside") then {
	fPlayersInside = {
	        private["_pos","_dist"];
	        _pos = _this select 0;
	        _dist = _this select 1;
	        ({_pos distance _x < _dist} count ([] call BIS_fnc_listPlayers) > 0);
	};
};

if(AMBAIRPARTOLS > 0) then {mps_ambient_air = true};

//define Ranks that are allowed to sign in and abort operations
PO_Ranks = ["CORPORAL","SERGEANT","LIEUTENANT","CAPTAIN"];

[] execVM "enemy\modules\roy_patrolops\mps\init_mps.sqf";

// Credit Roy
player createDiaryRecord ["Diary", ["Patrol Ops 2", "<br/>DESCRIPTION<br/>
===========<br/><br/>
Online Combat Battalion Australia Presents...<br/>
Patrol Operations 2 By [OCB]EightySix<br/><br/>
Don't Kill Civillians..."]]; 

if(!isDedicated) then {
	WaitUntil{ !(isNull player) && !isNil "mps_init" };
}else{
	WaitUntil{!isNil "mps_init"};
};

/*
// This calls the Patrol Ops Mission
// To use just the framework for your own missions, delete the line below.
*/

_patrol_ops = [] execVM "enemy\modules\roy_patrolops\tasks\operations_init.sqf";
