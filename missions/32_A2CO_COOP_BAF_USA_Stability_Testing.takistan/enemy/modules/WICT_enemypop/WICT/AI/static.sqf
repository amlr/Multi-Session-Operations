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
	private ["_allGroups","_grp","_pos","_units","_unit","_list","_staticWeapons","_skip"];

	_allGroups = allGroups;

	{
		_grp = _x;
		_units = units _grp;
		_skip = "no";
		
		{if ((alive _x) and (_x == player)) then {_skip = "yes"}} foreach _units;

		{
			if (alive _x) then
			{
				if (not(isNil (vehicleVarName vehicle _x))) then {_skip = "yes"}
			};
		} foreach _units;
		
		if (_skip == "no") then
		{
			_pos = getPos (leader _grp);

			_units = (units _grp) - [leader _grp];
			/* The leader should not mount defenses */

			_list = _pos nearObjects ["StaticWeapon", 150];
			_staticWeapons = [];

			// Find all nearby static defenses without a gunner
			{
				if ((_x emptyPositions "gunner") > 0) then 
				{
					_staticWeapons set [count _staticWeapons, _x];    
				};
			} forEach _list;

			// Have the group man empty static defenses
			{
				// Are there still units available?
				if ((count _units) > 0) then 
				{
					private ["_unit"];
					_unit = (_units select ((count _units) - 1));
				
					if (_unit == vehicle _unit) then
					{
						_unit setBehaviour "SAFE";
						_unit assignAsGunner _x;
						[_unit] orderGetIn true;
						sleep .5;
						_unit moveInGunner _x;
						
						_units resize ((count _units) - 1);
					};
				};
			} forEach _staticWeapons;
		};
	} forEach _allGroups;
};