# Article Figure Lineage Audit

## Executive read

- Setup/support family refreshed from `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/exal_m_t1_setup_support_by_cutoff_v2_20260516`.
- Setup/support full-history contract across all cutoffs: `PASS`.
- Setup/support GDPC contract across all cutoffs: `PASS`.
- Live shared-spec keep outputs complete: `NO`.
- Legacy uppercase `Figures/` mirror matches lowercase canonical `figures/`: `YES`.

## Figure family conclusions

| Family | Current status | Source lineage | Notes |
|---|---|---|---|
| Setup/support manuscript figures + appendix panels + forecast-context family | `updated_now` | `exal_m_t1_setup_support_by_cutoff_v2_20260516` | Full USGS/PPT/SOIL/GDPC history from `1987-05-29 -> cutoff`; retrospective support now sourced from repaired canonical shared bundles for all cutoffs. |
| Representative keep synthesis + cutoff-wide multivariate synthesis | `updated_now` | completed keep output root `20260516` | Refreshed from the completed shared-spec keep rerun. |
| Historical support from current models | `updated_now` | `completed_keep_outputs_20260516_via_rendered_from_retained_state_summary` | Refreshed from the corrected retained support contract using the dedicated historical-support replay root. |
| Reference synthesis family | `updated_now` | completed univariate output root `20260516` | Refreshed from the completed shared-spec univariate rerun. |

## Per-figure status

| Figure path | Class | Status | Source lineage | Source script | Blocker |
|---|---|---|---|---|---|
| `figures/appendix_cutoff_panels/README.md` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |
| `figures/appendix_cutoff_panels/cutoff_2021_01_23_setup_support.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/build_setup_support_by_cutoff_v2_appendix.py` | - |
| `figures/appendix_cutoff_panels/cutoff_2021_11_12_setup_support.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/build_setup_support_by_cutoff_v2_appendix.py` | - |
| `figures/appendix_cutoff_panels/cutoff_2021_12_21_setup_support.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/build_setup_support_by_cutoff_v2_appendix.py` | - |
| `figures/appendix_cutoff_panels/cutoff_2022_05_11_setup_support.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/build_setup_support_by_cutoff_v2_appendix.py` | - |
| `figures/appendix_cutoff_panels/cutoff_2022_12_25_setup_support.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/build_setup_support_by_cutoff_v2_appendix.py` | - |
| `figures/appendix_cutoff_panels/manifest.csv` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |
| `figures/forecast_context_by_cutoff/README.md` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |
| `figures/forecast_context_by_cutoff/cutoff_2021_01_23_forecast_context.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_cutoff_forecast_context_figures.py` | - |
| `figures/forecast_context_by_cutoff/cutoff_2021_11_12_forecast_context.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_cutoff_forecast_context_figures.py` | - |
| `figures/forecast_context_by_cutoff/cutoff_2021_12_21_forecast_context.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_cutoff_forecast_context_figures.py` | - |
| `figures/forecast_context_by_cutoff/cutoff_2022_05_11_forecast_context.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_cutoff_forecast_context_figures.py` | - |
| `figures/forecast_context_by_cutoff/cutoff_2022_12_25_forecast_context.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_cutoff_forecast_context_figures.py` | - |
| `figures/forecast_context_by_cutoff/manifest.csv` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |
| `figures/manuscript/covariate_context_precip_soil_gdpc.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_setup_support_v2_to_disc.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/forecast_products_context.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_setup_support_v2_to_disc.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/historical_component_80month.png` | model-output-driven figure | `updated_now` | `completed_keep_outputs_20260516_via_rendered_from_retained_state_summary` | `scripts/refresh_current_model_output_support_figures.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/historical_summary_dry_period.png` | model-output-driven figure | `updated_now` | `completed_keep_outputs_20260516_via_rendered_from_retained_state_summary` | `scripts/refresh_current_model_output_support_figures.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/historical_summary_wet_period.png` | model-output-driven figure | `updated_now` | `completed_keep_outputs_20260516_via_rendered_from_retained_state_summary` | `scripts/refresh_current_model_output_support_figures.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/reference_synthesis_univariate.png` | model-output-driven figure | `updated_now` | `completed_keep_outputs_20260516_via_rendered_from_retained_state_summary` | `scripts/refresh_current_model_output_support_figures.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/representative_synthesis_multivariate.png` | model-output-driven figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_exal_m_t1_generated_assets.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/retrospective_products_context.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_setup_support_v2_to_disc.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/manuscript/site_context_usgs.png` | input-side / support / context figure | `updated_now` | `corrected_setup_support_v2_20260516` | `scripts/refresh_setup_support_by_cutoff_v2.py -> scripts/promote_setup_support_v2_to_disc.py -> scripts/promote_generated_figures_to_disc.py` | - |
| `figures/multivariate_synthesis_by_cutoff/README.md` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2021_01_23_multivariate_synthesis.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2021_01_23_multivariate_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2021_11_12_multivariate_synthesis.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2021_11_12_multivariate_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2021_12_21_multivariate_synthesis.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2021_12_21_multivariate_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2022_05_11_multivariate_synthesis.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2022_05_11_multivariate_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2022_12_25_multivariate_synthesis.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/cutoff_2022_12_25_multivariate_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_keep_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/multivariate_synthesis_by_cutoff/manifest.csv` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |
| `figures/reference_synthesis_by_cutoff/README.md` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2021_01_23_reference_synthesis.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2021_01_23_reference_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2021_11_12_reference_synthesis.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2021_11_12_reference_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2021_12_21_reference_synthesis.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2021_12_21_reference_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2022_05_11_reference_synthesis.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2022_05_11_reference_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2022_12_25_reference_synthesis.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/cutoff_2022_12_25_reference_synthesis_with_reference_ensembles.png` | synthesis figure | `updated_now` | `completed_univar_outputs_20260516` | `scripts/refresh_cutoff_synthesis_families.py` | - |
| `figures/reference_synthesis_by_cutoff/manifest.csv` | figure unaffected by corrected lineage | `unchanged_intentionally` | `n/a` | `n/a` | - |

## Explicit keep-family confirmation

- Setup/support keep figure families now use full history: `YES`.
- Setup/support keep figure families now use GDPC instead of the legacy PCA interpretation: `YES`.
- Setup/support keep figure families now use corrected retrospective/forecast bundle lineage from the canonical `20260510` shared-input bundles.
- Keep model-output families are now refreshed to the completed `20260516` shared-spec keep rerun.
- Reference synthesis families are now refreshed to the completed `20260516` shared-spec univariate rerun.
- Historical-support figures are now refreshed from the dedicated retained-support replay contract and promoted into the revised manuscript figure tree.
