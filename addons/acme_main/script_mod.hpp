// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp
#define PREFIX acme

#define MAJOR 1
#define MINOR 0
#define PATCHLVL 0
#define BUILD 0

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD


#define ACME_TAG A.C.M.E.
//text = QUOTE(A.C.M.E. Developer Version VERSION);
//text = QUOTE(A.C.M.E. Alpha VERSION);
//text = QUOTE(A.C.M.E. ReleaseCandidate VERSION);
//text = QUOTE(A.C.M.E. Final VERSION);


// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.62

/*
	#define DEBUG_ENABLED_SYS_ADDONS
	#define DEBUG_ENABLED_SYS_DEBUG
*/
