 /* ----------------------------------------------------------------------------
Function: DAC_fnc_spawnArea

Description:
	
	
Parameters:
	- Trigger
	- GTK Plugin
	- Side
	- Unit config
	Optional
	- Config(s) (see below)
		[
			Type (0 - Infantry, 1 - Motorised, 2 - Mechanised, 3 - Helicopter)
			n Groups
			n Units/Vehicles [min, max]
			n Waypoints per group
		] or
		[
			Type (4 - Camp)
			Config Number
			Radius
			[
				Type (0 - Infantry, 1 - Motorised etc)
				etc (see above)
			]
			n Respawn Probability
			n Respawns
		]
	- AI Config

Example:
	[northernDastan, true, [east, "BIS_TK_GUE"], [0, 3, [5,9], 5], [1, 2, [1,2], 3], 0] call DAC_fnc_spawnArea
Returns:
	Nil
Author:
	Rommel

*/

_area = _this select 0;
_gtk = _this select 1;
_side = _this select 2;
_faction = _this select 3;
if (tolower (typename _faction) == "scalar") then {
	
} else {
	
};
if (count _this > 4) then {
	_config = [];
	{
		_type = _x select 0;
		_ngroups = _x select 1;
		_units = _x select 2;
		_nwaypoints = _x select 3;
		_waypoints = [];
		for "_i" from 0 to _nwaypoints do {
			_waypoints 
		}
	} foreach (_this select 4);
	_config
}

/*
if((count (_this select 5)) >= 6) then {DAC_Init_Camps = DAC_Init_Camps + ((_this select 5) select 0)};

		
		_ZoneMode 	= _this select 1;_GroupSol = _this select 2;
		_GroupVeh 	= _this select 3;_GroupTan = _this select 4;
		_GroupAir 	= _this select 5;_ZoneSide = _this select 6;
		_mxvalue 	= ((triggerArea _KiZone) select 0);_myvalue = ((triggerArea _KiZone) select 1);_ac = _ZoneMode select 1;_randomcount = random 10000;
		
		_zoneValues =	[
							[1,[(position _KiZone select 0),(position _KiZone select 1)]],
							[2,[_mxvalue,_myvalue]],
							[3,[(_ZoneSide select 1),(_ZoneSide select 2)]]
						];
	
		DAC_Init_Zone set [count DAC_Init_Zone,_randomcount];
		sleep 0.01;
		while {_cu < count _zoneValues} do
		{
			_zs = format["%1_%2",_thisZone,_cu];
			_ma = createmarkerlocal [_zs, ((_zoneValues select _cu) select 1)];
			_ma setMarkerShapelocal "RECTANGLE";
			_ma setMarkerSizelocal [6,6];
			_ma setMarkerColorlocal "ColorBlack";
			if(_ac == 1) then {_ma setMarkerSizelocal [4,4]};
			_marker set [count _marker,_ma];
			_cu = _cu + 1;
		};

		DAC_Zones set [count DAC_Zones,[_thisZone,_mxvalue,_myvalue,_ZoneMode,_GroupSol,_GroupVeh,_GroupTan,_GroupAir,_ZoneSide,_marker,_zPoly]];
		DAC_Init_Zone = DAC_Init_Zone - [_randomcount];
		//_KiZone setdir 0;		

		_zoneLoc = createLocation ["Name", position _KiZone, ((triggerArea _KiZone) select 0), ((triggerArea _KiZone) select 1)];
		_zoneLoc setDirection ((triggerArea _KiZone) select 2);
		_zoneLoc setRectangular ((triggerArea _trigger) select 3);
		_zoneLoc attachObject _KiZone;
		_zoneLoc setVariable ["DAC_Zone", _KiZone];
		_zoneLoc setVariable ["DAC_Type", "NewZone"];
		_KiZone setVariable ["DAC_ZoneLoc", _zoneLoc];

		if(DAC_StartDummy in DAC_Init_Zone) then {DAC_Init_Zone = DAC_Init_Zone - [DAC_StartDummy]};
		call compile format["z_%1 = 0",_thisZone];
		waituntil{DAC_Basic_Value == 1};
		sleep (5 + (random 1));
		if((DAC_Com_Values select 0) > 0) then {if((_ZoneMode select 1) == 1) then {DAC_Inactive_Zones set [count DAC_Inactive_Zones,_KiZone];player groupchat format["Zone %1 is deactivated",_thisZone]}};
	};
};*/