private ["_caller","_target"];
_caller = _this select 0;
_target = _this select 1;

private ["_tyres","_tyre"];
_tyres = (getpos _target) nearObjects ["Land_Pneu",5];
if (count _tyres == 0) exitwith {hint "No spare tyre";};
_tyre = _tyres select 0;

private "_rdx";
_rdx = round((([_target,_caller] call BIS_fnc_relativeDirTo) - 45)/ 90);
if (_rdx < 0) then {_rdx = _rdx + 4;};

_caller playmove "ainvpknlmstpslaywrfldnon_medic";
sleep 7;
if (alive _caller) then {
	[
		(if (local _target) then {3} else {0}),
		[_target,(["wheel_2_1_steering","wheel_2_2_steering","wheel_1_2_steering","wheel_1_1_steering"] select _rdx)],
		{
			if (local (_this select 0)) then {
				(_this select 0) sethit [(_this select 1),0];
				(_this select 0) setvectorup [0,0,1];
			};
		}
	] call mso_core_fnc_ExMP;
	deletevehicle _tyre;
};