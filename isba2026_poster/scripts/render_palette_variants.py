#!/usr/bin/env python3
"""Render poster palette previews without changing the canonical poster.

The script swaps only the color system in ``poster.tex`` and regenerates the
poster-specific figures with matching semantic colors. Outputs are written under
``isba2026_poster/palette_previews/`` so they can be compared and discarded.
"""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import textwrap
from dataclasses import dataclass
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


COLOR_BLOCK_RE = re.compile(
    r"% ---------- Refined semantic palette.*?(?=\\hypersetup\{)",
    flags=re.DOTALL,
)


@dataclass(frozen=True)
class Palette:
    slug: str
    label: str
    note: str
    colors: dict[str, str]


BASE_COLORS = {
    "white": "FFFFFF",
    "other": "8A9399",
}


PALETTES: dict[str, Palette] = {
    "current": Palette(
        "current",
        "Current Authoritative",
        "Canonical Sumi Minimal baseline: quiet editorial neutrals with separated source colors.",
        {
            "paper": "FCFCFA",
            "white": "FFFFFF",
            "ink": "1E252B",
            "title": "1F3442",
            "muted": "616B73",
            "rule": "D8DCDE",
            "panel": "F3F4F3",
            "lavender": "EEF2F4",
            "selected": "5C4B86",
            "structure": "3A7180",
            "glofas": "356C9C",
            "nws": "B9553A",
            "comparator": "9D7A29",
            "usgs": "181D21",
            "covariate": "657765",
            "sky": "708EAA",
            "climate": "827184",
            "other": "8A9399",
        },
    ),
    "indigo_persimmon": Palette(
        "indigo_persimmon",
        "Indigo and Persimmon",
        "Recommended distinctive palette: warm paper, indigo/slate text, blue GloFAS, persimmon NWS.",
        {
            "paper": "FCFAF3",
            "white": "FFFFFF",
            "ink": "282A30",
            "title": "24324B",
            "muted": "5F6670",
            "rule": "D9D4C8",
            "panel": "F2EFE7",
            "lavender": "EEF1F5",
            "selected": "5C4F82",
            "structure": "337986",
            "glofas": "356F9C",
            "nws": "C15B3A",
            "comparator": "A97B28",
            "usgs": "222629",
            "covariate": "63775F",
            "sky": "6A90B2",
            "climate": "846C82",
            "other": "8A9399",
        },
    ),
    "estuary_editorial": Palette(
        "estuary_editorial",
        "Estuary Editorial",
        "Lowest-risk refinement: close to current, but separates GloFAS blue and NWS rust.",
        {
            "paper": "FAF9F5",
            "white": "FFFFFF",
            "ink": "222B32",
            "title": "213845",
            "muted": "5C6870",
            "rule": "D4D9D7",
            "panel": "F0F3F1",
            "lavender": "EEF2F4",
            "selected": "67588A",
            "structure": "2E7883",
            "glofas": "3677A5",
            "nws": "C25D3D",
            "comparator": "A9822B",
            "usgs": "1F252A",
            "covariate": "688269",
            "sky": "6B8FAB",
            "climate": "826D82",
            "other": "8A9399",
        },
    ),
    "tol_muted": Palette(
        "tol_muted",
        "Tol Muted Scientific",
        "Accessibility-first scientific palette with strong categorical separability.",
        {
            "paper": "FAF9F6",
            "white": "FFFFFF",
            "ink": "242A30",
            "title": "283449",
            "muted": "626A72",
            "rule": "D6D8D6",
            "panel": "F1F2EF",
            "lavender": "EEF3F5",
            "selected": "332288",
            "structure": "44AA99",
            "glofas": "4477AA",
            "nws": "CC6677",
            "comparator": "999933",
            "usgs": "222222",
            "covariate": "117733",
            "sky": "88CCEE",
            "climate": "AA4499",
            "other": "888888",
        },
    ),
    "cud_signal": Palette(
        "cud_signal",
        "CUD Signal",
        "High-attention, color-universal-design inspired palette with vivid but controlled accents.",
        {
            "paper": "FAFAF7",
            "white": "FFFFFF",
            "ink": "20252B",
            "title": "263B4D",
            "muted": "5E6871",
            "rule": "D6D9DA",
            "panel": "F1F3F3",
            "lavender": "F3EFF5",
            "selected": "9B4F7F",
            "structure": "007A5E",
            "glofas": "0072B2",
            "nws": "D55E00",
            "comparator": "E69F00",
            "usgs": "000000",
            "covariate": "3C8DAD",
            "sky": "56B4E9",
            "climate": "CC79A7",
            "other": "8A9399",
        },
    ),
    "sea_glass_coral": Palette(
        "sea_glass_coral",
        "Sea Glass and Coral",
        "Fresh and contemporary: violet selected model, sea-glass accent, blue GloFAS, coral NWS.",
        {
            "paper": "FBFCF9",
            "white": "FFFFFF",
            "ink": "263238",
            "title": "214049",
            "muted": "607077",
            "rule": "D4DFDC",
            "panel": "EDF4F1",
            "lavender": "F2EFF6",
            "selected": "755BA1",
            "structure": "247E78",
            "glofas": "3679A7",
            "nws": "D66B57",
            "comparator": "B88A2D",
            "usgs": "20272C",
            "covariate": "63836A",
            "sky": "6E9BC0",
            "climate": "8B6F91",
            "other": "8A9399",
        },
    ),
    "sumi_minimal": Palette(
        "sumi_minimal",
        "Sumi Minimal",
        "Quiet, rigorous, premium editorial feel with low print risk.",
        {
            "paper": "FCFCFA",
            "white": "FFFFFF",
            "ink": "1E252B",
            "title": "1F3442",
            "muted": "616B73",
            "rule": "D8DCDE",
            "panel": "F3F4F3",
            "lavender": "EEF2F4",
            "selected": "5C4B86",
            "structure": "3A7180",
            "glofas": "356C9C",
            "nws": "B9553A",
            "comparator": "9D7A29",
            "usgs": "181D21",
            "covariate": "657765",
            "sky": "708EAA",
            "climate": "827184",
            "other": "8A9399",
        },
    ),
}


