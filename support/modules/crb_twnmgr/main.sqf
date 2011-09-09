private ["_debug"];
//if(isDedicated) exitWith{};

if(isNil "TownManager")then{TownManager = 1;};
if (TownManager == 0) exitWith{};

if (isNil "bis_functions_mainscope") exitWith{};
waitUntil{typeName (bis_functions_mainscope getVariable "locations") == "ARRAY"};

_debug = false;

if(isNil "twnmgr_status")then{twnmgr_status = 1;};
if(isNil "twnmgr_civ")then{twnmgr_civ = 1;};
if(isNil "twnmgr_blufor")then{twnmgr_blufor = 1;};
if(isNil "twnmgr_opfor")then{twnmgr_opfor = 1;};
if(isNil "twnmgr_tasks")then{twnmgr_tasks = 1;};

diag_log format["MSO-%1 Town Manager - Starting", time];

CRB_whichSideText = {
        switch(_this) do {
                case west: {"BLUFOR";};
                case east: {"OPFOR";};
                case resistance: {"Guerrilla";};
                case civilian: {"Civilian";};
        };
        
};

CRB_whichSideTrigger = {
        switch(_this) do {
                case west: {"WEST";};
                case east: {"EAST";};
                case resistance: {"GUER";};
                case civilian: {"CIV";};
        };
        
};

