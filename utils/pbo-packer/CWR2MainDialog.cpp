ModFolder="";
CampaignDir="";
AddonDir="";
MissionDir="";
MPMissionDir="";

_radioDest=0;
_radioPack=0;
/*
** folder (job) packs
*/
PackHumans=false;
PackAll=false;
PackCars=false;
PackTrucks=false;
PackWater=false;
PackAir=false;
PackTanks=false;
PackGeneral=false;
PackWeapons=false;
PackBaracken=false;
PackEditor=false;
PackIslands=false;
PackWinter=false;
/* mission packs
*/
PackMissions=false;
PackMP=false;
PackCampaigns=false;

CleanTemp=false;
Externals=true;
IgnoreProxies=true;
PackDemoM=false;
_oldX=100;
_oldY=200;
OFPDest="";
NoRap=false;

_Packer="P:\tools\Cwr2Packer\";// change to location of tool
_PackVars = ["PackHumans", "PackEditor","PackTanks", "PackIslands",  "PackCars","PackWater","PackTrucks", "PackAir","PackBaracken","PackMissions","PackCampaigns","PackMP","PackGeneral","PackWeapons","PackWinter"];

_dlgMain = 
 [310, 410,"PBO Packing Utility 2.19 TexHeader Edition",
       ["init",

			{
			[_radioPack] call _enablePack;
			[CleanTemp] call _enableStrip;
			dlgMove [_oldX,_oldY];
			}
		],
	["onexitdlg",{}],

	["move-to",5,5],	["minimize-button"],

	["label",39,10,"Mod Folder:",20],		["textline",180,13,"ModFolder",0],	["onchange",	{call _ModChangeShow;}],	["browse-button",60,13,"folders"],["break"],

	["label",39,10,"Addons:",20],		["textline",180,13,"AddonDir",0],	/*["browse-button",60,13,"folders"],*/["break"],
	["label",39,10,"Missions:",20],		["textline",180,13,"MissionDir",0],	/*["browse-button",60,13,"folders"],*/["break"],
	["label",39,10,"Campaigns:",20],		["textline",180,13,"CampaignDir",0],	/*["browse-button",60,13,"folders"],*/["break"],
	["label",39,10,"MPMissions:",20],		["textline",180,13,"MPMissionDir",0],	/*["browse-button",60,13,"folders"],*/["break"],
	["begin-subframe",294,26, "Pack:"],
		["radio-button",50,10,"Single","_radioPack",0],["onclick",	{[_radioPack] call _enablePack;}],
		["radio-button",50,10,"Folders","_radioPack",1],["onclick",	{[_radioPack] call _enablePack;}],
		["radio-button",50,10,"Demo","_radioPack",2],["onclick",	{[_radioPack] call _enablePack;}],
		["radio-button",50,10,"All","_radioPack",3],["onclick",	{[_radioPack] call _enablePack;}],

	["end-subframe"],
	["move-to",5,115],
	["begin-subframe",294,44, "Single is:"],
	["label",35,16,"Pbo:",0],	["textline",180,13,"FolderToPack",0],["browse-button",60,13,"folders"],["break"],
				["radio-button",50,10,"Addon","_radioDest",1],
				["radio-button",50,10,"SP Mission","_radioDest",2],
				["radio-button",50,10,"MP Mission","_radioDest",3],
				["radio-button",50,10,"Campaign","_radioDest",4],
	["end-subframe"],
	//["move-to",5,82],
	["begin-subframe",294,68, "Addon Folders:"],
		["check-box", 50, 15, "Air", "PackAir"],
		["check-box", 50, 15, "Cars", "PackCars"],
		["check-box", 50, 15, "Trucks", "PackTrucks"],
		["check-box", 50, 15, "Water", "PackWater"],
		["check-box", 50, 10, "Tanks", "PackTanks"],
		["check-box", 50, 10, "Humans", "PackHumans"],
		["check-box", 50, 10, "Weapons", "PackWeapons"],
		["check-box", 50, 10, "General", "PackGeneral"],
		["check-box", 50, 10, "Islands", "PackIslands"],
		["check-box", 50, 15, "Editor", "PackEditor"],
		["check-box", 50, 15, "Baracken", "PackBaracken"],
		["check-box", 50, 15, "Winter", "PackWinter"],
	["end-subframe"],
	["begin-subframe",294,34, "Mission Folders:"],
		["check-box", 80, 15, "Campaigns", "PackCampaigns"],
		["check-box", 80, 15, "MP Missions", "PackMP"],
		["check-box", 80, 15, "SP Missions", "PackMissions"],	

	["end-subframe"],
	["move-to",5,280],
	["begin-subframe",180,80, "Options:"],

		["check-box", 80, 13, "Noisy decode", "Noisy"],
		["check-box", 80, 13, "Clean Temp", "CleanTemp"],["onclick",	{[CleanTemp] call _enableStrip;}],
		["check-box", 80, 13, "Strip Log", "StripLog"],
		["check-box", 80, 13, "Sign PBO's", "SignFiles"],
		["check-box", 80, 13, "Check Externals", "Externals"],["onclick",	{[Externals] call _enableProx;}],
		["check-box", 80, 13, "Use Binarise", "NoRap"],
		["check-box", 80, 13, "Ignore Proxies", "IgnoreProxies"],
	["end-subframe"],

//	["move-to",240,64],	

	["move-to",220,284],	
	["button",45, 15,"Crunch"],	["onclick",{call _snapPos;dlgClose 3;	}	],
	["move-to",220,304],	
	["button",45,15,"ViewLog"],	["onclick",{dlgClose 7;}	],	
	["move-to",220,324],	
	["button",45,15,"Exit"],		["onclick",{dlgClose 99;}	]

];
_snapPos=
{
		 ar=dlgGetDialogRect;

	_oldx=ar@0;
	_oldy=ar@1;
};
_ModChange=
{
	AddonDir=ModFolder+"\Addons";
	CampaignDir=ModFolder+"\Campaigns";
	MissionDir=ModFolder+"\Missions\CWR2";
	MPMissionDir=ModFolder+"\MPMissions";
};
_ModChangeShow=
{
	call _ModChange;
dlgUpdate "AddonDir";
dlgUpdate "CampaignDir";
dlgUpdate "MissionDir";
dlgUpdate "MPMissionDir";

};
_loadSettings =
{
	//Load project specific settings
	private ["_settings","_setVar"];
	_settings = openFile [_this,1];
	while {! eof _settings} do
	{
		_setVar = getLine _settings;
		call _setVar;
	};
	_settings = nil;
call _ModChange;
//[Externals] call _enableProx;
};
_enableProx=
{
	_which=_this @ 0;
	on_off=false;
	if ( _which) then {on_off=true;};
	(dlgGetControls ("IgnoreProxies"))@0 dlgEnableControl on_off;

};
_enablePack =
{
	private ["_controls","_enable","_ids","_which"];
	_controls=_PackVars;
	
	_which = _this @ 0;
	_enableSingle=false;
	_enableFolders=false;
	if (_which==0) then {_enableSingle=true;	};
	if (_which==1) then	{_enableFolders=true;	};
	/*
	** always un editable
	*/
	(dlgGetControls ("ModFolder"))@0 dlgEnableControl false;
	(dlgGetControls ("CampaignDir"))@0 dlgEnableControl false;
	(dlgGetControls ("AddonDir"))@0 dlgEnableControl false;
	(dlgGetControls ("MissionDir"))@0 dlgEnableControl false;
	(dlgGetControls ("MPMissionDir"))@0 dlgEnableControl false;
	/* single pbo */
	(dlgGetControls ("FolderToPack"))@0 dlgEnableControl _enableSingle;
	(dlgGetControls ("_radioDest"))@0 dlgEnableControl _enableSingle;
	(dlgGetControls ("_radioDest"))@1 dlgEnableControl _enableSingle;
	(dlgGetControls ("_radioDest"))@2 dlgEnableControl _enableSingle;
	(dlgGetControls ("_radioDest"))@3 dlgEnableControl _enableSingle;


//	(dlgGetControls ("ViewLog"))@0 dlgEnableControl false;
	/* folders
	*/
	_ids = [];
	for "_i" from 0 to (count _controls - 1) do
	{
		_ids set [_i, (dlgGetControls (_controls @ _i))@0];
	};
	
	"_x dlgEnableControl _enableFolders" foreach _ids;
	[Externals] call _enableProx;

};


