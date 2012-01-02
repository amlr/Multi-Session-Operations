#include "\x\cba\addons\main\script_macros_common.hpp"

#ifndef PRELOAD_ADDONS
	#define PRELOAD_ADDONS class CfgAddons \
{ \
	class PreloadAddons \
	{ \
		class ADDON \
		{ \
			list[]={ QUOTE(ADDON) }; \
		}; \
	}; \
};
#endif

//[[ctrlData],[units]]
//_saveGroupEntry = [[_groupLeader, _distArray, 0, diag_tickTime]];

#define GET_CTRL_LEADER(var1) 			(var1 select 0)
#define GET_CTRL_DIST(var1) 			(var1 select 1)
#define GET_CTRL_DELAY(var1) 			(var1 select 2)
#define GET_CTRL_TICK(var1) 			(var1 select 3)

#define SET_CTRL_LEADER(var1, var2) 	var1 set[0, var2]
#define SET_CTRL_DIST(var1, var2) 		var1 set[1, var2]
#define SET_CTRL_DELAY(var1, var2) 		var1 set[2, var2]
#define SET_CTRL_TICK(var1, var2) 		var1 set[3, var2]