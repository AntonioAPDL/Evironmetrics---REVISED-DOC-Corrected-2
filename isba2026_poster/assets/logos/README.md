# Poster Logo Assets

Uploaded from the local `Poster_Logos` folder on 2026-06-20 and normalized for
stable poster references.

## Files

- `ecmwf_logo.svg`: ECMWF vector logo source.
- `glofas_logo.png`: GloFAS raster logo, 317 x 202 px, transparent PNG.
- `noaa_logo.svg`: NOAA vector logo source.
- `noaa_logo.png`: NOAA raster fallback, 100 x 100 px, transparent PNG.
- `nws_logo.svg`: National Weather Service vector logo source.
- `ucsc_uc_seal.svg`: UC/UCSC seal-style vector source.

## Derived pdfLaTeX-Ready Files

The server could not reach PyPI or system package repositories during the
2026-06-20 conversion pass, so Inkscape/CairoSVG could not be installed here.
As a controlled fallback, the existing server Firefox renderer was used through
`isba2026_poster/scripts/render_logo_pngs_with_firefox.py` to create
high-resolution PNG derivatives:

- `derived/ecmwf_logo_2400w.png`: 2400 x 489 px.
- `derived/noaa_logo_1800px.png`: 1800 x 1800 px.
- `derived/nws_logo_1800px.png`: 1800 x 1800 px.
- `derived/ucsc_uc_seal_1800px.png`: 1800 x 1800 px.

These PNGs are safe for pdfLaTeX and suitable for a compact poster logo strip.
They are not a replacement for vector PDF masters if an Inkscape/CairoSVG
conversion path becomes available later.

## Poster Use

The main poster is verified with pdfLaTeX. Raw SVG files should be converted to
PDF or high-resolution transparent PNG before being included directly in
`poster.tex`, unless the build path is intentionally changed and re-verified.

Use these logos as source/data/affiliation cues only. Avoid language or placement
that implies endorsement by NOAA, NWS, ECMWF, GloFAS, USGS, or UCSC.

## Current Gap

USGS is not present in this upload. If a USGS mark is needed in the final logo
strip, add an official vector or high-resolution transparent PNG here before the
poster integration pass.