_enableStrip=
{

};


_main =
{
	_win7=if(count _this >0)then {""}else{"\Wow6432Node"};
//	messageBox [_this@0,0];

 _JobsFolder=_Packer + "jobs\";
 FolderToPack = ""; // until over ridden
 SignFiles = false;
 Noisy=false;
 setCD _Packer;

 private ["_settings"];
 _dlgChoice = 1;

 _file = openFile ["CWR2PackingSettings.txt",0];
 if (!isNil "_file") then
 {
 // console << "Loading CWR2PackingSettings.txt" << eoln;
  "CWR2PackingSettings.txt" call _loadSettings;
 };

 _file = nil;
 O2Path = "";	

 _stream = shellCmdOpenPipe("reg query ""HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0"" /v Identifier");
 _stream skipUntil "REG_SZ";
 _stream ignore 6;

 _win64 = if(_stream exploreFor "(.*)x86(.*)")then{""}else{"\Wow6432Node"};

 _stream = shellCmdOpenPipe("reg query ""HKEY_LOCAL_MACHINE\SOFTWARE" + _win64 + "\Bohemia Interactive Studio\Oxygen 2 Personal Edition"" /v MAIN");
 _stream skipUntil "REG_SZ";
 _stream ignore 6;
	//messageBox [O2Path,0];

 if(O2Path == "")then{O2Path = (getline eatWS _stream)+"\O2Script.exe"};

 _stream = shellCmdOpenPipe("reg query ""HKEY_LOCAL_MACHINE\SOFTWARE" + _win64 + "\Bohemia Interactive Studio\ArmA"" /v MAIN");
 _stream skipUntil "REG_SZ";
 _stream ignore 6;

 if(ModFolder == "") then{ModFolder = (getline eatWS _stream)+"\Dist"};
 _stream = nil;
 while {_dlgChoice in [1,9,3,7,6]}do
 {


	 _dlgChoice = dialogBox _dlgMain;
  if (_dlgChoice == 6) then 
  {
	  call _ModChange;
  };
  if (_dlgChoice == 7) then
  {
	  if (_radioPack!=0) then
	  {
		messageBox ["Only useful when packing singles",0];
	  }
	  else
	  {

   _crud=FolderToPack + ".log";
   _logName = "\" + (splitpath _crud) @ 2 + ".log";
   _binLogPath = "p:\tools\CWR2Packer\binlogs" + _logName ;
    shellCmd ("cmd /c Notepad.exe " + _binLogPath);
	  };
  };

  if (_dlgChoice == 9) then
  {
     shellCmd ("Notepad.exe \tools\CWR2Packer\packer.log")
  };
  if (_dlgChoice == 3) then
  {
	private ["_options"];
	_OFP=false;
	_ScanFolders=NoRap;
	_externs=0;
	if (Externals) then 
	{
		_externs=1;
		if (IgnoreProxies) then {_externs=3;};
	};
	_options=str CleanTemp+ " " + str SignFiles +" "+ str Noisy+" "+ str _OFP+ " "+ str _externs+ " " +str StripLog;
	if( O2Path == "")then{messageBox ["Please choose location of O2Script.exe",0]}
	else
	{
		cmd="";
		destDir=ModFolder;
		if (_radioPack==0) then // single
		{
			singledir=addondir;
			if (_radioDest==2) then {singledir=MissionDir;};
			if (_radioDest==3) then {singledir=MPMissionDir;};
			if (_radioDest==4) then {singledir=CampaignDir;};
			shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp "+ """"+FolderToPack+""""  + " """ + singledir + """ " +  _options+ " " +str _ScanFolders);
		}
		else
		{
		    if(_radioPack==2)	then //demo
			{
			 shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp "+ _JobsFolder +"PackDemo.txt    """+ AddonDir + """ " + _options+ " " +str _ScanFolders);
			}else{
			PackAll=_radioPack==3;
			
			if(PackHumans	|| PackAll) then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\Humans """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackCars		|| PackAll) then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\Cars	"""+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackTrucks	|| PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\Trucks """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackWater	|| PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\water """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackAir		|| PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\Air   """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackEditor   || PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\cwr2_editor  """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackTanks	|| PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\Tanks """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackGeneral  || PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\general """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackBaracken || PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\Expansions\cwr2_baracken """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackIslands  || PackAll) then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\islands """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackWeapons  || PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\Weapons """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackWinter   || PackAll)	then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp p:\cwr2\expansions\cwr2_winter  """+ AddonDir + """ " + _options+ " " +str _ScanFolders)};
	
			if(PackMP		|| PackAll) then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp "+ _JobsFolder +"PackMP.txt        """	+ MPMissionDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackMissions || PackAll) then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp "+ _JobsFolder +"PackMissions.txt  """	+ MissionDir + """ " + _options+ " " +str _ScanFolders)};
			if(PackCampaigns|| PackAll) then {shellCmd (""""+O2Path+""" -d -a CWR2Pack.cpp "+ _JobsFolder +"PackCampaigns.txt """	+ CampaignDir + """ " + _options+ " " +str _ScanFolders)};
			};
		};
   };
  };
 };

//Write settings file

 console << "Update CWR2PackingSettings.txt ..." <<eoln;
	_settings = openFile ["CWR2PackingSettings.txt",2];
	_settings
	<< "O2Path=" + str(O2Path) + ";" << eoln
	<< "FolderToPack=" + str(FolderToPack) + ";" << eoln
	<< "ModFolder=" + str(ModFolder) + ";" << eoln
	<< "SignFiles=" + str(SignFiles) + ";" << eoln
	<< "Noisy=" + str(Noisy) + ";" << eoln
	<< "_radioDest=" + str(_radioDest) + ";" << eoln
	<< "_radioPack=" + str(_radioPack) + ";" << eoln
	<< "CleanTemp=" + str(CleanTemp) + ";" << eoln
	<< "Externals=" + str(Externals) + ";" << eoln
	<< "IgnoreProxies=" + str(IgnoreProxies) + ";" << eoln
	<< "PackHumans=" + str(PackHumans) + ";" << eoln
	<< "PackTanks=" + str(PackTanks) + ";" << eoln
	<< "PackIslands=" + str(PackIslands) + 	";" << eoln
	<< "PackCars=" + str(PackCars) + ";" << eoln
	<< "PackTrucks=" + str(PackTrucks) + ";" << eoln
	<< "PackWater=" + str(PackWater) + ";" << eoln
	<< "PackEditor=" + str(PackEditor) + ";" << eoln
	<< "PackEditor=" + str(PackEditor) + ";" << eoln
	<< "PackAir=" + str(PackAir) + ";" << eoln
	<< "PackMP=" + str(PackMP) + ";" << eoln
	<< "PackGeneral=" + str(PackGeneral) + ";" << eoln
	<< "PackWeapons=" + str(PackWeapons) + ";" << eoln
	<< "PackBaracken=" + str(PackBaracken) + ";" << eoln
	<< "PackCampaigns=" + str(PackCampaigns) + ";" << eoln
	<< "StripLog=" + str(StripLog) + ";" << eoln
	<< "PackWinter=" + str(PackWinter) + ";" << eoln
	<< "PackDemoM=" + str(PackDemoM) + ";" << eoln

	<< "PackMissions=" + str(PackMissions) + ";" << eoln;

};

console = openStandardIO;

this call _main;