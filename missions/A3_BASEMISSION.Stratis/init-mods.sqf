// Custom improvements that you may wish to implement - currently supporting ACE, ACRE, EOD and CIM

private ["_speakernum","_i","_markername","_pos","_grp"];

// ACE configuration
if (isClass(configFile>>"CfgPatches">>"ace_main")) then {
        
        mps_ace_enabled = true;
        enableEngineArtillery true;  //disable BI arty comp
        ace_sys_eject_fnc_weaponcheck = {};  //disable aircraft weapon removal
        ace_sys_aitalk_radio_enabled = false;
        ace_sys_repair_default_tyres = true;
        ace_sys_tracking_markers_enabled = false;
        [player,"ACE_KeyCuffs"] call CBA_fnc_addWeapon;
        [player,"ACE_GlassesLHD_glasses"] call CBA_fnc_addWeapon;
        [player,"ACE_Earplugs"] call CBA_fnc_addWeapon;
        
        // ACE WOUNDS
        
        ace_sys_wounds_enabled = true;
        Ace_sys_wounds_no_medical_gear = true;  //ACE adds medical items
        ace_sys_wounds_noai = true;  //disable wounds for AI for performance
        ACE_IFAK_Capacity = 6;  //medical gear slots
        ace_sys_wounds_leftdam = 0; //damage left when healed in the field (def 0.07)
        ace_sys_wounds_all_medics = true;  //everyone is a medic
        ace_sys_wounds_ai_movement_bloodloss = true; 
        ace_sys_wounds_player_movement_bloodloss = true;
        ace_sys_wounds_auto_assist = false;  //non-medic AI help unconscious units in own group
        ace_sys_wounds_auto_assist_any = false; //non-medic AI help unconscious units in other group
        ace_sys_wounds_no_medical_vehicles = false;  //medical vehicles can be used for full heal
        
		if !(isDedicated) then {
			mso_interaction_key = ace_sys_interaction_key_self;
		};
        
        // ACE Jerry can and tyre cleanup workaround running on all localities
            
        //Checking for Jerrycans and Tyres existing on missionstart (editor placed objects), Defining mess-objects
        ACE_MESS = ["ACE_JerryCan_15", "ACE_JerryCan_5","ACE_JerryCan","ACE_Spare_Tyre","ACE_Spare_Tyre_HD","ACE_WoundingLitter_Morphine","ACE_ACE_WoundingLitterMedkit","ACE_WoundingLitter_Traumabandage","ACE_Blooddrop_1","ACE_Blooddrop_2","ACE_Spare_Tyre_HDAPC"];
        AllowedSupplyObjects = [];
            { 
            	if (typeof _x in ACE_MESS) then {
                    AllowedSupplyObjects set [count AllowedSupplyObjects, _x];
                };
            } foreach allmissionobjects "";

        //Define cleanup Procedure
        ACE_object_cleanup = {
            diag_log format["MSO-%1 ACE Cleanup: Starting cleanup procedure...", time];
            _timeStart = time;
            
            //Checking cargo of existing vehicles
            _allowedobjects = AllowedSupplyObjects;
            {
                _runtime = (time - _timeStart);
                if (_runtime > 60) exitwith {diag_log format["MSO-%1 ACE Cleanup: Collect-procedure fails to finish properly...", time];};
                
                if (alive _x) then {
                    _tempCargo = _x call ACE_fnc_listCargo;
                    _allowedobjects = _allowedobjects + _tempCargo;
                };
            } foreach allmissionobjects "LandVehicle";
            
            //Delete all other jerrycans and tyres
            {
                _runtime = (time - _timeStart);
                if (_runtime > 60) exitwith {diag_log format["MSO-%1 ACE Cleanup: Delete-procedure fails to finish properly...", time];};
        
            	if ((local _x) && {typeof _x in ACE_MESS} && {!(_x in _allowedobjects)}) then {
                    diag_log format["Cleaning abandoned ACE object %1", _x];
                    deletevehicle vehicle _x; deletevehicle _x;
                };
            } foreach allmissionobjects "";
            diag_log format["MSO-%1 ACE Cleanup: Ended cleanup procedure...", time];
        };
        
        //Spawning Cleanuploop that deletes every 15 minutes IF totalcount of local abandoned tyres/jerrycans is over 150
        [] spawn {
        	while {true} do {
                sleep (900 + (random 60));
                _objectCount = {local _x && typeof _x in ACE_MESS} count allmissionobjects "";
            	if (_objectCount > 100) then {
                    [] call ACE_object_cleanup;
                } else {
                    diag_log format["Not cleaning - Abandoned ACE objects are %1 - below 100",_objectCount];
                };
            };
        };
};

