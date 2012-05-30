================================================
 DynamicWeatherEffects by Engima of Östgöta Ops
================================================

As a mission designer I have always had problems with the weather. It has not been dynamic the way I want it to be, and I've always thought that it synchronizes terribly in multiplayer as soon I start laborating with it (especially rain).

This is a simple script that makes the weather dynamic, and it works in single player, multiplayer (hosted and dedicated) and for JIPs. The weather is constantly changing over time intervals of the mission designer's choice. Weather is unpredictible, and above all it's always synchronized among all players in a multiplayer game!

Script handles fog, overcast, rain and wind.


=======================
 TECHNICAL INFORMATION
=======================

Data sent over network (using publicVariable) is minimal, as data is only sent when weather "forecast" changes and when weather needs to be synchronized because of a JIP player.

Fog and overcast is divided into four levels (clear, some, more, heavy) each representing a smaller value interval, since I don't regard pure random values as especially realistic (e.g. there would very seldom be a clear day). These levels are then chosen randomly, but they are forced to change. So If the weather is heavy fog, it will not change to heavy fog again, but to *another* randomly chosen fog level.

Each client run a "rain loop", that sets the rain value every second. This is a workaround for the "rain bug" (or what it is) causing rain to behave randomly on all clients when left unwatched.

If overcast goes above 0.75, there is chance of rain, otherwise it cannot rain (limitation in the game).

Fog and overcast does not change at the same time (due to limitation in game).


==============
 REQUIREMENTS
==============

The script is just a script, so no addons are required. The only dependency is to my own CommonLib, which is included (and is too only just a script).

Only tested on ArmA2 Combined Operations.


==============
 INSTALLATION
==============

1. Copy the folder "Scripts" to your mission folder, or otherwise make sure that the two following paths exist in your mission folder:

Scripts\DRN\CommonLib\CommonLib.sqf
Scripts\DRN\DynamicWeatherEffects\DynamicWeatherEffects.sqf 

2. If the init file not already exists, create the init file (init.sqf) in the root of your mission folder.

3. In init.sqf, initialize CommonLib and start the weather script by adding the the following two lines:

call compile preprocessFileLineNumbers "Scripts\DRN\CommonLib\CommonLib.sqf";
[10, 25, 5, 15, true] execVM "Scripts\DRN\DynamicWeatherEffects\DynamicWeatherEffects.sqf";


==============
 ARGUMENTS
==============

The following six arguments can be passed to the script:

1st) _minWeatherChangeTimeMin: Optional. Minimum time in minutes for the weather to change. (Default is 10).
2nd) _maxWeatherChangeTimeMin: Optional. Maximum time in minutes for the weather to change. (Default is 25).
3rd) _minTimeBetweenWeatherChangesMin: Optional. Minimum time in minutes that weather stays unchanged between weather changes. (Default is 5).
4th) _maxTimeBetweenWeatherChangesMin: Optional. Maximum time in minutes that weather stays unchanged between weather changes. (Default is 15).
5th) _allowRain: Optional. true if it is allowed to rain, otherwise false. (Default is true).
6th) _debug: Optional. true if debug mode is on, and debug messages are to be shown in side chat, otherwise false. (Default is false).


==============
 TIP
==============

If you want to set weather default, do that in init.sqf before call to DynamicWeatherEffects.sqf, like in the following example:

------------------
 init.sqf (begin)
------------------

call compile preprocessFileLineNumbers "Scripts\DRN\CommonLib\CommonLib.sqf";

0 setFog 0.75;
0 setOvercast 0.9;
0 setRain 0.8;
setWind [1, 8, true];

[10, 25, 5, 15, true] execVM "Scripts\DRN\DynamicWeatherEffects\DynamicWeatherEffects.sqf";

------------------
 init.sqf (end)
------------------
