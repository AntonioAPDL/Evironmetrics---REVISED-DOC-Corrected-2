# exAL-M-T1 Relaunch Checklist

Date: 2026-05-06

Status note added: 2026-05-16

This document still describes the **current article-side publication-state provenance**.

The planned next rerun under the shared `exAL-M-T1` relaunch spec is tracked separately in:
- `docs/exal_m_t1_shared_rerun_checklist.md`

## Purpose

This manuscript-side checklist records the **current publication-aligned** `exAL-M-T1` relaunch target for `Evironmetrics---REVISED-DOC-Corrected`.

It replaces the older pre-publication source-run audit that had become misleading after the corrected HE2 publication freeze.

Primary workflow-side execution note:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/reports/publication_replay/EXAL_M_T1_FIVE_RUN_RELAUNCH_PLAN.md`

Primary publication source of truth:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/reports/he2_publication_manifest/he2_bayesian_publication_manifest.md`

Planned next-state shared rerun plan:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/HE2_EXDQLM_MULTIVAR_KEEP_SHARED_RELAUNCH_PLAN_20260516.md`

## Locked five-run source map

These are the `exAL-M-T1` runs tied to the **current** CRPS values in the manuscript-facing HE2 table.

| Cutoff | Published CRPS | Run ID | Campaign |
|---|---:|---|---|
| `01/23/2021` | `0.1569` | `multimodel_20210123_v8_eps360cf1_exdqlm_multivar_keep_featurecov_cf1` | `multimodel_v8_featurecov_cf1_eps_sweep_20260416` |
| `11/12/2021` | `0.0284` | `multimodel_20211112_v8_eps180cf1_exdqlm_multivar_keep_featurecov_cf1` | `multimodel_v8_featurecov_cf1_eps_sweep_20260416` |
| `12/21/2021` | `0.2369` | `multimodel_20211221_v8_eps1cf1_exdqlm_multivar_keep_featurecov_cf1` | `multimodel_v8_featurecov_cf1_eps_sweep_20260416` |
| `05/11/2022` | `0.0210` | `multimodel_20220511_v8_eps180cf1_exdqlm_multivar_keep_featurecov_cf1` | `multimodel_v8_featurecov_cf1_eps_sweep_20260416` |
| `12/25/2022` | `0.4375` | `multimodel_20221225_v8_exalm_t1_discount_grid_exact_v1_set09_exdqlm_multivar_keep` | `multimodel_v8_exalm_t1_discount_grid_exact_20260424` |

## Locked manuscript provenance roles

### Section 4
- five-cutoff CRPS table remains the main forecast-validation evidence

### Section 5
- representative final cutoff is locked to `2022-12-25`
- this is the cutoff to use for the selected-model illustrative outputs

### Appendix / historical-summary objects
- these should not block the five-run relaunch
- revisit them only after the representative Section 5 outputs are refreshed cleanly

## Phase A outputs needed for the revised article

These are the first outputs the relaunch must support.

| Manuscript object | Required output(s) |
|---|---|
| `fig:synth1` | `exdqlm_multivar_synth_keep_cutoff_window_posterior_samples.(png,pdf)`, `..._with_raw_ensembles.(png,pdf)`, `..._quantiles.csv`, `..._sample_subset.csv` |
| `tab:components_23_31` | `covariate_effects_summary.(csv,tex,rds)` |
| `fig:synth2` if retained | `exdqlm_multivar_synth_drop_cutoff_window_posterior_samples.(png,pdf)`, `..._with_raw_ensembles.(png,pdf)`, `..._quantiles.csv`, `..._sample_subset.csv` |

## Phase B outputs that should not block the relaunch

| Manuscript object | Current role |
|---|---|
| `fig:dry_quantile` | historical regime illustration |
| `fig:rainy_quantile` | historical regime illustration |
| `fig:80_components` | appendix historical summary |
| `tab:gamma_sigma_intervals1` | appendix `gamma` summary |
| `tab:gamma_sigma_intervals2` | appendix `sigma` summary |

## Current audit findings

1. The original publication-aligned source runs already wrote the synthesis figures successfully.
2. The missing posterior-table export path has now been restored on the replay side.
3. The exact-snapshot deterministic-climate validation issue for the `12/25/2022` override run has now been fixed.
4. The two exAL-M-T1 canaries now pass end to end under the authoritative replay path:
   - `01/23/2021` cf1 keep
   - `12/25/2022` exact `set09` keep
5. The same verified path has now completed for all five publication-aligned `exAL-M-T1` cutoffs.

## Current execution status

| Cutoff | Status | Mean CRPS from rerun | Notes |
|---|---|---:|---|
| `01/23/2021` | `PASS` | `0.15685973014263893` | matches the published `0.1569` row to rounding |
| `11/12/2021` | `PASS` | `0.02838779803717152` | matches the published `0.0284` row to rounding |
| `12/21/2021` | `PASS` | `0.23693814285226766` | matches the published `0.2369` row to rounding |
| `05/11/2022` | `PASS` | `0.020965785429243058` | matches the published `0.0210` row to rounding |
| `12/25/2022` | `PASS` | `0.43752505703872074` | matches the published `0.4375` row to rounding |

## Recommended execution order

1. Verify for all five runs:
   - mean CRPS matches the current HE2 table to rounding
   - synthesis figures are present
   - posterior tables are present
2. Use only those five verified run roots to refresh:
   - `fig:synth1`
   - `tab:components_23_31`
   - `fig:synth2` if retained
3. Revisit Phase B historical-summary objects only after the Phase A refresh is complete.

## Companion workflow note

For the detailed workflow-side relaunch plan, including the post-fix rationale and canary acceptance contract, use:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/reports/publication_replay/EXAL_M_T1_FIVE_RUN_RELAUNCH_PLAN.md`
