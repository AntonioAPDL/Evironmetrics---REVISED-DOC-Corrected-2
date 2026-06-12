# Figure and Table Provenance Inventory

## Scope

This document records the current provenance status of manuscript figures and interpretation-dependent tables for the revised Environmetrics article.

Primary manuscript repo:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-Corrected`

Primary workflow repo currently linked to figure/table generation:
- `/data/muscat_data/jaguir26/project1_ucsc_phd`

Main purpose:
- identify which manuscript outputs are already traceable to the current workflow,
- distinguish reproducible workflow-linked outputs from legacy or ambiguous outputs,
- and define the next regeneration tasks needed to align all interpretation material with the final selected `exAL-M-T1` analysis behind Table 1.

Companion relaunch document:
- `docs/exal_m_t1_relaunch_checklist.md`
  - This records the exact cutoff-by-cutoff source runs behind the published `exAL-M-T1` CRPS values, the required rerun artifacts, and the post-rerun validation contract.
- `docs/exal_m_t1_shared_rerun_checklist.md`
  - This records the planned next shared-spec rerun and the article-side figure/table families that will be refreshed from it once the new relaunch completes.

Setup/support figure correction plan:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_SOURCE_MANIFEST.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_FILE_PLAN.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_ACCEPTANCE_CHECKLIST.md`

Canonical forward runbook:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/CANONICAL_REVISED_ARTICLE_WORKFLOW.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/HE2_FULL_HISTORY_REPAIR_FORWARD_PLAN.md`

Article-side provenance refresh helper:
- `MANUSCRIPT_ASSET_MANIFEST.json`
- `scripts/refresh_current_model_output_support_figures.py`
- `scripts/refresh_exal_m_t1_generated_assets.py`
- `scripts/refresh_he2_manifest_snapshot.py`
- `scripts/refresh_setup_support_by_cutoff_v2.py`
- `scripts/build_generated_table_includes.py`
- `scripts/promote_generated_figures_to_disc.py`
- `scripts/build_setup_support_by_cutoff_v2_appendix.py`
- `scripts/clean_article_legacy_assets.py`
- `scripts/build_generated_asset_index.py`
- `scripts/refresh_all_generated_assets.py`

Article-side review outputs:
- `reports/manuscript_asset_review/ARTICLE_ASSET_REVIEW.md`
- `reports/manuscript_asset_review/figure_gallery.html`
- `reports/manuscript_asset_review/CURRENT_MODEL_OUTPUT_WIRING_AUDIT.md`
- `reports/manuscript_asset_review/FIGURE_POLISH_STATUS_AUDIT.md`
- `reports/manuscript_figure_selection/selection_manifest.json`
- `tables/generated_tex/README.md`
- `artifacts/README.md`
- `artifacts/artifact_inventory.csv`
- `artifacts/he2_historical_support_audit/historical_support_audit.md`
- `figures/appendix_cutoff_panels/README.md`
- `figures/forecast_context_by_cutoff/README.md`

This inventory now distinguishes three reproducibility levels:
- objects frozen locally in the article repo and tied to verified selected-model reruns,
- objects frozen locally in the article repo as canonical current-output or setup/support `v2` support bundles,
- and the underlying workflow-side generators that remain the authoritative reproduction path.

## Overall conclusion

The manuscript repo is **not fully self-contained** for figure/table generation. It now contains frozen local provenance bundles for all current figure/table assets used by the article, but the authoritative generators still live in the workflow repo above.

Most important results from this audit:
- every figure file currently used by the manuscript and checked below matches the workflow repo's recorded gold hash exactly.
- every current figure/table asset in the article is now either:
  - tied to a verified selected-model rerun bundle,
  - or frozen locally as a workflow-linked support figure.
- the manuscript-facing `figures/manuscript/` figures are now promoted from a source-controlled generated-asset manifest rather than by manual selection.
- the model-derived manuscript tables now consume generated `\\input{}` row includes rebuilt from frozen article-side CSV sources.

That means the current manuscript figures are strongly linked to the current workflow repo, even though the manuscript repo itself does not carry the full generation scripts.

The clean current generator contract is:
- `R/unified/stages/stage_post.R`
- `scripts/run_environmetrics_figures.R`
- `R/environmetrics/40_figures.R`

The article-side generated asset freeze point is now indexed under:
- `artifacts/README.md`
- `artifacts/artifact_inventory.csv`

The appendix-ready composite cutoff panels now live under:
- `figures/appendix_cutoff_panels/`

The weaker historical entrypoint is:
- `scripts/make_environmetrics_figures.R`

That legacy script still relies on notebook-linearized state and hard-coded external paths, so it should not be treated as the primary current reproduction contract.

## 2026-05-06 selected-model refresh status

The representative selected-model refresh is now partially complete.

Verified source run:
- `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_all_cutoffs_sharedspec_20260516/runs/multimodel_20221225_v8_he2pubgdpc1r1_exdqlm_multivar_keep`

Verified status:
- `validation_status=pass`
- `compare_status=pass`
- deterministic-climate validation passes
- posterior table exports are present

The revised manuscript repo now contains a local copy of the representative selected-model artifacts under:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/Evironmetrics---REVISED-DOC-Corrected/artifacts/representative_selected_model_2022_12_25`

