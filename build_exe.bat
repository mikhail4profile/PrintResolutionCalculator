@echo off
REM Run this on a Windows machine, inside this folder, with Python 3.9+ installed.
REM Builds an unpacked (onedir) build with UPX compression disabled — this
REM specifically reduces false-positive antivirus detections (e.g.
REM Trojan:Win32/Wacatac.B!ml) that PyInstaller's single-file mode and
REM UPX-compressed binaries commonly trigger.

echo === Installing dependencies ===
pip install -r requirements.txt

echo === Building with PyInstaller (onedir, no UPX) ===
pyinstaller --noconfirm --onedir --noupx --windowed ^
  --name PrintResolutionCalculator ^
  --add-data "print-resolution-calculator.html;." ^
  main.py

echo === Zipping the build output ===
powershell -Command "Compress-Archive -Path dist\PrintResolutionCalculator\* -DestinationPath dist\PrintResolutionCalculator-windows.zip -Force"

echo.
echo === Done ===
echo App folder: dist\PrintResolutionCalculator\
echo Zipped copy: dist\PrintResolutionCalculator-windows.zip
pause