DEFAULT_PALETTES = ["current", "indigo_persimmon", "estuary_editorial", "cud_signal"]
ALL_PALETTES = [
    "current",
    "indigo_persimmon",
    "estuary_editorial",
    "tol_muted",
    "cud_signal",
    "sea_glass_coral",
    "sumi_minimal",
]


def repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def poster_dir() -> Path:
    return Path(__file__).resolve().parents[1]


def run(cmd: list[str], *, cwd: Path, env: dict[str, str] | None = None, log: Path | None = None) -> None:
    merged_env = os.environ.copy()
    if env:
        merged_env.update(env)
    proc = subprocess.run(
        cmd,
        cwd=cwd,
        env=merged_env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )
    if log:
        log.write_text(proc.stdout, encoding="utf-8")
    if proc.returncode != 0:
        if log:
            raise RuntimeError(f"Command failed ({proc.returncode}); see {log}")
        raise RuntimeError(f"Command failed ({proc.returncode}): {' '.join(cmd)}\n{proc.stdout}")


def palette_block(palette: Palette) -> str:
    c = palette.colors
    return textwrap.dedent(
        f"""\
        % ---------- Semantic palette preview: {palette.label} ----------------------------
        % Generated by isba2026_poster/scripts/render_palette_variants.py.
        % {palette.note}
        %
        % Neutral document system
        \\definecolor{{PosterPaper}}{{HTML}}{{{c["paper"]}}}
        \\definecolor{{PosterWhite}}{{HTML}}{{{c["white"]}}}
        \\definecolor{{PosterInk}}{{HTML}}{{{c["ink"]}}}
        \\definecolor{{TitleSlate}}{{HTML}}{{{c["title"]}}}
        \\definecolor{{MutedSlate}}{{HTML}}{{{c["muted"]}}}
        \\definecolor{{RuleStone}}{{HTML}}{{{c["rule"]}}}
        \\definecolor{{PanelStone}}{{HTML}}{{{c["panel"]}}}
        \\definecolor{{PanelLavender}}{{HTML}}{{{c["lavender"]}}}

        % Scientific semantic roles
        \\definecolor{{SelectedModelColor}}{{HTML}}{{{c["selected"]}}}
        \\definecolor{{StructureColor}}{{HTML}}{{{c["structure"]}}}
        \\definecolor{{GloFASColor}}{{HTML}}{{{c["glofas"]}}}
        \\definecolor{{NWSColor}}{{HTML}}{{{c["nws"]}}}
        \\definecolor{{ComparatorColor}}{{HTML}}{{{c["comparator"]}}}
        \\definecolor{{USGSColor}}{{HTML}}{{{c["usgs"]}}}
        \\definecolor{{CovariateColor}}{{HTML}}{{{c["covariate"]}}}
        \\definecolor{{CovariateSkyColor}}{{HTML}}{{{c["sky"]}}}
        \\definecolor{{ClimateIndexColor}}{{HTML}}{{{c["climate"]}}}

        % Compatibility aliases for the current poster source
        \\colorlet{{ModelPlum}}{{SelectedModelColor}}
        \\colorlet{{HydroBlue}}{{StructureColor}}
        \\colorlet{{GloFASOrange}}{{GloFASColor}}
        \\colorlet{{NWSPurple}}{{NWSColor}}
        \\colorlet{{ALOchre}}{{ComparatorColor}}
        \\colorlet{{USGSInk}}{{USGSColor}}
        \\colorlet{{CovariateSage}}{{CovariateColor}}
        \\colorlet{{CovariateSky}}{{CovariateSkyColor}}
        \\colorlet{{ClimateMauve}}{{ClimateIndexColor}}

        """
    )


