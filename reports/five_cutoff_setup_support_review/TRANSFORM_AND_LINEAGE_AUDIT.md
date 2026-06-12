# Setup/Support Transform And Lineage Audit

This report verifies three things for the revised article setup/support figures:

1. `retros_daily.csv` is only a single `log1p` transform of the raw retrospective lineage.
2. forecast ensemble inputs staged into the long-history figure bundles match the representative selected-run forecast bundles exactly.
3. the visually odd low-flow retrospective behavior is already present in the raw source lineage; the revised support figures now display flow on the `log1p` support scale rather than the harsher internal `log(log(1+x))` scale.

## Representative Cutoff

- `2022-12-25` now renders with full retrospective support from `1987-05-29` through `2022-12-25`.
- display scale is explicitly `log1p_cms` and the axis label is standardized to `River flow [log(1 + x); x in m^3 s^-1]`.

## Cutoff Checks

| Cutoff | Bundle class | Support window | One-transform USGS | One-transform GloFAS | One-transform NWS | Forecast NWS exact | Forecast GloFAS exact | Overlap rows | Overlap NWS max abs diff |
| --- | --- | --- | ---: | ---: | ---: | --- | --- | ---: | ---: |
| 2021-01-23 | histfix_long_history_bundle | 1987-05-29 to 2021-01-23 | 0.000000000 | 0.000000000 | 0.000000000 | yes | yes | 12294 | 0.000000 |
| 2021-11-12 | histfix_long_history_bundle | 1987-05-29 to 2021-11-12 | 0.000000000 | 0.000000000 | 0.000000000 | yes | yes | 12587 | 0.000000 |
| 2021-12-21 | histfix_long_history_bundle | 1987-05-29 to 2021-12-21 | 0.000000000 | 0.000000000 | 0.000000000 | yes | yes | 12626 | 0.000000 |
| 2022-05-11 | histfix_long_history_bundle | 1987-05-29 to 2022-05-11 | 0.000000000 | 0.000000000 | 0.000000000 | yes | yes | 12767 | 0.000000 |
| 2022-12-25 | histfix_long_history_bundle | 1987-05-29 to 2022-12-25 | 0.000000000 | 0.000000000 | 0.000000000 | yes | yes | 12995 | 0.000000 |

## Interpretation

### 20210123_exal_m_t1

- one-transform check: USGS=`0.000000000`, GloFAS=`0.000000000`, NWS=`0.000000000`
- forecast ensemble provenance: NWS exact=`yes`, GloFAS exact=`yes`
- selected-run overlap: rows=`12294`, window=`1987-05-29` to `2021-01-23`, USGS max abs diff=`0.000000`, GloFAS max abs diff=`0.000000`, NWS max abs diff=`0.000000`
- raw-source behavior: raw lineage already stepped/quantized: GloFAS min non-zero daily step=0.003906 cms; NWS negative daily deltas share=0.597; GloFAS zero-delta share=0.256

### 20211112_exal_m_t1

- one-transform check: USGS=`0.000000000`, GloFAS=`0.000000000`, NWS=`0.000000000`
- forecast ensemble provenance: NWS exact=`yes`, GloFAS exact=`yes`
- selected-run overlap: rows=`12587`, window=`1987-05-29` to `2021-11-12`, USGS max abs diff=`0.000000`, GloFAS max abs diff=`0.000000`, NWS max abs diff=`0.000000`
- raw-source behavior: raw lineage already stepped/quantized: GloFAS min non-zero daily step=0.007812 cms; NWS negative daily deltas share=0.603; GloFAS zero-delta share=0.555

### 20211221_exal_m_t1

- one-transform check: USGS=`0.000000000`, GloFAS=`0.000000000`, NWS=`0.000000000`
- forecast ensemble provenance: NWS exact=`yes`, GloFAS exact=`yes`
- selected-run overlap: rows=`12626`, window=`1987-05-29` to `2021-12-21`, USGS max abs diff=`0.000000`, GloFAS max abs diff=`0.000000`, NWS max abs diff=`0.000000`
- raw-source behavior: raw lineage already stepped/quantized: GloFAS min non-zero daily step=0.007812 cms; NWS negative daily deltas share=0.596; GloFAS zero-delta share=0.554

### 20220511_exal_m_t1

- one-transform check: USGS=`0.000000000`, GloFAS=`0.000000000`, NWS=`0.000000000`
- forecast ensemble provenance: NWS exact=`yes`, GloFAS exact=`yes`
- selected-run overlap: rows=`12767`, window=`1987-05-29` to `2022-05-11`, USGS max abs diff=`0.000000`, GloFAS max abs diff=`0.000000`, NWS max abs diff=`0.000000`
- raw-source behavior: raw lineage already stepped/quantized: GloFAS min non-zero daily step=0.007812 cms; NWS negative daily deltas share=0.599; GloFAS zero-delta share=0.554
- note: the long-history bundle and the representative selected run are numerically identical across the full overlap. The earlier sharp panel-C behavior came from combining full-history low-flow floor values with the old `log(log(1+x))` display scale rather than from a source mismatch.

### 20221225_exal_m_t1

- one-transform check: USGS=`0.000000000`, GloFAS=`0.000000000`, NWS=`0.000000000`
- forecast ensemble provenance: NWS exact=`yes`, GloFAS exact=`yes`
- selected-run overlap: rows=`12995`, window=`1987-05-29` to `2022-12-25`, USGS max abs diff=`0.000000`, GloFAS max abs diff=`0.000000`, NWS max abs diff=`0.000000`
- raw-source behavior: raw lineage already stepped/quantized: GloFAS min non-zero daily step=0.007812 cms; NWS negative daily deltas share=0.609; GloFAS zero-delta share=0.557
- note: the repaired long-history bundle now matches the representative selected run across the full overlap for USGS, GloFAS, and NWS while preserving the repaired pre-window historical support.

## Conclusion

- No evidence of accidental double transformation was found in the revised setup/support workflow.
- Forecast ensembles used in the support figures remain aligned with the representative selected-run forecast bundles.
- The unusual low-flow sawtooth patterns in the long-history retrospective panels are already present in the raw retrospective source lineage, but the support figures now render them on the `log1p` support scale to avoid pathological near-zero `log(log(1+x))` spikes.

