scriptName "InitMission.sqf";

//Last modified 4/30/10
//*****************************************************************************************
//Description: This is called before the WF core initialization starts.
//Note that you cannot set values like VOTETIME because core init will overwrite them.
//Set those values in a custom Init_Common.sqf.
//*****************************************************************************************
//Script for setting WF init values before init begins (this script). Put in init field of Warfare logic in editor.
//BIS_WF_Common SetVariable ["customInitMissionScript","InitMission.sqf"];

BIS_WF_Common SetVariable ["sidePlacement",[true,-1,-1]];	//Side placement, use starting logics only.
BIS_WF_Common SetVariable ["customInitClientScript",""];	//Use default core client initialization.
BIS_WF_Common SetVariable ["customInitCommonScript","enemy\modules\bis_warfare\InitCommon.sqf"];	//Run custom common init after core's. You can replace core's common scripts here, or just change values like vote time, etc. Refer to Init_Constants.sqf.
BIS_WF_Common SetVariable ["customInitServerScript",""];	//Use default core server initialization.

BIS_WF_Common SetVariable ["customInitBasesScript",""];		//Create custom base vehicles & patrols.
BIS_WF_Common SetVariable ["customBaseLayoutsScript",""];	//Custom base layouts.
BIS_WF_Common SetVariable ["customTownsScript",""];			//Custom town configurations.
BIS_WF_Common SetVariable ["customTownPath","enemy\modules\bis_warfare\Server\Config\"];

BIS_WF_UrbanWarfare = true;
BIS_WF_NoFastTravel = true;

//ToDo: Enable civs...
BIS_WF_EnableCivilians = false;

[] Spawn
{
	//Common tips for WF missions (can localize each line once).
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf0", localize "STR_EP1_InitMission.sqf1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf2", localize "STR_EP1_InitMission.sqf3"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf4", localize "STR_EP1_InitMission.sqf5"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf6", localize "STR_EP1_InitMission.sqf7"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf8", localize "STR_EP1_InitMission.sqf9"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf10", localize "STR_EP1_InitMission.sqf11"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf12", localize "STR_EP1_InitMission.sqf13"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf14", localize "STR_EP1_InitMission.sqf15"]];

	//Unique mission description.
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf16", localize "STR_EP1_InitMission.sqf17"]];
};

//*****************************************************************************************
//1/17/7 MM - Created file.
