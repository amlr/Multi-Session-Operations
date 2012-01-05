@echo off

SET /A ARGS_COUNT=0
FOR %%A in (%*) DO SET /A ARGS_COUNT+=1
if %ARGS_COUNT%==0 (goto err)

set modulesfolder=%1%

echo. > modules2.tmp
dir /b /ad %modulesfolder%\* > dirlist.tmp
findstr /bc:"#define" %modulesfolder%\modules.hpp > modules.tmp
FOR /f "usebackq tokens=2" %%A in ("modules.tmp") do @echo %%A >> modules2.tmp
move /y modules2.tmp modules.tmp > nul

for /f "tokens=1* usebackq delims=" %%A in (dirlist.tmp) do (
findstr /ic:"%%A" modules.tmp > temp.tmp
findstr . temp.tmp > nul 
if ERRORLEVEL 1 (
echo Deleting "%modulesfolder%\%%A"
rd /q /s "%modulesfolder%\%%A"
)
)

del /q *.tmp

goto end

:err
echo No modules directory given

:end
