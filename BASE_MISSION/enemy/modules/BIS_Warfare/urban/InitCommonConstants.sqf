//Last modified 1/6/10
//*****************************************************************************************
//Description: Initialize any constants.
//*****************************************************************************************

//Time from game start to allow faster construction of units.
BIS_WF_Constants SetVariable ["ACCELERATEDBUILDTIME",300];

//Amount of normal build time during accelerated building.
BIS_WF_Constants SetVariable ["ACCELERATEDBUILDTIMERATIO",0.4];

//Min required distance between each side at game start.
BIS_WF_Constants SetVariable ["SIDESTARTINGDISTANCE",250];

//Max distance between starting location & nearest town.
//Not used when all towns on map are enabled.
BIS_WF_Constants SetVariable ["STARTINGLOCATIONMAXTOWNDISTANCE",0];

//Time without any activity before town defenses inactivate.
//For garrisons and extended VG patrols refer to VGINACTIVETIME.
BIS_WF_Constants SetVariable["TOWNPATROLINACTIVETIME",150];

//Time until a town's defenses can rebuild.
BIS_WF_Constants SetVariable["TOWNPATROLREINFORCETIME",420];

//If true, town defenses are also spawned when friendlies are in area.
//Set false to only spawn during enemy activity for better performance (less units on the map).
BIS_WF_Constants SetVariable["ALWAYSSPAWNTOWNDEFENSES",true];

//Amount of teams per patrol type for a non-playable side's town.
//In most game-types this would be the neutral resistance towns & this would apply to the amount of
//forces that would be encountered when attacking these towns.
//Example 2 light, 2 medium, and 2 heavy patrols available.
BIS_WF_Constants SetVariable["OPPOSITIONMULTIPLIER",1];

//Amount of supplies required for light, medium, or heavy patrols.
//Patrols are cumulative. For example, if there is enough for a medium patrol, a light patrol also exists.
BIS_WF_Constants SetVariable["TOWNSUPPLIESFORPATROL",60];
BIS_WF_Constants SetVariable["TOWNSUPPLIESFORLIGHT",20];
BIS_WF_Constants SetVariable["TOWNSUPPLIESFORMEDIUM",30];
BIS_WF_Constants SetVariable["TOWNSUPPLIESFORHEAVY",60];
BIS_WF_Constants SetVariable["TOWNSUPPLIESFORGARRISON",5];

//Amount of supplies required non-playable side's light, medium, or heavy patrols.
//In most game-types this would be the neutral resistance towns.
//For example, a town starting with 20 supplies would have light and medium patrols defending it.
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORPATROL",30];
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORLIGHT",20];
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORMEDIUM",30];
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORHEAVY",40];
BIS_WF_Constants SetVariable["OPPOSITIONTOWNSUPPLIESFORGARRISON",5];

//Maximum rate that all captured camps can increase town capture speed (for example 5 times as fast).
BIS_WF_Constants SetVariable["MAXCAMPCAPTURERATE",5.0];

//Rate modifier for capturing towns.  Higher values means quicker captures.
BIS_WF_Constants SetVariable["TOWNCAPTURERATE",1.25];

//Fog of War time (time until visibility expires).
BIS_WF_Constants SetVariable["FOWTIME",60];

//Scores
BIS_WF_Constants SetVariable["SCORECAPTURECAMP",2];
BIS_WF_Constants SetVariable["SCOREASSISTCAPTURETOWN",2];
BIS_WF_Constants SetVariable["SCORECAPTURETOWN",5];
BIS_WF_Constants SetVariable["SCOREAIDESTROYVEHICLE",1];
BIS_WF_Constants SetVariable["SCORESTAYALIVE",2];

BIS_WF_Constants SetVariable["SCOREMISSIONCAPTURECAMP",3];
BIS_WF_Constants SetVariable["SCOREMISSIONASSISTCAPTURETOWN",3];
BIS_WF_Constants SetVariable["SCOREMISSIONCAPTURETOWN",8];

//Bounties
BIS_WF_Constants SetVariable["BOUNTYMODIFIER",0.25];
BIS_WF_Constants SetVariable["SUBORDINATEBOUNTYMODIFIER",0.125];

BIS_WF_Constants SetVariable["CAMPCAPTUREBOUNTY",100];
BIS_WF_Constants SetVariable["TOWNASSISTCAPTUREBOUNTY",250];
BIS_WF_Constants SetVariable["TOWNCAPTUREBOUNTY",500];

BIS_WF_Constants SetVariable["CAMPCAPTUREMISSIONBOUNTY",150];
BIS_WF_Constants SetVariable["TOWNASSISTCAPTUREMISSIONBOUNTY",375];
BIS_WF_Constants SetVariable["TOWNCAPTUREMISSIONBOUNTY",750];

//Modifier of town range in which a player is notified of capture progress and considered to be assisting.
BIS_WF_Constants SetVariable["TOWNCAPTUREASSISTRANGEMODIFIER",0.6];

//Time between for each town defense construction cycle.
BIS_WF_Constants SetVariable["TOWNCONSTRUCTIONTIME",90];

//Minimum distance HQ must be from a town to deploy.
BIS_WF_Constants SetVariable["MINBASEFROMTOWNRANGE",25];

//Range at which an enemy base structure can be detected by enemy.
BIS_WF_Constants SetVariable["BASEDETECTIONRANGE",300];

//Range at which a base structure must be for a player to be able to use it.
BIS_WF_Constants SetVariable["BASERANGE",150];

//Range from base that AI teams will check to capture towns. When out of this range they will capture nearest hostile town.
BIS_WF_Constants SetVariable["CAPTUREFROMBASERANGE",300];

//Max amount a location can increase in value from supply trucks.
BIS_WF_Constants SetVariable["SUPPLYINCREASE",5];

//Income earned per point of supply at a town.
BIS_WF_Constants SetVariable["INCOMEPERSUPPLYPOINT",2];

BIS_WF_Constants SetVariable["MAXTEAMSIZE",13];	//Slightly higher than players to allow a transport.

//*****************************************************************************************
//1/19/7 MM - Created file.
