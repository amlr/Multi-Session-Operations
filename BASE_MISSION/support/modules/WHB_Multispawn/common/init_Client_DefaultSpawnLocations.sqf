// Sets up the client player's default spawn location and HQ actions
// Author: WobbleyheadedBob aka CptNoPants
myRespawnPoint = [0,0,0];

{[_x] call fn_addAction_HQ} forEach PV_hqArray;

switch(faction player) do
{
	//BLUFOR
	case "USMC":			{myRespawnPoint = (markerPos "respawn_USMC");};
	case "BIS_BAF":			{myRespawnPoint = (markerPos "respawn_BAF");};
    case "BIS_US":			{myRespawnPoint = (markerPos "respawn_USA");};
	case "BIS_CZ":			{myRespawnPoint = (markerPos "respawn_CZ");};
	case "BIS_GER":			{myRespawnPoint = (markerPos "respawn_GER");};
	case "CDF":				{myRespawnPoint = (markerPos "respawn_CDF");};
	
	//OPFOR
	case "RU":				{myRespawnPoint = (markerPos "respawn_RU");};
	case "INS":				{myRespawnPoint = (markerPos "respawn_INS");};
	case "BIS_TK":			{myRespawnPoint = (markerPos "respawn_TK");};
	case "BIS_TK_INS":		{myRespawnPoint = (markerPos "respawn_TK_INS");};
	
	//Independent
	case "GUE":				{myRespawnPoint = (markerPos "respawn_GUE");}; 
	case "PMC_BAF":			{myRespawnPoint = (markerPos "respawn_PMC");};
	case "BIS_TK_GUE":		{myRespawnPoint = (markerPos "respawn_TK_GUE");}; 
	case "BIS_UN":			{myRespawnPoint = (markerPos "respawn_UN");}; 

	//Civilian
	case "CIV":				{myRespawnPoint = (markerPos "respawn_CIV");}; 
	case "CIV_RU":			{myRespawnPoint = (markerPos "respawn_RU");}; 
	case "BIS_TK_CIV":		{myRespawnPoint = (markerPos "respawn_TK_CIV");}; 
	case "BIS_CIV_special":	{myRespawnPoint = (markerPos "respawn_CIV_special");};
};

if (str myRespawnPoint == "[0,0,0]") then {
	myRespawnPoint = (markerPos format["respawn_%1", faction player]);
};

/*
if (str myRespawnPoint == "[0,0,0]") then {
	myRespawnPoint = position player;
};*/