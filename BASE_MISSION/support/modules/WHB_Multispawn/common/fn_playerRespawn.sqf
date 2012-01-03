// When called it sets the player's postion to 'myRespawnPoint' (simples!)
// Author: WobbleyheadedBob aka CptNoPants
private ["_mySoldier"];
_mySoldier = _this select 0;

//player sideChat format ["Debug : Respawn script Fired!"];

//Need to add a condition here in case the player isn't using CBA???
_mySoldier setPos ([myRespawnPoint, 10] call CBA_fnc_randPos);
//_mySoldier setDir direction (nearestObject [_mySoldier, "LandVehicle"]);

//Usage: Add this to a  trigger at the respawn_west
//Condition: (vehicle player) in thislist 
//On Act: [player] call fn_multiSpawn;

// This can probably be simplified with: http://forums.bistudio.com/showthread.php?t=117028
// player addEventhandler ["respawn", {player call fn_playerRespawn}];