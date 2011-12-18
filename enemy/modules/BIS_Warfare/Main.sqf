if(isNil "ambientEnvironment") then {ambientEnvironment = 1;};
	//Victory Conditions.
if(isNil "VictoryTime") then {VictoryTime = -1;};
if(isNil "VictoryScore") then {VictoryScore = -1;};
if(isNil "VictoryTowns") then {VictoryTowns = -1;};
if(isNil "CapturableTowns") then {CapturableTown = -1;};
if(isNil "FasterTime") then {FasterTime = 0;};
if(isNil "MinStartingDistance") then {MinStartingDistance = 2500;};
if(isNil "MiscSettings") then {MiscSettings = 0;};
if(isNil "NeutralOpposition") then {NeutralOpposition = 2;};
if(isNil "SideColorScheme") then {SideColorScheme = 0;};
if(isNil "StartTime") then {StartTime = -1;};
if(isNil "Support") then {Support = 4;};
if(isNil "TownSpawnRange") then {TownSpawnRange = 0;};
if(isNil "TownSpawnTime") then {TownSpawnTime = 0;};
if(isNil "GameMode") then {GameMode = 1;};
if(isNil "LimitedWarfare") then {LimitedWarfare = 1;};

BIS_Warfare_completed = true;