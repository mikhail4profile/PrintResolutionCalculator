@echo off
REM Run this on a Windows machine, inside this folder, with Python 3.9+ installed.
REM
REM Builds an unpacked (onedir) app with:
REM   - UPX compression disabled (--noupx)
REM   - a real custom icon (icon.ico) instead of PyInstaller's generic default
REM   - proper Windows version/company/product metadata (version_info.txt)
REM These three together are the standard, well-documented way to reduce
REM false-positive antivirus/heuristic detections on PyInstaller builds
REM (e.g. Trojan:Win32/Wacatac.B!ml-style flags) — they make the binary
REM look like what it actually is: a normal, versioned desktop app.

echo === Installing dependencies ===
pip install -r requirements.txt

echo === Building with PyInstaller (onedir, no UPX, versioned, icon) ===
pyinstaller --noconfirm --onedir --noupx --windowed ^
  --name PrintResolutionCalculator ^
  --icon=icon.ico ^
  --version-file=version_info.txt ^
  --add-data "print-resolution-calculator.html;." ^
  main.py

echo === Zipping the build output ===
powershell -Command "Compress-Archive -Path dist\PrintResolutionCalculator\* -DestinationPath dist\PrintResolutionCalculator-windows.zip -Force"

echo.
echo === Done ===
echo App folder: dist\PrintResolutionCalculator\
echo Zipped copy: dist\PrintResolutionCalculator-windows.zip
pause
