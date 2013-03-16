/*
__          __        _     _   _          _____             __ _ _      _     _______          _ 
\ \        / /       | |   | | (_)        / ____|           / _| (_)    | |   |__   __|        | |
 \ \  /\  / /__  _ __| | __| |  _ _ __   | |     ___  _ __ | |_| |_  ___| |_     | | ___   ___ | |
  \ \/  \/ / _ \| '__| |/ _` | | | '_ \  | |    / _ \| '_ \|  _| | |/ __| __|    | |/ _ \ / _ \| |
   \  /\  / (_) | |  | | (_| | | | | | | | |___| (_) | | | | | | | | (__| |_     | | (_) | (_) | |
    \/  \/ \___/|_|  |_|\__,_| |_|_| |_|  \_____\___/|_| |_|_| |_|_|\___|\__|    |_|\___/ \___/|_|

  ,---.                     ,---.  ,--.,--.,--.            ,--.,--.      
 /  O  \ ,--.--.,--,--,--. /  O  \ |  ||  ||  ,---.  ,---. |  |`--' ,---.
|  .-.  ||  .--'|        ||  .-.  ||  ||  ||  .-.  || .-. ||  |,--.| .--'
|  | |  ||  |   |  |  |  ||  | |  ||  ||  ||  | |  |' '-' '|  ||  |\ `--.
`--' `--'`--'   `--`--`--'`--' `--'`--'`--'`--' `--' `---' `--'`--' `---'
*/

if (isServer) then
{		
	// *WARNING* murk_spawn RIPOFF - Taken from _fnc_cleanGroup
	// This is the general cleanup function running in the background for the group, replaces the removebody eventhandler and delete group in V5
	_group = _this select 0;
	_unitsGroup = units _group;
	_sleep = _this select 1;
	// Hold until the entire group is dead
	while { ({alive _x} count _unitsGroup) > 0 } do { sleep 5; };
	sleep _sleep;
	{
		_origPos = getPos _x;
		_z = _origPos select 2;
		_desiredPosZ = if ( (vehicle _x) iskindOf "Man") then { (_origPos select 2) - 0.5 } else { (_origPos select 2) - 3 };
		if ( vehicle _x == _x ) then {
			_x enableSimulation false;
			while { _z > _desiredPosZ } do { 
				_z = _z - 0.005;
				_x setPos [_origPos select 0, _origPos select 1, _z];
				sleep 0.001;
			};
		};
		deleteVehicle _x; 
		sleep 5;
	} forEach _unitsGroup;		
	// Now we know that all units are deleted
	sleep 10;
	deleteGroup _group;
};	