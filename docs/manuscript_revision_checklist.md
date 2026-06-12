# Manuscript Revision Checklist

Purpose: organize the article rewrite so it stays aligned with the current rebuttal letter in `Corrections---Project-1` and can be executed one item at a time without losing track of dependencies.

Status at creation:
- Manuscript repo: `/data/muscat_data/jaguir26/Environmetrics_paper_repo`
- Main article file: `wileyNJD-APA.tex`
- Current manuscript HEAD: `26e8a7f`
- Rebuttal repo: `/data/muscat_data/jaguir26/Corrections---Project-1`
- Current rebuttal HEAD: `2bbcd39`
- Rebuttal internal TODO block: `Corrections---Project-1/main.tex:96-120`

Important guardrails:
- Do not edit the manuscript blindly. Every substantive manuscript change should remain consistent with the current rebuttal wording.
- If the manuscript strategy changes materially, re-check the corresponding rebuttal response before final submission.
- Keep a distinction between:
  - analyses/results already completed,
  - manuscript exposition/organization still to be rewritten.
- Do not delete important material before deciding where it will reappear in the revised paper.

---

## 0. Current exAL-M-T1 refresh checkpoint

This is the active manuscript-side rerender target for the revised article.

- The narrow `exAL-M-T1` replay path is now verified across all five publication cutoffs:
  - `01/23/2021`
  - `11/12/2021`
  - `12/21/2021`
  - `05/11/2022`
  - `12/25/2022`
- The representative `2022-12-25` rerun reproduces the published HE2 CRPS value to rounding and emits:
  - synthesis figures
  - quantile/sample exports
  - `covariate_effects_summary`
  - `gamma_summary`
  - `sigma_summary`
- The article-side five-run freeze is preserved under:
  - `artifacts/five_cutoff_crps_validation_sources/`
- Do not refresh `Evironmetrics---REVISED-DOC-Corrected` figures or tables from any older side-work roots when the five-run verified lineage is the intended source.

### 0.1 Setup/support figure correction checkpoint

The corrected cutoff-specific setup/support family is now:
- `artifacts/five_cutoff_setup_support/`
- `reports/five_cutoff_setup_support_review/`

Current corrected `v2` plotting contract:
- `usgs.png` uses the full `1987-05-29 -> cutoff` USGS history available to the selected-run shared inputs, while `precip_soilmoisture_climatePC1_faceted_labeled.png` now combines cutoff-specific PPT/SOIL histories with the canonical GDPC master factor sliced to the cutoff
- `forecats.png` uses a strict `cutoff - 28 days` to `cutoff + 28 days` display window
- `retrospective_log_discharge_plot_faceted.png` uses the retrospective support actually available for the cutoff-specific bundle, with per-cutoff availability recorded in `reports/five_cutoff_setup_support_review/SETUP_SUPPORT_BY_CUTOFF_V2_REVIEW.md`

It is built from the validated `v2` workflow:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_BY_CUTOFF_V2_WORKFLOW.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_SOURCE_MANIFEST.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_FILE_PLAN.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_ACCEPTANCE_CHECKLIST.md`

The older setup/support family:
- `artifacts/setup_support_by_cutoff/`
- `artifacts/setup_support_by_cutoff_review/`

has been removed from the article repo during the cleanup pass; only the canonical `v2` family remains in the current article contract.

### 0.2 Generated-asset organization checkpoint

The revised article repo is now the manuscript-local freeze point for generated asset families under:
- `artifacts/`

Current generated-asset index:
- `artifacts/README.md`
- `artifacts/artifact_inventory.csv`

Current canonical article-side generated families:
- `artifacts/representative_selected_model_2022_12_25/`
- `artifacts/five_cutoff_crps_validation_sources/`
- `artifacts/historical_support_from_current_models/`
- `artifacts/five_cutoff_setup_support/`
- `figures/appendix_cutoff_panels/`
- `figures/forecast_context_by_cutoff/`
- `tables/generated_tex/`

Preferred article-side refresh command:
- `python3 scripts/refresh_all_generated_assets.py`

That command should be treated as the standard way to refresh article-side bundles before any figure/table promotion into `figures/manuscript/`. It now also re-applies the cleanup step that removes stale `figures/manuscript/` files and obsolete article-side figure families.

The revised article appendix can now also draw from:
- `figures/appendix_cutoff_panels/`

This family contains appendix-ready composite panels for the cutoff-specific setup/support figures and is refreshed automatically through the same top-level command.

Advisor-facing cutoff-wide copies of the Figure 4 forecast-context view are also refreshed automatically under:
- `figures/forecast_context_by_cutoff/`

### 0.3 Forward repair checkpoint

The current publication state and the future corrected full-history rerun state must stay separate until we intentionally update them.

Forward repair planning documents:
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/HE2_FULL_HISTORY_REPAIR_FORWARD_PLAN.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/CANONICAL_GDPC_MASTER_COVARIATE_REPORT_20260509.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/CANONICAL_GDPC_IMPLEMENTATION_TRACKER_20260509.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/CANONICAL_GDPC_SOURCE_PIPELINE_RUNBOOK_20260509.md`
- `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/CANONICAL_GDPC_MASTER_PIPELINE_RUNBOOK_20260509.md`
- `artifacts/he2_historical_support_audit/historical_support_audit.md`

Important future TODOs now explicitly tracked:
- canonical GDPC master-covariate reproducibility hardening
- full-history bundle reconstruction for `2021-01-23`, `2021-11-12`, and `2022-12-25`
- corrected reruns for the affected Bayesian publication rows only after the bundle contract is rebuilt

Current canonical GDPC decision snapshot:
- use the full 17 daily climate indices over `1987-05-29 -> 2023-01-22`
- standardize each index over that canonical window
- keep the standardized daily series in levels for GDPC
- do not difference or detrend them before fitting the canonical `GDPC1`
- use fixed lag `k = 2`, `tol = 1e-3`, `niter_max = 200`, and criterion label `BIC`
- orient the final `GDPC1` so it has positive correlation with `oni`
- bounded simple screening over `k in {1, 2, 3}` selected `k = 2`; `k = 3` timed out under the `900` second cap

---

## 1. Source-of-truth crosswalk

### Rebuttal commitments that already drive the manuscript rewrite
- `HE-1`: add computational cost, refitting, and operational feasibility.
- `HE-2`: rebuild forecast validation around five version-consistent rolling-origin cutoffs; compare against simpler Bayesian alternatives and raw forecast products.
- `HE-3`: add an ablation study for the best model.
- `HE-4`: report CRPS plus targeted quantile diagnostics.
- `HE-5`: clarify code/reproducibility availability.
- `HE-6`: clarify what is fit-time information vs forecast-time inputs vs verification data.
- `HE-7`: latest-forecast-only protocol.
- `R1-M1`: separate meteorological vs hydrological uncertainty in the motivation.
- `R1-M2`: link model formulation to results more directly.
- `R1-M3`: reduce mathematical detail; remove PIT development from the main text; shorten posterior predictive synthesis exposition.
- `R1-M4`: expanded forecast evidence beyond one event.
- `R1-M5`: make the rolling-origin evaluation/cross-validation logic explicit.
- `R1-m1` to `R1-m9`: wording, organization, data-role clarity, table-caption fixes, and figure-interpretation clarifications.

