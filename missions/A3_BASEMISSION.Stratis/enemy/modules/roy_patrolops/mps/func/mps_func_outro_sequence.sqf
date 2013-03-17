// Written by BON_IF
// Adpated by EightySix

if(isDedicated) exitWith{};
private["_count","_titles","_time"];

[] spawn {
	_title = "Well Done. Mission Complete";
	if(mps_mission_score <= 0) then {_title = "Mission Failed... Try again?";};

	if(count _this > 0) then { _title = _this select 0; };

	waitUntil {!isNil "mps_mission_finished"};

	mps_hud_active = false;

	_playersNumber = {isPlayer _x} count allUnits;
	_time = 4*_playersnumber;

	playMusic mps_mission_outro; 0 fadeMusic 1;

	if (daytime > 19.75 || daytime < 4.15) then {camUseNVG true};

	109 cutText[format["%1",_title],"BLACK OUT",8];
	sleep 8;	109 cutText["","BLACK IN",2];
			[player,_time] spawn mps_outro_camera;
	sleep (_time);	110 cutText ["Thanks for playing.","BLACK OUT",5];
	sleep 5;	111 cutText [format["%1",mps_credits],"BLACK",0];
			7 fadeMusic 0;
	sleep 7;	playMusic "";

	endMission "END1";
	109 cutText ["","BLACK",0];
	110 cutText ["","BLACK",0];
};