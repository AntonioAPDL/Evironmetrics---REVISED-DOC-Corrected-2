# Input Alignment Audit

This audit summarizes the selected-run input alignment assumptions for the cutoff-specific setup/support family mirrored into the article repo.

## What this family represents

- `usgs.png` documents the cutoff-specific USGS history carried by the selected-run shared inputs, while the covariate figure combines cutoff-specific PPT/SOIL histories with the canonical master GDPC factor sliced to the cutoff.
- `retrospective_log_discharge_plot_faceted.png` documents the retrospective support actually available to the selected run for that cutoff.
- `forecats.png` documents the short forecast-context window tied to the selected forecast products.

## Cutoff summary

| Cutoff | Bundle class | Requested history | Retros available from | Full retrospective history available? | Flow display scale |
|---|---|---|---|---|---|
| 2021-01-23 | `histfix_long_history_bundle` | 1987-05-29 to 2021-01-23 | 1987-05-29 | True | log1p_cms |
| 2021-11-12 | `histfix_long_history_bundle` | 1987-05-29 to 2021-11-12 | 1987-05-29 | True | log1p_cms |
| 2021-12-21 | `histfix_long_history_bundle` | 1987-05-29 to 2021-12-21 | 1987-05-29 | True | log1p_cms |
| 2022-05-11 | `histfix_long_history_bundle` | 1987-05-29 to 2022-05-11 | 1987-05-29 | True | log1p_cms |
| 2022-12-25 | `histfix_long_history_bundle` | 1987-05-29 to 2022-12-25 | 1987-05-29 | True | log1p_cms |

## Interpretation

- The five-cutoff artifact bundle is copied directly from the validated workflow runtime family preserved under `artifacts/five_cutoff_setup_support/`.
- For `2021-01-23`, `2021-11-12`, and `2022-12-25`, the selected retrospective support is genuinely short-window, so a full-history retrospective panel would no longer be the same figure class.
- For `2021-12-21` and `2022-05-11`, the retrospective support is full-history within the mirrored cutoff-specific bundle.
- All flow figures in this family now use the article display contract `log1p_cms`.
