#ifndef execNow
#define execNow call compile preprocessfilelinenumbers
#endif

execNow "init-mso.sqf";

//execNow "core\modules\mso_strategic\tests\test.sqf";
execNow "core\modules\MSO_STORE\tests\test.sqf";
//execNow "Enemy\modules\MSO_CQBPOP\tests\test.sqf";

//execNow "find_stuff.sqf";
//execNow "find_stuff_civ.sqf";

endMission "END1";
forceEnd;

