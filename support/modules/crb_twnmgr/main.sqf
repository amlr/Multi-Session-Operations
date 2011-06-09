private ["_debug"];
if(!isServer) exitWith{};

if(isNil "bis_alice_mainscope") exitWith{};
waitUntil{typeName (bis_alice_mainscope getVariable "townlist") == "ARRAY"};
waitUntil{typeName (bis_alice_mainscope getVariable "ALICE_townsize") == "SCALAR"};

_debug = false;
{
        private ["_size","_name", "_pos","_trg"];
        // Get the town size
        _size = _x getVariable ["ALICE_townsize", bis_alice_mainscope getVariable "ALICE_townsize"];
        _name = _x getVariable "name";
        _pos = position _x;

        // Create the marker 
/*        _m = createMarkerLocal [format["%1_mgr", _name], _pos];
        _m setMarkerShapeLocal "ELLIPSE";
        _m setMarkerSizeLocal [_size,_size];
        _m setMarkerColorLocal "ColorWhite";
        _m setMarkerBrushLocal "Cross";
*/
        [format["%1_mgr", _name], _pos, "ELLIPSE", [_size, _size], "COLOR:", "ColorWhite", "BRUSH:", "Cross", "GLOBAL", "PERSIST"] call CBA_fnc_createMarker;
        
        // Create the BLUFOR trigger 
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["WEST SEIZED","PRESENT", true], 
        "STATE:", [
                "this", 
//                format["""%1_mgr""", _name] + " setMarkerColor ""ColorBlue""; player sideChat format[""[%1%2] has been secured"", (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 0, (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 1]",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorBlue""; [2,[], {player sideChat ""Area has been secured - map updated"";}] call mso_core_fnc_ExMP;",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorWhite"";"
        ]] call CBA_fnc_createTrigger;
	_trg = _trg select 0;
	_trg setTriggerTimeout [15, 30, 90, true];

        // Create the OPFOR trigger 
        [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["EAST","WEST D", true], 
        "STATE:",  [
                "this", 
//                format["""%1_mgr""", _name] + " setMarkerColor ""ColorRed""; player sideChat format[""Enemy spotted at [%1%2]"", (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 0, (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 1]",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorRed""; [2,[], {player sideChat ""Enemy spotted - map updated"";}] call mso_core_fnc_ExMP;",
                ""
        ]] call CBA_fnc_createTrigger;
        
        // Create the CIVILIAN trigger  
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["EAST","CIV D", true],
        "STATE:",  [
                "this", 
//                format["""%1_mgr""", _name] + " setMarkerColor ""ColorRed""; player sideChat format[""Enemy sightings at [%1%2]"", (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 0, (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 1]",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorRed""; [2,[], {player sideChat ""Enemy sightings - map updated"";}] call mso_core_fnc_ExMP;",
                ""
        ]] call CBA_fnc_createTrigger;
	_trg = _trg select 0;
	_trg setTriggerTimeout [180, 360, 900, true];

} forEach (bis_alice_mainscope getVariable "townlist");
