# Reference Poster Audit: TA Wiki TLC Symposium

Reference repo: `AntonioAPDL/TAwiki_poster_TLC_symposium_Repo`

Access note: a shell `git clone` failed in this Codex session because `github.com`
could not be resolved. Repository files were inspected through the authenticated
GitHub connector instead.

Supersession note: the ideas below describe the reference-poster pass that led
to an intermediate ISBA poster. A later Pro-style simplification pass removed
the header seal and body source-logo ribbon in favor of a quieter metadata
header, compact source legend, and restrained footer logo row. The current
canonical source remains `isba2026_poster/poster.tex`.

## Files Reviewed

- `README.md`
- `poster.tex`
- `beamerthemegemini.sty`
- `beamercolorthemecam.sty`

## Useful Ideas Identified

- The Gemini-style poster uses a strong institutional identity zone with a
  conventional university logo anchor.
- Section blocks are visually separated by clear title rules, which improves
  scanning at poster distance.
- The footer keeps a persistent conference/contact/repository identity instead
  of treating provenance as an afterthought.
- Topic visuals are integrated directly with explanatory text rather than
  isolated as decorative material.

## Adopted In The ISBA Poster

- Strengthened the UCSC header identity by enlarging the seal and labeling it.
- Reworked the source logo ribbon so the problem statement shows the actual
  product pairs: USGS observations, ECMWF/GloFAS 28-day guidance, and
  NOAA/NWS 8-day guidance.
- Added NOAA to the footer product-logo strip so the source family is complete.
- Changed section dividers to a short teal accent rule followed by a neutral
  rule, borrowing the useful Gemini scanning affordance while preserving the
  custom ISBA design language.
- Expanded the body grid and scientific figure heights so the A0 sheet is used
  more fully, with the central CRPS evidence still carrying the main visual
  weight.

## Not Adopted

- The full Gemini theme was not imported because it is LuaLaTeX/fontspec based,
  while this poster is deliberately pdfLaTeX-compatible for Overleaf.
- The three-equal-column Gemini layout was not adopted because the ISBA poster
  needs a larger center evidence column for the CRPS result.
- Cambridge-specific colors and generic block styling were not adopted because
  the current hydrology palette already encodes model/product roles.
- TA Wiki subject matter and GitHub platform graphics were not reused because
  they are unrelated to the hydrologic forecasting presentation.
