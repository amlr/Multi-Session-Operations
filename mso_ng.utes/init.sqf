//call compile preprocessfilelinenumbers "init-mso.sqf";

call compile preprocessfilelinenumbers "core\init.sqf";
"Completed" call MSO_fnc_initialising;
titleText ["", "BLACK IN"];

//call compile preprocessfilelinenumbers "core\modules\mso_strategic\tests\test.sqf";
call compile preprocessfilelinenumbers "core\modules\MSO_STORE\tests\test.sqf";
//call compile preprocessfilelinenumbers "Enemy\modules\MSO_CQBPOP\tests\test.sqf";

//call compile preprocessfilelinenumbers "find_stuff.sqf";
//call compile preprocessfilelinenumbers "find_stuff_civ.sqf";

endMission "END1";
forceEnd;

