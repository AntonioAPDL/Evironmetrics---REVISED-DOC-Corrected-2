# Article Asset Review Report

This report groups the current revised-article figures and tables by provenance role so they can be reviewed visually and operationally.

Manifest contract: `MANUSCRIPT_ASSET_MANIFEST.json`

Primary visual gallery: `reports/manuscript_asset_review/figure_gallery.html`

Primary wiring audit: `reports/manuscript_asset_review/CURRENT_MODEL_OUTPUT_WIRING_AUDIT.md`

## Review priorities

1. Check that setup/input figures are legible and still appropriate.
2. Check that `fig:synth1` matches the intended representative selected-model story.
3. Check that historical-summary figures read as descriptive support rather than validation evidence.
4. Check that appendix support figures and tables are still placed appropriately.

## Setup / Inputs

| Label | Role | Manuscript path | Artifact source | TeX line | Wired to current outputs? | Note |
|---|---|---|---|---:|---|---|
| `fig:sanlorenzo` | Study-setting figure | `figures/manuscript/site_context_usgs.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/usgs.png` | 251 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |
| `fig:covariates` | Covariate setup figure | `figures/manuscript/covariate_context_precip_soil_gdpc.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/precip_soilmoisture_climatePC1_faceted_labeled.png` | 272 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |
| `fig:retrospectives` | Retrospective-product setup figure | `figures/manuscript/retrospective_products_context.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/retrospective_log_discharge_plot_faceted.png` | 287 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |
| `fig:ensembles` | Forecast-product setup figure | `figures/manuscript/forecast_products_context.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/forecats.png` | 338 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |

## Selected Model

| Label | Role | Manuscript path | Artifact source | TeX line | Wired to current outputs? | Note |
|---|---|---|---|---:|---|---|
| `fig:dry_quantile` | Selected-model quantile dynamics, 2012-2016 window | `figures/manuscript/historical_summary_dry_period.png` | `artifacts/representative_selected_model_2022_12_25/authoritative_support/figures/selected_model_quantile_dry_period.png` | 389 | yes | Rendered from the same 2022-12-25 selected exAL-M-T1 output authority as the synthesis figure. |
| `fig:rainy_quantile` | Selected-model quantile dynamics, 2017-2019 window | `figures/manuscript/historical_summary_wet_period.png` | `artifacts/representative_selected_model_2022_12_25/authoritative_support/figures/selected_model_quantile_wet_period.png` | 398 | yes | Rendered from the same 2022-12-25 selected exAL-M-T1 output authority as the synthesis figure. |
| `fig:synth1` | Representative selected-model synthesis | `figures/manuscript/representative_synthesis_multivariate.png` | `artifacts/representative_selected_model_2022_12_25/representative_synthesis_multivariate.png` | 416 | yes | Authoritative representative 2022-12-25 exAL-M-T1 canonical-grid output |
| `fig:80_components` | Selected-model 80-month component summary with dry/wet period overlays | `figures/manuscript/historical_component_80month.png` | `artifacts/representative_selected_model_2022_12_25/authoritative_support/figures/selected_model_component_80month.png` | 481 | yes | Rendered from the same 2022-12-25 selected exAL-M-T1 output authority as the synthesis figure using the audited samplewise component-6-plus-trend contract. |

## Appendix Support

| Label | Role | Manuscript path | Artifact source | TeX line | Wired to current outputs? | Note |
|---|---|---|---|---:|---|---|
| `fig:synth2` | Historical-only reference synthesis | `figures/manuscript/reference_synthesis_univariate.png` | `artifacts/historical_support_from_current_models/figures/reference_synthesis_univariate.png` | 495 | yes | Copied from the current 2022-12-25 exdqlm_univar publication-style output bundle |

## Tables

| Label | Role | Generated include | TeX line | Note |
|---|---|---|---:|---|
| `tab:benchmark_crps_models` | Five-cutoff benchmark table | `tables/generated_tex/benchmark_crps_main_table.tex` | 355 | Generated from the frozen HE2 publication manifest plus the raw-baseline rows in the five authoritative exAL-M-T1 CRPS summaries. All nine Bayesian benchmark families are promoted onto the canonical 20260510 input-bundle contract; this is the final CRPS table source for the current publication snapshot. |
| `tab:he4_quantile_check_loss` | Forecast-window quantile check-loss table for the four principal synthesis competitors | `tables/generated_tex/he4_quantile_check_loss_main_table.tex` | 361 | Generated from the current HE2 publication manifest rows for exAL-M-T1, AL-M-T1, exAL-U-T1, and AL-U-T1. Quantile artifacts are resolved from the manifest run_root/run_id pairs, and CRPS is cross-checked against the frozen HE2 manifest before check losses are summarized. |
| `tab:components_23_31` | Representative covariate-effects table | `tables/generated_tex/representative_covariate_effects_table.tex` | 377 | Generated from the representative 2022-12-25 exAL-M-T1 covariate-effects export |
| `tab:gamma_sigma_intervals1` | Appendix gamma summary | `tables/generated_tex/appendix_gamma_summary_table.tex` | 470 | Generated from the representative 2022-12-25 exAL-M-T1 gamma export |
| `tab:gamma_sigma_intervals2` | Appendix sigma summary | `tables/generated_tex/appendix_sigma_summary_table.tex` | 472 | Generated from the representative 2022-12-25 exAL-M-T1 sigma export |
| `tab:he3_ablation_crps` | Selected-model ablation CRPS table | `tables/generated_tex/he3_ablation_crps_main_table.tex` | 369 | Generated from the authoritative HE3 exDQLM multivariate ablation matrix anchored to the 20260601 exAL-M-T1 winner manifest; raw forecast references are copied from the article-side five-cutoff CRPS validation source freeze. |

## Generated manifests

- `reports/manuscript_asset_review/figure_manifest.csv`
- `reports/manuscript_asset_review/table_manifest.csv`
- `reports/manuscript_asset_review/CURRENT_MODEL_OUTPUT_WIRING_AUDIT.md`
