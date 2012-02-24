//Last modified 10/13/10
//*****************************************************************************************
//Description: Call all common init scripts.
//Copy any data from Warfare2.pbo's Init_Common.sqf that you want to change here.
//*****************************************************************************************

//Factions that side controls (buildings & defenses of this faction will be available).
//Can use multiple factions. For example West could be USMC and CDF.
BIS_WF_Common SetVariable ["westFactions",[Localize "STR_FN_CDF"]];
BIS_WF_Common SetVariable ["eastFactions",[Localize "STR_FN_INS"]];
BIS_WF_Common SetVariable ["resistanceFactions",[Localize "STR_FN_GUE"]];

BIS_WF_Common SetVariable ["EastHQIdentity","WFHQ_CZ"];

WSOLDIER = "CDF_Soldier";
WMEDIC = "CDF_Soldier_Medic";
WCREW = "CDF_Soldier_Crew";
WPILOT = "CDF_Soldier_Pilot";

ESOLDIER = "Ins_Soldier_1";
EMEDIC = "INS_Soldier_Medic";
ECREW = "INS_Soldier_Crew";
EPILOT = "INS_Soldier_Pilot";

VGWSOLDIER = WSOLDIER;
VGESOLDIER = ESOLDIER;
VGGSOLDIER = GSOLDIER;

WREPAIRTRUCK = "UralRepair_CDF";
WSALVAGETRUCK = "WarfareSalvageTruck_CDF";
WSUPPLYTRUCK = "WarfareSupplyTruck_CDF";
WAMMOTRUCK = "WarfareReammoTruck_CDF";
WFUELTRUCK = "UralRefuel_CDF";

EREPAIRTRUCK = "UralRepair_INS";
ESALVAGETRUCK = "WarfareSalvageTruck_INS";
ESUPPLYTRUCK = "WarfareSupplyTruck_INS";
EAMMOTRUCK = "WarfareReammoTruck_INS";
EFUELTRUCK = "UralRefuel_INS";

BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORLIGHT",10];
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORMEDIUM",25];
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORHEAVY",35]; //no city will have heavy in civil war
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESPERGARRISON",5];

BIS_WF_Constants SetVariable["OPPOSITIONMULTIPLIER",2];

[] Call Compile PreprocessFile "enemy\modules\bis_warfare\Config_Loadouts.sqf";
[] Call Compile PreprocessFile "enemy\modules\bis_warfare\Config_Structures.sqf";

//*****************************************************************************************
//1/18/7 MM - Created file.
