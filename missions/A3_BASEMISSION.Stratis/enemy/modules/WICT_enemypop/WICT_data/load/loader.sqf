//{}{}{}{}{}{}{}{}{} LOADER {}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
waituntil {!isnil "bis_fnc_init"};
waituntil {BIS_MPF_InitDone};


//{}{}{}{}{}{}{}{}{} LOAD DATA FROM CLIPBOARD TO SERVER {}{}{}{}{}{}{}
if(isServer) then 
{
	// put data from Clipboard before semicolumn mark (replace *** with content of Clipboard)
	// repeat process for every captured mission!!!
	// this is example of syntax >>> { _null = [_x] execVM (WICT_PATH + "WICT\sandbox\murk_spawn_loaded.sqf"); } forEach *** ;
};

//{}{}{}{}{}{}{}{}{} GIVING TASK AT BEGINNING {}{}{}{}{}{}{}{}{}{}{}{}
// Dedicated server doesn't have a player, ever!
if (!isDedicated) then 
{
	// make sure player object exists i.e. not JIP
	waitUntil {!isNull player};
	waitUntil {player == player};
	
	sleep 3;

	[nil,nil,rEXECVM,(WICT_PATH + "WICT\sandbox\sandbox_exe.sqf"),(WICT_PATH + "WICT\sandbox\"),"taskCreator","BLUFOR Base","mixedBase_1","yes","Primary: Capture the enemy bases!","Seek and destroy all enemy bases and clear the area of enemy forces!","yes","all"] call RE;
};
