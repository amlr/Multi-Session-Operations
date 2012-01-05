/* (C)Rommel || http://creativecommons.org/licenses/by-nc-sa/2.5/au/ */


private ["_oStat","_fStat","_tStat","_hPaa","_fTime","_overcast","_fog","_img","_string"];
_overcast = overcastForecast;
_fog = fogForecast;

private ["_oStat","_fStat","_tStat","_hPaa"];

if (_overcast > 0.9) then {_oStat = "a possible storm"; _hPaa = "bourka"} else {
	if (_overcast > 0.7) then {_oStat = "rain"; _hPaa = "destivo"} else {
		if (_overcast > 0.5) then {_oStat = "cloudy"; _hPaa = "zatazeno"} else {
			if (_overcast > 0.2) then {_oStat = "partially fine with some cloud cover"; _hPaa = "polojasno"} else {
				if (_overcast >= 0) then {_oStat = "clear and fine"; _hPaa = "jasno"}}}}};

_img = ("CA\ui\data\editor_" + _hPaa + ".paa");

if (_fog > 0.7) then {_fStat = " with icy roads and fog."} else {
	if (_fog > 0.4) then {_fStat = " with the possibility of light fog."} else {
		if (_fog >= 0) then {_fStat = "."}}};

_fTime = dayTime + (nextWeatherChange / 60 / 60);

if (_fTime > 24) then {_tStat = "No change expected for today, but tommorow "; _fTime = _fTime - 24} else {_tStat = "This "};
if (_fTime > 18) then {_tStat = _tStat + "evening"} else {
	if (_fTime > 12) then {_tStat = _tStat + "afternoon"} else {
		if (_fTime > 0) then {_tStat = _tStat + "morning"}}};

_string = parseText format ["<img size='3' image='%1'/><br/>%2's forecast is %3%4", _img, _tStat, _oStat, _fStat];

hint _string;


