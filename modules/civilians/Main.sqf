if(isServer) then {
	createcenter sidelogic;
	_logicgrp = creategroup sidelogic;
	_logicFnc = _logicGrp createunit ["Alice2Manager",[0,0,0],[],0,"NONE"];
	_logicFnc = _logicGrp createunit ["SilvieManager",[0,0,0],[],0,"NONE"];
};

[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbCivSetup.sqf";
[] call compile preprocessfilelinenumbers "modules\civilians\crB_AmbVehSetup.sqf";

[] spawn compile preprocessFileLineNumbers "modules\civilians\CIV_City.sqf";