Those copied artifacts include:
- `posterior_samples_valid.png`
- `covariate_effects_summary.csv/.tex`
- `gamma_summary.csv/.tex`
- `sigma_summary.csv/.tex`
- `posterior_table_exports_manifest.csv`

Current manuscript refreshes already tied to that verified run:
- `figures/manuscript/representative_synthesis_multivariate.png`
- `tab:components_23_31`
- `tab:gamma_sigma_intervals1`
- `tab:gamma_sigma_intervals2`

The narrow exAL-M-T1 relaunch is now verified across all five publication cutoffs.

The exact manuscript-side artifact mapping is recorded in:
- `docs/exal_m_t1_artifact_run_map.md`

That companion file should now be treated as the most direct answer to:
- which manuscript objects are locked to the verified five-run keep lineage,
- which objects are already refreshed from the representative `2022-12-25` run,
- and which remaining figures are workflow-linked support objects outside the narrow keep-run source set.

The revised manuscript repo now carries its current support-side freeze under:
- `artifacts/historical_support_from_current_models/`
- `artifacts/five_cutoff_setup_support/`

Legacy article-side support bundles removed during the 2026-05-09 cleanup:
- `artifacts/historical_summary_sources/`
- `artifacts/workflow_linked_support_sources/`
- `artifacts/setup_support_by_cutoff/`
- `artifacts/setup_support_by_cutoff_review/`

It also contains a dedicated cutoff-specific setup/support figure family derived from the five verified `exAL-M-T1` run bundles:
- `artifacts/five_cutoff_setup_support/`
- `reports/five_cutoff_setup_support_review/`

That family is produced from the current workflow-side derivation path:
- `config/exal_m_t1_setup_support_by_cutoff_v2_20260516.json`
- `scripts/render_exal_m_t1_setup_support_by_cutoff_v2.py`
- `scripts/render_setup_support_bundle_v2.R`
- `scripts/setup_support_bundle_v2_helpers.R`
- `scripts/validate_exal_m_t1_setup_support_v2.py`
- `repro/run/EXAL_M_T1_SETUP_SUPPORT_BY_CUTOFF_V2_WORKFLOW.md`

Current article-facing status:
- the corrected `v2` setup/support family is now implemented, validated, and mirrored locally;
- the manuscript-facing `figures/manuscript/` copies are promoted from the representative `20221225_exal_m_t1` bundle;
- legacy `v1` and ad hoc support families have been removed from the article repo.

