// When called it sets the player's postion to 'myRespawnPoint' (simples!)
// Author: WobbleyheadedBob aka CptNoPants
private ["_mySoldier","_respawnObject","_objectLocation"];
_mySoldier = _this select 0;
_respawnObject = _mySoldier getVariable "playerRespawnPoint";
_objectLocation = position _respawnObject;

if (isNil "_respawnObject") then {
	_mySoldier setPos ([myRespawnPoint, 10] call CBA_fnc_randPos);
} else {
	_mySoldier setPos ([_objectLocation, 10] call CBA_fnc_randPos);
};