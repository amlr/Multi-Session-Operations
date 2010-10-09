if (isdedicated) exitwith {};

onMapSingleClick "if (_shift && _alt) then {RMM_jipmarkers_position = _pos; createDialog ""RMM_ui_jipmarkers"";};";

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
		private "_mkr";
		_mkr = createMarker ["mkr" + str(random time + 1), _x select 0];
		_mkr setmarkertypelocal (_x select 1);
		_mkr setmarkertextlocal (_x select 2);
	} foreach RMM_jipmarkers;
};