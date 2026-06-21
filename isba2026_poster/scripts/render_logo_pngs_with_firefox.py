#!/usr/bin/env python3
"""Render uploaded SVG logo masters to high-resolution PNGs.

This is a controlled fallback for systems where Inkscape/CairoSVG are not
available. It uses Firefox's SVG renderer through a temporary HTML wrapper and
keeps all derived files in the poster logo asset tree.
"""

from __future__ import annotations

import os
import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LOGO_DIR = ROOT / "assets" / "logos"
DERIVED_DIR = LOGO_DIR / "derived"
TMP_DIR = Path("/tmp/isba_logo_firefox_render")

SPECS = [
    ("ecmwf_logo.svg", "ecmwf_logo_2400w.png", 2400, 489),
    ("noaa_logo.svg", "noaa_logo_1800px.png", 1800, 1800),
    ("nws_logo.svg", "nws_logo_1800px.png", 1800, 1800),
    ("ucsc_uc_seal.svg", "ucsc_uc_seal_1800px.png", 1800, 1800),
]


def write_wrapper(svg_path: Path, html_path: Path, width: int, height: int) -> None:
    html_path.write_text(
        "\n".join(
            [
                "<!doctype html>",
                "<html>",
                "<head>",
                '<meta charset="utf-8">',
                "<style>",
                (
                    "html,body{margin:0;padding:0;background:white;"
                    f"width:{width}px;height:{height}px;overflow:hidden}}"
                ),
                (
                    "img{display:block;"
                    f"width:{width}px;height:{height}px;object-fit:contain}}"
                ),
                "</style>",
                "</head>",
                f'<body><img src="{svg_path.as_uri()}"></body>',
                "</html>",
                "",
            ]
        ),
        encoding="utf-8",
    )


def render_one(svg_name: str, out_name: str, width: int, height: int) -> None:
    svg_path = LOGO_DIR / svg_name
    out_path = DERIVED_DIR / out_name
    html_path = TMP_DIR / f"{Path(svg_name).stem}.html"

    if not svg_path.exists():
        raise FileNotFoundError(svg_path)

    write_wrapper(svg_path, html_path, width, height)

    env = os.environ.copy()
    env["HOME"] = str(TMP_DIR / "firefox-home")
    env["XDG_RUNTIME_DIR"] = str(TMP_DIR / "firefox-runtime")
    Path(env["HOME"]).mkdir(parents=True, exist_ok=True)
    Path(env["XDG_RUNTIME_DIR"]).mkdir(parents=True, exist_ok=True)
    Path(env["XDG_RUNTIME_DIR"]).chmod(0o700)

    cmd = [
        "timeout",
        "20s",
        "firefox",
        "--headless",
        "--screenshot",
        str(out_path),
        "--window-size",
        f"{width},{height}",
        html_path.as_uri(),
    ]

    completed = subprocess.run(cmd, env=env, check=False)
    if not out_path.exists() or out_path.stat().st_size == 0:
        raise RuntimeError(
            f"Firefox did not produce {out_path}; exit code {completed.returncode}"
        )


def main() -> None:
    DERIVED_DIR.mkdir(parents=True, exist_ok=True)
    TMP_DIR.mkdir(parents=True, exist_ok=True)

    for spec in SPECS:
        render_one(*spec)


if __name__ == "__main__":
    main()
