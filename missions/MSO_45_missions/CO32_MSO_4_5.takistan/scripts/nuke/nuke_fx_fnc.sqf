//functions

fnc_nuke_wind = {
    if (windrunning) exitwith {};
    windrunning = true;
    while {windv} do {
	setwind [0.201112,0.204166,true];
		_ran = ceil random 2;
		playsound format ["wind_%1",_ran];
		_pos = position player;

		//--- Dust
		setwind [0.201112*2,0.204166*2,false];
		_velocity = [random 10,random 10,-1];
		_color = [1.0, 0.9, 0.8];
		_alpha = 0.02 + random 0.02;
		_ps = "#particlesource" createVehicleLocal _pos;  
		_ps setParticleParams [["\Ca\Data\ParticleEffects\Universal\universal.p3d", 16, 12, 8], "", "Billboard", 1, 3, [0, 0, -6], _velocity, 1, 1.275, 1, 0, [9], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _pos];
		_ps setParticleRandom [3, [30, 30, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
		_ps setParticleCircle [0.1, [0, 0, 0]];
		_ps setDropInterval 0.01;

		sleep (random 1);
		_delay = 1 + random 5;
		sleep _delay;
		deletevehicle _ps;
	};
    windrunning = false;
};

fnc_nuke_envi = {
if ((fnc_nuke_envi_on) or (nuke_on)) exitwith {};
fnc_nuke_envi_on = true;

"colorCorrections" ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];  
"colorCorrections" ppEffectCommit 5;
"colorCorrections" ppEffectEnable true;

"dynamicBlur" ppEffectAdjust [random 0.3];
"dynamicBlur" ppEffectCommit 5;
"dynamicBlur" ppEffectEnable true;

"filmGrain" ppEffectAdjust [0.02, 1, 2.5, 0.5, 1, true];
"filmGrain" ppEffectCommit 5;
"filmGrain" ppEffectEnable true;
};

fnc_nuke_envi_off = {
if (nuke_on) exitwith {};
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 5;
"dynamicBlur" ppEffectEnable true;

"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
"colorCorrections" ppEffectCommit 10;
"colorCorrections" ppEffectEnable TRUE;

"filmGrain" ppEffectAdjust [0.001, 0.001, 0.001, 0.001, 0.001, true];
"filmGrain" ppEffectCommit 5;
"filmGrain" ppEffectEnable true;

sleep 10;
"dynamicBlur" ppEffectEnable false;
"filmGrain" ppEffectEnable false;
fnc_nuke_envi_on = false;
};

fnc_nuke_ash = {
    if (fnc_nuke_ash_on) exitwith {};
    fnc_nuke_ash_on = true;
	_pos = position player;
	_parray = [
	/* 00 */		["\Ca\Data\ParticleEffects\Universal\Universal", 16, 12, 8, 1],//"\Ca\Data\cl_water",
	/* 01 */		"",
	/* 02 */		"Billboard",
	/* 03 */		1,
	/* 04 */		4,
	/* 05 */		[0,0,0],
	/* 06 */		[0,0,0],
	/* 07 */		1,
	/* 08 */		0.000001,
	/* 09 */		0,
	/* 10 */		1.4,
	/* 11 */		[0.05,0.05],
	/* 12 */		[[0.1,0.1,0.1,1]],
	/* 13 */		[0,1],
	/* 14 */		0.2,
	/* 15 */		1.2,
	/* 16 */		"",
	/* 17 */		"",
	/* 18 */		vehicle player
	];
	snow = "#particlesource" createVehicleLocal _pos;  
	snow setParticleParams _parray;
	snow setParticleRandom [0, [10, 10, 7], [0, 0, 0], 0, 0.01, [0, 0, 0, 0.1], 0, 0];
	snow setParticleCircle [0.0, [0, 0, 0]];
	snow setDropInterval 0.003;
};
