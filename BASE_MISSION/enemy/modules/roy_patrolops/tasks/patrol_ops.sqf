mps_loc_towns = [];
mps_loc_hills = [];
mps_loc_airports = [];
mps_loc_viewpoints = [];
mps_loc_passes = [];
mps_mission_score = 0;

//_locations = nearestLocations [[0,0],["Name","NameLocal","NameVillage","NameCity","NameCityCapital","Hill","Airport","ViewPoint"],30000];

{	if( position _x distance getMarkerPos format["respawn_%1",(SIDE_A select 0)] > 1500 ) then {
		switch (type _x) do {
			case "Name": {mps_loc_passes = mps_loc_passes + [_x];};
			case "NameLocal": {mps_loc_passes = mps_loc_passes + [_x];};
			case "NameVillage": {mps_loc_towns = mps_loc_towns + [_x];};
			case "NameCity": {mps_loc_towns = mps_loc_towns + [_x];};
			case "NameCityCapital": {mps_loc_towns = mps_loc_towns + [_x];};
			case "Hill": {mps_loc_hills = mps_loc_hills + [_x];};
			case "Airport": {mps_loc_airports = mps_loc_airports + [_x];};
			case "ViewPoint": {mps_loc_viewpoints = mps_loc_viewpoints + [_x];};
		};
	};
} foreach CRB_LOCS;

if(count mps_loc_hills > 0) then {
	_location = (mps_loc_hills call mps_getRandomElement);
	mps_loc_hills = mps_loc_hills - [_location];
	[_location] spawn CREATE_OPFOR_AIRPATROLS;
};

mps_loc_last = mps_loc_towns select 0;

_list = switch (MISSIONTYPE) do {
	// Capture
	case 0: {["CAP_target","CAP_target_2","CAP_town","CAP_vehicle","SAD_bombcar"]};
	// Town Capture
    case 1: {["CAP_town"]};
	// RTF Tasks
	case 2: {["CAP_target","SAD_cache_2","SAD_camp","SAD_chemical","SAD_depot","SAD_radar","RTF_tower","SAD_bombcar"]};
	// Search and Rescue
	case 3: {["SAR_pilot","SAR_pow"]};
	// Mix Easy
	case 4: {["CAP_target","CAP_town","CAP_vehicle","SAD_cache","SAD_camp","SAD_chemical","SAD_depot","SAD_radar","SAD_scud","SAD_tower","SAR_pilot","SAD_bombcar"]};
	// Mix Hard
	case 5: {["CAP_target_2","CAP_town","CAP_vehicle","RTF_tower","SAD_cache_2","SAD_camp","SAD_chemical","SAD_depot","SAD_radar","SAD_scud","SAD_tower","SAR_pow","SAD_bombcar"]};

	default {["CAP_target","CAP_target_2","CAP_town","CAP_vehicle","RTF_tower","SAD_cache","SAD_cache_2","SAD_camp","SAD_chemical","SAD_depot","SAD_radar","SAD_scud","SAR_pilot","SAR_pow","SAD_bombcar"]};
};

for "_i" from 1 to MISSIONCOUNT do {
	
    //reset Check-In for everyone and remove action from MHQ again to be sure it's not doubled!
    PO2_assigned = false;
    Publicvariable "PO2_assigned";
    runningmission = false;
    Publicvariable "runningmission";
    
    [0,[],{
        HQ removeaction HQaction;
    }] call mso_core_fnc_ExMP;
    
    MPS_TASKCHECKIN = false;
    Publicvariable "MPS_TASKCHECKIN";
    
    //Add action again
    [0,[],{
	    HQaction = HQ addaction ["Check in for special operations", PO_Path + "tasks\checkin_mhq.sqf"];
    }] call mso_core_fnc_ExMP;
    
    //wait for a player to check in
    waitUntil{sleep 1;MPS_TASKCHECKIN};
    
    [0,[],{
        HQ removeaction HQaction;
    }] call mso_core_fnc_ExMP;
       
    //let mission-setup begin    
    sleep 10;
    

    [0,[],{
	    HQaction = HQ addaction ["Abort operation", PO_Path + "tasks\abort.sqf"];
    }] call mso_core_fnc_ExMP;

	_j = (count _list - 1) min (round random (count _list));
	_next = _list select _j;

	mps_mission_status = 1;
	_script = [] execVM format[PO_Path + "tasks\types\%1.sqf",_next];
	if (mps_debug) then {diag_log format ["MSO-%1 PO2: Launching %2 mission", time, _next];};
	runningmission = true;
    Publicvariable "runningmission";
	while {!(scriptdone _script)} do {sleep 1};
	if (mps_debug) then {diag_log format ["MSO-%1 PO2: %2 mission finished.", time, _next];};
	
	switch (mps_mission_status) do {
		case 2 : {mps_mission_score = mps_mission_score + 1;};
		case 3 : {mps_mission_score = mps_mission_score - 1;};
		default {_i = _i - 1};
	};
	mps_mission_status = 0;
	publicvariable "mps_mission_score";
    sleep 10;
};