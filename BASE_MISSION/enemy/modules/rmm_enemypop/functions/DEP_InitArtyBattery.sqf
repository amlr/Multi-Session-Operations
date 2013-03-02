//Classes by Rydiger, thx for his FAW scripts!
private ["_grp", "_grpt","_pos","_loc", "_units","_Arty","_staticWeapons","_ModSideHQ","_so","_gp","_artymod","_magAdded","_vh","_SMOKEM119","_SMOKED30","_ILLUMM252","_ILLUMM119","_ILLUMD30","_ILLUMPODNOS","_amount",
"_BL","_mdls","_isSync","_magAdded","_SADARMM119","_SADARMD30","_HEM119","_HED30","_HEPODNOS","_HEMLRS","_HEGRAD","_WPM252","_hAmmo","_typeVh","_WPM119",
"_WPD30","_WPPODNOS","_HEM252","_WPM119","_WPD30","_WPPODNOS","_ready","_CheckRange"];

if (isnil "RydFAW_Howitzer") then {RydFAW_Howitzer = ["M119","M119_US_EP1","D30_CDF","D30_Ins","D30_RU","D30_TK_EP1","D30_TK_GUE_EP1","D30_TK_INS_EP1"];};
if (isnil "RydFAW_Mortar") then {RydFAW_Mortar = ["M252","M252_US_EP1","2b14_82mm_CDF","2b14_82mm_GUE","2b14_82mm_INS","2b14_82mm_TK_EP1","2b14_82mm_TK_GUE_EP1","2b14_82mm_TK_INS_EP1"];};
if (isnil "RydFAW_Rocket") then {RydFAW_Rocket = ["MLRS","MLRS_DES_EP1","GRAD_CDF","GRAD_INS","GRAD_RU","GRAD_TK_EP1"];};
if (isnil "MSO_fnc_getrandomgrouptype") then {MSO_fnc_getrandomgrouptype = compile preprocessFileLineNumbers "enemy\modules\rmm_enemypop\functions\MSO_fnc_getrandomgrouptype.sqf"};

_loc = _this select 0;
_pos = position _loc;

_grpt = ["Infantry", MSO_FACTIONS] call MSO_fnc_getrandomgrouptype;
_grp = [_pos, _grpt select 0, _grpt select 1] call BIS_fnc_spawnGroup;
_ArtyGroup = creategroup (side leader _grp);
_units = units _grp;
_debug = debug_mso;

_staticWeapons = [];
_list = _pos nearObjects ["LandVehicle", 50];

{
    if (((_x emptyPositions "gunner") > 0) && {(typeof _x) in (RydFAW_Howitzer + RydFAW_Mortar + RydFAW_Rocket)}) then {
        _staticWeapons set [count _staticWeapons, _x];
    };
} forEach _list;

{
    if ((count _units) > 0) then 
    {
        private ["_unit"];
        _unit = (_units select ((count _units) - 1));
    
        _unit assignAsGunner _x;
        [_unit] orderGetIn true;
        _unit moveInGunner _x;
		[_unit] join _ArtyGroup;

        _units resize ((count _units) - 1);
    };
} forEach _staticWeapons;

{deletevehicle _x} foreach units _grp;
deletegroup _grp;

//By Rydiger! Thankx for the FAW scripts!
_amount = 240;

if (isnull _ArtyGroup) exitWith {};
_ArtyGroup setBehaviour "SAFE";
_ArtyGroup setSpeedmode "LIMITED";

_BL = leader _ArtyGroup;

_so = synchronizedObjects _BL;
_mdls = (position leader _ArtyGroup) nearEntities [["BIS_ARTY_Logic"], 50];
_loc = nearestObject [(position leader _ArtyGroup), "Can_small"];
_isSync = false;

	{
		if (_BL in (synchronizedObjects _x)) exitWith {_isSync = true};
	}
foreach _mdls;

if ((({(typeOf _ArtyGroup) in ["BIS_ARTY_Logic"]} count _so) == 0) and not (_isSync)) then {
	_gp = creategroup sideLogic;
	_artymod = _gp createUnit ["BIS_ARTY_Logic", position _loc, [], 0, "NONE"];
	_artymod synchronizeObjectsAdd [(leader _ArtyGroup)];
    _tC = time;
    _fail = false;

	waitUntil {
        _fail = time - _tC > 10;
		_ready = _artymod getVariable "ARTY_ONMISSION";
		(!(isNil "_ready") || _fail);
	};
};

if (!(isnil "_fail") && {_fail}) exitwith {
	if (_debug) then {diag_log format ["MSO-%1 DEP Artillery Battery initialising failed %2",time,_artymod]};

};

_hAmmo = _ArtyGroup getVariable "HEAmmo";

