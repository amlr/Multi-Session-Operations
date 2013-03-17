// Written by EightySix

mps_self_heal_condition = "damage player > 0.2 && damage player < 0.9";
mps_rally_condition = "player distance ( getMarkerPos format[""respawn_%1"",(SIDE_A select 0)] ) > 300 && !RALLY_STATUS && ((position player) select 2) < 2";

mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Rallypoint</t>",(mps_path+"action\mps_buildtent.sqf"),[],99,true,true,"",mps_rally_condition];
mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];

if( if( !isNil "ace_wounds_enabled" ) then { false } else { true } ) then {

	mps_self_heal = player addaction ["<t color=""#ff0000"">Apply First Aid to self</t>",(mps_path+"action\mps_ais_firstaid_self.sqf"),[],99,true,true,"",mps_self_heal_condition];

};

player addEventHandler ["killed", mps_player_killed];

player addEventHandler ["Killed",{player spawn mps_respawn_gear}];

player addEventHandler ["Killed",{

	mps_killed_event = [(_this select 0),(_this select 1),PlayerSide]; publicVariable "mps_killed_event";

	mps_mission_deathcount = mps_mission_deathcount - 1; publicVariable "mps_mission_deathcount";

	player removeAction mps_client_hud_act;

	player removeAction mps_self_heal;
	player removeAction mps_rallypoint;

	[] spawn {

		WaitUntil{ alive player };

		mps_client_hud_act = player addAction [localize "STR_Client_HUD_menu",(mps_path+"action\mps_hud_switch.sqf"),[],-1,false,false,"",""];

		if( if( !isNil "ace_wounds_enabled" ) then { false } else { true } ) then {

			mps_self_heal = player addaction ["<t color=""#FF0000"">Apply First Aid to self</t>",(mps_path+"action\mps_ais_firstaid_self.sqf"),[],99,true,true,"",mps_self_heal_condition];
			mps_rallypoint = player addaction ["<t color=""#ffc600"">Build Rallypoint</t>",(mps_path+"action\mps_buildtent.sqf"),[],99,true,true,"",mps_rally_condition];
		};

	};

}];

"mission_groupchat"	addPublicVariableEventHandler { player groupChat (_this select 1) };

"mission_globalchat"	addPublicVariableEventHandler { player globalChat (_this select 1) };

"mission_sidechat"	addPublicVariableEventHandler { [side player,"HQ"] sideChat (_this select 1) };

"mission_commandchat"	addPublicVariableEventHandler { [side player,"HQ"] commandChat (_this select 1) };

"mission_hint"		addPublicVariableEventHandler { hint parseText format["%1",_this select 1]; };

"mission_advhint"	addPublicVariableEventHandler { _message = _this select 1; _title = _message select 0; _content = _message select 1; _step = _message select 2; [_title,_content,_step] spawn mps_adv_hint; };

"mps_progress_bar_update"	addPublicVariableEventHandler { (_this select 1) call mps_progress_update; };

"mps_mission_deathcount"	addPublicVariableEventHandler { hint parseText format["Acceptable Mission Casualties Left: %1",_this select 1]; };

"mps_admin_vehicle_lock" addPublicVariableEventHandler { (_this select 1) call mps_lock_vehicle; };

"mps_admin_vehicle_unlock" addPublicVariableEventHandler {  (_this select 1) call mps_unlock_vehicle; };

"mps_change_time" addPublicVariableEventHandler {  (_this select 1) spawn mps_timechange; };