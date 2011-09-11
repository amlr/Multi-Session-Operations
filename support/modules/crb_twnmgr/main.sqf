//if(isDedicated) exitWith{};

if(isNil "TownManager")then{TownManager = 1;};
if (TownManager == 0) exitWith{};

if (isNil "bis_functions_mainscope") exitWith{};
waitUntil{typeName (bis_functions_mainscope getVariable "locations") == "ARRAY"};

CRB_TownMgr_debug = false;

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
                case resistance: {"GUER";};
                case civilian: {"CIV";};
                default {str _this};
        };
        
};

CRB_updateDetectedMarker = {
        private ["_name","_pos","_detector","_detected","_color","_detectorTxt"];
        _name = _this select 0;
        _pos = _this select 1;
        _detector = _this select 2;
        _detectorTxt = switch(_detector) do {
		case civilian: {"civilian"};
		case resistance: {"resistance"};
		default {str _detector};
	};
        _detected = _this select 3;
        _color = _this select 4;

	if(_detector == civilian) then {        
	        format["""%1_mgr"" setMarkerColorLocal ""%2""; [2,[], {[playerSide, ""HQ""] sideChat ""%4 intel reports %5 movement at %6 - map updated"";}] call mso_core_fnc_ExMP;", _name, _color,_detectorTxt, _detector call CRB_whichSideText, _detected call CRB_whichSideText, mapGridPosition _pos];
	} else {
	        format["""%1_mgr"" setMarkerColorLocal ""%2""; [2,[%3], {[(_this select 0), ""HQ""] sideChat ""%4 intel reports %5 movement at %6 - map updated"";}] call mso_core_fnc_ExMP;", _name, _color,_detectorTxt, _detector call CRB_whichSideText, _detected call CRB_whichSideText, mapGridPosition _pos];
	};
};

CRB_updateSeizedMarker = {
        private ["_name","_detector","_color","_detectorTxt"];
        _name = _this select 0;
        _detector = _this select 1;
        _detectorTxt = switch(_detector) do {
		case civilian: {"civilian"};
		case resistance: {"resistance"};
		default {str _detector};
	};
        _color = _this select 2;
        
        format["""%1_mgr"" setMarkerColorLocal ""%2""; [2,[%3], {[(_this select 0), ""HQ""] sideChat ""%4 intel reports %1 has been secured - map updated"";}] call mso_core_fnc_ExMP;", _name, _color, _detectorTxt, _detector call CRB_whichSideText];
};

CRB_createDetectTrigger = {
        private ["_detected","_detector","_size","_color","_pos","_name","_trg","_cond"];
        _name = _this select 0;
        _pos = _this select 1;
        _size = _this select 2;
        _detected = _this select 3;
        _detector = _this select 4;
        _color = _this select 5;
        
        _cond = switch(_detector) do {
                case civilian: {
                        "this";
                };
                default {
                        format["this && (str playerSide == ""%1"")", _detector];
                };
        };
        
        // Create the detect trigger 
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", [(_detected call CRB_whichSideTrigger), format["%1 D", _detector call CRB_whichSideTrigger], true], "STATE:",  [_cond, [_name,_pos,_detector, _detected, _color] call CRB_updateDetectedMarker, format["""%1_mgr"" setMarkerColorLocal ""ColorWhite"";", _name]]] call CBA_fnc_createTrigger;
        if(!CRB_TownMgr_debug) then {
                _trg = _trg select 0;
                if(_detector == civilian) then {
                        _trg setTriggerTimeout [180, 540, 900, true];
                } else {
                        _trg setTriggerTimeout [180, 360, 600, true];
                };
        } else {
                diag_log format["MSO-%1 Town Manager - %2", time, _trg];
        };
};

CRB_createSeizedTrigger = {
        private ["_detector","_size","_color","_pos","_name","_trg","_cond"];
        _name = _this select 0; 
        _pos = _this select 1;
        _size = _this select 2;
        _detector = _this select 3;
        _color = _this select 4;

        _cond = switch(_detector) do {
                default {
                        format["this && (getMarkerColor ""%1_mgr"" == ""ColorWhite"") && (str playerSide == ""%2"")", _name, _detector]
                };
        };
        
        // Create the detect trigger 
        _trg = [_pos, "AREA:", [_size, _size, 0, false], "ACT:", [format["%1 SEIZED", _detector call CRB_whichSideTrigger], "PRESENT", true], "STATE:",  [_cond, [_name,_detector, _color] call CRB_updateSeizedMarker,""]] call CBA_fnc_createTrigger;
        
        if(!CRB_TownMgr_debug) then {
                _trg = _trg select 0;
                _trg setTriggerTimeout [15, 30, 90, true];
        } else {
                diag_log format["MSO-%1 Town Manager - %2", time, _trg];
        };
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
        
        [_name, _pos, _size, west, "ColorBlue"] call CRB_createSeizedTrigger;

        //////////////////////////////////////////
        // GUER SEIZED Triggers
        //////////////////////////////////////////        
        
        [_name, _pos, _size, resistance, "ColorGreen"] call CRB_createSeizedTrigger;
        
        //////////////////////////////////////////
        // OPFOR SEIZED Triggers
        //////////////////////////////////////////        

        [_name, _pos, _size, east, "ColorRed"] call CRB_createSeizedTrigger;

        //////////////////////////////////////////
        // CIVILIAN DETECT Triggers
        //////////////////////////////////////////        
        
        // Create the CIVILIAN detect BLUFOR trigger  
        [_name, _pos, _size, west, civilian, "ColorBlue"] call CRB_createDetectTrigger;

        // Create the CIVILIAN detect OPFOR trigger  
        [_name, _pos, _size, west, civilian, "ColorRed"] call CRB_createDetectTrigger;

        // Create the CIVILIAN detect GUER trigger  
        [_name, _pos, _size, resistance, civilian, "ColorGreen"] call CRB_createDetectTrigger;
        
} forEach (bis_functions_mainscope getVariable "locations");
