class PO2_ON {
	title = "    Enemy - OCB Patrol Ops 2"; 
	values[]= {1, 0}; 
	texts[]= {"On","Off"}; 
	default = 1;
};
class MISSIONTYPE { // MISSION TYPE
	title= "        Mission Type";
	values[]={0,1,2,3,4,5,6};
	default=4;
	texts[]={"Target Capture","Domination","Reconstruction","Search and Rescue","Mix Standard","Mix Hard","Air Only"};
};
class MISSIONCOUNT { // MISSION COUNT
	title="        Number of Missions";
	values[]={1,3,5,7,9,15,20};
	default=9;
	texts[]={"1","3","5","7","9","15","20"};
};
class PO2_EFACTION { // ENEMY FACTION
	title="        Enemy Faction";
	values[]={0,1,2,3,4,5};
	default=0;
	texts[]={"Takistani Army","Takistani Guerillas","Russia","CWR2 RU","CWR2 FIA","Tigerianne"};
};
class PO2_IFACTION { // INS FACTION
	title="        Insurgents Faction";
	values[]={0,1};
	default=0;
	texts[]={"Takistani Insurgents","European Insurgents"};
};
class MISSIONDIFF { // MISSION Difficulty
	title="        Difficulty";
	values[]={1,2,3,4};
	default=2;
	texts[]={"Easy","Medium","Hard","Experienced"};
};
class AMBAIRPARTOLS { // AMBiENT Air Patrols
	title="        Ambient Air Patrols";
	values[]={0,1};
	default=0;
	texts[]={"Off","On"};
};

