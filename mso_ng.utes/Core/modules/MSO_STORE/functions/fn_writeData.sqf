private ["_result","_debug"];
_debug = false;
_result = nil;

// Write data to a data source
// Function is expecting the module name (preferably matching table name for db access) and the key/value pairs where the key would be the column id for a DB
// Values should be in string form (use the convertData function)
// Call to external datasource uses an arma2net plugin call
// For SQL this is an INSERT command followed by the column ids and values
// Outgoing calls to callExtension have a check to ensure they do not exceed 16kb
// Avoided using the format command as it has a 2kb limt

_module = _this select 0;
_params = _this select 1;

if (_debug) then {
    diag_log format["Writing Data: Len:%1 Params:(%3)  Type:%2", [_params] call CBA_fnc_strLen, _params, typeName _params];
};

// DATASOURCE = SQL|JSON|TEXT|MEMORY
// Somewhere we set global variables DATASOURCE, SQL_DATABASE_NAME etc

switch(DATASOURCE) do {
        case "SQL": {
			private ["_keys","_values","_cmd","_sql"];
			
			_keys = "";
			_values = "";
			
			// Build the SQL command
			_cmd = format ["Arma2NETMySQLCommand ['%1', 'INSERT INTO %2", SQL_DATABASE_NAME, _module];
			{
				_keys = _keys + (_x select 0) + ",";
				_values = _values + (_x select 1) + ",";
			} foreach _params;
			_sql = _cmd + " (" + _keys + ") values (" + _values + ")']";

			// Get rid of any ,) in the string
			_sql = [_sql, ",)", ")"] call CBA_fnc_replace;
			
			// Send the SQL command to the plugin
			_response = [_sql] call MSO_STORE_fnc_sendToPlugIn;
		};
		
		case "JSON": {
			private ["_pairs","_cmd","_json"];
			
			_pairs = "";
			// Build the JSON command
			_cmd = format ["SendJSON ['%1', '%2'", JSON_URL, _module];
			{
				_pairs = _pairs + (_x select 0) + ":" + (_x select 1) + ",";
			} foreach _params;
			_json = _cmd + ", {" + _pairs + "}']";
			
			// Get rid of any left over commas
			_json = [_json, ",}", "}"] call CBA_fnc_replace;
			
			// Send JSON to plugin
			_response = [_json] call MSO_STORE_fnc_sendToPlugIn;
		}
};

_response;