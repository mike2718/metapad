echo off
cd /d %~dp0
set "CL="
del /q Release\*.obj Release\*.exe Release\*.res Release\*.pdb Release\*.idb Release\*.manifest
nmake /f Makefile
del /q Release\*.obj Release\*.res Release\*.pdb Release\*.idb