### Remaining open rebuttal TODOs that must be respected while revising the manuscript
From `Corrections---Project-1/main.tex:96-120`:
- `HE-2`: justify why only five cutoffs were retained after archive/version screening; pending Raquel.
- `HE-3` / `HE-4`: optional exact section-number references later.
- `HE-6`: mirror the forecast-input timing clarification explicitly in the manuscript, and possibly move it earlier.
- `R1-M1`, `R1-M2`, `R1-M3`: recheck after the manuscript structure is rewritten.
- `R1-m4`, `R1-m7`, `R1-m9`: recheck after final section/figure decisions.

---

## 2. Current manuscript areas that clearly require revision

### Introduction
Current location:
- `wileyNJD-APA.tex:58-76`

Main issues already acknowledged in the rebuttal:
- mixes meteorological and hydrological uncertainty too early
- overemphasizes ensemble-generation details relative to the actual paper contribution
- still frames part of the contribution too broadly as dynamical error correction

### Methodology
Current location:
- `wileyNJD-APA.tex:78-245`

Main issues already acknowledged:
- PIT discussion is too long and should be removed from the main text (`216-245`)
- posterior predictive synthesis section is too long and too technical (`540-610`)
- quantile-crossing correction is developed at dissertation-level detail, even though no crossing occurs in the application

### Forecasting / application / results section
Current location:
- `wileyNJD-APA.tex:247-610`

Main issues already acknowledged:
- Section title and organization still mix data/application setup, model specification, historical fit, and forecasting results
- current paper still contains the old single-event framing and weighted multi-issuance forecast aggregation (`293-300`)
- `General Results` heading is too vague (`350`)
- current figure pair (`fig:synth1`, `fig:synth2`) still reflects the old illustrative setup and may need replacement or reframing

### Conclusions
Current location:
- `wileyNJD-APA.tex:612-623`

Main issues already acknowledged:
- needs to match the revised forecasting emphasis
- should not rely on claims that are tied only to the old single-cutoff presentation
- should reflect the final protocol and the forecasting-validation evidence actually retained in the manuscript

---

## 3. Writing standard for all manuscript changes

This section is the default style guide for every manuscript edit. If a later change is unclear, return here first.

### 3.1 Target voice
- Neutral, factual, and submission-ready.
- Clear enough for a statistically trained reader who is not an expert in the local forecast archive.
- Professional and restrained: no sales language, no rebuttal-letter tone, no internal workflow narration.
- Readable across statistics and hydrology audiences.

### 3.2 What the current manuscript already does well
- It has a technically serious core and usually names the modeled objects precisely.
- It gives the reader real hydrological context rather than presenting the paper as a purely abstract methods exercise.
- It includes concrete quantitative material that can support a strong final paper once the exposition is tightened.

### 3.3 Main tone/style problems in the current draft
- The introduction is too expansive and repeatedly uses broad “importance/challenge” language before reaching the actual contribution.
- Some sections sound more like dissertation exposition than article exposition.
- Several paragraphs do too many jobs at once: motivation, background, justification, and contribution all in one block.
- Some language is more promotional than evidentiary, especially around novelty, interpretability, and practical value.
- Some manuscript text still contains operational or local-audit detail that is more appropriate for internal validation notes, supplementary documentation, or the rebuttal letter than for the main paper.
- The results section mixes forecasting evidence with descriptive or historical interpretation in a way that obscures what is truly out-of-sample.
- Certain terms are not yet used with full consistency across the paper.

### 3.4 Core writing rules

#### A. Prefer factual claims over rhetorical framing
Use:
- direct statements of what the paper does
- direct statements of what the data show
- direct statements of what changed in the modeling or evaluation setup

Avoid:
- inflated importance language unless it is genuinely needed
- generic problem-framing repeated across multiple paragraphs
- phrases that sound like promotion rather than analysis

Examples to avoid or reduce:
- `crucial`, `vital`, `promising avenue`, `significant focus`, `open problem and active area of research`
- `A key contribution of this work lies in...`
- `Not surprisingly...`
- `This highlights the practical value...`

Preferred replacements:
- `We study...`
- `We use...`
- `The model includes...`
- `The revised forecasting evaluation compares...`
- `Table X shows...`
- `These results indicate...`

#### B. One paragraph, one job
Each paragraph should primarily do one of the following:
- motivate a modeling choice
- define a model component
- describe a data source
- report a result
- interpret a result

If a paragraph is doing more than one of these, it is a candidate for splitting or trimming.

#### C. Results should follow a claim -> evidence -> interpretation order
Preferred order:
1. state the result plainly
2. point to the relevant table/figure/pattern
3. interpret the result briefly

Avoid:
- interpretation before the reader knows the result
- broad takeaways not anchored to visible evidence
- “best/strongest/clear” language without specifying what comparison is being made

#### D. Keep explanations article-length, not dissertation-length
When choosing between two valid levels of detail, prefer the shorter one unless the longer one is essential for:
- identifiability
- reproducibility
- model interpretation
- understanding a key empirical result

Material that often needs shortening or relocation:
- long derivational walkthroughs
- sensitivity-check narration
- algorithmic detail not used in the main argument
- implementation detail that matters only for local audit/reconstruction

#### E. Avoid local-audit and workflow language in the main article
Do not write the manuscript as if the reader needs to know:
- how the revision was discovered
- the internal history of a rerun
- local repository logic
- operational archive debugging details

Only keep such detail if it is scientifically necessary to explain:
- why certain cutoffs are feasible
- why certain products are comparable
- why the validation design is constrained

Even then, explain it briefly and in reader-facing language.

#### F. Use terminology consistently
Use one term for each concept and keep it stable.

Terms to standardize carefully:
- `USGS observations`
- `retrospective products`
- `forecast products`
- `forecast covariates`
- `forecast-window`
- `raw forecast products`

Avoid unnecessary alternation among near-synonyms if they create ambiguity.

#### G. Keep interpretive claims calibrated
Only use stronger language when the evidence directly supports it.

Prefer:
- `suggests`
- `indicates`
- `is consistent with`
- `supports`

Use stronger terms only when justified:
- `shows`
- `demonstrates`
- `dominates`

Avoid stacking evaluative adjectives such as:
- `robust`, `coherent`, `practical`, `interpretable`, `scalable`

unless each one is needed and supported in context.

### 3.5 Preferred sentence style
- Prefer shorter declarative sentences over multi-clause build-ups.
- Put the main subject early in the sentence.
- Avoid excessive opening dependent clauses.
- Use transitions only when they clarify logic; do not add them to “smooth” the prose artificially.
- Keep notation-heavy sentences especially short.

