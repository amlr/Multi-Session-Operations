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
BIS_WF_Common SetVariable ["customInitCommonScript",""];	//Run custom common init after core's. You can replace core's common scripts here, or just change values like vote time, etc. Refer to Init_Constants.sqf.
BIS_WF_Common SetVariable ["customInitServerScript",""];	//Use default core server initialization.

BIS_WF_Common SetVariable ["customInitBasesScript",""];		//Create custom base vehicles & patrols.
BIS_WF_Common SetVariable ["customBaseLayoutsScript",""];	//Custom base layouts.
BIS_WF_Common SetVariable ["customTownsScript",""];			//Custom town configurations.

//ToDo: Enable civs...
BIS_WF_EnableCivilians = false;

[] Spawn
{
	//Common tips for ALL WF missions (can localize once).
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf0_1", localize "STR_EP1_InitMission.sqf1_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf2_1", localize "STR_EP1_InitMission.sqf3_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf4_1", localize "STR_EP1_InitMission.sqf5_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf6_1", localize "STR_EP1_InitMission.sqf7_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf8_1", localize "STR_EP1_InitMission.sqf9_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf10_1", localize "STR_EP1_InitMission.sqf11_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf12_1", localize "STR_EP1_InitMission.sqf13_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf14_1", localize "STR_EP1_InitMission.sqf15_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf16_1", localize "STR_EP1_InitMission.sqf17_1"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf18_0", localize "STR_EP1_InitMission.sqf19_0"]];
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf20_0", localize "STR_EP1_InitMission.sqf21_0"]];

	//Mission description.
	player CreateDiaryRecord ["Diary",[ localize "STR_EP1_InitMission.sqf22_0", localize "STR_EP1_InitMission.sqf23_0"]];
};

//*****************************************************************************************
//1/17/7 MM - Created file.
