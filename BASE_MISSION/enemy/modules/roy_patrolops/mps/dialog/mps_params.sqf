//class Params {
    class PO2_ON {
        title = "Enemy - OCB Patrol Ops 2"; 
        values[]= {1, 0}; 
        texts[]= {"On","Off"}; 
        default = 0;
	};
	class MISSIONTYPE { // MISSION TYPE
		title=$STR_DESC_OPT2;
		values[]={0,1,2,3,4,5};
		default=2;
		texts[]={"Target Capture","Domination","Reconstruction","Search and Rescue","Mix Standard","Mix Hard"};
	};
	class MISSIONCOUNT { // MISSION COUNT
		title=$STR_DESC_OPT3;
		values[]={1,3,5,7,9,15,20};
		default=5;
		texts[]={"1","3","5","7","9","15","20"};
	};
    class PO2_EFACTION { // ENEMY FACTION
	title="Enemy Faction";
	values[]={0,1,2,3,4,5};
	default=0;
	texts[]={"Takistani Army","Takistani Guerillas","Russia","CWR2 RU","CWR2 FIA","Tigerianne"};
	};
    class PO2_IFACTION { // INS FACTION
	title="Insurgents Faction";
	values[]={0,1};
	default=0;
	texts[]={"Takistani Insurgents","European Insurgents"};
	};
	class ACEWOUNDENBLE { // PLAYER IF ACE THEN USE ACE WOUNDS
		title=$STR_DESC_OPT14;
		values[]={0,1};
		default=0;
		texts[]={"Off","On"};
	};
	class MISSIONDIFF { // MISSION Difficulty
		title=$STR_DESC_OPT8;
		values[]={1,2,3,4};
		default=1;
		texts[]={"Easy","Medium","Hard","Experienced"};
	};
	class AMBIECOUNT { // Ambient IED COUNT
		title=$STR_DESC_OPT9;
		values[]={0,10,30,60};
		default=30;
		texts[]={"Off","Rare","Possible","Likely"};
	};
	class AMBAIRPARTOLS { // AMBiENT Air Patrols
		title=$STR_DESC_OPT17;
		values[]={0,1};
		default=0;
		texts[]={"Off","On"};
	};
//};