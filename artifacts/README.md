# Article Artifacts

These folders are the article-side frozen artifact bundles that feed the manuscript figures, tables, and supporting audits.

| Artifact family | Description | Files | PNGs | README | Review entrypoints |
|---|---|---:|---:|---|---|
| `five_cutoff_crps_validation_sources` | Five-cutoff CRPS validation freeze used by the benchmark table. | 18 | 0 | yes | `README.md` |
| `five_cutoff_main_model_synthesis` | Corrected cutoff-wide Figure 7 family copied from the five-cutoff he2pubgdpc1r1 exAL main-model reruns. | 56 | 10 | yes | `README.md` |
| `five_cutoff_reference_synthesis` | Cutoff-wide Figure A2-style reference synthesis family copied from the current exdqlm_univar output bundles. | 56 | 10 | yes | `README.md` |
| `five_cutoff_setup_support` | Canonical five-cutoff setup/support figure family mirrored from the validated workflow runtime bundle. | 84 | 20 | yes | `review/gallery.html | README.md` |
| `he2_historical_support_audit` | Workflow-side audit snapshot showing which publication rows use full historical support versus short-window support. | 5 | 0 | yes | `README.md` |
| `he2_publication_freeze` | Frozen local snapshot of the current HE2 Bayesian publication manifest and alignment tables. | 10 | 0 | yes | `README.md` |
| `he3_exdqlm_ablation_authoritative` | Artifact bundle. | 11 | 0 | yes | `README.md` |
| `he4_quantile_check_loss_current_publication` | Artifact bundle. | 7 | 0 | no | `` |
| `historical_support_from_current_models` | Current-model historical-support figures used by manuscript Figures 5, 6, A1, and A2. | 15 | 5 | yes | `README.md` |
| `representative_selected_model_2022_12_25` | Representative selected-model bundle for the verified 2022-12-25 exAL-M-T1 rerun. | 27 | 4 | yes | `README.md` |

Preferred refresh entrypoint:
- `scripts/refresh_all_generated_assets.py`