def rewrite_tex(source: str, palette: Palette, variant_dir: Path) -> str:
    replaced, count = COLOR_BLOCK_RE.subn(lambda _match: palette_block(palette), source)
    if count != 1:
        raise RuntimeError(f"Expected one palette block, replaced {count}")
    variant_graphics = f"  {{palette_previews/{variant_dir.name}/figures/generated/}}\n"
    replaced = replaced.replace("\\graphicspath{\n", "\\graphicspath{\n" + variant_graphics, 1)
    return replaced


def r_env(palette: Palette, variant_dir: Path) -> dict[str, str]:
    c = palette.colors
    mapping = {
        "PAPER": c["paper"],
        "WHITE": c["white"],
        "INK": c["ink"],
        "TITLE": c["title"],
        "MUTED": c["muted"],
        "RULE": c["rule"],
        "PANEL": c["panel"],
        "LAVENDER": c["lavender"],
        "PLUM": c["selected"],
        "HYDRO": c["structure"],
        "GLOFAS": c["glofas"],
        "NWS": c["nws"],
        "OCHRE": c["comparator"],
        "USGS": c["usgs"],
        "SAGE": c["covariate"],
        "SKY": c["sky"],
        "MAUVE": c["climate"],
        "OTHER": c.get("other", BASE_COLORS["other"]),
    }
    env = {f"POSTER_COL_{key}": f"#{value}" for key, value in mapping.items()}
    env["POSTER_FIG_DIR"] = str(variant_dir / "figures" / "generated")
    env["POSTER_DATA_DIR"] = str(variant_dir / "data" / "derived")
    return env


def render_one(palette: Palette, out_root: Path, tex_source: str, *, skip_figures: bool) -> dict[str, Path]:
    pdir = out_root / palette.slug
    pdir.mkdir(parents=True, exist_ok=True)
    (pdir / "figures" / "generated").mkdir(parents=True, exist_ok=True)
    (pdir / "data" / "derived").mkdir(parents=True, exist_ok=True)

    tex_path = pdir / f"poster_{palette.slug}.tex"
    tex_path.write_text(rewrite_tex(tex_source, palette, pdir), encoding="utf-8")

    if not skip_figures:
        run(
            ["Rscript", "--vanilla", str(poster_dir() / "scripts" / "build_poster_figures.R")],
            cwd=repo_root(),
            env=r_env(palette, pdir),
            log=pdir / "build_figures.log",
        )

    for pass_no in (1, 2):
        run(
            [
                "pdflatex",
                "-interaction=nonstopmode",
                "-halt-on-error",
                f"-output-directory={pdir}",
                str(tex_path),
            ],
            cwd=poster_dir(),
            log=pdir / f"pdflatex_pass{pass_no}.log",
        )

    pdf_path = pdir / f"poster_{palette.slug}.pdf"
    run(
        [
            "pdftoppm",
            "-png",
            "-r",
            "90",
            "-singlefile",
            str(pdf_path),
            str(pdir / "poster_preview"),
        ],
        cwd=repo_root(),
        log=pdir / "pdftoppm_preview.log",
    )
    run(
        [
            "pdfinfo",
            str(pdf_path),
        ],
        cwd=repo_root(),
        log=pdir / "pdfinfo.txt",
    )
    return {
        "dir": pdir,
        "tex": tex_path,
        "pdf": pdf_path,
        "preview": pdir / "poster_preview.png",
    }


def load_font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    candidates = [
        "/usr/share/fonts/dejavu/DejaVuSans-Bold.ttf" if bold else "/usr/share/fonts/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/liberation/LiberationSans-Bold.ttf" if bold else "/usr/share/fonts/liberation/LiberationSans-Regular.ttf",
    ]
    for candidate in candidates:
        if candidate and Path(candidate).exists():
            return ImageFont.truetype(candidate, size=size)
    return ImageFont.load_default()


