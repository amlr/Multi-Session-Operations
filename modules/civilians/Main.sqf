if(isServer) then {
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbCivSetup.sqf";
	[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbVehSetup.sqf";
};

if(worldName == "Zargabad") then {
	[] spawn compile preprocessFileLineNumbers "modules\civilians\CIV_City.sqf";
};

