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

 
//[] execVM PO_Path + "notes.sqf";

Receiving_finish = false;

if(isNil "paramsArray") then {
// Mission Parameters (set directly by class to allow module)
	MISSIONTIME	= 9;
	MISSIONTYPE	= 5;
	MISSIONCOUNT	= 3;
	ACEWOUNDENBLE	= 1;
	MISSIONDIFF	= 1;
	AMBIECOUNT	= 30;
	AMBAIRPARTOLS	= 0;
};

/*
// For SP/Mission Testing
//	if(isNil "paramsArray") then { paramsArray = [9,5,3,0,3,1,0,1,1,1,1,1,1,30,1,0,0]; };

// Mission Parameters (set directly by class to allow module)
	MISSIONTIME	= paramsArray select 0;
	MISSIONTYPE	= paramsArray select 1;
	MISSIONCOUNT	= paramsArray select 2;
//	VEHCLASSLIMIT	= paramsArray select 3;
//	INJURYFACTOR	= paramsArray select 4;
	ACEWOUNDENBLE	= paramsArray select 5;
//	RESTRICTCAM	= paramsArray select 6;
//	RANKSYSENBLE	= paramsArray select 7;
//	RANKEDGEAR	= paramsArray select 8;
	MISSIONDIFF	= paramsArray select 9;
//	AIRDROPSENBLE	= paramsArray select 10;
//	LIFTCHPRENBLE	= paramsArray select 11;
//	RECRUITENBLE	= paramsArray select 12;
	AMBIECOUNT	= paramsArray select 13;
//	AMBCIVILLIAN	= paramsArray select 14;
//	AMBINSURGENTS	= paramsArray select 15;
	AMBAIRPARTOLS	= paramsArray select 16;


//	if(VEHCLASSLIMIT > 0) then {mps_class_limit = true};
//	if(AIRDROPSENBLE > 0) then {mps_airdrop_enable = true};
//	if(LIFTCHPRENBLE > 0) then {mps_liftchopper_enable = true};
//	if(RANKSYSENBLE > 0) then {mps_rank_sys_enabled = true};
//	if(RANKEDGEAR > 0) then {mps_rank_gear = true};
//	if(RECRUITENBLE > 0) then {mps_recruitable_ai = true};
*/

	if(ACEWOUNDENBLE > 0) then {mps_ace_wounds = true};
	if(AMBIECOUNT > 0) then {mps_ambient_ins = true};
	if(AMBAIRPARTOLS > 0) then {mps_ambient_air = true};

//	mps_ais_factor = INJURYFACTOR;

	[] execVM PO_Path + "mps\init_mps.sqf";
//	[] execVM PO_Path + "tasks\checkin_mhq.sqf";

if(isNil "HQ") then {
	//make Check-in Action on MHQ available for all players and add action locally (for JIP);
	HQ = nearestobject [getmarkerpos format["respawn_%1", playerSide],"M1130_HQ_unfolded_Base_EP1"];
};
    if (isnil "runningmission") then {runningmission = false};
    
    if (!runningmission) then {    
    [3,[],{
	    HQaction = HQ addaction ["Check in for special operations", PO_Path + "tasks\checkin_mhq.sqf"];
    }] call mso_core_fnc_ExMP;
    };
    
    if (runningmission) then {    
    [3,[],{
	    HQaction = HQ addaction ["Abort operation", PO_Path + "tasks\abort.sqf"];
    }] call mso_core_fnc_ExMP;
    };
/* 
    //Crediting Patrol Ops - Team (locally)
    [3,[],{
	    [] execVM PO_Path + "credits.sqf";
    }] call mso_core_fnc_ExMP;
*/
player createDiaryRecord ["Diary", ["Patrol Ops 2", "<br/>DESCRIPTION<br/>
===========<br/><br/>
Online Combat Battalion Australia Presents...<br/>
Patrol Operations 2 By [OCB]EightySix<br/><br/>
Don't Kill Civillians..."]]; 

if(!isDedicated) then {
//	onPreloadFinished { Receiving_finish = true; onPreloadFinished {}; };
//	WaitUntil{ !(isNull player) && !isNil "mps_init" && Receiving_finish };
	WaitUntil{ !(isNull player) && !isNil "mps_init" };
}else{
	WaitUntil{!isNil "mps_init"};
};

/*
// This is the intro Sequence. Edit this line to have your own text fill the screen on intro.
	["Online Combat Battalion Presents...",format["Patrol Operations 2\n%1",worldname],"By [OCB]EightySix","Don't Kill Civillians..."] spawn mps_intro;

// This sets the date from the mission parameters on the server and all JIP players are then set to the server time.
//	[2011,5,2,MISSIONTIME,15] call mps_setdate;

// This line prepares the outro. To call the outro, declare "mps_mission_finished = true" in a trigger or line of code to trigger the outro sequence.
	[] call mps_outro;

// This creates an Ammobox for a New / JIP Player on a marker called "ammobox_(playerside)"
	[format["ammobox_%1",side player]] call mps_ammobox;

// This calls the Patrol Ops Mission
// To use just the framework for your own missions, delete the line below.
*/
	["patrol_ops"] spawn mps_mission_sequence;

