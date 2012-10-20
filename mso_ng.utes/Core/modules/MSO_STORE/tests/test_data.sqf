// ----------------------------------------------------------------------------

#include <script_macros_core.hpp>
SCRIPT(test_data);

// ----------------------------------------------------------------------------

private ["_testConvert","_testRestore","_processData","_type","_original","_converted","_restored","_result","_err"];

LOG("Testing data conversion to string");

ASSERT_DEFINED("MSO_fnc_convertData","Function not defined");
ASSERT_DEFINED("MSO_fnc_restoreData","Function not defined");

#define STAT(msg) sleep 1; \
["TEST("+str player+": "+msg] call MSO_fnc_logger; \
titleText [msg,"PLAIN"]

#define STAT1(msg) CONT = false; \
waitUntil{CONT}; \
["TEST("+str player+": "+msg] call MSO_fnc_logger; \
titleText [msg,"PLAIN"]

#define MISSIONOBJECTCOUNT _err = format["Mission objects: %1", count allMissionObjects ""]; \
STAT(_err);

_testConvert = {
        private ["_err","_result"];
        PARAMS_2(_type,_input);
        _err = format["%1 conversion", _type];
        
        ASSERT_DEFINED("_type",_err);
        ASSERT_TRUE(typeName _type == "STRING",_err);
        
        ASSERT_DEFINED("_input",_err);
        ASSERT_TRUE(typeName _input == _type,_err);
        
        _result = _input call MSO_fnc_convertData;
        ASSERT_DEFINED("_result",_err);
        ASSERT_TRUE(typeName _result == "STRING",_err);
        _result;
};

_testRestore = {
        private ["_type","_err","_result","_test"];
        PARAMS_2(_type,_test);
        _err = format["%1 restore", _type];
        
        ASSERT_DEFINED("_type",_err);
        ASSERT_TRUE(typeName _type == "STRING",_err);
        
        ASSERT_DEFINED("_test",_err);
        ASSERT_TRUE(typeName _test == "STRING",_err);        
        
        _result = _test call MSO_fnc_restoreData;
        ASSERT_DEFINED("_result",_err);
        ASSERT_TRUE(typeName _result == _type,typeName _result + " == " + _type);
        _result;
};

_processData = {
        private["_result"];
        PARAMS_1(_data);
        copyToClipboard _data;
        sleep 1;
        _result = copyFromClipboard;
        ASSERT_TRUE(typeName _result == "STRING","Process Data error");
        _result;
};

sleep 5;

MISSIONOBJECTCOUNT

STAT("Test STRING");
_type = "STRING";
_original = "test string";
_converted = [_type, _original] call _testConvert;
_converted = _converted call _processData;
_restored = [_type, _converted] call _testRestore;
_result = [_original, _restored] call BIS_fnc_areEqual;
ASSERT_TRUE(_result,_original + " == " + _restored);

STAT("Test TEXT");
_type = "TEXT";
_original = text "test text string";
_converted = [_type, _original] call _testConvert;
_converted = _converted call _processData;
_restored = [_type, _converted] call _testRestore;
_result = [_original, _restored] call BIS_fnc_areEqual;
ASSERT_TRUE(_result,str _original + " == " + str _restored);

STAT("Test BOOL (false)");
_type = "BOOL";
_original = false;
_converted = [_type, _original] call _testConvert;
_converted = _converted call _processData;
_restored = [_type, _converted] call _testRestore;
ASSERT_FALSE(_restored,str _restored);

STAT("Test BOOL (true)");
_original = true;
_converted = [_type, _original] call _testConvert;
_converted = _converted call _processData;
_restored = [_type, _converted] call _testRestore;
ASSERT_TRUE(_restored,str _restored);

STAT("Test SCALAR (large)");
_type = "SCALAR";
//_original = 12376898761.123546798; // this doesn't work atm
_original = 12376900000;
_converted = [_type, _original] call _testConvert;
_converted = _converted call _processData;
_restored = [_type, _converted] call _testRestore;
_result = [_original, _restored] call BIS_fnc_areEqual;
ASSERT_TRUE(_result,str _original + " == " + str _restored);

STAT("Test SCALAR (small)");
//_original = 12376898761.123546798; // this doesn't work atm
_original = 0.123547;
_converted = [_type, _original] call _testConvert;
_converted = _converted call _processData;
_restored = [_type, _converted] call _testRestore;
_result = [_original, _restored] call BIS_fnc_areEqual;
ASSERT_TRUE(_result,str _original + " == " + str _restored);

// test "ARRAY"
// test "CODE"
// test "CONFIG"
// test "CONTROL"
// test "DISPLAY"
// test "GROUP"
// test "LOCATION"
// test "OBJECT"
// test "SCRIPT"
// test "SIDE"

MISSIONOBJECTCOUNT

/*
// find nearest house
_house = (getPos player) nearestObject "House";
_err = "no house found";
ASSERT_DEFINED("_house",_err);
ASSERT_TRUE(typeName _house == "OBJECT",_err);
[str _house, getPosATL _house, "Icon", [1, 1],"TYPE:", "Dot"] call CBA_fnc_createMarker;
*/
nil;
