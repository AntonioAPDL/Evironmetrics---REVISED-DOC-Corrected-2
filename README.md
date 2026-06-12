# Revised Article Repository

This repository is the advisor-facing freeze of the revised manuscript, its manuscript-facing figures and tables, and the article-local artifact bundles used to regenerate them.

## Where to look first

- `wileyNJD-APA.tex`: manuscript source used by Overleaf
- `figures/manuscript/`: the exact figure files used by the manuscript
- `figures/forecast_context_by_cutoff/`: advisor-facing copies of the Figure 4 forecast-context view for all five cutoffs
- `figures/multivariate_synthesis_by_cutoff/`: advisor-facing Figure 7 family for all five cutoffs
- `figures/reference_synthesis_by_cutoff/`: advisor-facing Figure A2-style family for all five cutoffs
- `tables/generated_tex/`: the exact generated table blocks included by the manuscript
- `docs/figure_table_provenance.md`: figure/table provenance summary
- `reports/manuscript_asset_review/ARTICLE_ASSET_REVIEW.md`: review report for the current article assets
- `reports/manuscript_asset_review/FIGURE_POLISH_STATUS_AUDIT.md`: point-by-point status audit for the earlier figure-polish request
- `scripts/validate_manuscript_figure_paths.py`: validates that every `\includegraphics{}` call in the manuscript resolves through the canonical figure search paths

## Directory roles

- `figures/`: manuscript-facing figures, appendix cutoff panels, and advisor-facing cutoff-wide forecast/synthesis figure families
- `tables/`: generated TeX tables used by the manuscript
- `artifacts/`: frozen local bundles copied from validated workflow outputs
- `reports/`: review reports, galleries, audits, and selection manifests
- `docs/`: advisor-facing documentation and provenance notes
- `scripts/`: refresh and audit scripts used to rebuild the article-side bundles

## Standard refresh command

```bash
python3 scripts/refresh_all_generated_assets.py
```

The refresh path now includes a figure-path validation step. The manuscript keeps
the lowercase `figures/` tree as canonical, while `wileyNJD-APA.tex` also
accepts the legacy uppercase `Figures/` tree as a compile-time fallback for
Overleaf Git-sync compatibility.

## Overleaf sync recovery

Overleaf can create `overleaf-*` branches that delete generated publication
assets under `figures/`, `Figures/`, `artifacts/`, or `tables/generated_tex/`.
Those deletion-only branches are not manuscript edits and should not be accepted
into `main`.

When Overleaf reports that GitHub and Overleaf could not automatically merge,
first audit the branch from this repo:

```bash
python3 scripts/merge_overleaf_branch_preserving_generated_assets.py --fetch origin/overleaf-YYYY-MM-DD-HHMM
```

If the audit reports no TeX/Bib source edits and only protected generated-asset
changes, merge it with:

```bash
python3 scripts/merge_overleaf_branch_preserving_generated_assets.py origin/overleaf-YYYY-MM-DD-HHMM --merge-generated-deletions-only
git push origin main
```

If real TeX/Bib source edits are present, merge them normally, but keep
generated article assets from `main` unless the workflow-side refresh scripts are
deliberately regenerating them.

## Standard compile command

```bash
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
bibtex output
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
pdflatex -interaction=nonstopmode -halt-on-error -jobname=output wileyNJD-APA.tex
```
