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
| `fig:sanlorenzo` | Study-setting figure | `figures/manuscript/site_context_usgs.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/usgs.png` | 260 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |
| `fig:covariates` | Covariate setup figure | `figures/manuscript/covariate_context_precip_soil_gdpc.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/precip_soilmoisture_climatePC1_faceted_labeled.png` | 281 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |
| `fig:retrospectives` | Retrospective-product setup figure | `figures/manuscript/retrospective_products_context.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/retrospective_log_discharge_plot_faceted.png` | 296 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |
| `fig:ensembles` | Forecast-product setup figure | `figures/manuscript/forecast_products_context.png` | `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/forecats.png` | 347 | yes | Representative 2022-12-25 setup/support figure from the canonical five-cutoff support bundle |

## Selected Model

| Label | Role | Manuscript path | Artifact source | TeX line | Wired to current outputs? | Note |
|---|---|---|---|---:|---|---|
| `fig:dry_quantile` | Selected-model quantile dynamics, 2012-2016 window | `figures/manuscript/historical_summary_dry_period.png` | `artifacts/representative_selected_model_2022_12_25/authoritative_support/figures/selected_model_quantile_dry_period.png` | 398 | yes | Rendered from the same 2022-12-25 selected exAL-M-T1 output authority as the synthesis figure. |
| `fig:rainy_quantile` | Selected-model quantile dynamics, 2017-2019 window | `figures/manuscript/historical_summary_wet_period.png` | `artifacts/representative_selected_model_2022_12_25/authoritative_support/figures/selected_model_quantile_wet_period.png` | 407 | yes | Rendered from the same 2022-12-25 selected exAL-M-T1 output authority as the synthesis figure. |
| `fig:synth1` | Representative selected-model synthesis with reference-product overlays | `figures/manuscript/representative_synthesis_multivariate.png` | `artifacts/representative_selected_model_2022_12_25/representative_synthesis_multivariate_with_reference_ensembles.png` | 425 | yes | Authoritative representative 2022-12-25 exAL-M-T1 canonical-grid output with adapter-scale retrospective and forecast-product references |
| `fig:80_components` | Selected-model 80-month component summary with dry/wet period overlays | `figures/manuscript/historical_component_80month.png` | `artifacts/representative_selected_model_2022_12_25/authoritative_support/figures/selected_model_component_80month.png` | 502 | yes | Rendered from the same 2022-12-25 selected exAL-M-T1 output authority as the synthesis figure using the audited samplewise component-6-plus-trend contract. |

## Appendix Support

| Label | Role | Manuscript path | Artifact source | TeX line | Wired to current outputs? | Note |
|---|---|---|---|---:|---|---|
| `fig:synth2` | Historical-only reference synthesis | `figures/manuscript/reference_synthesis_univariate.png` | `artifacts/historical_support_from_current_models/figures/reference_synthesis_univariate.png` | 516 | yes | Copied from the current 2022-12-25 exdqlm_univar publication-style output bundle |

## Tables

| Label | Role | Generated include | TeX line | Note |
|---|---|---|---:|---|
| `tab:benchmark_crps_models` | Five-cutoff 28-day benchmark table | `tables/generated_tex/benchmark_crps_main_table.tex` | 364 | Generated from the frozen HE2 publication manifest plus the 28-day raw GloFAS row in the five authoritative exAL-M-T1 per-time CRPS summaries. NWS is intentionally excluded from this table because the archived NWS forecasts provide only eight valid daily leads for these origins. |
| `tab:benchmark_crps_models_nws_horizon` | Five-cutoff common eight-day NWS-horizon benchmark table | `tables/generated_tex/benchmark_crps_nws_horizon_table.tex` | 368 | Generated from the same frozen HE2 publication manifest and authoritative exAL-M-T1 per-time CRPS sources as Table 1, but every row is restricted to leads 1--8 so RAW-NWS, RAW-GLOFAS, and the Bayesian predictive distributions are compared on a common horizon. |
| `tab:he4_quantile_check_loss` | Forecast-window quantile check-loss table for the four principal synthesis competitors | `tables/generated_tex/he4_quantile_check_loss_main_table.tex` | 374 | Generated from the current HE2 publication manifest rows for exAL-M-T1, AL-M-T1, exAL-U-T1, and AL-U-T1. Quantile artifacts are resolved from the manifest run_root/run_id pairs, and CRPS is cross-checked against the frozen HE2 manifest before check losses are summarized. |
| `tab:components_23_31` | Representative covariate-effects table | `tables/generated_tex/representative_covariate_effects_table.tex` | 386 | Generated from the representative 2022-12-25 exAL-M-T1 covariate-effects export |
| `tab:gamma_sigma_intervals1` | Appendix gamma summary | `tables/generated_tex/appendix_gamma_summary_table.tex` | 491 | Generated from the representative 2022-12-25 exAL-M-T1 gamma export |
| `tab:gamma_sigma_intervals2` | Appendix sigma summary | `tables/generated_tex/appendix_sigma_summary_table.tex` | 493 | Generated from the representative 2022-12-25 exAL-M-T1 sigma export |
| `tab:he3_ablation_crps` | Selected-model 28-day ablation CRPS table | `tables/generated_tex/he3_ablation_crps_main_table.tex` | 482 | Generated from the authoritative HE3 exDQLM multivariate ablation matrix anchored to the 20260601 exAL-M-T1 winner manifest. This 28-day table includes RAW-GLOFAS as the horizon-compatible raw reference and omits RAW-NWS because NWS has eight valid daily leads for these origins. |
| `tab:he3_ablation_crps_nws_horizon` | Selected-model common eight-day NWS-horizon ablation CRPS table | `tables/generated_tex/he3_ablation_crps_nws_horizon_table.tex` | 484 | Generated from the same authoritative HE3 ablation sources as the 28-day table, but every row is restricted to leads 1--8 so RAW-NWS, RAW-GLOFAS, the full model, and the ablation variants are compared on a common horizon. |

## Generated manifests

- `reports/manuscript_asset_review/figure_manifest.csv`
- `reports/manuscript_asset_review/table_manifest.csv`
- `reports/manuscript_asset_review/CURRENT_MODEL_OUTPUT_WIRING_AUDIT.md`
