# Figure Polish Status Audit

This audit checks the implementation status of the nine-point figure-polish request that preceded the PCA hardening and full-history reconstruction phase.

- `complete`: 9
- `partial`: 0
- `not_done`: 0

## Item-by-item status

### Item 1 [complete]
Figure 1 should remain good and consistent.

- Note: USGS figure remains the manuscript anchor and uses the shared flood-threshold styling and flow-axis label contract.
- Evidence:
  - `Figures/manuscript/site_context_usgs.png`
  - `wileyNJD-APA.tex:243`
  - `scripts/setup_support_bundle_v2_helpers.R:330-371`

### Item 2 [complete]
Figure 2 should remove support-window subtitle, show units for precipitation and soil moisture, keep the large-scale climate-factor label concise, and keep caption compact/high quality.

- Note: Facet labels now render as plotmath expressions for precipitation, soil moisture, and `GDPC[1]`; the manuscript caption describes the raw support-file scale directly.
- Evidence:
  - `Figures/manuscript/covariate_context_precip_soil_gdpc.png`
  - `scripts/figure_style_contract.R:86-92`
  - `scripts/setup_support_bundle_v2_helpers.R:376-401`
  - `wileyNJD-APA.tex:259-264`

### Item 3 [complete]
Figure 3 should remove the historical-support subtitle, keep clear flow units, and use a compact/high-quality caption.

- Note: The retrospective figure uses the shared flow-axis label and no support-window subtitle; the caption now states the corrected full-history support contract and `log(1+x)` units.
- Evidence:
  - `Figures/manuscript/retrospective_products_context.png`
  - `scripts/setup_support_bundle_v2_helpers.R:403-432`
  - `scripts/figure_style_contract.R:3-14`
  - `wileyNJD-APA.tex:278`

### Item 4 [complete]
Figure 4 should use the same flow-axis contract, simplified legend labels, aligned flood thresholds, and readable caption wording without “cutoff-centered”.

- Note: Legend labels now use product/version names only, the flow axis matches the other flow figures, and the flood lines come from the shared helper used by the USGS plot.
- Evidence:
  - `Figures/manuscript/forecast_products_context.png`
  - `scripts/forecats_plot_bundle.R:390-541`
  - `scripts/figure_style_contract.R:61-121`
  - `wileyNJD-APA.tex:330`

### Item 5 [complete]
Figure 5 should use a 0 to 7 y-range and inherit the normalized style when possible.

- Note: The dry-period historical summary is rendered with an explicit `ylim_override = c(0, 7)` under the shared flow display contract.
- Evidence:
  - `Figures/manuscript/historical_summary_dry_period.png`
  - `scripts/render_current_model_output_support_figures.R:617-623`

### Item 6 [complete]
Figure 6 should exist in both 0 to 20 and 0 to 7 variants and keep the normalized style.

- Note: The manuscript version uses `0–7`; the repo preserves the full-range companion under the historical-support artifact bundle.
- Evidence:
  - `Figures/manuscript/historical_summary_wet_period.png`
  - `artifacts/historical_support_from_current_models/figures/historical_summary_wet_period_fullrange.png`
  - `scripts/render_current_model_output_support_figures.R:624-634`

### Item 7 [complete]
Figure 7 and Figure A2 should align visually with Figure 4, be produced for all cutoffs, and also have extra overlay versions with raw/reference ensembles.

- Note: The representative cutoff uses the polished `publication_focus_v2` style and now the corresponding Figure 7 and Figure A2 families are also preserved article-side for all five cutoffs, including the overlay variants with raw/reference ensembles.
- Evidence:
  - `Figures/multivariate_synthesis_by_cutoff/cutoff_2022_12_25_multivariate_synthesis_with_reference_ensembles.png`
  - `artifacts/five_cutoff_main_model_synthesis/20221225_exal_m_t1/exdqlm_multivar_synth_keep_cutoff_window_posterior_samples_with_raw_ensembles.png`
  - `Figures/multivariate_synthesis_by_cutoff/manifest.csv`
  - `Figures/reference_synthesis_by_cutoff/manifest.csv`
  - `R/unified/post_publication_figures.R:546-807`

### Item 8 [complete]
Figure A1 should plot the 80-month seasonal component alone and use a compact, high-quality caption.

- Note: The render metadata records the intended raw component-6 contract explicitly; plus/minus-trend variants are retained only as analysis diagnostics.
- Evidence:
  - `Figures/manuscript/historical_component_80month.png`
  - `artifacts/historical_support_from_current_models/figures/render_metadata.json`
  - `scripts/render_authoritative_selected_model_support_figures.R`
  - `wileyNJD-APA.tex:460-466`

### Item 9 [complete]
Keep the forecast-context panel D for all cutoffs, and replace manuscript A3–A6 setup/support composites with cutoff-specific multivariate synthesis overlays.

- Note: Forecast-context figures remain preserved cutoff-wide for review. The manuscript appendix now uses the cutoff-specific multivariate synthesis overlay figures; setup/support composites are retained only as generated support artifacts and are no longer included in the manuscript.
- Evidence:
  - `Figures/forecast_context_by_cutoff/manifest.csv`
  - `Figures/multivariate_synthesis_by_cutoff/manifest.csv`
  - `Figures/reference_synthesis_by_cutoff/manifest.csv`
  - `artifacts/five_cutoff_setup_support/review/figure_manifest.csv`
  - `wileyNJD-APA.tex:483-520`

## Remaining work before the next modeling phase

1. Keep setup/support composites as repo-only support artifacts unless a future manuscript revision explicitly requests them.
2. Keep the early short-window cutoffs (`2021-01-23`, `2021-11-12`) separate from any future full-history-only interpretation claims until the full-table corrected bundle relaunch is complete.