The current support families can now be refreshed through:
- `scripts/refresh_current_model_output_support_figures.py`
- `scripts/refresh_setup_support_by_cutoff_v2.py`
- `scripts/build_setup_support_by_cutoff_v2_appendix.py`
- `scripts/clean_article_legacy_assets.py`

The representative selected-model bundle and the HE2 snapshot can now be refreshed through:
- `scripts/refresh_exal_m_t1_generated_assets.py`
- `scripts/refresh_he2_manifest_snapshot.py`

The preferred top-level article-side refresh entrypoint is:
- `scripts/refresh_all_generated_assets.py`

The representative selected-model support refresh also writes an analysis-only
component gallery under:
- `artifacts/representative_selected_model_2022_12_25/authoritative_support/analysis_figures/component_evolution/`

That gallery is rendered from the same compact selected-model support CSVs as
Figure A1. It includes raw retained state components plus the audited
`component_6_plus_trend_component_1_samplewise` construction used by Figure A1.
It is checksummed in the local artifact bundle but intentionally not registered
in `MANUSCRIPT_ASSET_MANIFEST.json`.

The compact posterior support CSV/RDS files used to render this gallery are not
persisted in the Overleaf-facing article repo. They remain workflow/runtime
source artifacts and are staged in a temporary directory by
`scripts/refresh_authoritative_selected_model_support_figures.py` during
refresh. This keeps the article repository focused on manuscript tables,
figures, and small provenance manifests.

## Current workflow evidence

### Figure-generation evidence

The workflow repo contains the following direct figure-generation references:
- authoritative current path:
  - `R/environmetrics/40_figures.R`
  - `scripts/run_environmetrics_figures.R`
  - `R/unified/stages/stage_post.R`
- legacy / historical references:
  - `scripts/make_environmetrics_figures.R`
  - `Environmetrics_Figures.ipynb`
  - `repro/extracted/Environmetrics_Figures__RECOVERED_WORKING.r`
- provenance / validation:
  - `repro/REPO_MAP.md`
  - `repro/REPRODUCE_PAPER.md`
  - `repro/gold_DISC_figures.sha256`

### Posterior-table export evidence

The workflow repo contains the following table-export infrastructure:
- `R/environmetrics/02_helpers_core.R`
- `R/unified/stages/stage_post.R`
- `R/unified/post_artifact_contract.R`
- `repro/UNIFIED_WORKFLOW_README.md`
- `tests/testthat/test_post_posterior_table_exports.R`

The documented post-stage outputs are:
- `gamma_summary.csv`
- `sigma_summary.csv`
- `covariate_effects_summary.csv`
- optional `.tex` snippets for the same summaries
- `posterior_table_exports_README.md`
- `posterior_table_exports_manifest.csv`

## Figure provenance map

### High-confidence, workflow-linked figures already matching the recorded gold outputs

The following manuscript figure assets in `Evironmetrics---REVISED-DOC-Corrected/figures/manuscript/` were hashed locally and match the workflow repo's `repro/gold_DISC_figures.sha256` exactly.

