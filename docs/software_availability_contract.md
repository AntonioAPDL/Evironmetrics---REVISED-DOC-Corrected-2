# Software Availability Contract

Date: 2026-06-15

This document records the manuscript-side HE-5 reproducibility contract. The
companion machine-readable manifest is:

- `artifacts/software_availability/software_availability_manifest.json`

## Contract

The revised article uses a three-layer reproducibility model:

1. The reusable exDQLM estimation routines are available through the CRAN
   package `exdqlm`.
2. The study-specific forecasting workflow is available in the public workflow
   repository `https://github.com/AntonioAPDL/Project1`.
3. This article repository freezes manuscript-facing figures, tables, generated
   TeX fragments, and compact provenance artifacts.

The article repository is not meant to carry large runtime outputs or all raw
forecast archives. Applying the workflow to a new basin requires constructing a
basin-specific, version-consistent archive of observations, retrospective
products, forecast products, and covariates.

## Current Public Software Status

- CRAN package: `https://CRAN.R-project.org/package=exdqlm`
- Package DOI: `https://doi.org/10.32614/CRAN.package.exdqlm`
- Workflow repository: `https://github.com/AntonioAPDL/Project1`
- Workflow archive DOI: pending final revision freeze

The workflow repository also carries the public-facing release-readiness files
that will support the final archived release:

- `README.md`
- `CITATION.cff`
- `RELEASE_NOTES_PENDING_FINAL_ARCHIVE.md`
- `docs/workflow_archive_readiness_20260615.md`

These files document the current public repository state and the remaining final
archive steps. They do not replace the final archive DOI, which remains pending.

## Validation

The workflow repository validates this contract through:

- `scripts/validate_publication_freeze.py`
- `scripts/validate_revision_cross_repo_wiring.py`

Those validators check the article manuscript, corrections response, and
software availability manifest together.
