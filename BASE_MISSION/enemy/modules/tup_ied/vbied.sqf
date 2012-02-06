private ["_IEDskins","_IED","_trg","_vehicle"];
_debug = true;
_vehicle = _this select 0;
_radio = _this select 1;

		// create IED object and attach to vehicle
		_IEDskins = ["Land_IED_v1_PMC","Land_IED_v2_PMC","Land_IED_v3_PMC","Land_IED_v4_PMC"];
		_IED = createVehicle [_IEDskins select (floor (random (count _IEDskins))),getpos _vehicle, [], 0, "CAN_COLLIDE"];
		_IED attachTo [_vehicle,[0,0,-0.5]];
		
		// If EOD addon is detected then add reezo eventhandler for radio controlled IED else set detonation trigger for normal IED
		if ((isClass(configFile>>"CfgPatches">>"reezo_eod")) && (tup_ied_eod == 1) && (_radio)) then {
			// add dicker to ensure IED is not interfered with
			private ["_dicker","_skins","_group"];
			_group = createGroup civilian;
			_skins = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1"];
			_dicker = _group createUnit [_skins select (floor (random (count _skins))), getPos _ied, [], 200, "NONE"];
			removeAllItems _dicker;
			removeAllWeapons _dicker;
			_dicker addWeapon "Binocular";
			_dicker addWeapon "ItemRadio";
			_dicker doWatch (getPos _ied);			
			_dicker setVariable ["reezo_eod_avail",false];
			if (_debug) then {
				diag_log format ["MSO-%1 IED: Creating Dicker (for Reezo VBIED %3) at %2", time, position _dicker, typeof _vehicle];
			};
			// Setup IED as Reezo IED radio controlled 
			_IED setVariable ["reezo_eod_trigger","radio"];
			nul0 = [_dicker, _IED, 200] execVM "x\eod\addons\eod\IED_postServerInit.sqf";
			if (_debug) then {
				diag_log format ["MSO-%1 IED: Creating Reezo EOD Radio VB-IED for %2 at %3", time, typeof _vehicle, position _vehicle];
			};
		} else {
			// Set up trigger to detonate IED
			_booby = [_IED, typeOf _vehicle, "Sh_125_HE"] execvm "enemy\modules\tup_ied\arm_ied.sqf";
			waitUntil {sleep 1; scriptDone _booby};
			if (_debug) then {
				diag_log format ["MSO-%1 IED: Creating VB-IED for %2 at %3", time, typeof _vehicle, position _vehicle];
			};
		};