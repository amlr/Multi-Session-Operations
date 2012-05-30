_i1 = "";
_i2 = "";
_i3 = "";
_i4 = "";

_unitG = _this select 0;
_BEnemyPos = _this select 1;
_PosMidX = _this select 2;
_PosMidY = _this select 3;
_angle0 = _this select 4;
_MinSide = _this select 5;

_safeX1 = 0;
_safeY1 = 0;

_safeX2 = 0;
_safeY2 = 0;

_GposX = (getpos (leader _unitG)) select 0;
_GposY = (getpos (leader _unitG)) select 1;

_BEposX = _BEnemyPos select 0;
_BEposY = _BEnemyPos select 1;

_dX = _BEposX - ((getpos leaderHQ) select 0);
_dY = _BEposY - ((getpos leaderHQ) select 1);

_angle = _dX atan2 _dY;

if (_angle < 0) then {_angle = _angle + 360};  
_h = 1;
if ((_angle0 > 45) and (_angle0 <= 225)) then {_h = - 1};

_BorHQD = leaderHQ distance _BEnemyPos;

_distanceSafe = 700;

_safeX1 = _h * _distanceSafe * (cos _angle);
_safeY1 = _h * _distanceSafe * (sin _angle);

_safeX2 = _distanceSafe * (sin _angle);
_safeY2 = _distanceSafe * (cos _angle);

if (_MinSide) then {_safeX1 = - _safeX1} else {_safeY1 = - _safeY1};

_FlankPosX = _BorHQD * (sin _angle);
_FlankPosY = _BorHQD * (cos _angle);

_posXWP1 = ((getPos leaderHQ) select 0) + _FlankPosX + _safeX1 + random 100 - random 100;
_posYWP1 = ((getPos leaderHQ) select 1) + _FlankPosY + _safeY1 + random 100 - random 100;

_isWater = surfaceIsWater [_posXWP1,_posYWP1];

while {((_isWater) and (([_posXWP1,_posYWP1] distance _BEnemyPos) >= 200))} do
	{
	_posXWP1 = _posXWP1 - _safeX1/20;
	_posYWP1 = _posYWP1 - _safeY1/20;
	_isWater = surfaceIsWater [_posXWP1,_posYWP1];
	};

_isWater = surfaceIsWater [_posXWP1,_posYWP1];

if (_isWater) exitwith {_unitG setVariable [("Busy" + str (_unitG)), false, true];RydHQ_FlankAv = RydHQ_FlankAv - [_unitG]};

_posXWP2 = _posXWP1 + _safeX2 + random 100 - random 100;
_posYWP2 = _posYWP1 + _safeY2 + random 100 - random 100;

_isWater = surfaceIsWater [_posXWP2,_posYWP2];

while {((_isWater) and (([_posXWP2,_posYWP2] distance _BEnemyPos) >= 200))} do
	{
	_posXWP2 = _posXWP2 - _safeX2/20;
	_posYWP2 = _posYWP2 - _safeY2/20;
	_isWater = surfaceIsWater [_posXWP2,_posYWP2];
	};

_isWater = surfaceIsWater [_posXWP2,_posYWP2];

if (_isWater) exitwith {_unitG setVariable [("Busy" + str (_unitG)), false, true];RydHQ_FlankAv = RydHQ_FlankAv - [_unitG]};

_posXWP3 = _posXWP2 - (_safeX1/2) + random 100 - random 100;
_posYWP3 = _posYWP2 - (_safeY1/2) + random 100 - random 100;

_isWater = surfaceIsWater [_posXWP3,_posYWP3];

while {((_isWater) and (([_posXWP3,_posYWP3] distance _BEnemyPos) >= 150))} do
	{
	_posXWP3 = (_posXWP3 + (_BEnemyPos select 0))/2;
	_posYWP3 = (_posYWP3 + (_BEnemyPos select 1))/2;
	_isWater = surfaceIsWater [_posXWP3,_posYWP3];
	};

_isWater = surfaceIsWater [_posXWP3,_posYWP3];

if (_isWater) exitwith {_unitG setVariable [("Busy" + str (_unitG)), false, true];RydHQ_FlankAv = RydHQ_FlankAv - [_unitG]};

_posXWP4 = _PosMidX + random 100 - random 100;
_posYWP4 = _PosMidY + random 100 - random 100;

_isWater = surfaceIsWater [_posXWP4,_posYWP4];

