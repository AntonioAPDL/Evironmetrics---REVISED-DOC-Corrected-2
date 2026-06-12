# HE3 ablation audit

This audit checks that each launched HE3 ablation row is a structural simplification
of the cutoff-specific winning full model rather than a different data/configuration run.

## Launch-row audit

| Cutoff | Variant | Config inheritance | Runtime input hashes | Target model id | Overall | Mean CRPS | Delta vs full | Delta vs HE2 drop | Notes |
|---|---|---|---|---|---|---:|---:|---:|---|
| 01/23/2021 | `noH1` | `True` | `True` | `True` | `True` | 1.278609 | 1.138900 |  | ok |
| 01/23/2021 | `noH2` | `True` | `True` | `True` | `True` | 0.726896 | 0.587187 |  | ok |
| 01/23/2021 | `noH3` | `True` | `True` | `True` | `True` | 1.082814 | 0.943105 |  | ok |
| 01/23/2021 | `noTF` | `True` | `True` | `True` | `True` | 1.736096 | 1.596387 | 0.514593 | ok |
| 01/23/2021 | `noTrend` | `True` | `True` | `True` | `True` | 1.051592 | 0.911883 |  | ok |
| 11/12/2021 | `noH1` | `True` | `True` | `True` | `True` | 1.601420 | 1.554184 |  | ok |
| 11/12/2021 | `noH2` | `True` | `True` | `True` | `True` | 1.047240 | 1.000004 |  | ok |
| 11/12/2021 | `noH3` | `True` | `True` | `True` | `True` | 1.035625 | 0.988388 |  | ok |
| 11/12/2021 | `noTF` | `True` | `True` | `True` | `True` | 1.912852 | 1.865616 | 0.114176 | ok |
| 11/12/2021 | `noTrend` | `True` | `True` | `True` | `True` | 0.723427 | 0.676191 |  | ok |
| 12/21/2021 | `noH1` | `True` | `True` | `True` | `True` | 2.938406 | 2.673034 |  | ok |
| 12/21/2021 | `noH2` | `True` | `True` | `True` | `True` | 2.935784 | 2.670412 |  | ok |
| 12/21/2021 | `noH3` | `True` | `True` | `True` | `True` | 2.686675 | 2.421303 |  | ok |
| 12/21/2021 | `noTF` | `True` | `True` | `True` | `True` | 1.794516 | 1.529144 | 0.709486 | ok |
| 12/21/2021 | `noTrend` | `True` | `True` | `True` | `True` | 2.520427 | 2.255055 |  | ok |
| 05/11/2022 | `noH1` | `True` | `True` | `True` | `True` | 1.158967 | 1.126642 |  | ok |
| 05/11/2022 | `noH2` | `True` | `True` | `True` | `True` | 0.820201 | 0.787876 |  | ok |
| 05/11/2022 | `noH3` | `True` | `True` | `True` | `True` | 0.729399 | 0.697074 |  | ok |
| 05/11/2022 | `noTF` | `True` | `True` | `True` | `True` | 1.596938 | 1.564613 | -0.534085 | ok |
| 05/11/2022 | `noTrend` | `True` | `True` | `True` | `True` | 0.550411 | 0.518086 |  | ok |
| 12/25/2022 | `noH1` | `True` | `True` | `True` | `True` | 4.812205 | 4.146745 |  | ok |
| 12/25/2022 | `noH2` | `True` | `True` | `True` | `True` | 4.450271 | 3.784811 |  | ok |
| 12/25/2022 | `noH3` | `True` | `True` | `True` | `True` | 4.144780 | 3.479320 |  | ok |
| 12/25/2022 | `noTF` | `True` | `True` | `True` | `True` | 2.367420 | 1.701961 | 1.156101 | ok |
| 12/25/2022 | `noTrend` | `True` | `True` | `True` | `True` | 3.866177 | 3.200718 |  | ok |

## Lead-bucket diagnostics

The table below summarizes mean lead-wise CRPS over four lead buckets.
This helps distinguish a true performance degradation from a malformed run.

### Cutoff 01/23/2021

| Variant | 01-07 | 08-14 | 15-21 | 22-28 |
|---|---:|---:|---:|---:|
| `full` | 0.245 | 0.077 | 0.121 | 0.116 |
| `noH1` | 1.730 | 1.294 | 1.079 | 1.012 |
| `noH2` | 1.177 | 0.707 | 0.540 | 0.483 |
| `noH3` | 1.588 | 1.165 | 0.829 | 0.749 |
| `noTF` | 1.816 | 1.714 | 1.719 | 1.695 |
| `noTrend` | 1.548 | 1.133 | 0.801 | 0.724 |

### Cutoff 11/12/2021

| Variant | 01-07 | 08-14 | 15-21 | 22-28 |
|---|---:|---:|---:|---:|
| `full` | 0.059 | 0.046 | 0.038 | 0.046 |
| `noH1` | 1.700 | 1.629 | 1.561 | 1.516 |
| `noH2` | 1.150 | 1.073 | 1.006 | 0.960 |
| `noH3` | 1.098 | 1.033 | 1.003 | 1.008 |
| `noTF` | 1.898 | 1.942 | 1.887 | 1.924 |
| `noTrend` | 0.781 | 0.716 | 0.693 | 0.704 |

### Cutoff 12/21/2021

| Variant | 01-07 | 08-14 | 15-21 | 22-28 |
|---|---:|---:|---:|---:|
| `full` | 0.650 | 0.191 | 0.080 | 0.140 |
| `noH1` | 3.835 | 3.223 | 2.548 | 2.147 |
| `noH2` | 3.792 | 3.239 | 2.558 | 2.154 |
| `noH3` | 3.576 | 2.974 | 2.300 | 1.896 |
| `noTF` | 1.934 | 1.826 | 1.729 | 1.688 |
| `noTrend` | 3.405 | 2.807 | 2.136 | 1.734 |

### Cutoff 05/11/2022

| Variant | 01-07 | 08-14 | 15-21 | 22-28 |
|---|---:|---:|---:|---:|
| `full` | 0.028 | 0.025 | 0.025 | 0.051 |
| `noH1` | 1.223 | 1.171 | 1.135 | 1.107 |
| `noH2` | 0.903 | 0.835 | 0.792 | 0.751 |
| `noH3` | 0.788 | 0.746 | 0.706 | 0.678 |
| `noTF` | 1.613 | 1.557 | 1.622 | 1.597 |
| `noTrend` | 0.611 | 0.565 | 0.528 | 0.498 |

### Cutoff 12/25/2022

| Variant | 01-07 | 08-14 | 15-21 | 22-28 |
|---|---:|---:|---:|---:|
| `full` | 0.720 | 0.438 | 0.918 | 0.586 |
| `noH1` | 4.085 | 4.741 | 5.712 | 4.710 |
| `noH2` | 3.692 | 4.392 | 5.362 | 4.355 |
| `noH3` | 3.454 | 4.075 | 5.032 | 4.018 |
| `noTF` | 2.304 | 2.309 | 2.581 | 2.276 |
| `noTrend` | 3.174 | 3.798 | 4.755 | 3.738 |

