# Authoritative Selected-Model Support

This bundle contains compact posterior support artifacts and rendered figures for the representative `2022-12-25 exAL-M-T1` selected model. It is the full-history support bundle used for the dry/wet and 80-month interpretation diagnostics, and it is wired to the same current `2022-12-25` selected `exAL-M-T1` output authority as the representative synthesis figure. These figures remain interpretation diagnostics, not forecast-validation evidence. Figure A1 is article-labeled as the 80-month seasonal component; its internal render metadata records the audited samplewise component-6-plus-trend construction and the dry/wet period overlays. The `analysis_figures/component_evolution/` subfolder is an analysis-only component gallery rendered from the same support CSVs; it is checksummed here but intentionally not registered as a manuscript figure family. It also includes the samplewise component-6-minus-trend diagnostic when the support summary provides that contract.

Large compact support CSV/RDS files are intentionally not persisted in this Overleaf-facing article repository. The manifest records their external runtime source paths and hashes; the refresh script stages those files in a temporary directory only while rendering figures.

- support run id: `multimodel_20221225_v8_he2grid_c05_eps030_exdqlm_multivar_keep`
- cutoff: `2022-12-25`
- support runtime output root: `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_epsilon_discount_grid_20260524/runs/multimodel_20221225_v8_he2grid_c05_eps030_exdqlm_multivar_keep/post/outputs/multimodel_20221225_v8_he2grid_c05_eps030_exdqlm_multivar_keep`
- clean 2026-06-23 representative authority: `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_partial_authority_refresh_20260623/runs/multimodel_20221225_v8_he2partial20260623_exdqlm_multivar_keep`

Refresh entrypoint:
- `scripts/refresh_authoritative_selected_model_support_figures.py`
