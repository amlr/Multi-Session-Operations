private ["_nukepos"];
_nukepos = _this select 0;

if (isserver) then {
    [_nukepos] execvm "scripts\nuke\damage.sqf";
};

if !(isserver) then {

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [0.5];
"dynamicBlur" ppEffectCommit 1;

[_nukepos,40] execvm "scripts\nuke\nuke_sound.sqf";

_Cone = "#particlesource" createVehicleLocal _nukepos;
_Cone setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 10, [0, 0, 0],
				[0, 0, 0], 0, 1.275, 1, 0, [40,80], [[0.25, 0.25, 0.25, 0], [0.25, 0.25, 0.25, 0.5], 
				[0.25, 0.25, 0.25, 0.5], [0.25, 0.25, 0.25, 0.05], [0.25, 0.25, 0.25, 0]], [0.25], 0.1, 1, "", "", _nukepos];
_Cone setParticleRandom [2, [1, 1, 30], [1, 1, 30], 0, 0, [0, 0, 0, 0.1], 0, 0];
_Cone setParticleCircle [10, [-10, -10, 20]];
_Cone setDropInterval 0.005;

_top = "#particlesource" createVehicleLocal _nukepos;
_top setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 28, [0, 0, 0],
				[0, 0, 60], 0, 1.7, 1, 0, [100,120,150], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", _nukepos];
_top setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top setDropInterval 0.002;

_smoke = "#particlesource" createVehicleLocal _nukepos;
_smoke setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48, 1], "", "Billboard", 1, 38, [0, 0, 0],
				[0, 0, 70], 0, 1.7, 1, 0, [70,95,120], 
				[[1, 1, 1, 0.4],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0.7],[1, 1, 1, 0]]
				, [0.5, 0.1], 1, 1, "", "", _nukepos];
_smoke setParticleRandom [0, [10, 10, 15], [15, 15, 7], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_smoke setDropInterval 0.005;


_Wave = "#particlesource" createVehicleLocal _nukepos;
_Wave setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 7, 48], "", "Billboard", 1, 20, [0, 0, 0],
				[0, 0, 0], 0, 1.5, 1, 0, [50, 100], [[0.1, 0.1, 0.1, 0.5], 
				[0.5, 0.5, 0.5, 0.5], [1, 1, 1, 0.3], [1, 1, 1, 0]], [1,0.5], 0.1, 1, "", "", _nukepos];
_Wave setParticleRandom [2, [20, 20, 20], [5, 5, 0], 0, 0, [0, 0, 0, 0.1], 0, 0];
_Wave setParticleCircle [50, [-80, -80, 2.5]];
_Wave setDropInterval 0.0002;

_light = "#lightpoint" createVehicleLocal [((_nukepos select 0)),(_nukepos select 1),((_nukepos select 2)+500)];
_light setLightAmbient[1500, 1200, 1000];
_light setLightColor[1500, 1200, 1000];
_light setLightBrightness 100000.0;

"colorCorrections" ppEffectEnable true;
"colorCorrections" ppEffectAdjust [0.8, 15, 0, [0.5, 0.5, 0.5, 0], [0.0, 0.0, 0.6, 2],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 0.4;

"dynamicBlur" ppEffectAdjust [1];
"dynamicBlur" ppEffectCommit 3;

[_nukepos,40] execvm "scripts\nuke\nuke_shockwave.sqf";
[_nukepos,40] execvm "scripts\nuke\nuke_shock_impact.sqf";

0 setOvercast 0;
sleep 0.1;

_xHandle = []spawn
{
	Sleep 4;
	"colorCorrections" ppEffectAdjust [1.0, 0.5, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];
	"colorCorrections" ppEffectCommit 7;
};


sleep 1.5;
"dynamicBlur" ppEffectAdjust [0.5];
"dynamicBlur" ppEffectCommit 1;
_Wave setDropInterval 0.001;
addCamShake [10, 15, 25];

deletevehicle _top;
sleep 5;
_top2 = "#particlesource" createVehicleLocal _nukepos;
_top2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 32, [0, 0, 420],
				[0, 0, 50], 0, 1.7, 1, 0, [80,90,120], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", _nukepos];
_top2 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top2 setDropInterval 0.002;
sleep 5;
deleteVehicle _top2;
sleep 2;

_top3 = "#particlesource" createVehicleLocal _nukepos;
_top3 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal", 16, 3, 48, 0], "", "Billboard", 1, 32, [0, 0, 700],
				[0, 0, 42], 0, 1.7, 1, 0, [100,120,150], [[1, 1, 1, -10],[1, 1, 1, -7],[1, 1, 1, -4],[1, 1, 1, -0.5],[1, 1, 1, 0]], [0.05], 1, 1, "", "", _nukepos];
_top3 setParticleRandom [0, [75, 75, 15], [17, 17, 10], 0, 0, [0, 0, 0, 0], 0, 0, 360];
_top3 setDropInterval 0.001;

sleep 10;
deleteVehicle _top3;
sleep 20;
deleteVehicle _smoke;

_i = 0;
while {_i < 100} do
{
	_light setLightBrightness 100.0 - _i;
	_i = _i + 1;
	sleep 0.1;
};
deleteVehicle _light;

"colorCorrections" ppEffectAdjust [1, 1, 0, [0.5, 0.5, 0.5, 0], [1.0, 1.0, 0.8, 0.4],[0.3, 0.3, 0.3, 0.1]];"colorCorrections" ppEffectCommit 1; "colorCorrections" ppEffectEnable TRUE;

sleep 2;

"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit 1;

_Cone setDropInterval 0.01;
_smoke setDropInterval 0.006;
_Wave setDropInterval 0.001;

sleep 2;

_Cone setDropInterval 0.02;
_Wave setDropInterval 0.01;

sleep 15;
deleteVehicle _Wave;
deleteVehicle _cone;

areaee = createMarkerLocal ["areaee", _nukepos];
"areaee" setMarkerShapeLocal "ELLIPSE";
"areaee" setMarkerSizeLocal [1000, 1000];
"areaee" setMarkerColorLocal "ColorRed";

_markerobj = createMarkerLocal ["natext", _nukepos];
_markerobj setMarkerShapeLocal "ICON";
_markerobj setMarkerTypeLocal "Destroy";
_markerobj setMarkerColorLocal "ColorRed";
_markerobj setMarkerTextLocal "Nuclear Radiation";

//["Fallout Map", {}] execVM "scripts\nuke\mando_giveme_mapfallout.sqf";
};