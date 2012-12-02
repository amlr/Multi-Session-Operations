/////////////////////////////////////////////////////////////////////////////////////////
////// code re-arranged via squint from sbsmac, to whom, all honour and glory
////// don't leave home without it
/////////////////////////////////////////////////////////////////////////////////////////

Drive="P:\";		// this forces us back to p:\ to start things

binPath=Drive;		// location of extracted bin.pbo (p:/[bin])
                	// this over-rides the supplied bitools bin folder

Packer=getCD +"\";	// location of all things packer, ie, where this bastard started from (P:\tools somewhere)

Addon="p:\cwr2 -addon=p:\ca"; //needed for islands to find a land class

IsMission=false;//not used
UseMikero=true;//for rapify commands
PrefixDetected=false;
SignFiles=false;
IgnoreExternals=false;
Noisy=false;
Failed=0;
LogName="";
CompileForOFP=false;
StripLog=false;
RapifyCommand="";
DistPath="";
BinLogPath="";

PackIsland=false;
MakeRapCmd=
{
	private ["_ofparg","_noisyarg","_marg"];
	_ofparg="a"; // assume arma
	_noisyarg="";
	_marg="e";

	if (IgnoreExternals) then {_marg="";};
	if (CompileForOFP) then {_ofparg="o";};
	if (Noisy) then  {_noisyarg="n";};
	RapifyCommand="\tools\dostools\rapify.exe -k"+_marg+_ofparg+_noisyarg+ " ";
//	console<<RapifyCommand<<eoln;
};

