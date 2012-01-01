//Last modified 3/31/10
//*****************************************************************************************
//Description: Sets mission parameters.
//*****************************************************************************************

BIS_WF_Constants SetVariable["MAXTEAMSIZE",9];	//Max units that an AI team can own.

BIS_WF_MissionDefaultSide = Civilian;
BIS_WF_Constants SetVariable["EASTSTARTINGTOWNSRATIO",0.2];
BIS_WF_Constants SetVariable["WESTSTARTINGTOWNSRATIO",0.2];
BIS_WF_Constants SetVariable["RESISTANCESTARTINGTOWNSRATIO",0.3];

westPlayerStartingFunds = 500;
eastPlayerStartingFunds = 500;
resistancePlayerStartingFunds = 500;

for [{_count = 0},{_count < 32},{_count = _count + 1}] do
{
	//Player votes.
	Call Compile Format["if (IsNil ""EastTeam%1Vote"") then {EastTeam%1Vote = -1};",_count + 1];
	Call Compile Format["if (IsNil ""WestTeam%1Vote"") then {WestTeam%1Vote = -1};",_count + 1];
	Call Compile Format["if (IsNil ""ResistanceTeam%1Vote"") then {ResistanceTeam%1Vote = -1};",_count + 1];

	//Player starting funds.
	Call Compile Format["if (IsNil ""EastPlayer%1Funds"") then {EastPlayer%1Funds = eastPlayerStartingFunds};",_count + 1];
	Call Compile Format["if (IsNil ""WestPlayer%1Funds"") then {WestPlayer%1Funds = westPlayerStartingFunds};",_count + 1];
	Call Compile Format["if (IsNil ""ResistancePlayer%1Funds"") then {ResistancePlayer%1Funds = resistancePlayerStartingFunds};",_count + 1];

	//AI starting funds.
	Call Compile Format["if (IsNil ""EastAI%1Funds"") then {EastAI%1Funds = 2000};",_count + 1];
	Call Compile Format["if (IsNil ""WestAI%1Funds"") then {WestAI%1Funds = 2000};",_count + 1];
	Call Compile Format["if (IsNil ""ResistanceAI%1Funds"") then {ResistanceAI%1Funds = 2000};",_count + 1];
};

EastAICommanderFunds = 3000;
WestAICommanderFunds = 3000;
ResistanceAICommanderFunds = 3000;

if (IsNil "EastSupplies") then {EastSupplies = 800};
if (IsNil "WestSupplies") then {WestSupplies = 800};
if (IsNil "ResistanceSupplies") then {ResistanceSupplies = 800};

[] Call Compile PreprocessFile "enemy\modules\bis_warfare\InitCommonConstants.sqf";
[] Call Compile PreprocessFile "enemy\modules\bis_warfare\ConfigTeams.sqf";
[] Call Compile PreprocessFile "enemy\modules\bis_warfare\ConfigSquads.sqf";

["Costs",{_this * 1.5},[East,West,Resistance],"Light"] Call BIS_WF_ModifyAllUnitData;
["MannedCosts",{_this * 1.5},[East,West,Resistance],"Light"] Call BIS_WF_ModifyAllUnitData;

["Costs",{_this * 2},[East,West,Resistance],"Heavy"] Call BIS_WF_ModifyAllUnitData;
["MannedCosts",{_this * 2},[East,West,Resistance],"Heavy"] Call BIS_WF_ModifyAllUnitData;

["Costs",{_this * 3},[East,West,Resistance],["Aircraft","WingedAircraft"]] Call BIS_WF_ModifyAllUnitData;
["MannedCosts",{_this * 3},[East,West,Resistance],["Aircraft","WingedAircraft"]] Call BIS_WF_ModifyAllUnitData;

//*****************************************************************************************
//1/18/7 MM - Created file.
