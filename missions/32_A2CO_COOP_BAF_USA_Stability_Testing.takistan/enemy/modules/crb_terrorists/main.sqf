#include <crbprofiler.hpp>

//execVM "modules\crb_terrorists\main.sqf";
//[position player, 1,_debug] call CRB_fnc_FindVehicle;
//[position player, 1] call CRB_fnc_SpawnVehicle
//(group player) setVariable ["Ammunition", [position player] call CRB_fnc_SpawnRandomAmmo, true];
//[units player, CIVAMMO] spawn CRB_fnc_ArmFromAmmo;
//[position player, true] call CRB_fnc_GetNearestTown;
//[[position ((group player) getVariable "Ammunition"), true] call CRB_fnc_GetNearestTown,true] call CRB_fnc_GetBuildingPosForTown;
//[group player, true] spawn CRB_fnc_RecruitMember;

private ["_spawnpoints","_debug","_numcells"];
if(!isServer) exitWith{};

_debug = debug_mso;

if(isNil "rmm_ep_safe_zone")then{rmm_ep_safe_zone = 2000;};

if(isNil "crb_tc_intensity")then{crb_tc_intensity = 1;};
crb_tc_intensity = switch(crb_tc_intensity) do {
	case 0: {
		0;
	};
	case 1: {
		0.12;
	};
	case 2: {
		0.25;
	};
	case 3: {
		0.5;
	};
	case 4: {
		1;
	};
	case 5: {
		2;
	};
};
if(crb_tc_intensity == 0 || AmbientCivs == 0) exitWith{};

if(isNil "crb_tc_markers")then{crb_tc_markers = 0;};

CRB_fnc_debugPositions = {
	CRBPROFILERSTART("CRB Terrorists debugPositions")

        private ["_positions","_debug","_text"];
        _positions = _this select 0;
        _text = _this select 1;
        _debug = _this select 2;
        if(_debug) then {
                diag_log format["Marking %1...", _text];
                private["_i","_m","_p"];
                _i = 0;
                {
                        _p = if(typeName _x == "ARRAY") then {_x} else {position _x};
                        _m = createMarkerLocal [format["tmptc%1", _i], _p];
                        _m setMarkerTypeLocal "Dot";
                        _i = _i + 1;
                } forEach _positions;
                sleep 5;
                _i = 0;
                {
                        deleteMarkerLocal format["tmptc%1", _i];
                        _i = _i + 1;
                } forEach _positions;
        };

	CRBPROFILERSTOP
};


// Thanks to Pogoman's Insurgency for this code
#define intelMarkerType "hd_unknown"
#define intelRadius 1000

