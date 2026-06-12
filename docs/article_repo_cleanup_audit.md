# Article Repo Cleanup Audit

This report records the cleanup that removes retired article-side figure/table directories and old naming layers after the repository reorganization.

## Canonical manuscript-facing figures

- `figures/manuscript/covariate_context_precip_soil_gdpc.png`
- `figures/manuscript/forecast_products_context.png`
- `figures/manuscript/historical_component_80month.png`
- `figures/manuscript/historical_summary_dry_period.png`
- `figures/manuscript/historical_summary_wet_period.png`
- `figures/manuscript/reference_synthesis_univariate.png`
- `figures/manuscript/representative_synthesis_multivariate.png`
- `figures/manuscript/retrospective_products_context.png`
- `figures/manuscript/site_context_usgs.png`

## Removed legacy paths

- `scripts/__pycache__`

## Retained artifact families

- `artifacts/five_cutoff_crps_validation_sources`
- `artifacts/five_cutoff_main_model_synthesis`
- `artifacts/five_cutoff_reference_synthesis`
- `artifacts/five_cutoff_setup_support`
- `artifacts/he2_historical_support_audit`
- `artifacts/he2_publication_freeze`
- `artifacts/historical_support_from_current_models`
- `artifacts/representative_selected_model_2022_12_25`

## Retained report families

- `reports/article_figure_lineage_audit_20260516`
- `reports/five_cutoff_setup_support_review`
- `reports/five_cutoff_synthesis_review`
- `reports/manuscript_asset_review`
- `reports/manuscript_figure_selection`
- `reports/representative_setup_selection`

## Current cleanup contract

1. `figures/manuscript/` should contain only the figure files named in `MANUSCRIPT_ASSET_MANIFEST.json`.
2. The old `DISC/` and `generated/` directory trees should remain absent.
3. Refresh through `scripts/refresh_all_generated_assets.py`, which now re-applies this cleanup automatically.
