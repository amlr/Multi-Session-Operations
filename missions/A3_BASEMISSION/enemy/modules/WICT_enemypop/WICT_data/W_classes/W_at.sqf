if (isServer) then
{
	/* "Initialize and format" array */
	private ["_team"];
	
	/* Check if there are multiple variants and select random if there is */
	if (count wict_w_at > 1) then 
	{
		_team = wict_w_at call BIS_fnc_selectRandom;
	}
	else
	{
		_team = wict_w_at select 0;
	};
	
	/* Now execute master_Class_Spawn function */
	["west",_team,"none","infantry2W"] call fnct_masterClassSpawn;
};