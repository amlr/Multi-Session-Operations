//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: (AEF)Wolffy.au [CTB]
// Created: 20101017
// Contact: http://creobellum.org
// Purpose: Setup BIS Ambient Vehicles
///////////////////////////////////////////////////////////////////
if(!isServer) exitWith{};

waitUntil{!isNil "BIS_fnc_init"};
waitUntil{!isNil "BIS_silvie_mainscope"};

// http://community.bistudio.com/wiki/Ambient_Civilian_Vehicles

// formula on which basis system calculates number of vehicles for location. %1 is number of buildings (blacklisted objects are excluded) in 500 metres from location. 
// BIS_silvie_mainscope setVariable ["vehicleCount","round ((sqrt %1) * 1.5)"]; 
// Reduce vehicle count formula to try to reduce number of civilian vehicles
switch toLower(worldName) do {		
        case "chernarus": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 1.0)"];
        };
        case "eden": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 0.75)"];
        };
        case "fallujah": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 0.5)"];
        };
        case "isladuala": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 2.0)"];
        };
        case "takistan": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 1.0)"];
        };
        case "torabora": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 1.0)"];
        };
        case "utes": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 0.5)"];
        };
        case "zargabad": {
                BIS_silvie_mainscope setvariable ["vehicleCount","round ((sqrt %1) * 0.5)"];
        };
};

// Changing vehicle rarity numbers (e.g. to have village cars spawned in cities, or to disable spawning of given class completely with unusual number like 10). Default rarity numbers are set in config under rarityUrban value (in range from 0/village to 1/city) 
// BIS_silvie_mainscope setVariable ["vehicleRarity",["skodaRed",10,"skodaBlue",0.8]]; 
// add motorbikes and bicycles to Ambient Vehicles
BIS_silvie_mainscope setVariable ["vehicleRarity",[
        "MMT_Civ ", 0,
        "TT650_Civ", 0,
        "TT650_TK_CIV_EP1", 0,
        "Old_bike_TK_CIV_EP1", 0,
        "Old_moto_TK_Civ_EP1", 0
]]; 

// randomly lock and vary fuel

BIS_silvie_mainscope setVariable ["vehicleInit",{
        if (random 1>0.6) then {
                _this lock true;
        } else {

		// zGuba: enabled random damage and fuel
		_this setFuel 0.5 + ((random 1)^3 - (random 1)^3)/2;
//                _this setFuel (random 1);
		_this setDamage (random 0.5)^2;	// Up to 25% worn out
//                _this setDamage (random 0.5);
        };
        _this addEventHandler ["Engine", {
                if(_this select 1) then {
                        driver (_this select 0) addRating -400;
                };
        }];

	// zGuba: HitParts members for class Car, usually common
	_zgb_hitparts_car = ["HitEngine","HitRGlass","HitLGlass","HitBody","HitFuel","HitLFWheel","HitRFWheel","HitLF2Wheel","HitRF2Wheel","HitLMWheel","HitRMWheel","HitLBWheel","HitRBWheel","HitGlass1","HitGlass2","HitGlass3","HitGlass4"];
	{_this setHit [_x,(random 0.75)^3]} forEach _zgb_hitparts_car;	// Up to 42,1875% worn out

	//--- Alarm ;)
	if (random 1 > 0.75) then {
		_eh = _this addeventhandler ["engine",{
			_car = _this select 0;
			if (!isnil {_car getvariable "SILVIE_radio"}) exitwith {};
			if (_this select 1) then {[-2,{
				_this say3D "SILVIE_carradio";
				_this setvariable ["SILVIE_radio",true]},_car] call CBA_fnc_GlobalExecute;
			};
		}];
	};
}, true];


