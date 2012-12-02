// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-19-version-stringtable-and-pre-init-EH-code
// https://dev-heaven.net/projects/cca/wiki/Extended_Eventhandlers#New-in-200-Support-for-ArmA-II-serverInit-and-clientInit-entries

LOG(MSG_INIT);

ADDON = false;

// PREP any functions required during XEH init process

// Version mismatch handling
PREP(mismatch);
//  Set an event handler to handle the mismatch check
if (!isDedicated) then {
	[QGVAR(check), {player globalchat format ["Player %1 is missing following files required by server: %2", _this select 1, _this select 0]}] call CBA_fnc_addEventHandler;
};

// Handling units firing (for recording player shots)
PREP(fired);

// Handling units killed (for recording player kills/deaths)
PRERP(unitKilled);

// Handling map co-ordinates in a standard way
acme_fnc_mapCoord = COMPILE_FILE(fnc_mapCoord);

ADDON = true;
