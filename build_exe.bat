@echo off
REM Run this on a Windows machine, inside this folder, with Python 3.9+ installed.
REM It installs dependencies and builds a single-file PrintResolutionCalculator.exe

echo === Installing dependencies ===
pip install -r requirements.txt

echo === Building exe with PyInstaller ===
pyinstaller --noconfirm --onefile --windowed ^
  --name PrintResolutionCalculator ^
  --add-data "print-resolution-calculator.html;." ^
  main.py

echo.
echo === Done ===
echo Your exe is in the "dist" folder: dist\PrintResolutionCalculator.exe
pause
