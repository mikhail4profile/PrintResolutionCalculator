# Print Resolution Calculator

A local, offline calculator for preparing raster images for print:
calculates the required resolution (px) for a given print format and PPI,
the source image's effective PPI, the upscale factor, and the final size —
with aspect ratio checking.

Works as a plain `.html` file in your browser **or** as a standalone Windows
desktop app (`.exe`) — it's the same interface and logic, the second option
is just a wrapper in a native window.

## Download the ready-made .exe

The built `PrintResolutionCalculator.exe` is not stored in the repository —
grab the latest version from the **[Releases](../../releases)** page.
Nothing to install: a single file, offline, no Python required.

If there are no releases yet (or you want a fresh build from the current
code) — build it yourself, see below, or run the workflow manually from the
**Actions** tab.

## Run without building

SmartScreen may block my exe because the application is not signed. The simplest alternative option — download only `print-resolution-calculator.html` and just open it in any browser. It's the same interface as the `.exe`, with nothing to install.

## Building the .exe yourself

You'll need a Windows machine with Python 3.9+.

```bat
git clone <this-repository-URL>
cd <repository-folder>
build_exe.bat
```

The finished file will appear at `dist\PrintResolutionCalculator.exe`.

## Repository structure

```
print-resolution-calculator.html   — the interface and all calculation logic
main.py                            — native window wrapper (pywebview)
requirements.txt                   — build dependencies
build_exe.bat                      — one-command local build
.github/workflows/build-release.yml — automated build and Release publishing
```

