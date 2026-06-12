#!/usr/bin/env python3
from __future__ import annotations

import json
from datetime import datetime
from pathlib import Path
from typing import Any

import yaml

from article_runtime_bindings import binding_as_path, load_runtime_bindings

EXPECTED_CUTOFFS = ["20210123", "20211112", "20211221", "20220511", "20221225"]


def cutoff_dash(cutoff: str) -> str:
    cutoff = str(cutoff).zfill(8)
    return f"{cutoff[:4]}-{cutoff[4:6]}-{cutoff[6:8]}"


def cutoff_slug(cutoff: str) -> str:
    return f"{str(cutoff).zfill(8)}_exal_m_t1"


def read_yaml(path: Path) -> dict[str, Any]:
    with path.open("r", encoding="utf-8") as handle:
        payload = yaml.safe_load(handle) or {}
    if not isinstance(payload, dict):
        raise ValueError(f"YAML root must be a mapping: {path}")
    return payload


def authoritative_manifest_path(article_root: Path, bindings: dict[str, Any] | None = None) -> Path:
    bindings = bindings or load_runtime_bindings(article_root)
    raw = bindings.get("exal_m_t1", {}).get("authoritative_keep_manifest", "")
    if raw:
        return Path(str(raw)).expanduser().resolve()
    return binding_as_path(bindings, "workflow_root") / "docs" / "exdqlm_multivar_keep_authoritative_specs_20260601.yaml"


def load_authoritative_payload(article_root: Path) -> dict[str, Any]:
    return read_yaml(authoritative_manifest_path(article_root))


def load_authoritative_five_run_specs(article_root: Path, runtime_root: Path | None = None) -> list[dict[str, str]]:
    bindings = load_runtime_bindings(article_root)
    payload = read_yaml(authoritative_manifest_path(article_root, bindings))
    metadata = payload.get("metadata", {}) if isinstance(payload.get("metadata"), dict) else {}
    resolved_runtime_root = runtime_root or Path(str(metadata.get("runtime_root") or binding_as_path(bindings, "exal_m_t1", "keep_runtime_root"))).expanduser().resolve()
    rows: list[dict[str, str]] = []
    for winner in payload.get("winners", []):
        cutoff = str(winner["cutoff"]).zfill(8)
        rows.append(
            {
                "slug": cutoff_slug(cutoff),
                "cutoff": cutoff_dash(cutoff),
                "cutoff_code": cutoff,
                "published_crps": f"{float(winner['mean_crps']):.4f}",
                "run_id": str(winner["run_id"]),
                "multivar_run_id": str(winner["run_id"]),
                "grid_spec_id": str(winner["grid_spec_id"]),
                "runtime_root": str(resolved_runtime_root),
                "runtime_run_root": str(resolved_runtime_root / "runs" / str(winner["run_id"])),
                "authoritative_manifest": str(authoritative_manifest_path(article_root, bindings)),
                "source_lineage": "exdqlm_multivar_keep_canonical_grid_20260524:authoritative_winner",
            }
        )
    observed = [row["cutoff_code"] for row in rows]
    if observed != EXPECTED_CUTOFFS:
        raise ValueError(f"authoritative exAL-M-T1 cutoffs out of order: {observed}")
    return rows


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("--article-root", type=Path, default=Path(__file__).resolve().parents[1])
    args = parser.parse_args()
    print(json.dumps(load_authoritative_five_run_specs(args.article_root.resolve()), indent=2))
