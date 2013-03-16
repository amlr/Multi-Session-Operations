//Last modified 3/31/10
//*****************************************************************************************
//Description: Sets mission parameters.

BIS_WF_MissionDefaultSide = Civilian;
BIS_WF_Constants SetVariable["EASTSTARTINGTOWNSRATIO",0.2];
BIS_WF_Constants SetVariable["WESTSTARTINGTOWNSRATIO",0.2];
BIS_WF_Constants SetVariable["RESISTANCESTARTINGTOWNSRATIO",0.3];

//[] Call Compile PreprocessFile "ConfigStructures.sqf";

["Costs",{Round (_this * 0.8)},Resistance,"Barracks"] Call BIS_WF_ModifyAllUnitData;
["Costs",{Round (_this - 50)},Resistance,"Light"] Call BIS_WF_ModifyAllUnitData;
["MannedCosts",{Round (_this - 50)},Resistance,"Light"] Call BIS_WF_ModifyAllUnitData;

["Costs",{Round (_this - 200)},Resistance,"Heavy"] Call BIS_WF_ModifyAllUnitData;
["MannedCosts",{Round (_this - 200)},Resistance,"Heavy"] Call BIS_WF_ModifyAllUnitData;

["Costs",{Round (_this * 1.5)},[East,West],"Aircraft"] Call BIS_WF_ModifyAllUnitData;
["MannedCosts",{Round (_this * 1.5)},[East,West],"Aircraft"] Call BIS_WF_ModifyAllUnitData;

//*****************************************************************************************
//11/20/9 MM - Created file.
