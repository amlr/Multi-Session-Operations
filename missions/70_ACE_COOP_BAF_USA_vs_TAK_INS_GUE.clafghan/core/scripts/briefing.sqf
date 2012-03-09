/*
	File: briefing.sqf
	Author: Tupolov

	Description:
	Briefing file for MSO

	Parameters:
	None.
 
	Execution:
	Executed from init.sqf.
*/

_aboutmso = player createDiaryRecord ["Diary", ["About Multi-Session Operations", 
"<br/>DESCRIPTION<br/>
===========<br/><br/>
The Multi-Session Operation (MSO) is the ultimate in reality-based gameplay; it is a persistent mission simulating real-life warfare to the best of our capabilities.<br/><br/>

You have limited number of lives; after which you will be kicked from the server.<br/>Player status is persistent; upon reconnection, you will respawn with all your gear at the same position you were last time you played.<br/><br/>

<t size=2 align=left>What Now?</t><br/>
Check your tasks and the notes section for after action reports, upcoming missions and recon information.<br/><br/>
 
CREDITS
========<br/><br/>

Wolffy.au<br/>
Rommel<br/>
Tupolov<br/>
Rye<br/>
Kieran<br/>
HateDread<br/>
Friznit<br/>
Zorrobyte<br/>
Mandoble - Heli route script<br/>
Loyalguard - AEG scripts<br/>
UnitedOperations.net<br/>
VOLCBAT<br/>
Bohemia Interactive Studios - Original ARMA 2 Modules<br/>
"]]; 

_notes = player createDiaryRecord ["Diary",["Mission Notes","
GENERAL NOTES
<br/><br/>
Contributions by AAF/AEF, VCB, UnitedOperations, Tupolov and Wolffy.au
<br/><br/>
If using ACRE, there is a small chance of that you will have comm issues as a JIP due to an ongoing bug in ARMA2. http://dev-heaven.net/issues/19213
<br/><br/>
If you have an issue where you can hear others but they cannot hear you, it could be due to this bug (ensure you are not experiencing terrain effects). To fix it use 'Run ACRE Sync' in your ACE self-interaction key. It should fix it. 

"]];


		_commandsignals = player createDiaryRecord ["Diary",["Command and Control","
		Each trooper has a PRR. If using ACRE leaders should also have PRC-148 radios. RTOs/Signaller, FOs/FOOs and JTACs/FACs should have PRC-117s.   <br/><br/>
		Callsigns
		<br/>
		 BROADSWORD 0A - US Platoon Commander 
		<br/>
		 BROADSWORD 0B - Platoon Sergeant 
		 <br/>
		 BROADSWORD 0C - Platoon XO
		<br/>
		 BROADSWORD 1 - US 1st platoon section (rifle) 
		<br/>
		 BROADSWORD 2 - US 2nd platoon section (rifle) 
		<br/>
		 BROADSWORD 3 - US Manoeuvre Support platoon section 
		<br/>
		SABRE 0A - UK Platoon Commander 
		<br/>
		 SABRE 0B - Platoon Sergeant 
		 <br/>
		 SABRE 0C - Platoon 2IC
		<br/>
		 SABRE 1 - UK 1st platoon section (rifle) 
		 <br/>
		 SABRE 2 - UK 2nd platoon section (rifle)  
		 <br/>
		 SABRE 3 - UK Manoeuvre Support platoon section
		<br/>
		 AXEMAN 1 - US M119 Battery Section
		 <br/>
		 LANTERN 1'1 through LANTERN 1'2 - US Transport Group (CH-47 Chinook)
		 <br/>
		 TORCH 1'1 through TORCH 1'2 - UK Transport Group (HC4 Chinook)
		 <br/>
		 FIREFLY 1'1 through FIREFLY 1'2 - US Air Assault Group (UH-60 / MH-6J)
		 <br/>
		 DRAGON 1'1 through DRAGON 1'2 - UK Air Assault Group (HC3 / AH11)
		 <br/>
		 ENFIELD 1'1 through ENFIELD 1'2 - US A-10 Flight
		 <br/>
		 BLOODHOUND 1 - US AH-1Z Flight
		 <br/>
		 UGLY 1'1 through UGLY 1'2 - UK AH1 Flight
		 <br/><br/>
		Suggested Comnet
		<br/>
		Channel 2 (Long Range) - Company Command Net (PLs, Coy CO, Transport Aircraft)<br/>
		Channel 3 (Long Range) - Air Support Net (JTACs, Attack Aircraft) <br/>
		Channel 4 (Long Range) - Fire Support Net (FDC) <br/>
		Channel 5 (Long Range) - US 1st platoon section command net (PL, squads) <br/>
		Channel 6 (Long Range) - US 2nd platoon section command net (PL, squads) <br/>
		Channel 7 (Long Range) - UK 1st platoon section command net (PL, squads) <br/>
		Channel 8 (Long Range) - UK 2nd platoon section command net (PL, squads) <br/>
		Channel 1 (Short Range) - US 1 squad, 1 platoon <br/>
		Channel 2 (Short Range) - US 1 squad, 2 platoon <br/>
		Channel 3 (Short Range) - US 1 squad, 3 platoon <br/>
		Channel 4 (Short Range) - UK 1 squad, 1 platoon <br/>
		Channel 5 (Short Range) - UK 1 squad, 2 platoon <br/>
		Channel 6 (Short Range) - UK 1 squad, 3 platoon <br/>
		Channel 14 (Short Range) - m119 section (Firebase Wonka) <br/>
		"]];	
	
		_execution = player createDiaryRecord ["Diary",["Execution","
Establish a series of patrols to impose our will on the nearby area. Locate, fix and destroy enemy groups and camps. Interdict enemy movements with fire. Win the support of the local population by securing towns. 
		"]];		
	
		_mission = player createDiaryRecord ["Diary",["Mission","
		Establish a presence in this stretch of the Korengal - bringing neutral towns to our side and establishing security for future development projects. Ensure as few casualties as possible. 
		"]];	
	
		_situation = player createDiaryRecord ["Diary",["Situation","
The Korengal valley is inhabited by an ancient, tribal people known as the Pashtuns. This is the heart of the insurgency in Afghanistan - as the local Pashtun Taliban, aided by foreign fighters, contest all major population centers. Expect no area outside of the wire to be secure. The Taliban operate in small groups, pressuring locals to support their insurgency. Larger groups are often coordinated by foreign fighters. Groups are armed with small arms, heavy and light machine guns, and small amounts of RPGs and MANPADS. They also operate technicals and a very limited number of light armored vehicles. IEDs, mortar and rocket attacks are common.<br/><br/>
Our current area of control extends to: <br/>
FOB Lincoln, United States Armed Forces 1 Platoon. <br/>
Firebase Wonka, US M119 Fire Support Group. <br/>
FOB Halifax, British Armed Forces 1 Platoon. <br/>
Prozakhar Airfield, UK and US Air Assets are based here.<br/>
		"]];
		




