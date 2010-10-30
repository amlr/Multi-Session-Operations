for "_i" from 0 to ((count RMM_aar_lines)-1) do {
	private "_x";
	_x = RMM_aar_lines select _i; 
	{
		lbAdd [_i,_x];
	} foreach _x;
};
if (not isnil "RMM_aar") then {
	for "_i" from 0 to 2 do {
		lbSetCurSel [_i, RMM_aar select _i];
	};
	for "_i" from 3 to 9 do {
		ctrlSetText [_i, RMM_aar select _i];
	};
};
while {dialog} do {
	RMM_aar = [lbCurSel 0,lbCurSel 1,lbCurSel 2,ctrlText 3,ctrlText 4,ctrlText 5,ctrlText 6,ctrlText 7,ctrlText 8,ctrlText 9];
};