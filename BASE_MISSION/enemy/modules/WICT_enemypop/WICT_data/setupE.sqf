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
private["_configParams","_i"];

/* Here you define the configuration for each TYPE of the base.
	I made some pre-defined base types with 45,35,10,5,5 spawning pattern.  */
if ([WICT_eb,"regInfantry"] call KRON_StrInStr) then {_configParams = [25,45,60,70,75,0,0,0,0,0,0,0,0]};
if ([WICT_eb,"specInfantry"] call KRON_StrInStr) then {_configParams = [10,0,25,45,75,0,0,0,0,0,0,0,0]};
if ([WICT_eb,"lightVehicles"] call KRON_StrInStr) then {_configParams = [15,20,25,0,0,45,75,0,0,0,0,0,0]};
if ([WICT_eb,"mediumVehicles"] call KRON_StrInStr) then {_configParams = [10,15,25,0,0,0,45,75,0,0,0,0,0]};
if ([WICT_eb,"mediumArmor"] call KRON_StrInStr) then {_configParams = [10,15,25,0,0,0,0,0,55,0,75,0,0]};
if ([WICT_eb,"heavyArmor"] call KRON_StrInStr) then {_configParams = [5,10,0,0,0,0,0,0,30,45,0,50,0]};
if ([WICT_eb,"airCavalry"] call KRON_StrInStr) then {_configParams = [5,10,20,0,0,0,0,0,0,0,50,75,100]};
//...except this one...
//if ([WICT_eb,"allClasses"] call KRON_StrInStr) then {_configParams = [7.5,15,22.5,30,37.5,45,52.5,60,67.5,75,82.5,90,97.5]};

	_i = 0;
	{call compile format ["%1 = _configParams select _i; _i = _i + 1;",_x]} forEach ["E_reginf","E_at","E_sup","E_snip","E_spec","E_trans","E_lightveh","E_ifv","E_mtank","E_htank","E_mchop","E_hchop","E_wing"];	

};