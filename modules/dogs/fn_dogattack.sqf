
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
if (alive _dog) then {
_victim setdamage 0.3;
sleep 1;
};
if (alive _dog) then {
_dog setDir 175;
_victim setdamage 0.6;
sleep 1;
};
if (alive _dog) then {
_dog setDir 180;
_victim setdamage 0.9;
sleep 1;
};
if (alive _dog) then {
_dog setDir 185;
_victim setdamage 1;
};
detach _dog;

if (true) exitWith {};