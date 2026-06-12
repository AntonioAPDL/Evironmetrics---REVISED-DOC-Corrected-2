#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
from pathlib import Path

from article_repo_layout import build_layout


def file_exists(root: Path, rel: str) -> bool:
    return (root / rel).exists()


def read_text(path: Path) -> str:
    return path.read_text(encoding='utf-8') if path.exists() else ''


def build_items(root: Path) -> list[dict[str, object]]:
    tex = read_text(root / 'wileyNJD-APA.tex')
    render_meta_path = root / 'artifacts' / 'historical_support_from_current_models' / 'figures' / 'render_metadata.json'
    render_meta = json.loads(render_meta_path.read_text(encoding='utf-8')) if render_meta_path.exists() else {}

    no_support_window_phrase = 'support window for the cutoff' not in tex.lower()
    no_cutoff_centered = 'cutoff-centered' not in tex.lower()
    has_all_cutoff_forecast_context = len(list((root / 'figures' / 'forecast_context_by_cutoff').glob('cutoff_*_forecast_context.png'))) == 5
    has_all_cutoff_multivar_synthesis = len(list((root / 'figures' / 'multivariate_synthesis_by_cutoff').glob('cutoff_*_multivariate_synthesis.png'))) == 5
    has_all_cutoff_reference_synthesis = len(list((root / 'figures' / 'reference_synthesis_by_cutoff').glob('cutoff_*_reference_synthesis.png'))) == 5
    has_rep_multivar_overlay = file_exists(root, 'artifacts/representative_selected_model_2022_12_25/representative_synthesis_multivariate_with_reference_ensembles.png')
    has_rep_multivar = file_exists(root, 'figures/manuscript/representative_synthesis_multivariate.png')
    has_rep_univar = file_exists(root, 'figures/manuscript/reference_synthesis_univariate.png')
    has_wet_fullrange = file_exists(root, 'artifacts/historical_support_from_current_models/figures/historical_summary_wet_period_fullrange.png')
    long_cycle_shifted = render_meta.get('component_display_contract') == '80-month component shifted by posterior mean trend level'
    appendix_panels_in_article = 'figures/appendix_cutoff_panels/' in tex

    items: list[dict[str, object]] = [
        {
            'item': 1,
            'request': 'Figure 1 should remain good and consistent.',
            'status': 'complete',
            'evidence': [
                'figures/manuscript/site_context_usgs.png',
                'wileyNJD-APA.tex:243',
                'scripts/setup_support_bundle_v2_helpers.R:330-371',
            ],
            'note': 'USGS figure remains the manuscript anchor and uses the shared flood-threshold styling and flow-axis label contract.',
        },
        {
            'item': 2,
            'request': 'Figure 2 should remove support-window subtitle, show units for precipitation and soil moisture, keep the large-scale climate-factor label concise, and keep caption compact/high quality.',
            'status': 'complete' if no_support_window_phrase else 'partial',
            'evidence': [
                'figures/manuscript/covariate_context_precip_soil_gdpc.png',
                'scripts/figure_style_contract.R:86-92',
                'scripts/setup_support_bundle_v2_helpers.R:376-401',
                'wileyNJD-APA.tex:259-264',
            ],
            'note': 'Facet labels now render as plotmath expressions for precipitation, soil moisture, and `GDPC[1]`; the manuscript caption describes the raw support-file scale directly.',
        },
        {
            'item': 3,
            'request': 'Figure 3 should remove the historical-support subtitle, keep clear flow units, and use a compact/high-quality caption.',
            'status': 'complete',
            'evidence': [
                'figures/manuscript/retrospective_products_context.png',
                'scripts/setup_support_bundle_v2_helpers.R:403-432',
                'scripts/figure_style_contract.R:3-14',
                'wileyNJD-APA.tex:278',
            ],
            'note': 'The retrospective figure uses the shared flow-axis label and no support-window subtitle; the caption now states the corrected full-history support contract and `log(1+x)` units.',
        },
        {
            'item': 4,
            'request': 'Figure 4 should use the same flow-axis contract, simplified legend labels, aligned flood thresholds, and readable caption wording without “cutoff-centered”.',
            'status': 'complete' if no_cutoff_centered else 'partial',
            'evidence': [
                'figures/manuscript/forecast_products_context.png',
                'scripts/forecats_plot_bundle.R:390-541',
                'scripts/figure_style_contract.R:61-121',
                'wileyNJD-APA.tex:330',
            ],
            'note': 'Legend labels now use product/version names only, the flow axis matches the other flow figures, and the flood lines come from the shared helper used by the USGS plot.',
        },
        {
            'item': 5,
            'request': 'Figure 5 should use a 0 to 7 y-range and inherit the normalized style when possible.',
            'status': 'complete',
            'evidence': [
                'figures/manuscript/historical_summary_dry_period.png',
                'scripts/render_current_model_output_support_figures.R:617-623',
            ],
            'note': 'The dry-period historical summary is rendered with an explicit `ylim_override = c(0, 7)` under the shared flow display contract.',
        },
        {
            'item': 6,
            'request': 'Figure 6 should exist in both 0 to 20 and 0 to 7 variants and keep the normalized style.',
            'status': 'complete' if has_wet_fullrange else 'partial',
            'evidence': [
                'figures/manuscript/historical_summary_wet_period.png',
                'artifacts/historical_support_from_current_models/figures/historical_summary_wet_period_fullrange.png',
                'scripts/render_current_model_output_support_figures.R:624-634',
            ],
            'note': 'The manuscript version uses `0–7`; the repo preserves the full-range companion under the historical-support artifact bundle.',
        },
        {
            'item': 7,
            'request': 'Figure 7 and Figure A2 should align visually with Figure 4, be produced for all cutoffs, and also have extra overlay versions with raw/reference ensembles.',
            'status': 'complete' if (has_all_cutoff_multivar_synthesis and has_all_cutoff_reference_synthesis and has_rep_multivar_overlay and has_rep_multivar and has_rep_univar) else 'partial',
            'evidence': [
                'artifacts/representative_selected_model_2022_12_25/representative_synthesis_multivariate.png',
                'artifacts/representative_selected_model_2022_12_25/representative_synthesis_multivariate_with_reference_ensembles.png',
                'figures/multivariate_synthesis_by_cutoff/manifest.csv',
                'figures/reference_synthesis_by_cutoff/manifest.csv',
                'R/unified/post_publication_figures.R:546-807',
            ],
            'note': 'The representative cutoff uses the polished `publication_focus_v2` style and now the corresponding Figure 7 and Figure A2 families are also preserved article-side for all five cutoffs, including the overlay variants with raw/reference ensembles.',
        },
        {
            'item': 8,
            'request': 'Figure A1 should plot the 80-month component after adding the posterior mean trend level and use a compact, high-quality caption.',
            'status': 'complete' if long_cycle_shifted else 'partial',
            'evidence': [
                'figures/manuscript/historical_component_80month.png',
                'artifacts/historical_support_from_current_models/figures/render_metadata.json',
                'scripts/render_current_model_output_support_figures.R:589-608, 656-680',
                'wileyNJD-APA.tex:460-466',
            ],
            'note': 'The render metadata records the intended contract explicitly and the renderer computes the trend-shift map before building the 80-month component figure.',
        },
        {
            'item': 9,
            'request': 'Keep the composite A3–A6 style panels only if useful; definitely preserve the forecast-context panel D for all cutoffs, and do the same cutoff-wide treatment for Figure 7 and A2 when full-history conditions allow it.',
            'status': 'complete' if (has_all_cutoff_forecast_context and has_all_cutoff_multivar_synthesis and has_all_cutoff_reference_synthesis) else 'partial',
            'evidence': [
                'figures/forecast_context_by_cutoff/manifest.csv' if has_all_cutoff_forecast_context else 'figures/forecast_context_by_cutoff/',
                'figures/multivariate_synthesis_by_cutoff/manifest.csv' if has_all_cutoff_multivar_synthesis else 'figures/multivariate_synthesis_by_cutoff/',
                'figures/reference_synthesis_by_cutoff/manifest.csv' if has_all_cutoff_reference_synthesis else 'figures/reference_synthesis_by_cutoff/',
                'figures/appendix_cutoff_panels/',
                'artifacts/five_cutoff_setup_support/review/figure_manifest.csv',
                'wileyNJD-APA.tex:483-520',
            ],
            'note': 'Forecast-context figures, multivariate synthesis figures, and reference synthesis figures are now preserved cutoff-wide in advisor-facing folders. The remaining decision is whether the composite appendix panels should stay in the manuscript appendix or move to repo-only review support.',
        },
    ]
    return items


