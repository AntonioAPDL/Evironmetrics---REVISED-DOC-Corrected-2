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
  - `figures/manuscript/site_context_usgs.png`
  - `wileyNJD-APA.tex:243`
  - `scripts/setup_support_bundle_v2_helpers.R:330-371`

### Item 2 [complete]
Figure 2 should remove support-window subtitle, show units for precipitation and soil moisture, keep the large-scale climate-factor label concise, and keep caption compact/high quality.

- Note: Facet labels now render as plotmath expressions for precipitation, soil moisture, and `GDPC[1]`; the manuscript caption describes the raw support-file scale directly.
- Evidence:
  - `figures/manuscript/covariate_context_precip_soil_gdpc.png`
  - `scripts/figure_style_contract.R:86-92`
  - `scripts/setup_support_bundle_v2_helpers.R:376-401`
  - `wileyNJD-APA.tex:259-264`

### Item 3 [complete]
Figure 3 should remove the historical-support subtitle, keep clear flow units, and use a compact/high-quality caption.

- Note: The retrospective figure uses the shared flow-axis label and no support-window subtitle; the caption now states the corrected full-history support contract and `log(1+x)` units.
- Evidence:
  - `figures/manuscript/retrospective_products_context.png`
  - `scripts/setup_support_bundle_v2_helpers.R:403-432`
  - `scripts/figure_style_contract.R:3-14`
  - `wileyNJD-APA.tex:278`

### Item 4 [complete]
Figure 4 should use the same flow-axis contract, simplified legend labels, aligned flood thresholds, and readable caption wording without “cutoff-centered”.

- Note: Legend labels now use product/version names only, the flow axis matches the other flow figures, and the flood lines come from the shared helper used by the USGS plot.
- Evidence:
  - `figures/manuscript/forecast_products_context.png`
  - `scripts/forecats_plot_bundle.R:390-541`
  - `scripts/figure_style_contract.R:61-121`
  - `wileyNJD-APA.tex:330`

### Item 5 [complete]
Figure 5 should use a 0 to 7 y-range and inherit the normalized style when possible.

- Note: The dry-period historical summary is rendered with an explicit `ylim_override = c(0, 7)` under the shared flow display contract.
- Evidence:
  - `figures/manuscript/historical_summary_dry_period.png`
  - `scripts/render_current_model_output_support_figures.R:617-623`

### Item 6 [complete]
Figure 6 should exist in both 0 to 20 and 0 to 7 variants and keep the normalized style.

- Note: The manuscript version uses `0–7`; the repo preserves the full-range companion under the historical-support artifact bundle.
- Evidence:
  - `figures/manuscript/historical_summary_wet_period.png`
  - `artifacts/historical_support_from_current_models/figures/historical_summary_wet_period_fullrange.png`
  - `scripts/render_current_model_output_support_figures.R:624-634`

### Item 7 [complete]
Figure 7 and Figure A2 should align visually with Figure 4, be produced for all cutoffs, and also have extra overlay versions with raw/reference ensembles.

- Note: The representative cutoff uses the polished `publication_focus_v2` style and now the corresponding Figure 7 and Figure A2 families are also preserved article-side for all five cutoffs, including the overlay variants with raw/reference ensembles.
- Evidence:
  - `artifacts/representative_selected_model_2022_12_25/representative_synthesis_multivariate.png`
  - `artifacts/representative_selected_model_2022_12_25/representative_synthesis_multivariate_with_reference_ensembles.png`
  - `figures/multivariate_synthesis_by_cutoff/manifest.csv`
  - `figures/reference_synthesis_by_cutoff/manifest.csv`
  - `R/unified/post_publication_figures.R:546-807`

### Item 8 [complete]
Figure A1 should plot the 80-month component after adding the posterior mean trend level and use a compact, high-quality caption.

- Note: The render metadata records the intended contract explicitly and the renderer computes the trend-shift map before building the 80-month component figure.
- Evidence:
  - `figures/manuscript/historical_component_80month.png`
  - `artifacts/historical_support_from_current_models/figures/render_metadata.json`
  - `scripts/render_current_model_output_support_figures.R:589-608, 656-680`
  - `wileyNJD-APA.tex:460-466`

### Item 9 [complete]
Keep the composite A3–A6 style panels only if useful; definitely preserve the forecast-context panel D for all cutoffs, and do the same cutoff-wide treatment for Figure 7 and A2 when full-history conditions allow it.

- Note: Forecast-context figures, multivariate synthesis figures, and reference synthesis figures are now preserved cutoff-wide in advisor-facing folders. The remaining decision is whether the composite appendix panels should stay in the manuscript appendix or move to repo-only review support.
- Evidence:
  - `figures/forecast_context_by_cutoff/manifest.csv`
  - `figures/multivariate_synthesis_by_cutoff/manifest.csv`
  - `figures/reference_synthesis_by_cutoff/manifest.csv`
  - `figures/appendix_cutoff_panels/`
  - `artifacts/five_cutoff_setup_support/review/figure_manifest.csv`
  - `wileyNJD-APA.tex:483-520`

## Remaining work before the next modeling phase

1. Decide whether the appendix composite setup/support panels should remain in the manuscript appendix or move to repo-only documentation.
2. Keep the early short-window cutoffs (`2021-01-23`, `2021-11-12`) separate from any future full-history-only interpretation claims until the full-table corrected bundle relaunch is complete.

