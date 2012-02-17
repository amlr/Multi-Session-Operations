// Written by BON_IF
// Adpated by EightySix

_ied = _this select 0;
_caller = _this select 1;
_randomtime = 10 + round random 10;
_delay = 20 - _randomtime;

player playMove "ActsPercSnonWnonDnon_carFixing2";
sleep _randomtime;
player playMoveNow "AmovPercMstpSlowWrflDnon";

if(not alive player) exitwith { player playMoveNow "AmovPercMstpSlowWrflDnon"; };

if(getNumber (configFile >> "CfgVehicles" >> typeof _caller >> "canDeactivateMines") < 1) then {
	if(_randomtime > 15) then {
		hint format["IED defuse failed. Detonating in %1...",_delay];
		sleep _delay;
		_ied setvariable ["bon_ied_blowit",true,true];
	};
};
sleep 2;
hint "";
deleteVehicle _ied;

if(true) exitwith { player playMoveNow "AmovPercMstpSlowWrflDnon"; };