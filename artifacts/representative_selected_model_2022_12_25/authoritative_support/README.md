# Authoritative Selected-Model Support

This bundle contains compact posterior support artifacts and rendered figures for the representative `2022-12-25 exAL-M-T1` selected model. These figures are sourced from the same selected-output authority as the synthesis figure. Figure A1 is article-labeled as the 80-month seasonal component; its internal render metadata records the audited samplewise component-6-plus-trend construction and the dry/wet period overlays. The `analysis_figures/component_evolution/` subfolder is an analysis-only component gallery rendered from the same support CSVs; it is checksummed here but intentionally not registered as a manuscript figure family.

Large compact support CSV/RDS files are intentionally not persisted in this Overleaf-facing article repository. The manifest records their external runtime source paths and hashes; the refresh script stages those files in a temporary directory only while rendering figures.

- run id: `multimodel_20221225_v8_he2grid_c05_eps030_exdqlm_multivar_keep`
- cutoff: `2022-12-25`
- runtime output root: `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_epsilon_discount_grid_20260524/runs/multimodel_20221225_v8_he2grid_c05_eps030_exdqlm_multivar_keep/post/outputs/multimodel_20221225_v8_he2grid_c05_eps030_exdqlm_multivar_keep`

Refresh entrypoint:
- `scripts/refresh_authoritative_selected_model_support_figures.py`