def write_markdown(path: Path, items: list[dict[str, object]]) -> None:
    complete = sum(1 for item in items if item['status'] == 'complete')
    partial = sum(1 for item in items if item['status'] == 'partial')
    not_done = sum(1 for item in items if item['status'] == 'not_done')

    lines = [
        '# Figure Polish Status Audit',
        '',
        'This audit checks the implementation status of the nine-point figure-polish request that preceded the PCA hardening and full-history reconstruction phase.',
        '',
        f'- `complete`: {complete}',
        f'- `partial`: {partial}',
        f'- `not_done`: {not_done}',
        '',
        '## Item-by-item status',
        '',
    ]
    for item in items:
        lines.append(f"### Item {item['item']} [{item['status']}]")
        lines.append(item['request'])
        lines.append('')
        lines.append(f"- Note: {item['note']}")
        lines.append('- Evidence:')
        for ev in item['evidence']:
            lines.append(f'  - `{ev}`')
        lines.append('')

    lines.extend([
        '## Remaining work before the next modeling phase',
        '',
        '1. Decide whether the appendix composite setup/support panels should remain in the manuscript appendix or move to repo-only documentation.',
        '2. Keep the early short-window cutoffs (`2021-01-23`, `2021-11-12`) separate from any future full-history-only interpretation claims until the full-table corrected bundle relaunch is complete.',
        '',
    ])
    path.write_text('\n'.join(lines) + '\n', encoding='utf-8')


def main() -> None:
    parser = argparse.ArgumentParser(description='Build a point-by-point audit of the figure-polish checklist status.')
    parser.add_argument('--article-root', type=Path, default=Path(__file__).resolve().parents[1])
    args = parser.parse_args()

    layout = build_layout(args.article_root.resolve())
    layout.ensure_base_dirs()
    out_dir = layout.manuscript_asset_review_dir
    out_dir.mkdir(parents=True, exist_ok=True)

    items = build_items(layout.root)
    md_path = out_dir / 'FIGURE_POLISH_STATUS_AUDIT.md'
    json_path = out_dir / 'figure_polish_status_audit.json'
    write_markdown(md_path, items)
    json_path.write_text(json.dumps(items, indent=2), encoding='utf-8')
    print(f'Wrote {md_path}')
    print(f'Wrote {json_path}')


if __name__ == '__main__':
    main()