### 3.6 Section-specific guidance

#### Introduction
- Move quickly from problem context to the actual paper contribution.
- Do not let broad hydrology/weather background dominate the introduction.
- Separate meteorological uncertainty from hydrological uncertainty clearly.
- Keep literature review selective and functional.

#### Methodology
- Define the model clearly, but do not defend every choice at full length in the main text.
- If a justification is not central, compress it or move it later.
- Prefer concise interpretation of components over repeated notation restatement.

#### Data / application section
- Introduce the role of each data source explicitly.
- Make the observational target clear before discussing retrospective or forecast products.
- Keep operational data-processing detail only when it affects scientific interpretation.

#### Results
- Separate:
  - forecasting evidence
  - historical fit / parameter interpretation
  - synthesis illustrations
- Lead with the evaluated comparison, not with setup reminders.
- Keep table discussion concrete and comparison-based.

#### Conclusions
- Summarize what the paper actually establishes after revision.
- Do not revert to broader claims that the results section no longer supports.
- End with restrained future-work statements.

### 3.7 Submission-ready quality check for every edit
Before accepting a revised paragraph, ask:

1. Is this written for a journal reader rather than for a coauthor or reviewer?
2. Is the main point stated directly?
3. Is there any repeated idea that appeared in the previous paragraph or subsection?
4. Is any sentence carrying local audit/process detail that the main paper does not need?
5. Is the level of detail proportional to the importance of the point?
6. Is the wording neutral and evidence-based?
7. Are the terms consistent with the rest of the manuscript and the rebuttal?
8. If this paragraph were read in isolation, would it still sound submission-ready?

### 3.8 Fast red-flag checklist
Revise immediately if a paragraph contains:
- broad motivational language with no new information
- more than one “importance/challenge” sentence in a row
- unexplained local jargon
- internal audit history
- a claim of practical value without evidence
- heavy derivation that the results do not use
- multiple near-synonyms for the same data source or forecasting object

---

## 4. Structural blueprint for the revised manuscript

This is the working architectural decision for the manuscript. Do not begin the large section rewrite without checking new edits against this map.

### 4.1 Main structural decision
The revised paper should be organized around one central contribution:
- a Bayesian quantile-based correction-and-synthesis framework for river-flow forecasting

The manuscript should no longer be organized around:
- `Model A`
- `Model B`
- `Model C`

Instead, the main text should present:
- one shared latent quantile process
- one source-linking structure for observations and agency products
- one forecast-window extension
- one main forecasting-validation result section

### 4.2 What is central versus supporting

#### Central in the main article
- one compact final model description
- one clear statement of the roles of USGS observations, retrospective products, forecast products, and forecast covariates
- one clear rolling-origin forecasting design
- one central comparative forecasting result
- one concise interpretation block for the selected specification

#### Supporting, not central
- the pedagogical `Model A / Model B / Model C` build-up
- long developmental explanations of nested variants
- parameter-heavy source-specific tables
- extended historical-fit illustrations
- multiple synthesis illustrations

#### Best candidates for supplement or appendix
- ablation study
- quantile-level scoring diagnostics
- the second synthesis figure
- one or both source-specific `gamma / sigma` tables
- any figure or table that is informative but not needed to understand the main forecasting result

Rule for these materials:
- if moved out of the main article, they still need a clear home in the submission package and their placement must remain consistent with the rebuttal

### 4.3 Final target section map

#### Section 1. Introduction
- keep as the problem-and-contribution entry point
- update the closing roadmap paragraph only after the new structure is in place

#### Section 2. Methodology
Recommended subsection logic:
1. Extended asymmetric Laplace likelihood
2. Shared latent quantile process
3. Source-specific observation equations
4. Forecast-window extension
5. Prior specification, inference, and tuning
6. Posterior predictive synthesis

Key rule:
- benchmark variants such as `N / AL / exAL`, `U / M`, and `T0 / T1` should appear as restricted variants of the same framework, not as the conceptual backbone of the paper
- the abstract model exposition should foreground the shared quantile process, its trend/seasonal/transfer components, and the source-specific discrepancy structure before introducing any benchmark simplifications

#### Section 3. Application Data and Forecasting Design
Recommended subsection logic:
1. Study setting and target observations
2. External data sources and forecast covariates
3. Application-specific state specification
4. Rolling-origin forecast evaluation design

Key rule:
- this section must explicitly distinguish USGS observations, retrospective products, forecast products, and forecast covariates before the main results section begins

#### Section 4. Forecast Validation Results
Recommended subsection logic:
1. Comparative forecasting performance across model families

Key rule:
- the CRPS-based five-cutoff comparison should be the first major empirical result the reader sees

#### Section 5. Interpretation of the Selected Specification
Recommended subsection logic:
1. Covariate effects and source-specific behavior
2. Historical behavior across representative regimes
3. Optional synthesized predictive illustration

Key rule:
- this section is supporting interpretation, not the paper's primary empirical evidence

#### Section 6. Conclusions
- rewrite only after the new body structure is stable

### 4.4 Block-by-block migration map

#### Methodology block map
- `wileyNJD-APA.tex:77-80` exAL likelihood:
  - keep in main text
  - compress lightly later if needed
- `wileyNJD-APA.tex:86-117` current `Model A`:
  - rewrite into the new `Shared latent quantile process` subsection
- `wileyNJD-APA.tex:119-149` current `Model B`:
  - rewrite into the new `Source-specific observation equations` subsection
- `wileyNJD-APA.tex:151-181` current `Model C`:
  - rewrite into the new `Forecast-window extension` subsection
- `wileyNJD-APA.tex:183-193` priors and discounting:
  - keep
  - compress where possible
- `wileyNJD-APA.tex:195-208` posterior inference and VB:
  - keep
  - compress where possible
- `wileyNJD-APA.tex:210-223` model selection:
  - keep as revised

#### Application/setup block map
- `wileyNJD-APA.tex:228-241` study setting and target observations:
  - keep
  - compress
  - lead explicitly with USGS as the target series
- `wileyNJD-APA.tex:243-249` covariates and GDPC setup:
  - keep
  - compress substantially
- `wileyNJD-APA.tex:251-258` covariates figure:
  - keep in main text
- `wileyNJD-APA.tex:260-262` retrospective and forecast-source description:
  - keep
  - rewrite for clearer data-role separation
- `wileyNJD-APA.tex:264-269` retrospective-products figure:
  - optional keep
  - remove first if space becomes tight
- `wileyNJD-APA.tex:271-278` old weighted multi-issuance protocol:
  - delete from the main paper
  - replace with the latest-forecast-only rolling-origin design
- `wileyNJD-APA.tex:280-287` ensemble illustration figure:
  - optional keep
  - only as a setup illustration, not as core forecasting evidence
- `wileyNJD-APA.tex:289-325` application-specific state specification:
  - keep in main text
  - rewrite lightly for clarity and centrality

