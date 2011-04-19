private ["_area","_radius","_trg","_name","_units"];
_area = _this select 0;
_radius = _this select 1;

_name = format["%1", floor(random 10000)];
_trg = createTrigger ["EmptyDetector", position _area];
call compile format["%1 = _trg;", _name];
_trg setTriggerActivation ["ANY", "PRESENT", true];
_trg setTriggerArea [_radius,_radius,0,false];

_units = [];
sleep 1;

// Get all units in the area
_units = list _trg;

sleep 1;

// remove trigger
deleteVehicle _trg;	

_units;