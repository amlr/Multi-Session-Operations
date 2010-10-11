/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

if (not isdedicated) then {
	PREP(arty);
	PREP(create);
	PREP(extract);
	PREP(fired);
	PREP(insert);
	PREP(onload);
	PREP(update);
	PREP(updatepos);

	GVAR(battery) = objNull;
	GVAR(selectedType) = "HE";
	GVAR(selectedTimerType) = "IMMEDIATE";
	GVAR(position) = [0,0,0];
	GVAR(roundsDelay) = 1;
	GVAR(roundsNumber) = 9;
	GVAR(maximumTimeSustained) = 30;
	GVAR(maximumRounds) = 12;
	GVAR(smokePosition) = [0,0,0];

	["KeyDown", QUOTE(_handle = _this spawn FUNC(create))] call CBA_fnc_addDisplayHandler;
	[] spawn {
		waituntil {not isnull player};
		player addEventHandler ["Fired",QUOTE(_h = _this spawn FUNC(fired))];
	};
	[QUOTE(GVAR(sidechat)), {if (playerSide == (_this select 0)) then {(_this select 1) set [0, localize ((_this select 1) select 0)];[playerSide, "AIRBASE"] sidechat format (_this select 1)}}] call CBA_fnc_addEventHandler;
	[QUOTE(GVAR(sidechatHQ)), {if (playerSide == (_this select 0)) then {(_this select 1) set [0, localize ((_this select 1) select 0)];[playerSide, "HQ"] sidechat format (_this select 1)}}] call CBA_fnc_addEventHandler;
	[QUOTE(GVAR(groupchat)), {if (group player == group (_this select 0)) then {(_this select 1) set [0, localize ((_this select 1) select 0)];(_this select 0) groupchat format (_this select 1)}}] call CBA_fnc_addEventHandler;
};
if (isserver) then {
	PREP(execute_insert);
	PREP(execute_extract);
	PREP(API_add_helicopter);
	
	GVAR(artilleryAvailable) = true;
	GVAR(helicopters) = [];
	GVAR(helicopterAvailable) = true;
	publicVariable QUOTE(GVAR(artilleryAvailable));
	publicVariable QUOTE(GVAR(helicopterAvailable));
	
	[QUOTE(GVAR(execute)), {_this call BIS_ARTY_F_ExecuteTemplateMission}] call CBA_fnc_addEventHandler;
	[QUOTE(GVAR(execute_insert)), {_this call FUNC(execute_insert)}] call CBA_fnc_addEventHandler;
	[QUOTE(GVAR(execute_extract)), {_this call FUNC(execute_extract)}] call CBA_fnc_addEventHandler;
};