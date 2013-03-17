
if(!mps_debug) then {

	player playMove "AinvPknlMstpSlayWrflDnon_medic";

	sleep 8;

	if!(alive player) exitwith {};
};

	deletevehicle (_this select 0);