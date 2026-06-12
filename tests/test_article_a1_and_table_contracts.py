from __future__ import annotations

import json
import re
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class ArticleA1AndTableContractTests(unittest.TestCase):
    def test_figure_a1_renderer_uses_samplewise_component_contract(self) -> None:
        script = ROOT / "scripts" / "render_authoritative_selected_model_support_figures.R"
        text = script.read_text(encoding="utf-8")
        self.assertIn(
            'FIGURE_A1_COMPONENT_CONTRACT <- "component_6_plus_trend_component_1_samplewise"',
            text,
        )
        self.assertIn("hydrologic_regime_periods <- function()", text)
        self.assertIn('"2012-01-01"', text)
        self.assertIn('"2016-12-31"', text)
        self.assertIn('"2017-01-01"', text)
        self.assertIn('"2019-12-31"', text)
        self.assertNotIn(
            'components$component_contract == "component_6_shifted_by_posterior_mean_trend_component_1"',
            text,
        )
        self.assertIn("component_analysis_specs <- function(component_df)", text)
        self.assertIn("COMPONENT_ANALYSIS_LEGACY_EXCLUDED_CONTRACTS", text)
        self.assertIn("include_in_manuscript = FALSE", text)

    def test_figure_a1_render_metadata_records_contract_and_periods(self) -> None:
        meta_path = (
            ROOT
            / "artifacts"
            / "representative_selected_model_2022_12_25"
            / "authoritative_support"
            / "figures"
            / "render_metadata.json"
        )
        self.assertTrue(meta_path.exists(), f"missing render metadata: {meta_path}")
        meta = json.loads(meta_path.read_text(encoding="utf-8"))
        self.assertEqual(
            meta.get("figure_a1_component_contract"),
            "component_6_plus_trend_component_1_samplewise",
        )
        periods = meta.get("hydrologic_regime_periods")
        self.assertIsInstance(periods, list)
        self.assertEqual(
            [(row.get("period"), row.get("start"), row.get("end")) for row in periods],
            [("Dry", "2012-01-01", "2016-12-31"), ("Wet", "2017-01-01", "2019-12-31")],
        )
        component_analysis = meta.get("component_analysis")
        self.assertIsInstance(component_analysis, dict)
        self.assertEqual(component_analysis.get("figure_count"), 8)
        self.assertIn(
            "component_06_component_6_plus_trend_component_1_samplewise.png",
            component_analysis.get("files", []),
        )

    def test_component_analysis_gallery_is_analysis_only(self) -> None:
        support_dir = (
            ROOT
            / "artifacts"
            / "representative_selected_model_2022_12_25"
            / "authoritative_support"
        )
        manifest_path = support_dir / "analysis_figures" / "component_evolution" / "component_analysis_manifest.csv"
        self.assertTrue(manifest_path.exists(), f"missing component analysis manifest: {manifest_path}")
        text = manifest_path.read_text(encoding="utf-8")
        self.assertIn("component_01_raw_state_component.png", text)
        self.assertIn("component_07_raw_state_component.png", text)
        self.assertIn("component_06_component_6_plus_trend_component_1_samplewise.png", text)
        self.assertNotIn("component_6_shifted_by_posterior_mean_trend_component_1", text)
        self.assertNotIn("TRUE", text)

        manuscript_manifest = json.loads((ROOT / "MANUSCRIPT_ASSET_MANIFEST.json").read_text(encoding="utf-8"))
        manifest_blob = json.dumps(manuscript_manifest)
        self.assertNotIn("analysis_figures/component_evolution", manifest_blob)
        bundle_manifest = (support_dir / "manifest.csv").read_text(encoding="utf-8")
        self.assertIn("analysis_component", bundle_manifest)

    def test_overleaf_bundle_excludes_large_compact_support_data(self) -> None:
        support_dir = (
            ROOT
            / "artifacts"
            / "representative_selected_model_2022_12_25"
            / "authoritative_support"
        )
        forbidden = [
            "authoritative_component_summary.csv",
            "authoritative_component_summary.rds",
            "authoritative_usgs_quantile_dynamics_summary.csv",
            "authoritative_usgs_quantile_dynamics_summary.rds",
            "authoritative_selected_support_manifest.json",
            "authoritative_selected_support_lineage.csv",
        ]
        for filename in forbidden:
            self.assertFalse((support_dir / filename).exists(), f"large support payload should stay external: {filename}")

        refresh_script = (ROOT / "scripts" / "refresh_authoritative_selected_model_support_figures.py").read_text(
            encoding="utf-8"
        )
        self.assertIn("tempfile.TemporaryDirectory", refresh_script)
        self.assertIn("external_support_data", refresh_script)
        self.assertNotIn("copy_required_support", refresh_script)

    def test_generated_table_builder_uses_single_five_decimal_policy(self) -> None:
        script = ROOT / "scripts" / "build_generated_table_includes.py"
        text = script.read_text(encoding="utf-8")
        self.assertIn("DISPLAY_DIGITS = 5", text)
        self.assertNotIn(":.4f", text)
        self.assertNotIn(", 3)", text)
        self.assertIn("fmt_display", text)
        self.assertIn("table-format=-1.5", text)

    def test_generated_table_decimal_cells_have_five_places(self) -> None:
        table_dir = ROOT / "tables" / "generated_tex"
        self.assertTrue(table_dir.exists(), f"missing generated table dir: {table_dir}")
        decimal = re.compile(r"(?<![A-Za-z0-9/])-?\d+\.(\d+)")
        bad: list[str] = []
        for path in sorted(table_dir.glob("*.tex")):
            for lineno, line in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
                if "&" not in line or line.lstrip().startswith("%"):
                    continue
                if line.startswith("Model &") or line.startswith("Ablation model &") or line.startswith("RAW-"):
                    pass
                for match in decimal.finditer(line):
                    if len(match.group(1)) != 5:
                        bad.append(f"{path.relative_to(ROOT)}:{lineno}:{match.group(0)}")
        self.assertEqual(bad, [])


if __name__ == "__main__":
    unittest.main()
