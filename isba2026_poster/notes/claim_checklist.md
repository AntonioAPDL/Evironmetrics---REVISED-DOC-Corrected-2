# ISBA 2026 Poster Claim Checklist

Use this checklist before sharing or uploading the poster PDF.

## Required claims

- [ ] The title remains factual and method/application aligned.
- [ ] The main result states "four of five" and names the 2022-12-25 exception.
- [ ] The 8-day NWS comparison is labelled as a horizon-matched comparison.
- [ ] The 2022-12-25 synthesis panel is labelled illustrative.
- [ ] The active discount/epsilon screen is excluded from poster evidence.

## Prohibited wording

- [ ] No unqualified "best model" claim.
- [ ] No claim that exAL-M-T1 wins every cutoff.
- [ ] No active-screen CRPS value.
- [ ] No causal wording for forecast covariates.
- [ ] No claim that the five origins are a dense continuous hindcast.

## Provenance checks

- [ ] `scripts/build_poster_figures.R` regenerates the poster figures.
- [ ] Derived CSVs match frozen generated table values.
- [ ] Main CRPS figure comes from `benchmark_crps_main_table.tex`.
- [ ] NWS figure comes from `benchmark_crps_nws_horizon_table.tex`.
- [ ] Representative synthesis uses the frozen article figure for 2022-12-25.

