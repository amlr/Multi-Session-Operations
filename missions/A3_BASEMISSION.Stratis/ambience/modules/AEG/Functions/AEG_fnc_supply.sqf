	/*
		File: AEG_fnc_supply.sqf
		Version: 0.90
		Author: Loyalguard

		Description:
		A function to adjust the supply of power flowing into nodes when power in a node that is connected to it changes.

		Parameters:
		_this select 0:  Whether or not power is on or off (boolean).
		_this select 1: An array of connected objects (array).
		
		Execution:
		Loaded into memory in AEG_server.sqf.  Spawned by AEG_monitor.sqf if the node supplies power to other nodes.
	*/

AEG_fnc_supply = 
{
	// Scope //
	private ["_bool", "_supplies", "_node", "_inStr", "_in", "_val"];
	
	// Parameter(s) //
	_bool = _this select 0;
	_supplies = _this select 1;
		
	if (!_bool) then
	{
		{
			_node = (_x select 0);
			_inStr = (format ["AEG_in_%1", _node]);
			_in = missionNameSpace getVariable _inStr;
			_val = (_x select 1);
					
			_in = _in - _val;
			
			missionNameSpace setVariable [_inStr, _in];
					
		} forEach _supplies;
	}
	else
	{
		{
			_node = (_x select 0);
			_inStr = (format ["AEG_in_%1", _node]);
			_in = missionNameSpace getVariable _inStr;
			_val = (_x select 1);
					
			_in = _in + _val;
			
			missionNameSpace setVariable [_inStr, _in];
			
		} forEach _supplies;
	};
};