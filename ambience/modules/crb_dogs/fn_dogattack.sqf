private ["_victim","_dog"];
_victim = _this select 0;
_dog = _this select 1;
_dog setVariable ["attacking", true, true];

//_victim say ["scream", 10];
if (vehicle _victim isKindOf "CAManBase") then { 
        _victim say3D "scream";
};
if (vehicle _victim isKindOf "CAAnimalBase") then { 
        _victim say3D "dog_yelp";
};

_dog attachTo [_victim,[0,1,0], "lholen"];
_dog setDir 180;

while {alive _dog && alive _victim && vehicle _victim == _victim} do {
        //_victim say ["scream", 10];
        if (vehicle _victim isKindOf "CAManBase" && random 1 < 0.5) then { 
                _victim say3D "scream";
        };
        if (vehicle _victim isKindOf "CAAnimalBase" && random 1 < 0.5) then { 
                _victim say3D "dog_yelp";
        };
        
        _victim setdamage (damage _victim + 0.05);
        _dog setDir 160 + (floor(random 8) * 5);
        sleep 0.5 + random 1;
};
_victim say3D "";
detach _dog;
_dog setVariable ["attacking", false, true];

if (true) exitWith {};