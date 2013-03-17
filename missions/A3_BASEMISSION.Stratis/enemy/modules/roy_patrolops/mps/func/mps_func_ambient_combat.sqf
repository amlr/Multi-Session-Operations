//Written by Dash

if(mps_ambient_insurgents) then
{

 
	//ACM_INS settings
   
		waitUntil {!isNil {BIS_ACM getVariable "initDone"}};
		waitUntil {BIS_ACM getVariable "initDone"};
		[] spawn 
		{
			waitUntil {!(isnil "BIS_fnc_init")};
			[0.2, BIS_ACM] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM, 400, 500] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to, 400m being the minimal distance and 700m being the maximum. Minimum is 1 I believe.

			[["RU"], BIS_ACM] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn. In this case it will spawn Takistani Insurgents
			[0.1, 0.3, BIS_ACM] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.8, 0.9, BIS_ACM] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 1, BIS_ACM] call BIS_ACM_setTypeChanceFunc; //If you want ground patrols then leave it as a 1, if you don't put a 0. They will use random paths
			["air_patrol", 0, BIS_ACM] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
			[BIS_ACM, ["RU_InfSquad","RU_InfSection","RU_InfSection_MG","RU_SniperTeam","RUS_ReconTeam","MVD_AssaultTeam","RU_MotInfSquad"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 
		};
 
} else {

 
	//ACM_INS settings
   
		waitUntil {!isNil {BIS_ACM getVariable "initDone"}};
		waitUntil {BIS_ACM getVariable "initDone"};
		[] spawn 
		{
			waitUntil {!(isnil "BIS_fnc_init")};
			[0.0, BIS_ACM] call BIS_ACM_setIntensityFunc;                 //Sets the intensity of the ACM, in other words, determines how active it will be. Starts at 0 ends at 1.0, its been known to fail using 0.7 and 0.8
			[BIS_ACM, 10000, 20000] call BIS_ACM_setSpawnDistanceFunc;      // This is the radius on where the units will spawn around the unit the module is sync'd to, 400m being the minimal distance and 700m being the maximum. Minimum is 1 I believe.

			[["RU"], BIS_ACM] call BIS_ACM_setFactionsFunc;     // This tells the ACM which faction of units it will spawn. In this case it will spawn Takistani Insurgents
			[0.1, 0.3, BIS_ACM] call BIS_ACM_setSkillFunc;                // This determines what the skill rating for the spawned units will be
			[0.8, 0.9, BIS_ACM] call BIS_ACM_setAmmoFunc;               // This sets their amount of ammo they spawn with
			["ground_patrol", 0, BIS_ACM] call BIS_ACM_setTypeChanceFunc; //If you want ground patrols then leave it as a 1, if you don't put a 0. They will use random paths
			["air_patrol", 0, BIS_ACM] call BIS_ACM_setTypeChanceFunc;    // Same thing for air patrols
			[BIS_ACM, ["RU_InfSquad"]] call BIS_ACM_addGroupClassesFunc;   // This determines which exact units will spawn from the group **Citation needed**
 
		};

};