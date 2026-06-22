# Design audit response, 2026-06-22

Scope: response to the external ISBA 2026 poster design audit supplied during
the Sumi Minimal poster pass.

## Adopted

- Refined the Sumi Minimal palette to v1.1 and propagated the same defaults to
  the poster figure-generation script.
- Rebalanced the section-heading hierarchy so the informative heading is
  dominant and the uppercase kicker functions as a smaller category label.
- Reduced the visual weight of callout boxes, figure frames, section rules, and
  the top accent bar.
- Reserved selected-model plum for exDQLM/output/result emphasis rather than
  generic bullets or generic question framing.
- Corrected the workflow diagram so the synthesized predictive distribution
  and held-out USGS verification both feed the CRPS score.
- Increased the smallest workflow-diagram text and simplified its arrow logic.
- Replaced the seven-line manuscript-style model display with a compact
  poster-readable set of channel, state, and transfer equations that preserve
  the article notation.
- Shortened the inference explanation and foregrounded the DQLM/exDQLM
  computational distinction.
- Reframed the main result and takeaways around the exact four-of-five CRPS
  claim and the named 2022-12-25 DQLM exception.
- Added a robust QR fallback for both repository-root and poster-directory
  compilation contexts.

## Deferred intentionally

- Did not shrink the UCSC seal to the audit's proposed 8.5 cm because the
  current poster direction intentionally uses the university mark as a strong
  top-right affiliation anchor.
- Did not remove the source/product logos from the left body section because
  the current design goal is to keep the data-product provenance visible near
  the problem statement.
- Did not add a separate header-level `4/5` banner because a prior poster pass
  removed that banner and the current result block now carries the exact claim.
- Did not change the equal center/right column allocation because recent layout
  work intentionally enlarged the right-column examples and diagnostics.

## Validation contract

After this pass, regenerate poster-specific figures, compile `poster.tex`
twice with `pdflatex`, confirm the PDF remains a single A0 page, inspect full
page and section crops, and reject the build if the log reports fatal errors or
new overfull boxes.
