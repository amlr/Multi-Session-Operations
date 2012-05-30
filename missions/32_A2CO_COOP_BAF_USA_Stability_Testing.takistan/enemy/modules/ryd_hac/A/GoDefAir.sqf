_i = "";

_unitG = _this select 0;
_StartPos = position (leader _unitG);

_ammo = 0;

	{
	_ammo = _ammo + (count (magazines (vehicle _x)))
	}
foreach (units _unitG);

if (_ammo == 0) exitwith {RydHQ_Roger = true};

_unitvar = str (_unitG);
_busy = false;
_busy = _unitG getvariable ("Busy" + _unitvar);

if (isNil ("_busy")) then {_busy = false};

if ((_busy) and (_unitG in RydHQ_AirInDef)) exitwith {RydHQ_Roger = true};

while {((count (waypoints _unitG)) > 0)} do
	{
	 deleteWaypoint ((waypoints _unitG) select 0);
	};

_unitG setVariable [("Busy" + _unitvar), true, true];

RydHQ_AirInDef = RydHQ_AirInDef + [_unitG];

RydHQ_Roger = true;

while {not (RydHQ_NewOrders)} do
	{
	_DefPos = [((position leaderHQ) select 0) + random 500 - random 500,((position leaderHQ) select 1)+ random 500 - random 500];
	if (RydHQ_Debug) then 
		{
		_i = "markDef" + str (_unitG);
		_markerposition = _DefPos;
		_markercolor = "ColorBrown";
		_markershape = "ICON";
		_markertype = "DOT";
		_markertext = "Air A"; _marker = [_i, _markerposition, _markershape, [1,1], "COLOR:", _markercolor,"TEXT:",_markertext,"TYPE:",_markertype, "GLOBAL"] call CBA_fnc_createMarker;
		};

	_wp = _unitG addWaypoint [_DefPos, 0, 1];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "AWARE";
	_wp setWaypointCombatMode "YELLOW";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
	_unitG setCurrentWaypoint _wp;

	_alive = false;

	_timer = -5;
	waituntil 
		{
		sleep 6;
		if not (isNull _unitG) then {_alive = true};
		if ((speed (vehicle (leader _unitG))) == 0) then {_timer = _timer + 5};
		((count (waypoints _unitG)) < 1) or (_timer > 120);
		}
	};

_wp = _unitG addWaypoint [_StartPos, 0, 1];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointCombatMode "GREEN";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true", "(vehicle this) land 'LAND';deleteWaypoint [group this, 0];"];
_unitG setCurrentWaypoint _wp;
_alive = false;
_timer = -5;
waituntil 
	{
	sleep 6;
	if not (isNull _unitG) then {_alive = true};
	if ((speed (vehicle (leader _unitG))) == 0) then {_timer = _timer + 5};
	((count (waypoints _unitG)) < 1) or (_timer > 120);
	};
if not (_alive) exitwith {if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markDef" + str (_unitG))] call CBA_fnc_globalExecute};RydHQ_AirInDef = RydHQ_AirInDef - [_unitG]};

sleep 30;

if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markDef" + str (_unitG))] call CBA_fnc_globalExecute};

RydHQ_AirInDef = RydHQ_AirInDef - [_unitG];
_unitG setVariable [("Busy" + _unitvar), false, true];