CRB_updateMarker = {
        private ["_name","_pos","_detector","_detected","_color"];
        _name = _this select 0;
        _pos = _this select 1;
        _detector = _this select 2;
        _detected = _this select 3;
        _color = _this select 4;
        
        format["""%1_mgr"" setMarkerColorLocal ""%2""; [2,[%3], {[(_this select 0), ""HQ""] sideChat ""%4 intel reports %5 movement at %6 - map updated"";}] call mso_core_fnc_ExMP;", _name, _color,_detector, _detector call CRB_whichSideText, _detected call CRB_whichSideText, mapGridPosition _pos];
};


CRB_createDetectTrigger = {
        private ["_detected","_detector","_size","_color","_pos","_name"];
        _name = _this select 0;
        _pos = _this select 1;
        _size = _this select 2;
        _detected = _this select 3;
        _detector = _this select 4;
        _color = _this select 5;
        
        // Create the detect trigger 
        _t = [_pos, "NAME:", format["%1_%2_D%3", _detected call CRB_whichSideTrigger, _detector call CRB_whichSideTrigger, ceil random 10000], "AREA:", [_size, _size, 0, false], "ACT:", [(_detected call CRB_whichSideTrigger), format["%1 D", _detector call CRB_whichSideTrigger], true], "STATE:",  [format["this && (playerSide == %1)", _detector], [_name,_pos,_detector, _detected, _color] call CRB_updateMarker,""]] call CBA_fnc_createTrigger;

	if(_debug) then {diag_log format["MSO-%1 Town Manager - %2", time, _t];};
};

{
        private ["_size","_name", "_pos","_trg"];
        // Get the town size
        _size = 250;
        _name = _x getVariable "name";
        _pos = position _x;
        
        // Create the marker 
        /*        _m = createMarkerLocal [format["%1_mgr", _name], _pos];
        _m setMarkerShapeLocal "ELLIPSE";
        _m setMarkerSizeLocal [_size,_size];
        _m setMarkerColorLocal "ColorWhite";
        _m setMarkerBrushLocal "Cross";
        */
        [format["%1_mgr", _name], _pos, "ELLIPSE", [_size, _size], "COLOR:", "ColorWhite", "BRUSH:", "Cross", "PERSIST"] call CBA_fnc_createMarker;
        
        //////////////////////////////////////////
        // BLUFOR DETECT Triggers
        //////////////////////////////////////////        
        
        // Create the BLUFOR detect EAST trigger 
        [_name, _pos, _size, east, west, "ColorRed"] call CRB_createDetectTrigger;
        // Create the BLUFOR detect GUER trigger 
        [_name, _pos, _size, resistance, west, "ColorGreen"] call CRB_createDetectTrigger;
        
        //////////////////////////////////////////
        // GUER DETECT Triggers
        //////////////////////////////////////////        

        // Create the GUER detect BLUFOR trigger 
        [_name, _pos, _size, west, resistance, "ColorBlue"] call CRB_createDetectTrigger;
        // Create the GUER detect EAST trigger 
        [_name, _pos, _size, east, resistance, "ColorRed"] call CRB_createDetectTrigger;
        
        //////////////////////////////////////////
        // OPFOR DETECT Triggers
        //////////////////////////////////////////        

        // Create the EAST detect BLUFOR trigger 
        [_name, _pos, _size, west, east, "ColorBlue"] call CRB_createDetectTrigger;
        // Create the EAST detect GUER trigger 
        [_name, _pos, _size, resistance, east, "ColorGreen"] call CRB_createDetectTrigger;
                
        //////////////////////////////////////////
        // BLUFOR SEIZED Triggers
        //////////////////////////////////////////        
        
        /*        // Create the BLUFOR trigger 
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["WEST SEIZED","PRESENT", true], 
        "STATE:", [
                "this", 
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorBlue""; [2,[], {player sideChat " + format["""%1 has been secured - map updated""", _name] + ";}] call mso_core_fnc_ExMP;",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorWhite"";"
        ]] call CBA_fnc_createTrigger;
        _trg = _trg select 0;
        _trg setTriggerTimeout [15, 30, 90, true];
        */

        //////////////////////////////////////////
        // GUER SEIZED Triggers
        //////////////////////////////////////////        

	/*
        // Create the GUER trigger 
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["GUER SEIZED","PRESENT", true], 
        "STATE:", [
                "this", 
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorGreen""; [2,[], {player sideChat " + format["""%1 has been secured - map updated""", _name] + ";}] call mso_core_fnc_ExMP;",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorWhite"";"
        ]] call CBA_fnc_createTrigger;
        _trg = _trg select 0;
        _trg setTriggerTimeout [15, 30, 90, true];
        */

        //////////////////////////////////////////
        // OPFOR SEIZED Triggers
        //////////////////////////////////////////        

	/*
        // Create the OPFOR trigger 
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["EAST SEIZED","PRESENT", true], 
        "STATE:", [
                "this", 
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorRed""; [2,[], {player sideChat " + format["""%1 has been secured - map updated""", _name] + ";}] call mso_core_fnc_ExMP;",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorWhite"";"
        ]] call CBA_fnc_createTrigger;
        _trg = _trg select 0;
        _trg setTriggerTimeout [15, 30, 90, true];
        */
        
        /*
        //////////////////////////////////////////
        // CIVILIAN DETECT Triggers
        //////////////////////////////////////////        
        
        // Create the CIVILIAN detect OPFOR trigger  
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["EAST","CIV D", true],
        "STATE:",  [
                "this", 
                //                format["""%1_mgr""", _name] + " setMarkerColor ""ColorRed""; player sideChat format[""Enemy sightings at [%1%2]"", (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 0, (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 1]",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorRed""; [2,[], {player sideChat " + format["""Civilians report enemy activity at %1 - map updated""", _grid] + ";}] call mso_core_fnc_ExMP;",
                ""
        ]] call CBA_fnc_createTrigger;
        _trg = _trg select 0;
        _trg setTriggerTimeout [180, 360, 900, true];
        
        // Create the CIVILIAN detect BLUFOR trigger  
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["WEST","CIV D", true],
        "STATE:",  [
                "this", 
                //                format["""%1_mgr""", _name] + " setMarkerColor ""ColorBlue""; player sideChat format[""Enemy sightings at [%1%2]"", (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 0, (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 1]",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorBlue""; [2,[], {player sideChat " + format["""Civilians report enemy activity at %1 - map updated""", _grid] + ";}] call mso_core_fnc_ExMP;",
                ""
        ]] call CBA_fnc_createTrigger;
        _trg = _trg select 0;
        _trg setTriggerTimeout [180, 360, 900, true];
        
        // Create the CIVILIAN detect GUER trigger  
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", ["GUER ","CIV D", true],
        "STATE:",  [
                "this", 
                //                format["""%1_mgr""", _name] + " setMarkerColor ""ColorGreen""; player sideChat format[""Enemy sightings at [%1%2]"", (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 0, (format[""%1_mgr"", _name] call BIS_fnc_PosToGrid) select 1]",
                format["""%1_mgr""", _name] + " setMarkerColor ""ColorGreen""; [2,[], {player sideChat " + format["""Civilians report enemy activity at %1 - map updated""", _grid] + ";}] call mso_core_fnc_ExMP;",
                ""
        ]] call CBA_fnc_createTrigger;
        _trg = _trg select 0;
        _trg setTriggerTimeout [180, 360, 900, true];
        */

} forEach (bis_functions_mainscope getVariable "locations");
