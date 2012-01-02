if (isServer) then
{
	/* "Initialize and format" array */
	private ["_team"];
	
	/* Check if there are multiple variants and select random if there is */
	if (count wict_w_snip > 1) then 
	{
		_team = wict_w_snip call BIS_fnc_selectRandom;
	}
	else
	{
		_team = wict_w_snip select 0;
	};
	
	/* Now execute master_Class_Spawn function */
	["west",_team,"none","infantry2W"] call fnct_masterClassSpawn;
};