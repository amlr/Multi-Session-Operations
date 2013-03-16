_i = "";

_timer = 0;
_reconG = _this select 0;

_ammo = 0;

	{
	_ammo = _ammo + (count (magazines (vehicle _x)))
	}
foreach (units _reconG);

if (_ammo == 0) exitwith {};

_PosObj1 = _this select 1;
_recvar = str (_reconG);
_busy = false;
_busy = _reconG getvariable ("Busy" + _recvar);

if (isNil ("_busy")) then {_busy = false};

if ((_busy) or (_reconG in RydHQ_FlankAv)) exitwith {};
if (RydHQ_ReconStage > 3) exitwith {};


while {(count (waypoints _reconG)) > 0} do
	{
	 deleteWaypoint ((waypoints _reconG) select 0);
	};

_reconG setVariable [("Busy" + _recvar), true, true];

RydHQ_ReconAv = RydHQ_ReconAv - [_reconG];

_RL = leader _reconG;
_PosLand = position _RL;
_nothing = true;
_End = position leaderHQ;
_rd = 200;

_dX = (_PosObj1 select 0) - ((getPos leaderHQ) select 0);
_dY = (_PosObj1 select 1) - ((getPos leaderHQ) select 1);

_angle = _dX atan2 _dY;

_distance = leaderHQ distance _PosObj1;

_distance2 = 600;

_dXc = _distance2 * (cos _angle);
_dYc = _distance2 * (sin _angle);

if (RydHQ_ReconStage == 3) then {RydHQ_ReconStage = RydHQ_ReconStage + 1;_dYc = - _dYc};
if (RydHQ_ReconStage == 2) then {RydHQ_ReconStage = RydHQ_ReconStage + 1;_dXc = - _dXc};
if (RydHQ_ReconStage == 1) then {RydHQ_ReconStage = RydHQ_ReconStage + 1;_distance = _distance - _distance2,_dXc = 0;_dYc = 0};

_dXb = _distance * (sin _angle);
_dYb = _distance * (cos _angle);

_posX = ((getPos leaderHQ) select 0) + _dXb + _dXc + random 100 - random 100;
_posY = ((getPos leaderHQ) select 1) + _dYb + _dYc + random 100 - random 100;

_isWater = surfaceIsWater [_posX,_posY];

while {((_isWater) and (([_posX,_posY] distance _PosObj1) >= 250))} do
	{
	_posX = _posX - _dXc/20;
	_posY = _posY - _dYc/20;
	_isWater = surfaceIsWater [_posX,_posY];
	};

_isWater = surfaceIsWater [_posX,_posY];

if (_isWater) exitwith {RydHQ_ReconAv = RydHQ_ReconAv + [(_reconG)];_reconG setVariable [("Busy" + str (_reconG)), false, true]};

if (RydHQ_Debug) then 
	{
	_i = "markRecon" + str (_reconG);
	_markerposition = [_posX,_posY];
	_markercolor = "ColorRed";
	_markershape = "ICON";
	_markertype = "mil_dot";
	_markertext = "Rec A"; _marker = [_i, _markerposition, _markershape, [1,1], "COLOR:", _markercolor,"TEXT:",_markertext,"TYPE:",_markertype, "GLOBAL"] call CBA_fnc_createMarker;
	};

_wp = _reconG addWaypoint [[_posX,_posY], 0, 1];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointCombatMode "GREEN";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
_reconG setCurrentWaypoint _wp;
_alive = false;
_NNE = _RL findNearestEnemy _RL;
_timer = -5;
waituntil 
	{
	sleep 6;
	if not (isNull _reconG) then {_alive = true};
	if ((speed (leader _reconG)) == 0) then {_timer =_timer + 5};
	((((_NNE distance _RL) < 250) and ((_reconG knowsAbout _NNE) >= 0.05)) or ((count (waypoints _reconG)) < 1) or (_timer > 120));
	};

if not (_alive) exitwith {if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markRecon" + str (_reconG))] call CBA_fnc_globalExecute};};

if (RydHQ_ReconStage >= 4) then {RydHQ_ReconDone = true};

if (RydHQ_Debug) then {[-1,{_i setmarkercolor _this},  "ColorBlue"] call CBA_fnc_globalExecute};
_timer = 0;
while {(count (waypoints _reconG)) > 0} do
	{
	 deleteWaypoint ((waypoints _reconG) select 0);
	};

while {_nothing} do
	{
	if ((not (isNull (_RL findNearestEnemy _RL)) or (_timer > 4)) and not (isNull _reconG)) then 
		{
		sleep 15;
		_rd = 0;
		if (_reconG in RydHQ_AirG) then {_End = _PosLand;_rd = 0} else {_End = position leaderHQ;_rd = 200};
		_wp = _reconG addWaypoint [_End, _rd, 1];	
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointCombatMode "GREEN";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "(group this) setVariable [('Busy' + str (group this)), false, true];deleteWaypoint [group this, 0];"];
		if (_reconG in (RydHQ_reconG + RydHQ_FOG + RydHQ_snipersG + RydHQ_InfG)) then {_wp setWaypointStatements ["true", "(group this) setVariable [('Busy' + str (group this)), false, true];RydHQ_ReconAv = RydHQ_ReconAv + [(group this)];deleteWaypoint [group this, 0];"]};
		if (_reconG in RydHQ_AirG) then {_wp setWaypointStatements ["true", "(vehicle this) land 'LAND';(group this) setVariable [('Busy' + str (group this)), false, true];deleteWaypoint [group this, 0];"]};
		
		_reconG setCurrentWaypoint _wp;
		if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markRecon" + str (_reconG))] call CBA_fnc_globalExecute};;
		_nothing = false;
		_timer2 = -5;
		waituntil 
			{
			sleep 6;
			if not (isNull _reconG) then {_alive = true};
			if ((speed (vehicle (leader _reconG))) == 0) then {_timer2 = _timer2 + 5};
			((count (waypoints _reconG)) < 1) or (_timer2 > 120);
			};
		};
	sleep 15;
	if (isNull _reconG) then {_alive = false};
	if not (_alive) exitwith {if (RydHQ_Debug) then {[-1,{deleteMarker _this},  ("markRecon" + str (_reconG))] call CBA_fnc_globalExecute};};
	_timer = _timer + 1;
	};

