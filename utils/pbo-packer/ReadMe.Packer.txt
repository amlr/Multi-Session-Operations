two >>>>>>>>>>example<<<<<<<< bats proved per respective operating system

if you've installed bis tools "normally", one of them should work un-altered

----------------------------

General Notes

The packer UNCONDITIONALLY copies paa.
The packer UNCONDITIONALLY recompiles configs, rvmats and missions
The packer converts ANY tga /png reference inside a config or rvmat or mission.sqm to paa inside the resulting bin file


IF the packer discovers a png/tga in the source, AND, no equivalent paa is detected, that tga is compiled. ONCE

TGA's and png's are deprecated.

TGAHelper.p3d's are NOT required.

exclude lists are NOT required (makepbo is quite intelligent)

-----------------------------------------------------------------------------------------------------------------


Packer Options:


OFP Compile

This is a confidence test.

A mirror of the cwr2 STRUCTURE exists in p:\ofp (but obviously not all it's files)

It is intended to ensure that the parm values and the names remain compatible with ofp. Similar vehicle charactersitics eg, similar
fire and weapon effects (as originally intended) and, importantly the SAME NAMES FOR MISSION/SQS COMPATIBILITY

(The packer will binarise configs in ofp format)


Not all files are present on the svn. Most of the data comes from ofp and held offline

The defines _ARMA_ and _OFP_ are present in most configs to distinguish file path differences

vairiables are generally common to both. Those not understood by ofp are ignored by ofp, and vice versa. Hence, it is 'safe' 
to write a common config.


-------------------------------

Noisy:

Noisy output applies to the dos console only. It slows down processing (obviously). It should normally only be used to track a 
bug.


Note that noisy does NOT apply to the log files.

Log files are only valid when binarise is used. The packer attempts to use rapify wherever possible for speed reasons. 


------------------------------

Sign Pbo's:

only intended at distribution time.

------------------------------
Pack Everything: self evident


-----------------------------
Clean Temp:

All bets are off. No matter what binarise thinks is 'ok' in the temp folders, it' isn't it's been erased. This causes a total recompile of teh 
the p3d/wrp and whatever. Muhc Much slower.

----------------------
No externals:

If you dont want to check that file.paa or \some\rvmat actually exists. well, be my guest