while {((_isWater) and (([_posXWP4,_posYWP4] distance _BEnemyPos) >= 150))} do
	{
	_posXWP3 = (_posXWP4 + (_BEnemyPos select 0))/2;
	_posYWP3 = (_posYWP4 + (_BEnemyPos select 1))/2;
	_isWater = surfaceIsWater [_posXWP4,_posYWP4];
	};

_isWater = surfaceIsWater [_posXWP4,_posYWP4];

if (_isWater) exitwith {_unitG setVariable [("Busy" + str (_unitG)), false, true];RydHQ_FlankAv = RydHQ_FlankAv - [_unitG]};

if ((leaderHQ distance [_posXWP1,_posYWP1]) > (leaderHQ distance [_posXWP2,_posYWP2])) then 
	{
	_posXWP2 = _posXWP1 - _safeX2;
	_posYWP2 = _posYWP1 - _safeY2;

	_isWater = surfaceIsWater [_posXWP2,_posYWP2];

	while {((_isWater) and (([_posXWP2,_posYWP2] distance _BEnemyPos) >= 200))} do
		{
		_posXWP2 = _posXWP2 + _safeX2/20;
		_posYWP2 = _posYWP2 + _safeY2/20;
		_isWater = surfaceIsWater [_posXWP2,_posYWP2];
		};

	_isWater = surfaceIsWater [_posXWP2,_posYWP2];
	};

if (_isWater) exitwith {_unitG setVariable [("Busy" + str (_unitG)), false, true];RydHQ_FlankAv = RydHQ_FlankAv - [_unitG]};

if (((leader _unitG) distance [_posXWP2,_posYWP2]) < ((leader _unitG) distance [_posXWP1,_posYWP1])) then {_posXWP1 = _GposX;_posYWP1 = _GposY};

_ammo = 0;

	{
	_ammo = _ammo + (count (magazines (vehicle _x)))
	}
foreach (units _unitG);

