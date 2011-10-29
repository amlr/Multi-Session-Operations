if (isServer) then
{
	/* "Initialize and format" array */
	private ["_team"];
	
	/* Check if there are multiple variants and select random if there is */
	if (count wict_w_hchop > 1) then 
	{
		_team = wict_w_hchop call BIS_fnc_selectRandom;
	}
	else
	{
		_team = wict_w_hchop select 0;
	};
	
	/* Now execute master_Class_Spawn function */
	["west",_team,"heli","airW"] call fnct_masterClassSpawn;
};