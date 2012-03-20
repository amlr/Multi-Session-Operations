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
	MISSIONTYPE	= 5;
	MISSIONCOUNT	= 3;
	ACEWOUNDENBLE	= 1;
	MISSIONDIFF	= 1;
	AMBAIRPARTOLS	= 0;
};

if(AMBAIRPARTOLS > 0) then {mps_ambient_air = true};

//define Team leaders that are allowed to sign in and abort operations
PO_teamleads = [
	"BAF_Soldier_TL_MTP",
	"BAF_Soldier_SL_MTP",
	"US_Soldier_TL_EP1",
	"US_Soldier_SL_EP1",
	"USMC_Soldier_SL",
	"USMC_Soldier_TL",
	"RU_Soldier_SL",
	"RU_Soldier_TL",
	"GUE_Soldier_CO",
	"GUE_Commander",
	"CZ_Soldier_SL_DES_EP1",
	"aawInfantrySecco1",
	"aawInfantrySecco1_dpduDpcu",
	"cwr2_OfficerW"
];

[] execVM PO_Path + "mps\init_mps.sqf";

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

_patrol_ops = [] execVM PO_path + "tasks\operations_init.sqf";
