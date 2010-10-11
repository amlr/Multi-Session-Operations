/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */

#define PREFIX RMM
#define COMPONENT radioDialog

#define __BATTERYS [Shelldrake]

#define __DISPLAYID	100922
#define __DISPLAY_KEY 21

#define __IDC_TYPES	0
#define __IDC_TIMERTYPES 1
#define __IDC_ROUNDS 2

#define __TYPES	["HE", "WP", "SMOKE", "ILLUM"]
#define __TIMERTYPES	["IMMEDIATE", "TIMED"]

/* Do not edit below this */
#include "\x\cba\addons\main\script_macros_common.hpp"

#define PATHTO_SYS(var1,var2,var3) dialog\##COMPONENT\##var3.sqf

#define __DISPLAY findDisplay __DISPLAYID
#define __CONTROL (__DISPLAY) displayCtrl