# Five-Cutoff CRPS Validation Sources

This artifact bundle freezes the five authoritative canonical-grid `exAL-M-T1` run roots used by the revised article benchmark table refresh.

Refresh script:
- `scripts/refresh_exal_m_t1_generated_assets.py`

For each cutoff, the local freeze contains:
- `summary.json`
- `compare_report.json`
- `crps_forecast_summary.csv`

These files are copied from the CRPS-selected canonical-grid `exdqlm_multivar_keep` winner root.
