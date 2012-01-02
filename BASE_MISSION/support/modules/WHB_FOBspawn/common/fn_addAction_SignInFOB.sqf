// When triggered, updates myRespawnPoint to the object's location.
// Still a work in Progress:
// This will later be modified so that it is actually tied to the object.
// another eventHandler will be setup to monitor the state of the HQ Building.
// Author: WobbleyheadedBob aka CptNoPants

private ["_spawnObject"];
_spawnObject = _this select 0;
myRespawnPoint = position _spawnObject;

player sideChat format ["You are now stationed at: %1", myRespawnPoint]; 

//--Add this to the object you want to use as a spawnpoint:
//this addAction ["Sign in", "functions\client\fn_addAction_SignInFOB.sqf", position player, 0, false, true, "", "true"];