#### Forecast-results block map
- `wileyNJD-APA.tex:331-362` benchmark comparison text and CRPS table:
  - keep in main text
  - this becomes the core empirical result
- `wileyNJD-APA.tex:333` compact label explanation:
  - keep with the benchmark table, not in the methods section

#### Interpretation/supporting block map
- `wileyNJD-APA.tex:364-431` `gamma / sigma` tables:
  - move to supplement or appendix
  - keep only a short prose summary in the main paper if needed
- `wileyNJD-APA.tex:434-436` `gamma / sigma` interpretation:
  - compress heavily
  - retain only if needed to motivate source-specific parameters
- `wileyNJD-APA.tex:438-475` regime figures and no-crossing discussion:
  - compress heavily
  - keep at most one compact interpretive figure block in the main paper
- `wileyNJD-APA.tex:477-515` covariate-effects table and discussion:
  - keep in main text if one interpretive table is retained
  - this is a stronger candidate for the main paper than the `gamma / sigma` tables
- `wileyNJD-APA.tex:518-540` synthesis definition:
  - move conceptually to the methods section
  - do not keep as a late results subsection
- `wileyNJD-APA.tex:542-550` `fig:synth1`:
  - optional keep as a single operational illustration
- `wileyNJD-APA.tex:552-561` `fig:synth2`:
  - move to supplement or delete
- `wileyNJD-APA.tex:563-576` conclusions:
  - full rewrite after the structure is stable

### 4.5 Structural decisions that are now considered locked
- remove the `Model A / Model B / Model C` progression from the main text as the organizing device
- make the five-cutoff CRPS comparison the first major empirical result
- remove the old weighted multi-issuance forecast-aggregation protocol
- treat ablation and quantile-level scoring as supplement/appendix candidates rather than required main-text sections
- keep at most one synthesis figure in the main text
- split the current combined Section 3 into setup, forecast validation, and supporting interpretation

### 4.6 Structural recheck after the planning pass
This blueprint was rechecked against the current manuscript and rebuttal, and it remains the best high-quality option for the revised submission for five reasons:

1. It matches the revised rebuttal without forcing every rebuttal artifact into the main article.
2. It gives the paper one dominant narrative: forecasting with one unified framework.
3. It separates out-of-sample evidence from historical interpretation, which is the main readability problem in the current draft.
4. It removes the strongest source of conceptual clutter: the `Model A / B / C` staging.
5. It preserves interpretive material, but only after the main forecasting evidence is established.

If a later manuscript change conflicts with any of these five points, revisit this section before editing further.

---

## 5. Implementation order for the structural rewrite

Use this order when the large section rewrite begins.

### Stage 1. Replace the section skeleton first [completed]
- update the roadmap sentence in the introduction only after the new section map is in place
- replace the current combined Section 3 plan with the new Section 3 / Section 4 / Section 5 split
- remove `General Results`
- create the new subsection headings before rewriting local prose

### Stage 2. Rebuild the methods around one framework [completed]
- replace the `Model A / B / C` presentation with:
  - shared latent quantile process
  - source-specific observation equations
  - forecast-window extension
- keep benchmark-variant labeling out of the core methods exposition

### Stage 3. Rewrite the application/setup section
- lead with USGS as the target series
- rewrite the source-role paragraphs
- compress the GDPC and local covariate exposition
- insert the rolling-origin forecast-design subsection
- remove the old weighted forecast-aggregation text

### Stage 4. Rebuild the main results flow
- make the CRPS benchmark comparison the first result
- keep the model-family label explanation with the benchmark table
- move secondary result blocks out of the way before rewriting result prose

### Stage 5. Rebuild the supporting interpretation section
- decide which interpretive table stays in the main paper
- decide which hydrological figure block stays in the main paper
- decide whether one synthesis figure remains

### Stage 6. Final consistency pass after the structure is in place
- update the introduction roadmap
- rewrite the conclusions
- recheck manuscript vs rebuttal consistency
- recheck all supplement candidates

---

## 6. Revision order: easiest first, hardest last

This order is designed to reduce risk and keep the rebuttal and manuscript synchronized.

### Phase A. Fast factual/editorial fixes
Goal: clean low-risk issues first.

- [x] Fix `Flexile` -> `Flexible` in the subsection title.
  - Source: `R1-m2`
  - Current location: `83`

- [x] Update the introduction sentence on hydrological models to include conceptual models.
  - Source: `R1-m1`
  - Current location: `62`

- [x] Replace deterministic language around retrospective/reanalysis products and note ERA5 forecast components explicitly.
  - Source: `R1-m3`
  - Current locations: `250-290`, especially data/product descriptions

- [x] Fix Table 1 and Table 2 captions/notes so they consistently say posterior medians where appropriate.
  - Source: `R1-m8`
  - Current locations: `387`, `422`, text at `456`

- [x] Normalize baseline terminology in the manuscript to `raw forecast products` or another final consistent term.
  - Source: final rebuttal cleanup and `HE-2`
  - Current locations: `355`, `384`, any table captions/text that still say `raw physical ensembles`

- [x] Add/clarify code availability and reproducibility statement.
  - Source: `HE-5`
  - Likely location: acknowledgments / data-availability / supplementary note area

### Phase B. Shorten math and trim nonessential exposition
Goal: reduce obvious overlength before structural rewrites.

- [x] Remove PIT development from the main text.
  - Source: `R1-M3`
  - Current location: `216-245`
  - Keep only what is truly needed, if anything, outside the main text.

- [x] Shorten the model-selection discussion so CRPS is the main criterion without a long PIT-centered setup.
  - Source: `HE-4`, `R1-M3`
  - Current location: `216-245`

- [x] Shorten the posterior predictive synthesis section.
  - Source: `R1-M3`
  - Current location: `540-610`
  - Keep a concise description because it remains part of the contribution.

- [x] Reduce the quantile-crossing discussion to a brief robustness note unless it is still essential for the final paper.
  - Source: `R1-M3`
  - Current locations: `562-589`

### Phase C. Introduction rewrite
Goal: fix the motivation before touching results structure.

- [x] Separate meteorological uncertainty from hydrological uncertainty early in the introduction.
  - Source: `R1-M1`
  - Current location: `58-76`

- [x] Shorten the ensemble-generation discussion so it supports the paper’s actual scope rather than becoming a parallel weather-forecasting introduction.
  - Source: `R1-M1`
  - Current location: `62-66`

- [x] Reframe the contribution more clearly around:
  - Bayesian quantile-based correction-and-synthesis
  - forecasting performance in this application
  rather than generic `dynamical error correction`.
  - Source: Reviewer 1 overview + `R1-M1`/`R1-M2`
  - Current locations: `68-76`, abstract as well when manuscript editing begins

- [ ] Recheck this section against the rebuttal after the rewrite.
  - Source: rebuttal TODO `R1-M1[BRUNO-REVIEW]`

### Phase D. Data / application / section-organization rewrite
Goal: fix the architecture that Reviewer 1 found confusing.

