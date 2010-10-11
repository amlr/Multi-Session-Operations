/* (C)Rommel Von Richtofen // http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

_helo = _this select 0;
_id = _this select 2;
_veh = _this select 3;
_helo removeAction _id;

RMM_airLift_action = 0;
RMM_airLift_attached = false;
RMM_airLift_attached_vehicle = objnull;

detach _veh;