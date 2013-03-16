/*
	File: init.sqf
	Author: Loyalguard

	Description:
	init.sqf script for AEG demo missions.

	Parameters:
	None.
 
	Execution:
	Executed at mission start by the game engine.
*/

if(isNil "AEGheader")then{AEGheader = 1;};
if (AEGheader == 0) exitWith{};

// Uncomment this line to disable players from manually switching power on and off through the action menu at transformer locations.  True or Nil: enabled.  False: disabled.  Default is enabled.
//AEG_manual = false;

// Uncomment the first line below to allow the CCTV system to use night vision  True: enabled.  False or Nil: disabled.  Default is disabled.  Default times for nightvision can also be customized.
AEG_NVG = true;
//AEG_dark = 19; // Default time Camera NVG use BEGINS, change to customize as desired.  Does not need to be uncommented to work, only if changed.
//AEG_light 6; // Default time Camera NVG use ENDS, change to customize as desired.  Does not need to be uncommented to work, only if changed.

// Uncomment this line to cause an arc flash explosion every time a circuit breaker is switched.  Change the value to whatever odds of occurence you want an arc flash to occur.  For examples AEG_explode = 4 would cause an arc flash 1 in every 4 times, AEG_explode = 100 would cause an arc flash 1 in every 100 times.
AEG_explode = 50; 

// Comment or delete this line to NOT require a password to logon to the grid control software system.  In the demo on Chernarus a password is required at Elektrozavodsk but NOT at Chernogorsk.
//AEG_password = "abc123";

// Uncomment the following line to enable the simulation to remain consistent for team switching players in SP and in the editor.
onTeamSwitch {[_from, _to] execVM "ambience\modules\AEG\Scripts\AEG_team.sqf";};

// If this is not a dedicated server then wait until the player connects otherwise execute the briefing and task script.
if (!isDedicated) then
{
    waitUntil {!isNull player};
};

_nul = [] execVM "ambience\modules\AEG\briefing.sqf";
// _nul = [] execVM "powerTask.sqf"; // Sample task

// Show hint.
// hint "See briefing notes for more information on the ArmA Electrical Grids Simulation.";

// Debug options for developer only.  Similar code is present in most simulation scripts.
//AEG_DEBUG = true;
//LGD_fnc_debugMessage = compile (preprocessFileLineNumbers "LGD_fnc_debugMessage.sqf"); //DEBUG

if (!isNil "AEG_DEBUG") then {_debug = ["init.sqf: execVM AEG_init.sqf."] call LGD_fnc_debugMessage;}; //DEBUG

_nul = [] execVM "ambience\modules\AEG\scripts\AEG_init.sqf";