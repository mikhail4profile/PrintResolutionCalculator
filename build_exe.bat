@echo off
REM Run this on a Windows machine, inside this folder, with Python 3.9+
REM and a C compiler available (Nuitka will offer to download MinGW64
REM automatically on first run if you don't have MSVC installed — just
REM accept the prompt).
REM
REM This project builds with Nuitka rather than PyInstaller: Nuitka
REM compiles Python to real C, then to a native binary, avoiding the
REM bootloader/archive-in-overlay structure that a number of heuristic
REM antivirus engines flag on PyInstaller builds regardless of what the
REM Python code actually does. Verified clean (0/71) on VirusTotal.

echo === Installing dependencies ===
pip install -r requirements.txt

echo === Building with Nuitka (standalone) ===
python -m nuitka ^
  --standalone ^
  --windows-console-mode=disable ^
  --windows-icon-from-ico=icon.ico ^
  --include-data-files=print-resolution-calculator.html=print-resolution-calculator.html ^
  --output-dir=dist_nuitka ^
  --output-filename=PrintResolutionCalculator.exe ^
  --assume-yes-for-downloads ^
  main.py

echo === Zipping the build output ===
powershell -Command "Compress-Archive -Path dist_nuitka\main.dist\* -DestinationPath dist_nuitka\PrintResolutionCalculator-windows.zip -Force"

echo.
echo === Done ===
echo App folder: dist_nuitka\main.dist\
echo Zipped copy: dist_nuitka\PrintResolutionCalculator-windows.zip
pause
