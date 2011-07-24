#include "script_component.hpp"

private["_groupLeader", "_group", "_saveGroupEntry", "_distArray", "_infDistance", "_vehDistance", "_airDistance"];
_groupLeader = _this select 0;
_distArray = _this select 1;

_group = group _groupLeader;


//[[ctrlData],[units]]
_saveGroupEntry = [[_groupLeader, _distArray, 0, diag_tickTime]];

_groupArray = [];
{
	private["_unit"];
	_unit = _x;
	PUSH(_groupArray, _unit);
} foreach units _group;

PUSH(_saveGroupEntry, _groupArray);

_groupLeader setVariable [QUOTE(GVAR(isLeader)), true, false];

[_saveGroupEntry] call FUNC(deactivateGroup);

// finally, save it
PUSH(GVAR(masterGroupList), _saveGroupEntry);

true