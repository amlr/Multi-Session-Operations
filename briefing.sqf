[
	[
		"Situation",
		[
			"Following the collapse of the Takistan Goverment, NATO forces are now conducting security and stability operations in Takistan. The Takiban maintain highly operational terrorist cells in the regional and mountainous areas; conducting small scale attacks on local populations in an attempt to overthrow the fledgling NATO backed goverment."
		]
	],
	[
		"Administration and Log",
		[
			"The order of seniority, signals and any other necessary cmd. information will always be given out to you prior to action. If you join in progress, you must wait until you are assigned a unit. Combat after-action reports, are to be posted after the disconnected unit has returned to a transmittable location (field camp or safe location)."
		]
	],
	[
		"Credits",
		[
			"Mission by Rommel"
		]
	]
]

// do not edit below this

call {
	waituntil {not isnull player};
	for "_i" from ((count _this) - 1) to 0 step -1 do {
		for [{_k = (count (_this select _i select 1)) - 1},{_k >= 0},{_k = _k - 1}] do {
			player createDiaryRecord ["Diary", [_this select _i select 0,_this select _i select 1 select _k]];
		};
	};
};