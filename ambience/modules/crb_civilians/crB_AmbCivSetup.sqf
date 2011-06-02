//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: (AEF)Wolffy.au [CTB]
// Created: 20101017
// Contact: http://creobellum.org
// Purpose: Setup BIS Ambient Civilians 2
///////////////////////////////////////////////////////////////////
if(!isServer) exitWith{};

waitUntil{!isNil "BIS_fnc_init"};
waitUntil{!isNil "BIS_alice_mainscope"};

// See http://community.bistudio.com/wiki/Ambient_Civilians
// Reduce spawn distance to try to reduce number of civilian units
//BIS_alice_mainscope setvariable ["spawnDistance",400, true];

// Increase spawn distance for ALICE2 traffic
//BIS_alice_mainscope setvariable ["trafficDistance",500];
switch toLower(worldName) do {		
        case "chernarus": { 
                BIS_alice_mainscope setvariable ["trafficDistance",1000];                
                BIS_alice_mainscope setvariable ["spawnDistance",700];                
                BIS_alice_mainscope setVariable ["townsFaction",["CIV","CIV_RU"]];                
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\ALICE2_houseEffects.sqf";        
        };        
        case "eden": {                
                BIS_alice_mainscope setvariable ["trafficDistance",700];                
                BIS_alice_mainscope setvariable ["spawnDistance",350];                
                BIS_alice_mainscope setVariable ["townsFaction",["CIV","CIV_RU"]];                
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\ALICE2_houseEffects.sqf";        
        };
        case "fallujah": {                
                BIS_alice_mainscope setvariable ["trafficDistance",600, true];      
                BIS_alice_mainscope setvariable ["spawnDistance",250, true];      
                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV"], true];   
                //                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV","BIS_CIV_special"], true];   
                //                [BIS_alice_mainscope, "civilianRarity",["CIV_EuroWoman01_EP1", 5, "CIV_EuroWoman02_EP1", 5, "Dr_Annie_Baker_EP1", 10, "Rita_Ensler_EP1", 10, "CIV_EuroMan01_EP1", 5, "CIV_EuroMan02_EP1", 5, "Haris_Press_EP1", 10, "Dr_Hladik_EP1", 10, "Citizen2_EP1", 5, "Citizen3_EP1", 5, "Profiteer2_EP1", 5, "Functionary1_EP1", 5, "Functionary2_EP1", 3]] call BIS_fnc_variableSpaceAdd;
        };  
        case "isladuala": {      
                BIS_alice_mainscope setvariable ["trafficDistance",1000];             
                BIS_alice_mainscope setvariable ["spawnDistance",700];            
                BIS_alice_mainscope setVariable ["civilianCount","round (5 * (sqrt %1))"];   
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\ALICE2_houseEffects.sqf";  
        };       
        case "takistan": {   
                BIS_alice_mainscope setvariable ["trafficDistance",1000];      
                BIS_alice_mainscope setvariable ["spawnDistance",700];        
                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV"], true];   
                // Add some rare english speaking civilians to the mix          
                //                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV","BIS_CIV_special"]]; 
                //                [BIS_alice_mainscope, "civilianRarity",["CIV_EuroWoman01_EP1", 5, "CIV_EuroWoman02_EP1", 5, "Dr_Annie_Baker_EP1", 10, "Rita_Ensler_EP1", 10, "CIV_EuroMan01_EP1", 5, "CIV_EuroMan02_EP1", 5, "Haris_Press_EP1", 10, "Dr_Hladik_EP1", 10, "Citizen2_EP1", 5, "Citizen3_EP1", 5, "Profiteer2_EP1", 5, "Functionary1_EP1", 5, "Functionary2_EP1", 3]] call BIS_fnc_variableSpaceAdd;
        };   
        case "torabora": {       
                BIS_alice_mainscope setvariable ["trafficDistance",1500, true];       
                BIS_alice_mainscope setvariable ["spawnDistance",600, true];        
                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV"], true];   
                //                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV","BIS_CIV_special"]];     
                //                [BIS_alice_mainscope, "civilianRarity",["CIV_EuroWoman01_EP1", 5, "CIV_EuroWoman02_EP1", 5, "Dr_Annie_Baker_EP1", 10, "Rita_Ensler_EP1", 10, "CIV_EuroMan01_EP1", 5, "CIV_EuroMan02_EP1", 5, "Haris_Press_EP1", 10, "Dr_Hladik_EP1", 10, "Citizen2_EP1", 5, "Citizen3_EP1", 5, "Profiteer2_EP1", 5, "Functionary1_EP1", 5, "Functionary2_EP1", 3]] call BIS_fnc_variableSpaceAdd;
        };
        case "utes": {        
                BIS_alice_mainscope setvariable ["trafficDistance",650];      
                BIS_alice_mainscope setvariable ["spawnDistance",500];       
                BIS_alice_mainscope setVariable ["townsFaction",["CIV","CIV_RU"]];  
                [] call compile preprocessFileLineNumbers "ambience\modules\crb_civilians\ALICE2_houseEffects.sqf";
                
        };
        case "zargabad": { 
                BIS_alice_mainscope setvariable ["trafficDistance",750];      
                BIS_alice_mainscope setvariable ["spawnDistance",600];      
                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV"], true];   
                // Add some rare english speaking civilians to the mix            
                //                BIS_alice_mainscope setVariable ["townsFaction",["BIS_TK_CIV","BIS_CIV_special"]];  
                //                [BIS_alice_mainscope, "civilianRarity",["CIV_EuroWoman01_EP1", 5, "CIV_EuroWoman02_EP1", 5, "Dr_Annie_Baker_EP1", 10, "Rita_Ensler_EP1", 10, "CIV_EuroMan01_EP1", 5, "CIV_EuroMan02_EP1", 5, "Haris_Press_EP1", 10, "Dr_Hladik_EP1", 10, "Citizen2_EP1", 5, "Citizen3_EP1", 5, "Profiteer2_EP1", 5, "Functionary1_EP1", 5, "Functionary2_EP1", 3]] call BIS_fnc_variableSpaceAdd;
        };
};

