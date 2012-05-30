Mission_capture = [];

_sleep = _this select 0;

if (typeName _sleep != "SCALAR") then {_sleep = -1;};

if (_sleep >= 0) then 
{
	sleep _sleep; 
	copyToClipboard str(Mission_capture);
	"PROCESSING DONE..." hintC "MISSION CAPTURING IS DONE!!!";
};