if (isNil "_hAmmo") then 
	{
	_vh = assignedvehicle (leader _ArtyGroup);
	_typeVh = typeOf _vh;

	_ArtyGroup setVariable ["HEAmmo",_amount];
	if (_typeVh in (RydFAW_Howitzer + RydFAW_Mortar)) then {_ArtyGroup setVariable ["IllumAmmo",_amount]};
	if (_typeVh in (RydFAW_Howitzer + RydFAW_Mortar)) then {_ArtyGroup setVariable ["WPAmmo",_amount]};
	if (_typeVh in RydFAW_Howitzer) then {_ArtyGroup setVariable ["SmokeAmmo",_amount]};
	if (_typeVh in RydFAW_Howitzer) then {_ArtyGroup setVariable ["SADARMAmmo",ceil (_amount/10)]};

	_magAdded = [];

		{
		_vh = vehicle _x;
		if not (_vh in _magAdded) then
			{
			_magAdded set [(count _magAdded),_vh];
			_SMOKEM119 = "ARTY_30Rnd_105mmSMOKE_M119";
			_SMOKED30 = "ARTY_30Rnd_122mmSMOKE_D30";

			_SADARMM119 = "ARTY_30Rnd_105mmSADARM_M119";
			_SADARMD30 = "ARTY_30Rnd_122mmSADARM_D30";

			_ILLUMM252 = "ARTY_8Rnd_81mmILLUM_M252";
			_ILLUMM119 = "ARTY_30Rnd_105mmILLUM_M119";
			_ILLUMD30 = "ARTY_30Rnd_122mmILLUM_D30";
			_ILLUMPODNOS = "ARTY_8Rnd_82mmILLUM_2B14";

			_HEM252 = "ARTY_8Rnd_81mmHE_M252";
			_HEM119 = "ARTY_30Rnd_105mmHE_M119";
			_HED30 = "ARTY_30Rnd_122mmHE_D30";
			_HEPODNOS = "ARTY_8Rnd_82mmHE_2B14";
			_HEMLRS = "ARTY_12Rnd_227mmHE_M270";
			_HEGRAD = "ARTY_40Rnd_120mmHE_BM21";

			_WPM252 = "ARTY_8Rnd_81mmWP_M252";
			_WPM119 = "ARTY_30Rnd_105mmWP_M119";
			_WPD30 = "ARTY_30Rnd_122mmWP_D30";
			_WPPODNOS = "ARTY_8Rnd_82mmWP_2B14";

			switch (typeOf _vh) do
				{
				case	"M119" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKEM119;
					_vh addMagazine _ILLUMM119;
					_vh addMagazine _HEM119;
					_vh addMagazine _WPM119;
					_vh addMagazine _SADARMM119;
					}};

				case	"M119_US_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKEM119;
					_vh addMagazine _ILLUMM119;
					_vh addMagazine _HEM119;
					_vh addMagazine _WPM119;
					_vh addMagazine _SADARMM119;
					}};

				case	"D30_RU" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKED30;
					_vh addMagazine _ILLUMD30;
					_vh addMagazine _HED30;
					_vh addMagazine _WPD30;
					_vh addMagazine _SADARMD30;
					}};

				case	"D30_INS" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKED30;
					_vh addMagazine _ILLUMD30;
					_vh addMagazine _HED30;
					_vh addMagazine _WPD30;
					_vh addMagazine _SADARMD30;
					}};

				case	"D30_CDF" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKED30;
					_vh addMagazine _ILLUMD30;
					_vh addMagazine _HED30;
					_vh addMagazine _WPD30;
					_vh addMagazine _SADARMD30;
					}};

				case	"D30_TK_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKED30;
					_vh addMagazine _ILLUMD30;
					_vh addMagazine _HED30;
					_vh addMagazine _WPD30;
					_vh addMagazine _SADARMD30;
					}};

				case	"D30_TK_GUE_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKED30;
					_vh addMagazine _ILLUMD30;
					_vh addMagazine _HED30;
					_vh addMagazine _WPD30;
					_vh addMagazine _SADARMD30;
					}};

				case	"D30_TK_INS_EP1" : {for "_i" from 1 to (ceil (_amount/30)) do 
					{
					_vh addMagazine _SMOKED30;
					_vh addMagazine _ILLUMD30;
					_vh addMagazine _HED30;
					_vh addMagazine _WPD30;
					_vh addMagazine _SADARMD30;
					}};

				case	"MLRS" : {for "_i" from 1 to (ceil (_amount/12)) do 
					{
					_vh addMagazine _HEMLRS;
					}};

				case	"MLRS_DES_EP1" : {for "_i" from 1 to (ceil (_amount/12)) do 
					{
					_vh addMagazine _HEMLRS;
					}};

				case	"GRAD_CDF" : {for "_i" from 1 to (ceil (_amount/40)) do 
					{
					_vh addMagazine _HEGRAD;
					}};

				case	"GRAD_INS" : {for "_i" from 1 to (ceil (_amount/40)) do 
					{
					_vh addMagazine _HEGRAD;
					}};

				case	"GRAD_RU" : {for "_i" from 1 to (ceil (_amount/40)) do 
					{
					_vh addMagazine _HEGRAD;
					}};

				case	"GRAD_TK_EP1" : {for "_i" from 1 to (ceil (_amount/40)) do 
					{
					_vh addMagazine _HEGRAD;
					}};

				case	"M252" : {for "_i" from 1 to (ceil (_amount/8)) do 
					{
					_vh addMagazine _ILLUMM252;
					_vh addMagazine _HEM252;
					_vh addMagazine _WPM252;
					}};

				case	"M252_US_EP1" : {for "_i" from 1 to (ceil (_amount/8)) do 
					{
					_vh addMagazine _ILLUMM252;
					_vh addMagazine _HEM252;
					_vh addMagazine _WPM252;
					}};

				default {for "_i" from 1 to (ceil (_amount/8)) do 
					{
					_vh addMagazine _ILLUMPODNOS;
					_vh addMagazine _HEPODNOS;
					_vh addMagazine _WPPODNOS;
					}};
				}
			}
		}
	foreach (units _ArtyGroup);
};

[_artymod, "HE"] call BIS_ARTY_F_LoadMapRanges;
_CheckRange = _artymod getvariable "ARTY_MAX_RANGE";

if !(isnil "_CheckRange") then {
    if (_debug) then {diag_log format ["MSO-%1 DEP Artillery Battery initialised %2",time,_artymod]};
	_loc setvariable ["Artillery",_artymod,true]; 
    ARTILLERIES set [count ARTILLERIES,_artymod]; 
    Publicvariable "ARTILLERIES";
} else {
   if (_debug) then {diag_log format ["MSO-%1 DEP Artillery Battery initialising failed %2",time,_artymod]}; 
};

_artymod;