// Reduce unit count formula to try to reduce number of civilian units
//BIS_alice_mainscope setvariable ["civilianCount","round (4 * (sqrt %1))"];
//BIS_alice_mainscope setvariable ["civilianCount","round (3 * (sqrt %1))", true];

// Dumb down civilian units to use less CPU (see http://creobellum.org/node/175)
[BIS_alice_mainscope,"ALICE_civilianinit",[
        {(group _this) setVariable ["CEP_disableCache",true]},
        {_this setSkill 0}, 
        { 
                {_this disableAI _x} count ["AUTOTARGET","TARGET"]
        },
        {_this allowFleeing 1}, 
        {removeAllWeapons _this}, 
        {removeAllItems _this},
        {
                if (random 1 > 0.95 && (_this isKindOf "Woman_EP1" || _this isKindOf "Woman")) then {
                        if (random 1 > 0.5) then {
                                _this addMagazine "8Rnd_9x18_Makarov";
                                _this addMagazine "8Rnd_9x18_Makarov";
                                _this addWeapon "Makarov";
                        } else {
                                _this addMagazine "6Rnd_45ACP";
                                _this addMagazine "6Rnd_45ACP";
                                _this addWeapon "revolver_EP1";
                        };
                };
        }

]] call BIS_fnc_variableSpaceAdd;

// Artificial coeficient to set how much will be town's respect decreased once some civilian is hit or killed.
// The higher the number is, the more is respect towards killer's faction decreased. 
BIS_alice_mainscope setvariable ["respectModifyCoef", 0.7, true]; 

// Value which is removed from town threat every 5 seconds (until threat reaches 0) 
BIS_alice_mainscope setvariable ["threatDecay", 0.00005, true];
