private ["_injured","_healer","_ismedic"];
_injured = _this select 0;
_healer = _this select 1;
_ismedic = _this select 2;

if (not isnil {_injured getvariable "revive_treating"}) exitwith {};
_injured setvariable ["revive_treating",true];

private "_ratio";
_ratio = if (_ismedic) then {26} else {round (56 max (114 * damage _injured))};

_healer playactionnow "medicstart";
if not (isplayer _healer) then { //ai compatibility
	_healer lookat _injured;
	_healer dowatch _injured;
	sleep (_ratio / 3); //take less time
	if (lifestate _healer != "alive") exitwith {};
	if (lifestate _injured != "unconscious") exitwith {};
	[0,_injured,{_this call revive_fnc_conscious}] call mso_core_fnc_ExMP;
} else {
	sleep 3;

	for "_i" from 0 to _ratio do {
		sleep 0.5;
		private ["_string","_total"];
		//ensure the medic is still healing
		_string = toArray(animationstate _healer);
		_total = (_string find ((toArray "_") select 0)) + (_string find ((toArray "e") select 0));
		if not ((_total > 48 and _total < 52) || (_total > 72 and _total < 76)) exitwith {};
		if (lifestate _healer != "alive") exitwith {};
		if (lifestate _injured != "unconscious") exitwith {};
		if (_i == _ratio) then {
			[0,_injured,{_this call revive_fnc_conscious}] call mso_core_fnc_ExMP;
		};
	};
};

_healer playaction "medicstop";

if not (isplayer _injured) then {
	_injured enableAI "anim";
};

_injured setvariable ["revive_treating",nil];
