#define _ARMA_

class CfgPatches
{
 class acme_main
 {
  units[] = {};
  weapons[] = {};
  requiredVersion = 1.62;
  requiredAddons[] = {"CBA_XEH","CBA_OA_XEH","CBA_MAIN","CBA_OA_MAIN","CA_Modules","CAFonts"};
  author[] = {"ACME Team - Wolffy.au, Tupolov, HighHead, Rommel, JMan, Friznit"};
  authorUrl = "http://acme.dev-heaven.net";
  versionDesc = "A.C.M.E.";
  versionAct = "['MAIN',_this] execVM '\x\acme\addons\main\about.sqf';";
  version = "1.0.0.0";
  versionStr = "1.0.0.0";
  versionAr[] = {1,0,0,0};
 };
};
class CfgMods
{
 class acme
 {
  dir = "@ACME";
  name = "Core - Advanced Co-op Mission Environment";
  picture = "ca\ui\data\logo_arma2ep1_ca.paa";
  hidePicture = "true";
  hideName = "true";
  actionName = "Website";
  action = "http://acme.dev-heaven.net";
  description = "Bugtracker: http://dev-heaven.net/projects/acme<br/>Documentation: http://acme.dev-heaven.net";
 };
};
class CfgSettings 
{
   class CBA 
   {
      class Versioning 
	  {
         // This registers ACME with the versioning system and looks for version info at CfgPatches -> MyMod_main
         class acme 
		 {
           // Optional: Manually specify the Main Addon for this mod
           main_addon = "acme"; // Uncomment and specify this to manually define the Main Addon (CfgPatches entry) of the mod

           // Optional: Add a custom handler function triggered upon version mismatch
           handler = "acme_main_fnc_mismatch"; // Adds a custom script function that will be triggered on version mismatch. Make sure this function is compiled at a called preInit, not spawn/execVM

           // Optional: Dependencies
           // Example: Dependency on CBA
           
            class Dependencies 
			{
                    CBA[] = {"cba_main",{ 1,0,0 },"true"};
					XEH[] = {"cba_xeh",{ 1,0,0 },"true"};
            };

           // Optional: Removed addons Upgrade registry
           // Example: myMod_addon1 was removed and it's important the user doesn't still have it loaded
           //removed[] = {"myMod_addon1"};
         };
      };
   };
   class ACME
   {
		// Server Settings - this should really be read from file (ACE does this with sys_settings)
		class acme_server_settings
		{
			checkpbos = 1;
			checklist[] = {};
			check_all_acme_pbos = 1;
			exclude_pbos[] = {};
		};
	};
};
class CfgSounds
{
 class ACME_VERSION_DING
 {
  name = "ACME_VERSION_DING";
  sound[] = {"\x\acme\addons\main\sound\acme_version_ding.ogg","db+10",1};
  titles[] = {};
 };
};

class RscStandardDisplay;
class RscText;
class RscPicture;
class RscActiveText;
class RscStructuredText;
class RscEdit;
class RscButton_small;
class RscShortcutButton;
class RscButton;
class RscLine;
class CA_Title;
class RscControlsGroup;

class ACME_ABOUT_CTRL: RscActiveText
{
 idc = -1;
 style = "0x02+ 0x04+ 0x100";
 x = "(0.025 * safeZoneW) + safeZoneX";
 y = "(0.92 * safeZoneH) + safeZoneY";
 w = "0.04 * safeZoneW";
 h = "0.02 * safeZoneH";
 sizeEx = "0.025 * SafeZoneH";
 color[] = {0.8784,0.8471,0.651,1};
 colorActive[] = {0.543,0.5742,0.4102,1};
 text = "About";
 onButtonClick = "";
};

