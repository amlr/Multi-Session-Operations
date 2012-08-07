// Call to database
private ["_procedureName","_parameters","_response","_databaseName"];

_databaseName = "arma";

_procedureName = _this select 0;
_parameters = _this select 1;

 // diag_log ["callExtension->Arma2NETMySQL: GetPlayer _parameters: ",  _parameters, typeName _parameters];
 
if (([_parameters] call CBA_fnc_strLen) < 4096) then {
	_response = "Arma2Net.Unmanaged" callExtension format ["Arma2NETMySQL ['%1','%2','%3']", _databaseName,_procedureName,_parameters];	
	_response = call compile _response;	
} else{
	diag_log format["SERVER MSG: Output is greater than 4096 characters - NOT saving: %1", _parameters];
	_response = [];
};
 
//diag_log ["callExtension->Arma2NETMySQL: GetPlayer _response: ",  _response, typeName _response];

if (count _response > 0) then {
	_response = _response select 0;
};

//diag_log format ["Response = %1", _response];

_response
		