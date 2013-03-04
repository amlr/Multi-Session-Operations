@echo off

echo MSO Build Batch
echo Thanks to Xeno for the dom_maker scripts/tools

setlocal  EnableDelayedExpansion

set ZIPNAME=MSO_Missions
set MP_DIR=MPMissions
set M_DIR=missions
set BASE_DIR=BASE_MISSION
set D_VER=4-6
set D_BNVER=4.6
set CODE_DIR=MSO_%BASE_DIR%_CODE_%D_VER%

echo Creating temporary mission folders and placing base mission code into each mission
cd ..
md TMPMissions
xcopy %M_DIR% TMPMissions /T /Y /Q /EXCLUDE:mso_maker\exclude.txt

cd TMPMissions
rem For each mission folder, check version, copy across mission template, update the SQM, PBO Mission, delete mission folder
FOR /F %%G IN ('dir /b') DO (CALL :processMission %%G)

rem Rename TMPMissions folder MPMissions and copy code base to folder
md %CODE_DIR%
cd ..
echo Moving TMPMissions to %MP_DIR%
move TMPMissions %MP_DIR%
echo Copying code base %BASE_DIR% to %MP_DIR%\%CODE_DIR%
xcopy %BASE_DIR% %MP_DIR%\%CODE_DIR% /S /Y /Q

echo Zipping up %MP_DIR% to %ZIPNAME%_%D_VER%.7z
del %ZIPNAME%_%D_VER%.7z 1> nul
"c:\program files\7-zip\7z.exe" a %ZIPNAME%_%D_VER%.7z %MP_DIR%

rem cleanup
echo Deleting %MP_DIR% working folder
rmdir /S /Q %MP_DIR%

echo Complete!

goto:eof

:processMission
@echo off
setlocal  EnableDelayedExpansion

set MISSION_FOLDER_NAME=%1
echo.                                                                     
echo --------------------------------------------------------------------
echo Processing Mission %MISSION_FOLDER_NAME%
echo --------------------------------------------------------------------
echo Copying PBO utilities across
xcopy ..\mso_maker\makepbo.exe . /Q /Y
xcopy ..\mso_maker\depbo.dll . /Q /Y

echo Copying code base structure to %MISSION_FOLDER_NAME%
xcopy ..\%BASE_DIR% %MISSION_FOLDER_NAME% /E /Y /Q

echo Copying Mission customisations to %MISSION_FOLDER_NAME%
xcopy ..\%M_DIR%\%MISSION_FOLDER_NAME% %MISSION_FOLDER_NAME% /S /Y /Q /EXCLUDE:..\mso_maker\exclude.txt

rem echo Checking for A2Free version
rem for /f "tokens=1,2 delims=_" %%U in ('echo %MISSION_FOLDER_NAME%') do (CALL :processA2Free %%V)

cd %MISSION_FOLDER_NAME%
call ..\..\mso_maker\clean_modules.bat ambience\modules
call ..\..\mso_maker\clean_modules.bat core\modules
call ..\..\mso_maker\clean_modules.bat enemy\modules
call ..\..\mso_maker\clean_modules.bat support\modules
cd ..
FOR /F "tokens=1,2 delims=." %%U IN ('echo %MISSION_FOLDER_NAME%') DO (CALL :setMissionNames %%U %%V)
set MISSION_FILENAME=mso_%MISSION_NAME%_%D_VER%.%MISSION_ISLAND%
move %MISSION_FOLDER_NAME% %MISSION_FILENAME%
set NDIR=..\TMPMissions\%MISSION_FILENAME%

cd ..
cd mso_maker
set MISSION_NAME=%MISSION_NAME:_= %
CALL :UpCase MISSION_NAME
echo Creating Mission Briefing Name - MSO %MISSION_NAME% %D_BNVER%
sqm %NDIR%\mission.sqm -s briefingName * "MSO %MISSION_NAME% %D_BNVER%" -o %NDIR%\newmission.sqm
del %NDIR%\mission.sqm
move %NDIR%\newmission.sqm %NDIR%\mission.sqm

CALL :LoCase MISSION_FILENAME
echo Creating %MISSION_FILENAME%.pbo
cd ..\TMPMissions
makePbo -N -K %MISSION_FILENAME% 1> nul
echo Deleting %MISSION_FILENAME% Folder
rmdir /S /Q %MISSION_FILENAME%
del makepbo.exe
del depbo.dll
goto:eof

:setMissionNames
set MISSION_NAME=%1
set MISSION_NAME=%MISSION_NAME: =%
set MISSION_ISLAND=%2
set MISSION_ISLAND=%MISSION_ISLAND: =%
goto:eof

:processA2Free
set A2FREE_NAME=%1
CALL :UpCase A2FREE_NAME
set A2FREE_NAME=%A2FREE_NAME: =%
if %A2FREE_NAME%==A2FREE (
echo Patching mission for %A2FREE_NAME%
..\mso_maker\patch.exe --ignore-whitespace -F3 -N -p1 -d %MISSION_FOLDER_NAME% < ..\mso_maker\a2free_patch.txt
echo Extracting A2Free files into %MISSION_FOLDER_NAME%
"c:\program files\7-zip\7z.exe" x -y -o%MISSION_FOLDER_NAME% ..\mso_maker\a2free_convert.7z 1> nul)
goto:eof

:LoCase
:: Subroutine to convert a variable VALUE to all lower case.
:: The argument for this subroutine is the variable NAME.
FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO CALL SET "%1=%%%1:%%~i%%"
GOTO:EOF

:UpCase
:: Subroutine to convert a variable VALUE to all UPPER CASE.
:: The argument for this subroutine is the variable NAME.
FOR %%i IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO CALL SET "%1=%%%1:%%~i%%"
GOTO:EOF