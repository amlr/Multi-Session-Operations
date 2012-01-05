if (isServer) then
{
	/* "Initialize and format" array */
	private ["_team"];
	
	/* Check if there are multiple variants and select random if there is */
	if (count wict_w_mtank > 1) then 
	{
		_team = wict_w_mtank call BIS_fnc_selectRandom;
	}
	else
	{
		_team = wict_w_mtank select 0;
	};
	
	/* Now execute master_Class_Spawn function */
	["west",_team,"ground","vehiclesW"] call fnct_masterClassSpawn;
};