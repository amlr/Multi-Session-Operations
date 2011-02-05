if(!isNil "inko_disposable_oa") then {
	waituntil {inko_disposable_oa};
	{terminate _x} foreach [
		inko_disposable_ammo_player,
		inko_disposable_ammo_ai
	];
	inko_disposable_throw = {};
	inko_disposable_fired = {};
	inko_disposable_oa = false;
};