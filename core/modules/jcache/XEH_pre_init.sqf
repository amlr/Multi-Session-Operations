#include "script_component.hpp"


ADDON = false;

//
// Function definitions
//
PREP(addGroup);

// main loop functionality
PREP(srv_mainLoop);
PREP(srv_processGroup);

PREP(deactivateGroup);
PREP(activateGroup);

PREP(despawnGroup);
PREP(spawnGroup);

PREP(showDebugMarkers);

PREP(getUnitVehiclePosition);

//
// GVAR definitions for addon
//
GVAR(masterGroupList) = [];
GVAR(deactivatedCount) = 0;
GVAR(cachedCount) = 0;

ADDON = true;
