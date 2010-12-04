if(isServer) then {
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbCivSetup.sqf";
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbVehSetup.sqf";
};

if(toLower(worldName) == "zargabad") then {
	[] spawn compile preprocessFileLineNumbers "modules\civilians\CIV_City.sqf";
};

