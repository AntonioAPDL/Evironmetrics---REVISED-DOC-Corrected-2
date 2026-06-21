# Pro Design Audit Response, 2026-06-20

This note records the follow-up passes based on external design audits of the
ISBA 2026 poster source. The current canonical source is the simplified
Pro-style `poster.tex` pulled from `origin/main` at commit `916f320`, followed by
local integration edits that keep the source compatible with the project figures
and claim-governance rules.

The current goal is to reduce repetition, quiet the visual system, and align the
generated figures with the new poster palette without changing the scientific
lock.

## Adopted

- Changed the title to sentence case:
  `Dynamic Bayesian quantile synthesis for medium-range river-flow forecasting`.
- Made the header metadata unboxed and right-aligned.
- Kept a rapid-reading result band with the exact four-of-five claim and the
  2022-12-25 exception.
- Replaced the earlier source-logo ribbon and card grid with one compact
  source legend in the left column.
- Removed the full-width takeaway band and retained one quieter footer.
- Used a wider center evidence column so the 28-day CRPS panel remains the
  primary visual object.
- Adopted a warmer slate/plum/hydrologic-blue/rust/ochre palette.
- Recolored regenerated poster figures to match the new semantic palette.
- Used marker shape as well as color for the selected model, AL comparator, and
  raw source references in the score figures.
- Shortened repeated caveats and replaced defensive wording with positive scope
  language.
- Kept the footer source-logo row restrained: USGS, ECMWF, GloFAS, NWS, UCSC
  text, contact, and repository access.
- Removed visible active-screening, manifest, and frozen-manuscript management
  language from the conference-facing poster surface.

## Deferred

- Did not add a compact model equation. The audit correctly notes that a
  statistical audience may appreciate it, but it should only be added after the
  exact manuscript notation is verified against the revised article source.
- Did not promote any active screening result. The current poster remains tied
  to the authoritative article-facing outputs.
- Did not reintroduce both NOAA and NWS circular marks in the footer. The source
  legend names NOAA/NWS, while the footer uses the more direct NWS product cue
  to avoid logo clutter.

## Verification Standard

Before committing this pass, rebuild the poster with pdfLaTeX, confirm it is one
A0 portrait page, scan the rendered text for prohibited claims or internal
workflow-management language, and inspect the rendered preview for logo
visibility, figure palette consistency, legend clarity, and layout balance.
