
_unitG = _this select 0;
_pos = position (leader _unitG);

if not (_unitG in (RydHQ_reconG + RydHQ_FOG + RydHQ_snipersG)) then 
	{
	 diag_log format ["MSO-%1 HETMAN: %2 is going idle, looking for static weapons to man.",time, str _unitG];
	_list = _pos nearObjects ["StaticWeapon", 200];
	_units = (units _unitG) - [leader _unitG]; 
	_staticWeapons = [];

		{
		if ((_x emptyPositions "gunner") > 0) then 
			{
			_staticWeapons = _staticWeapons + [_x];	
			};
		} 
	forEach _list;

		{
		if ((count _units) > 0) then 
			{
			if ((random 1) > 0.2) then 
				{
				_unit = (_units select ((count _units) - 1));
				
				_unit assignAsGunner _x;
				[_unit] orderGetIn true;
				
				_units resize ((count _units) - 1);
				};
			};
		} 
	forEach _staticWeapons;
	};

_position = [((position (leader _unitG)) select 0) + random 100 - random 100,((position (leader _unitG)) select 1) + random 100 - random 100];
_radius = 100;
_precision = 20;
_sourcesCount = 1;
_expression = "Meadow";
switch (true) do 
	{
	case (_x in RydHQ_InantryG) : {_expression = "(1 + (2 * Houses)) * (1 + (1.5 * Forest)) * (1 + Trees) * (1 - Meadow)"};
	case (not (_x in RydHQ_InantryG)) : {_expression = "(1 + (2 * Meadow)) * (1 - Forest) * (1 - (0.5 * Trees))"};
	};
_Spot = selectBestPlaces [_position,_radius,_expression,_precision,_sourcesCount];
_Spot = _Spot select 0;
_Spot = _Spot select 0;

_posX = _Spot select 0;
_posY = _Spot select 1;

diag_log format ["MSO-%1 HETMAN: %2 is going idle, moving to %3.",time, str _unitG, mapgridposition [_posX,_posY,0]];
_wp = _unitG addWaypoint [[_posX,_posY],0, 1];
_wp setWaypointType "SENTRY";
_wp setWaypointBehaviour "AWARE";
_wp setWaypointCombatMode "RED";
_wp setWaypointSpeed "NORMAL";
_wp setWaypointStatements ["true","deleteWaypoint [group this, 0];"];
//_unitG setCurrentWaypoint _wp;