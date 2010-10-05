[
	[
		"task1", //Task Name (GLOBALVAR)
		[
			"Kill or Capture Ex-Takistani Army Colonel Aziz; located in the Jabal as-Saraj mountains.", // Task Description Paragraph
			"Kill or Capture Colonel Aziz", // Task Title
			"AO" // Waypoint Title
		],
		getmarkerpos "task1" // Task Destination
	],
	[
		"task2",
		[
			"You are to RTB NLT 06102000H AEST",
			"RTB",
			"RTB"
		],
		getmarkerpos "headquarters"
	]
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