class ACME_VERSION_MISMATCH
{
 idd = 114111;
 movingEnable = 1;
 duration = 99999999;
 fadein = 0.5;
 fadeout = 0.5;
 name = "ACME_VERSION_MISMATCH";
 onLoad = "with uiNameSpace do { ACME_VERSION_MISMATCH = _this select 0 }; playSound ""ACME_VERSION_DING"";";
 controls[] = {"ACME_VERSION_MISMATCH_BG","ACME_VERSION_MISMATCH_TITLE","ACME_VERSION_MISMATCH_TEXT","ACME_VERSION_MISMATCH_BUTT","ACME_VERSION_MISMATCH_LINE","ACME_VERSION_MISMATCH_HTML","ACME_VERSION_MISMATCH_LINE2"};
 class ACME_VERSION_MISMATCH_BG
 {
  moving = 1;
  idc = 101;
  type = 0;
  colorText[] = {0,1,0,0.5};
  font = "Bitstream";
  colorBackground[] = {0.1882,0.2588,0.149,0.76};
  text = "";
  style = 128;
  sizeEx = 0.015;
  size = 0.015;
  x = "SafeZoneX+ 0.2";
  y = "SafeZoneY+ 0.4";
  w = 0.6;
  h = 0.35;
 };
 class ACME_VERSION_MISMATCH_TITLE
 {
  access = 0;
  type = 13;
  idc = 4112;
  style = "2 + 16";
  lineSpacing = 1;
  x = "SafeZoneX+ 0.21";
  y = "SafeZoneY+ 0.41";
  w = 0.5;
  h = 0.12;
  sizeEx = 0.035;
  size = 0.035;
  colorBackground[] = {0.1882,0.2588,0.149,0};
  colorText[] = {0,0,0,1};
  text = "FEHLER";
  font = "BitStream";
  class Attributes
  {
   font = "BitStream";
   color = "#FF0F00";
   align = "left";
   shadow = "false";
  };
 };
 class ACME_VERSION_MISMATCH_LINE
 {
  idc = -1;
  type = 0;
  style = 176;
  x = "SafeZoneX+ 0.2 + 0.01";
  y = "SafeZoneY+ 0.445";
  w = 0.58;
  h = 0.0;
  colorText[] = {1,1,1,1};
  colorBackground[] = {0.1882,0.2588,0.149,0};
  font = "Bitstream";
  sizeEx = 0.04;
  size = 0.04;
  text = "";
 };
 class ACME_VERSION_MISMATCH_TEXT: ACME_VERSION_MISMATCH_TITLE
 {
  idc = 114113;
  style = "0x00";
  x = "SafeZoneX+ 0.2";
  y = "SafeZoneY+ 0.446";
  w = 0.6;
  h = 0.25;
  sizeEx = 0.027;
  size = 0.027;
  text = "";
  class Attributes
  {
   font = "TahomaB";
   color = "#000000";
   align = "center";
   valign = "middle";
   shadow = "false";
   shadowColor = "#ff0000";
   size = "1";
  };
 };
 class ACME_VERSION_MISMATCH_LINE2: ACME_VERSION_MISMATCH_LINE
 {
  y = "SafeZoneY+ 0.65";
 };
 class ACME_VERSION_MISMATCH_BUTT
 {
  idc = 114114;
  type = 11;
  style = "0x00";
  x = "SafeZoneX+ 0.7";
  y = "SafeZoneY+ 0.7";
  w = 0.1;
  h = 0.035;
  font = "Zeppelin32";
  sizeEx = 0.018;
  size = 0.018;
  color[] = {1,1,1,1};
  colorActive[] = {1,0.2,0.2,1};
  soundEnter[] = {"",0,1};
  soundPush[] = {"",0,1};
  soundClick[] = {"",0,1};
  soundEscape[] = {"",0,1};
  action = "closedialog 0";
  text = "";
  default = "true";
 };
 class ACME_VERSION_MISMATCH_HTML: ACME_VERSION_MISMATCH_TITLE
 {
  idc = -1;
  x = "SafeZoneX+ 0.2";
  y = "SafeZoneY+ 0.7";
  w = 0.575;
  h = 0.05;
  size = 0.027;
  colorText[] = {1,1,1,1};
  sizeEx = 0.027;
  text = "http://dev-heaven.net/projects/activity/ACME";
  class Attributes{};
 };
};

