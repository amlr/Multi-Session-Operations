/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#include <defines.h>

lbClear (__CONTROL __IDC_TYPES);
lbClear (__CONTROL __IDC_TIMERTYPES);

{
	(__CONTROL __IDC_TYPES) lbAdd _x;
} foreach __TYPES;
lbSetCurSel [__IDC_TYPES,__TYPES find GVAR(selectedType)];

{
	(__CONTROL __IDC_TIMERTYPES) lbAdd _x;
} foreach __TIMERTYPES;
lbSetCurSel [__IDC_TIMERTYPES,__TIMERTYPES find GVAR(selectedTimerType)];

if (GVAR(selectedTimerType) == "IMMEDIATE") then {
	sliderSetRange [__IDC_ROUNDS, 1, GVAR(maximumRounds)];
	sliderSetSpeed [__IDC_ROUNDS, 1, 1];
	sliderSetPosition [__IDC_ROUNDS, GVAR(roundsNumber) min GVAR(maximumRounds)];
} else {
	sliderSetRange [__IDC_ROUNDS, 1, GVAR(maximumTimeSustained)];
	sliderSetSpeed [__IDC_ROUNDS, 1, 1];
	sliderSetPosition [__IDC_ROUNDS, GVAR(roundsNumber) min GVAR(maximumTimeSustained)];
};

GVAR(marker) = createMarkerLocal ["m" + str round(random 10000), GVAR(position)];
GVAR(marker) setMarkerTypeLocal "mil_destroy";

onMapSingleClick QUOTE(_pos call FUNC(updatepos); true);

waituntil {not dialog};

deleteMarker GVAR(marker);
onMapSingleClick "";