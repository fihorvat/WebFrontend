@echo off

echo Setting directory
SET Folder=%~dp0

echo Creating markdown files and images
REM create markdown files from docx

echo Directories are:

REM add /r if you want all recursively
for /d  %%i in (*) do (
	echo -  %%i 
)

REM pause
