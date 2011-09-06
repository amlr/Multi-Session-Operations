/***************************************************************************
OBJECT NETWORK UPDATE
CREATED BY SPYDER
SPYDER001@COMCAST.NET

_null = [] execVM "SPY\SPY_objectNetUpdate.sqf";
****************************************************************************/

if(!isServer) exitWith{};

[] spawn {
        while {true} do {
		private ["_i"];
		_i = 0;
                {                                                
                        if (simulationEnabled _x) then {
                                _x enableSimulation false;
				_i = _i + 1;
                                
                                if (((typeOf _x) in ["HeliHEmpty"])) exitWith {};
                                
                                _x addEventHandler ["Hit", "(_this select 0) enableSimulation true;"];    
                                
                                // DEBUG
                                //player sideChat format ["OBJ: %1", _object];
                        };
                        
                } forEach (((allMissionObjects "Static") + (allMissionObjects "Thing")) - (allMissionObjects "ThingEffect"));

		if(_i > 0) then {diag_log format["MSO-%1 Spyder Object Network Update - %2 objects disabled", time, _i];};
		sleep 120;
        };
};

