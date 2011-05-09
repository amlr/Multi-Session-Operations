SR5 Tactical IED detection and Ordnance Disposal script, by Reezo
Jan 14th, 2011 - check version number in .version.txt
Visit us at www.sr5tactical.net
This script is dedicated to Valeria, my girlfriend who lets me play ArmA 2!

Description:
This script allows a unit or vehicle to detect IEDs, explosive ordnance and bombs, allowing disposal functions such as manual defuse, remotely controlled detonations etc.

Purpose:
- Enhance the EOD department
- Specialize Engineer roles
- Increase the fun in Ordnance Disposal
- Cover an important, realistic and very actual element of modern warfare: improvised explosive devices, car bombs and other guerrilla techniques that vastly affected all modern Middle-East war theaters like Afghanistan and Iraq

Features:
- Custom images and sounds
- Fully modular for easy installation
- Clean and carefully polished code
- Works with virtually any mod
- Works in SP and MP environments
- Strives to work with all the best and most popular IED scripts available in the ArmA community
- Detector unit receives IED approximated position in the map
- IED position marker relocate dynamically when IED moves (e.g. moving car-bombs)
- Detection range is affected by speed: units and vehicles should move slowly to allow maximum detection range
- Remotely controlled detonation via electromagnetic pulse (EMP)
- Fake IED detections with subsequent "clear" notification when anomaly verifications are found non-consistent
- Manual defuse
- Make any objects a detectable bomb or attach a bomb to it
- Detach and defuse attached detected devices
- Accidentally arm the bomb when manual defuse goes wrong
- Decide whether detectable bombs beep regularly, remain silent or let the script decide, randomly
- Armed bombs start beeping increasingly faster until they explode
- Turn any unit into a triggerman, even unsuspected civilians
- Triggermen can be suicide bombers or have the bomb attached to any object from a specific class (e.g. trashcans, cars, etc.)
- Works with ALICE and SILVIE modules: you can spawn a triggerman from civilians in determined areas, just by using a trigger
- Triggermen will behave as instructed by the AI, the module or the mission maker, until the time is right for them to touch the bomb off
- Triggermen freeze and fear enemy soldiers aiming their weapon on them: having a triggerman or a suspect under your crosshair will decrease the chances of a detonation, allowing maneuvering and refusal, if necessary.
- Triggermen who successfully detonate their bomb or find it defused might surrender, flee or engage into a firefight by drawing a hidden weapon
- Killing a triggerman is considered legit for the ROE only when he reveals his offensive action: shooting civilians to prevent suicide bombers is not right
- Killing a triggerman leaves his bomb intact, meaning it might still go off if damaged and must be considered dangerous (can be detected and defused normally)
- Realistic behavior creates the right amount of pressure and simulation for the virtual environment

Requirements:
- None, this script suite works with any installation of ArmA 2, OA and CO
- It is pretty much 99% update-safe, meaning there is practically no official update that can break the script suite

How to set it up:
1) Copy the following folder into your mission folder:
    > scripts\IEDdetect
   
2) Open the description.ext and add the #include lines to your description.ext

3) Open the init.sqf and add that line to your init.sqf

4a) In the editor, to turn a unit or vehicle into a detector, put this in its init field:
UNITS: nul0 = [this,50,10,20,01] execVM "scripts\IEDdetect\IEDdetect_detector.sqf";
VEHICLES: nul0 = [this,50,10,20,01] execVM "scripts\IEDdetect\IEDdetect_detector_vehicle.sqf";
Where:
this - is the unit that will become the detector
50 - is the detection range (the higher the further IEDs will be detected)
10 - is the scan interval, in seconds (don't make it too short or it could worsen the server performance)
20 - is the probability (in %) of being able to remotely detonated a detected bomb, via EMP
01 - is the probability (in %) of receiving inconsistent anomalies (= fake IED reports)

4b) In the editor, to make an object detectable by a detector unit, put this in the object init field:
nul0 = [this,0] execVM "scripts\IEDdetect\IEDdetect_add.sqf";
Where:
this - is the object that will become detectable
0 - is the beeping (0=no beep, 1=beep, 2=random)

4c) In the editor, to attach a detectable IED/bomb to an object, put this in the object init field:
nul0 = [this,0] execVM "scripts\IEDdetect\IEDdetect_attach.sqf";
Where:
this - is the object that will have a detectable IED/bomb attached
0 - is the beeping (0=no beep, 1=beep, 2=random)

4d) In the editor, to turn an object into a proximity IED, put this in the object init field:
nul0 = [this,0,1] execVM "scripts\IEDdetect\IEDdetect_proximity.sqf";
Where:
this - is the object that will have a detectable IED/bomb attached
0 - is the beeping (0=no beep, 1=beep, 2=random)
1 - is the trigger required pressure weight (0=personnel, 1=vehicle 2=random)

