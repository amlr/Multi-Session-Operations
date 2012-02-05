// Ambient Bomber - create EOD Mod Ambient Bomber module at location
private ["_location","_twn","_debug","_victim","_size"];

if !(isServer) exitWith {diag_log "AmbientBomber Not running on server!";};

_victim = objNull;
_location = _this select 0;
_victim = (_this select 1) select 0;
_size = _this select 2;

_debug = false;

	if ((isClass(configFile>>"CfgPatches">>"reezo_eod")) && (tup_ied_eod == 1)) then {
		("reezo_eod_suicarea" createUnit [_location, group BIS_functions_mainscope, 
			format ["this setVariable ['reezo_eod_range',[0,%1]];
			this setVariable ['reezo_eod_probability',1];
			this setVariable ['reezo_eod_interval',1];",_size], 0, ""]);
	} else {
		// Create non-eod suicide bomber
		private ["_grp","_skins","_bomber","_pos","_time"];
		_grp = createGroup CIVILIAN;
		_pos = [_location, 0, _size - 10, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		_skins = ["TK_CIV_Takistani01_EP1","TK_CIV_Takistani02_EP1","TK_CIV_Takistani03_EP1","TK_CIV_Takistani04_EP1","TK_CIV_Takistani05_EP1","TK_CIV_Takistani06_EP1","TK_CIV_Worker01_EP1","TK_CIV_Worker02_EP1"];
		_bomber = _grp createUnit [_skins call BIS_fnc_selectRandom, _pos, [], _size, "NONE"];
		_bomber addweapon "EvMoney";
		if (_debug) then {
			diag_log format ["MSO-%1 Suicide Bomber: created at %2", time, _pos];
		};
		sleep (random 60);
		_victim = units (group _victim) call BIS_fnc_selectRandom;
		_time = time + 600;
		waitUntil {_bomber doMove position _victim; sleep 5; (_bomber distance _victim < 8) || (time > _time) || !(alive _bomber)};
		if ((_bomber distance _victim < 8) && (alive _bomber)) then {
			_bomber playMoveNow "AmovPercMstpSsurWnonDnon";
			[_bomber, "reezo_eod_sound_akbar"] call CBA_fnc_globalSay3d;
			sleep 5;
			_bomber disableAI "ANIM";
			_bomber disableAI "MOVE";
			_bomber addRating -1000;
			diag_log format ["BANG! Suicide Bomber %1", _bomber];
			"Sh_82_HE" createVehicle (position _bomber);
		} else {
			sleep 1;
			if (_debug) then {
				diag_log format ["Deleting Suicide Bomber %1 as out of time or dead.", _bomber];
			};
			sleep 120;
			deletevehicle _bomber;
		};
	};
