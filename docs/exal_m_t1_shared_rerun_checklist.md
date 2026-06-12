# exAL-M-T1 Shared Rerun Checklist

Date: 2026-05-17

## Purpose

This note records the completed shared-spec `exAL-M-T1` relaunch that now underpins the
current revised-article refresh state.

It does not replace the already-frozen publication-state provenance in:
- `docs/exal_m_t1_relaunch_checklist.md`
- `docs/exal_m_t1_artifact_run_map.md`

Instead, it records the rerun/update contract that was used to replace the older
`20260512` article-facing bundles with the completed `20260516` shared-spec refresh.

Primary workflow-side plan:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/HE2_EXDQLM_MULTIVAR_KEEP_SHARED_RELAUNCH_PLAN_20260516.md`

Primary workflow-side shared-spec report:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/reports/he2_exdqlm_multivar_keep_shared_relaunch_plan_20260516/HE2_EXDQLM_MULTIVAR_KEEP_SHARED_RELAUNCH_PLAN_20260516.md`

## Current article status

Right now the revised article is wired to the completed `20260516` shared-spec rerun for:

1. the five-cutoff CRPS validation freeze
2. the representative selected-model bundle
3. the five-cutoff multivariate synthesis family
4. the five-cutoff reference synthesis family
5. the corrected setup/support/context families

The one remaining article-side exception is:

1. `artifacts/historical_support_from_current_models/`
   - still blocked because the renderer expects retained multivariate fit artifacts that are not exported by the completed workflow roots

## Locked shared rerun spec

The next relaunch is planned around a single shared `exAL-M-T1` spec:

| Contract item | Locked choice |
|---|---|
| family | `exdqlm_multivar_keep` |
| cutoffs | `20210123`, `20211112`, `20211221`, `20220511`, `20221225` |
| retros / USGS window | `1987-05-29 -> cutoff` |
| shared bundle lineage | `multimodel_v8_he2_publication_shared_inputs_20260510` |
| bundle run id | `20260510_publication_shared_r01` |
| deterministic blended covariates | `PPT`, `SOIL` |
| climate factor alias | `PCA` backed by canonical `GDPC1` |
| shared `epsilon` | `30.0` |
| shared `c_factor` | `1.0` |
| shared discount set | `set10_manual_20260516` |
| shared discount values | `df_t=0.99999999`, `df_s1=df_s2=df_s67=df_discrep=0.99999`, `lambda=0.97`, `df_trans=df_covs=0.9999999` |
| shared q50 stabilization | `freeze_target=states`, `hold_after_guard=0`, blend `0.5/0.5`, step caps `0.15/0.25`, `fail_fast` guard |
| runtime contract | row queue serial, `7` quantile jobs in parallel, one core per quantile job, thread caps pinned to `1` |

## Figure / table families refreshed from the rerun

These are the article-side bundles refreshed from the completed shared rerun outputs:

| Article family | Role | Refresh stage |
|---|---|---|
| `artifacts/five_cutoff_crps_validation_sources/` | Table 1 CRPS source freeze | refreshed from `20260516` keep root |
| `artifacts/representative_selected_model_2022_12_25/` | representative Section 5 bundle | refreshed from `20260516` keep root |
| `artifacts/five_cutoff_setup_support/` | cutoff-specific setup/input/support figures | refreshed |
| `figures/forecast_context_by_cutoff/` | all-cutoff forecast-window context figures | refreshed |
| `figures/multivariate_synthesis_by_cutoff/` | all-cutoff main-model synthesis figures | refreshed from `20260516` keep root |
| `figures/reference_synthesis_by_cutoff/` | all-cutoff reference synthesis figures | refreshed from `20260516` univar root |
| `artifacts/historical_support_from_current_models/` | historical support figures | still blocked pending retained-artifact contract |

## Staged execution schedule

### Stage A: no-launch validation

The workflow repo must first complete:
- shared-spec config build
- prelaunch validator
- representative q50/q65 execution smokes

No article assets should be refreshed from the planned shared runtime root before this stage passes.

### Stage B: relaunch execution

The workflow repo then performs:
1. canary relaunch rows
2. full five-cutoff relaunch
3. row-level `fit`, `post`, `validate`, `report` checks

### Stage C: article refresh

After Stage B passed, the revised-doc repo refreshed:
1. five-cutoff CRPS freeze
2. representative selected-model bundle
3. setup/support by cutoff
4. forecast-context by cutoff
5. multivariate synthesis by cutoff
6. reference synthesis by cutoff
7. manuscript figure/table review manifests

Preferred refresh entrypoint after the rerun completes:

```bash
python3 scripts/refresh_all_generated_assets.py
```

### Stage D: Remaining follow-up

The remaining work after the shared-spec refresh is:
1. resolve the retained-artifact contract for `artifacts/historical_support_from_current_models/`
2. keep the article-side provenance docs aligned with the refreshed `20260516` source roots
3. commit/push the revised-doc bundle updates
4. pull into Overleaf

## Operator rule

Current operator rule:

- treat `docs/exal_m_t1_artifact_run_map.md` and `docs/figure_table_provenance.md` as the current article provenance anchor
- treat this file as the shared-rerun execution record plus the outstanding historical-support follow-up
