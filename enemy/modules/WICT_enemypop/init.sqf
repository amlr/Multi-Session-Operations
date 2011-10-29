//{}{}{}{}{}{}{}{}{} CREATING CENTERS {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}

/*
// Creating all centers, so you don't have to place "dummy" units
WEST = createCenter WEST;	
EAST = createCenter EAST;
GUER = createCenter RESISTANCE;
CIV = createCenter CIVILIAN;

// Making friends ? :) nooo, enemies

	WEST setFriend [EAST, 0];
	EAST setFriend [WEST, 0];
	EAST setFriend [GUER, 0.2];
	GUER setFriend [EAST, 0.2];
*/

//{}{}{}{}{}{}{}{}{} INITIALIZING WICT {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
WICT_PATH = "enemy\modules\WICT_enemypop\";

// DO NOT TOUCH THIS !!!
WICT_init = false; WICT_state = "stop";
_null = [] execVM (WICT_PATH + "WICT\start.sqf");

//{}{}{}{}{}{}{}{}{} AUTO START WICT{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
// negative number means OFF, greater or equal than 0 = number of seconds
_null = [5] execVM (WICT_PATH + "WICT\autoStart.sqf");

//{}{}{}{}{}{}{}{}{} LOADER {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
// continue loading other stuff at the beginning
_null = [] execVM (WICT_PATH + "WICT_data\load\loader.sqf");

//{}{}{}{}{}{}{}{}{} CATCHING TRIGGERS {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
// Do not change this - it's variable that carries trigger name (initializing on "none") for Editor based AI spawn script by trigger
	catch_trigger = "none";
	
//{}{}{}{}{}{}{}{}{} MISSION CAPTURE {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
//Capture your mission to Clipboard!!!
// negative number means OFF, greater or equal than 0 = number of seconds (more is better)
_null = [-10] execVM (WICT_PATH + "WICT\missionCapture.sqf");

//{}{}{}{}{}{}{}{}{} TIME SHIFT {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
//If you don't want to use it put comment marks in front
//_null = [30,1,1] execVM (WICT_PATH + "WICT\timeShift.sqf");

//{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}