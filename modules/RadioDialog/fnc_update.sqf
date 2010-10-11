/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

GVAR(battery) = __BATTERYS select 0;
GVAR(selectedType) = __TYPES select (lbCurSel __IDC_TYPES);
GVAR(selectedTimerType) = __TIMERTYPES select (lbCurSel __IDC_TIMERTYPES);
GVAR(roundsNumber) = round (sliderPosition __IDC_ROUNDS);

if (GVAR(selectedTimerType) == "IMMEDIATE") then {
	sliderSetRange [__IDC_ROUNDS, 1, GVAR(maximumRounds)];
	sliderSetSpeed [__IDC_ROUNDS, 1, 1];
	sliderSetPosition [__IDC_ROUNDS, GVAR(roundsNumber) min GVAR(maximumRounds)];
} else {
	sliderSetRange [__IDC_ROUNDS, 1, GVAR(maximumTimeSustained)];
	sliderSetSpeed [__IDC_ROUNDS, 1, 1];
	sliderSetPosition [__IDC_ROUNDS, GVAR(roundsNumber) min GVAR(maximumTimeSustained)];
};