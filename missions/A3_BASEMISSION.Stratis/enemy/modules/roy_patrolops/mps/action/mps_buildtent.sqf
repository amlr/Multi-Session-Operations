// Inspired by Code34
// Added into framework do to popular demand

if(isNil "mps_lock_action") then { mps_lock_action = false; };
if (mps_lock_action) then {
	hint "The current operation isn't finished.";
}else{
	private ["_position", "_mydir","_light"];

	mps_lock_action = true;

	if ( ( ( position player ) distance ( getmarkerpos format["respawn_%1", ( SIDE_A select 0 ) ] ) ) < 300 ) exitwith { 
		hint "Too close to base.";
	};

	_mydir = getdir player;
	_mypos = getposatl player;
	_position =  [(getposatl player select 0) + (sin _mydir * 2), (getposatl player select 1) + (cos _mydir * 2), 0];

	if(isnil "mps_rallypoint_tent") then {

		if(!mps_debug) then {
			player playMove "AinvPknlMstpSlayWrflDnon_medic";
			sleep 8;
			if!(alive player) exitwith {mps_lock_action = false}; 
		};

		mps_rallypoint_tent = "RoadCone" createvehicle _position;
		mps_rallypoint_tent setposatl _position;
		mps_rallypoint_tent setVariable ["owner", name player, true];
		mps_rallypoint_tent setDir (_mydir - 90);

		_text = format["this addAction [""<t color='#ffc600'>Remove tent of %1</t>"", ""mps\action\mps_removetent.sqf"",[],-1,false];", name player];
		mps_rallypoint_tent setVehicleInit _text;
		processInitCommands;

		deleteMarker RALLY_MARKER;
		RALLY_MARKER = createMarkerlocal ["Respawn_Rally",_position];
		RALLY_MARKER setmarkerTypelocal "mil_dot";

		switch ( SIDE_A select 0 ) do{
			case west: { RALLY_MARKER setMarkerColorlocal "ColorBlue";};
			case east: { RALLY_MARKER setMarkerColorlocal "ColorRed"; };
			default { RALLY_MARKER setMarkerColorlocal "ColorGreen"; };
		};

		RALLY_MARKER setMarkerTextlocal " Rallypoint";
		RALLY_STATUS = true;
		hint "Rallypoint Deployed";

	} else {
		hint "Rallypoint Removed";
	};

	_light = "#lightpoint" createVehicle _mypos;//[(position mps_rallypoint_tent) select 0,(position mps_rallypoint_tent) select 1,((position mps_rallypoint_tent) select 2) + 1.6];
	_light setLightBrightness 0.0050;
	_light setLightAmbient[ 0.0, 1.0, 0.0];
	_light setLightColor [0.0, 1.0, 0.0];
//	_light lightAttachObject [mps_rallypoint_tent, [0, 0, 1.2]];

	mps_lock_action = false;

	waituntil { !alive mps_rallypoint_tent || damage mps_rallypoint_tent > 0.9 };

		deleteVehicle mps_rallypoint_tent;
		deleteVehicle _light;
		deleteMarkerlocal RALLY_MARKER;

		mps_rallypoint_tent = nil;

		hint "Rallypoint Removed";

		RALLY_STATUS = false;
}