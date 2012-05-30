/* Just waiting for Functions and Multiplayer framework */
waituntil {!isNil "bis_fnc_init"};
waituntil {BIS_MPF_InitDone};
waituntil {!isNil "WICT_init"};

_sleep = _this select 0;

if (typeName _sleep != "SCALAR") then {_sleep = -1;};

// Dedicated server doesn't have a player, ever!
if ((_sleep >= 0) and (!isDedicated)) then 
{
	// make sure player object exists i.e. not JIP
	waitUntil {!isNull player};
	waitUntil {player == player};
	
	sleep _sleep; 
	WICT_state = "start"; publicVariable "WICT_state";
};