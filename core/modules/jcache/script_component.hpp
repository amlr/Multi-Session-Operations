#define MAINPREFIX x
#define PREFIX jayai

//--BUILDPREFIX
#define MAJOR 1
#define MINOR 0
#define PATCHLVL 0
#define BUILD 1
#define BUILDDATE 2011-02-25 07:38:02
//--ENDBUILDPREFIX

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION_PLUGIN MAJOR.MINOR.PATCHLVL

#define JAYAI_TAG JAYAI

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.01

//
// component specific
// 

#define COMPONENT sys_cache

#ifdef DEBUG_ENABLED_SYS_CACHE
	#define DEBUG_MODE_FULL
#endif

#ifdef JCACHE_DEBUG
	#define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_ENABLED_SYS_CACHE
	#define DEBUG_SETTINGS DEBUG_SETTINGS_SYS_CACHE
#endif

#include "script_macros.hpp"

#define COMPILE_FILE(var1) compile preprocessFileLineNumbers 'var1.sqf'
#define PREP(var1) TRIPLES(PREFIX,COMPONENT,DOUBLES(fnc,var1)) = compile preProcessFileLineNumbers 'core\modules\jcache\DOUBLES(fnc,var1).sqf'

