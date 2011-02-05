if(isDedicated) exitWith{};
execVM "scripts\MSO_help.sqf";
sleep 10;
["Multi-Session","Operation"] call BIS_fnc_infoText;
sleep 10;
["by Rommel, Wolffy.au", "And AusArmA.org"] call BIS_fnc_infoText;
