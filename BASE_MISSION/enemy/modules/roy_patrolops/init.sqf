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

[] execVM PO_Path + "mps\init_mps.sqf";

if (isServer) then {
	if(isNil "HQ") then {
		//get nearest HQ
		HQ = nearestobject [markerpos "ammo","M1130_HQ_unfolded_Base_EP1"];
		
		// If no HQ then create one
		if (isNull HQ) then {
			private ["_pos","_newpos"];
			if !(str (markerPos "ammo") == "[0,0,0]") then {
				_pos = markerPos "ammo";
				_newpos = [_pos, 0, 50, 2, 0, 0, 0] call BIS_fnc_findSafePos;
				HQ = "M1130_HQ_unfolded_Base_EP1" createVehicle _newpos;
				diag_log format ["Creating Patrol Ops MHQ at %1", _newpos];
			} else {
                //failsafe if no marker with name ammo is there (respawn should always be there)
                _pos = markerPos "respawn_west";
				_newpos = [_pos, 0, 50, 2, 0, 0, 0] call BIS_fnc_findSafePos;
				HQ = "M1130_HQ_unfolded_Base_EP1" createVehicle _newpos;
				diag_log format ["Creating Patrol Ops MHQ at %1", _newpos];
            };
		};
		publicvariable "HQ";
	};
};

WaitUntil { !(isNil "HQ")};

if (isnil "runningmission") then {runningmission = false};

//make Check-in and Abort actions on MHQ available for all players and add action locally (for JIP);
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
	["patrol_ops"] spawn mps_mission_sequence;