4e) In the editor, to make an AI unit a triggerman (see below for an explanation), put this in the unit init field:
nul0 = [this,skodabomb,0,50,30,WEST] execVM "scripts\IEDdetect\IEDdetect_triggerman.sqf";
Where:
this - is the unit that will become a triggerman
skodabomb - is the object that the IED/bomb will be attached to
0 - is the beeping (0=no beep, 1=beep, 2=random)
50 - is the radius for the triggerman to check for enemy units that might discover him and cause fear (see below)
30 - is the radius from the bomb that will be considered deadly, for the triggerman. The triggerman will wait for at least one enemy unit to enter this radius from the bomb before considering to touch the bomb off
WEST - is the side that the triggerman will consider as enemy

What is a triggerman? A triggerman is a unit that can trigger a bomb remotely (using a cell phone or similar tools).
With this script a triggerman will start to "fear" enemy units (e.g. BLUFOR soldiers) when they get into a determined radius (50, in the example above). The triggerman's fear will build up if an enemy soldier keeps the triggerman targeted in his crosshairs. Keeping a triggerman under your crosshair will give you a good chance to prevent him from touching the bomb off. If you take the crosshairs away from him he will start to take adavantage of the situation (depending on how much he had been kept under guard). Once the triggerman feels safe about it and if he notices potential victims around the bomb area (determined by a radius of "30" in the example above) he will trigger the bomb.
When a triggerman triggers a bomb he goes into a "surrendering" position and shouts: "Allahu Akbar!!". This gives anyone roughly around 1 second to shoot the motherf*cker down. If he dies before the touching the bomb off, the bomb will NOT explode but it will be still considered a potential threat and will require appropriate disposal from an engineer.

NOTE: if you want to make suicide bombers, just put "this" in both fields, so that the unit is both the triggerman and the bomb. e.g. nul0 = [this,this,0,30,30,WEST] execVM "scripts\IEDdetect\IEDdetect_triggerman.sqf";

4f) You can also create a trigger and let a script randomly decide to pick up a unit of a certain type and turn into a triggerman. To do so, create a trigger on, let's say, a town. Make it as large as you want to cover the entire town or just parts of it. Choose the side to activate it, let's say, BLUFOR, and make it PRESENT.
In the "On activation" field, type:
nul0 = [IEDarea1,50,"car",0,60,30,25,65,WEST] execVM "scripts\IEDdetect\IEDdetect_triggerman_spawn.sqf";
Where:
IEDarea1 - is the trigger name (make sure you give it a name and this matches it, or it won't work)
50 - is the % of having a triggerman, if you use 100 there will definitely be a triggerman
"car" - is the object type that a triggerman might use for attaching a bomb.
0 - is the beeping (0=no beep, 1=beep, 2=random)
60 - is the area to scan for suitable objects (e.g. "car") and attach the bomb to one of those, randomly. This is also the scan area for the triggerman to trigger the bomb
30 - is the area to scan for hostiles that can instill fear in the triggerman (read above for how fear works).
25 - is the area to scan for possible victims that will make the triggerman touch the bomb off.
65 - is the % for the triggerman to be a suicide bomber instead
WEST - is the side to consider enemy of the triggerman

4g) You can also use what I called the "Ambient Bombers" script. To do so, write this in your init.sqf file:
nul0 = [200,4,50,10,"car",0,55,30,25,65,WEST] execVM "scripts\IEDdetect\IEDdetect_ambientBombers.sqf";
Where:
200 - is the ambient radius from the player
4 - is the minimum amount of civilians near the player
50 - is the % of presence of a triggerman among them
10 - is the scan interval time
"car" - is the object classtype of what could potentially host triggermen bombs
0 - is the beeping (0=no beep, 1=beep, 2=random)
55 - is the area to scan for suitable objects (e.g. "car") and attach the bomb to one of those, randomly. This is also the scan area for the triggerman to trigger the bomb
30 - is the area to scan for hostiles that can instill fear in the triggerman (read above for how fear works)
25 - is the area to scan for possible victims that will make the triggerman touch the bomb off
65 - is the % for the triggerman to be a suicide bomber instead
WEST - is the side to consider enemy of the triggerman

This script works by attaching itself to group leaders of the enemy faction ONLY (WEST in the example). This means it will work as a sort of Ambient Combat Module (ACM), following group leaders and "making things happen around them". The script checks for civilian presence in a pre-determined "ambient radius" (200m in the example) around the player. If a minimum number of civilians (4 in the example) is found, it will try the % of presence (50 in the example) for a triggerman to be among them. If positive, it will turn one of the civilians into a triggerman and decide whether it is a suicide bomber or a remote-detonator. In case it is the latter, it will scan for a specific object class ("car" in the example) in a pre-determined radius from the triggerman (55 in the example) and attach a bomb to it. After that the triggerman will behave just like illustrated in the previous paragraph. The script pauses itself for the interval specified by the user (10 in the example) if the player stays around the same area or around the same triggerman. The script attaches itself to new leaders in case a group leader changes. This script works well with ALICE-created and user-created civilians. It also moves with the player so it is very easy to use and is totally automated.

