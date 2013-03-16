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

if (isServer) then	{
	if (isNil "wict_spawnBLUFOR") then {wict_spawnBLUFOR = 1};

		switch(wict_spawnBLUFOR) do {
			case 0: {
					private["_configParams","_i"];

					/* Here you define the configuration for each TYPE of the base.
					I made some pre-defined base types with 45,35,10,5,5 spawning pattern.  */
					if ([WICT_wb,"regInfantry"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"specInfantry"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"lightVehicles"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"mediumVehicles"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"mediumArmor"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"heavyArmor"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"airCavalry"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,0,0,0,0,0,0,0]};
					//...except this one...
					//if ([WICT_wb,"allClasses"] call KRON_StrInStr) then {_configParams = [7.5,15,22.5,30,37.5,45,52.5,60,67.5,75,82.5,90,97.5]};
	
					_i = 0;
					{call compile format ["%1 = _configParams select _i; _i = _i + 1;",_x]} forEach ["W_reginf","W_at","W_sup","W_snip","W_spec","W_trans","W_lightveh","W_ifv","W_mtank","W_htank","W_mchop","W_hchop","W_wing"];
			};
			case 1: {
					private["_configParams","_i"];

					if ([WICT_wb,"regInfantry"] call KRON_StrInStr) then {_configParams = [45,55,90,95,100,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"specInfantry"] call KRON_StrInStr) then {_configParams = [5,10,45,55,100,0,0,0,0,0,0,0,0]};
					if ([WICT_wb,"lightVehicles"] call KRON_StrInStr) then {_configParams = [10,15,20,0,0,55,100,0,0,0,0,0,0]};
					if ([WICT_wb,"mediumVehicles"] call KRON_StrInStr) then {_configParams = [5,0,10,0,0,20,55,100,0,0,0,0,0]};
					if ([WICT_wb,"mediumArmor"] call KRON_StrInStr) then {_configParams = [0,5,0,0,0,10,20,55,100,0,0,0,0]};
					if ([WICT_wb,"heavyArmor"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,5,10,20,55,100,0,0,0]};
					if ([WICT_wb,"airCavalry"] call KRON_StrInStr) then {_configParams = [0,0,0,0,0,0,5,10,0,0,55,90,100]};
					
					_i = 0;
					{call compile format ["%1 = _configParams select _i; _i = _i + 1;",_x]} forEach ["W_reginf","W_at","W_sup","W_snip","W_spec","W_trans","W_lightveh","W_ifv","W_mtank","W_htank","W_mchop","W_hchop","W_wing"];
			};

	};
};