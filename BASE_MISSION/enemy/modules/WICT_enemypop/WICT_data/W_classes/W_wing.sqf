if (isServer) then
{
	/* "Initialize and format" array */
	private ["_team"];
	
	/* Check if there are multiple variants and select random if there is */
	if (count wict_w_air > 1) then 
	{
		_team = wict_w_air call BIS_fnc_selectRandom;
	}
	else
	{
		_team = wict_w_air select 0;
	};
	
	/* Now execute master_Class_Spawn function */
	["west",_team,"winged","airW"] call fnct_masterClassSpawn;
};