PGM_fnc_CreateIntel = { 
	CRBPROFILERSTART("CRB Terrorists createIntel")

        private ["_i","_sign","_sign2","_radius","_cache","_pos","_range"];
        
        _cache  = _this;	
        _i      = 0; 
        while{ (getMarkerPos format["%1intel%2", _cache, _i] select 0) != 0}do{ _i = _i + 1;}; 	
        _sign   = 1; 
        if (random 100 > 50) then { _sign = -1; }; 
        _sign2  = 1; 
        if (random 100 > 50) then { _sign2 = -1; }; 
        _radius = intelRadius - _i*50;
        if (_radius < 50) then { _radius = 50; };
        _pos    = [
                (getPosATL _cache select 0) + _sign *(random _radius),
                (getPosATL _cache select 1) + _sign2*(random _radius)
        ]; 
        _range  = ceil((position _cache distance _pos) / 50) * 50;
        [format["%1intel%2", _cache, _i], _pos, "Icon", [0.5,0.5], "TEXT:", format["%1m", _range], "TYPE:", intelMarkerType, "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
        [2,[],{player sideChat "Intelligence received - map updated";}] call mso_core_fnc_ExMP;

	CRBPROFILERSTOP
}; 




TUP_fnc_AddVehicleTrigger = {
	private ["_vehicle","_debug","_trg"];
	
	_vehicle = _this select 0;
	_debug = _this select 1;
	
	// Create trigger and attach to vehicle to check for enemy - in order to control reaction
	_trg = createTrigger["EmptyDetector",getPos _vehicle]; 
	_trg setTriggerArea[200,200,0,false];
	_trg setTriggerActivation["WEST","EAST D",false];
	_trg setTriggerStatements["this && ({(vehicle _x in thisList) && ((position _x) select 2 <50)} count ([] call BIS_fnc_listPlayers) > 0)", "null = [thisTrigger, thisList] execvm 'enemy\modules\crb_terrorists\inspectvehicle.sqf'", ""]; 
	_trg attachTo [_vehicle,[0,0,-0.5]];
	 if (_debug) then {
		diag_log format ["MSO-%1 Terrorists Cells: %2 created at %3", time, typeof _vehicle, position _vehicle];
	};
};

CRB_fnc_FindVehicle = {
	CRBPROFILERSTART("CRB Terrorists findVehicle")

        private ["_newveh","_vdist","_pos","_vcargo","_vehs","_debug"];
        _pos = _this select 0;
        _vcargo = _this select 1;
        _debug = _this select 2;
        _vdist = 500;
        _newveh = objNull;
        _vehs = nearestObjects [_pos, ["Car"], 250];
        [_vehs, "vehicles", _debug] call CRB_fnc_debugPositions;
        {
                if((_x emptyPositions "cargo") >= _vcargo && ((_x distance _pos) < _vdist) /*&& isNull (assignedDriver _x)*/) then {
                        _newveh = _x;
                        _vdist = _x distance _pos;
                };
        } forEach _vehs;
        
        if(!isNull _newveh) then {
                //DEBUG:player sideChat format["Found vehicle: %1", _newveh];
                _newveh lock false;
                _newveh setDamage 0;
        } else {
                //DEBUG:player sideChat "No vehicle found";
        };
		
		// Create trigger and attach to vehicleto check for enemy - in order to control reaction
		[_newveh,_debug] call TUP_fnc_AddVehicleTrigger;
        
	CRBPROFILERSTOP
        _newveh;
};

CRB_fnc_SpawnVehicle = {
	CRBPROFILERSTART("CRB Terrorists spawnVehicle")

        private ["_vehicle","_vcargo","_tmp","_pos","_crew","_debug"];
        _pos = _this select 0;
        _crew = 1;
        if(count _this > 1) then {
                _crew = _this select 1;
        };
        _vcargo = 0;
        _vehicle = objNull;
        waitUntil{!isNil "bis_alice_mainscope"};
        while{_vcargo < _crew} do {
                deleteVehicle _vehicle;
                _tmp = (BIS_alice_mainscope getvariable "ALICE_classesVehicles") call BIS_fnc_selectRandom;
                if(_tmp isKindOf "Car") then {
                        _vehicle = _tmp createVehicle _pos;
						// Create trigger and attach to vehicleto check for enemy - in order to control reaction
						[_vehicle,_debug] call TUP_fnc_AddVehicleTrigger;
                        _vcargo = _vehicle emptyPositions "cargo";
                };
//                sleep 0.1;
        };
        //DEBUG:player sideChat format["Spawned vehicle: %1", _vehicle];

	CRBPROFILERSTOP

        _vehicle;
};

CRB_fnc_SpawnRandomAmmo = {
	CRBPROFILERSTART("CRB Terrorists spawnRandomAmmo")

        /*
        ["BAF_IEDBox","GuerillaCacheBox_EP1","GuerillaCacheBox","LocalBasicWeaponsBox","LocalBasicAmmunitionBox"],
        [1,1,5,5,10]
        */
        // Randomly pick and create ammo box
        private ["_aclass","_ammo","_pos"];
        _pos = _this select 0;
        _aclass = [
                ["GuerillaCacheBox_EP1","GuerillaCacheBox","LocalBasicWeaponsBox"],
                [2,3,3]
        ] call mso_core_fnc_selectRandomBias;
        _ammo = createVehicle [_aclass, _pos, [], 0, "NONE"];
        //        _ammo setPos _pos;
        _ammo setVectorUp [0, 0, 1];

	CRBPROFILERSTOP
        _ammo;
};

CRB_fnc_ArmFromAmmo = {
	CRBPROFILERSTART("CRB Terrorists armFromAmmo")

        // Arm with weapons
        private ["_srcwep","_ammo","_units"];
        _units = _this select 0;
        _ammo = _this select 1;
        _srcwep = "";
        {
                // Pick a random weapon from crate
                while{alive _x && !(_x isKindOf "Woman_EP1") && !(_x isKindOf "Woman") && primaryWeapon _x == "" && count((getWeaponCargo _ammo) select 0) != 0} do {
                        _srcwep = ([(getWeaponCargo _ammo) select 0] call CBA_fnc_shuffle) select 0;
                        // Arm civilian with weapon
                        //DEBUG:hint str _srcwep;
                        _x action ["takeweapon", _ammo, _srcwep];
                        sleep 5;
                };
                private["_muzzles"];                                
                // check for multiple muzzles (eg: GL)
                _muzzles = getArray(configFile >> "cfgWeapons" >> primaryWeapon _x >> "muzzles");
                if (count _muzzles > 1) then  {
                        _x selectWeapon (_muzzles select 0);
                } else {
                        _x selectWeapon (primaryWeapon _x);
                };
                _x setBehaviour "ALERT";
                _x setSpeedMode "FULL";
        } forEach _units;

	CRBPROFILERSTOP
};

CRB_fnc_GetBuildingPosForTown = {
	CRBPROFILERSTART("CRB Terrorists getBuildingPosForTown")

        private ["_i","_twn","_bldgpos","_nearbldgs","_debug"];
        _twn = _this select 0;
        _debug = _this select 1;
        _bldgpos = _twn getVariable "BuldingPositions";
        if(!isNil "_bldgpos") then {
                _bldgpos = _twn getVariable "BuldingPositions";
        } else {
                _bldgpos = [];
                _i = 0;
                _nearbldgs = nearestObjects [ position _twn, ["Building"], 400];
				if (count _nearbldgs > 0) then
				{				
					{
						if(!surfaceIsWater position _x) then {
							private["_y"];
							_y = _x buildingPos _i;
							while {format["%1", _y] != "[0,0,0]"} do {
								if(_y select 2 < 3) then {
									_bldgpos set [count _bldgpos, _y];
								};
								_i = _i + 1;
								_y = _x buildingPos _i;
							};
							_i = 0;
						};
					} forEach _nearbldgs;
					_twn setVariable ["BuldingPositions", _bldgpos, true];
				} else {
					diag_log format["MSO-%1 TerrorCells: Cannot find buildings in %2", time, name _twn];
				};
        };
        [_bldgpos,"building positions",_debug] call CRB_fnc_debugPositions;

	CRBPROFILERSTOP
        _bldgpos;
};

CRB_fnc_GetNearestTown = {
	CRBPROFILERSTART("CRB Terrorists getNearestTown")

        private ["_nearest","_pos","_neighbours","_debug"];
        _pos = _this select 0;
        _debug = _this select 1;
        
        waitUntil{!isNil "bis_alice_mainscope"};
        waitUntil{typeName (bis_alice_mainscope getvariable "townlist") == "ARRAY"};
		
        _nearest = (bis_alice_mainscope getvariable "townlist") select 0;
        {
                if(_nearest distance _pos > _x distance _pos) then {
                        _nearest = _x;
                };
        } forEach (bis_alice_mainscope getvariable "townlist");
        
 //      _neighbours = _nearest getVariable "neighbors"; // Removed this as it was not compatible with towns without neighbours defined - was causing issues/errors.

		_neighbours = [];
		
        {
                if(_nearest distance _x < 1000) then {
                        _neighbours set [count _neighbours, _x];
                };
        } forEach (bis_alice_mainscope getvariable "townlist") - [_nearest];
		
	if(random 1 > 0.5) then {
		_neighbours set [count _neighbours, _nearest];
	};
        
        [_neighbours, "neighbours", _debug] call CRB_fnc_debugPositions;
        
        _nearest = _neighbours call BIS_fnc_selectRandom;
	
	if(isNil "_nearest") then {
		_nearest = (bis_alice_mainscope getvariable "townlist") select 0;
		diag_log format["MSO-%1 TerrorCells: Nearest town not found", time];
	}; 

	CRBPROFILERSTOP
	_nearest;
};

CRB_fnc_InitClassLists = {
	CRBPROFILERSTART("CRB Terrorists initClassLists")

        private ["_class","_faction","_woman","_classlist"];
        waitUntil{!isNil "bis_alice_mainscope"};
        waitUntil{typeName (bis_alice_mainscope getvariable "ALICE_classes") == "ARRAY"};
        waitUntil{count (bis_alice_mainscope getvariable "ALICE_classes")  > 0};
        waitUntil{typeName (bis_alice_mainscope getvariable "townsFaction") == "ARRAY"};
        
        //--- Select driver
        _classlist = bis_alice_mainscope getvariable "ALICE_classes";
        CRB_classlistMen = [];
        CRB_classListFaction = [];
        {
                _class = _x select 0;
                //	_rarity = _x select 1;
                _faction = _x select 2;
                _woman = _x select 3;
                if (_faction in (BIS_alice_mainscope getVariable "townsFaction")) then {
                        CRB_classListFaction set [count CRB_classListFaction, _class];
                        if (_woman == 0) then {
                                CRB_classlistMen set [count CRB_classlistMen, _class];
                        };
                };
        } foreach _classlist;

	CRBPROFILERSTOP
};

CRB_fnc_GetUnitClass = {
	CRBPROFILERSTART("CRB Terrorists getUnitclass")

        private ["_classMan","_classList","_rarity","_bldgposcount","_twnRarityUrban","_rarityRange","_unitrarity"];
        _classList = _this select 0;
        _bldgposcount = _this select 1;
        //        _twnRarityUrban = [_twn,["RARITY"]] call bis_fnc_locations;
        _twnRarityUrban = sqrt (_bldgposcount / 400);
        _rarityRange = 0.3 + (0.2 * _twnRarityUrban);
        
        _classMan = "";
        _rarity = 10;
        _unitrarity = bis_alice_mainscope getvariable "ALICE_classes";
        //DEBUG:hint format["%1 %2 %3 %4", _twnRarityUrban, _rarityRange];
        while{abs(_twnRarityUrban - _rarity) > _rarityRange} do {
                _classMan = _classList call BIS_fnc_selectRandom;
                _rarity = _unitrarity select ((_unitrarity find _classMan)+1);
        };
        
	CRBPROFILERSTOP
        _classMan;
};


CRB_fnc_RecruitMember = {
	CRBPROFILERSTART("CRB Terrorists recruitMember")

        private ["_t","_tcrm","_tcid","_bldgpos","_ammo","_grp","_debug","_recpos","_classMan","_recruit","_twn","_waittime"];
        _grp = _this select 0;
        _debug = _this select 1;
        _ammo = _grp getVariable "Ammunition";
        if(isNil "_ammo") then { 
                _ammo = [position leader _grp] call CRB_fnc_SpawnRandomAmmo;
                _grp setVariable ["Ammunition", _ammo, true];
        };
        _tcid = _grp getVariable "ID";
        if(isNil "_tcid") then {_tcid = 0;};
        _twn = _grp getVariable "nearestTown";
		if(isNil "_twn") then {
			_twn = [position leader _grp, _debug] call CRB_fnc_GetNearestTown;
			_grp setVariable ["nearestTown", _twn, true];
		};        _bldgpos = [_twn,_debug] call CRB_fnc_GetBuildingPosForTown;
        _recpos = _bldgpos call BIS_fnc_selectRandom;
        if(isNil "_recpos") exitWith {
		hint "No recruit spawn position";
		diag_log format["MSO-%1 TerrorCells: No recruit spawn position (%2)", time, _twn];
		};
        _tcrm = "";
        if (_debug) then {
                _t = format["tcell_r%1", _tcid];
                hint format["Cell#%1 - recruiting %2", _tcid, _t];
                _tcrm = [_t, _recpos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorBlue", "GLOBAL"] call CBA_fnc_createMarker;
        };
        
        if(isNil "CRB_classlistFaction") then {
                [] call CRB_fnc_InitClassLists;
        };
        waitUntil{typeName CRB_classlistFaction == "ARRAY"};
        
        _classMan = CRB_classlistMen call BIS_fnc_selectRandom;        
        _recruit = (createGroup civilian) createUnit [_classMan, _recpos, [], 0, "NONE"];
        _recruit setSkill (random 1);
        _recruit allowDamage false;
        _recruit move position _ammo;
        _waittime = time + 300;
        waitUntil{sleep 1;unitReady _recruit || _waittime < time};
        _recruit allowDamage true;
        
        // Pick a random weapon from crate
        [[_recruit], _ammo] call CRB_fnc_ArmFromAmmo;
        [_recruit] joinSilent _grp;
        if (_debug) then {
                deleteMarker _tcrm;
        };

	CRBPROFILERSTOP
};

CRB_fnc_SplitCell = {
	CRBPROFILERSTART("CRB Terrorists splitCell")

        private ["_newveh","_t","_tcrm","_tcid","_grp","_debug","_terrorlead","_pos","_count","_split","_newcell","_newtwn","_str","_newlead","_waittime"];
        _grp = _this select 0;
        _debug = _this select 1;
        
        _tcid = _grp getVariable "ID";
        if(isNil "_tcid") then {_tcid = 0;};
        _terrorlead = leader _grp;
        _pos = position _terrorlead;
        _count = count(units _grp);
        _tcrm = "";
        // split
        _split = (ceil(random (_count / 2))) max 2;
        
        _newcell  = createGroup east;
        _newcell setVariable ["rmm_gtk_exclude", true, true];
        for "_i" from 0 to _split do {
                [(units _grp - [_terrorlead]) call BIS_fnc_selectRandom] joinSilent _newcell;
        };
        _newveh = [_pos, (count units _newcell) - 1,_debug] call CRB_fnc_FindVehicle;
        
        if(isNull _newveh) then {
                _newveh = [_pos, (count units _newcell) - 1] call CRB_fnc_SpawnVehicle;
        };
        
        if (_debug) then {
                _t = format["tcell_r%1", _tcid];
                _str = format["MSO-%1 Cell#%2 - splitting %3 %4", time, _tcid, _t, _newveh];
                hint _str;
                diag_log _str;
                _tcrm = [_t, position _newveh, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorYellow", "GLOBAL"] call CBA_fnc_createMarker;
        };
        
        _newlead = leader _newcell;
        while{(_newlead isKindOf "Woman_EP1") || (_newlead isKindOf "Woman")} do {
                _newcell selectLeader ((units _newcell) call BIS_fnc_selectRandom);
                _newlead = leader _newcell;
        };
        _newlead setSkill 1;
        _newlead setBehaviour "ALERT";
        _newlead setSpeedMode "FULL";
        _newlead allowFleeing 0;
        _newlead assignAsDriver _newveh;
        _newcell addVehicle _newveh;
        _newlead move position _newveh;
        _waittime = time + 300;

	CRBPROFILERSTOP

        waitUntil{sleep 1;_newlead distance _newveh < 15 || _waittime < time};

        [_newlead] orderGetIn true;
        _newlead move _pos;
        _waittime = time + 300;

        waitUntil{sleep 1;_newlead distance _pos < 5 || _waittime < time};

        sleep 15;
        
        /*        _newtwn = [];
        waitUntil{!isNil "bis_alice_mainscope"};
        {
                if(_pos distance _x < (BIS_alice_mainscope getvariable "trafficDistance")) then {
                        _newtwn set [count _newtwn, _x];
                };
        } forEach (bis_alice_mainscope getvariable "townlist");
        
        _newtwn = _newtwn call BIS_fnc_selectRandom;
        */        
        _newtwn = [_pos, _debug] call CRB_fnc_GetNearestTown;
        _newcell setVariable ["nearestTown", _newtwn, true];        
        if (_debug) then {
                deleteMarker _tcrm;
        };
        
        [_newlead, _newveh, _newtwn, _debug] call CRB_fnc_SpawnNewCell;      
};

CRB_fnc_SpawnNewCell = {
	CRBPROFILERSTART("CRB Terrorists spawnNewCell")

        private ["_terrorcrgo","_pos","_count","_terrorlead","_maxgroupsize","_ammo","_spawn","_vehicle","_twn","_bldgpos","_grp","_debug","_t","_tcid","_tcsm","_tcdm","_forcesplit","_waittime","_wait"];
        _terrorlead = _this select 0;
        _vehicle = _this select 1;
        _twn = _this select 2;
        _debug = _this select 3;
        
        _spawn = position _terrorlead;
        _tcid = floor(random 10000);
        (group _terrorlead) setVariable ["ID", _tcid, true];
        _tcsm = "";
        _tcdm = "";
        if (_debug) then {
                _t = format["tcell_s%1", _tcid];
                _tcsm = [_t, _spawn, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorGreen", "GLOBAL"] call CBA_fnc_createMarker;
        };
        
        _terrorlead setSkill 1;
        _terrorlead setBehaviour "ALERT";
        _terrorlead setSpeedMode "FULL";
        _terrorlead allowFleeing 0;
        (group _terrorlead) setVariable ["rmm_gtk_exclude", true, true];
        _maxgroupsize = 6 + floor(random 10);
        
        _ammo = [_spawn] call CRB_fnc_SpawnRandomAmmo;
        (group _terrorlead) setVariable ["Ammunition", _ammo, true];
        [units _terrorlead, _ammo] call CRB_fnc_ArmFromAmmo;
        _ammo setPos [0,0,0];
        
        // Get in car
        _terrorlead assignAsDriver _vehicle;
        
        _terrorcrgo = units _terrorlead - [_terrorlead];
        {
                _x assignAsCargo _vehicle;
                _x setSkill random 1;
                _x setBehaviour "ALERT";
                _x setSpeedMode "FULL";
        } forEach _terrorcrgo;        
        
        _bldgpos = [_twn,_debug] call CRB_fnc_GetBuildingPosForTown;
        _pos = _bldgpos call BIS_fnc_selectRandom;
        if (_debug) then {
                _t = format["tcell_d%1", _tcid];
                _tcdm = [_t, _pos, "Icon", [1,1], "TEXT:", _t, "TYPE:", "Dot", "COLOR:", "ColorRed", "GLOBAL"] call CBA_fnc_createMarker;
        };

        units _terrorlead orderGetIn true;
        _wait = time + 120;

	CRBPROFILERSTOP

        waitUntil{sleep 1;{!unitReady _x} count units _terrorlead == 0 || _wait < time};
        if(!((group _terrorlead) call CBA_fnc_isAlive)) exitWith {deleteVehicle _ammo;};

        _terrorlead move _pos;
        _terrorlead setBehaviour "SAFE";
        _waittime = time + 300;
        waitUntil{sleep 1;_terrorlead distance _pos < 50 || _waittime < time};
        if(!((group _terrorlead) call CBA_fnc_isAlive)) exitWith {deleteVehicle _ammo;};
        sleep 15;
        
        _ammo setPos _pos;
        _ammo setVelocity [0,0,-1];
        
        _terrorlead setBehaviour "ALERT";
        (group _terrorlead) leaveVehicle _vehicle;
        
        if (_debug) then {
                deleteMarker _tcsm;
        };
        
        [group _terrorlead, _pos] execVM "enemy\scripts\BIN_taskDefend.sqf";
		
		// Check to see if Cell sets up roadblock
		if ((random 1 > 0.7) || (_debug)) then {
			[group _terrorlead, _pos] execVM "enemy\scripts\TUP_deployRoadBlock.sqf";
			if (_debug) then {
                diag_log format["Cell#%1 - Deployed Road Block", _tcid];
			};
		};
        
        //{alive _x} count units _grp> 0 && 
        while{count((getWeaponCargo _ammo) select 0) != 0 || count((getMagazineCargo _ammo) select 0) != 0} do {
                _forcesplit = false;
                waitUntil{sleep 15;(count ([] call BIS_fnc_listPlayers) > 1 || !isMultiplayer) && (east countSide allUnits < 150)};
                if(_debug) then {sleep 15} else {sleep ((1800 + random 1800) * crb_tc_intensity)};
                _grp = group _terrorlead;
                if(count units _grp < _maxgroupsize) then {
                        [_grp, _debug] call CRB_fnc_RecruitMember;
                } else {
                        _forcesplit = true;
                };
                
                _count = count(units _grp);
                if((random 3 > 2  && _count >= 6) || _forcesplit) then {
                        if(crb_tc_markers==1)then{_ammo call PGM_fnc_CreateIntel;};
                        [_grp, _debug] spawn CRB_fnc_SplitCell;
                };
		if(!alive _ammo) exitWith {
			private ["_i"];
		        _i = 0; 
		        while{str (getMarkerPos format["%1intel%2", _ammo, _i]) != "[0,0,0]"} do {
				deleteMarker format["%1intel%2", _ammo, _i];
				_i = _i + 1;
			};
		};
        };
        
        if(crb_tc_markers==1)then{_ammo call PGM_fnc_CreateIntel;};
        
        if (_debug) then {
                diag_log format["Cell#%1 - no longer recruiting", _tcid];
                deleteMarker _tcdm;
        };
};



// Identify all random spawn points
waitUntil{!isNil "BIS_fnc_init"};
if(isNil "CRB_LOCS") then {
        CRB_LOCS = [] call mso_core_fnc_initLocations;
};

_spawnpoints = [];
{
        if(type _x == "BorderCrossing") then {
                _spawnpoints set [count _spawnpoints, position _x];
        };
} forEach CRB_LOCS;

private ["_tmplocs"];
_tmplocs = bis_functions_mainscope getvariable "locations";
{
	_spawnpoints set [count _spawnpoints, position _x];
} forEach _tmplocs;

waitUntil{!isNil "bis_alice_mainscope"};

// Pick a civilian class and civilian vehicle class
if(isNil "CRB_classlistMen") then {
        [] call CRB_fnc_InitClassLists;
};        
waitUntil{typeName CRB_classlistMen == "ARRAY"};

if(isNil "CRB_classlistFaction") then {
        [] call CRB_fnc_InitClassLists;
};        
waitUntil{typeName CRB_classlistFaction == "ARRAY"};

_numcells = ceil(1 + random 2 + ceil((count _spawnpoints) / 5));
diag_log format["MSO-%1 TerrorCells: spawns(%2) cells(%3)", time, count _spawnpoints, _numcells];

for "_i" from 1 to _numcells do {
        [_spawnpoints, _debug] spawn {        
                private ["_classMan","_terrorunit","_terrorcrgo","_spawnpoints","_debug","_spawn","_grp","_terrorlead","_vehicle","_vcargo","_twn"];
                _spawnpoints = _this select 0;
                _debug = _this select 1;
                
                // Pick a spawn point
                _spawn =  _spawnpoints call BIS_fnc_selectRandom;
                while {
                (([_spawn, rmm_ep_safe_zone] call fPlayersInside) or (_spawn distance getmarkerpos "ammo" < rmm_ep_safe_zone) or (_spawn distance getmarkerpos "ammo_1" < rmm_ep_safe_zone)) 
                } do {_spawn = _spawnpoints call BIS_fnc_selectRandom; sleep 0.1};
                
                //DEBUG:player setPos _spawn;
                //DEBUG:sleep 15;
                
                // Create terrorist leader and vehicle
                _classMan = CRB_classlistMen call BIS_fnc_selectRandom;
                _grp  = createGroup east;
                _grp setVariable ["rmm_gtk_exclude", true, true];
                _terrorlead = (createGroup civilian) createUnit [_classMan, _spawn, [], 0, "NONE"];
                [_terrorlead] joinSilent _grp;
                
                //DEBUG:_vehicle = "Ikarus" createVehicle _spawn;
                _vehicle = [_spawn] call CRB_fnc_SpawnVehicle;
                _grp addVehicle _vehicle;
                
                _vcargo = _vehicle emptyPositions "cargo";
                
				//DEBUG:_twn = nearestLocation [_spawn, "CityCenter"];
                _twn = [_spawn, _debug] call CRB_fnc_GetNearestTown;
                _grp setVariable ["nearestTown", _twn, true];                
                _terrorcrgo = [];
                for "_i" from 0 to floor(random _vcargo) do {
                        _classMan  = CRB_classlistMen call BIS_fnc_selectRandom;
                        _terrorunit = (createGroup civilian) createUnit [_classMan, _spawn, [], 0, "NONE"];
                        [_terrorunit] joinSilent _grp;
                        _terrorcrgo set [count _terrorcrgo, _terrorunit];
                };
                
                [_terrorlead, _vehicle, _twn, _debug] call CRB_fnc_SpawnNewCell;
                
                /*
                // Count max weapon and magazine slots in vehicle
                _dstmags = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "transportMaxMagazines");
                _dstweps = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "transportMaxWeapons");
                // Remember original terrorlead weapon loadout
                _tlmags = magazines _terrorlead;
                _tlweps = weapons _terrorlead;
                
                // Wait for weapon to transfer
                waitUntil{sleep 1;count(weapons _terrorlead) > count(_tlweps)};
                player globalChat str (count(weapons _terrorlead) > count(_tlweps));
                // Check weapon and mag capacity in vehicle not yet reached
                //if(_dstwep == 0) then { //skip to end
                
                if(_dstmags < count((magazines _terrorlead) - _tlmags)) then {
                        // Remove extra mags
                        _extra = count((magazines _terrorlead) - _tlmags) - _dstmags;
                        for "_i" from 0 to _extra do {
                                _tlmagsx = magazines _terrorlead;
                                _terrorlead action ["dropweapon", _ammo, ((magazines _terrorlead) - _tlmags) select 0];
                                waitUntil{sleep 1; count(magazines _terrorlead) < count(_tlmagsx)};
                        };
                };
                player globalChat str _dstmags;
                
                // Transfer weapon to vehicle
                _dstmags = _dstmags - count((magazines _terrorlead) - _tlmags);
                player globalChat str _dstmags;
                _dstweps = _dstweps - count((weapons _terrorlead) - _tlweps);
                player globalChat str _dstweps;
                
                sleep 10;
                player globalChat str [_vehicle, _srcwep];
                _terrorlead action ["dropweapon", _vehicle, _srcwep];
                player globalChat str (weapons _terrorlead);
                */
        };
};