SignPbo=
{
	private["_thing","_srcPath","_ar"];
	_srcPath= _this @ 0;
	_thing=_srcPath+".pbo";
	_ar=splitpath _thing;
	_thing=DistPath +"\"+ _ar@2 + ".pbo";
	if (Noisy) then {	console << "...Signing pbo: "<<_thing << eoln;};
	if (0!=shellcmd ("CMD /C \tools\keys\signpbo.bat """+ _thing +""" ")) exitWith{Failed=1;};// bloody thing sent return error
};

Pack =
{
	private ["_srcPath","_prefix","_exclude","_FileBank"];

	_srcPath = _this @ 0;
//	_destPath = _this @ 1;
	_prefix = _this @ 1;
	_exclude = if(count _this == 4)then{_exclude = _this @ 3}else{Packer +"exclude.lst"};
	_FileBank = """" + BinPBO + "\filebank\FileBank.exe"" -property prefix=" + _prefix + " -exclude " + _exclude + " " + _srcPath;
	if (Noisy) then {		console << "...Making pbo"<< eoln;};

	if (0!=shellCmd(_FileBank))  exitWith{Failed=1;};// wont return an error

	_FileBank="MOVE /Y "+ _srcPath +".pbo*.* "+""""+DistPath+"""";
	if (Noisy) then {		console <<_FileBank<<eoln;};
	if (0!=shellCmd ("CMD /C " + _FileBank)) exitWith{Failed=1;};
//	if (SignFiles) then { [_srcPath] call SignPbo;};

};

scanpaa=
{
    private ["_files","_file","_ext","_destfile","_srcPath","_tempPath","_here","_exists","_palpac"];
        _palpac=BinMake+"\Pal2PacE\Pal2PacE ";

    _ext= _this @0; _srcPath= _this @1; _tempPath= _this @2;
    _here=_srcPath+"\*" + _ext;

    _files= shellCmdOpenPipe("CMD /C DIR /B/A:-h-d/L " +_here);// list files only
    while {!eof _files} do 
    {
        _file = getline _files;
        if (_file!="") then  
        {
            _destfile=_srcPath +"\" + (splitPath _file) @ 2 + ".paa";
            _exists=openFile [_destfile,0];
            if (isnil("_exists")) then 
            {
    // right now, we're putting the bastard back in the svn
    // we should just pass it to temp
// will fail on spaced args but i'm sick to death of bis coding
                Failed=shellCmd(_palpac +_srcPath +"\" + _file +" " +_destfile);
                if  (Failed!=0 ) Exitwith{};

                shellCmd("CMD /C XCOPY /Q/Y/R/I/K " + _destfile +" " +_tempPath);
            };
        };
    };
    _files = nil;
};

scanrvmat=
{
	private ["_dirs","_file","_srcPath","_destPath","_destfile","_srcfile"];

    if (CompileForOFP) exitwith {};
	_srcPath= _this @ 0;
	_destPath = _this @ 1;
	_dirs= shellCmdOpenPipe("CMD /C DIR /B/A:-h-d/L " +_srcPath+"\*.rvmat");
	while {!eof _dirs} do 
	{
		if (Failed!=0) exitWith{};
		_file = getline _dirs;
		if (_file!="") then
		{
			_destfile=_destPath +"\"+_file;
			_srcfile= _srcPath+"\"+_file;
			_file=RapifyCommand +  """" + _srcfile + """" +" "+ """" +_destfile + """";
			if (Noisy) then {console<<_file<<eoln;};
			if (0!=shellCmd("CMD /C "+_file)) exitWith{Failed=1;};
		};
	};
	_dirs = nil;
};

scanmodelcfg=
{
		
    private ["_dirs","_file","_srcPath","_srcfile"];
    if (CompileForOFP) exitwith {};

    _srcPath= _this @ 0;

    _dirs= shellCmdOpenPipe("CMD /C DIR /B/A:-h-d/L " +_srcPath+"\*.cfg");
  
	while {!eof _dirs} do 
    {
        if (Failed!=0) exitWith{};
        _file = getline _dirs;
       if (_file!="") then
        {
            _srcfile=_srcPath+"\"+_file;
            _file=RapifyCommand + "-L "+  """" + _srcfile + """" ;
			if (Noisy) then {console<<"LintCheck: "<<_file<<eoln;};
            if (0!=shellCmd("CMD /C "+_file)) exitWith{Failed=1;};
        };
    };
    _dirs = nil;
    _dirs= shellCmdOpenPipe("CMD /C DIR /B/A:-h-d/L " +_srcPath+"\*.bisurf");

	/*
	** now lint-check bisurf
	*/
	while {!eof _dirs} do 
    {
        if (Failed!=0) exitWith{};
        _file = getline _dirs;
        if (_file!="") then
        {
            _srcfile=_srcPath+"\"+_file;
            _file=RapifyCommand + "-L "+  """" + _srcfile + """" ;
			if (Noisy) then {console<<"LintCheck: "<<_file<<eoln;};
            if (0!=shellCmd("CMD /C "+_file)) exitWith{Failed=1;};
        };
    };
    _dirs = nil;

	_dirs= shellCmdOpenPipe("CMD /C DIR /B/A:-h-d/L " +_srcPath+"\*.bikb");

	/*
	** now lint-check bikb
	*/
	while {!eof _dirs} do 
    {
        if (Failed!=0) exitWith{};
        _file = getline _dirs;
        if (_file!="") then
        {
            _srcfile=_srcPath+"\"+_file;
            _file=RapifyCommand + "-LE "+  """" + _srcfile + """" ;
			if (Noisy) then {console<<"LintCheck: "<<_file<<eoln;};
            if (0!=shellCmd("CMD /C "+_file)) exitWith{Failed=1;};
        };
    };
    _dirs = nil;


};

scantga=
{
    private ["_dirs","_srcPath","_destPath","_dir"];

    if (CompileForOFP) exitwith {};

    _srcPath= _this @ 0;
    _destPath = _this @ 1;

//////////////////////////////////////
// crunch any missing tga
//////////////////////////////////////
    [".tga",_srcPath,_destPath] call scanpaa; if (Failed!=0) exitwith{};
    //[".png",_srcPath,_destPath] call _scanpaa; if (Failed!=0) exitwith{};
    // ^^ potentially fails so don t bother.
    // ^ also, some island maps contain huge png that should not be converted
    // [".jpg",_srcPath,_destPath] call _scanpaa; if (Failed!=0) exitwith{};
    _dirs = shellCmdOpenPipe("CMD /C DIR /B/A:D-H/L " +_srcPath);// list only dirs

    while {!eof _dirs} do 
    {
        _dir = getline _dirs;
        if (_dir!="" && _dir !=".svn") then 
        {
            [_srcPath +"\" +_dir,_destPath +"\" +_dir] call scantga;
            if (Failed!=0)   exitwith{};
        };
    };	
    _dirs = nil;
};

binarize =
{
	private ["_srcPath","_destPath","_binarizeLn"];
	_srcPath = _this @ 0;
	_destPath = _this @ 1;

	LogName = "\" + (splitpath _srcPath) @ 2 + ".log";
	BinLogPath = Packer + "binLogs" + LogName;

	if (!PackIsland) then
	{
_binarizeLn = "CMD /C """+BinMake+"\binarize\binarize.exe"" -targetBonesInterval=56 -textures="+ Packer +"temp -binPath="+ binpath + " " + _srcPath + " " + _destPath + " 2> " + BinLogPath;
	}else
	{
_binarizeLn = "CMD /C """+BinMake+"\binarize\binarize.exe"" -targetBonesInterval=56 -textures="+ Packer +"temp -binPath="+ binpath + " -addon="+ Addon + " " + _srcPath + " " + _destPath + " 2> " + BinLogPath;
	};
	console << "Binarizing:"<< _binarizeLn<<eoln<<eoln;

	if (0!=shellCmd(_binarizeLn)) exitWith{Failed=1;};// won't fail even when it says it's bad
	_binarizeLn = "CMD /C """+BinMake+"\binarize\binarize.exe"" -texheader= " + _srcPath + " " + _destPath ;
	if (0!=shellCmd(_binarizeLn)) exitWith{Failed=1;};// won't fail even when it says it's bad

	if (Noisy) then {		console<<"scanning for unprocessed tga"<<eoln;};
 	[_srcPath,_destPath] call scantga;

};
DeletePbo=
{
	private ["_file","_ar","_filename"];
	_filename= _this @0;
	_ar=splitpath _filename;
	_filename= DistPath +"\" + _ar @2 + ".pbo";
	_file = openFile [_filename,0];
    if(!isNil "_file") then 
	{
		_file=nil;
		shellCmd("CMD /C DEL /Q """ + _filename + """");
	}
};
syncFolder =
{
	private ["_folder","_tempFolder","_patterns","_files","_file","_dirs","_dir","_filename"];
	_folder = _this @ 0;
	_tempFolder = _this @ 1;
	if (Noisy) then {	console <<".Sync " <<_tempFolder<<eoln;};

///
///// lintcheck config.mission,should do desc.ext as well
/////
    _filename=_folder + "\config.cpp";
    _file = openFile [_filename,0];
    if(!isNil "_file")then{[_filename,_tempFolder+"\config.bin"] call convertConfig}; 
    if(Failed!=0)exitWith{};
    _file = nil;

    _filename=_folder + "\mission.sqm";

    _file = openFile [_filename,0];
    if(!isNil "_file")then{[_filename,_tempFolder+"\mission.sqm"] call convertConfig}; 
    if(Failed!=0) exitWith{};
    _file=nil;
    _dirs = shellCmdOpenPipe("CMD /C DIR """+ _folder +""" /B /A:D /L");

	//filestypes to copy directly
	_patterns = [".rtm",".sqf",".sqs",".bikb",".fsm",".wss",".ogg",".wav",".fxy",".html",".lip",".bisurf",".csv",".jpg",".ext",".xml",".pac",".paa"];
	// we can't copy huge island paa's directly they are sometimes erroneous

	//mission folder?
	if(_folder findI "." != -1)then{_patterns = _patterns + [".txt",".jpg",".paa",".pac",".ext",".hpp",".h"]};
	
	_files = shellCmdOpenPipe("CMD /C DIR """+ _folder +""" /B /A:-D /L");
    {
        if(_files exploreFor ("(.*)\"+_x))then
        {
            if (Noisy) then {	  console <<"..Copy "<<_folder<<eoln;};
            shellCmd("CMD /C XCOPY " + _folder + "\*" + _x + " " + _tempFolder + " /Y /R /I /K");
        };
    }foreach _patterns;

//rvmats
    [_folder,_tempFolder] call scanrvmat;
    [_folder] call scanmodelcfg; 
    if(Failed!=0)exitWith{};

    while {!eof _dirs} do 
    {
        _dir = getline _dirs;
        if(_dir != "" && _dir != ".svn")then{[_folder+"\"+_dir,_tempFolder+"\"+_dir] call syncFolder};
        if (Failed!=0) exitwith{};
    };	
    _dirs = nil;
};

copyFolderStructure =
{
	private["_folder","_tempFolder"];
	_folder = _this @ 0;
	_tempFolder = _this @ 1;
	if (Noisy) then {	console << ".Creating temp folders:" <<_tempFolder<< eoln;};
	shellCmd ("CMD /C @ECHO OFF & MKDIR """ + _tempFolder + """");
	if (0!=shellCmd ("CMD /C XCOPY "+ _folder +" "+ _tempFolder +" /T /I /Y /R")) exitWith{Failed=1;};
};


hasPrefix=
{
	private["_dirs","_folder","_filename"];
	_folder= _this @ 0;
    PrefixDetected=false;
    _dirs = shellCmdOpenPipe("CMD /C DIR """+ _folder +""" /B");
    while {!eof _dirs} do 
	{
		_filename = getline _dirs;
		if (_filename == "$PBOPREFIX$" ) exitWith {PrefixDetected=true;};
		if (_filename == "PboPrefix.txt" ) exitWith {PrefixDetected=true;};
	};	
	_dirs = nil;
};

convertConfig =
{

    private ["_file","_from","_to"];
    _from = _this @ 0;
    _to = _this @ 1;

	if (UseMikero) then
	{
		_file=RapifyCommand +_from + " " + _to;
		if (0!=shellCmd("CMD /C "+_file)) exitWith{Failed=1;};
	}
	else
	{
		console<<"LintCheck :";
		_file=RapifyCommand +"-L " +_from + " " + _to;
		if (0!=shellCmd("CMD /C "+_file)) exitWith{Failed=1;};// lintcheck only, then let bis do it
		if (0!=shellCmd("CMD /C """ + BinMake + "\cfgconvert\cfgConvert.exe"" -bin -dst " + _to + " " + _from)) exitWith{Failed=1;};
	};

    _file = nil;
};

readFile =
{
	private ["_content","_file"];
	_file = openFile [_this, 1];
	if (isnil "_file") then
	{ 
		messagebox [_this,1,"Joblist doesn't exist"];

	}
	else
	{
	_content = openMemoryStream "";
    while {!eof _file} do 
	{
		_content << (getLine _file + eoln);
	};
	_file = nil;
	call getBuffer _content;// this crap probably puts stuff into undocumented joblist
	_content = nil;
};
};
_FileExists=
{
	private ["_file","_res","_ok"];
	_ok=false;
	_file=_this @0;
	_res=OpenFile[_file,0];
	if (!isnil "_res") then {_ok=true;};
	_res=nil;
	_ok
};

_FolderToPack="";
_destDir="";
main =
{
    private ["_stream","_scrap","_cleanTemp","_optG","_cmd","_Dir2Pack","_tempDir","_tempPath","_win64"];
	Failed=0;
	setCD Drive;
	_stream = shellCmdOpenPipe("reg query ""HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0"" /v Identifier");
	_stream skipUntil "REG_SZ";
	_stream ignore 6;

	_win64 = if(_stream exploreFor "(.*)x86(.*)")then{""}else{"\Wow6432Node"};

	DebugLog << "Reading registry for BinPBO and BinMake paths:" << eoln;

	_stream = shellCmdOpenPipe("reg query ""HKEY_LOCAL_MACHINE\SOFTWARE" + _win64 + "\Bohemia Interactive\BinPBO Personal Edition"" /v MAIN");
	_stream skipUntil "REG_SZ";
	_stream ignore 7;

	BinPBO = getline eatWS _stream;

	DebugLog << "BinPBO = " << BinPBO << eoln;

	_stream = shellCmdOpenPipe("reg query ""HKEY_LOCAL_MACHINE\SOFTWARE" + _win64 + "\Bohemia Interactive\BinMake"" /v MAIN");
	_stream skipUntil "REG_SZ";
	_stream ignore 7;

	BinMake = getline eatWS _stream;

	_stream = nil;

	if(BinMake == "" || BinPBO == "")exitWith{console << eoln << "Please install BinMake and BinPBO." << eoln};

	_destDir = "";
	_cleanTemp = false;
	if(count _this <9) exitwith
	{
		console << "ERROR: Wrong count of arguments!" << eoln;
		console << "debug " <<str count _this << eoln;
		console << "debug " <<_this@0<< eoln;
		failed=1;
	};
		private ["_fred"];
	IgnoreExternals=false;
	IgnoreProxies=false;
	StripLog=false;
	_FolderToPack=_this@0;
	_destDir = _this @ 1;
	_cleanTemp = call compile(_this @ 2);
	SignFiles = call compile (_this @ 3);
	Noisy=call compile(_this @ 4);
	CompileForOFP=call compile(_this @ 5);
	_fred=call compile(_this @ 6);
	if (_fred==0) then {IgnoreExternals=true;};
	if (_fred>1) then {IgnoreProxies=true;};
	StripLog=call compile(_this @ 7);
	_norap=call compile(_this @ 8);
	if (_norap) then {UseMikero=false;console <<"using binarise"<<eoln;};
	DistPath=_destDir;
	_destdir=DistPath;
	[] call MakeRapCmd;

	private["_df"];
	_found=false;
	jobList=[];

/*
** joblist.txt's are special case where we can't automate the folder
** 
** if the parent folder has a config.cpp, the entire children (if any) are packed as a single pbo
*/

	/*
	** check for joblist.txt
	*/
	_df=_FolderToPack findI ".txt";
	if (IsNil("_df")) then {_df=-1;};
	if (_df!=-1) then	{_FolderToPack call readFile; 	}// can't automate
	else
	{
		/*
		** single pbo check
		*/
		if (([_FolderToPack +"\config.cpp"] call _FileExists)) then	{		jobList = [[_FolderToPack]];	}
		else
		{
			/*
			** recurse scan the children, any that have a config == pbo
			*/
			_found=[_FolderToPack] call _BuildJobList;

			if (!_found) exitwith{	Failed=1;	messagebox [_FolderToPack,1,"Folder doesn't exist"];};
		};

	};
	private ["_optpboNoisy","_optpboRes","_OptUnBinarised"];
	_optpboNoisy="";if (Noisy) then {_optpboNoisy="s";};
	_optpboRes="";	if (CompileForOFP) then {_optpboRes="r";};
	_optG="";		if (not IgnoreExternals) then 
	{
		_optG="g";
		if (IgnoreProxies) then {_optG="gP";};
	};

	{
		if(Failed!=0) exitWith{};
		_Dir2Pack = (_x @ 0);
		if (count _x >1) then
		{
			IsMission = call compile (_x @ 1);//not used
		};
		_tempDir = Packer+"temp";
		_tempPath = _tempDir + _Dir2Pack@[2];// skips the p:
		console <<"Processing "<<_tempPath <<eoln;
		// delete the pbo. no mattter what
		[_Dir2Pack] call DeletePbo;

		private ["_sts"];
		_sts=0;
		_OptUnBinarised="";
		[_Dir2Pack] call hasPrefix;
		if (not UseMikero) then {_sts=10;}
		else
		{
			if (PrefixDetected) then {_OptUnBinarised="u";};//allows unbinarised p3d to pass as is.
			_cmd="\tools\dostools\MakePbo.exe -k"+_optG+_OptUnBinarised+_optpboNoisy+_optpboRes+"z default "+ """"+_Dir2Pack+"""" + " " +""""+_destDir+"""";
			console<<"========Trying MakePbo======"<<eoln<<_cmd<<eoln;
			_sts=shellCmd("CMD /C "+_cmd);
		};
			console<<"=========End MakePbo========"<<eoln;
		if (_sts!=0) then
		{
			if (_sts!=10 && _sts!=11)		exitWith{Failed=1;};//10 = UNbinarised p3d detected
			console<<"attempting binarise instead"<<eoln;
			PackIsland=false; if (_sts==11) then{PackIsland=true;};//wont' work if p3d's are in same folder
			/*if (not IgnoreExternals) then
			{
				console<<"------MakePbo scanning p3d/wrps-----"<<eoln;
				_cmd="\tools\dostools\MakePbo.exe -kQ"+_optG+_OptUnBinarised+_optpboNoisy+_optpboRes+ " " + """"+_Dir2Pack+"""" + " " +""""+_destDir+"""";
				console<<_cmd<<eoln;
				_sts=shellCmd("CMD /C "+_cmd);
				if (_sts!=0)  exitwith{failed=1;};
				console<<"done"<<eoln;
			};
			if(Failed!=0) exitWith{};
			*/
			if(_cleanTemp)then 
			{
				if (Noisy) then {console << ".Deleting temp folder: " + _tempPath << eoln;};		
				shellCmd("CMD /C RD /Q /S """ + _tempPath + """");
			};
			[_Dir2Pack,_tempPath] call copyFolderStructure;
			if(Failed!=0) exitWith{console<<"copyfolderstruct failed"<<eoln;};
			[_Dir2Pack,_tempPath] call syncFolder;//scans rvmats and config
			if(Failed!=0) exitWith{};
			[_Dir2Pack,_tempPath] call binarize;
			if(Failed!=0)exitWith{};
			[_tempPath,_Dir2Pack@[3]] call Pack;
			if(Failed!=0)exitWith{};
			if (StripLog) then
			{
				_cmd="\tools\Cwr2Packer\Striplog.bat "+BinLogPath;
				console<<_cmd<<eoln;
				if (0!=shellCmd("CMD /C "+_cmd)) exitWith{Failed=1;};
			};
		};
		if (SignFiles) then { [_tempPath] call SignPbo;};
	}foreach jobList;
};
_DirHasConfig=
{
	private ["_found","_subdir"];
	_subdir=_this @0;
	_found=false;
	if ([_subdir +"\config.cpp"] call _FileExists) then
	{
		jobList = jobList+[[_subdir]];
		_found=true;
	};

	_found
};

_BuildJobList=
{
	private ["_dirs","_file","_found","_folder","_dir","_got","_subdir"];
	_folder=_this @0;
	_found=false;
	_dirs = shellCmdOpenPipe("CMD /C DIR /B/A:D-H/L " +_folder);
	while {!eof _dirs} do 
	{
		_dir = getline _dirs;
		if (_dir!="" && _dir !=".svn") then 
		{
			_subdir=_folder +"\" + _dir;
			if ([_subdir] call _DirHasConfig) then  {_found=true;}
			else // go one more level
			{
				_dirs2 = shellCmdOpenPipe("CMD /C DIR /B/A:D-H/L " +_subdir);
				while {!eof _dirs2} do 
				{
					_dir = getline _dirs2;
					if (_dir!="" && _dir !=".svn") then 
					{
						_subdir2=_subdir +"\" + _dir;
						if ([_subdir2] call _DirHasConfig) then	{_found=true;};
					};
				};
				_dirs2=nil;
			};
		};
	};	
	_dirs = nil;
	_found
};

tabs =
{
	private ["_res"];

	_res = "";
	for "_i" from 0 to DebugIntend do
	{
		_res = _res + "	";
	};
	_res
};

console = openStandardIO;
DebugIntend = -1;
DebugLog = openFile [Packer + "Packer.log",2];
console << eoln;// << "Starting packing process!" << eoln;
this call main;
if (Failed!=0)then 
{
 console << "Failed" <<eoln;
 DebugLog << "************failed*************" << eoln << eoln;
 str="failed: " + _FolderToPack;
 messagebox [str,1];
}
else 
{
	_cmd="\tools\Cwr2Packer\RenameData3D.bat "+_destDir;
	if (0!=shellCmd("CMD /C "+_cmd)) exitWith{Failed=1;};
	console << "Done" << eoln;
};
console = nil;
