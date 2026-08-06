# Forecast Design Contract

This note documents the manuscript-facing HE-6 forecast-validation contract.

The revised article reports a five-cutoff, rolling-origin forecast-window
evaluation. Each cutoff defines a version-consistent staged dataset: the model
uses only information available at that origin, fits seven quantile-specific
models, synthesizes the resulting posterior predictive distribution, and scores
that distribution against future USGS observations held out over the forecast
window. At each cutoff, fitting uses USGS observations and retrospective
products only through the cutoff. Forecast generation uses the latest forecast
products issued at or before the cutoff, together with the forecast-window
transfer covariates staged in the cutoff-specific support bundle.

The article does not claim a continuous daily post-2022 hindcast or a dense
grid of heavily overlapping origins. Constructing each fold requires a
version-consistent bundle of observations, retrospective products, forecast
products, and forecast-window covariates from large evolving gridded archives.
Because every retained origin requires data ingestion plus seven
quantile-specific fits followed by posterior predictive synthesis, a dense
origin grid would require a substantially larger data-ingestion and
computational campaign. Dense overlapping windows would also overrepresent
individual hydrological episodes. The retained folds therefore prioritize
archive-feasible, version-consistent, hydrologically contrasting forecast
origins.

Post-cutoff USGS observations are reserved strictly for verification and are not
used to fit or update the predictive distributions. In the forecast window, the
local precipitation and shallow soil-water transfer covariates are GEFS
ensemble-based covariates staged in the cutoff-specific origin bundle and
reduced to deterministic summaries before entering the model.
The workflow-facing `PCA` covariate is the canonical GDPC1 compatibility alias;
it is a deterministic climate-index covariate and is not treated as an
operational forecast product or verification target.

Precipitation is handled only as an external transfer covariate. The workflow
does not fit a separate censoring, zero-inflation, or occurrence/intensity model
for precipitation. Dry days remain in the supplied covariate path, and
precipitation intermittency enters through the transfer component and the
deterministic engineered terms recorded in the cutoff-specific support bundle.

Machine-readable companion:

- `artifacts/forecast_design/forecast_design_manifest.json`

The source-specific latest-issue selection rule for the forecast products is
documented separately in `docs/latest_forecast_issue_contract.md` and
`artifacts/latest_forecast_issue/latest_forecast_issue_manifest.json`.
