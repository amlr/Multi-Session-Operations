
private ["_loc","_loctype","_pos","_placeholder","_grptype","_camp","_grptype2","_d","_type"];

_debug = debug_mso;
diag_log format["MSO-%1 PDB EP Population: starting INIT...", time];

DEP_LOCS = [];
for "_i" from 0 to ((count CRB_LOCS)-1) step rmm_ep_intensity do {
    if (_i > ((count CRB_LOCS)-1)) exitwith {};
    
    _loc = CRB_LOCS select _i;
    _loctype = type _loc;
    _pos = position _loc;
    if ((_pos distance getmarkerpos "ammo" > rmm_ep_safe_zone) && (_pos distance getmarkerpos "ammo_1" > rmm_ep_safe_zone)) then {
    
    	_loctype = type _loc;
    	_pos = position _loc;

    	if ((_loctype == "Hill") && (random 1 > 0.33)) then {
        	_pos = [position _loc, 0, 30, 1, 0, 5, 0] call bis_fnc_findSafePos;
        	_placeholder = "Can_small" createvehicle _pos;
        
			_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_mec,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
			_grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
    		_placeholder setVariable ["groupType",[_grptype]];
        
        	if (random 1 < ep_campprob) then {
            	_camp = [[] call mso_fnc_selectcamptype];
            	_pos = [_pos,200,0.15,5] call rmm_ep_getFlatArea;
            	_grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
				
				_placeholder setVariable ["type", _camp];
				_placeholder setVariable ["groupType", [_grptype] + [_grptype2]];
                
        		if (random 1 < 0.5) then { // Add AA
					_AA = [true];
					_placeholder setVariable ["type", _camp + _AA];
        		};                
        	};
        
       		_placeholder setpos [_pos select 0, _pos select 1, -30];
        	DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
    	};
    
    	if ((_loctype in ["Strategic","StrongpointArea","Airport","HQ","FOB","Heliport","Artillery","AntiAir","City","Strongpoint","Depot","Storage","PlayerTrail","WarfareStart"]) && (random 1 > 0.5)) then {
        	_d = 500;
      	  	_pos = [position _loc, 0,_d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
      		_placeholder = "Can_small" createvehicle _pos;
	
			_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_mec,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
     	   	_grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
    		_placeholder setVariable ["groupType",[_grptype]];
                        
        	if (random 1 < ep_campprob) then {
            	_camp = [[] call mso_fnc_selectcamptype];
            	_pos = [_pos,200,0.15,5] call rmm_ep_getFlatArea;
            	_grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
				
            	_placeholder setVariable ["type", _camp];
				_placeholder setVariable ["groupType", [_grptype] + [_grptype2]];
                
        		if (random 1 < 0.5) then {
					_placeholder setVariable ["type", _camp + [true]];
        		};                
        	};

        	_placeholder setpos [_pos select 0, _pos select 1, -30];
        	DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
    	};
    
    	if ((_loctype in ["FlatArea", "FlatAreaCity","FlatAreaCitySmall","CityCenter","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","fakeTown"]) && (random 1 > 0.6)) then {
        	_d = 300;
        	_pos = [position _loc, 0,_d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
        	_placeholder = "Can_small" createvehicle _pos;
        	
        	_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_mec,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
        	_grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
    		_placeholder setVariable ["groupType",[_grptype]];
        
			_AA = [];
			
        	if (random 1 < ep_campprob) then {
            	_camp = [[] call mso_fnc_selectcamptype];
            	_pos = [_pos,200,0.15,5] call rmm_ep_getFlatArea;
            	_grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
				
				_placeholder setVariable ["type", _camp];
				_placeholder setVariable ["groupType", [_grptype] + [_grptype2]];
                
				
				if (random 1 < 0.5) then {
					_AA = [true];
					_placeholder setVariable ["type", _camp + _AA];
        		};
        	};
            
            if (((random 1 < 0.5) && (count (_pos nearRoads 500) > 0)) ) then {
				_placeholder setVariable ["type", _camp + _AA + [true]];
        	};
      
        	_placeholder setpos [_pos select 0, _pos select 1, -30];
        	DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
    	};
    
    	if ((_loctype in ["ViewPoint","RockArea","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"]) && (random 1 > 0.75))then {
        	_d = 200;
        	_pos = [position _loc, 0,_d / 2 + random _d, 1, 0, 5, 0] call bis_fnc_findSafePos;
        	_placeholder = "Can_small" createvehicle _pos;
        
        	_type = [["Infantry", "Motorized", "Mechanized", "Armored"],[rmm_ep_inf,rmm_ep_mot,rmm_ep_mec,rmm_ep_arm]] call mso_core_fnc_selectRandomBias;
        	_grptype = [_type, MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
    		_placeholder setVariable ["groupType",[_grptype]];
        
        	if (random 1 < ep_campprob) then {
            	_camp = [[] call mso_fnc_selectcamptype];
            	_pos = [_pos,200,0.15,5] call rmm_ep_getFlatArea;
            	_grptype2 = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
				
				_placeholder setVariable ["type", _camp];
				_placeholder setVariable ["groupType", [_grptype] + [_grptype2]];
        	};

        	_placeholder setpos [_pos select 0, _pos select 1, -30];
        	DEP_LOCS set [count DEP_LOCS,[_placeholder,0]];
    	};
	} else {
      	if (_debug) then {diag_log format["MSO-%1 PDB EP Population: Skipping unfitting location...", time]};
    };
};

diag_log format["MSO-%1 PDB EP Population: ended INIT...", time];
diag_log format["MSO-%1 PDB EP Population: DEP Locations - %2", time,count DEP_LOCS];