_unitvar = str (_unitG);
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);
if (isNil ("_busy")) then {_busy = false};
if ((_ammo > 0) and not (_busy)) then
	{
	_unitG setVariable [("Busy" + str (_unitG)), true, true];
	_veh = str (typeOf (Vehicle (leader (_unitG))));
	
	if (RydHQ_Debug) then 
		{
		_i1 = "markFlank" + str (_unitG);
		_marker1position = [_posXWP1,_posYWP1];
		_marker1Color ="ColorOrange";
		_marker1Shape ="ICON";
		_marker1Type ="DOT";
		_marker1Text ="Fl1 A"; _marker = [_i1, _marker1position, _marker1shape, [1,1], "COLOR:", _marker1color,"TEXT:",_marker1text,"TYPE:",_marker1type, "GLOBAL"] call CBA_fnc_createMarker;

		_i2 = "markFlank" + str (_unitG);
		_marker2position = [_posXWP2,_posYWP2];
		_marker2Color ="ColorOrange";
		_marker2Shape ="ICON";
		_marker2Type ="DOT";
		_marker2Text ="Fl2 A"; _marker = [_i2, _marker2position, _marker2shape, [1,1], "COLOR:", _marker2color,"TEXT:",_marker2text,"TYPE:",_marker2type, "GLOBAL"] call CBA_fnc_createMarker;

		_i3 = "markFlank" + str (_unitG);
		_marker3position = [_posXWP3,_posYWP3];
		_marker3Color ="ColorOrange";
		_marker3Shape ="ICON";
		_marker3Type ="DOT";
		_marker3Text ="Fl3 A"; _marker = [_i3, _marker3position, _marker3shape, [1,1], "COLOR:", _marker3color,"TEXT:",_marker3text,"TYPE:",_marker3type, "GLOBAL"] call CBA_fnc_createMarker;

		_i4 = "markFlank" + str (_unitG);
		_marker4position = [_posXWP4,_posYWP4];
		_marker4Color ="ColorOrange";
		_marker4Shape ="ICON";
		_marker4Type ="DOT";
		_marker4Text ="Fl2 A"; _marker = [_i4, _marker4position, _marker4shape, [1,1], "COLOR:", _marker4color,"TEXT:",_marker4text,"TYPE:",_marker4type, "GLOBAL"] call CBA_fnc_createMarker;
		};

	_wp1 = _unitG addWaypoint [[_posXWP1,_posYWP1], 50, 1];
	_wp1 setWaypointType "MOVE";
	_wp1 setWaypointBehaviour "AWARE";
	_wp1 setWaypointCombatMode "GREEN";
	_wp1 setWaypointSpeed "NORMAL";
	_wp1 setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
	_unitG setCurrentWaypoint _wp1;
	_alive = false;
	_timer = -5;
	waituntil 
		{
		sleep 6;
		if not (isNull _unitG) then {_alive = true};
		if ((speed (vehicle (leader _unitG))) == 0) then {_timer = _timer + 5};
		((count (waypoints _unitG)) < 1) or (_timer > 120);
		};
	if not (_alive) exitwith 
		{
		if (RydHQ_Debug) then 
			{
				{
				[-1,{deleteMarker _this},  (_x + str (_unitG))] call CBA_fnc_globalExecute;
				}
			foreach [_i1,_i2,_i3_,_i4]
			}
		};
	if (RydHQ_Debug) then {[-1,{_i1 setmarkercolor _this},  "ColorBlue"] call CBA_fnc_globalExecute};
	_wp2 = _unitG addWaypoint [[_posXWP2,_posYWP2], 50, 1];
	_wp2 setWaypointType "MOVE";
	_wp2 setWaypointBehaviour "AWARE";
	_wp2 setWaypointCombatMode "GREEN";
	_wp2 setWaypointSpeed "NORMAL";
	_wp2 setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
	_unitG setCurrentWaypoint _wp2;
	_alive = false;
	_timer = -5;
	waituntil 
		{
		sleep 6;
		if not (isNull _unitG) then {_alive = true};
		if ((speed (vehicle (leader _unitG))) == 0) then {_timer = _timer + 5};
		((count (waypoints _unitG)) < 1) or (_timer > 120);
		};
	if not (_alive) exitwith 
		{
		if (RydHQ_Debug) then 
			{
				{
				[-1,{deleteMarker _this},  (_x + str (_unitG))] call CBA_fnc_globalExecute;
				}
			foreach [_i1,_i2,_i3_,_i4]
			}
		};
	if (RydHQ_Debug) then {[-1,{_i2 setmarkercolor _this},  "ColorBlue"] call CBA_fnc_globalExecute};
	_wp3 = _unitG addWaypoint [[_posXWP3,_posYWP3], 50, 1];
	_wp3 setWaypointType "MOVE";
	_wp3 setWaypointBehaviour "AWARE";
	_wp3 setWaypointCombatMode "GREEN";
	_wp3 setWaypointSpeed "NORMAL";
	_wp3 setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
	_unitG setCurrentWaypoint _wp2;
	_alive = false;
	_timer = -5;
	waituntil 
		{
		sleep 6;
		if not (isNull _unitG) then {_alive = true};
		if ((speed (vehicle (leader _unitG))) == 0) then {_timer = _timer + 5};
		((count (waypoints _unitG)) < 1) or (_timer > 120);
		};
	if not (_alive) exitwith 
		{
		if (RydHQ_Debug) then 
			{
				{
				[-1,{deleteMarker _this},  (_x + str (_unitG))] call CBA_fnc_globalExecute;
				}
			foreach [_i1,_i2,_i3_,_i4]
			}
		};
	if (RydHQ_Debug) then {[-1,{_i3 setmarkercolor _this},  "ColorBlue"] call CBA_fnc_globalExecute};
	_wp4 = _unitG addWaypoint [[_posXWP4,_posYWP4], 200, 1];
	_wp4 setWaypointType "SAD";
	_wp4 setWaypointBehaviour "AWARE";
	_wp4 setWaypointCombatMode "RED";
	_wp4 setWaypointSpeed "NORMAL";
	_wp4 setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
	_unitG setCurrentWaypoint _wp4;

	_timer = -5;
	waituntil 
		{
		sleep 6;
		if not (isNull _unitG) then {_alive = true};
		if ((speed (vehicle (leader _unitG))) == 0) then {_timer = _timer + 5};
		((count (waypoints _unitG)) < 1) or (_timer > 120);
		};

	if not (_alive) exitwith 
		{
		if (RydHQ_Debug) then 
			{
				{
				[-1,{deleteMarker _this},  (_x + str (_unitG))] call CBA_fnc_globalExecute;
				}
			foreach [_i1,_i2,_i3_,_i4]
			}
		};

	RydHQ_FlankAv = RydHQ_FlankAv - [_unitG];
	_unitG setVariable [("Busy" + _unitvar), false, true];

	if (RydHQ_Debug) then {[-1,{_i4 setmarkercolor _this},  "ColorBlue"] call CBA_fnc_globalExecute};
	sleep 30;
	if (RydHQ_Debug) then 
		{
			{
			[-1,{deleteMarker _this},  (_x + str (_unitG))] call CBA_fnc_globalExecute;
			}
		foreach [_i1,_i2,_i3_,_i4]
		}
	};		