- [x] Decide the new section layout before editing prose.
  - Source: `R1-m4`, `R1-m7`, `R1-M2`
  - Current problem area: `247-610`
  - Final blueprint recorded in Section 4 of this checklist

- [x] Introduce USGS observations earlier and more explicitly as the target series.
  - Source: `R1-m4`
  - Current locations: `250-290`

- [x] Make the distinction among:
  - USGS observations,
  - retrospective products,
  - forecast products,
  - forecast covariates
  explicit and early.
  - Source: `R1-m4`, `HE-6`

- [x] Replace the vague subsection title `General Results`.
  - Source: `R1-m7`
  - Current location: `350`

- [ ] Recheck this whole structure after the rewrite against rebuttal TODOs:
  - `R1-M2[BRUNO-REVIEW]`
  - `R1-m4[BRUNO-REVIEW]`
  - `R1-m7[BRUNO-REVIEW]`

### Phase E. Forecast protocol rewrite
Goal: align the manuscript with the revised final forecasting protocol.

- [x] Remove or rewrite the old weighted multi-issuance forecast aggregation protocol.
  - Source: `HE-7`, `R1-m6`
  - Current location: `293-300`
  - Replace with latest-forecast-only protocol.

- [x] Clarify that the forecasting evaluation is rolling-origin and out-of-sample.
  - Source: `HE-2`, `HE-6`, `R1-M5`

- [x] State clearly what is available at each cutoff:
  - observed discharge through the cutoff,
  - retrospective products available through the cutoff,
  - forecast products issued at or before the cutoff,
  - forecast covariates available at the cutoff.
  - Source: `HE-6`

- [x] State clearly that post-cutoff USGS observations are used only for verification.
  - Source: `HE-6`

- [ ] Decide where to place the explanation for why only five cutoffs were retained.
  - Source: `HE-2` TODO pending Raquel

- [x] Make the cross-validation logic explicit as rolling-origin cutoff-based folds.
  - Source: `R1-M5`

### Phase F. Forecast validation/results overhaul
Goal: this is the main substantive rewrite.

- [x] Replace the old single-window forecasting emphasis with the five-cutoff validation design.
  - Source: `HE-2`, `R1-M4`

- [x] Insert the final benchmark table and text consistent with the rebuttal.
  - Source: `HE-2`
  - Current manuscript already has an updated table at `360-383`, but the surrounding framing should be rechecked against the final rebuttal wording.

- [x] Ensure the text states correctly that `exAL-M-T1` is best in all five cutoffs.
  - Source: `HE-2`, `HE-7`

- [x] Keep the comparison against simpler Bayesian alternatives and raw forecast products visible and easy to interpret.
  - Source: `HE-2`

- [ ] Decide whether the ablation study will appear in the supplement or appendix rather than in the main article.
  - Source: `HE-3`
  - Current structural decision: supplementary candidate by default

- [ ] Decide whether quantile-diagnostic reporting will appear in the supplement or appendix rather than in the main article.
  - Source: `HE-4`
  - Current structural decision: supplementary candidate by default

### Phase G. Interpretation and synthesis-material decision
Goal: defer until the main forecasting rewrite is settled.

- [x] Decide whether `fig:synth1` and `fig:synth2` remain in the final paper.
  - Source: `R1-m9[BRUNO-REVIEW]`
  - Decision: keep `fig:synth1` in the main text as the operational illustration; move `fig:synth2` to the appendix as a historical-only counterfactual.

If retained:
- [x] rewrite the surrounding discussion so their different roles are explicit
- [x] avoid letting them carry the main validation burden

If replaced:
- [ ] update the manuscript and then recheck the rebuttal wording for `R1-m9`

- [x] Decide whether the `gamma / sigma` tables remain in the main paper or move to supplement.
  - Source: structural blueprint Section 4
  - Decision: move to appendix and reference briefly from the main text.

- [x] Decide whether the historical-regime figures remain as a compact main-text block or move to supplement.
  - Source: structural blueprint Section 4
  - Decision: keep the dry/wet regime pair in the main text; move the 80-month seasonal figure to the appendix.

### Phase H. Conclusions and final consistency pass
Goal: only after the body is stable.

- [x] Rewrite the conclusions so they match the revised paper rather than the old single-cutoff manuscript.
  - Source: global consistency with `HE-2` to `HE-7`

- [x] Make sure the conclusion reflects:
  - five-cutoff validation
  - simpler Bayesian comparisons
  - raw forecast-product comparisons
  - latest-forecast-only protocol
  - supporting interpretation from the selected specification
  - supplementary diagnostics only if they are retained elsewhere in the submission package

- [x] Final terminology sweep:
  - `raw forecast products`
  - `retrospective products`
  - `forecast products`
  - `USGS observations`
  - `forecast-window`

- [ ] Final rebuttal/manuscript coherence check.
  - Every manuscript change promised in the rebuttal should either be present in the article or the rebuttal should be updated.

---

## 7. Easy-to-hard execution checklist

Use this as the working order when actually editing the manuscript.

### First pass: low-risk manuscript fixes
- [x] `Flexile` -> `Flexible`
- [x] conceptual-model wording in introduction
- [x] ERA5 / retrospective wording precision
- [x] Table 1 / Table 2 caption fixes
- [x] baseline terminology normalization
- [x] code/reproducibility note

### Second pass: delete/shorten obvious excess
- [x] PIT section from main text
- [x] long CRPS derivation trimmed
- [x] synthesis section shortened
- [x] quantile-crossing correction reduced

### Third pass: introduction and section architecture
- [x] introduction rewritten
- [x] section architecture decided
- [x] data/application ordering rewritten
- [x] `General Results` renamed/replaced
- [x] methods reframed around one unified framework
- [x] full state-space model presented directly, with simpler formulations treated as restrictions rather than separate models
- [x] unified model rewritten as one readable single-model presentation, with line-by-line equations, a compact form, and explicit A/B/C equivalence

### Targeted audit: unified-model and results-table readability

#### Unified-model exposition
- [x] Verify mathematical equivalence between the current single-model presentation and the old A/B/C setup.
  - Confirm that the line-by-line equations recover:
    - the USGS-only case (`Model A`)
    - the estimation-period multivariate case (`Model B`)
    - the forecast-window continuation (`Model C`)
  - Confirm that the T0 restriction is described only as a benchmark restriction, not as a second main model.
- [x] Verify notation and indexing consistency within Subsection `Unified State-Space Model`.
  - Every symbol appearing in the equations should be either defined locally or already standard from earlier text.
  - Check especially:
    - `T`, `t`, `k`, `j`, `i`, `J`, `K_{(j)}`, `I_j`
    - `\boldsymbol{\eta}_t`, `\boldsymbol{\theta}_t`, `\boldsymbol{\delta}_t^j`, `\zeta_t`, `\boldsymbol{\psi}_t`
    - `\mathbf{F}_t`, `\mathbf{G}_t`, `\mathbf{G}^{\text{trans}}_t`, `\boldsymbol{D}_t`, `\boldsymbol{M}_t`
    - `\mathbf{h}_{t,j}`, `\mathbf{e}_{t,j}`
