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
	//Tips unique to this mission.
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf0_0", localize "STR_EP1_InitMission.sqf1_0"]];

	//Common tips for ALL WF missions (can localize once).
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf2_0", localize "STR_EP1_InitMission.sqf3_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf4_0", localize "STR_EP1_InitMission.sqf5_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf6_0", localize "STR_EP1_InitMission.sqf7_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf8_0", localize "STR_EP1_InitMission.sqf9_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf10_0", localize "STR_EP1_InitMission.sqf11_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf12_0", localize "STR_EP1_InitMission.sqf13_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf14_0", localize "STR_EP1_InitMission.sqf15_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf16_0", localize "STR_EP1_InitMission.sqf17_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf18", localize "STR_EP1_InitMission.sqf19"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf20", localize "STR_EP1_InitMission.sqf21"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf22", localize "STR_EP1_InitMission.sqf23"]];

	//Mission description.
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf24", localize "STR_EP1_InitMission.sqf25"]];
};

//*****************************************************************************************
//1/17/7 MM - Created file.
