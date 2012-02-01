if(leader player == player) then {
        [0,player,{
                private ["_SOM"];
                // Create Logic
                _SOM = (createGroup sideLogic) createUnit ["SecOpManager", position _this, [], 0, "NONE"];
                
                // Setup SOM
                _SOM setVariable ["settings",[["ambush", "attack_location", "trap", "rescue", "patrol", "escort", "defend_location", "destroy", "search"], true, nil, 30, true, 300, 0.7, [500, 2500]],true];
                //_SOM setVariable ["settings", [[], true, nil, nil, false]];
                
                // Sync leader
                _SOM synchronizeObjectsAdd [_this];
                
                [_SOM, _this] spawn {                                
                        private ["_SOM","_leader"];
                        _SOM = _this select 0;
                        _leader = _this select 1;
                        // Setup Support
                        waitUntil{_SOM getVariable "initDone"};
                        [["transport", "aerial_reconnaissance", "supply_drop", "tactical_airstrike", "artillery_barrage","gunship_run"], _leader] call BIS_SOM_addSupportRequestFunc;
                };
        }] call mso_core_fnc_ExMP;
};
