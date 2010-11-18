waitUntil{!isNil "bis_fnc_init"};

_this addAction  ["Recruitment",CBA_fnc_actionargument_path, [[],{createDialog  "RMM_ui_recruitment"}], -1, false, true, "", "true"];
_this addAction  ["Team Status",
	"modules\recruitment\TeamStatusDialog\TeamStatusDialog.sqf",
	[["Page",  "Team"],
	"ShowAIGroups",
	"HideOpposition"], 0];