// ACRE Config and sync
if (isClass(configFile>>"CfgPatches">>"acre_main")) then {
        
        // Add ACRE box near current ammo boxes - ACRE_RadioBox
        if (isServer) then {
                private ["_radiomarkers"];
                _radiomarkers = ["ammo","ammo_1"];
                {
                        private ["_pos","_newpos"];
                        if !(str (markerPos _x) == "[0,0,0]") then {
                                _pos = markerPos _x;
                                if (count nearestObjects [_pos, ["ACRE_RadioBox"], 10] == 0) then {
                                        _newpos = [_pos, 0, 10, 2, 0, 0, 0] call BIS_fnc_findSafePos;
                                        "ACRE_RadioBox" createVehicle _newpos;
                                        diag_log format ["Creating ACRE Radio Box at %1", _newpos];
                                };
                        };
                } foreach _radiomarkers;
        };
        
        //	[0] call acre_api_fnc_setLossModelScale;  // Description: Specify any value between 1.0 and 0. Setting it to 0 means the loss model is disabled, 1 is default.
        
        runOnPlayers = {
                [] spawn
                {
                        waitUntil {!isNil "mso_interaction_key"};
                        ["player", [mso_interaction_key], -9399, ["scripts\callAcreSync.sqf", "main"]] call CBA_ui_fnc_add;
                };
        };
        
        if (!isDedicated) then {
                if (!isNull player) then  // non JIP
                {
                        call runOnPlayers;
                }
                else 
                {
                        [] spawn {
                                waitUntil {!isNull player};
                                call runOnPlayers;
                        };
                };
        };
};

// EOD Mod Configuration
if (isNil "tup_ied_eod")then{tup_ied_eod = 1;};

if ((isClass(configFile>>"CfgPatches">>"reezo_eod")) && (tup_ied_eod == 1)) then {
        if (isServer) then {		
                // Add THOR 3 backpacks to ammo crates or ACRE_RadioBox
                private ["_thors","_boxes","_crates","_boxmarkers","_crate","_number"];
                _boxmarkers = ["ammo","ammo_1"];
                _thors = ["SR5_THOR3", "SR5_THOR3_MAR", "SR5_THOR3_ACU"];
                _boxes = ["ACRE_RadioBox","ACE_RuckBox","BAF_BasicWeapons","USBasicWeaponsBox","USBasicWeapons_EP1"];
                _number = (count playableunits) * 3;
                _crates = [];
                {
                        _crates = _crates + nearestObjects [markerPos _x, _boxes, 20];
                } foreach _boxmarkers;
                {
                        _crate = _x;
                        {
                                _crate addweaponcargoglobal [_x, _number];
                        } foreach _thors;
                } foreach _crates;
                diag_log format ["Added %1 THOR III devices to %2 crate(s)", (count _thors) * (count playableunits), count _crates];
                
                // Add Loudspeaker to any vehicles nearby ammo markers
                PV_EOD_Loudspeaker_Vehicles = [];
                _speakernum = 1;
                {
                        private ["_prob","_tits","_posx","_list"];
                        _tits = 0;
                        
                        _posx = markerPos _x;
                        if !(str (markerPos _x) == "[0,0,0]") then {
                                _prob = 0.7 + random 0.3;
                                // Create Loudspeaker logic
                                /*				"reezo_eod_loudspeaker" createUnit [_posx, group BIS_functions_mainscope,
                                format["loudspeaker_%2 = this; this setVariable ['reezo_eod_range',[50,150]];
                                this setVariable ['reezo_eod_probability',%1];
                                this setVariable ['reezo_eod_interval',20];",_prob, _speakernum], 
                                0, ""];*/
                                // Find cars nearby
                                _list = nearestObjects [_posx, ["Car"], 150];
                                // Sync cars to loudspeaker
                                {
                                        if ((_x isKindOf "Wheeled_APC") || (_x isKindOf "LandRover_Base") || (_x isKindOf "HMMWV_Base") || (_x isKindOf "BAF_Jackal2_BASE_D") || (_x isKindOf "UAZ_Base")) then {
                                                //						call compile format ["loudspeaker_%1 synchronizeObjectsadd [_x];",_speakernum];
                                                _tits = _tits + 1;
                                                PV_EOD_Loudspeaker_Vehicles set [count PV_EOD_Loudspeaker_Vehicles, _x];
                                        };
                                } foreach _list;
                                diag_log format ["Synchronised %2 out of %1 possible cars to EOD Loudspeaker.", count _list, _tits];
                                _speakernum = _speakernum + 1;
                        };
                } foreach _boxmarkers;
                publicvariable "PV_EOD_Loudspeaker_Vehicles";
        };
        
        // Add the addaction on the vehicles with Loudspeakers for each player
        if (isMultiplayer && !isDedicated) then {
                [] spawn { 
                        private ["_prob"];                      
                        waitUntil {!isNull player && !isNil "PV_EOD_Loudspeaker_Vehicles"};
                        _prob = 0.7 + random 0.3;
                        {
                                _x addAction ['<t color="#FF9900">'+"Loudspeaker (Evacuate Civilians)"+'</t>', "x\eod\addons\eod\reezo_eod_action_loudspeaker_evacuate.sqf", [_x,[50,150],_prob,20], 0, false, true, "",""];
                        } foreach PV_EOD_Loudspeaker_Vehicles;
                };
        };
};