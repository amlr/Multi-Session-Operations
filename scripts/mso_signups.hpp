{
	if (_uid == (_x select 0)) exitwith {
		MSO_R = _x select 2;
		MSO_R_Admin = "admin" in MSO_R;
		MSO_R_Leader = (_x select 1) in ["CORPORAL","SERGEANT","LIEUTENANT"] || MSO_R_Admin;
		MSO_R_Officer = (_x select 1) == "LIEUTENANT" || MSO_R_Admin;
		MSO_R_Air = ("pilot" in MSO_R) || MSO_R_Admin;
		MSO_R_Crew = ("crew" in MSO_R) || MSO_R_Admin;
	};
} foreach [
	["822401", 		"CORPORAL",		["crew"]],	//Ryan
	["1022977",		"PRIVATE",		["crew"]],	//Glenn
	["1062145", 	"CORPORAL",		["crew"]], 	//Antipop
	["1019521", 	"PRIVATE",		["pilot"]], //Innomadic
	["1065345", 	"CORPORAL",		["pilot"]], //Tank
	["3048774",		"LIEUTENANT",	["admin"]] //Rommel
];