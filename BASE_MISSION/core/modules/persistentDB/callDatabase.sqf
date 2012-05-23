// Call to database
private ["_procedureName","_parameters","_response","_databaseName"];

_databaseName = "arma";

_procedureName = _this select 0;
_parameters = _this select 1;

 // diag_log ["callExtension->Arma2NETMySQL: GetPlayer _parameters: ",  _parameters, typeName _parameters];
 
_response = "Arma2Net.Unmanaged" callExtension format ["Arma2NETMySQL ['%1','%2','%3']", _databaseName,_procedureName,_parameters];	

//diag_log ["callExtension->Arma2NETMySQL: GetPlayer _response: ",  _response, typeName _response];

_response = call compile _response;	

_response
		