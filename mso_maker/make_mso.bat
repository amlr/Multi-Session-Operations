rem MSO Build Batch
rem Thanks to Xeno for the dom_maker scripts/tools

@echo off

setlocal  EnableDelayedExpansion

set MP_DIR=MPMissions
set M_DIR=missions
set BASE_DIR=BASE_MISSION
set D_VER=4_0
set D_BNVER=4.0
set D_NUM_PLAYERS=32
set D_NUM_PLAYERS_TVT=16
set D_NUM_PLAYERS_CTI=16

rem Create temporary mission folders and place base mission code into each mission
cd ..
md TMPMissions
echo Copying Mission folders to temp folder
xcopy %M_DIR% TMPMissions /T /Y /Q /EXCLUDE:mso_maker\exclude.txt

cd TMPMissions
rem For each mission folder, update the SQM, rapify it, compile FSMs, PBO Mission, delete mission folder
FOR /F %%G IN ('dir /b') DO (CALL :processMission %%G)

rem cleanup
cd ..
move TMPMissions %MP_DIR%_%D_VER%
echo Complete!

goto:eof

:processMission
@echo off
setlocal  EnableDelayedExpansion
set MISSION_FOLDER_NAME=%1
echo Processing %1
rem copy base mission across
xcopy ..\%BASE_DIR% %MISSION_FOLDER_NAME% /E /Y /Q
rem copy any mission customizations back
xcopy ..\%M_DIR%\%MISSION_FOLDER_NAME% %MISSION_FOLDER_NAME% /S /Y /Q /EXCLUDE:..\mso_maker\exclude.txt
FOR /F "tokens=1,2 delims=." %%U IN ('echo %MISSION_FOLDER_NAME%') DO (CALL :setMissionNames %%U %%V)
set MISSION_FILENAME=MSO%D_NUM_PLAYERS%_%MISSION_NAME%_%D_VER%.%MISSION_ISLAND%
move %MISSION_FOLDER_NAME% %MISSION_FILENAME%
set NDIR=..\TMPMissions\%MISSION_FILENAME%
cd ..
cd mso_maker
set MISSION_NAME=%MISSION_NAME:_= %
sqm %NDIR%\mission.sqm -s briefingName * "MSO%D_NUM_PLAYERS% %MISSION_NAME% %D_BNVER%" -o %NDIR%\newmission.sqm
del %NDIR%\mission.sqm
move %NDIR%\newmission.sqm %NDIR%\mission.sqm
rapify %NDIR%\mission.sqm
del %NDIR%\mission.sqm
move %NDIR%\mission.sqm.bin %NDIR%\mission.sqm
echo Creating %MISSION_FILENAME% PBO
makePbo -N -K %NDIR% 1> %NDIR%.txt
rmdir /S /Q %NDIR%
goto:eof

:setMissionNames
set MISSION_NAME=%1
set MISSION_NAME=%MISSION_NAME: =%
set MISSION_ISLAND=%2
set MISSION_ISLAND=%MISSION_ISLAND: =%

