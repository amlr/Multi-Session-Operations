// ACME Self Interaction Conditions

// Self Interaction Menu not available if player is unconscious
#define ACME_INTERACT_ALIVE (alive player)
#define ACME_INTERACT_UNCON (player call ace_sys_wounds_fnc_isUncon)

// Player is Player Vehicle
#define ACME_INTERACT_PLAYER (player == vehicle player)

// Possible = Self interaction opens only if player is alive and conscious (can be in a vehicle)
#define ACME_SELFINTERACTION_POSSIBLE (!ACME_INTERACT_LADDER && ACME_INTERACT_ALIVE && !ACME_INTERACT_UNCON)

// Restricted = Self interaction opens only if player is alive and conscious (can NOT be in a vehicle, i.e Groundmarker, explosives ...)
#define ACME_SELFINTERACTION_RESTRICTED (ACE_SELFINTERACTION_POSSIBLE && ACE_INTERACT_PLAYER)

// Close interaction menu if unconscious
#define ACME_INTERACT_FNC_EXIT if (ACME_INTERACT_UNCON) exitWith {}
