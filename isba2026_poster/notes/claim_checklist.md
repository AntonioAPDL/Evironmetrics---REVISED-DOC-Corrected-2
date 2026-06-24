# ISBA 2026 Poster Claim Checklist

Use this checklist before sharing or uploading the poster PDF.

Verification pass: 2026-06-23. Checked against the unified `poster.tex`,
tracked `poster.pdf`, `scripts/build_poster_figures.R`, and the refreshed HE2
article generated tables/representative synthesis artifact. `poster.tex` remains the
only Overleaf-facing poster source.

Viewer-first polish pass: 2026-06-21. Wording, model definitions,
interpretation bullets, and generated plot labels were tightened without
changing the frozen scientific lock below.

## Required claims

- [x] The title remains factual and method/application aligned:
  `Bayesian quantile-based correction and synthesis of climate products`.
- [x] The main CRPS evidence states the scoped result: selected exDQLM has the
  lowest mean 28-day CRPS at all five rolling origins under the refreshed HE2
  publication authority.
- [x] CRPS is expanded as continuous ranked probability score before the main
  evidence panel is interpreted.
- [x] The 8-day NWS comparison is labelled as a horizon-matched comparison.
- [x] The 2022-12-25 synthesis panel is labelled illustrative.
- [x] The 80-month component panel is labelled as a retrospective diagnostic,
  not additional forecast validation.
- [x] The active discount/epsilon screen is excluded from poster evidence.

## Prohibited wording

- [x] No unqualified "best model" claim.
- [x] No unsupported generic "best model" claim beyond the stated five-origin
  28-day CRPS authority.
- [x] No active-screen CRPS value.
- [x] No causal wording for forecast covariates.
- [x] No claim that the five origins are a dense continuous hindcast.
- [x] No internal instruction such as "use all five origins for final claims."
- [x] No unqualified "calibrated predictive quantiles" claim without a
  dedicated calibration diagnostic.

## Provenance checks

- [x] `scripts/build_poster_figures.R` regenerates the poster figures.
- [x] Derived CSVs match refreshed generated table values.
- [x] Main CRPS figure comes from `benchmark_crps_main_table.tex`.
- [x] NWS figure comes from `benchmark_crps_nws_horizon_table.tex`.
- [x] Representative synthesis uses the frozen article figure for 2022-12-25.
- [x] The poster-specific 80-month component figure records its source in
  `data/derived/component_80month_poster_provenance.csv`.

Build commands / validation verified locally:

```bash
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster isba2026_poster/poster.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster isba2026_poster/poster.tex
pdfinfo isba2026_poster/poster.pdf
pdftoppm -png -r 110 isba2026_poster/poster.pdf /tmp/isba_poster_page
```

The canonical full figure regeneration path remains:

```bash
Rscript isba2026_poster/scripts/build_poster_figures.R
```

For the 2026-06-23 pass, the refreshed poster-generated figures were
regenerated after source edits, then the one-page A0 PDF was rebuilt and
visually checked.