- [x] Verify internal consistency between the line-by-line and compact forms.
  - The compact equations should be a faithful restatement of the readable display, not a modified variant.
  - No quantity should appear in the compact form with a meaning that differs from the line-by-line form.
- [x] Audit the reader flow for a first-time statistics reader.
  - The subsection should answer in order:
    1. What is the state?
    2. What is observed before the cutoff?
    3. What is observed after the cutoff?
    4. How does the state evolve?
    5. How do the compact matrices encode the same structure?
    6. What are the natural special cases of the unified formulation?
- [x] Remove dependence on the older staged-model narrative.
  - Do not refer to `Model A`, `Model B`, or `Model C` in the main exposition.
  - If restrictions are mentioned, describe them as special cases of the unified formulation.
- [x] Audit for undefined or weakly motivated transitions.
  - Remove any sentence that sounds like internal refactoring commentary.
  - Replace any sentence that asks the reader to infer too much from notation alone.
- [x] Audit the formatting of the displays for readability.
  - Keep the line labels informative but brief.
  - Avoid overcrowded lines where both interpretation and indexing compete for space.
  - Prefer one display per conceptual step when a combined display becomes visually heavy.
  - Keep the compact form as a reference block, not the main explanatory burden.
- [x] Audit for redundancy.
  - Remove repeated explanations of:
    - source-specific parameters
    - the meaning of the cutoff
    - the role of forecast covariates
  - Keep each explanation once, at the place where a new reader most needs it.
- [x] Audit subsection-to-subsection continuity.
  - The transition from exAL to the unified model should feel natural.
  - The transition from the unified model to priors/discount factors should not reintroduce the old staged-model logic.
  - The transition from the unified model to posterior inference should use the same single-model framing.
- [x] Final style pass for the unified-model subsection.
  - Neutral, factual tone
  - No AI-sounding scaffolding
  - No unnecessary reassurance or meta language
  - Sentences should be short enough to parse on first read, especially after displayed equations

#### Results tables and label definitions
- [x] Verify that all benchmark labels are defined before or at the benchmark table.
  - `L-S-T`
  - `T0` and `T1`
  - `RAW-GLOFAS` and `RAW-NWS`
  - univariate vs multivariate synthesis
- [x] Verify consistency between the data section and the benchmark table.
  - Raw baselines should match the forecast-product sources actually introduced in Section 3.
  - No table row should use an undefined or inconsistent source name.
- [x] Make the benchmark table more self-contained.
  - Add a table note that decodes the model-label shorthand.
  - State explicitly what the raw baselines refer to.
- [x] Verify that covariate-effect tables do not introduce undefined shorthand.
  - Replace or explain any label that depends on prior local knowledge.
  - In particular, clarify the GDPC-based covariate label.
- [x] Verify that appendix tables remain readable as stand-alone references.
  - Expand source abbreviations in table notes where useful.
  - Keep source naming consistent with the main text.
- [x] Verify results-to-table continuity.
  - The running text should define the comparison before the table appears.
  - The interpretation after the table should use the same labels and terminology as the table itself.

### Fourth pass: forecasting protocol and validation
- [x] latest-forecast-only protocol in text
- [x] five-cutoff rolling-origin design stated clearly
- [x] fit-time vs forecast-time vs verification distinction stated clearly
- [x] benchmark comparison fully aligned with rebuttal
- [ ] supplement/appended placement for ablation and quantile diagnostics finalized

### Targeted baseline-recovery pass
- [x] Recover a small amount of application motivation from the baseline without restoring the old narrative scale.
- [x] Recover clearer post-equation explanatory rhythm in the unified-model section without reintroducing staged A/B/C exposition.
- [x] Recover a more intuitive explanation of why retrospective products are useful for discrepancy learning.
- [x] Recover a short explanation of why forecast products from different agencies are not directly exchangeable.
- [x] Make the GDPC description slightly more intuitive for a first-time reader.
- [x] Improve the transition from external data description to application-specific specification.
- [x] Sharpen the benchmark-table interpretation so the role of `U/M` and `T0/T1` is easier to read from the text.
- [x] Clarify the purpose of the regime figures and synthesized predictive illustration so they remain supporting, not central, evidence.

### Targeted notation and layout refinement pass
- [x] Reduce vertical space in the unified-model subsection where a row-vector display is clearer than a tall column-vector display.
- [x] Introduce a compact transfer-state notation that keeps the model equivalent while reducing display height.
- [x] Normalize the main source/member/lead indices through index sets rather than repeated inequality strings.
- [x] Rewrite the compact forecast-window equations so the lead index is carried explicitly by \(T+k\), reducing notation drift between expanded and compact forms.
- [x] Make repeated block-diagonal structure more explicit, including the number and role of the repeated \(\mathbf{G}_t\) blocks.
- [x] Replace the expectation form of CRPS with the integrated quantile-score representation and state explicitly that deterministic forecasts reduce to MAE.
- [x] Recheck that the revised notation remains standard, mathematically equivalent, and easier for a first-time reader to parse.

### Targeted appendix-algorithm readability pass
- [x] Align the appendix algorithms explicitly with the unified-model notation from the main text.
- [x] Clarify the source-indexed notation used in the algorithms, including the role of \(j=0\), \(\mathcal{J}\), and \(\mathcal{J}_0\).
- [x] Distinguish clearly between estimation-period selectors \(\mathbf{h}_{t,j}\) and forecast-window selectors \(\mathbf{e}_{T+k,j}\).
- [x] Rewrite the forecast-window algorithm steps so they use the same \(T+k\) notation as the main text.
- [x] Remove stale or ambiguous notation residue that no longer matches the cleaned unified-model exposition.
- [x] Add short continuity cues so a reader can move from `Posterior Computation` into the appendix algorithms without reconstructing old notation.
- [x] Recheck the appendix as a reader-facing continuation of the main text rather than as an implementation note.

### Targeted heading and Section 2.2 polish pass
- [x] Rename section and subsection headings so they are self-contained and do not depend on local draft history.
- [x] Replace local labels such as `Unified` with standard state-space terminology.
- [x] Reframe the compact model display in Section 2.2 as a computational summary rather than a second model exposition.
- [x] Trim the explanatory text around the compact form so it motivates filtering, smoothing, and FFBS without overexplaining equivalence.
- [x] Recheck subsection cross-references after the heading changes.

### Targeted dimension and computational-notation pass
- [x] Add missing dimensions for matrices, vectors, and scalar variance terms in the main state-space specification.
- [x] Make the application-specific trend and seasonal dimensions explicit so the value of \(p\) is concrete in the San Lorenzo model.
- [x] Clarify that the compact state-space display is included for computational implementation and to expose the conditionally Gaussian structure used by filtering, smoothing, and FFBS.

