/* 
 * Filename:
 * unitKilled.sqf 
 *
 * Description:
 * Extended Killed Eventhandler, set in mso-description.ext
 * 
 * Created by Tupolov
 * Creation date: 21/05/2012
 * 
 * */

// ====================================================================================
// MAIN

	private ["_enemykills","_civkills","_friendlykills","_killed","_killer","_sideKilled","_sideKiller","_suicides","_deaths"];

	_killed = _this select 0;
	_killer = _this select 1;
	
	if (isPlayer _killed) exitWith { // Player was killed
		_deaths = (_killed getvariable "_thispdeaths") + 1;		
		//hintsilent format["Player Deaths: %1", _deaths];
		_killed setVariable ["_thispdeaths", _deaths, true];
	};
	
	if (isNull _killer) exitWith {}; // Unit was likely killed in a collision with something
	
	if (isPlayer _killer) then {
		
		if (_killer == _killed) exitWith { // Suicide
			_suicides = (_killer getvariable "_thispsuicides") + 1;	
			//hintsilent format["Suicide: %1", _suicides];
			_killer setVariable ["_thispsuicides", _suicides, true];
		};

		_sideKilled = side (group _killed); // group side is more reliable
		_sideKiller = side _killer;

		diag_log format["Unit Killed: %1, Killed side = %2, Killer side = %3", _this, _sideKilled, _sideKiller];
		
		if (_sideKilled == _sideKiller) then { // BLUE on BLUE
			_friendlykills = (_killer getvariable "_thispfriendlykills") + 1;		
			//diag_log format["BLUFOR Kills: %1", _friendlykills];
			_killer setVariable ["_thispfriendlykills", _friendlykills, true];
		};
		
		if ((_sideKilled == civilian) || (_sideKilled == sideFriendly)) then { // civpop killing
			_civkills = (_killer getvariable "_thispcivkills") + 1;		
			//hintsilent format["Civ Kills %1", _civkills];
			_killer setVariable ["_thispcivkills", _civkills, true];
		};
		
		if ((_sideKilled != civilian) && (_sideKilled != _sideKiller) && (_sideKilled != sideFriendly) && (_sideKiller != sideEnemy)) then { // enemy killing yay!
			_enemykills = (_killer getvariable "_thispenemykills") + 1;		
			//if (isDedicated) then {diag_log format["%1 Enemy Kills %2", _killer, _enemykills];} else {hintsilent format["Enemy Kills %1", _enemykills];};
			_killer setVariable ["_thispenemykills", _enemykills, true];
		};
		
	};
// ====================================================================================