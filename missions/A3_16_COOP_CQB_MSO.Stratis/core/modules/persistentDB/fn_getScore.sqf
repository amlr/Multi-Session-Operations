/* 
* Filename:
* fn_getScore.sqf 
*
* Description:
* Called from persistentDB/main.sqf
* Runs on server only
* 
* Created by [KH]Jman
* Creation date: 06/01/2013
* Email: jman@kellys-heroes.eu
* Web: http://www.kellys-heroes.eu
* 
* */

// ====================================================================================

//	 data = [_player, _pname, _puid, "false"] call persistent_fnc_getScore;
		private ["_player","_puid","_globalPlayerScore","_thisPlayerGlobalscore","_response","_procedureName","_serverData","_parameters","_thisPSCount","_r","_thisPSArray","_thisPScore","_seen"];
			_player = _this select 0;
			_pname = _this select 1; 		
			_puid = _this select 2;
			_seen = _this select 3;
			
			_globalPlayerScore = 0;	
			if (pdb_globalScores_enabled) then {
				_serverData = format["Loading player global score..."];
				PDB_CLIENT_LOADERSTATUS = [_player,_serverData]; publicVariable "PDB_CLIENT_LOADERSTATUS";
				_procedureName = "GetGlobalScoreByPlayer"; _parameters = format["[tpid=%1]",_puid];
				_response = [_procedureName,_parameters] call persistent_fnc_callDatabase;	
				_thisPlayerGlobalscore = _response;
				_thisPSCount = count _thisPlayerGlobalscore;	
				for [{_r=0},{_r < _thisPSCount},{_r=_r+1}] do 	// START loop through all records
				{
					_thisPSArray = _thisPlayerGlobalscore select _r ;    // copy the returned row into array
					_thisPScore = _thisPSArray select 0;     //  returned pscore
					_thisPScore = parseNumber _thisPScore;
					_globalPlayerScore = _globalPlayerScore + _thisPScore;
				};
				_player setVariable ["globalPlayerScore", _globalPlayerScore, true];  	
			};
		
		if (pdb_date_enabled) then { MISSIONDATE = date;	publicvariable "MISSIONDATE"; 	};
		[_player, _pname, _puid, score _player, _globalPlayerScore, _seen] execVM "core\modules\persistentDB\updateScore.sqf";
