if(isNil "mps_civilian_intel") then {mps_civilian_intel = ["The civilians don't appear to be able to help"]};
if(count mps_civilian_intel == 0) then {mps_civilian_intel = ["The civilians don't appear to be able to help"]};

_person = (_this select 0);
_badresponse = ["This person is confused","This person is hostile","This person does not appear to understand english"] call mps_getRandomElement;

if(!alive _person) exitWith{ hint "The dead won't talk to the living"};

_infcount = ( {_x in (playableunits+switchableunits) && (side _x == (SIDE_A select 0)) } count nearestObjects[position player,["Man"],20]) / mps_ref_playercount;
_rndfactor = random 1;
_factor = 1 - (_infcount*_rndfactor);
_alreadygathered = _person getVariable "mps_questioned";

if(if(isNil "_alreadygathered") then {true} else {not _alreadygathered}) then{
	if(_factor > 0.93 && (random 1 > 0.5)) then {
		_hint = mps_civilian_intel call mps_getRandomElement;
		hint format["%1",_hint];
		_person setVariable ["mps_questioned",true,true];
	}else{
		hint _badresponse;
	};
}else{
	hint "This person has already been questioned";
};

if(true) exitWith {};