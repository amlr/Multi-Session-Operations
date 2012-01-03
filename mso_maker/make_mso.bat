@echo off

echo MSO Build Batch
echo Thanks to Xeno for the dom_maker scripts/tools

setlocal  EnableDelayedExpansion

set MP_DIR=MPMissions
set M_DIR=missions
set BASE_DIR=BASE_MISSION
set D_VER=4-0
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

rem zip PBO files
"c:\program files\7-zip\7z.exe" a MSO_Missions_%D_VER%.7z *.pbo

rem cleanup
cd ..
move TMPMissions %MP_DIR%_%D_VER%

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
rem copy any mission customizations back
xcopy ..\%M_DIR%\%MISSION_FOLDER_NAME% %MISSION_FOLDER_NAME% /S /Y /Q /EXCLUDE:..\mso_maker\exclude.txt
cd %MISSION_FOLDER_NAME%
call ..\..\mso_maker\clean_modules.bat ambience\modules
call ..\..\mso_maker\clean_modules.bat core\modules
call ..\..\mso_maker\clean_modules.bat enemy\modules
call ..\..\mso_maker\clean_modules.bat support\modules
cd ..
FOR /F "tokens=1,2 delims=." %%U IN ('echo %MISSION_FOLDER_NAME%') DO (CALL :setMissionNames %%U %%V)
set MISSION_FILENAME=mso%D_NUM_PLAYERS%_%MISSION_NAME%_%D_VER%.%MISSION_ISLAND%
move %MISSION_FOLDER_NAME% %MISSION_FILENAME%
set NDIR=..\TMPMissions\%MISSION_FILENAME%
cd ..
cd mso_maker
set MISSION_NAME=%MISSION_NAME:_= %
CALL :UpCase MISSION_NAME
sqm %NDIR%\mission.sqm -s briefingName * "MSO%D_NUM_PLAYERS% %MISSION_NAME% %D_BNVER%" -o %NDIR%\newmission.sqm
del %NDIR%\mission.sqm
move %NDIR%\newmission.sqm %NDIR%\mission.sqm
CALL :LoCase MISSION_FILENAME
echo Creating %MISSION_FILENAME%.pbo
cd ..\TMPMissions
makePbo -N -K %MISSION_FILENAME% 1> %MISSION_FILENAME%.txt
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