4h) You can also use the "Ambient Proximity IEDs", which will randomly create Proximity-triggered IEDs around the player area. To do so, write this in your init.sqf file:
nul0 = [500,10,60,0,50,WEST] execVM "scripts\IEDdetect\IEDdetect_ambientProxyIEDs.sqf";
Where:
500 - is the ambient radius from the player
10 - is the chance of an IED being present
60 - is the scan interval time
0 - is the beeping (0=no beep, 1=beep, 2=random)
50 - is the chance of the IED being anti-personnel vs anti-vehicle

4i) You can also scatter proximity IEDs around a specific area. This can be useful for one-time creation of random proximity IEDs without having to use the Ambient IEDs feature. To do so, write this in your init.sqf file, into a trigger or wherever you find it suitable to your needs:
nul0 = ["scatterCenter",500,5,100,2,50] execVM "scripts\IEDdetect\IEDdetect_proximity_scatter.sqf";
Where:
"scatterCenter" - is the name of a marker placed on map, make sure the name matches your marker name. This will be the center of the scatter area
500 - is the radius to scan for good spots to spawn proximity IEDs
5 - is the number of proximity IEDs you want to spawn randomly in the area
100 - is the chance of having each of the (5) proximity IEDs spawned. This % is tested for each IED spawn.
2 - is the beeping (0=no beep, 1=beep, 2=random)
50 - is the chance of the IED being anti-personnel vs anti-vehicle

NOTE: Proximity IEDs are hardcore. You can safely disable them if keep the distance but their pressure plates will not distinguish friend from foe. Even a rabbit crossing your way while disarming the bomb can lead to bad consequences.

Procedures and functions:
- Immediately determine worst-case scenario blast radius and estimate potential human and property losses in the area
- Evacuate all non-military personnel and any other unauthorized presence from the area
- Establish roadblocks and maintain peripheral presence to avoid further non-authorized presence in the blast radius
- Fortify and consolidate military strongpoints, considering that a surprise attack or ambush is likely. Maintain units on high alert
- Investigate for possible triggerman in direct visual range of the explosive device. Do not compromise security for the investigation
- Expect triggerman concealment in plain sight, among civilian groups or behind civilian constructions
- Consider possible sentinel-relays, where a chain of individuals - with one in line of sight with the just then next one - report to a final element being the real triggerman
- Prefer remotely controlled detonations, if available
- Consider the use of anti-material rifles to destroy the bomb from a safe distance
- When no other option is available, get an EOD specialist to the bomb
- Before entering the blast radius, the best escape route from the bomb must be estimated. Cover strength and distance should be considered. Being far from the bomb while in direct line of sight will most probably result in death. Being behind a strong cover but in close proximity of the bomb will most probably result in death, too. A good escape route is one that has the best compromise between distance and strength
- Allow the specialist to reach the bomb. Do NOT escort the specialist
- Attached explosives devices can be detached and then defused
- Defusing is done through the "Defuse Bomb" action from the bomb itself 
- The instrument will start receiving numerical readings at random intervals. To successfully defuse the bomb the right code must be injected when the reading is a multiple of 3
- Failure to defuse will kickstart the electronics and send the bomb to self-destruct in a matter of seconds. There is no way to predict the amount of time available before the detonation
- Should the defuse fail, the EOD specialist must immediately reach the safest spot via his pre-planned escape route

Multiplayer compatibility:
- Tested and working. I try my best to continue improving it so further tweaking/optimizations/bug fixes are possible

Known bugs:
- There is a chance that Fake IED detection does not work. If you encounter problems, put 00 in the % and it will be disabled

Future features:
- Detector tool as an actual object you can pick up and put in your inventory

License:
I don't want to say this is a masterpiece, but I know for sure I have put a lot of time and efforts in this scripts suite. If you want to make changes I would please ask you to contact me for my permission. I would also love to have more people work on this same thing rather than having 20 people working on the same thing with different names. I am open to critics and teamwork, we can make an entire EOD mod if you want, I will try my best to make my skills match my enthusiasm.

Credits:
Demonized - global array functionality, better marker generation
VIPER[CWW], Nielsen, Kremator, SpectreRSG - bug reports and feedback
VIPER[CWW] - 'Allah Akbar!' sound
VanhA-ICON - attach/detach IEDs idea
SR5 Tactical - my men

Copyright:
Nothing I can really "claim" or track you down with..so please don't just be an assh*le and if you do any change to this script or implement it in your missions or scenarios..please add some kind of credit line to this work. It would be kind :)

How to pay me back:
- Anything really expensive

Mirroring and downloads:
Please do not mirror this file. Use the following link to get the latest, better, shiny, original version:
http://www.sr5tactical.net/sr5_reezo_ieddetect.7z
if the link is down..contact me.

For feedback, email me at info(at)sr5tactical.net

Enjoy and have fun, see you on the battlefield,
- Reezo