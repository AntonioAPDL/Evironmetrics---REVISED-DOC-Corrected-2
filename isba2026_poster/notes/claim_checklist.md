# ISBA 2026 Poster Claim Checklist

Use this checklist before sharing or uploading the poster PDF.

Verification pass: 2026-06-20. Checked against the unified `poster.tex`,
`scripts/build_poster_figures.R`, and the frozen article generated
tables/representative synthesis artifact. `poster.tex` is the only
Overleaf-facing poster source.

Viewer-first polish pass: 2026-06-20. Wording, model definitions, interpretation
bullets, and generated plot labels were tightened without changing the frozen
scientific lock below.

## Required claims

- [x] The title remains factual and method/application aligned.
- [x] The main result states "four of five" and names the 2022-12-25 exception.
- [x] The 8-day NWS comparison is labelled as a horizon-matched comparison.
- [x] The 2022-12-25 synthesis panel is labelled illustrative.
- [x] The active discount/epsilon screen is excluded from poster evidence.

## Prohibited wording

- [x] No unqualified "best model" claim.
- [x] No claim that exAL-M-T1 wins every cutoff.
- [x] No active-screen CRPS value.
- [x] No causal wording for forecast covariates.
- [x] No claim that the five origins are a dense continuous hindcast.

## Provenance checks

- [x] `scripts/build_poster_figures.R` regenerates the poster figures.
- [x] Derived CSVs match frozen generated table values.
- [x] Main CRPS figure comes from `benchmark_crps_main_table.tex`.
- [x] NWS figure comes from `benchmark_crps_nws_horizon_table.tex`.
- [x] Representative synthesis uses the frozen article figure for 2022-12-25.

Build commands verified locally:

```bash
Rscript isba2026_poster/scripts/build_poster_figures.R
make -f isba2026_poster/Makefile poster
make -f isba2026_poster/Makefile clean
```
