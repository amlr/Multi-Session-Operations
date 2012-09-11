// ----------------------------------------------------------------------------

#include <script_macros_core.hpp>
SCRIPT(test_cqb_server);

// ----------------------------------------------------------------------------

private ["_result","_err","_logic","_nearesthouse","_oldgroupcount","_oldunitcount","_unittypes","_result2","_state"];

LOG("Testing CQB Server");

// UNIT TESTS (initStrings.sqf - stringJoin)
ASSERT_DEFINED("MSO_fnc_CQB","");
ASSERT_DEFINED("MSO_fnc_getEnterableHouses","");

#define STAT(msg) ["TEST: "+msg] call MSO_fnc_logger; titleText [msg,"PLAIN"]

_err = format["Mission objects: %1", count allMissionObjects ""];
STAT(_err);

STAT("Create CQB instance");
_logic = call MSO_fnc_CQB;
_err = "instantiate object";
ASSERT_DEFINED("_logic",_err);
ASSERT_TRUE(typeName _logic == "OBJECT", _err);
STAT("Created CQB instance");

STAT("Setup debug parameters");
_logic setVariable ["debugColor","ColorRed",true];
_logic setVariable ["debugPrefix","Testing",true];
_result = [_logic, "debug", true] call MSO_fnc_CQB;
_err = "enabled debug";
ASSERT_TRUE(typeName _result == "BOOL", _err);
ASSERT_TRUE(_result, _err);

STAT("Find distant enterable houses");
_result = [_logic, "houses", [player modelToWorld [0,-100,0], 50] call MSO_fnc_getEnterableHouses] call MSO_fnc_CQB;
_err = "set houses";
ASSERT_TRUE(typeName _result == "ARRAY", _err);

STAT("Add nearest building");
// TODO - Need to test clear building with no usable buildingpos
//_nearesthouse = nearestObject [player, "House"];
waitUntil{!isNull cursorTarget};
_nearesthouse = cursorTarget;
_result = [_logic, "addHouse", _nearesthouse] call MSO_fnc_CQB;
_err = "add house";
ASSERT_TRUE(typeName _result == "ARRAY", _err);

STAT("Remove a building");
_result = [_logic, "clearHouse", ([_logic, "houses"] call MSO_fnc_CQB) select 0] call MSO_fnc_CQB;
_err = "remove house";
ASSERT_TRUE(typeName _result == "ARRAY", _err);

STAT("Set factions");
_result = [_logic, "factions", ["RU","INS"]] call MSO_fnc_CQB;
_err = "set factions";
ASSERT_TRUE(typeName _result == "ARRAY", _err);

STAT("Set spawn distance to zero (disable activity)");
_result = [_logic, "spawnDistance", 0] call MSO_fnc_CQB;
_err = "set spawn distance";
ASSERT_TRUE(typeName _result == "SCALAR", _err);

_oldgroupcount = count allGroups;
_oldunitcount = count allUnits;

STAT("Activate CQB");
[_logic, "active", true] call MSO_fnc_CQB;

sleep 5;

STAT("Check for no groups @ 0 spawn distance");
_result = [_logic, "groups"] call MSO_fnc_CQB;
_err = "check 0 groups";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result == 0, _err);
ASSERT_TRUE(count AllGroups == _oldgroupcount, _err);
ASSERT_TRUE(count allUnits == _oldunitcount, _err);

STAT("Increase spawn distance for 1 building");
[_logic, "spawnDistance", 10] call MSO_fnc_CQB;

waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) > 0)};

sleep 5;

STAT("Check for 1 new group");
_result = [_logic, "groups"] call MSO_fnc_CQB;
_err = "check 1 group";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result == 1, _err);
ASSERT_TRUE(count AllGroups == _oldgroupcount + 1, _err);
ASSERT_TRUE(count allUnits > _oldunitcount, _err);

STAT("Get and store unit types for nearest building");
_result = _nearesthouse getVariable "unittypes";
_err = "check group unittypes";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_unittypes = _result;

STAT("Save state");
_result = [_logic, "state"] call MSO_fnc_CQB;
_err = "check state";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_state = _result;

STAT("Disable debug");
_result = [_logic, "debug", false] call MSO_fnc_CQB;
_err = "disable debug";
ASSERT_TRUE(typeName _result == "BOOL", _err);
ASSERT_TRUE(!_result, _err);

STAT("Modify and re-enabled debug");
_logic setVariable ["debugColor","ColorGreen",true];
_logic setVariable ["debugPrefix","Testing2",true];
_result = [_logic, "debug", true] call MSO_fnc_CQB;
_err = "enabled debug";
ASSERT_TRUE(typeName _result == "BOOL", _err);
ASSERT_TRUE(_result, _err);

