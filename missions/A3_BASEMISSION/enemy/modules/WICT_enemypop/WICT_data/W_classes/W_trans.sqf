if (isServer) then
{
	/* "Initialize and format" array */
	private ["_team"];

	/* Check if there are multiple variants and select random if there is */
	if (count wict_w_trans > 1) then 
	{
		_team = wict_w_trans call BIS_fnc_selectRandom;
	}
	else
	{
		_team = wict_w_trans select 0;
	};		

	/* Now execute master_Class_Spawn function */
	["west",_team,"heli","transportW"] call fnct_masterClassSpawn;	
};