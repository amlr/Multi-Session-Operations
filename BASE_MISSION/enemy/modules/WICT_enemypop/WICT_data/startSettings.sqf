/*
__          __        _     _   _          _____             __ _ _      _     _______          _ 
\ \        / /       | |   | | (_)        / ____|           / _| (_)    | |   |__   __|        | |
 \ \  /\  / /__  _ __| | __| |  _ _ __   | |     ___  _ __ | |_| |_  ___| |_     | | ___   ___ | |
  \ \/  \/ / _ \| '__| |/ _` | | | '_ \  | |    / _ \| '_ \|  _| | |/ __| __|    | |/ _ \ / _ \| |
   \  /\  / (_) | |  | | (_| | | | | | | | |___| (_) | | | | | | | | (__| |_     | | (_) | (_) | |
    \/  \/ \___/|_|  |_|\__,_| |_|_| |_|  \_____\___/|_| |_|_| |_|_|\___|\__|    |_|\___/ \___/|_|

  ,---.                     ,---.  ,--.,--.,--.            ,--.,--.      
 /  O  \ ,--.--.,--,--,--. /  O  \ |  ||  ||  ,---.  ,---. |  |`--' ,---.
|  .-.  ||  .--'|        ||  .-.  ||  ||  ||  .-.  || .-. ||  |,--.| .--'
|  | |  ||  |   |  |  |  ||  | |  ||  ||  ||  | |  |' '-' '|  ||  |\ `--.
`--' `--'`--'   `--`--`--'`--' `--'`--'`--'`--' `--' `---' `--'`--' `---'
*/

