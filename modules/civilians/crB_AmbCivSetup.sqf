//////////////////////////////////////////////////////////////////
// Function file for Armed Assault
// Created by: (AEF)Wolffy.au [CTB]
// Created: 20101017
// Contact: http://creobellum.org
// Purpose: Setup BIS Ambient Civilians 2
///////////////////////////////////////////////////////////////////
if(!isServer) exitWith{};

waitUntil{!isNil "BIS_alice_mainscope"};

// Add some rare english speaking civilians to the mix
//BIS_alice_mainscope setVariable ["civilianRarity",["CIV_EuroWoman01_EP1", 0.5, "CIV_EuroWoman02_EP1", 0.5, "Dr_Annie_Baker_EP1", 0.5, "Rita_Ensler_EP1", 0.5, "CIV_EuroMan01_EP1", 0.5, "CIV_EuroMan02_EP1", 0.5, "Haris_Press_EP1", 0.5, "Dr_Hladik_EP1", 0.5, "Citizen2_EP1", 0.5, "Citizen3_EP1", 0.5, "Profiteer2_EP1", 0.5, "Functionary1_EP1", 1, "Functionary2_EP1", 1], true];

// See http://community.bistudio.com/wiki/Ambient_Civilians
// Reduce spawn distance to try to reduce number of civilian units
//BIS_alice_mainscope setvariable ["spawnDistance",400, true];

// Increase spawn distance for ALICE2 traffic
//BIS_alice_mainscope setvariable ["trafficDistance",500];
BIS_alice_mainscope setvariable ["trafficDistance",1000, true];

// Reduce unit count formula to try to reduce number of civilian units
//BIS_alice_mainscope setvariable ["civilianCount","round (4 * (sqrt %1))"];
BIS_alice_mainscope setvariable ["civilianCount","round (2 * (sqrt %1))", true];

// Dumb down civilian units to use less CPU (see http://creobellum.org/node/175)
[BIS_alice_mainscope,"ALICE_civilianinit",[{_this setSkill 0},{{_this disableAI _x} count ["AUTOTARGET","TARGET"]},{_this allowFleeing 1;},{removeAllWeapons _this;},{removeAllItems _this;}]] call BIS_fnc_variableSpaceAdd;

// Artificial coeficient to set how much will be town's respect decreased once some civilian is hit or killed.
// The higher the number is, the more is respect towards killer's faction decreased. 
BIS_alice_mainscope setvariable ["respectModifyCoef", 0.7, true]; 

// Value which is removed from town threat every 5 seconds (until threat reaches 0) 
BIS_alice_mainscope setvariable ["threatDecay", 0.000005, true];

/*
//[BIS_alice_mainscope,"ALICE_civilianinit",[{_this call TK_fnc_takistani}]] call BIS_fnc_variableSpaceAdd;
this setvariable [""civilianCount"",""round (%1 ^ 0.8)""];
this setvariable [""initArray"",[{_this call TK_fnc_takistani}]];
this setvariable [""threatDecay"",0.000005];
this setvariable [""RALICE_func"", {_this spawn TK_fnc_threatFunc}];
this setvariable [ ""RALICE_randomSeed"",1];
if (isserver) then {this execfsm (""fsm\ftl.fsm"");};";
*/