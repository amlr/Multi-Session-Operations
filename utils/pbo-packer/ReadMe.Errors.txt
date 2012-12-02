to use the packer you MUST

1) extract all the pbo's from arma\addons and construct a p:\ca folder therefrom
 a) the ca pbo becomes p:\ca
 b) all other folders in the arma\addons are folder trees off, p:\ca

2) extract the dta\bin pbo and dta\core pbo, dta\languagecore.pbo

3) 

because of a bug in arma, these, must be put in p:\core and p:\bin p:\languagecore respectively. NOT, p:dta\ as nature intended

COPY languagecore\stringtable.XML to P:\bin
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/////////////////////////////////////// ^^^^^ YOU WILL GET log ERRORS IF YOU DONT ^^^^^^^^^^^^^


****note that you MUST derapify all rapified content in above addons. To do so easily
****
****   \tools\addontools\extractpbo -oy nameofpbo
****
****this will automatically convert the rvmats (eg) to text output
****alternatively, you can use eliteness to achieve same purpose

===========================================================================================
if you do NOT do above, the following errors occur when packing for the following reasons;
===========================================================================================


following notes are arma, not arma2 they probably still apply


_GENERALLY_ speaking, they only occur on a clean temp build
-------------------------------------------------------------------
-------------------------------------------------
"Cannot load font core\data\fonts\lucidaconsoleb8"

caused by lack of p:\core 
--------------------------
W:\c\Poseidon\Lib\fileServer.cpp(2010) : Assertion failed '_workerThread.Size() == _nRequestsLoading'
caused by lack of p:\bin
-----------------------------

Cannot open object ca\plants\clutter_grass_general.p3d
Cannot open object ca\rocks\clutter_stone_small.p3d
etc

lack of P:ca\plants etc
----------------------------------------------------
C:\Tools\BinMake\CfgConvertFileChng\CfgConvertFileChng.exe returned error 1

ca\something have rapified rvmat files

use extractpbo -oy filename (or eliteness) to automatically convert these to text

----------------------------------------------------------------------------------
Apply clutterfix to "intro.wrp"
Error occurred during initialization of VM
java/lang/NoClassDefFoundError: java/lang/Object

your java is not installed properly
--------------------------------------

No entry 'C:\Tools\BinMake\binarize\bin\config.cpp/RscDisplayLoading/Variants/Loading_East1.idd'.

missing p:ca\ui or ca\desert





