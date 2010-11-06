/* ----------------------------------------------------------------------------
Function: CBA_fnc_supplyDrop

Description:
	A function used to set the position of an entity.
Parameters:
	Marker, Object, Location, Group or Position
	Object or Classname
Example:
	[player, "MtvrRepair_DES_EP1"] call CBA_fnc_supplyDrop
Returns:
	[Position,Object Or Classname]
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_position","_object","_parachute"];
_position = (_this select 0) call CBA_fnc_getpos;
_object = _this select 1;

if (typename _object == "string") then {
	_object = createvehicle [_object,[0,0,1],[],0, "none"];
};
_parachute = createvehicle ["parachute_us_ep1",[0,0,100],[],0, "fly"];
_position set [2, (_position select 2) max 50];
_parachute setpos _position;

_object attachto [_parachute,[0,0,0],"paraend"];
[_object,_parachute]