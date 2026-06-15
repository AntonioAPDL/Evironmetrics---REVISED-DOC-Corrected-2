# Forecast Design Contract

This note documents the manuscript-facing HE-6 forecast-validation contract.

The revised article reports a five-cutoff rolling-origin out-of-sample
forecasting exercise. This is the time-ordered analogue of cross-validation for
the operational forecasting problem: each fold fixes a forecast origin, uses
only information available at that origin, and scores the resulting predictive
distribution against future USGS observations. At each cutoff, fitting uses
USGS observations and retrospective products only through the cutoff. Forecast
generation uses the latest forecast products issued at or before the cutoff,
together with the forecast-window transfer covariates staged in the
cutoff-specific support bundle.

The article does not claim a continuous daily post-2022 hindcast or a dense
grid of heavily overlapping origins. The retained folds are constrained by
version-consistent forecast archives, and dense overlapping forecast windows
would overrepresent individual hydrological episodes.

Post-cutoff USGS observations are reserved strictly for verification and are not
used to fit or update the predictive distributions. The local precipitation and
soil-moisture transfer covariates have forecast-window support in the staged
bundle. The workflow-facing `PCA` covariate is the canonical GDPC1 compatibility
alias; it is a deterministic climate-index covariate and is not treated as an
operational forecast product or verification target.

Machine-readable companion:

- `artifacts/forecast_design/forecast_design_manifest.json`

The source-specific latest-issue selection rule for the forecast products is
documented separately in `docs/latest_forecast_issue_contract.md` and
`artifacts/latest_forecast_issue/latest_forecast_issue_manifest.json`.
