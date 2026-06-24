# ISBA 2026 Poster

Poster source:

- `isba2026_poster/poster.tex`: unified main poster source for Overleaf.
- `isba2026_poster/poster.pdf`: tracked rendered PDF kept in sync with the
  canonical source for GitHub/Overleaf comparison.

Current poster title:

- `Bayesian quantile-based correction and synthesis of climate products`

Current evidence narrative:

- correction-before-synthesis framing in the opening question;
- main 28-day result stated as selected exDQLM having the lowest mean CRPS at
  all five rolling origins under the refreshed HE2 publication authority;
- separate NWS horizon-matched check over common days 1--8.

Recommended Overleaf setting:

- Main file: `isba2026_poster/poster.tex`
- Compiler: pdfLaTeX
- Output: one-page A0 portrait PDF

The source includes graphics paths for both common Overleaf modes:

- compiling from the project root with main file `isba2026_poster/poster.tex`;
- compiling after opening/setting `poster.tex` from inside the `isba2026_poster/`
  folder.

The representative 2022-12-25 synthesis PNG is copied into
`isba2026_poster/figures/frozen/` so the poster folder can compile without
depending on article-level figure directories.

The poster source also includes a compact source/affiliation logo strip using
pdfLaTeX-ready PNG assets under `isba2026_poster/assets/logos/`.

Local build from the revised article repo root:

```bash
Rscript isba2026_poster/scripts/build_poster_figures.R
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster isba2026_poster/poster.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster isba2026_poster/poster.tex
```

`poster.tex` also supports LuaLaTeX/XeLaTeX through the theme fallback, but
pdfLaTeX is the verified Overleaf-safe path.

The poster-specific CRPS and timeline figures are generated from the frozen
manuscript tables in `tables/generated_tex/`. Do not hand-edit the derived CSV
or numerical plot values unless the corresponding frozen article artifacts have
been formally replaced.

Latest local validation:

- 2026-06-23 current-authority refresh compiled with pdfLaTeX twice.
- `poster.pdf` verified as one A0 portrait page.
- No fatal, undefined-control-sequence, or overfull LaTeX errors were present in
  the final log; remaining underfull boxes are from narrow poster text columns,
  and embedded-PDF page-group warnings are benign.
- Visual crops were inspected for the header/question area, right column, and
  footer.

Current scientific lock:

- Use refreshed HE2 publication-authority outputs as of 2026-06-23.
- Do not include active or partial screening results unless a future replacement
  is formally promoted through the workflow, revised article repo, and
  corrections repo.
- Future authority refreshes should follow the workflow runbook:
  `/data/muscat_data/jaguir26/project1_ucsc_phd/docs/current_authority_refresh_runbook.md`.
  Rebuild poster figures/PDF only after the article freeze and generated tables
  have been refreshed from the promoted HE2 manifest.
