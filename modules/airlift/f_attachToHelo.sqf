/* (C)Rommel Von Richtofen // http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#define DETACH_FILEPATH "functions\f_detachFromHelo.sqf"
#define OBJECT_Z_OFFSET -10

_helo = _this select 0;
_id = _this select 2;
_veh = _this select 3;
_helo removeAction _id;

RMM_airLift_attached = true;
RMM_airLift_attached_vehicle = _veh;

_veh attachTo [_helo, [0,0, OBJECT_Z_OFFSET]];
RMM_airLift_action = _helo addAction [format["Detach %1", typeof _veh],DETACH_FILEPATH, _veh, 0, false, true];