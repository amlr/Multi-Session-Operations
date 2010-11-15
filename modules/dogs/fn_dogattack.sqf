
_victim = _this select 0;
_dog = _this select 1;

//_victim say ["scream", 10];
if (vehicle _victim isKindOf "CAManBase") then { 
_nic = [objNull, _victim, rSAY, "scream"] call RE;
};
if (vehicle _victim isKindOf "CAAnimalBase") then { 
_nic = [objNull, _victim, rSAY, "dog_yelp"] call RE;
};

_dog attachTo [_victim,[0,.8,0], "lholen"];
_dog setDir 180;

while {alive _dog && alive _victim && vehicle _victim != _victim} do {
	_victim setdamage (damage _victim + 0.1);
	_dog setDir 175 + (floor(random 3) * 5);
	sleep 1;
};
detach _dog;

if (true) exitWith {};