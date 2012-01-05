#include "script_component.hpp"

private["_groupEntry", "_ctrl"];

// dont actually initialize for 10 seconds
sleep 10;

while { true } do {
	// go through each group entry, see if we need to process it in this current timeframe
	{ 
		_groupEntry = _x;
		_ctrl = _groupEntry select 0;
		if( (diag_tickTime - GET_CTRL_TICK(_ctrl) ) > GET_CTRL_DELAY(_ctrl) ) then {
		
			// let it be processed
			[_groupEntry] call FUNC(srv_processGroup);
			
			// then flag last tick. process may/may not have changed delay. we dont care.
			SET_CTRL_TICK(_ctrl, diag_tickTime);
		};
		_groupEntry set[0, _ctrl];
		// sleep 1 second between each group
		sleep 0.25;
	} forEach GVAR(masterGroupList);
	
	Sleep 5;
};