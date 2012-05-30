//Last modified 1/6/10
//*****************************************************************************************
//Description: Helper script that can be used to create predefined town stats.
//*****************************************************************************************
Private["_maxSV","_minSV","_nearLocations","_range","_side","_town","_townName"];

_town = _this Select 0;
_townName = _this Select 1;
_nearLocations = _this Select 2;

_range = 450;
if (Count _this > 3) then {_range = _this Select 3};
if (_range < 1) then {_range = 450};

_side = Resistance;
if (Count _this > 4) then {_side = _this Select 4};

_minSV = 10;
if (Count _this > 5) then {_minSV = _this Select 5};
if (_minSV < 0) then {_minSV = 10};

_maxSV = 60;
if (Count _this > 6) then {_maxSV = _this Select 6};
if (_maxSV < 0) then {_maxSV = 60};

//Lists below are not amount of teams created. They are random selection lists.
//Example: ["Infantry","Infantry",""InfantryAT"]
//If one team is made then 67% of it being "Infantry", 33% of it being "InfantryAT".
//Can also put blank entries ("") for a chance of nothing being made (only recommended for neutral sides).

//Large town configuration.
if (_maxSV >= 120) then
{
	//Team types - Should use team names that are available to both factions for a side.
	_town SetVariable["lightWestPatrols",["Recon","InfantryATAA","InfantryPatrol","InfantryPatrol","LargeInfantryPatrol","LightPatrol"]];
	_town SetVariable["mediumWestPatrols",["LargeATAASquad","InfantryPatrol","Recon","MediumPatrol"]];
	_town SetVariable["heavyWestPatrols",["HeavyPatrol","HeavyPatrol","InfantryPatrol","LargeInfantryPatrol","LargeInfantryPatrol","LightTankSquad","LargeMechanizedSquad","LargeHeavyMechanizedSquad"]];

	_town SetVariable["lightEastPatrols",["ReconLight","InfantryATAA","InfantryPatrol","InfantryPatrol","LargeInfantryPatrol","LightPatrol"]];
	_town SetVariable["mediumEastPatrols",["LargeATAASquad","InfantryPatrol","ReconLight","MediumPatrol"]];
	_town SetVariable["heavyEastPatrols",["HeavyPatrol","HeavyPatrol","InfantryPatrol","LargeInfantryPatrol","LargeInfantryPatrol","LightTankSquad","LargeHeavyMechanizedSquad","LargeHeavyMechanizedSquad"]];

	_town SetVariable["lightResistancePatrols",["ReconLight","InfantryATAA","InfantryPatrol","LightPatrol","InfantryPatrol","LargeInfantryPatrol"]];
	_town SetVariable["mediumResistancePatrols",["InfantryATAA","InfantryPatrol","ReconLight","MediumPatrol"]];
	_town SetVariable["heavyResistancePatrols",["HeavyPatrol","HeavyPatrol","InfantryPatrol","LargeInfantryPatrol","LargeInfantryPatrol","LargeInfantryPatrol","Tank","LargeMechanizedSquad","LargeMechanizedSquad"]];
}
else
{
	//Team types
	_town SetVariable["lightWestPatrols",["InfantryFT","InfantryWT","InfantryATAA","LargeRifleSquad","LightPatrol"]];
	_town SetVariable["mediumWestPatrols",["LargeRifleSquad","MediumPatrol","MechanizedSquad"]];
	_town SetVariable["heavyWestPatrols",["InfantryPatrol","HeavyPatrol","HeavyPatrol","LargeHeavyMechanizedSquad"]];

	_town SetVariable["lightEastPatrols",["InfantryFT","InfantryWT","InfantryATAA","LargeRifleSquad","LightPatrol"]];
	_town SetVariable["mediumEastPatrols",["LargeRifleSquad","MediumPatrol","MechanizedSquad"]];
	_town SetVariable["heavyEastPatrols",["InfantryPatrol","HeavyPatrol","HeavyPatrol","LargeHeavyMechanizedSquad"]];

	_town SetVariable["lightResistancePatrols",["InfantryFT","InfantryFT","InfantryATAA","LargeRifleSquad","LightPatrol"]];
	_town SetVariable["mediumResistancePatrols",["ReconLight","MediumPatrol","InfantryPatrol","MechanizedSquad","LargeRifleSquad"]];
	_town SetVariable["heavyResistancePatrols",["LargeRifleSquad","InfantryPatrol","HeavyPatrol","LargeMechanizedSquad"]];
};

WaitUntil {!IsNil "BIS_WF_InitLocation"};
[_town,_townName,_nearLocations,_minSV,_maxSV,_range,_side] Call BIS_WF_InitLocation;

//*****************************************************************************************
//9/7/8 MM - Created file.
