//class Params {
	class option00 { //MISSIONTIME	Mission: Operation Time
		title=$STR_DESC_OPT0;
		values[]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
		default=6;
		texts[]={"0000H","0100H","0200H","0300H","0400H","0500H","0600H","0700H","0800H","0900H","1000H","1100H","1200H","1300H","1400H","1500H","1600H","1700H","1800H","1900H","2000H","2100H","2200H","2300H"};
	};
	class option01 { //MISSIONTYPE	Mission: Operation Type
		title=$STR_DESC_OPT1;
		values[]={0,1,2,3,4,5,99};
		default=5;
		texts[]={"Target Capture","Town Capture","Task Force Ops","Search and Rescue","General Operations","Hard Operations","All Operations"};
	};
	class option02 { //MISSIONCOUNT	Number of Operations
		title=$STR_DESC_OPT2;
		values[]={1,3,5,7,9,15,20,30,50,999};
		default=999;
		texts[]={"1","3","5","7","9","15","20","30","50","A LOT"};
	};
	class option03 { //MISSIONDIFF	Mission: Enemy Difficulty
		title=$STR_DESC_OPT3;
		values[]={1,2,3,4};
		default=3;
		texts[]={"Easy","Medium","Hard","Experienced"};
	};
	class option04 { //HALOLIMITS	Mission: Halo Limitation
		title=$STR_DESC_OPT4;
		values[]={0,0.5,1,2,3,4,5,6,7};
		default=7;
		texts[]={"None","5 mins","10 mins","20 mins","30 mins","40 mins","50 mins","60 mins","Unavailable"};
	};
	class option05 { //DEATHCOUNT	Mission: Casualty Limitation
		title=$STR_DESC_OPT5;
		values[]={1,4,8,16,32,999};
		default=999;
		texts[]={"No Deaths Permitted","Limited Casualties","Few Casualties","Expected Casualties","Many Casualties","Plenty more where they came from"};
	};
	class option06 { //AIRDROPSENBLE	Mission: Player Airdrop Ability
		title=$STR_DESC_OPT6;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option07 { //LIFTCHPRENBLE	Mission: Lift Chopper
		title=$STR_DESC_OPT7;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option08 { //RECRUITENBLE	Mission: Enable Recruitable AI
		title=$STR_DESC_OPT8;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option09 { //INJURYFACTOR	Player: Injury Tolerance
		title=$STR_DESC_OPT9;
		values[]={0,2,4,6,8};
		default=4;
		texts[]={"Off","Low","Normal","High","Very High"};
	};
	class option10 { //RESTRICTCAM	Player: Restrict 3rd Person
		title=$STR_DESC_OPT10;
		values[]={0,1,2};
		default=0;
		texts[]={"Off","Drivers Only","No 3rd Person"};
	};
	class option11 { //VEHCLASSLIMIT	Player: Limitation of Class
		title=$STR_DESC_OPT11;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option13 { //RANKSYSENBLE	Player: Ranking System
		title=$STR_DESC_OPT13;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option14 { // Gear Restriction by RANK
		title=$STR_DESC_OPT14;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option15 { //AMBIECOUNT	Ambient: Roadside IED Potential
		title=$STR_DESC_OPT15;
		values[]={0,10,30,60};
		default=0;
		texts[]={"Off","Rare","Possible","Likely"};
	};
	class option16 { //AMBCIVILLIAN	Ambient: Civilians
		title=$STR_DESC_OPT16;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option17 { //AMBINSURGENTS	Ambient: Insurgents
		title=$STR_DESC_OPT17;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
	class option18 { //AMBAIRPARTOLS	Ambient: Air Patrols
		title=$STR_DESC_OPT18;
		values[]={0,1};
		default=0;
		texts[]={"Disabled","Enabled"};
	};
//};