# exAL-M-T1 Artifact-to-Run Map

Date: 2026-05-06

## Purpose

This file locks the reproducible `exAL-M-T1` source set used by the revised article and maps each manuscript object to its exact verified run/output source.

It is the execution companion to:
- `docs/exal_m_t1_relaunch_checklist.md`
- `docs/figure_table_provenance.md`
- `docs/exal_m_t1_shared_rerun_checklist.md`

Important transition note:
- the mappings below now point at the completed shared-spec `20260516` rerun where the article-side refresh has already been applied.
- the only remaining article-side exception is the historical-support bundle, which is still blocked on retained multivariate fit artifacts.

## Cleanup status

The article repo cleanup on 2026-05-09 removed stale manuscript-facing figure copies and legacy article-side support bundles that were no longer part of the current workflow contract.

Current canonical article-side figure/table families are:
- `artifacts/representative_selected_model_2022_12_25/`
- `artifacts/five_cutoff_crps_validation_sources/`
- `artifacts/historical_support_from_current_models/`
- `artifacts/five_cutoff_setup_support/`
- `figures/appendix_cutoff_panels/`
- `figures/forecast_context_by_cutoff/`
- `tables/generated_tex/`

Removed legacy article-side families:
- `artifacts/historical_summary_sources/`
- `artifacts/workflow_linked_support_sources/`
- `artifacts/setup_support_by_cutoff/`
- `artifacts/setup_support_by_cutoff_review/`

`figures/manuscript/` is now pruned automatically to the exact figure files named in `MANUSCRIPT_ASSET_MANIFEST.json`.

## 1. Locked reproducible source set

The revised article now carries a minimal local freeze of the five verified publication `exAL-M-T1` runs under:

- `artifacts/five_cutoff_crps_validation_sources/`

For each cutoff, that local freeze includes:
- `crps_forecast_summary.csv`
- `compare_report.json`
- `summary.json`

These local copies are derived from the verified workflow replay roots and should be treated as the article-side provenance anchor for the five-cutoff `exAL-M-T1` CRPS lineage.

## 2. Verified five-run publication lineage

| Cutoff | Local frozen copy | Canonical run root | Canonical CRPS source | Status |
|---|---|---|---|---|
| `2021-01-23` | `artifacts/five_cutoff_crps_validation_sources/20210123_exal_m_t1/` | `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_all_cutoffs_sharedspec_20260516/runs/multimodel_20210123_v8_he2pubgdpc1r1_exdqlm_multivar_keep` | `post/outputs/.../tables/crps_forecast_summary.csv` | `PASS` |
| `2021-11-12` | `artifacts/five_cutoff_crps_validation_sources/20211112_exal_m_t1/` | `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_all_cutoffs_sharedspec_20260516/runs/multimodel_20211112_v8_he2pubgdpc1r1_exdqlm_multivar_keep` | `post/outputs/.../tables/crps_forecast_summary.csv` | `PASS` |
| `2021-12-21` | `artifacts/five_cutoff_crps_validation_sources/20211221_exal_m_t1/` | `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_all_cutoffs_sharedspec_20260516/runs/multimodel_20211221_v8_he2pubgdpc1r1_exdqlm_multivar_keep` | `post/outputs/.../tables/crps_forecast_summary.csv` | `PASS` |
| `2022-05-11` | `artifacts/five_cutoff_crps_validation_sources/20220511_exal_m_t1/` | `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_all_cutoffs_sharedspec_20260516/runs/multimodel_20220511_v8_he2pubgdpc1r1_exdqlm_multivar_keep` | `post/outputs/.../tables/crps_forecast_summary.csv` | `PASS` |
| `2022-12-25` | `artifacts/five_cutoff_crps_validation_sources/20221225_exal_m_t1/` | `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_all_cutoffs_sharedspec_20260516/runs/multimodel_20221225_v8_he2pubgdpc1r1_exdqlm_multivar_keep` | `post/outputs/.../tables/crps_forecast_summary.csv` | `PASS` |

## 3. Representative selected-model bundle

The representative Section 5 cutoff is `2022-12-25`.

The revised article now carries a richer local copy of the verified representative output bundle under:

- `artifacts/representative_selected_model_2022_12_25/`

