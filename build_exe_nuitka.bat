@echo off
REM EXPERIMENTAL — Nuitka build (alternative to PyInstaller).
REM
REM Run this on a Windows machine, inside this folder, with Python 3.9+
REM and a C compiler available (Nuitka will offer to download MinGW64
REM automatically on first run if you don't have MSVC installed — just
REM accept the prompt).
REM
REM Why try this: Nuitka compiles Python to real C, then to a native
REM binary — it does not use PyInstaller's bootloader/archive-in-overlay
REM structure, which is what a handful of heuristic-heavy antivirus
REM engines (Gridinsoft, Skyhigh SWG, SecureAge, etc.) key on. This is
REM the standard next step for reducing PyInstaller-specific false
REM positives.
REM
REM This is NOT guaranteed to work first try — pywebview's Windows
REM backend (WebView2/pythonnet) can need extra --include flags
REM depending on your installed pywebview version. If it fails, copy
REM the full error output back for troubleshooting.

echo === Installing dependencies ===
pip install -r requirements.txt
pip install nuitka

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
powershell -Command "Compress-Archive -Path dist_nuitka\main.dist\* -DestinationPath dist_nuitka\PrintResolutionCalculator-nuitka.zip -Force"

echo.
echo === Done ===
echo App folder: dist_nuitka\main.dist\
echo Zipped copy: dist_nuitka\PrintResolutionCalculator-nuitka.zip
echo.
echo Test it thoroughly before replacing the PyInstaller pipeline:
echo run the exe, check both calculator tabs work, then re-upload
echo to VirusTotal to compare the detection count.
pause
