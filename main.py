"""
Print Resolution Calculator — desktop wrapper
------------------------------------------------
This does NOT reimplement the calculator. It loads the original
print-resolution-calculator.html file (unchanged) inside a native
window via pywebview, so all HTML/CSS/JS logic stays 1:1 identical
to the browser version.

resource_path() is written to work correctly no matter which packer
built the .exe (PyInstaller or Nuitka), so this same file works for
both build pipelines without edits.
"""
import os
import sys
import webview

APP_TITLE = "Print Resolution Calculator"
HTML_FILE = "print-resolution-calculator.html"


def resource_path(relative_path: str) -> str:
    """Resolve a bundled resource path across build tools and plain
    source runs:
      - PyInstaller sets sys._MEIPASS (temp dir in --onefile mode,
        the exe's own folder in --onedir mode).
      - Nuitka (--standalone/--onefile) sets sys.frozen but not
        _MEIPASS; bundled data files sit next to sys.executable.
      - Running main.py directly (no packer): resolve next to this
        source file.
    """
    if hasattr(sys, "_MEIPASS"):
        base_path = sys._MEIPASS
    elif getattr(sys, "frozen", False):
        base_path = os.path.dirname(os.path.abspath(sys.executable))
    else:
        base_path = os.path.dirname(os.path.abspath(__file__))
    return os.path.join(base_path, relative_path)


def main():
    html_path = resource_path(HTML_FILE)
    if not os.path.exists(html_path):
        raise FileNotFoundError(
            f"Could not find {HTML_FILE} next to the executable. "
            "Make sure it was bundled as a data file by the build."
        )

    webview.create_window(
        APP_TITLE,
        html_path,
        width=1040,
        height=780,
        min_size=(760, 620),
        resizable=True,
        text_select=True,
    )
    # gui="edgechromium" forces the modern WebView2 (Chromium) engine on
    # Windows instead of the legacy MSHTML/IE fallback, which is required
    # for the calculator's JS to run correctly.
    webview.start(gui="edgechromium" if sys.platform == "win32" else None)


if __name__ == "__main__":
    main()