if (isServer) then
{
	/* This is a place for user defined settings that WICT loads at the beginning. */

	/* Limit in the main loop in the AutoFlag function =  maximum number of the bases of ANY TYPE */
	WICT_flagLoopLimit = 999;
	
	/* Auto Flag function.
	Parameter(s):
		1: base type (any string you want : "base1","base2","infantry","lightVehicles","tanks" etc.)
		2: radius of the trigger
		3: trigger timeout in form [min, mid, max]
	Note this for multiplayer: 
	Trigger will only be present on the machine(s) this command is run = server! */
	_null = ["regInfantry",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	_null = ["specInfantry",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	_null = ["lightVehicles",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	_null = ["mediumVehicles",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	_null = ["mediumArmor",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	_null = ["heavyArmor",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	_null = ["airCavalry",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	_null = ["allClasses",30,[15,20,30]] execVM (WICT_PATH + "WICT\autoFlag.sqf");
	
	
	/* Here you can set how long one turn lasts. 
	I suggest you to read the manual first and then decide will you change these values. 
	There are other ways for changing spawning frequency. */
	WICT_time = 2.5;
	WICT_timeRand = 5;

	/* Do not change spawning distance if you are not sure what you are doing. 
	The upper limit is WICT_scandist. Although there is no lower limit except 0, 
	decreasing spawning distance is only for zombie mode ;) */
	//WICT_sd = 800;

	if(isNil "wict_scandistance")then{wict_scandistance = 1};
		WICT_sd = switch(wict_scandistance) do {
			case 0: {
				300;
			};
			case 1: {
				400;
			};
			case 2: {
				700;
			};
			case 3: {
				1000;
			};
	};


	WICT_sdRand = 1000;
	/* Additionally you can set up fixed displacement for aircrafts that will increase spawn distance. */
	WICT_displace = 900;

	/* This is scan distance for searching nearest bases. Bases further than this distance won't be considered during 
	searching and tactical planning.
	Default value is 1km.
	Scan distance for neutral sectors will be WICT_scandist + 500m. 
	Note that base won't be consider either if you are closer than spawning distance limit WICT_sd. 
	In other words base will be active if:
		1) it is nearest
		2) it is further than WICT_sd
		3) it is closer than WICT_scandist */
	//WICT_scandist = 1500;

	if(isNil "wict_scandistance")then{wict_scandistance = 1};
		WICT_scandist = switch(wict_scandistance) do {
			case 0: {
				1000;
			};
			case 1: {
				1500;
			};
			case 2: {
				3000;
			};
			case 3: {
				15000;
			};
	};

	
	/* Let's remove some "far, far away" units (in meters) */
	WICT_removeMan = 20000;
	/* Let's remove some "far, far away" vehicles (in meters) */
	WICT_removeVehicle = 20000;
	/* Remove body (in seconds) */
	WICT_removeBody = 600;

	/* Here you can set number of AI groups - please read the manual before setting this. */
	//WICT_numAIg = 100;
	
	if(isNil "wict_ai_groups")then{wict_ai_groups = 2};
		WICT_numAIg = switch(wict_ai_groups) do {
			case 0: {
				55;
			};
			case 1: {
				80;
			};
			case 2: {
				100;
			};
			case 3: {
				120;
			};
	};

	/* Here you can set Anti-Jam -- again read the manual */
	WICT_jam = WICT_numAIg + 20;

	/* This is debug mode:
	Show from which base spawning process took place and show spawning marker as "warning" sign
	-- this debug yes/no is required for core files. */
	//WICT_debug = "yes";

	if(isNil "wict_debugmodule")then{wict_debugmodule = 0};
	WICT_debug = 	switch(wict_debugmodule) do {
					case 0: {
						"no";
					};
					case 1: {
						"yes";
					};
					case 2: {
						"no";
					};
			};

	
	
/*
oooooo   oooooo     oooo ooooo   .oooooo.   ooooooooooooo                                   oooo 
 `888.    `888.     .8'  `888'  d8P'  `Y8b  8'   888   `8                                   `888 
  `888.   .8888.   .8'    888  888               888         oo.ooooo.   .ooooo.   .ooooo.   888 
   `888  .8'`888. .8'     888  888               888          888' `88b d88' `88b d88' `88b  888 
    `888.8'  `888.8'      888  888               888          888   888 888   888 888   888  888 
     `888'    `888'       888  `88b    ooo       888          888   888 888   888 888   888  888 
      `8'      `8'       o888o  `Y8bood8P'      o888o         888bod8P' `Y8bod8P' `Y8bod8P' o888o
                                                              888                                
                                                             o888o                               
             _ _          ___               _     _      _           
 _   _ _ __ (_) |_ ___   ( _ )   __   _____| |__ (_) ___| | ___  ___ 
| | | | '_ \| | __/ __|  / _ \/\ \ \ / / _ \ '_ \| |/ __| |/ _ \/ __|
| |_| | | | | | |_\__ \ | (_>  <  \ V /  __/ | | | | (__| |  __/\__ \
 \__,_|_| |_|_|\__|___/  \___/\/   \_/ \___|_| |_|_|\___|_|\___||___/
                                                                     

   ___  __   __  __________  ___ 
  / _ )/ /  / / / / __/ __ \/ _ \
 / _  / /__/ /_/ / _// /_/ / , _/
/____/____/\____/_/  \____/_/|_|       
*/

	/* Regular infantry, soldiers, medics, leaders and officers */
	wict_w_inf = [
	["USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic"],
	["USMC_Soldier_TL","USMC_Soldier","USMC_Soldier_Medic","USMC_Soldier_Medic"],
	["USMC_Soldier_TL","USMC_Soldier_Medic","USMC_Soldier_Medic","USMC_Soldier_Medic"],
	["USMC_Soldier_TL","USMC_Soldier","USMC_SoldierS_Spotter","USMC_Soldier_Medic"]
	];

	/* Machinegunners and grenadiers */
	wict_w_support = [
	["USMC_Soldier_TL","USMC_Soldier_MG","USMC_Soldier_GL","USMC_Soldier_AR"]
	];

	/* Snipers */
	wict_w_snip = [
	["USMC_SoldierS_Spotter","USMC_SoldierS_Sniper"]
	]; 

	/* Marksmen and spotters (SpecOp) */
	wict_w_spec = [
	["USMC_Soldier_TL","USMC_Soldier_AR","USMC_SoldierS_Spotter","USMC_SoldierM_Marksman"]
	];

	/* AT units */
	wict_w_at = [
	["USMC_Soldier_TL","USMC_Soldier_AT","USMC_Soldier_HAT","USMC_Soldier_AT"]
	];

	/* Jeeps and light vehicles -- the first element is ARRAY with vehicle(s) */
	wict_w_lightveh = [
	[["HMMWV_M2"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic"],
	[["HMMWV_Armored"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic"],
	[["HMMWV_MK19"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic"],
	[["HMMWV_TOW"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic","USMC_Soldier_Medic"]
	];

	/* Transport -- the first element is ARRAY with vehicle(s) */
	wict_w_trans = [
	[["MTVR"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic","USMC_Soldier_TL","USMC_Soldier_AT","USMC_Soldier_HAT","USMC_SoldierM_Marksman","USMC_Soldier_AA","USMC_SoldierS_Spotter","USMC_SoldierS_Sniper","USMC_Soldier_AR"],
	[["UH1Y"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic","USMC_Soldier_TL","USMC_SoldierM_Marksman","USMC_Soldier_HAT","USMC_Soldier_AT"],
	[["HMMWV_M2","HMMWV"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic","USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic"],
	[["HMMWV_Armored","HMMWV"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier_Medic","USMC_Soldier_Medic","USMC_Soldier_Medic","USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic"],
	[["HMMWV_M2","HMMWV"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic","USMC_Soldier_Medic","USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier_Medic"]
	];

	/* Infantry fighting vehicles -- the first element is ARRAY with vehicle(s) */
	wict_w_ifv = [
	[["BMP2_CDF"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier","USMC_Soldier_AT","USMC_Soldier_Medic"]
	];

	/* Medium and light tanks -- the first element is ARRAY with vehicle(s) */
	wict_w_mtank = [
	[["T34"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier"]
	];

	/* Heavy tanks -- the first element is ARRAY with vehicle(s) */
	wict_w_htank = [
	[["M1A1"],"USMC_Soldier_TL","USMC_Soldier","USMC_Soldier"]
	];

	/* Medium and light choppers -- the first element is ARRAY with vehicle(s) */
	wict_w_mchop = [
	[["AH1Z"],"USMC_Soldier_Pilot","USMC_Soldier_Crew"]
	];

	/* Heavy choppers -- the first element is ARRAY with vehicle(s) */
	wict_w_hchop = [
	[["AH64D"],"USMC_Soldier_Pilot","USMC_Soldier_Crew"]
	];
	
	/* Airplanes -- the first element is ARRAY with vehicle(s) */
	wict_w_air = [
	[["F35B"],"USMC_Soldier_Pilot"]
	];

/*
  ____  ___  ________  ___ 
 / __ \/ _ \/ __/ __ \/ _ \
/ /_/ / ___/ _// /_/ / , _/
\____/_/  /_/  \____/_/|_| 
*/

        //getting factions from MSO_FACTIONS and load the specific faction-class-file
	_WICT_FACTION_ACQUIRED = false;

	if (("IRAN" in MSO_FACTIONS) && !(_WICT_FACTION_ACQUIRED)) then {
			call compile preprocessfilelinenumbers (WICT_PATH + "WICT_data\IRAN.hpp");
			sleep 0.5; 
			_WICT_FACTION_ACQUIRED = true;
	};
	
	if (("BIS_TK" in MSO_FACTIONS) && !(_WICT_FACTION_ACQUIRED)) then {
			call compile preprocessfilelinenumbers (WICT_PATH + "WICT_data\BIS_TK.hpp");
			 sleep 0.5;
			 _WICT_FACTION_ACQUIRED = true;
	};	
	
	
	if (("RU" in MSO_FACTIONS) && !(_WICT_FACTION_ACQUIRED)) then {
			call compile preprocessfilelinenumbers (WICT_PATH + "WICT_data\RU_INS.hpp");
			sleep 0.5;
			_WICT_FACTION_ACQUIRED = true;
	};

	if (("BIS_TK_GUE" in MSO_FACTIONS) && !(_WICT_FACTION_ACQUIRED)) then {
			call compile preprocessfilelinenumbers (WICT_PATH + "WICT_data\BIS_TK.hpp");
			sleep 0.5; 
			_WICT_FACTION_ACQUIRED = true;
	};

	if (("GUE" in MSO_FACTIONS) && !(_WICT_FACTION_ACQUIRED)) then {
			call compile preprocessfilelinenumbers (WICT_PATH + "WICT_data\GUE.hpp");
			sleep 0.5; 
			_WICT_FACTION_ACQUIRED = true;
	};


	if !(_WICT_FACTION_ACQUIRED) then {call compile preprocessfilelinenumbers (WICT_PATH + "WICT_data\RU_INS.hpp"); sleep 0.5; _WICT_FACTION_ACQUIRED = true;};
};