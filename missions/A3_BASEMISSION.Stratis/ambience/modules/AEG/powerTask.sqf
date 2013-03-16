// powerTask.sqf //

// Create Task.
provincialVillaPower = player createSimpleTask ["Cut Provincial Villa Power"];
provincialVillaPower setSimpleTaskDescription ["Cut off power at the Provincial Villa by destroying the transformer pole or tripping the circuit breaker.", "Cut Provincial Villa Power", "Cut Provincial Villa Power"];
provincialVillaPower setSimpleTaskDestination (getMarkerPos "D_Pron");
provincialVillaPower setTaskState "CREATED";

// player setCurrentTask strelkaPower; // Uncomment to force this task.

// Task successful when Strelka power is off.
waitUntil {!(AEG_on_D_Pron)};
provincialVillaPower setTaskState "SUCCEEDED";

// End Script //