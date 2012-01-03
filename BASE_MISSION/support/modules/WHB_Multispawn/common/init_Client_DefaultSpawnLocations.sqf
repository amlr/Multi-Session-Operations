// Sets up the client player's default spawn location
// Author: WobbleyheadedBob aka CptNoPants

private ["_syncActions"];

//player sideChat format ["INITIALISING : MULTI-SPAWN"];
myRespawnPoint = [0,0,0];

// Apply Deploy/Undeploy/SignIn actions to all HQ objects on JIP
_syncActions = [PV_hqArray] execVM "support\modules\WHB_Multispawn\common\fn_JIP_HQSync.sqf";

switch(faction player) do
{
	case "USMC":	{myRespawnPoint = (markerPos "respawn_US");};
	case "BIS_BAF":	{myRespawnPoint = (markerPos "respawn_UK");}; 
	default {
		myRespawnPoint = (markerPos format["respawn_%1", faction player]);
	};
}; //Assign Default Spawn Point based on your faction

if (str myRespawnPoint == "[0,0,0]") then {
	myRespawnPoint = (markerPos format["respawn_%1", faction player]);
};


if (str myRespawnPoint == "[0,0,0]") then {
	myRespawnPoint = position player;
};

//player sideChat format ["Debug : Respawn Coords: %1", myRespawnPoint]; 

//Usage: Add this to a global trigger
//Activation: None / Once / Present
//Type: None
//Condition: local player
//On Act: _dummy = [] execvm "functions\common\initSpawn.sqf"