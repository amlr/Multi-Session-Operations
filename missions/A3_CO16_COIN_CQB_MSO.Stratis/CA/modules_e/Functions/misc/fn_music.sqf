scriptName "modules_e\Functions\objects\fn_music.sqf";
/*
	File: fn_music.sqf
	Author: Karel Moricky

	Description:
	Jukebox

	Parameter(s):
	_this:	ARRAY	- list of used songs (Optional)
		NUMBER	- delay between tracks (Optional)

	Returns:
	Nothing
*/

private ["_trackList","_delay","_class","_duration","_current","_path","_pathCount","_durationList"];
_trackList = [];
_durationList = [];
_delay = 3;
if (count _this > 0) then {_trackList = _this select 0};
if (count _this > 1) then {_delay = _this select 1};

//--- Load tracklist from config
if (count _tracklist == 0) then {
	_path = configfile >> "cfgMusic";
	_pathCount = count _path;

	for "_i" from 0 to (_pathCount - 1) do {
		_current = _path select _i;
		if (isclass _current) then {
			_class = configname _current;
			_duration = getnumber (_current >> "duration");
			if (_duration != 0) then {
				_trackList = _trackList + [_class];
			};
		};
	};
};
{
	_duration = getnumber (configfile >> "cfgMusic" >> _x >> "duration");
	if (_duration == 0) then {_duration = 60}; //--- Default falue if none is set
	_durationList = _durationList + [_duration];
} foreach _trackList;

//--- Play
if (!isnil "bis_fnc_music_spawn") then {terminate bis_fnc_music_spawn};
bis_fnc_music_spawn = [_trackList,_durationList,_delay] spawn {
	private ["_ran","_fade","_track","_durationFull","_oldRan","_duration","_n","_trackList","_trackCount","_durationList","_delay","_fadeTime"];
	_trackList = _this select 0;
	_trackCount = count _trackList;
	_durationList = _this select 1;
	_delay = _this select 2;

	_oldRan = -1;
	_ran = -1;
	_fadeTime = 3;

	while {true} do {
		private ["_musicVolume"];

		//--- Select track
		waituntil {
			sleep 1;
			_ran = floor random _trackCount;
			_ran != _oldRan || _trackCount == 1
		};
		_track = _trackList select _ran;
		_durationFull = _durationList select _ran;

		//--- Play
		playmusic _track;
		_oldRan = _ran;

		//--- Duration
		_duration = _durationFull - _fadeTime;
		_fade = false;
		_n = diag_tickTime;	// zGuba: music is played in realtime, playback is faster after hitting Escape
		while {diag_tickTime < _n + _durationFull} do {
			sleep 1;
			if (diag_tickTime >= _n + _duration && !_fade) then {
				_musicVolume = musicvolume;
				(_fadeTime * acctime) fademusic 0;
				_fade = true;
			};
		};

		0 fademusic _musicVolume;

		//--- Delay
		sleep _delay;
	};
};