@echo off
echo "Running the update-date script..." > update-log.txt

:: Get current date and time
for /f "tokens=1-3 delims=/" %%a in ("%date%") do set DAY=%%a& set MONTH=%%b& set YEAR=%%c
for /f "tokens=1-2 delims=: " %%a in ("%time%") do set HOUR=%%a& set MIN=%%b

:: Format the current date and time (YYYY-MM-DD HH:MM:SS)
set DATE_STR=%YEAR%-%MONTH%-%DAY% %HOUR%:%MIN%

:: Set the file path
set FILE_PATH=Layout/NavMenu.razor
set SEARCH="@UpdateDate ="

:: Log original content of NavMenu.razor before modification
echo "Original content of NavMenu.razor before modification:" >> update-log.txt
type %FILE_PATH% >> update-log.txt

:: Backup the original file
copy /y %FILE_PATH% %FILE_PATH%.bak

:: Update the date line in NavMenu.razor
(for /f "tokens=1,*" %%i in (%FILE_PATH%) do (
    set line=%%i
    if "!line!" neq "%SEARCH%" (
        echo %%i
    ) else (
        echo @UpdateDate = "!DATE_STR!";  :: Replace with current date and time
    )
)) > %FILE_PATH%.new

:: Update the timestamp of NavMenu.razor to force Visual Studio to rebuild the file
powershell -Command "(Get-Item 'Layout/NavMenu.razor').LastWriteTime = Get-Date"

:: Replace the original file with the updated one
move /y %FILE_PATH%.new %FILE_PATH%

:: Log new content of NavMenu.razor after update
echo "Updated content of NavMenu.razor after modification:" >> update-log.txt
type %FILE_PATH% >> update-log.txt

:: Update the timestamp of NavMenu.razor to force VS rebuild
powershell -Command "(Get-Item 'Layout/NavMenu.razor').LastWriteTime = Get-Date"

echo Date updated to: %DATE_STR% >> update-log.txt
pause
