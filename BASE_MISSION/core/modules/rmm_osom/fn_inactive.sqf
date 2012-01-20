hint "y";
private ["_group","_params","_array","_waypoints","_list"];
_group = _this getvariable "group";
_params = [
	side _group,
	behaviour (leader _group),
	combatmode _group,
	speedmode _group,
	formation _group
];
_array = [];
{
	private "_waypoint";
	_waypoint = [
		waypointposition _x,
		waypointtype _x,
		waypointbehaviour _x,
		waypointspeed _x,
		waypointcombatmode _x,
		waypointformation _x,
		waypointstatements _x,
		waypointtimeout _x,
		waypointhouseposition _x
	];
	_array set [count _array, _waypoint];
} foreach (waypoints _group);
_waypoints = [_array, currentwaypoint _group];
_list = [];
{
	if (alive _x) then {
		_list set [count _list, [
				typeof _x,
				getpos _x,
				weapons _x,
				magazines _x,
				assignedVehicle _x,
				assignedVehicleRole _x,
				damage _x,
				skill _x,
				rank _x
			]
		];
	};
} foreach (units _group);
_group call CBA_fnc_deleteEntity;
_this setvariable ["data",[_list,_waypoints,_params]];

diag_log format["MSO-%1 OSOM Total Units: %2", time, count allUnits];
