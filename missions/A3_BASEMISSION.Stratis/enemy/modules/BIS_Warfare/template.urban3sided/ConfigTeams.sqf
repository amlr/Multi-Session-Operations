//Last modified 5/11/10
//*****************************************************************************************
//Description: Defines teams.
//*****************************************************************************************
Private["_a","_ai","_c","_count","_d","_h","_i","_l","_n","_total"];
//ToDo: Localize _d variables only.

Private["_TEAMTYPEAA","_TEAMTYPEAT","_TEAMTYPENORMAL","_TEAMTYPEUNARMED"];
_TEAMTYPENORMAL = BIS_WF_Constants GetVariable "BIS_WF_TEAMTYPENORMAL";
_TEAMTYPEAA = BIS_WF_Constants GetVariable "BIS_WF_TEAMTYPEAA";
_TEAMTYPEAT = BIS_WF_Constants GetVariable "BIS_WF_TEAMTYPEAT";
_TEAMTYPEUNARMED = BIS_WF_Constants GetVariable "BIS_WF_TEAMTYPEUNARMED";

Private["_ARMOR","_INFANTRY","_MECHANIZED","_SPECOPS"];
_ARMOR = Localize "STR_WF_TEAMARM";
_MECHANIZED = Localize "STR_WF_TEAMMECH";
_INFANTRY = Localize "STR_WF_TEAMINF";
_SPECOPS = Localize "STR_WF_TEAMSPEC";

//WEST
_faction = (BIS_WF_Common GetVariable "WestFactions") Select 0;

_n		= ["None"];					//Variable name of team. Also the search name for functions.
_d		= ["None"];					//Name of team that is displayed in UIs. Making it blank will make it unavaible to commander for AI team assignment.
_t		= ["None"];					//Type of team: None, Infantry, SpecOp, Mechanized, Armor, Air.
_ab		= [_TEAMTYPENORMAL];//Ability of team: _TEAMTYPENORMAL, _TEAMTYPEAA, _TEAMTYPEAT. Can be added: _TEAMTYPEAA + _TEAMTYPEAT
_ai		= [false];					//If true it is only available to AI teams.
_f		= [""];						//Name of the BLUFOR/OPFOR sub-faction this team belongs to
_i		= [false];					//Infantry team.
_l		= [false];					//Light vehicles team.
_h		= [false];					//Heavy vehicles team.
_a		= [false];					//Air team.
_u		= [];
_c		= [_u];						//Classnames of units in team.

_n = _n	+ ["Infantry"];
_d = _d	+ [""];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryFT"];
_d = _d	+ ["Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_LAT_EP1"];
_u = _u + ["US_Soldier_AR_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryAT"];
_d = _d	+ ["AT Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_AT_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_HAT_DRAGON_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryAA"];
_d = _d	+ ["AA Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAA];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_AA_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_AA_EP1"];
_c = _c	+ [_u];

