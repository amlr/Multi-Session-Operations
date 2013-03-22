
private ["_loc","_CRB_locs_tmp","_posLoc","_timeactual","_AA","_debug","_DEP_loctypes","_DEP_locs_tmp","_timenow","_dist","_CRB_locs_tmp2"];

_debug = true;
diag_log format["MSO-%1 PDB EP Population: Starting INIT...", time];

// Function to convert group into appropriate format (avoiding config > string issues)
// Set side
// Set group as [Side,Faction,GroupType,Group]
DEP_format_group = {
        private ["_grptemp"];
        _grptemp = str ((_this select 0) select 1);
        // Convert group type
        _grptemp = [_grptemp, "bin\config.bin/CfgGroups/", ""] call CBA_fnc_replace;
        _grptemp = [_grptemp, "/"] call CBA_fnc_split;
        // Check for guerrilas...
        if (_grptemp select 0 == "Guerrila") then {
                _grptemp set [0,"resistance"];
        };
        // diag_log format ["_group initialised = %1", _grptemp];
        _grptemp;
};

if (isNil "CRB_LOCS") then {
        diag_log format["MSO-%1 PDB EP Population: Calling INITLOCS...", time];
    	
					if (((rmm_locality > 0) && (isHC) && (persistentDBHeader == 1))) then {
						_hcData = format["Headless client is calling locations please wait..."];
						PDB_HEADLESS_LOADERSTATUS = [_hcData]; publicVariable "PDB_HEADLESS_LOADERSTATUS";
					};
					
					if ((rmm_locality == 0) && (persistentDBHeader == 1)) then {
						_serverData = format["Server is calling locations please wait..."];
						PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
					};
	
        CRB_LOCS = [] call mso_core_fnc_initLocations;
        diag_log format["MSO-%1 PDB EP Population: Endet INITLOCS %2...", time, count CRB_LOCS];
	
};

//Select Active locations
_DEP_loctypes = ["Hill","Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart","FlatArea", "FlatAreaCity","FlatAreaCitySmall","CityCenter","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown","ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"];
_CRB_locs_tmp = +CRB_LOCS;
_DEP_locs_tmp = [];
_DEP_ArtyIntensity = (rmm_ep_arty / 10);
_timenow = time;

diag_log format["MSO-%1 PDB EP Population: Start collecting locs from CRB_Locs (%2)...!", time, count CRB_LOCS];
					if (((rmm_locality > 0) && (isHC) && (persistentDBHeader == 1))) then {
						_hcData = format["Headless client is collecting locations please wait..."];
						PDB_HEADLESS_LOADERSTATUS = [_hcData]; publicVariable "PDB_HEADLESS_LOADERSTATUS";
					};
					
					if ((rmm_locality == 0) && (persistentDBHeader == 1)) then {
						_serverData = format["Server is collecting locations please wait..."];
						PDB_SERVER_LOADERSTATUS = [_serverData]; publicVariable "PDB_SERVER_LOADERSTATUS";
					};
		
while {count _DEP_locs_tmp < DEP_ACTIVE_LOCS && count _CRB_locs_tmp > 0} do {

        private ["_continue"];
        
        _loc = _CRB_locs_tmp call BIS_fnc_selectRandom;
        _posLoc = position _loc;
        
        //if minimum-distance fits, check for some other params and if ok then collect location
        if (
                (type _loc) in _DEP_loctypes &&
                {(_posLoc distance getmarkerpos "ammo" > rmm_ep_safe_zone)} &&
                {(_posLoc distance getmarkerpos "ammo_1" > rmm_ep_safe_zone)}
        ) then {
                _DEP_locs_tmp set [count _DEP_locs_tmp, _loc];
                if (_debug) then {diag_log format["MSO-%1 PDB EP Population: %2 at %3 selected...(%4)", time,type _loc,_posLoc,count _CRB_locs_tmp]};
                
                _CRB_locs_tmp2 = +_CRB_locs_tmp;
                //check if location is too near to an other selected location
                {
                        _dist = _posLoc distance (position _x);
                        if (_dist < DEP_LOC_DENSITY) then {
                                _CRB_locs_tmp = _CRB_locs_tmp - [_x];
                        };
                } foreach _CRB_locs_tmp2;
        } else {
                _CRB_locs_tmp = _CRB_locs_tmp - [_loc];
        };
        
        //Failsafe exit
        _timeactual = time;
        if ((_timeactual - _timenow) > 180) exitwith {diag_log format["MSO-%1 PDB EP Population: Collection didnt finish in a timely manner!", time]};
};
_CRB_locs_tmp = nil;
_DEP_loctypes = nil;
diag_log format["MSO-%1 PDB EP Population: Collected %2 locations...!", time, count _DEP_locs_tmp];