### Targeted provenance inventory pass
- [x] Build a manuscript-side provenance inventory for interpretation-dependent figures and tables.
- [x] Verify whether the current manuscript figure assets hash-match the workflow repo's recorded gold outputs.
- [x] Distinguish workflow-linked setup figures from selected-run-dependent interpretation outputs.
- [x] Record the current strength of table provenance and identify which tables still require run-level regeneration or verification.
- [x] Write the inventory to `docs/figure_table_provenance.md` so regeneration decisions can be made safely.

### Fifth pass: harder review-dependent items
- [ ] five-cutoff justification after Raquel input
- [ ] final figure decision for Figures 8 and 9
- [ ] recheck `R1-M1`, `R1-M2`, `R1-M3` after full structural rewrite
- [ ] recheck `R1-m4`, `R1-m7`, `R1-m9` after final section/figure decisions

### Locked regeneration baseline
- [x] Fix the representative selected-model cutoff for Section 5 at `2022-12-25`.
- [x] Fix the selected-model workflow family for regeneration at `exdqlm_multivar_keep` (paper label: `exAL-M-T1`).
- [x] Confirm that recent validated runs exist for all five manuscript cutoffs with forecast precipitation and soil moisture enabled and PCA/GDPC passed through.
- [x] Confirm that the recent `2022-12-25` selected-model run already produces cutoff-window synthesis figures and quantile CSV exports.
- [x] Identify the current gap: posterior interpretation tables are not yet emitted by those runs and will require a targeted post-export rerun or export fix.

### Exact relaunch handoff
- [x] Build a publication-aligned relaunch checklist for the selected manuscript model `exAL-M-T1`.
- [x] Record the five publication-relevant `exAL-M-T1` runs tied to the current HE2 CRPS table.
- [x] Record the representative Section 5 cutoff run to use for `fig:synth1`, `fig:synth2` if retained, and `tab:components_23_31`.
- [x] Record the Phase A predictive-synthesis and posterior-table outputs required to refresh the revised manuscript.
- [x] Record the post-rerun validation contract, including CRPS verification against the current published Table 1 values.
- [x] Write the exact manuscript-side handoff to `docs/exal_m_t1_relaunch_checklist.md`.

### Focused exAL-M-T1 relaunch planning
- [x] Freeze the narrow five-run `exAL-M-T1` publication lineage for the revised manuscript and remove dependence on the older pre-publication source-run audit.
- [x] Write a workflow-side relaunch plan for the five publication-relevant `exAL-M-T1` runs only.
- [x] Replace the manuscript-side `docs/exal_m_t1_relaunch_checklist.md` with the current publication-aligned five-run source map.
- [x] Split the required outputs into Phase A article-critical outputs and Phase B historical-summary outputs so the relaunch stays focused.
- [x] Identify the current replay blocker as a headless post issue rather than a fit-stage failure.
- [x] Apply the minimal headless-safe post fix in the workflow repo.
- [x] Rerun two `exAL-M-T1` canaries: `01/23/2021` cf1 keep and `12/25/2022` exact `set09` keep.
  - Final result:
    - both canaries pass end to end under the authoritative replay path
    - both reproduce the published HE2 CRPS rows to rounding
    - both emit the synthesis figures and posterior table exports needed for the revised article
- [x] Finish the remaining three publication-aligned `exAL-M-T1` rows and lock the final five-run provenance.
  - Final result:
    - `11/12/2021` passes and reproduces the published `0.0284` row to rounding
    - `12/21/2021` passes and reproduces the published `0.2369` row to rounding
    - `05/11/2022` passes and reproduces the published `0.0210` row to rounding
    - all five publication-aligned `exAL-M-T1` cutoffs now pass end to end under the authoritative replay path
- [x] Refresh the representative Section 5 Phase A manuscript assets from the verified `12/25/2022` selected-model run.
  - Current refresh:
    - `fig:synth1` source image in `figures/manuscript/representative_synthesis_multivariate.png`
    - `tab:components_23_31`
    - copied provenance bundle under `artifacts/representative_selected_model_2022_12_25/`
- [x] Keep `tab:gamma_sigma_intervals1` and `tab:gamma_sigma_intervals2` as supplementary appendix support.
  - Locked choice:
    - keep both tables refreshed from the representative `2022-12-25` selected-model run
    - treat them as appendix support, not central selected-model refresh targets
    - keep them outside the main in-scope Section 5 artifact set
- [x] Freeze the five verified `exAL-M-T1` run roots locally in the revised-doc repo.
  - Local freeze:
    - `artifacts/five_cutoff_crps_validation_sources/<slug>/crps_forecast_summary.csv`
    - `artifacts/five_cutoff_crps_validation_sources/<slug>/compare_report.json`
    - `artifacts/five_cutoff_crps_validation_sources/<slug>/summary.json`
- [x] Build the exact artifact-to-run map for current `exAL-M-T1`-dependent manuscript objects.
  - Source map:
    - `docs/exal_m_t1_artifact_run_map.md`
- [x] Sync the main five-cutoff CRPS benchmark table in the revised article to the frozen HE2 publication manifest.
  - Locked source:
    - `reports/he2_publication_manifest/he2_bayesian_publication_manifest.md`
  - Result:
    - `tab:benchmark_crps_models` in `wileyNJD-APA.tex` now matches the frozen published HE2 benchmark source
  - Hold-state note:
    - keep this table frozen until NDLM is relaunched on the canonical shared bundle, AL multivariate keep/drop are complete, and the exAL shared-spec rerun benchmark rows are reconciled
  - Local article-side snapshot:
    - `artifacts/he2_publication_freeze/`
- [x] Distinguish in-scope selected-model refresh objects from workflow-linked but out-of-scope historical/counterfactual objects.
  - In scope:
    - `tab:benchmark_crps_models`
    - `fig:synth1`
    - `tab:components_23_31`
  - Deferred/out of narrow keep-run scope:
    - `fig:synth2`
    - `fig:dry_quantile`
    - `fig:rainy_quantile`
    - `fig:80_components`
  - Supplementary appendix support:
    - `tab:gamma_sigma_intervals1`
    - `tab:gamma_sigma_intervals2`
- [x] Make the historical-summary figures explicit in the manuscript text and captions.
  - Locked choice:
    - keep `fig:dry_quantile`, `fig:rainy_quantile`, and `fig:80_components`
    - treat them as workflow-linked historical summaries of the selected specification
    - do not treat them as representative-cutoff or additional forecast-validation objects
- [x] Consolidate article-side local provenance onto the canonical current families.
  - Historical-summary and appendix-support figures now anchor to:
    - `artifacts/historical_support_from_current_models/`
  - Cutoff-specific setup/support figures now anchor to:
    - `artifacts/five_cutoff_setup_support/`
    - `reports/five_cutoff_setup_support_review/`
  - Locked reproduction note:
    - treat `R/unified/stages/stage_post.R` + `scripts/run_environmetrics_figures.R` + `R/environmetrics/40_figures.R` as the current clean reproduction path
    - treat `scripts/make_environmetrics_figures.R` as legacy scaffolding rather than the preferred reproduction contract