//Team type with this name must always be present.
_n = _n	+ ["InfantryATAA"];
_d = _d	+ ["AT/AA Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAA+_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_AA_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_AT_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantrySupport"];
_d = _d	+ ["Support Team"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_Engineer_EP1"];
_u = _u + ["US_Soldier_Engineer_EP1"];
_u = _u + ["US_Soldier_Medic_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryWT"];
_d = _d	+ ["Weapons Team"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_MG_EP1"];
_u = _u + ["US_Soldier_Medic_EP1"];
_u = _u + ["US_Soldier_MG_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["Sniper"];
_d = _d	+ ["Sniper Team"];
_t = _t + [_SPECOPS];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Delta_Force_Marksman_EP1"];
_u = _u + ["US_Delta_Force_EP1"];
_u = _u + ["US_Delta_Force_Marksman_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["BlackOps"];
_d = _d	+ ["Spec Ops Team"];
_t = _t + [_SPECOPS];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Delta_Force_EP1"];
_u = _u + ["US_Delta_Force_Marksman_EP1"];
_u = _u + ["US_Delta_Force_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["Recon"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "HMMWV_DES_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["HMMWV_M998_crows_M2_DES_EP1"];
_u = _u + ["HMMWV_M998_crows_MK19_DES_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["ReconAT"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "HMMWV_TOW_DES_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["HMMWV_TOW_DES_EP1"];
_u = _u + ["HMMWV_M998_crows_M2_DES_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["ReconAA"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "HMMWV_Avenger_DES_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAA];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["HMMWV_Avenger_DES_EP1"];
_u = _u + ["HMMWV_M998_crows_M2_DES_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "MTVR_DES_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEUNARMED];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["MTVR_DES_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedMedium"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "M1126_ICV_mk19_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["M1126_ICV_mk19_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedHeavy"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "M2A3_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["M2A3_EP1"];
_c = _c	+ [_u];

//Not really a tank team. Just gives an easy "downgrade" option for an armor team until heavy factory is available.
_n = _n	+ ["TankLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "M1126_ICV_mk19_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_LAT_EP1"];
_u = _u + ["US_Soldier_AR_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["TankMedium"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "M1A1_US_DES_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["M2A3_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["TankHeavy"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "M1A2_US_TUSK_MG_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["M1A2_US_TUSK_MG_EP1"];
_c = _c	+ [_u];

//Patrol teams for towns.
_n = _n	+ ["LightPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAA];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["US_Soldier_TL_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_LAT_EP1"];
_u = _u + ["US_Soldier_AR_EP1"];
_u = _u + ["US_Soldier_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MediumPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["US_Soldier_TL_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_LAT_EP1"];
_u = _u + ["US_Soldier_AR_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_MG_EP1"];
_u = _u + ["US_Soldier_Medic_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["HeavyPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [true];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["M2A3_EP1"];
_u = _u + ["US_Soldier_TL_EP1"];
_u = _u + ["US_Soldier_EP1"];
_u = _u + ["US_Soldier_LAT_EP1"];
_u = _u + ["US_Soldier_Medic_EP1"];
_u = _u + ["US_Soldier_MG_EP1"];
_c = _c	+ [_u];

_total = Count _n;

WestInfantryTeamTypes = [];
WestLightTeamTypes = [];
WestHeavyTeamTypes = [];
WestAirTeamTypes = [];
WestAIOnlyTeamTypes = [];

for [{_count = 0},{_count < _total},{_count = _count + 1}] do
{
	if (_i Select _count) then {WestInfantryTeamTypes = WestInfantryTeamTypes + [_count]};
	if (_l Select _count) then {WestLightTeamTypes = WestLightTeamTypes + [_count]};
	if (_h Select _count) then {WestHeavyTeamTypes = WestHeavyTeamTypes + [_count]};
	if (_a Select _count) then {WestAirTeamTypes = WestAirTeamTypes + [_count]};
	if (_ai Select _count) then {WestAIOnlyTeamTypes = WestAIOnlyTeamTypes + [_count]};
};

WestTeamTemplates = _c;
WestTeamTemplateNames = _n;
WestTeamTemplateDescriptions = _d;
WestTeamTemplateTypes = _t;
WestTeamTemplateAbilities = _ab;
WestTeamTemplateFactions = _f;

//Generate costs for each template.
WestTeamTemplateCosts = [];

{
	_cost = 0;

	{
		_data = [West,"",_x] Call BIS_WF_GetUnitData;
		if (Count _data > 0) then {_cost = _cost + (_data Select 3)};
	} ForEach _x;

	WestTeamTemplateCosts = WestTeamTemplateCosts + [_cost];
} ForEach WestTeamTemplates;

//Generate fast lookup lists for factions.
WestTeamTemplateFactionIndex = [];

//List of factions that exist for this side's team templates.
{
	if (_x != "" && !(_x In WestTeamTemplateFactionIndex)) then {WestTeamTemplateFactionIndex = WestTeamTemplateFactionIndex + [_x]};
} ForEach WestTeamTemplateFactions;

//Construct lists for each faction. This allows fast faction lookups of team names with Find command.
//(Master list may contain multiple teams with same name but different factions.)
WestTeamTemplateNamesByFaction = [];

{
	//Create list of template names for only this faction.
	_list = +WestTeamTemplateNames;
	_total = Count _list;

	for [{_count = 0},{_count < _total},{_count = _count + 1}] do
	{
		//If template belongs to different faction, clear the name. Index will be compatible with master list.
		if ((WestTeamTemplateFactions Select _count) != _x) then
		{
			_list Set [_count,""];
		};
	};

	WestTeamTemplateNamesByFaction = WestTeamTemplateNamesByFaction + [_list];
} ForEach WestTeamTemplateFactionIndex;

//AI commander preferences for AI teams.
_t		= ["InfantryFT"];
_t = _t	+ ["InfantryAT"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["InfantryWT"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["Sniper"];
_t = _t	+ ["InfantryWT"];
_t = _t	+ ["BlackOps"];
WestAITeamTemplates = _t;

//EAST
_faction = (BIS_WF_Common GetVariable "EastFactions") Select 0;

_n		= ["None"];					//Variable name of team. Also the search name for functions.
_d		= ["None"];	//Name of team that is displayed in UIs. Making it blank will make it unavaible to commander for AI team assignment.
_t		= ["None"];					//Type of team: None, Infantry, Mechanized, Armor, Air.
_ab		= [_TEAMTYPENORMAL];//Ability of team: _TEAMTYPENORMAL, BIS_WF_TEAMTYPEEAA, BIS_WF_TEAMTYPEEAT. Can be added: BIS_WF_TEAMTYPEEAA + BIS_WF_TEAMTYPEEAT
_ai		= [false];					//If true it is only available to AI teams.
_f		= [""];						//Name of the BLUFOR/OPFOR sub-faction this team belongs to
_i		= [false];					//Infantry team.
_l		= [false];					//Light vehicles team.
_h		= [false];					//Heavy vehicles team.
_a		= [false];					//Air team.
_u		= [];
_c		= [_u];						//Classnames of units in team.

_n = _n	+ ["Infantry"];
_d = _d	+ [""];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryFT"];
_d = _d	+ ["Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AR_EP1"];
_u = _u + ["TK_Soldier_RPG7_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryAT"];
_d = _d	+ ["AT Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AT_EP1"];
_u = _u + ["TK_Soldier_AR_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryAA"];
_d = _d	+ ["AA Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAA];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_AA_EP1"];
_u = _u + ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AA_EP1"];
_c = _c	+ [_u];

//Team type with this name must always be present.
_n = _n	+ ["InfantryATAA"];
_d = _d	+ ["AT/AA Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAT+_TEAMTYPEAA];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_AA_EP1"];
_u = _u + ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AT_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantrySupport"];
_d = _d	+ ["Support Team"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];

_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_Medic_EP1"];
_u = _u + ["TK_Soldier_Medic_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryWT"];
_d = _d	+ ["Weapons Team"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_MG_EP1"];
_u = _u + ["TK_Soldier_Medic_EP1"];
_u = _u + ["TK_Soldier_MG_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["Sniper"];
_d = _d	+ ["Sniper Team"];
_t = _t + [_SPECOPS];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_GL_EP1"];
_u = _u + ["TK_Soldier_Sniper_EP1"];
_u = _u + ["TK_Soldier_SniperH_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["ReconLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "UAZ" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["UAZ_AGS30_TK_EP1"];
_u = _u + ["UAZ_AGS30_TK_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["ReconHeavy"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "BTR60_TK_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["BTR60_TK_EP1"];
_u = _u + ["BTR60_TK_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "V3S_TK_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEUNARMED];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["V3S_TK_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedMedium"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "M113_TK_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["M113_TK_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedHeavy"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "BMP2_TK_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["BMP2_TK_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedHeavyAA"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "ZSU_TK_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAA];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["ZSU_TK_EP1"];
_c = _c	+ [_u];

//Not really a tank team. Just gives an easy "downgrade" option for an armor team until heavy factory is available.
_n = _n	+ ["TankLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "M113_TK_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AR_EP1"];
_u = _u + ["TK_Soldier_Medic_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["TankMedium"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "T55_TK_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["T34_TK_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["TankHeavy"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "T72_TK_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["T72_TK_EP1"];
_c = _c	+ [_u];

//Patrol teams for towns.
_n = _n	+ ["LightPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AR_EP1"];
_u = _u + ["TK_Soldier_GL_EP1"];
_u = _u + ["TK_Soldier_RPG7_EP1"];
_u = _u + ["TK_Soldier_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MediumPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AR_EP1"];
_u = _u + ["TK_Soldier_GL_EP1"];
_u = _u + ["TK_Soldier_RPG7_EP1"];
_u = _u + ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_MG_EP1"];
_u = _u + ["TK_Soldier_Medic_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["HeavyPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT+_TEAMTYPEAA];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_AR_EP1"];
_u = _u + ["TK_Soldier_RPG7_EP1"];
_u = _u + ["TK_Soldier_EP1"];
_u = _u + ["TK_Soldier_Medic_EP1"];
_u = _u + ["BMP3"];
_c = _c	+ [_u];

_total = Count _n;

EastInfantryTeamTypes = [];
EastLightTeamTypes = [];
EastHeavyTeamTypes = [];
EastAirTeamTypes = [];
EastAIOnlyTeamTypes = [];

for [{_count = 0},{_count < _total},{_count = _count + 1}] do
{
	if (_i Select _count) then {EastInfantryTeamTypes = EastInfantryTeamTypes + [_count]};
	if (_l Select _count) then {EastLightTeamTypes = EastLightTeamTypes + [_count]};
	if (_h Select _count) then {EastHeavyTeamTypes = EastHeavyTeamTypes + [_count]};
	if (_a Select _count) then {EastAirTeamTypes = EastAirTeamTypes + [_count]};
	if (_ai Select _count) then {EastAIOnlyTeamTypes = EastAIOnlyTeamTypes + [_count]};
};

EastTeamTemplates = _c;
EastTeamTemplateNames = _n;
EastTeamTemplateDescriptions = _d;
EastTeamTemplateTypes = _t;
EastTeamTemplateAbilities = _ab;
EastTeamTemplateFactions = _f;

//Generate costs for each template.
EastTeamTemplateCosts = [];

{
	_cost = 0;

	{
		_data = [East,"",_x] Call BIS_WF_GetUnitData;
		if (Count _data > 0) then {_cost = _cost + (_data Select 3)};
	} ForEach _x;

	EastTeamTemplateCosts = EastTeamTemplateCosts + [_cost];
} ForEach EastTeamTemplates;

//Generate fast lookup lists for factions.
EastTeamTemplateFactionIndex = [];

//List of factions that exist for this side's team templates.
{
	if (_x != "" && !(_x In EastTeamTemplateFactionIndex)) then {EastTeamTemplateFactionIndex = EastTeamTemplateFactionIndex + [_x]};
} ForEach EastTeamTemplateFactions;

//Construct lists for each faction. This allows fast faction lookups of team names with Find command.
//(Master list may contain multiple teams with same name but different factions.)
EastTeamTemplateNamesByFaction = [];

{
	//Create list of template names for only this faction.
	_list = +EastTeamTemplateNames;
	_total = Count _list;

	for [{_count = 0},{_count < _total},{_count = _count + 1}] do
	{
		//If template belongs to different faction, clear the name. Index will be compatible with master list.
		if ((EastTeamTemplateFactions Select _count) != _x) then
		{
			_list Set [_count,""];
		};
	};

	EastTeamTemplateNamesByFaction = EastTeamTemplateNamesByFaction + [_list];
} ForEach EastTeamTemplateFactionIndex;

//AI commander preferences for AI teams.
_t		= ["InfantryFT"];
_t = _t	+ ["InfantryAT"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["InfantryWT"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["Sniper"];
_t = _t	+ ["InfantryWT"];
_t = _t	+ ["Sniper"];
EastAITeamTemplates = _t;

//Resistance
_faction = (BIS_WF_Common GetVariable "ResistanceFactions") Select 0;

_n		= ["None"];					//Variable name of team. Also the search name for functions.
_d		= ["None"];	//Name of team that is displayed in UIs. Making it blank will make it unavaible to commander for AI team assignment.
_t		= ["None"];					//Type of team: None, Infantry, Mechanized, Armor, Air.
_ab		= [_TEAMTYPENORMAL];	//Ability of team: _TEAMTYPENORMAL, BIS_WF_TEAMTYPEEAA, BIS_WF_TEAMTYPEEAT. Can be added: BIS_WF_TEAMTYPEEAA + BIS_WF_TEAMTYPEEAT
_ai		= [false];					//If true it is only available to AI teams.
_f		= [""];
_i		= [false];					//Infantry team.
_l		= [false];					//Light vehicles team.
_h		= [false];					//Heavy vehicles team.
_a		= [false];					//Air team.
_u		= [];
_c		= [_u];						//Classnames of units in team.

_n = _n	+ ["Infantry"];
_d = _d	+ [""];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_2_EP1"];
_u = _u + ["TK_GUE_Soldier_3_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryFT"];
_d = _d	+ ["Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryWT"];
_d = _d	+ ["Weapons Team"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryAT"];
_d = _d	+ ["Anti-Tank Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_AT_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["InfantryAA"];
_d = _d	+ ["Anti-Air Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAA];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_AA_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_AA_EP1"];
_c = _c	+ [_u];

//Team type with this name must always be present.
_n = _n	+ ["InfantryATAA"];
_d = _d	+ ["AT/AA Fireteam"];
_t = _t + [_INFANTRY];
_ab=_ab + [_TEAMTYPEAT+_TEAMTYPEAA];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_AT_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_AA_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["Sniper"];
_d = _d	+ ["Sniper Team"];
_t = _t + [_SPECOPS];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_Sniper_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_Sniper_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["SpecOps"];
_d = _d	+ ["Spec Ops"];
_t = _t + [_SPECOPS];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_Sniper_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_Sniper_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["ReconLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "Offroad_DSHKM_TK_GUE_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["Offroad_DSHKM_TK_GUE_EP1"];
_u = _u + ["Pickup_PK_TK_GUE_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["ReconLightAT"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "Offroad_SPG9_TK_GUE_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["Offroad_SPG9_TK_GUE_EP1"];
_u = _u + ["Offroad_DSHKM_TK_GUE_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["ReconHeavy"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "BTR40_MG_TK_GUE_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["BTR40_MG_TK_GUE_EP1"];
_u = _u + ["BTR40_MG_TK_GUE_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "V3S_TK_GUE_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEUNARMED];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["V3S_TK_GUE_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedHeavy"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "BTR40_MG_TK_GUE_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["BTR40_MG_TK_GUE_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MechanizedAA"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "Ural_ZU23_TK_GUE_EP1" >> "displayName")];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["Ural_ZU23_TK_GUE_EP1"];
_c = _c	+ [_u];

//Not really a tank team. Just gives an easy "downgrade" option for an armor team until heavy factory is available.
_n = _n	+ ["TankLight"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "Offroad_DSHKM_TK_GUE_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["Offroad_DSHKM_TK_GUE_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["Tank"];
_d = _d	+ [GetText (configFile >> "CfgVehicles" >> "T55_TK_GUE_EP1" >> "displayName")];
_t = _t + [_ARMOR];
_ab=_ab + [_TEAMTYPEAT];
_ai=_ai	+ [false];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["T55_TK_GUE_EP1"];
_c = _c	+ [_u];

//Patrol teams for towns.
_n = _n	+ ["LightPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [false];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["MediumPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [false];
_l = _l	+ [true];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_AA_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
_u = _u + ["Offroad_DSHKM_TK_GUE_EP1"];
_c = _c	+ [_u];

_n = _n	+ ["HeavyPatrol"];
_d = _d	+ [""];
_t = _t + [_MECHANIZED];
_ab=_ab + [_TEAMTYPENORMAL];
_ai=_ai	+ [true];
_f = _f	+ [_faction];
_i = _i	+ [true];
_l = _l	+ [false];
_h = _h	+ [true];
_a = _a	+ [false];
_u		= ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_u = _u + ["TK_GUE_Bonesetter_EP1"];
_u = _u + ["BTR40_MG_TK_GUE_EP1"];
_u = _u + ["TK_GUE_Soldier_EP1"];
_u = _u + ["TK_GUE_Soldier_MG_EP1"];
_c = _c	+ [_u];

_total = Count _n;

ResistanceInfantryTeamTypes = [];
ResistanceLightTeamTypes = [];
ResistanceHeavyTeamTypes = [];
ResistanceAirTeamTypes = [];
ResistanceAIOnlyTeamTypes = [];

for [{_count = 0},{_count < _total},{_count = _count + 1}] do
{
	if (_i Select _count) then {ResistanceInfantryTeamTypes = ResistanceInfantryTeamTypes + [_count]};
	if (_l Select _count) then {ResistanceLightTeamTypes = ResistanceLightTeamTypes + [_count]};
	if (_h Select _count) then {ResistanceHeavyTeamTypes = ResistanceHeavyTeamTypes + [_count]};
	if (_a Select _count) then {ResistanceAirTeamTypes = ResistanceAirTeamTypes + [_count]};
	if (_ai Select _count) then {ResistanceAIOnlyTeamTypes = ResistanceAIOnlyTeamTypes + [_count]};
};

ResistanceTeamTemplates = _c;
ResistanceTeamTemplateNames = _n;
ResistanceTeamTemplateDescriptions = _d;
ResistanceTeamTemplateTypes = _t;
ResistanceTeamTemplateAbilities = _ab;
ResistanceTeamTemplateFactions = _f;

//Generate costs for each template.
ResistanceTeamTemplateCosts = [];

{
	_cost = 0;

	{
		_data = [Resistance,"",_x] Call BIS_WF_GetUnitData;
		if (Count _data > 0) then {_cost = _cost + (_data Select 3)};
	} ForEach _x;

	ResistanceTeamTemplateCosts = ResistanceTeamTemplateCosts + [_cost];
} ForEach ResistanceTeamTemplates;


//Generate fast lookup lists for factions.
ResistanceTeamTemplateFactionIndex = [];

//List of factions that exist for this side's team templates.
{
	if (_x != "" && !(_x In ResistanceTeamTemplateFactionIndex)) then {ResistanceTeamTemplateFactionIndex = ResistanceTeamTemplateFactionIndex + [_x]};
} ForEach ResistanceTeamTemplateFactions;

//Construct lists for each faction. This allows fast faction lookups of team names with Find command.
//(Master list may contain multiple teams with same name but different factions.)
ResistanceTeamTemplateNamesByFaction = [];

{
	//Create list of template names for only this faction.
	_list = +ResistanceTeamTemplateNames;
	_total = Count _list;

	for [{_count = 0},{_count < _total},{_count = _count + 1}] do
	{
		//If template belongs to different faction, clear the name. Index will be compatible with master list.
		if ((ResistanceTeamTemplateFactions Select _count) != _x) then
		{
			_list Set [_count,""];
		};
	};

	ResistanceTeamTemplateNamesByFaction = ResistanceTeamTemplateNamesByFaction + [_list];
} ForEach ResistanceTeamTemplateFactionIndex;

//AI commander preferences for AI teams.
_t		= ["InfantryFT"];
_t = _t	+ ["InfantryAT"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["Sniper"];
_t = _t	+ ["InfantryFT"];
_t = _t	+ ["SpecOps"];
ResistanceAITeamTemplates = _t;

//*****************************************************************************************
//9/6/8 MM - Created file.
