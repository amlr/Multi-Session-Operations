	//Victory Conditions.
	class VictoryTime
	{
		title = $STRWFMISSIONENDTIME;
		values[] = {-1,30,45,60,90,120,180,300};
		texts[] = {$STRWFNA,"30","45","60","90","120","180","300"};
		default = -1;
	};

	class VictoryScore
	{
		title = $STRWFSCORENEEDED;
		values[] = {-1,10,25,50,100,150,250,500,1000};
		texts[] = {$STRWFNA,"10","25","50","100","150","250","500","1000"};
		default = -1;
	};

	class VictoryTowns
	{
		title = $STRWFTOWNSNEEDED;
		values[] = {-1,1000,1,2,3,5,10,15,20,25,30,35,40};
		texts[] = {$STRWFNA,$STRWFALL,"1","2","3","5","10","15","20","25","30","35","40"};
		default = -1;
	};

	//Mission variables.
	class CapturableTowns
	{
		title = $STRWFTOWNSPRESENT;
		values[] = {-1,1,2,3,4,5,6,7,8,9,10,15,20,25,30,35,40};
		texts[] = {$STRWFALL,"1","2","3","4","5","6","7","8","9","10","15","20","25","30","35","40"};
		default = -1;
	};

	class FasterTime
	{
		title = $STRWFPARAM1C;
		values[] = {0,0.25,0.5,1,2,4};
		texts[] = {$STRWFOFF,$STRWFFASTTIME15,$STRWFFASTTIME30,$STRWFFASTTIME60,$STRWFFASTTIME120,$STRWFFASTTIME240};
		default = 0;
	};

	class MinStartingDistance
	{
		title = $STRWFMINSTARTDISTANCE;
		values[] = {0,-500,-250,250,500,2500};
		texts[] = {$STRWFMISSIONDEFAULT,$STRWFVERYLOW,$STRWFLOW,$STRWFMEDIUM,$STRWFHIGH,$STRWFVERYHIGH};
		default = 2500;
	};

	class MiscSettings
	{
		title = $STRWFMISCSETTINGS;
		values[] = {0,1,2,3};
		texts[] = {$STRWFALLON,$STRWFALLOFF,$STRWFNOCIVS,$STRWFNOGRASS};
		default = 2;
	};

	class NeutralOpposition
	{
		title = $STRWFNEUTRALOPPOSITION;
		values[] = {-2,-1,0,1,2};
		texts[] = {$STRWFVERYLOW,$STRWFLOW,$STRWFNORMAL,$STRWFMEDIUM,$STRWFHIGH};
		default = 0;
	};

	class SideColorScheme
	{
		title = $STRWFSIDECOLORSCHEME;
		values[] = {0,1};
		texts[] = {$STRWFABSOLUTECOLORS,$STRWFRELATIVECOLORS};
		default = 0;
	};

	class StartTime
	{
		title = $STRWFSTARTTIME;
		//values[] = {-1,100,5,7,11,12,14,18,22,2};
		//texts[] = {$STRWFMISSIONDEFAULT,$STRWFRANDOM,$STRWFEARLYMORNING,$STRWFMORNING,$STRWFEARLYAFTERNOON,$STRWFAFTERNOON,$STRWFLATEAFTERNOON,$STRWFEVENING,$STRWFNIGHT,$STRWFLATENIGHT};
		values[] = {-1};
		texts[] = {$STRWFMISSIONDEFAULT};
		default = -1;
	};

	class Support
	{
		title = $STRWFSUPPORT;
		values[] = {-1,0,1,2,3,4};
		texts[] = {$STRWFMISSIONDEFAULT,$STRWFNONE,$STRWFFREE,$STRWFCHEAP,$STRWFNORMAL,$STRWFEXPENSIVE};
		default = 4;
	};

	class TownSpawnRange
	{
		title = $STRWFTOWNRANGE;
		values[] = {-4,-2,0,2,4,8};
		texts[] = {$STRWFVERYLOW,$STRWFLOW,$STRWFNORMAL,$STRWFMEDIUM,$STRWFHIGH,$STRWFVERYHIGH};
		default = 0;
	};

	class TownSpawnTime
	{
		title = $STRWFTOWNTIME;
		values[] = {-90,-30,0,90,150,450};
		texts[] = {$STRWFVERYLOW,$STRWFLOW,$STRWFNORMAL,$STRWFMEDIUM,$STRWFHIGH,$STRWFVERYHIGH};
		default = 0;
	};

	class GameMode
	{
		title = $STR_MP_TYPE_COOP;
		values[] = {0,1};
		texts[] = {$STRWFNO,$STRWFYES};
		default = 1;
	};

	class LimitedWarfare
	{
		title = $STR_WFLIMITEDWARFARE;
		values[] = {0,1};
		texts[] = {$STRWFNO,$STRWFYES};
		default = 0;
	};