def make_contact_sheet(results: list[dict[str, Path]], palettes: list[Palette], out_root: Path) -> Path:
    thumb_w = 760
    label_h = 116
    gap = 28
    margin = 34
    columns = 2
    rows = (len(results) + columns - 1) // columns
    thumb_h = int(thumb_w * 118.9 / 84.1)
    swatch_h = 18

    canvas_w = margin * 2 + columns * thumb_w + (columns - 1) * gap
    canvas_h = margin * 2 + rows * (label_h + thumb_h + swatch_h + 24) + (rows - 1) * gap
    sheet = Image.new("RGB", (canvas_w, canvas_h), "#F7F7F3")
    draw = ImageDraw.Draw(sheet)
    title_font = load_font(28, bold=True)
    small_font = load_font(19, bold=False)

    for idx, (result, palette) in enumerate(zip(results, palettes)):
        row = idx // columns
        col = idx % columns
        x = margin + col * (thumb_w + gap)
        y = margin + row * (label_h + thumb_h + swatch_h + 24 + gap)

        draw.text((x, y), palette.label, fill="#24324B", font=title_font)
        for line_no, note_line in enumerate(textwrap.wrap(palette.note, width=78)[:3]):
            draw.text((x, y + 36 + line_no * 22), note_line, fill="#5F6670", font=small_font)

        swatches = [
            palette.colors["selected"],
            palette.colors["structure"],
            palette.colors["glofas"],
            palette.colors["nws"],
            palette.colors["comparator"],
            palette.colors["covariate"],
        ]
        swatch_w = thumb_w // len(swatches)
        for sw_idx, hex_color in enumerate(swatches):
            draw.rectangle(
                [x + sw_idx * swatch_w, y + label_h - swatch_h, x + (sw_idx + 1) * swatch_w - 2, y + label_h - 2],
                fill="#" + hex_color,
            )

        preview = Image.open(result["preview"]).convert("RGB")
        preview.thumbnail((thumb_w, thumb_h), Image.Resampling.LANCZOS)
        px = x + (thumb_w - preview.width) // 2
        py = y + label_h
        sheet.paste(preview, (px, py))
        draw.rectangle([px, py, px + preview.width, py + preview.height], outline="#D3D6D4", width=2)

    out_path = out_root / "palette_contact_sheet.png"
    sheet.save(out_path, optimize=True)

    gray = sheet.convert("L").convert("RGB")
    gray.save(out_root / "palette_contact_sheet_grayscale.png", optimize=True)
    return out_path


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--palette",
        action="append",
        choices=sorted(PALETTES),
        help="Palette slug to render. Can be repeated. Defaults to the report shortlist plus current.",
    )
    parser.add_argument(
        "--all",
        action="store_true",
        help="Render all palette-only candidates except Night River.",
    )
    parser.add_argument(
        "--skip-figures",
        action="store_true",
        help="Do not regenerate poster-specific figures; useful for quick LaTeX-only checks.",
    )
    parser.add_argument(
        "--output-root",
        type=Path,
        default=poster_dir() / "palette_previews",
        help="Directory for generated preview outputs.",
    )
    parser.add_argument(
        "--contact-sheet-only",
        action="store_true",
        help="Reuse existing poster_preview.png files and rebuild only the contact sheets.",
    )
    args = parser.parse_args()

    slugs = ALL_PALETTES if args.all else (args.palette or DEFAULT_PALETTES)
    palettes = [PALETTES[slug] for slug in slugs]

    tex_source = (poster_dir() / "poster.tex").read_text(encoding="utf-8")
    args.output_root.mkdir(parents=True, exist_ok=True)

    print(f"Rendering {len(palettes)} palette preview(s) into {args.output_root}")
    results = []
    if args.contact_sheet_only:
        for palette in palettes:
            pdir = args.output_root / palette.slug
            preview = pdir / "poster_preview.png"
            if not preview.exists():
                raise FileNotFoundError(f"Missing preview for {palette.slug}: {preview}")
            results.append(
                {
                    "dir": pdir,
                    "tex": pdir / f"poster_{palette.slug}.tex",
                    "pdf": pdir / f"poster_{palette.slug}.pdf",
                    "preview": preview,
                }
            )
    else:
        for palette in palettes:
            print(f"  - {palette.label} ({palette.slug})")
            results.append(render_one(palette, args.output_root, tex_source, skip_figures=args.skip_figures))

    contact_sheet = make_contact_sheet(results, palettes, args.output_root)
    print(f"\nContact sheet: {contact_sheet}")
    for palette, result in zip(palettes, results):
        print(f"{palette.slug}: {result['pdf']}")


if __name__ == "__main__":
    main()
