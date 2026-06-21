# Unified Poster Audit, 2026-06-20

This note records the comparison pass used to make `poster.tex` the single
Overleaf-facing ISBA 2026 poster source.

## Inputs Compared

- `poster.tex` before this pass: compact, conservative, claim-disciplined.
- Historical high-aesthetic source: stronger hierarchy, more polished
  sectioning, better visual rhythm, and robust pdfLaTeX package fallbacks. Its
  selected improvements were promoted into the canonical `poster.tex`, and the
  alternate `.tex` source was removed.

No newer third poster source was visible on `origin/main` at the time of this
audit. The GitHub remote head was `65ef6fd` before edits.

## Standard Source Assessment

Strengths:

- Clear claim governance: four-of-five result, explicit 2022-12-25 exception,
  NWS horizon nuance, and active-screen exclusion.
- Compact code and simpler layout.
- Strong reproducibility language.

Issues:

- Visual hierarchy was flatter than ideal for a conference poster.
- Dense card grid made the poster feel more like a report page than an
  exhibition surface.
- The lower portion of the page was underused in the rendered preview.

## High-Aesthetic Source Assessment

Strengths:

- Better first-glance structure: large title, top result band, numbered
  sections, and a central evidence panel.
- Stronger visual grouping around the 28-day CRPS result.
- Better poster-scale rhythm, with clear left/middle/right reading paths.
- Robust font and QR fallbacks for local and Overleaf pdfLaTeX builds.

Issues Corrected In Unified Source:

- Replaced broad "dominance" wording with a more precise strong-reference claim.
- Restored explicit visible exclusion of active discount/epsilon screening
  evidence.
- Updated provenance text so the frozen-artifact boundary is visible in the
  poster itself.
- Promoted the high-aesthetic structure into `poster.tex` so Overleaf has one
  primary main file.

## Unified Decision

Use the high-aesthetic structure as the main poster, but preserve the standard
source's claim discipline and provenance constraints. The unified `poster.tex`
is the only file that should be set as the Overleaf main file.

## Current Scientific Lock

- Use frozen manuscript-facing outputs dated 2026-06-19.
- State that exAL-M-T1 has the lowest 28-day CRPS at four of five rolling
  origins.
- State that AL-M-T1 is the 2022-12-25 exception.
- Treat the 2022-12-25 synthesis panel as illustrative, not aggregate evidence.
- Exclude active discount/epsilon screening results until a future replacement
  is formally promoted through the workflow, article, and response records.

## Verification Commands

```bash
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=/tmp/isba_audit_unified isba2026_poster/poster.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=/tmp/isba_audit_unified isba2026_poster/poster.tex
pdfinfo /tmp/isba_audit_unified/poster.pdf
```

Final local verification succeeded with pdfLaTeX. The rendered PDF is one A0
page, approximately 1.1 MB, and was previewed from
`/tmp/isba_audit_preview/unified_final-1.png`. The remaining LaTeX diagnostics
are underfull box warnings from narrow poster text columns and benign PDF
page-group warnings from included figure PDFs; no fatal or overfull warnings
remained after the QR fallback text was tightened.

## Remaining Review Items

- Human visual pass in Overleaf or from the compiled PDF at full-page and
  zoomed poster-reading scales.
- Possible micro-typography pass if the local pdfLaTeX underfull warnings are
  visually distracting.
- Final QR target once the archival/code landing page is chosen.
