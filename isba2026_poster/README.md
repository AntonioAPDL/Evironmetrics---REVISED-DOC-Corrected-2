# ISBA 2026 Poster

Poster sources:

- `isba2026_poster/poster.tex`: standard source, compact and conservative.
- `isba2026_poster/poster_high_aesthetic.tex`: more designed source with
  optional Lato/Raleway/QR support and robust fallbacks.

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

Local build from the revised article repo root:

```bash
Rscript isba2026_poster/scripts/build_poster_figures.R
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster isba2026_poster/poster.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=isba2026_poster isba2026_poster/poster.tex
```

`poster.tex` also supports LuaLaTeX/XeLaTeX through the theme fallback, but
pdfLaTeX is the verified Overleaf-safe path. The high-aesthetic source should
also be compiled with pdfLaTeX.

The poster-specific CRPS and timeline figures are generated from the frozen
manuscript tables in `tables/generated_tex/`. Do not hand-edit the derived CSV
or numerical plot values unless the corresponding frozen article artifacts have
been formally replaced.

Current scientific lock:

- Use frozen article outputs as of 2026-06-19.
- Do not include active overnight-screen results unless a future replacement is
  formally promoted through the workflow, revised article repo, and corrections
  repo.
