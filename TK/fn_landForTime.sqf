private ["_helicopter", "_duration", "_group"];
_helicopter = _this select 0;
_duration = _this select 1;
_group = group driver _helicopter;

_group lockWP true;
_helicopter land "getout";
waituntil {landResult _helicopter == "Found" || landResult _helicopter == "NotFound" || not alive _helicopter};

if (landResult _helicopter == "Found") then {
	waituntil {count ([_helicopter] unitsBelowHeight 2) > 0};
	sleep _duration;
};
_group lockWP false;