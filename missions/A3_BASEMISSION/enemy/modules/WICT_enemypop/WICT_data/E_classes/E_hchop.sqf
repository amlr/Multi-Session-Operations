if (isServer) then
{
	/* "Initialize and format" array */
	_team = [];
	
	/* Check if there are multiple variants and select random if there is */
	if (count wict_e_hchop > 1) then 
	{
		_team = wict_e_hchop call BIS_fnc_selectRandom;
	}
	else
	{
		_team = wict_e_hchop select 0;
	};
	
	/* Now execute master_Class_Spawn function */
	["east",_team,"heli","airE"] call fnct_masterClassSpawn;
};