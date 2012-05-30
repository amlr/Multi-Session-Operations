_i = "";

_unitG = _this select 0;
_Trg = objNull;

if (isNil ("RydHQ_Obj")) then {_trg = leaderHQ} else {_Trg = RydHQ_Obj};

_isAttacked = _Trg getvariable ("Capturing" + str _Trg);
if (isNil ("_isAttacked")) then {_isAttacked = 0};

_ammo = 0;

	{
	_ammo = _ammo + (count (magazines (vehicle _x)))
	}
foreach (units _unitG);

if (_ammo == 0) exitwith {if (_isAttacked == 0) then {_Trg setvariable [("Capturing" + str _Trg),0.1,true]}};

_PosObj1 = position _Trg;
_unitvar = str (_unitG);
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);

if (isNil ("_busy")) then {_busy = false};

if ((_busy) or (_unitG in RydHQ_FlankAv)) exitwith {if (_isAttacked == 0) then {_Trg setvariable [("Capturing" + str _Trg),0.1,true]}};

if (_isAttacked > 3) exitwith {};

while {(count (waypoints _unitG)) > 0} do
	{
	 deleteWaypoint ((waypoints _unitG) select 0);
	};

if (_isAttacked < 1) then {_Trg setvariable [("Capturing" + str _Trg),1,true]};

_unitG setVariable [("Busy" + _unitvar), true, true];
RydHQ_AttackAv = RydHQ_AttackAv - [_unitG];

_UL = leader _unitG;
_nothing = true;

_dX = (_PosObj1 select 0) - ((getPos leaderHQ) select 0);
_dY = (_PosObj1 select 1) - ((getPos leaderHQ) select 1);

_angle = _dX atan2 _dY;

_distance = leaderHQ distance _PosObj1;
_distance2 = 100;

_dXc = _distance2 * (cos _angle);
_dYc = _distance2 * (sin _angle);

_isAttacked = _Trg getvariable ("Capturing" + str _Trg);

if (_isAttacked == 3) then {_Trg setvariable [("Capturing" + str _Trg),4,true];_dYc = - _dYc};
if (_isAttacked == 2) then {_Trg setvariable [("Capturing" + str _Trg),3,true];_dXc = - _dXc};
if (_isAttacked == 1) then {_Trg setvariable [("Capturing" + str _Trg),2,true];_distance = _distance - _distance2,_dXc = 0;_dYc = 0};

_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getPos leaderHQ) select 0) + _dXb + _dXc + random 100 - random 100;
_posY = ((getPos leaderHQ) select 1) + _dYb + _dYc + random 100 - random 100;

_isWater = surfaceIsWater [_posX,_posY];

while {((_isWater) and (([_posX,_posY] distance _PosObj1) >= 10))} do
	{
	_posX = _posX - _dXc/20;
	_posY = _posY - _dYc/20;
	_isWater = surfaceIsWater [_posX,_posY];
	};

_isWater = surfaceIsWater [_posX,_posY];

if (_isWater) exitwith {RydHQ_AttackAv = RydHQ_AttackAv + [(_unitG)];_unitG setVariable [("Busy" + str (_unitG)), false, true]};

if (RydHQ_Debug) then 
	{
	_i = "markCapture" + str (_unitG);
	_markerposition = [_posX,_posY];
	_markercolor = "ColorRed";
	_markershape = "ICON";
	_markertype = "DOT";
	_markertext = "Cap A"; _marker = [_i, _markerposition, _markershape, [1,1], "COLOR:", _markercolor,"TEXT:",_markertext,"TYPE:",_markertype, "GLOBAL"] call CBA_fnc_createMarker;
	};

_wp = _unitG addWaypoint [[_posX,_posY], 0, 1];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointCombatMode "RED";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
_unitG setCurrentWaypoint _wp;

_alive = false;
_timer = -5;

waituntil 
	{
	sleep 6;
	if not (isNull _unitG) then {_alive = true};
	if ((speed (leader _unitG)) == 0) then {_timer = _timer + 5};
	((count (waypoints _unitG)) < 1) or (_timer > 120)
	};
if not (_alive) exitwith {if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markAttack" + str (_unitG))] call CBA_fnc_globalExecute;};};
_atpos = [];
diag_log format ["Trg = %1 at %2, PosObj1 = %3",typeof _Trg, position _Trg, _PosObj1];
if !(alive _Trg) then {_atpos = _PosObj1; } else { _atpos = position _Trg;}; 
_wp = _unitG addWaypoint [_atpos, 0, 1];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointCombatMode "RED";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
_unitG setCurrentWaypoint _wp;

_alive = false;
_timer = -5;

waituntil 
	{
	sleep 6;
	if not (isNull _unitG) then {_alive = true};
	if ((speed (leader _unitG)) == 0) then {_timer =_timer + 5};
	((count (waypoints _unitG)) < 1) or (_timer > 120)
	};
if not (_alive) exitwith {if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markAttack" + str (_unitG))] call CBA_fnc_globalExecute;};};

if (RydHQ_Debug) then {[-1,{_i setmarkercolor _this},  "ColorBlue"] call CBA_fnc_globalExecute};

sleep 60;

if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markCapture" + str (_unitG))] call CBA_fnc_globalExecute};

_all = true;

	{
	if ((_x in RydHQ_AttackAv) and not (_x getVariable ("Busy" + str (_x)))) exitwith {_all = false};
	}
foreach (RydHQ_Friends - (RydHQ_AirG + RydHQ_NavalG + RydHQ_StaticG + RydHQ_SupportG + RydHQ_ArtG));

_countAv = count RydHQ_AttackAv;
RydHQ_AttackAv = RydHQ_AttackAv + [(_unitG)];
_unitG setVariable [("Busy" + str (_unitG)), false, true];

if (((_Trg getvariable ("Capturing" + str _Trg)) > 3)  or (_all)) exitwith {_Trg setvariable [("Capturing" + str _Trg),0,true]};