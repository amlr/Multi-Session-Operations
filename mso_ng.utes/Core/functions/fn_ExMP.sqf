//0, All
//1, Server
//2, Clients
//3, Local
private ["_locality","_params","_code"];

_locality = _this select 0;
_params = _this select 1;
_code = _this select 2;

"RMM_MPe" addPublicVariableEventHandler {
	private ["_data","_locality","_params","_code"];
	_data = _this select 1;
	_locality = _data select 0;
	_params = _data select 1;
	_code = _data select 2;
	
	if (switch (_locality) do {
		case 0 : {true};
		case 1 : {isserver};
		case 2 : {not isdedicated};
		default {false};
	}) then {
		if (isnil "_params") then {call _code} else {_params call _code};
	};
};

//diag_log str [_this,((not isserver) and (_locality == 1)) , (_locality in [0,2])];
if (((not isserver) and (_locality == 1)) or (_locality in [0,2])) then {
	RMM_MPe = _this;
	publicvariable "RMM_MPe"; 
};

//diag_log str [_this,(isserver and (_locality == 1)) , (_locality in [0,3]) , ((not isdedicated) and (_locality == 2))];
if ((isserver and (_locality == 1)) or (_locality in [0,3]) or ((not isdedicated) and (_locality == 2))) then {
	if (isnil "_params") then {call _code} else {_params call _code};
};