| Manuscript label | Current asset | Current manuscript role | Workflow evidence | Hash match | Repro status | Selected-run status | Recommended action |
|---|---|---|---|---|---|---|---|
| `fig:sanlorenzo` | `figures/manuscript/site_context_usgs.png` | study-setting figure | corrected cutoff-specific `v2` bundle built from the CRPS-linked `exAL-M-T1` source manifest and authoritative figure-input bundles; manuscript-facing copy promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/usgs.png`; current contract uses full `1987-05-29 -> cutoff` USGS history | yes | reproducible through validated `v2` workflow and frozen locally | representative `2022-12-25` support role; all five cutoff variants preserved | keep as representative setup/support figure with explicit cutoff-specific provenance |
| `fig:covariates` | `figures/manuscript/covariate_context_precip_soil_gdpc.png` | covariate setup figure | corrected `v2` bundle reads raw cutoff-specific `cov_01_PPT.csv` and `cov_02_SOIL.csv`, together with the canonical `GDPC1` master factor truncated to the cutoff; manuscript-facing copy is promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/...`; current contract uses the full `1987-05-29 -> cutoff` covariate history | yes | reproducible through validated `v2` workflow and frozen locally | representative `2022-12-25` support role; all five cutoff variants preserved | keep as representative setup/support figure with explicit cutoff-specific provenance |
| `fig:retrospectives` | `figures/manuscript/retrospective_products_context.png` | retrospective-product setup figure | corrected `v2` bundle reads authoritative retrospective lineage / bundle-native retrospective sources; manuscript-facing copy promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/...`; current contract uses the retrospective support actually available for the selected cutoff and records whether full history is present | yes | reproducible through validated `v2` workflow and frozen locally | representative `2022-12-25` support role; all five cutoff variants preserved | keep as representative setup/support figure with explicit cutoff-specific provenance |
| `fig:ensembles` | `figures/manuscript/forecast_products_context.png` | forecast-product setup figure | corrected `v2` bundle stages bundle-native forecast inputs through `forecats_plot_bundle.R`; manuscript-facing copy promoted from `artifacts/five_cutoff_setup_support/20221225_exal_m_t1/figures/...`; current contract uses a strict `cutoff - 28 days` to `cutoff + 28 days` display window | yes | reproducible through validated `v2` workflow and frozen locally | representative `2022-12-25` support role; advisor-facing cutoff-wide copies also live under `figures/forecast_context_by_cutoff/` | keep as representative setup/support figure with explicit cutoff-specific provenance |
| `fig:dry_quantile` | `figures/manuscript/historical_summary_dry_period.png` | historical regime illustration | current `2022-05-11 exAL-M-T1` full-history multivariate run rendered through `scripts/render_current_model_output_support_figures.R` and frozen locally in `artifacts/historical_support_from_current_models/` | yes | reproducible from current model outputs and frozen locally in the article repo | current-model historical-support figure outside the narrow five-run keep lineage | keep with explicit current-output support provenance |
| `fig:rainy_quantile` | `figures/manuscript/historical_summary_wet_period.png` | historical regime illustration | same as above; frozen locally in `artifacts/historical_support_from_current_models/` | yes | reproducible from current model outputs and frozen locally in the article repo | current-model historical-support figure outside the narrow five-run keep lineage | keep with explicit current-output support provenance |
| `fig:synth1` | `figures/manuscript/representative_synthesis_multivariate.png` | predictive synthesis illustration | verified representative rerun bundle in `artifacts/representative_selected_model_2022_12_25/` plus workflow-side replay validation | yes | reproducible from verified `2022-12-25 exAL-M-T1` rerun bundle and frozen locally | locked to representative `2022-12-25` selected-model run | keep synced to representative selected-model bundle |
| `fig:80_components` | `figures/manuscript/historical_component_80month.png` | appendix long-cycle seasonal illustration | current `2022-05-11 exAL-M-T1` full-history multivariate run rendered through `scripts/render_current_model_output_support_figures.R` and frozen locally in `artifacts/historical_support_from_current_models/` | yes | reproducible from current model outputs and frozen locally in the article repo | current-model historical-support figure outside the narrow five-run keep lineage | keep with explicit current-output support provenance |
| `fig:synth2` | `figures/manuscript/reference_synthesis_univariate.png` | appendix historical-only predictive synthesis | current `2022-12-25 exdqlm_univar` publication-style output bundle copied into `artifacts/historical_support_from_current_models/` | yes | reproducible from current model outputs and frozen locally in the article repo | current-model appendix support figure outside the narrow five-run keep lineage | keep with explicit current-output support provenance |

### Notes on figure confidence

1. The four setup/support figures are now reproduced through the corrected cutoff-specific `v2` workflow.
   - Workflow-side review:
     - `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/exal_m_t1_setup_support_by_cutoff_v2_20260516/review/`
   - Article-side mirror and review:
     - `artifacts/five_cutoff_setup_support/`
     - `reports/five_cutoff_setup_support_review/`
   - Representative manuscript promotion:
     - `reports/representative_setup_selection/selection_manifest.json`
   - This validated family covers:
     - `usgs.png`
     - `precip_soilmoisture_climatePC1_faceted_labeled.png`
     - `retrospective_log_discharge_plot_faceted.png`
     - `forecats.png`
   - The corrected `v2` contract is now:
     - `usgs.png` and the raw covariate figure use the full `1987-05-29 -> cutoff` daily history available in the selected-run shared inputs
     - `forecats.png` uses a strict `cutoff - 28 days` to `cutoff + 28 days` display window
     - the retrospective figure now uses repaired full-history retrospective support from `1987-05-29 -> cutoff` for all five cutoffs through the canonical `20260510` shared-input bundles
   - The full per-cutoff availability audit is recorded in:
     - `reports/five_cutoff_setup_support_review/SETUP_SUPPORT_BY_CUTOFF_V2_REVIEW.md`
   - The older `20260506` `v1` family has been removed from the article repo as part of the cleanup pass; only the canonical `v2` family remains.

2. `forecats.png` remains more delicate than the other setup figures, but the canonical `v2` path now stages bundle-native forecast inputs explicitly.
   - The workflow repo includes a dedicated reproducibility plan at:
     - `repro/FORECATS_INPUTS_AND_WEIGHTING_PLAN.md`
   - The corrected cutoff-specific derivation anchors that figure to the CRPS-linked `exAL-M-T1` source manifest and the authoritative forecats/histfix bundles instead of the older generic paper-level copy.

3. The dry/wet regime figures and the appendix long-cycle figure are now regenerated from current model outputs.
   - They are still outside the narrow five-run `exAL-M-T1` keep-run lineage used for the main benchmark table.
   - They are frozen locally in:
     - `artifacts/historical_support_from_current_models/`
   - Their role remains descriptive support:
     - current-model historical summaries of the fitted specification,
     - not representative-cutoff outputs,
     - and not a second forecast-validation exercise.

4. The older notebook/manual reproduction notes are now secondary.
   - `repro/REPRODUCE_PAPER.md` and `repro/REPO_MAP.md` remain useful provenance references.
   - But the clean current reproduction path is the run-scoped unified workflow:
     - `stage_post.R` injects the actual shared input paths,
     - `run_environmetrics_figures.R` runs headlessly,
     - `40_figures.R` generates the figures.

5. `fig:synth1` remains the representative selected-model synthesis figure tied to the `2022-12-25` rerun bundle.
   - `fig:synth2` is now refreshed from a current `exdqlm_univar` output bundle.
   - It remains outside the narrow five-run keep-lineage freeze used for the main benchmark table.

## Table provenance map

### Interpretation-dependent tables in the manuscript

| Manuscript label | Current manuscript role | Current provenance evidence | Confidence | Repro status | Selected-run status | Recommended action |
|---|---|---|---|---|---|---|
| `tab:benchmark_crps_models` | main five-cutoff forecast-validation table | HE2 publication manifest plus synchronized manuscript table values; local article-side snapshot in `artifacts/he2_publication_freeze/` | high | validated against the frozen HE2 publication source | main reference table | keep frozen until NDLM is canonical, AL multivariate families are complete, and the exAL benchmark rows are explicitly reconciled |
| `tab:components_23_31` | main-text covariate-effects summary | verified representative rerun export frozen locally in `artifacts/representative_selected_model_2022_12_25/covariate_effects_summary.csv`; workflow export contract and tests remain in repo | high | reproducible from verified `2022-12-25 exAL-M-T1` rerun bundle and frozen locally | locked to representative `2022-12-25` selected-model run | keep synced to representative selected-model bundle |
| `tab:gamma_sigma_intervals1` | supplementary appendix `gamma` summary | verified representative rerun export frozen locally in `artifacts/representative_selected_model_2022_12_25/gamma_summary.csv`; workflow export contract and tests remain in repo | high | reproducible from verified `2022-12-25 exAL-M-T1` rerun bundle and frozen locally | locked to representative `2022-12-25` support role | keep as supplementary appendix support |
| `tab:gamma_sigma_intervals2` | supplementary appendix `sigma` summary | verified representative rerun export frozen locally in `artifacts/representative_selected_model_2022_12_25/sigma_summary.csv`; workflow export contract and tests remain in repo | high | reproducible from verified `2022-12-25 exAL-M-T1` rerun bundle and frozen locally | locked to representative `2022-12-25` support role | keep as supplementary appendix support |

### Notes on table confidence

1. Table exports are better documented than they first appeared.
   - The workflow repo has a formal post-stage artifact contract.
   - Export helpers and tests are already in place.
   - The missing piece is the exact run-level linkage for the current manuscript tables.

2. `tab:components_23_31` is now locked to the representative `2022-12-25` selected-model rerun.
   - The manuscript and local provenance bundle now use the verified `covariate_effects_summary.csv` export from that run.

3. The appendix `gamma` and `sigma` tables are now explicitly treated as supplementary representative-cutoff support.
   - They are frozen locally from the same verified `2022-12-25` rerun bundle.
   - They are no longer described as central forecast-validation evidence.

## Provenance classification for the next phase

### Group A: keep as cutoff-specific setup/support figures
These are now reproduced through the corrected `v2` per-cutoff family derived from the verified five-run `exAL-M-T1` bundles and the authoritative forecats/histfix bundle roots.
- `fig:sanlorenzo`
- `fig:covariates`
- `fig:retrospectives`
- `fig:ensembles`

### Group B: keep as current-model appendix support
- `fig:synth2`

### Group C: selected-run dependent and must be refreshed or verified first
These are too tightly tied to one fitted output to leave ambiguous.
- `fig:synth1`
- `tab:components_23_31`

### Group D: reproducible current-model historical-support figures
These objects are intentionally kept as current-model historical summaries of the fitted specification, rather than as representative-cutoff outputs.
- `fig:dry_quantile`
- `fig:rainy_quantile`
- `fig:80_components`
- `tab:gamma_sigma_intervals1`
- `tab:gamma_sigma_intervals2`

## Locked provenance policy

The following policy is now adopted for the revised manuscript and should govern the regeneration work that follows.

### Section 4: forecast-validation evidence
- Section 4 remains the manuscript's five-cutoff forecast-validation evidence.
- Its benchmark values must continue to come from the validated five-cutoff `exdqlm_multivar_keep` / `exAL-M-T1` comparison workflow.
- Any rerun used to refresh those values must preserve the same configuration that produced the published CRPS table.

### Section 5: representative selected-model interpretation
- Section 5 will use one representative final cutoff of the selected specification.
- The representative cutoff is fixed as `2022-12-25`, because:
  - it is already the manuscript's current illustrative forecast origin,
  - a recent validated workflow run exists for it, and
  - that run already produces publication-facing cutoff-window synthesis artifacts.
- Therefore, the following Section 5 objects must be regenerated or re-verified from the `2022-12-25` `exdqlm_multivar_keep` run:
  - `fig:synth1`
  - `tab:components_23_31`

### Appendix: historical summaries of the selected specification
- Appendix figures and tables remain historical summaries of the selected specification rather than representative-cutoff illustrations.
- This applies to:
  - `fig:dry_quantile`
  - `fig:rainy_quantile`
  - `fig:80_components`
  - `tab:gamma_sigma_intervals1`
  - `tab:gamma_sigma_intervals2`
- The captions and nearby text should continue to say so clearly.
- For the three historical-summary figures, the current article-side provenance anchor is now:
  - `artifacts/historical_support_from_current_models/`
- The earlier article-local `historical_summary_sources` bundle was removed during cleanup once the current-output support family became the canonical manuscript-local freeze point.

## Recent selected-model workflow status

A recent validated family of selected-model runs exists under:
- `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/multimodel_v8_he2_exdqlm_multivar_keep_all_cutoffs_sharedspec_20260516/runs/`

For all five manuscript cutoffs, the corresponding `exdqlm_multivar_keep` runs:
- passed validation,
- passed deterministic-climate checks,
- use forecast precipitation after the cutoff,
- use forecast soil moisture after the cutoff,
- and keep the PCA/GDPC covariate in passthrough mode rather than forecasting it the same way.

These runs already provide:
- cutoff-window posterior-synthesis figures,
- cutoff-window quantile CSV exports,
- CRPS summary tables,
- and run-scoped manifests and input hashes.

Resolved gaps from this audit:
- the narrow `exAL-M-T1` replay path was completed with the required post-export fixes, so the representative selected-model outputs and posterior interpretation tables are now frozen locally in the revised article repo.
- the cutoff-dependent setup/support figures are now mirrored locally in the revised article repo through:
  - `artifacts/five_cutoff_setup_support/`
  - `reports/five_cutoff_setup_support_review/`
- the manuscript-facing `figures/manuscript/` copies for `fig:sanlorenzo`, `fig:covariates`, `fig:retrospectives`, and `fig:ensembles` are now promoted from the representative `20221225_exal_m_t1` `v2` bundle through:
  - `reports/representative_setup_selection/selection_manifest.json`
- the appendix historical-only reference synthesis and the historical-summary figures now share the current article-side provenance anchor:
  - `artifacts/historical_support_from_current_models/`
- In practice, this means:
  - `fig:synth1`, `tab:components_23_31`, `tab:gamma_sigma_intervals1`, and `tab:gamma_sigma_intervals2` are now locked to verified article-side bundles,
  - `fig:dry_quantile`, `fig:rainy_quantile`, `fig:80_components`, and `fig:synth2` are preserved through the canonical `current_model_output_support` family,
  - and the four setup/support figures are preserved through the validated `v2` cutoff family, while older article-side support families have been removed.

## Exact relaunch handoff

The high-level provenance inventory in this file is now paired with a run-level relaunch checklist:
- `docs/exal_m_t1_relaunch_checklist.md`

Use that companion file when:
- identifying the authoritative source run for a given cutoff,
- rerunning the selected specification associated with a published Table 1 CRPS value,
- verifying that the rerun reproduces the selected `exAL-M-T1` CRPS exactly,
- and checking whether the required figure and table artifacts were emitted.

## Current locked state

1. Section 4 remains the five-cutoff validation evidence.
   - `tab:benchmark_crps_models` is intentionally still synced to the frozen HE2 publication manifest and should not yet be promoted to a new rerun-backed benchmark source.

2. Section 5 uses outputs from one representative final cutoff of the selected `exAL-M-T1` specification.
   - `fig:synth1`
   - `tab:components_23_31`

3. The appendix support tables remain tied to the same representative cutoff, but in a supplementary role.
   - `tab:gamma_sigma_intervals1`
   - `tab:gamma_sigma_intervals2`

4. The historical-summary objects remain workflow-linked descriptive support and are frozen locally in the article repo.
   - `fig:dry_quantile`
   - `fig:rainy_quantile`
   - `fig:80_components`

5. The corrections letter is synchronized to the same provenance split and current benchmark table values.

## Audit status summary

### Established in this pass
- the benchmark table in the revised article is still aligned with the frozen HE2 publication manifest as a temporary hold state,
- the representative selected-model outputs are refreshed from verified `exAL-M-T1` sources,
- the appendix support tables are explicitly demoted to a supplementary role,
- the historical-summary figures are workflow-linked, hash-verified, and frozen locally in the revised article repo, and
- the corrections letter is synchronized to the current article-side provenance split.

### Remaining optional work
- further aesthetic or publication-quality refreshes of historical-summary figures, if ever desired, should be treated as optional figure-improvement work rather than as unresolved provenance work.
