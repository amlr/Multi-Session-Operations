if (isdedicated) exitwith {};

RMM_jipmarkers_types = [
	"mil_objective",
	"mil_marker",
	"mil_flag",
	"mil_ambush",
	"mil_destroy",
	"mil_start",
	"mil_end",
	"mil_pickup",
	"mil_join",
	"mil_warning",
	"mil_unknown"
];

if (isnil "RMM_jipmarkers") then {
	RMM_jipmarkers = [];
	publicvariable "RMM_jipmarkers";
} else {
	{
		if(playerSide == (_x select 4)) then {
			private "_mkr";
			_mkr = createMarkerLocal [(_x select 0),(_x select 1)];
			_mkr setmarkertypelocal (_x select 2);
			_mkr setmarkertextlocal (_x select 3);
		};
	} foreach RMM_jipmarkers;
};

["player", [mso_interaction_key], 4, ["support\modules\jipmarkers\fn_menuDef.sqf", "main"]] call CBA_ui_fnc_add;

CRB_MAPCLICK = CRB_MAPCLICK + "if (!_shift && _alt) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";};";
onMapSingleClick CRB_MAPCLICK;

"RMM_jipmarkers" addPublicVariableEventHandler {
	{
		if(str (markerPos (_x select 0)) == "[0,0,0]" && playerSide == (_x select 4)) then {
			private "_mkr";
			_mkr = createMarkerLocal [(_x select 0),(_x select 1)];
			_mkr setmarkertypelocal (_x select 2);
			_mkr setmarkertextlocal (_x select 3);
		};
	} forEach (_this select 1);
};
