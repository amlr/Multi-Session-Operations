@echo off

echo MSO Build Batch
echo Thanks to Xeno for the dom_maker scripts/tools

setlocal  EnableDelayedExpansion

set ZIPNAME=MSO_Missions
set MP_DIR=MPMissions
set M_DIR=missions
set BASE_DIR=BASE_MISSION
set D_VER=4-0
set D_BNVER=4.0
set CODE_DIR=MSO_%BASE_DIR%_CODE_%D_VER%

rem Create temporary mission folders and place base mission code into each mission
cd ..
md TMPMissions
echo Copying Mission folders to temp folder
xcopy %M_DIR% TMPMissions /T /Y /Q /EXCLUDE:mso_maker\exclude.txt

cd TMPMissions
rem For each mission folder, update the SQM, PBO Mission, delete mission folder
FOR /F %%G IN ('dir /b') DO (CALL :processMission %%G)

rem Copy base mission code to TMPMissions
md %CODE_DIR%
cd ..
move TMPMissions %MP_DIR%
xcopy %BASE_DIR% %MP_DIR%\%CODE_DIR% /S /Y /Q

rem zip PBO files
"c:\program files\7-zip\7z.exe" a %ZIPNAME%_%D_VER%.7z %MP_DIR%

rem cleanup
rmdir /S /Q %MP_DIR%

echo Complete!

goto:eof

:processMission
@echo off
setlocal  EnableDelayedExpansion
set MISSION_FOLDER_NAME=%1
echo ---------------------
echo Processing %1
rem copy base mission across
xcopy ..\mso_maker\makepbo.exe . /Q /Y
xcopy ..\mso_maker\depbo.dll . /Q /Y
xcopy ..\%BASE_DIR% %MISSION_FOLDER_NAME% /E /Y /Q
pause
for /f "tokens=1,2 delims=_" %%U in ('echo %MISSION_FOLDER_NAME%') do (
if "%%U"=="A2Free" call (
rem Apply A2Free patch
..\mso_maker\patch.exe --binary -t -p1 -d %MISSION_FOLDER_NAME% < ..\mso_maker\a2free_patch.txt
"c:\program files\7-zip\7z.exe" x -o%MISSION_FOLDER_NAME% ..\mso_maker\cba-x.7z
)
pause
rem copy any mission customizations back
xcopy ..\%M_DIR%\%MISSION_FOLDER_NAME% %MISSION_FOLDER_NAME% /S /Y /Q /EXCLUDE:..\mso_maker\exclude.txt

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
sqm %NDIR%\mission.sqm -s briefingName * "MSO %MISSION_NAME% %D_BNVER%" -o %NDIR%\newmission.sqm
del %NDIR%\mission.sqm
move %NDIR%\newmission.sqm %NDIR%\mission.sqm
CALL :LoCase MISSION_FILENAME
echo Creating %MISSION_FILENAME%.pbo
cd ..\TMPMissions
makePbo -N -K %MISSION_FILENAME% 1> nul
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