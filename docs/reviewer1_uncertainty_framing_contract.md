# Reviewer 1 Uncertainty-Framing Contract

This note documents the manuscript-facing contract for Reviewer 1 major comment
1.

The revised article distinguishes hydrological uncertainty from
meteorological/input uncertainty before introducing the Bayesian framework.
Hydrological uncertainty is tied to river-system model structure, parameters,
states, and observations. Meteorological/input uncertainty is tied to
precipitation and related atmospheric forcing fields. The data-source section
therefore describes precipitation and soil moisture as local
hydrometeorological covariates rather than as purely hydrological covariates.

The corresponding workflow validator is
`scripts/reviewer1_uncertainty_contract.py` in the workflow repository. It
checks that the revised article and corrections response keep this uncertainty
framing and do not reintroduce stale wording from the original manuscript or the
reviewer comment.
