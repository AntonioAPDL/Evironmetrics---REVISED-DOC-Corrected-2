from __future__ import annotations

import json
import re
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class ArticleA1AndTableContractTests(unittest.TestCase):
    def test_software_availability_manifest_and_text_are_wired(self) -> None:
        manifest_path = ROOT / "artifacts" / "software_availability" / "software_availability_manifest.json"
        self.assertTrue(manifest_path.exists(), f"missing software availability manifest: {manifest_path}")
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        self.assertEqual(manifest.get("schema_version"), "revision_software_availability_v1")
        self.assertEqual(
            manifest.get("public_estimation_package", {}).get("cran_package_url"),
            "https://CRAN.R-project.org/package=exdqlm",
        )
        self.assertEqual(
            manifest.get("public_estimation_package", {}).get("package_doi"),
            "https://doi.org/10.32614/CRAN.package.exdqlm",
        )
        self.assertEqual(
            manifest.get("study_workflow_repository", {}).get("public_url"),
            "https://github.com/AntonioAPDL/Project1",
        )
        self.assertEqual(
            manifest.get("archive_status", {}).get("workflow_archive_status"),
            "pending_final_release",
        )
        self.assertEqual(manifest.get("archive_status", {}).get("workflow_archive_doi"), "pending")
        article = (ROOT / "wileyNJD-APA.tex").read_text(encoding="utf-8")
        self.assertIn(r"CRAN R package \texttt{exdqlm}", article)
        self.assertIn("https://CRAN.R-project.org/package=exdqlm", article)
        self.assertIn("https://doi.org/10.32614/CRAN.package.exdqlm", article)
        self.assertIn("https://github.com/AntonioAPDL/Project1", article)
        self.assertIn("permanent archival release of the workflow repository will be created", article)
        self.assertNotIn("workflow repository has been archived", article)

    def test_runtime_benchmark_manifest_and_text_are_wired(self) -> None:
        manifest_path = ROOT / "artifacts" / "runtime_benchmark" / "runtime_manifest.json"
        self.assertTrue(manifest_path.exists(), f"missing runtime benchmark manifest: {manifest_path}")
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        self.assertEqual(manifest.get("schema_version"), "he1_runtime_benchmark_v1")
        self.assertEqual(manifest.get("interface_table", {}).get("row_count"), 1620)
        self.assertEqual(manifest.get("interface_table", {}).get("column_count"), 127)
        self.assertEqual(
            manifest.get("interface_table", {}).get("practical_total_runtime_columns"),
            ["runtime_sec_total", "runtime_sec"],
        )
        self.assertEqual(
            manifest.get("interface_table", {}).get("mostly_missing_decomposition_columns"),
            ["runtime_sec_fit", "runtime_sec_forecast"],
        )
        planned = manifest.get("planned_run_manifest", {})
        self.assertEqual((planned.get("planned_run_units"), planned.get("done"), planned.get("pending")), (72, 54, 18))
        self.assertFalse(manifest.get("claims_policy", {}).get("report_fit_forecast_decomposition"))

        article = (ROOT / "wileyNJD-APA.tex").read_text(encoding="utf-8")
        self.assertIn("about two hours end-to-end", article)
        self.assertIn(r"\texttt{runtime\_sec\_total}", article)
        self.assertIn(r"\texttt{runtime\_sec}", article)
        self.assertIn("hardware- and implementation-dependent", article)
        self.assertNotIn("100 minutes for fitting", article)
        self.assertNotIn("20 minutes for post-processing", article)

    def test_forecast_design_manifest_and_text_are_wired(self) -> None:
        manifest_path = ROOT / "artifacts" / "forecast_design" / "forecast_design_manifest.json"
        self.assertTrue(manifest_path.exists(), f"missing forecast-design manifest: {manifest_path}")
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        self.assertEqual(manifest.get("schema_version"), "he6_forecast_design_v1")
        self.assertEqual(
            manifest.get("rolling_origin_design", {}).get("held_out_target"),
            "post_cutoff_usgs_only",
        )
        self.assertEqual(
            manifest.get("forecast_origin_inputs", {}).get("forecast_products", {}).get("timing"),
            "latest_issued_at_or_before_cutoff",
        )
        self.assertEqual(
            manifest.get("forecast_origin_inputs", {}).get("local_covariates", {}).get("names"),
            ["precipitation", "soil_moisture"],
        )
        gdpc = manifest.get("forecast_origin_inputs", {}).get("gdpc_pca", {})
        self.assertEqual(gdpc.get("workflow_slot"), "PCA")
        self.assertEqual(gdpc.get("canonical_name"), "GDPC1")
        self.assertFalse(gdpc.get("operational_forecast_product"))
        self.assertFalse(gdpc.get("verification_target"))
        self.assertFalse(manifest.get("claims_policy", {}).get("post_cutoff_usgs_used_for_fit_or_update"))

        self.assertTrue((ROOT / "docs" / "forecast_design_contract.md").exists())
        article = (ROOT / "wileyNJD-APA.tex").read_text(encoding="utf-8")
        self.assertIn("forecast-window precipitation and soil-moisture covariates", article)
        self.assertIn("canonical GDPC/PCA climate-index factor", article)
        self.assertIn("Post-cutoff USGS observations are reserved strictly for verification", article)
        self.assertIn("not treated as an operational forecast product or verification target", article)
        self.assertNotIn("GDPC forecast product", article)

    def test_figure_a1_renderer_uses_samplewise_component_contract(self) -> None:
        script = ROOT / "scripts" / "render_authoritative_selected_model_support_figures.R"
        text = script.read_text(encoding="utf-8")
        self.assertIn(
            'FIGURE_A1_COMPONENT_CONTRACT <- "component_6_plus_trend_component_1_samplewise"',
            text,
        )
        self.assertIn(
            'COMPONENT_6_MINUS_TREND_CONTRACT <- "component_6_minus_trend_component_1_samplewise"',
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
        self.assertEqual(component_analysis.get("figure_count"), 9)
        self.assertIn(
            "component_06_component_6_plus_trend_component_1_samplewise.png",
            component_analysis.get("files", []),
        )
        self.assertIn(
            "component_06_component_6_minus_trend_component_1_samplewise.png",
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
        self.assertIn("component_06_component_6_minus_trend_component_1_samplewise.png", text)
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
        self.assertIn("BENCHMARK_LONG_HORIZON_DAYS = 28", text)
        self.assertIn("BENCHMARK_NWS_COMMON_HORIZON_DAYS = 8", text)
        self.assertIn("BENCHMARK_LONG_RAW_ROW_ORDER = ['RAW-GLOFAS']", text)

    def test_benchmark_tables_separate_28_day_and_nws_common_horizons(self) -> None:
        table_dir = ROOT / "tables" / "generated_tex"
        long_table = table_dir / "benchmark_crps_main_table.tex"
        short_table = table_dir / "benchmark_crps_nws_horizon_table.tex"
        source_csv = table_dir / "benchmark_crps_horizon_summary.csv"
        self.assertTrue(long_table.exists(), f"missing 28-day table: {long_table}")
        self.assertTrue(short_table.exists(), f"missing NWS-horizon table: {short_table}")
        self.assertTrue(source_csv.exists(), f"missing horizon audit CSV: {source_csv}")

        long_text = long_table.read_text(encoding="utf-8")
        short_text = short_table.read_text(encoding="utf-8")
        self.assertIn("Mean 28-day forecast-window CRPS", long_text)
        self.assertIn("RAW-GLOFAS", long_text)
        self.assertNotIn("RAW-NWS &", long_text)
        self.assertIn("normal dynamic linear model baselines", long_text)
        self.assertIn("Mean CRPS over the common eight-day NWS forecast horizon", short_text)
        self.assertIn("RAW-GLOFAS", short_text)
        self.assertIn("RAW-NWS", short_text)
        self.assertIn("forecast leads 1--8", short_text)

        source_text = source_csv.read_text(encoding="utf-8")
        self.assertIn("tab:benchmark_crps_models,RAW-GLOFAS,20210123,28", source_text)
        self.assertNotIn("tab:benchmark_crps_models,RAW-NWS", source_text)
        self.assertIn("tab:benchmark_crps_models_nws_horizon,RAW-NWS,20210123,8", source_text)

    def test_he3_ablation_tables_separate_28_day_and_nws_common_horizons(self) -> None:
        table_dir = ROOT / "tables" / "generated_tex"
        long_table = table_dir / "he3_ablation_crps_main_table.tex"
        short_table = table_dir / "he3_ablation_crps_nws_horizon_table.tex"
        source_csv = table_dir / "he3_ablation_crps_horizon_summary.csv"
        self.assertTrue(long_table.exists(), f"missing HE3 28-day table: {long_table}")
        self.assertTrue(short_table.exists(), f"missing HE3 NWS-horizon table: {short_table}")
        self.assertTrue(source_csv.exists(), f"missing HE3 horizon audit CSV: {source_csv}")

        long_text = long_table.read_text(encoding="utf-8")
        short_text = short_table.read_text(encoding="utf-8")
        self.assertIn("Targeted 28-day ablation", long_text)
        self.assertIn("RAW-GLOFAS", long_text)
        self.assertNotIn("RAW-NWS &", long_text)
        self.assertIn("noH3", long_text)
        self.assertIn("1/6.8068493", long_text)
        self.assertIn("Targeted ablation CRPS over the common eight-day NWS forecast horizon", short_text)
        self.assertIn("RAW-GLOFAS", short_text)
        self.assertIn("RAW-NWS", short_text)
        self.assertIn("forecast leads 1--8", short_text)

        article_text = (ROOT / "wileyNJD-APA.tex").read_text(encoding="utf-8")
        self.assertIn(r"Appendix~\ref{app:he3ablation}", article_text)
        self.assertIn(r"\label{app:he3ablation}", article_text)
        self.assertIn("1/6.8068493", article_text)
        self.assertLess(
            article_text.index(r"\appendix"),
            article_text.index(r"\input{tables/generated_tex/he3_ablation_crps_main_table.tex}"),
        )
        self.assertEqual(
            article_text.count(r"\input{tables/generated_tex/he3_ablation_crps_main_table.tex}"),
            1,
        )
        self.assertEqual(
            article_text.count(r"\input{tables/generated_tex/he3_ablation_crps_nws_horizon_table.tex}"),
            1,
        )

        source_text = source_csv.read_text(encoding="utf-8")
        self.assertIn("tab:he3_ablation_crps,RAW-GLOFAS,20210123,28", source_text)
        self.assertNotIn("tab:he3_ablation_crps,RAW-NWS", source_text)
        self.assertIn("tab:he3_ablation_crps_nws_horizon,RAW-NWS,20210123,8", source_text)

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
