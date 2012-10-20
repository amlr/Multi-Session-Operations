_i = "";

_unitG = _this select 0;
_DefPos = _this select 1;

_ammo = 0;

	{
	_ammo = _ammo + (count (magazines (vehicle _x)))
	}
foreach (units _unitG);

if (_ammo == 0) exitwith {RydHQ_RecDefSpot = RydHQ_RecDefSpot - [_unitG];RydHQ_GoodSpots = RydHQ_GoodSpots + [_DefPos];RydHQ_Roger = true};

_unitvar = str (_unitG);
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);

if (isNil ("_busy")) then {_busy = false};

if ((_busy) and (_unitG in RydHQ_RecDefSpot)) exitwith {RydHQ_Roger = true};

while {((count (waypoints _unitG)) > 0)} do
	{
	 deleteWaypoint ((waypoints _unitG) select 0);
	};

_unitG setVariable [("Busy" + _unitvar), true, true];

_posX = (_DefPos select 0) + random 20 - random 20;
_posY = (_DefPos select 1) + random 20 - random 20;
_DefPos = [_posX,_posY];

_isWater = surfaceIsWater _DefPos;

while {((_isWater) and (leaderHQ distance _DefPos >= 10))} do
	{
	_PosX = ((_DefPos select 0) + ((position leaderHQ) select 0))/2; 
	_PosY = ((_DefPos select 1) + ((position leaderHQ) select 1))/2;
	_DefPos = [_posX,_posY]
	};

_isWater = surfaceIsWater _DefPos;

if (_isWater) exitwith {RydHQ_RecDefSpot = RydHQ_RecDefSpot - [_unitG];RydHQ_Roger = true;_unitG setVariable [("Busy" + str (_unitG)), false, true]};

if (RydHQ_Debug) then 
	{
	_i = "markDef" + str (_unitG);
	_markerposition = _DefPos;
	_markercolor = "ColorBrown";
	_markershape = "ICON";
	_markertype = "DOT";
	_markertext = "Rec A"; _marker = [_i, _markerposition, _markershape, [1,1], "COLOR:", _markercolor,"TEXT:",_markertext,"TYPE:",_markertype, "GLOBAL"] call CBA_fnc_createMarker;
	};

_wp = _unitG addWaypoint [_DefPos, 0, 1];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointCombatMode "YELLOW";
_wp setWaypointSpeed "FULL";
_wp setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
_unitG setCurrentWaypoint _wp;

RydHQ_Roger = true;

_alive = false;

_timer = -5;
waituntil 
	{
	sleep 6;
	if not (isNull _unitG) then {_alive = true};
	if ((speed (vehicle (leader _unitG))) == 0) then {_timer = _timer + 5};
	((count (waypoints _unitG)) < 1) or (_timer > 120);
	};
if not (_alive) exitwith {if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markDef" + str (_unitG))] call CBA_fnc_globalExecute};RydHQ_RecDefSpot = RydHQ_RecDefSpot - [_unitG]};

_wp = _unitG addWaypoint [_DefPos, 0, 1];
_wp setWaypointType "SENTRY";
_wp setWaypointBehaviour "STEALTH";
_wp setWaypointCombatMode "YELLOW";
_wp setWaypointSpeed "FULL";
_wp setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
_unitG setCurrentWaypoint _wp;

_TED = position leaderHQ;

_dX = 2000 * (sin RydHQ_Angle);
_dY = 2000 * (cos RydHQ_Angle);

_posX = ((getPos leaderHQ) select 0) + _dX + random 1000 - random 1000;
_posY = ((getPos leaderHQ) select 1) + _dY + random 1000 - random 1000;

_TED = [_posX,_posY];

if (RydHQ_Debug) then 
	{
	_i = "markWatch" + str (_unitG);
	_markerposition = _TED;
	_markercolor = "ColorYellow";
	_markershape = "ICON";
	_markertype = "Destroy";
	_markertext = "WatchedRec"; _marker = [_i, _markerposition, _markershape, [1,1], "COLOR:", _markercolor,"TEXT:",_markertext,"TYPE:",_markertype, "GLOBAL"] call CBA_fnc_createMarker;
	};

(units _unitG) doWatch _TED;

waituntil {sleep 1.05;RydHQ_NewOrders};

if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markDef" + str (_unitG))] call CBA_fnc_globalExecute};

(units _unitG) doWatch ObjNull;

RydHQ_RecDefSpot = RydHQ_RecDefSpot - [_unitG];

_unitG setVariable [("Busy" + _unitvar), false, true];