class ACME_ABOUT_DLG
{
 idd = 114137;
 movingEnable = 0;
 onLoad = "with uiNameSpace do { ACME_ABOUT_DLG = _this select 0; };";
 onKeyDown = "if((_this select 1) == 1) then {ACME_ABOUT_STP = true;};";
 class controlsBackground
 {
  class Contents: RscStructuredText
  {
   idc = 1141371;
   colorBackground[] = {0,0,0,0};
   x = "(0.45 * safeZoneW) + safeZoneX";
   y = "(0.25 * safeZoneH) + safeZoneY";
   w = "0.45 * safeZoneW";
   h = "0.6 * safeZoneH";
   size = "0.025 * SafeZoneH";
   class Attributes
   {
    font = "TahomaB";
    color = "#C8C8C8";
    align = "left";
    valign = "middle";
    shadow = "true";
    shadowColor = "#191970";
    size = "1";
   };
  };
  class ACME_ABOUT_NEXT: ACME_ABOUT_CTRL
  {
   idc = 1141372;
   x = "(0.065 * safeZoneW) + safeZoneX";
   w = "0.03 * safeZoneW";
   text = "";
   action = "";
  };
 };
};

class Extended_PreInit_EventHandlers
{
 class acme_main
 {
  init = "call ('\x\acme\addons\main\XEH_preInit.sqf' call SLX_XEH_COMPILE)";
  serverInit = "call ('\x\acme\addons\main\XEH_preServerInit.sqf' call SLX_XEH_COMPILE)";
 };
};

class Extended_PostInit_EventHandlers
{
 class acme_main
 {
  serverInit = "call ('\x\acme\addons\main\XEH_PostServerInit.sqf' call SLX_XEH_COMPILE)";
  clientInit = "call ('\x\acme\addons\main\XEH_postClientInit.sqf' call SLX_XEH_COMPILE)";
 };
};

class Extended_Killed_Eventhandlers
{
	class LANDVEHICLE
	{
		landvehicle_killed = "_this call acme_main_fnc_unitKilled";
	};
	class MAN
	{
		man_killed = "_this call acme_main_fnc_unitKilled";
	};
	class AIR
	{
		air_killed = "_this call acme_main_fnc_unitKilled";
	};
	class SHIP
	{
		ship_killed = "_this call acme_main_fnc_unitKilled";
	};
};

class Extended_FiredBIS_EventHandlers
{
 class CAManBase
 {
  class acme_main
  {
   firedBis = "_this call acme_main_fnc_fired";
  };
 };
};

class Extended_Init_EventHandlers
{
 class ACME_Logic
 {
  class acme_main
  {
   init = "(_this select 0) enableSimulation false";
  };
 };
};

class CfgFunctions
{
	class ACME
	{
		class Main
		{
			class particle
			{
				description = "Creates particlesource and attaches on unit";
				file = "\x\acme\addons\main\fnc_particle.sqf";
		   };
		   class track
		   {
				description = "Tracks an object with markers and particles";
				file = "\x\acme\addons\main\fnc_track.sqf";
		   };
		};
	};
	
	class BIS
	{
		class misc
		{
		   class PosToGrid
		   {
				file = "\x\acme\addons\main\fnc_posToGrid.sqf";
		   };
		};
	};
};

class ACME_Config
{
 class acme_pbos
 {
  access = 2;
  acme_pbos[] = {""}; // Client based PBOs?
 };
};

class CfgMarkers
{
 class Flag;
 class ACME_Flag: Flag{};
};

class CfgVehicles
{
 class All
 {
  class ACME{};
 };
  class Logic;
 class ACME_Logic: Logic
 {
  displayname = "$STR_ACME_LOGIC";
 };
 class ACME_Required_Logic: ACME_Logic
 {
  displayName = "$STR_ACME_REQUIRED";
  vehicleClass = "Modules";
 };
 class ACME_BI_Animals_Logic: ACME_Logic
 {
  scope = 1;
  displayName = "$STR_ACME_BI_ANIMALS";
  icon = "\x\acme\addons\main\data\icon\icon_Animals_ca.paa";
  vehicleClass = "Modules";
  class Eventhandlers
  {
   init = "_this spawn ('\ca\modules\animals\data\scripts\init.sqf' call {_slx_xeh_compile = uiNamespace getVariable 'SLX_XEH_COMPILE'; if (isNil '_slx_xeh_compile') then { _this call compile preProcessFileLineNumbers 'x\cba\addons\xeh\init_compile.sqf' } else { _this call _slx_xeh_compile } })";
  };
 };
 class HeliHEmpty;
 class ACME_LogicDummy: HeliHEmpty
 {
  scope = 1;
  SLX_XEH_DISABLED = 1;
  class EventHandlers
  {
   init = "(_this select 0) enableSimulation false";
  };
 };
};
