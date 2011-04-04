waitUntil{!isNil "bis_fnc_init"};

_this addAction ["Recruitment",CBA_fnc_actionargument_path, [[],{createDialog  "RMM_ui_recruitment_baf"}], -1, false, true, "", "rank _this in [""CORPORAL"",""SERGEANT"",""LIEUTENANT""] && typeOf _this == ""BAF_Soldier_TL_MTP"";"];
_this addAction ["Recruitment",CBA_fnc_actionargument_path, [[],{createDialog  "RMM_ui_recruitment_us"}], -1, false, true, "", "rank _this in [""CORPORAL"",""SERGEANT"",""LIEUTENANT""] && typeOf _this == ""US_Soldier_TL_EP1"";"];
_this addAction ["Recruitment",CBA_fnc_actionargument_path, [[],{createDialog  "RMM_ui_recruitment_cz"}], -1, false, true, "", "rank _this in [""CORPORAL"",""SERGEANT"",""LIEUTENANT""] && typeOf _this == ""CZ_Soldier_SL_DES_EP1"";"];
_this addAction ["Recruitment",CBA_fnc_actionargument_path, [[],{createDialog  "RMM_ui_recruitment_aaw"}], -1, false, true, "", "rank _this in [""CORPORAL"",""SERGEANT"",""LIEUTENANT""] && (typeOf _this == ""aawInfantrySecco1"");"];
_this addAction ["Recruitment",CBA_fnc_actionargument_path, [[],{createDialog  "RMM_ui_recruitment_aaw_dpduDpcu"}], -1, false, true, "", "rank _this in [""CORPORAL"",""SERGEANT"",""LIEUTENANT""] && (typeOf _this == ""aawInfantrySecco1_dpduDpcu"");"];

_this addAction ["Team Status", "support\modules\recruitment\TeamStatusDialog\TeamStatusDialog.sqf", [
      ["Page", "Team"], // Page to show initially (only include 1 of these 4 "Page" options)
      //["Page", "Group"],
      //["Page", "Vehicle"],
      //["Page", "Opposition"],
      "ShowAIGroups", // AI are excluded by default, but can be included with this option.
      "AllowAIRecruitment", // Place-holder code: Allow AI players to be recruited into your group from other AI groups
      "AllowPlayerInvites", // Place-holder code: Invite another real player into your group. Currently only sends a chat message.      
      //['VehicleObject', _vehicle], // usually use this with ["Page", "Vehicle"] option, good for use when in/outside of vehicle
      // you can include 1 or more of these "Hide" options to hide a particular page & button
      //"HideTeam", // hide 'team' page & button
      //"HideGroup", // hide 'group' page & button
      //"HideVehicle", // hide 'vehicle' page & button
      "HideOpposition", // hide 'opposition' page & button
      //"HideIcons", // hide icons used for vehicles & weapons lists
      "DeleteRemovedAI" // Upon removing an AI player from your group, delete the AI player
      //"AllowAILeaderSelect", // Allow player to select an AI player as new leader, otherwise only real players can be selected
      //"CloseOnKeyPress" // Close the dialog upon pressing any key.
    ], 0];
    