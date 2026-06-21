# Pro Design Audit Response, 2026-06-20

This note records the follow-up pass based on the external design audit of the
current ISBA 2026 poster source. The goal of the pass was to improve poster
hierarchy and visual polish without changing the scientific lock.

## Adopted

- Changed the title to sentence case:
  `Dynamic Bayesian quantile synthesis for medium-range river-flow forecasting`.
- Made the header metadata unboxed and right-aligned.
- Added the claim eyebrow `HELD-OUT DISTRIBUTIONAL ACCURACY`.
- Replaced numbered section badges with semantic section labels.
- Increased poster-scale typography modestly across titles, body, captions, and
  footer text.
- Increased the center column width and enlarged the main 28-day CRPS evidence.
- Reduced repeated result language by keeping one top claim and one concise
  result/exception box under the main CRPS figure.
- Simplified the bottom area into a single conclusion band plus footer.
- Simplified the logo strip to product/source marks plus UCSC text, avoiding an
  overfilled seal row.
- Removed visible active-screening and frozen-manuscript management language
  from the conference-facing poster surface.
- Regenerated the poster CRPS figures with audience-facing captions.

## Deferred

- Did not add a compact model equation. The audit correctly notes that a
  statistical audience may appreciate it, but it should only be added after the
  exact manuscript notation is verified against the revised article source.
- Did not promote any active screening result. The current poster remains tied
  to the authoritative article-facing outputs.

## Verification Standard

Before committing this pass, rebuild the poster with pdfLaTeX, confirm it is one
A0 portrait page, scan the rendered text for prohibited claims or internal
workflow language, and inspect the rendered preview for logo visibility and
layout balance.
