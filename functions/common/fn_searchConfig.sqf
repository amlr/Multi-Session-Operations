/* -----------------------------------------------------------------------------
Function: CBA_fnc_searchConfig

Description:
	Searches the config for the parsed string, returns matches that contain the string, very resource heavy

Parameters:
	- String - the search string
	Optional
	- List of config types
Returns:
	List of matching config entries
	
Example:
	["a10"] call CBA_fnc_searchConfig
	["a10",["CfgVehicles"]] call CBA_fnc_searchConfig

Author:
	Rommel
---------------------------------------------------------------------------- */

private ["_string", "_types", "_results", "_l"];
_string = tolower (_this select 0);
_types = if (count _this > 1) then {_this select 1} else {["CfgAmmo","CfgMagazines","CfgVehicles","CfgWeapons"]};
_results = [];

{
	_l = configFile >> _x;
	for "_i" from 0 to ((count _l) - 1) do {
		private "_name";
		_name = configName (_l select _i);
		if ([tolower _name, _string] call CBA_fnc_find != -1) then {
			_results set [count _results, _name];
		};
	};
} foreach _types;

_results