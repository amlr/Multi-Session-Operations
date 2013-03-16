call compile preProcessFileLineNumbers "Test\test_functions.sqf";

if(!isMultiplayer) then {
	call compile preProcessFileLineNumbers "Test\ambientcivs_test_SP.sqf";
};
if(isMultiplayer && !isDedicated) then {
	call compile preProcessFileLineNumbers "Test\ambientcivs_test_MP.sqf";
};
if(isDedicated) then {
	call compile preProcessFileLineNumbers "Test\ambientcivs_test_DS.sqf";
};