DEP_LOCS = [];
for "_i" from 0 to ((count _DEP_locs_tmp)-1) do {
        private ["_loc","_loctype","_pos","_placeholder","_grptype","_camp","_grptype2","_d","_type"];
        
        _loc = _DEP_locs_tmp select _i;
        _loctype = type _loc;
        _pos = position _loc;
        _grptype = nil;
        _AA = false;
        _RB = false;
        _Arty = false;
        _camp = false;
        
        _loctype = type _loc;
        _pos = position _loc;
        
        if ((_loctype == "Hill")) then {
                _pos = [position _loc, 0, 30, 1, 0, 5, 0] call bis_fnc_findSafePos;
                _placeholder = "Sign_Pointer_F" createvehicle _pos;
                
                _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                while {isnil "_grptype"} do {
                        _grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                };
                _grptype = [_grptype] call DEP_format_group;
                _placeholder setVariable ["groupType",[_grptype],DEP_clientside];
                
                if (random 1 < ep_campprob) then {
                        _posTMP = [position _loc,200,0.15,5] call rmm_ep_getFlatArea;
                        if (str(_posTMP) == str(position _loc)) exitwith {diag_log format["MSO-%1 PDB EP Population: Camp not created due to unsuitable location %2!", time,_posTMP];};
                        
                        _pos = _posTMP;
                        _camp = [] call mso_fnc_selectcamptype;
                        _grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _grptype2 = [_grptype2] call DEP_format_group;
                        _placeholder setVariable ["groupType", [_grptype] + [_grptype2],DEP_clientside];
                        
                        // Add AA
                        if (random 1 < 0.5) then { 
                                _AA = true;
                        };
                        _placeholder setVariable ["type", [_camp,_AA,_RB,_Arty],DEP_clientside];                
                };
                
                _placeholder setposATL [_pos select 0, _pos select 1, -30];
                DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
        };
        
        if ((_loctype in ["Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"])) then {
                _d = 500;
                _pos = [position _loc, 0,_d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
                _placeholder = "Sign_Pointer_F" createvehicle _pos;
                
                _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                while {isnil "_grptype"} do {
                        _grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                };
                _grptype = [_grptype] call DEP_format_group;
                _placeholder setVariable ["groupType",[_grptype],DEP_clientside];
                
                if (random 1 < ep_campprob) then {
                        _posTMP = [position _loc,200,0.15,5] call rmm_ep_getFlatArea;
                        if (str(_posTMP) == str(position _loc)) exitwith {diag_log format["MSO-%1 PDB EP Population: Camp not created due to unsuitable location %2!", time,_posTMP];};
                        
                        _pos = _posTMP;
                        _camp = [] call mso_fnc_selectcamptype;
                        _grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _grptype2 = [_grptype2] call DEP_format_group;
                        _placeholder setVariable ["groupType", [_grptype] + [_grptype2],DEP_clientside];
                        
                        // Add AA
                        if (random 1 < 0.5) then {
                                _AA = true;
                        };
                        _placeholder setVariable ["type", [_camp,_AA,_RB,_Arty],DEP_clientside];                      
                };

                _placeholder setposATL [_pos select 0, _pos select 1, -30];
                DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
        };
        
        if ((_loctype in ["FlatArea", "FlatAreaCity","FlatAreaCitySmall","CityCenter","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"])) then {
                _d = 300;
                _pos = [position _loc, 0,_d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
                _placeholder = "Sign_Pointer_F" createvehicle _pos;
                
                _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                while {isnil "_grptype"} do {
                        _grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                };
                _grptype = [_grptype] call DEP_format_group;
                _placeholder setVariable ["groupType",[_grptype],DEP_clientside];
                
                if (random 1 < ep_campprob) then {
                    if (random 1 < _DEP_ArtyIntensity) then {
                         _posTMP = [position _loc,200,0.15,5] call rmm_ep_getFlatArea;
                        if (str(_posTMP) == str(position _loc)) exitwith {diag_log format["MSO-%1 PDB EP Population: Camp not created due to unsuitable location %2!", time,_posTMP];};
                        
                        _pos = _posTMP;
                        _camp = [] call mso_fnc_selectcamptype;
                        _grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _grptype2 = [_grptype2] call DEP_format_group;
                        _placeholder setVariable ["groupType", [_grptype] + [_grptype2],DEP_clientside];
                   } else {
                        _posTMP = [position _loc,200,0.15,5] call rmm_ep_getFlatArea;
                        if (str(_posTMP) == str(position _loc)) exitwith {diag_log format["MSO-%1 PDB EP Population: Camp not created due to unsuitable location %2!", time,_posTMP];};

						_pos = _posTMP;
						if ("BIS_TK" in MSO_FACTIONS || "BIS_TK_INS" in MSO_FACTIONS || "BIS_TK_GUE" in MSO_FACTIONS) then {_camp = "firebase_tk1";} else {_camp = "firebase_ru1";};
                        _Arty = true;
                        
                        _grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _grptype2 = [_grptype2] call DEP_format_group;
                        _placeholder setVariable ["groupType", [_grptype] + [_grptype2],DEP_clientside];
                   };
                   
                    // Add AA
                    if (random 1 < 0.5) then { 
                            _AA = true;
                    };
                };

                if (((random 1 < 0.5) && (count (_pos nearRoads 500) > 0)) ) then {
                        _placeholder setVariable ["type", [_camp,_AA,true,_Arty],DEP_clientside];  
                } else {
                        _placeholder setVariable ["type", [_camp,_AA,false,_Arty],DEP_clientside]; 
                };
                
                _placeholder setposATL [_pos select 0, _pos select 1, -30];
                DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
        };
        
        if ((_loctype in ["ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"])) then {
                _d = 200;
                _pos = [position _loc, 0,_d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
                _placeholder = "Sign_Pointer_F" createvehicle _pos;
                
                _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                while {isnil "_grptype"} do {
                        _grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _type = [["Infantry", "Motorized_MTP", "Support", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_sup,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
                };
                _grptype = [_grptype] call DEP_format_group;
                _placeholder setVariable ["groupType",[_grptype],DEP_clientside];
                
                if (random 1 < ep_campprob) then {
                        _posTMP = [position _loc,200,0.15,5] call rmm_ep_getFlatArea;
                        if (str(_posTMP) == str(position _loc)) exitwith {diag_log format["MSO-%1 PDB EP Population: Camp not created due to unsuitable location %2!", time,_posTMP];};
                        
                        _pos = _posTMP;
                        _camp = [] call mso_fnc_selectcamptype;
                        _grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
                        _grptype2 = [_grptype2] call DEP_format_group;
                        _placeholder setVariable ["type", [_camp,_AA,_RB,_Arty],DEP_clientside];
                        _placeholder setVariable ["groupType", [_grptype] + [_grptype2],DEP_clientside];
                };
                
                _placeholder setposATL [_pos select 0, _pos select 1, -30];
                DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
        };
};

publicVariable "DEP_LOCS";
diag_log format["MSO-%1 PDB EP Population: Endet INIT! Finalized DEP Locations: %2", time,count DEP_LOCS];