STAT("Set spawn distance to zero (disable activity)");
[_logic, "spawnDistance", 0] call MSO_fnc_CQB;

waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) == 0)};

sleep 5;

STAT("Check for no groups @ 0 spawn distance");
_result = [_logic, "groups"] call MSO_fnc_CQB;
_err = "check 0 groups";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result == 0, _err);
ASSERT_TRUE(count AllGroups == _oldgroupcount, _err);
ASSERT_TRUE(count allUnits == _oldunitcount, _err);

STAT("Check unit types remained the same");
_result = _nearesthouse getVariable "unittypes";
_err = "check group unittypes";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_result2 = [_result, _unittypes] call BIS_fnc_areEqual;
ASSERT_TRUE(_result2,_err);

STAT("Increase spawn distance for 1 building");
[_logic, "spawnDistance", 10] call MSO_fnc_CQB;

waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) > 0)};

STAT("Check for 1 new group");
_result = [_logic, "groups"] call MSO_fnc_CQB;
_err = "check 1 group";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result == 1, _err);
ASSERT_TRUE(count AllGroups == _oldgroupcount + 1, _err);
ASSERT_TRUE(count allUnits > _oldunitcount, _err);

STAT("Set spawn distance to zero (disable activity)");
[_logic, "spawnDistance", 0] call MSO_fnc_CQB;

waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) == 0)};

STAT("Check for no groups @ 0 spawn distance");
_result = [_logic, "groups"] call MSO_fnc_CQB;
_err = "check 0 groups";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result == 0, _err);
ASSERT_TRUE(count AllGroups == _oldgroupcount, _err);
ASSERT_TRUE(count allUnits == _oldunitcount, _err);

STAT("Check unit types remained the same");
_result = _nearesthouse getVariable "unittypes";
_err = "check group unittypes";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_result2 = [_result, _unittypes] call BIS_fnc_areEqual;
ASSERT_TRUE(_result2,_err);

STAT("Destroy old instance");
[_logic, "destroy"] call MSO_fnc_CQB;

_err = format["Mission objects: %1", count allMissionObjects ""];
STAT(_err);

STAT("Create new instance");
_logic = call MSO_fnc_CQB;

STAT("Activate new instance");
[_logic, "active", true] call MSO_fnc_CQB;

STAT("Setup new debug parameters");
_logic setVariable ["debugColor","ColorBlue",true];
_logic setVariable ["debugPrefix","Testing3",true];
[_logic, "debug", true] call MSO_fnc_CQB;

STAT("Restore state on new instance");
[_logic, "state", _state] call MSO_fnc_CQB;

STAT("Confirm restored state is still the same");
_result = [_logic, "state"] call MSO_fnc_CQB;
_err = "confirming restored state";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result > 0, _err);
_result2 = [_result, _state] call BIS_fnc_areEqual;
ASSERT_TRUE(_result2,_err);

STAT("Confirm unittypes have been restored correctly");
_result = _nearesthouse getVariable "unittypes";
_err = "check restored group unittypes";
_result2 = [_result, _unittypes] call BIS_fnc_areEqual;
ASSERT_TRUE(_result2,_err);

STAT("Increase spawn distance for 1 building");
[_logic, "spawnDistance", 10] call MSO_fnc_CQB;

waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) > 0)};

STAT("Check for 1 new group");
_result = [_logic, "groups"] call MSO_fnc_CQB;
_err = "check 1 group";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result == 1, _err);
ASSERT_TRUE(count AllGroups == _oldgroupcount + 1, _err);
ASSERT_TRUE(count allUnits > _oldunitcount, _err);

waitUntil{sleep 3; count units (([_logic, "groups"] call MSO_fnc_CQB) select 0) > 0};

STAT("Kill units");
_result = [_logic, "groups"] call MSO_fnc_CQB;
{
	_x setDamage 1;
} forEach units (_result select 0);

STAT("Waiting for house to clear");
waitUntil{sleep 3; (count ([_logic, "groups"] call MSO_fnc_CQB) == 0)};

STAT("Check house is cleared");
_result = [_logic, "houses"] call MSO_fnc_CQB;
_err = "check house cleared";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(!(_nearesthouse in _result), _err);

STAT("Check group is deleted");
_result = [_logic, "groups"] call MSO_fnc_CQB;
_err = "check group deletion";
ASSERT_TRUE(typeName _result == "ARRAY", _err);
ASSERT_TRUE(count _result == 0, _err);
ASSERT_TRUE(count AllGroups == _oldgroupcount, _err);
ASSERT_TRUE(count allUnits == _oldunitcount, _err);

STAT("Destroy old instance");
[_logic, "destroy"] call MSO_fnc_CQB;

_err = format["Mission objects: %1", count allMissionObjects ""];
STAT(_err);

nil;