That bundle now includes:
- selected synthesis figures:
  - `exdqlm_multivar_synth_keep_cutoff_window_posterior_samples.(png,pdf)`
  - `exdqlm_multivar_synth_keep_cutoff_window_posterior_samples_with_raw_ensembles.(png,pdf)`
- synthesis exports:
  - `exdqlm_multivar_synth_keep_cutoff_window_quantiles.csv`
  - `exdqlm_multivar_synth_keep_cutoff_window_sample_subset.csv`
- figure provenance:
  - `figure_manifest.csv`
  - `publication_figure_manifest.csv`
  - `publication_style_used.yaml`
- posterior tables:
  - `covariate_effects_summary.csv/.tex`
  - `gamma_summary.csv/.tex`
  - `sigma_summary.csv/.tex`
  - `posterior_table_exports_manifest.csv`
- CRPS summaries:
  - `crps_forecast_summary.csv`
  - `crps_forecast_per_time.csv`

## 4. Manuscript artifact map

### In-scope objects now locked to the verified five-run/representative source set

| Manuscript object | Current role | Locked cutoff/run | Exact verified source | Current manuscript target | Current status |
|---|---|---|---|---|---|
| `tab:benchmark_crps_models` | five-cutoff validation table | HE2 publication freeze across all five cutoffs | local snapshot in `artifacts/he2_publication_freeze/`, with the `exAL-M-T1` row additionally locked to `artifacts/five_cutoff_crps_validation_sources/<slug>/crps_forecast_summary.csv` | values in `wileyNJD-APA.tex` Table 1 | locked |
| `fig:synth1` | representative selected-model illustration | `2022-12-25 exAL-M-T1 keep` | `artifacts/representative_selected_model_2022_12_25/exdqlm_multivar_synth_keep_cutoff_window_posterior_samples.png` | `figures/manuscript/representative_synthesis_multivariate.png` | refreshed |
| `tab:components_23_31` | representative transfer-function summary | `2022-12-25 exAL-M-T1 keep` | `artifacts/representative_selected_model_2022_12_25/covariate_effects_summary.csv` | values in `wileyNJD-APA.tex` | refreshed |

### Supplementary appendix support tied to the representative selected-model run

| Manuscript object | Current role | Locked cutoff/run | Exact verified source | Current manuscript target | Current status |
|---|---|---|---|---|---|
| `tab:gamma_sigma_intervals1` | supplementary appendix `gamma` summary | `2022-12-25 exAL-M-T1 keep` | `artifacts/representative_selected_model_2022_12_25/gamma_summary.csv` | values in `wileyNJD-APA.tex` | refreshed |
| `tab:gamma_sigma_intervals2` | supplementary appendix `sigma` summary | `2022-12-25 exAL-M-T1 keep` | `artifacts/representative_selected_model_2022_12_25/sigma_summary.csv` | values in `wileyNJD-APA.tex` | refreshed |

### Current-model support outside the locked five-run keep source set

These objects are now wired to current model outputs, but they are still outside the narrow locked `exAL-M-T1` keep-run source set used for the main five-cutoff validation evidence above.

| Manuscript object | Current role | Current source status | Action |
|---|---|---|---|
| `fig:synth2` | appendix historical-only reference | copied from the current `2022-12-25 exdqlm_univar` publication-style output bundle and frozen locally in `artifacts/historical_support_from_current_models/` | keep with explicit current-output support provenance |
| `fig:dry_quantile` | historical regime illustration | rendered from the current `2022-05-11 exAL-M-T1` full-history multivariate run and frozen locally in `artifacts/historical_support_from_current_models/` | keep as current-model historical-support object |
| `fig:rainy_quantile` | historical regime illustration | rendered from the current `2022-05-11 exAL-M-T1` full-history multivariate run and frozen locally in `artifacts/historical_support_from_current_models/` | keep as current-model historical-support object |
| `fig:80_components` | appendix long-cycle historical summary | rendered from the current `2022-05-11 exAL-M-T1` full-history multivariate run and frozen locally in `artifacts/historical_support_from_current_models/` | keep as current-model historical-support object |

### Setup figures outside the selected-model refresh scope

