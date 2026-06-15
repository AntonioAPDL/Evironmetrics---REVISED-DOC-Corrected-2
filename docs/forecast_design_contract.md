# Forecast Design Contract

This note documents the manuscript-facing HE-6 forecast-validation contract.

The revised article reports a five-cutoff rolling-origin out-of-sample
forecasting exercise. At each cutoff, fitting uses USGS observations and
retrospective products only through the cutoff. Forecast generation uses the
latest forecast products issued at or before the cutoff, together with the
forecast-window transfer covariates staged in the cutoff-specific support
bundle.

Post-cutoff USGS observations are reserved strictly for verification and are not
used to fit or update the predictive distributions. The local precipitation and
soil-moisture transfer covariates have forecast-window support in the staged
bundle. The workflow-facing `PCA` covariate is the canonical GDPC1 compatibility
alias; it is a deterministic climate-index covariate and is not treated as an
operational forecast product or verification target.

Machine-readable companion:

- `artifacts/forecast_design/forecast_design_manifest.json`
