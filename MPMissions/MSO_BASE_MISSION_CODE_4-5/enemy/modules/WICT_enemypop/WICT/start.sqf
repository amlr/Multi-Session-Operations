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

/* Just waiting for Functions and Multiplayer framework */
waituntil {!isnil "bis_fnc_init"};
waituntil {BIS_MPF_InitDone};

/* Show this text on all machines */
//titleText ["Powered by WICT v7.0d", "PLAIN"]; titleFadeOut 7;

/* Run this only on server */
if (isServer) then
{	
	/* Initialize angles for spawning process */
	WICT_angleW = 0;
	WICT_angleE = 0;

	/* Initialize spawning position -- to be recognized as format "Position" */
	WICT_spwnPos = [];
	
	/* Dice for spawning process */
	WICT_dice = 0;

	/* Known bases are "none" */
	WICT_wb = "none";
	WICT_eb = "none";
	WICT_nb = "none";
	
	/* And lists of bases are empty arrays */
	WICT_wbl = [];
	WICT_ebl = [];
	WICT_nbl = [];

	/* Initialize player's position -- to be recognized as format "Position" */
	WICT_playerPos = [];
	
	/* Load Kronzky strings */
	_null = [] execVM (WICT_PATH + "WICT\KRON_Strings.sqf");

	/* Load WICT settings */
	_null = [] execVM (WICT_PATH + "WICT_data\startSettings.sqf");
	
	/* Create variables for base configuration */
	{call compile format ["%1 = 0;",_x]} forEach ["W_reginf","W_at","W_sup","W_snip","W_spec","W_trans","W_lightveh","W_ifv","W_mtank","W_htank","W_mchop","W_hchop","W_wing","E_reginf","E_at","E_sup","E_snip","E_spec","E_trans","E_lightveh","E_ifv","E_mtank","E_htank","E_mchop","E_hchop","E_wing"];
	
	/* Pre process setup - "picker" script(s) that loads / picks current spawning configuration */
	WICT_setupW = compile preProcessFileLineNumbers (WICT_PATH + "WICT_data\setupW.sqf");
	WICT_setupE = compile preProcessFileLineNumbers (WICT_PATH + "WICT_data\setupE.sqf");
	
	/* Pre process masterClassSpawn function */
	fnct_masterClassSpawn = compile preProcessFileLineNumbers (WICT_PATH + "WICT\masterClassSpawn.sqf");
	
	/* Variable that clutches several important parts of spawning process, ensuring fluent execution */
	WICT_clutch = 0;
	
	/* Variable that contains data about flag */
	WICT_flag = ["","","",0]; publicVariable "WICT_flag";
	
	/* Making a list of executed scripts */
	WICT_exe_list = [];
	
	/* Making a list of tasks for taskCreator */
	WICT_tasks_list = [];

	/* Starting WICT controller */
	_null = [] spawn {_null = [] execVM (WICT_PATH + "WICT\controller.sqf")};

	/* Starting the flag script that monitors flag changes */
	_null = [] spawn {_null = [] execVM (WICT_PATH + "WICT\flag.sqf")};	
	
	/* Initializing show me script by zapat */
	_null = [] spawn {_null = [] execVM (WICT_PATH + "WICT\show_them.sqf")};	
	
	/* Initializing variable for reinforcements */
	WICT_reinforce_check = "none";
	
	/* Waiting for debug in order to show appropriate messages on server */
	waitUntil {!(isnil "WICT_debug")};
	
	/* Variable that signals that WICT done with initialization -- message from server to others */
	WICT_init = true; publicVariable "WICT_init";
	
	if (isMultiplayer) then
	{
		if (WICT_debug == "yes") then
		{
			cutText ["WICT v7.0d MP Server initialized successfully", "PLAIN DOWN"]; titleFadeOut 10;
		};
	}
	else
	{
		if (WICT_debug == "yes") then
		{
			cutText ["WICT v7.0d SP initialized successfully", "PLAIN DOWN"]; titleFadeOut 10;
		};
	};
}
else
{
	/* Waiting for debug (from server) in order to show appropriate messages on client */
	waitUntil {!(isnil "WICT_debug")};
	
	if (WICT_debug == "yes") then
	{
		cutText ["WICT v7.0d MP Client initialized successfully", "PLAIN DOWN"]; titleFadeOut 10;
	};
};