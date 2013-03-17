// Written by EightySix

if(isDedicated) exitWith{};
private["_count","_titles","_time"];

_titles = _this;
_count = count _titles;

_totaltime = 20;
_time = _totaltime / _count;

waitUntil{time > 0};

playMusic mps_mission_intro;
if (daytime > 19.75 || daytime < 4.15) then {camUseNVG true};

[_totaltime] spawn mps_intro_camera;

{ 109 cutText [format["%1",_x],"PLAIN",5]; sleep _time; }forEach _titles;

109 cutText ["","PLAIN DOWN",0];

5 fadeMusic 0;

_this spawn {
	waitUntil{!(isNil "BIS_fnc_init")};
	[	str(format["Welcome %1",name player]),
		str(date select 2) + "-" + str(date select 1) + "-" + str(date select 0),
		str(format["%1",mps_mission_name])
	] spawn BIS_fnc_infoText;
};

sleep (5);

playMusic "";