# Article Repository Structure

This document describes the current advisor-facing structure of the revised article repository after the cleanup and rewiring pass on 2026-05-09.

## Purpose

The repository is organized so that a reader can separate three roles immediately:

1. manuscript-facing assets actually used by the paper
2. frozen artifact bundles copied from validated workflow outputs
3. review and audit reports that document provenance and wiring

## Top-level layout

- `wileyNJD-APA.tex`: manuscript source used by Overleaf
- `figures/`: manuscript-facing figures, appendix cutoff panels, and advisor-facing forecast-context copies
- `tables/`: generated TeX tables consumed by `\input{}` in the manuscript
- `artifacts/`: article-local frozen bundles copied from validated workflow outputs
- `reports/`: galleries, audits, selection manifests, and review reports
- `docs/`: advisor-facing documentation and provenance notes
- `scripts/`: refresh, promotion, and audit scripts used to regenerate the article-side state

The manuscript now resolves figures through a validated `\graphicspath` layer.
The canonical asset tree remains lowercase `figures/`, but the TeX compile path
also tolerates the legacy uppercase `Figures/` tree so Overleaf Git-sync
transitions do not break figure rendering.

## Manuscript-facing paths

### Figures used directly by the manuscript

- `figures/manuscript/site_context_usgs.png`
- `figures/manuscript/covariate_context_precip_soil_gdpc.png`
- `figures/manuscript/retrospective_products_context.png`
- `figures/manuscript/forecast_products_context.png`
- `figures/manuscript/historical_summary_dry_period.png`
- `figures/manuscript/historical_summary_wet_period.png`
- `figures/manuscript/representative_synthesis_multivariate.png`
- `figures/manuscript/historical_component_80month.png`
- `figures/manuscript/reference_synthesis_univariate.png`

### Appendix cutoff-panel figures

- `figures/appendix_cutoff_panels/cutoff_2021_01_23_setup_support.png`
- `figures/appendix_cutoff_panels/cutoff_2021_11_12_setup_support.png`
- `figures/appendix_cutoff_panels/cutoff_2021_12_21_setup_support.png`
- `figures/appendix_cutoff_panels/cutoff_2022_05_11_setup_support.png`
- `figures/appendix_cutoff_panels/cutoff_2022_12_25_setup_support.png`

### Advisor-facing cutoff forecast-context figures

- `figures/forecast_context_by_cutoff/cutoff_2021_01_23_forecast_context.png`
- `figures/forecast_context_by_cutoff/cutoff_2021_11_12_forecast_context.png`
- `figures/forecast_context_by_cutoff/cutoff_2021_12_21_forecast_context.png`
- `figures/forecast_context_by_cutoff/cutoff_2022_05_11_forecast_context.png`
- `figures/forecast_context_by_cutoff/cutoff_2022_12_25_forecast_context.png`

These are advisor-facing copies of the Figure 4 forecast-context view for every cutoff. They are not manuscript-facing paths, but they are refreshed automatically and meant to support cutoff-by-cutoff review before wider synthesis promotion work.

### Generated tables used directly by the manuscript

- `tables/generated_tex/benchmark_crps_main_table.tex`
- `tables/generated_tex/representative_covariate_effects_table.tex`
- `tables/generated_tex/appendix_gamma_summary_table.tex`
- `tables/generated_tex/appendix_sigma_summary_table.tex`

## Artifact bundles

- `artifacts/five_cutoff_setup_support/`
  - canonical five-cutoff setup/support family mirrored from the validated runtime bundle
- `artifacts/historical_support_from_current_models/`
  - current-model historical-support figures used by manuscript Figures 5, 6, A1, and A2
- `artifacts/representative_selected_model_2022_12_25/`
  - representative selected-model bundle for the verified 2022-12-25 exAL-M-T1 rerun
- `artifacts/five_cutoff_crps_validation_sources/`
  - five-cutoff CRPS source freeze used by the benchmark table
- `artifacts/he2_publication_freeze/`
  - local snapshot of the workflow-side HE2 publication manifest
- `artifacts/he2_historical_support_audit/`
  - local snapshot of the workflow-side HE2 historical-support audit

## Review bundles

- `reports/manuscript_asset_review/`
  - article-wide gallery, figure/table manifests, and wiring audit
- `reports/manuscript_figure_selection/`
  - exact promotion manifest from artifact bundles to manuscript-facing figure files
- `reports/five_cutoff_setup_support_review/`
  - review gallery and audits for the five-cutoff setup/support family
- `reports/representative_setup_selection/`
  - records which cutoff bundle feeds Figures 1-4

## Canonical manifest

The source-controlled selection contract is:

- `MANUSCRIPT_ASSET_MANIFEST.json`

This manifest records:

- manuscript-facing figure paths
- artifact-source paths for those figures
- manuscript table include paths
- artifact-source paths for the table inputs

## Standard refresh workflow

```bash
python3 scripts/refresh_all_generated_assets.py
```

This refresh path now does all of the following:

1. rebuild article-side artifact bundles
2. rebuild review reports and audits
3. promote manuscript-facing figure files from the manifest contract
4. promote the advisor-facing cutoff forecast-context figure family
5. regenerate manuscript table blocks
6. remove the retired `DISC/` and `generated/` naming layers
7. rebuild the advisor-facing README and inventory guides
8. validate that every manuscript `\includegraphics{}` call resolves to an
   existing figure asset

## Standard compile workflow

```bash
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
bibtex output
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
```

## Legacy crosswalk

The machine-readable current-to-legacy path crosswalk is stored at:

- `docs/article_repository_path_crosswalk.csv`

That file is meant for maintainers who need to map old notes or emails that still mention the retired `DISC/` or `generated/` paths.