| Manuscript object | Role | Action |
|---|---|---|
| `fig:sanlorenzo` | study-setting figure | now tied to the corrected `v2` cutoff-specific setup/support family; manuscript-facing `figures/manuscript/site_context_usgs.png` is promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/usgs.png`, while all five cutoff variants are preserved under `artifacts/five_cutoff_setup_support/`. In the corrected contract this figure uses the full `1987-05-29 -> cutoff` USGS history available in the selected-run shared inputs. |
| `fig:covariates` | data/covariate setup figure | now tied to the corrected `v2` cutoff-specific setup/support family; manuscript-facing `figures/manuscript/covariate_context_precip_soil_gdpc.png` is promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/...`, while all five cutoff variants are preserved under `artifacts/five_cutoff_setup_support/`. In the corrected contract this figure uses the full `1987-05-29 -> cutoff` raw PPT/SOIL histories together with the canonical GDPC history. |
| `fig:retrospectives` | retrospective-product setup figure | now tied to the corrected `v2` cutoff-specific setup/support family; manuscript-facing `figures/manuscript/retrospective_products_context.png` is promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/...`, while all five cutoff variants are preserved under `artifacts/five_cutoff_setup_support/`. In the corrected contract this figure uses the retrospective support actually available for the cutoff-specific bundle, with the availability audit recorded alongside the figures. |
| `fig:ensembles` | forecast-product setup figure | now tied to the corrected `v2` cutoff-specific setup/support family; manuscript-facing `figures/manuscript/forecast_products_context.png` is promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/...`, while advisor-facing cutoff-wide copies live under `figures/forecast_context_by_cutoff/`. In the corrected contract this figure uses a strict `cutoff - 28 days` to `cutoff + 28 days` display window. |

## 5. What this means operationally

1. The five verified `exAL-M-T1` keep runs are now the locked reproducible source set for the main selected-model manuscript evidence.
2. Any further refresh of the central selected-model objects `fig:synth1` and `tab:components_23_31` should use only the files recorded above.
3. The appendix support tables `tab:gamma_sigma_intervals1` and `tab:gamma_sigma_intervals2` should remain supplementary and should continue to use the representative `2022-12-25` source files recorded above.
4. `fig:synth2` and the historical-support figures are now regenerated from separately locked current-output source paths.
   - They should remain distinguished from the narrow five-run keep lineage used for the main benchmark table.
   - Their article-side provenance anchor is now `artifacts/historical_support_from_current_models/`.

## 6. Locked choice for the current manuscript pass

For the current revised article pass, the chosen approach is:

1. keep `fig:dry_quantile`, `fig:rainy_quantile`, and `fig:80_components`
2. treat them explicitly as current-model historical-support figures
3. do not treat them as additional five-cutoff forecast-validation evidence
4. do not force them into the representative `2022-12-25` selected-run bundle
5. preserve their article-side provenance bundle in `artifacts/historical_support_from_current_models/`
6. preserve `fig:synth2` in `artifacts/historical_support_from_current_models/`
7. preserve the corrected cutoff-dependent setup/support figures through:
   - `artifacts/five_cutoff_setup_support/`
   - `reports/five_cutoff_setup_support_review/`
8. keep the article repo free of older `v1` / ad hoc support families; the cleanup step removes them automatically.
9. refresh the current-model support bundle through:
   - `scripts/refresh_current_model_output_support_figures.py`
10. refresh the corrected cutoff-specific setup/support family through:
   - `scripts/refresh_setup_support_by_cutoff_v2.py`
   - `scripts/build_setup_support_by_cutoff_v2_review.py`
   - `scripts/promote_setup_support_v2_to_disc.py`
11. promote manuscript-facing `figures/manuscript/` figures through the source-controlled generated-asset manifest:
   - `MANUSCRIPT_ASSET_MANIFEST.json`
   - `scripts/promote_generated_figures_to_disc.py`
12. rebuild the manuscript table rows from the frozen article-side CSV exports through:
   - `scripts/build_generated_table_includes.py`
13. refresh the representative selected-model bundle and five-run source freeze through:
   - `scripts/refresh_exal_m_t1_generated_assets.py`
14. refresh the HE2 publication snapshot through:
   - `scripts/refresh_he2_manifest_snapshot.py`
15. refresh all article-side generated bundles and the review report through:
   - `scripts/refresh_all_generated_assets.py`
16. re-apply the article-side cleanup/audit contract through:
   - `scripts/clean_article_legacy_assets.py`

This is the strongest minimal choice because it preserves reproducibility, avoids mixing incompatible provenance roles, and does not require unnecessary reruns.
