# Audience-Facing Model Revision, 2026-06-20

This note records the poster revision that shifts the surface from internal
model shorthand toward audience-facing scientific language. It was superseded
in part by the 2026-06-21 evidence-narrative polish recorded in
`claim_checklist.md` and `README.md`.

## Adopted Changes

- Retitled the poster as:
  `Bayesian quantile correction and synthesis for climate products`.
- Moved the UCSC seal into the header as the institutional anchor.
- Moved USGS, ECMWF/GloFAS, and NOAA/NWS logos into the problem/data-source
  panel where the products are introduced.
- Removed `exAL-M-T1` and `AL-M-T1` from audience-facing score-figure labels.
  The rendered poster now uses `Selected model`, `AL synthesis`, `GloFAS`, and
  `NWS` labels.
- Replaced the compact local-code specification block with model and inference
  explanation:
  - Dynamic Quantile Linear Model (DQLM) lanes at seven quantile levels.
  - Mean-field variational Bayes (MFVB) for scalable posterior approximation.
  - Variational Bayes with Laplace--Delta approximations (VB-LD) for
    non-conjugate extended-likelihood updates.
  - Priors/evolution summarized through diffuse scale/skewness priors, Gaussian
    initial states, and component discounting.
- Added the `historical_component_80month.png` diagnostic from the authoritative
  manuscript figure set to show that the selected model supports retrospective
  dynamic component interpretation, not only forecast correction.
- Replaced the earlier observation-only comparison emphasis with the scoped
  main evidence statement: source-aware exAL has the lowest mean 28-day CRPS at
  four of five origins, while AL-M-T1 is lowest at 2022-12-25.
- Added an expert-facing expanded model-expression panel under the schematic,
  using the revised article's observed-measurement, retrospective-product,
  forecast-product, trend/seasonal, discrepancy, transfer, and covariate-effect
  equations rather than the compact stacked representation.

## Claim Governance

- The poster still uses only article-facing frozen/authoritative results.
- Active screening results are not included.
- The 2022-12-25 exception remains explicit.
- NWS remains restricted to the horizon-matched 1--8 day comparison.

## Build/Asset Notes

- `poster.tex` now resolves manuscript figures from both `Figures/manuscript/`
  and `../Figures/manuscript/` so the component diagnostic works whether
  compiling from the repo root or from `isba2026_poster/`.
- Product logos are still included only as source identifiers; the footer keeps
  the no-endorsement disclaimer.