- [x] Remove superseded article-side figure families once the canonical bundles were in place.
  - Removed during cleanup:
    - `artifacts/historical_summary_sources/`
    - `artifacts/workflow_linked_support_sources/`
    - `artifacts/setup_support_by_cutoff/`
    - `artifacts/setup_support_by_cutoff_review/`
    - legacy extra files under `figures/manuscript/`
    - legacy article-only `Figures/`
- [x] Freeze the corrected `v2` planning gate for the setup/support figures before further implementation.
  - Canonical planning docs:
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_SOURCE_MANIFEST.md`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_FILE_PLAN.md`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_ACCEPTANCE_CHECKLIST.md`
- [x] Implement the corrected setup/support `v2` workflow from the frozen planning gate.
  - Workflow config:
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/config/exal_m_t1_setup_support_by_cutoff_v2_20260516.json`
  - Workflow scripts:
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/scripts/render_exal_m_t1_setup_support_by_cutoff_v2.py`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/scripts/render_setup_support_bundle_v2.R`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/scripts/setup_support_bundle_v2_helpers.R`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/scripts/build_exal_m_t1_setup_support_v2_review.py`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/scripts/validate_exal_m_t1_setup_support_v2.py`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_BY_CUTOFF_V2_WORKFLOW.md`
- [x] Validate the corrected setup/support `v2` family across all five publication cutoffs.
  - Canonical runtime family:
    - `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/exal_m_t1_setup_support_by_cutoff_v2_20260516/`
  - Workflow-side review:
    - `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/exal_m_t1_setup_support_by_cutoff_v2_20260516/review/REVIEW.md`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/exal_m_t1_setup_support_by_cutoff_v2_20260516/review/gallery.html`
    - `/data/muscat_data/jaguir26/project1_ucsc_phd_runtime/exal_m_t1_setup_support_by_cutoff_v2_20260516/review/figure_manifest.csv`
  - Validation gate:
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/EXAL_M_T1_SETUP_SUPPORT_V2_ACCEPTANCE_CHECKLIST.md`
- [x] Mirror the corrected setup/support `v2` family into the revised article repo and promote the representative `2022-12-25` cutoff figures into `figures/manuscript/`.
  - Article-side mirror:
    - `artifacts/five_cutoff_setup_support/`
    - `reports/five_cutoff_setup_support_review/`
  - Article-side promotion manifest:
    - `reports/representative_setup_selection/selection_manifest.json`
  - Article-side scripts:
    - `scripts/refresh_setup_support_by_cutoff_v2.py`
    - `scripts/build_setup_support_by_cutoff_v2_review.py`
    - `scripts/promote_setup_support_v2_to_disc.py`
- [x] Add a canonical forward runbook and an article-side provenance refresh helper.
  - Canonical runbook:
    - `/data/muscat_data/jaguir26/project1_ucsc_phd/repro/run/CANONICAL_REVISED_ARTICLE_WORKFLOW.md`
  - Article-side helpers:
    - `scripts/clean_article_legacy_assets.py`
    - `scripts/refresh_exal_m_t1_generated_assets.py`
    - `scripts/refresh_he2_manifest_snapshot.py`
    - `scripts/refresh_all_generated_assets.py`
    - `scripts/build_article_asset_review_report.py`
  - Operational rule:
    - refresh article-side generated bundles through the helper scripts instead of manual copying
- [x] Generate an article-side review report so all current figures and tables can be inspected from one place.
  - Review outputs:
    - `reports/manuscript_asset_review/ARTICLE_ASSET_REVIEW.md`
    - `reports/manuscript_asset_review/figure_gallery.html`
    - `reports/manuscript_asset_review/figure_manifest.csv`
    - `reports/manuscript_asset_review/table_manifest.csv`

### Next coordinated TODOs after the current manuscript pass
- [x] Refresh or explicitly reclassify every interpretation-dependent table and figure in line with the locked provenance split.
  - Representative selected-model outputs refreshed from verified `exAL-M-T1` sources:
    - `fig:synth1`
    - `tab:components_23_31`
    - `tab:gamma_sigma_intervals1`
    - `tab:gamma_sigma_intervals2`
  - Historical-summary figures intentionally retained with separate locked provenance:
    - `fig:dry_quantile`
    - `fig:rainy_quantile`
    - `fig:80_components`
  - Cutoff-dependent setup/support figures now reproduced through the dedicated five-cutoff derived family:
    - `fig:sanlorenzo`
    - `fig:covariates`
    - `fig:retrospectives`
    - `fig:ensembles`
- [x] Decide and state the provenance of the supporting interpretation material.
  - Locked decision: Section 4 remains the five-cutoff CRPS evidence; Section 5 uses the representative final cutoff `2022-12-25`; appendix figures/tables remain historical summaries of the selected specification unless later demoted or rerun.
- [x] Update the predictive-synthesis figure in the main text so it matches the final selected `exAL-M-T1` analysis used in the current manuscript.
  - `fig:synth1` is now tied to the verified representative `2022-12-25` selected-model bundle.
- [x] Recheck the dry/wet regime figures and make their provenance explicit.
  - Locked decision:
    - keep them as descriptive historical-summary figures
    - do not treat them as representative-cutoff outputs
    - preserve them through `artifacts/historical_support_from_current_models/`
- [ ] Clarify forecast-covariate availability in both the manuscript and the corrections letter.
  - Make explicit that forecast precipitation and forecast soil moisture are used after the cutoff, whereas the large-scale climate factor (GDPC / PCA-based summary) is not forecasted in the same way.
- [ ] Add an explicit justification for why only five cutoffs were retained after the archive/version screening.
  - This justification must appear in the corrections letter and may also need a short manuscript sentence once the wording is settled.
- [ ] Synchronize the corrections letter with the current manuscript before the final crosswalk audit.
  - Update older CRPS values, figure/table references, and any stale terminology that no longer matches the revised manuscript.
  - Recheck source naming carefully; the corrections letter still contains older labels in places and must match the manuscript exactly.
- [ ] Decide the final status and location of the ablation and quantile-diagnostic material.
  - Finalize whether these stay only in the corrections letter, move to an appendix/supplement, or receive a brief manuscript-side pointer.
- [ ] Do a full response-letter/manuscript crosswalk audit once the refreshed figures, tables, and corrections-letter updates are complete.
  - Verify that every promised revision is actually present, that every cited number matches the final manuscript, and that the response letter points to the correct sections, tables, and figures.

---

## 8. Practical workflow note

When actual manuscript editing starts, work in this loop:
1. update one coherent block of the manuscript,
2. compare it immediately with the matching rebuttal response,
3. note any mismatch,
4. only then move to the next block.

This will keep the article and the response letter synchronized and reduce the risk of introducing a contradiction late in the revision.
