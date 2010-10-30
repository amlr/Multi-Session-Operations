[
	/*[
		"task1",
		[
			"You are to RTB NLT 25102000H AEST",
			"RTB",
			"RTB"
		],
		getmarkerpos "headquarters"
	]*/
]

// do not edit below this

call {
	waituntil {not isnull player};
	{
		private "_task";
		_task = player createsimpletask [_x select 0];
		_task setsimpletaskdescription (_x select 1);
		_task setsimpletaskdestination (_x select 2);
		_task settaskstate "created";
		missionnamespace setvariable [(_x select 0),_task];
	} foreach _this;
};