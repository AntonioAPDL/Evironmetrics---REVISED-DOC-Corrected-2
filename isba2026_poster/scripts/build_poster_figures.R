#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(readr)
  library(stringr)
  library(tidyr)
})

args_all <- commandArgs(FALSE)
file_arg <- args_all[str_detect(args_all, "^--file=")][1]
script_path <- normalizePath(str_replace(file_arg, "^--file=", ""), mustWork = TRUE)
poster_dir <- normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
repo_root <- normalizePath(file.path(poster_dir, ".."), mustWork = TRUE)

data_dir <- Sys.getenv(
  "POSTER_DATA_DIR",
  unset = file.path(poster_dir, "data", "derived")
)
fig_dir <- Sys.getenv(
  "POSTER_FIG_DIR",
  unset = file.path(poster_dir, "figures", "generated")
)
dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

env_col <- function(name, default) {
  value <- Sys.getenv(paste0("POSTER_COL_", toupper(name)), unset = "")
  if (nzchar(value)) value else default
}

poster_cols <- c(
  paper = env_col("paper", "#FCFCFA"),
  white = env_col("white", "#FFFFFF"),
  ink = env_col("ink", "#1E252B"),
  title = env_col("title", "#1F3442"),
  muted = env_col("muted", "#5D6870"),
  rule = env_col("rule", "#C9D0D2"),
  panel = env_col("panel", "#F0F2F1"),
  lavender = env_col("lavender", "#F0EDF4"),
  plum = env_col("plum", "#514174"),
  hydro = env_col("hydro", "#3A7180"),
  glofas = env_col("glofas", "#B85A22"),
  nws = env_col("nws", "#6C4A8D"),
  ochre = env_col("ochre", "#A07D2E"),
  usgs = env_col("usgs", "#181D21"),
  sage = env_col("sage", "#667866"),
  sky = env_col("sky", "#748FAA"),
  mauve = env_col("mauve", "#81717F"),
  synth_pink_light = env_col("synth_pink_light", "#F9E2EA"),
  synth_pink_dark = env_col("synth_pink_dark", "#A33A67"),
  other = env_col("other", "#8A9399")
)

model_labels <- c(
  "exAL-M-T1" = "Selected exDQLM",
  "AL-M-T1" = "DQLM",
  "RAW-GLOFAS" = "GloFAS",
  "RAW-NWS" = "NWS"
)

model_label <- function(x) {
  dplyr::recode(x, !!!as.list(model_labels), .default = x)
}

palette <- c(
  "Selected exDQLM" = poster_cols[["plum"]],
  "DQLM" = poster_cols[["ochre"]],
  "GloFAS" = poster_cols[["glofas"]],
  "NWS" = poster_cols[["nws"]],
  "Other Bayesian variants" = poster_cols[["other"]]
)

shape_values <- c(
  "Selected exDQLM" = 16,
  "DQLM" = 18,
  "GloFAS" = 15,
  "NWS" = 17,
  "Other Bayesian variants" = 16
)

cutoff_map <- tibble(
  cutoff = c("20210123", "20211112", "20211221", "20220511", "20221225"),
  cutoff_label = c("Jan 23 2021", "Nov 12 2021", "Dec 21 2021", "May 11 2022", "Dec 25 2022"),
  cutoff_date = as.Date(c("2021-01-23", "2021-11-12", "2021-12-21", "2022-05-11", "2022-12-25"))
)

clean_tex_cell <- function(x) {
  x |>
    str_replace_all("\\\\textbf\\{([^{}]+)\\}", "\\1") |>
    str_replace_all("\\\\texttt\\{([^{}]+)\\}", "\\1") |>
    str_replace_all("\\\\", "") |>
    str_replace_all("\\{", "") |>
    str_replace_all("\\}", "") |>
    str_squish()
}

parse_crps_table <- function(path) {
  lines <- readLines(path, warn = FALSE)
  candidate <- lines |>
    str_subset("&") |>
    str_subset("\\\\\\\\") |>
    str_subset("Model label|Ablation model|toprule|midrule|bottomrule|multicolumn|caption|label|Note", negate = TRUE)

  parsed <- lapply(candidate, function(line) {
    line <- str_remove(line, "\\\\\\\\.*$")
    parts <- str_split(line, "&", simplify = TRUE)
    if (ncol(parts) != 6) return(NULL)
    model <- clean_tex_cell(parts[1])
    values <- clean_tex_cell(parts[2:6])
    tibble(
      model = model,
      cutoff = cutoff_map$cutoff,
      crps = parse_number(values)
    )
  })

  bind_rows(parsed) |>
    filter(!is.na(crps)) |>
    left_join(cutoff_map, by = "cutoff")
}

theme_poster <- function(base_size = 22) {
  theme_minimal(base_size = base_size, base_family = "DejaVu Sans") +
    theme(
      plot.title = element_text(face = "bold", color = poster_cols[["title"]], size = base_size * 1.22),
      plot.subtitle = element_text(color = poster_cols[["muted"]], size = base_size * 0.82, margin = margin(b = 12)),
      axis.title = element_text(face = "bold", color = poster_cols[["ink"]]),
      axis.text = element_text(color = poster_cols[["ink"]]),
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "bottom",
      legend.title = element_blank(),
      legend.text = element_text(size = base_size * 0.74),
      plot.caption = element_text(color = poster_cols[["muted"]], size = base_size * 0.62, hjust = 0),
      plot.margin = margin(12, 18, 12, 18)
    )
}

main_path <- file.path(repo_root, "tables", "generated_tex", "benchmark_crps_main_table.tex")
nws_path <- file.path(repo_root, "tables", "generated_tex", "benchmark_crps_nws_horizon_table.tex")

crps_28d <- parse_crps_table(main_path)
crps_8d <- parse_crps_table(nws_path)

write_csv(crps_28d, file.path(data_dir, "benchmark_crps_28d_long.csv"))
write_csv(crps_8d, file.path(data_dir, "benchmark_crps_8d_long.csv"))

raw_glofas_28d <- crps_28d |>
  filter(model == "RAW-GLOFAS") |>
  select(cutoff, raw_glofas_28d = crps)

crps_28d_plot <- crps_28d |>
  filter(model %in% c(
    "exAL-M-T1", "AL-M-T1",
    "exAL-U-T1", "AL-U-T1", "N-U-T1",
    "RAW-GLOFAS"
  )) |>
  left_join(raw_glofas_28d, by = "cutoff") |>
  mutate(
    ratio_raw_glofas = crps / raw_glofas_28d,
    horizon_note = "1-28 d",
    display_group = case_when(
      model == "exAL-M-T1" ~ "exDQLM",
      model == "AL-M-T1" ~ "DQLM",
      model == "RAW-GLOFAS" ~ "Raw GloFAS (1-28 d)",
      model %in% c("exAL-U-T1", "AL-U-T1", "N-U-T1") ~ "Univariate variants"
    )
  )

nws_8d_reference <- crps_8d |>
  filter(model == "RAW-NWS") |>
  left_join(raw_glofas_28d, by = "cutoff") |>
  mutate(
    ratio_raw_glofas = crps / raw_glofas_28d,
    raw_glofas_28d = raw_glofas_28d,
    model = "RAW-NWS-8D",
    horizon_note = "1-8 d reference",
    display_group = "Raw NWS (1-8 d ref.)"
  )

plot_group_levels <- c(
  "exDQLM",
  "DQLM",
  "Raw GloFAS (1-28 d)",
  "Raw NWS (1-8 d ref.)",
  "Univariate variants"
)

crps_28d_display <- bind_rows(
  crps_28d_plot,
  nws_8d_reference |>
    select(names(crps_28d_plot))
) |>
  mutate(
    cutoff_panel = factor(cutoff_label, levels = rev(cutoff_map$cutoff_label)),
    y_base = as.numeric(cutoff_panel),
    point_y = y_base,
    display_group = factor(display_group, levels = plot_group_levels),
    is_univariate = model %in% c("exAL-U-T1", "AL-U-T1", "N-U-T1")
  )

write_csv(crps_28d_display, file.path(data_dir, "benchmark_crps_results_plot_points.csv"))

winner_28d <- crps_28d_display |>
  filter(horizon_note == "1-28 d", model != "RAW-GLOFAS") |>
  group_by(cutoff, cutoff_panel, y_base) |>
  slice_min(crps, n = 1, with_ties = FALSE) |>
  ungroup() |>
  mutate(
    winner_text = paste0(sprintf("%.2f", ratio_raw_glofas), "x"),
    label_y = y_base + 0.18
  )

p28_palette <- c(
  "exDQLM" = poster_cols[["plum"]],
  "DQLM" = poster_cols[["ochre"]],
  "Raw GloFAS (1-28 d)" = poster_cols[["glofas"]],
  "Raw NWS (1-8 d ref.)" = poster_cols[["nws"]],
  "Univariate variants" = poster_cols[["other"]]
)

p28_shapes <- c(
  "exDQLM" = 16,
  "DQLM" = 16,
  "Raw GloFAS (1-28 d)" = 15,
  "Raw NWS (1-8 d ref.)" = 15,
  "Univariate variants" = 1
)
p28_model_groups <- c("exDQLM", "DQLM")
p28_raw_groups <- c("Raw GloFAS (1-28 d)", "Raw NWS (1-8 d ref.)")

p28 <- ggplot(crps_28d_display, aes(y = point_y)) +
  geom_segment(
    data = winner_28d,
    aes(x = ratio_raw_glofas, xend = 1, y = y_base, yend = y_base),
    inherit.aes = FALSE,
    linewidth = 1.0, color = poster_cols[["rule"]], alpha = 0.82
  ) +
  geom_vline(
    xintercept = 1, linewidth = 0.78, linetype = "dashed",
    color = poster_cols[["muted"]]
  ) +
  geom_point(
    data = crps_28d_display |> filter(is_univariate),
    aes(x = ratio_raw_glofas, color = display_group, shape = display_group),
    size = 3.15, stroke = 0.9, alpha = 0.74
  ) +
  geom_point(
    data = crps_28d_display |> filter(as.character(display_group) %in% p28_raw_groups),
    aes(x = ratio_raw_glofas, color = display_group, shape = display_group),
    size = 4.25, stroke = 1.05, alpha = 0.9
  ) +
  geom_point(
    data = crps_28d_display |> filter(as.character(display_group) %in% p28_model_groups),
    aes(x = ratio_raw_glofas, color = display_group, shape = display_group),
    size = 4.35, stroke = 1.05
  ) +
  geom_label(
    data = winner_28d,
    aes(x = ratio_raw_glofas, y = label_y, label = winner_text),
    inherit.aes = FALSE,
    hjust = 0.5, size = 4.65, fontface = "bold", linewidth = 0,
    color = poster_cols[["plum"]],
    fill = poster_cols[["white"]], label.padding = unit(0.12, "lines"),
    show.legend = FALSE
  ) +
  annotate(
    "text", x = 0.94, y = 5.52, label = "raw GloFAS\n1-28 d",
    hjust = 1, vjust = 0.5, color = poster_cols[["glofas"]],
    size = 4.8, fontface = "bold", lineheight = 0.9
  ) +
  annotate(
    "text", x = 0.065, y = 5.52, label = "lower CRPS",
    hjust = 0, vjust = 0.5, color = poster_cols[["hydro"]],
    size = 4.9, fontface = "bold"
  ) +
  scale_x_log10(
    limits = c(0.06, 12.5),
    breaks = c(0.1, 0.25, 0.5, 1, 2, 4, 8),
    labels = c("0.10x", "0.25x", "0.50x", "1.0x", "2x", "4x", "8x")
  ) +
  scale_y_continuous(
    breaks = seq_along(levels(crps_28d_display$cutoff_panel)),
    labels = levels(crps_28d_display$cutoff_panel)
  ) +
  scale_color_manual(values = p28_palette, breaks = plot_group_levels) +
  scale_shape_manual(values = p28_shapes, breaks = plot_group_levels) +
  labs(
    x = "Mean CRPS relative to raw GloFAS at the same origin",
    y = NULL
  ) +
  guides(
    shape = "none",
    color = guide_legend(
      nrow = 2, byrow = TRUE,
      override.aes = list(
        size = c(4.8, 4.8, 4.8, 4.8, 3.8),
        shape = unname(p28_shapes[plot_group_levels])
      )
    )
  ) +
  theme_poster(25) +
  coord_cartesian(ylim = c(0.46, 5.64), clip = "off") +
  theme(
    legend.position = "bottom",
    legend.justification = "left",
    legend.box.margin = margin(t = 0, r = 0, b = 0, l = 0),
    legend.key.width = unit(0.72, "cm"),
    panel.grid.major.x = element_line(color = "#E3E6E4", linewidth = 0.62),
    panel.grid.major.y = element_line(color = "#ECEFEE", linewidth = 0.42),
    axis.text.y = element_text(size = 23, color = poster_cols[["ink"]]),
    axis.text.x = element_text(size = 19, color = poster_cols[["ink"]]),
    axis.title.x = element_text(size = 23, color = poster_cols[["title"]]),
    plot.margin = margin(8, 14, 6, 10)
  )

ggsave(
  filename = file.path(fig_dir, "crps_28d_poster.pdf"),
  plot = p28, device = cairo_pdf, width = 13.0, height = 8.4, units = "in"
)

crps_8d_plot <- crps_8d |>
  filter(model %in% c("RAW-GLOFAS", "RAW-NWS", "AL-M-T1", "exAL-M-T1")) |>
  group_by(cutoff) |>
  mutate(
    best_crps = min(crps),
    ratio_best = crps / best_crps,
    winner = model[which.min(crps)]
  ) |>
  ungroup() |>
  mutate(
    cutoff_panel = factor(cutoff_label, levels = rev(cutoff_map$cutoff_label)),
    model_display = factor(model_label(model), levels = c("Selected exDQLM", "DQLM", "NWS", "GloFAS"))
  )

winner_8d <- crps_8d_plot |>
  group_by(cutoff, cutoff_panel) |>
  slice_min(crps, n = 1, with_ties = FALSE) |>
  ungroup() |>
  mutate(winner_text = paste0("lowest: ", model_label(model)))

p8 <- ggplot(crps_8d_plot, aes(x = ratio_best, y = cutoff_panel, color = model_display, shape = model_display)) +
  geom_vline(xintercept = 1, linewidth = 0.7, color = poster_cols[["ink"]]) +
  geom_point(size = 6.0, stroke = 1.15) +
  geom_line(aes(group = cutoff_panel), linewidth = 0.8, color = poster_cols[["rule"]]) +
  geom_label(
    data = winner_8d,
    aes(x = 1.18, y = cutoff_panel, label = winner_text),
    inherit.aes = FALSE,
    hjust = 0, size = 5.2, linewidth = 0, fill = poster_cols[["panel"]], color = poster_cols[["title"]],
    label.padding = unit(0.16, "lines")
  ) +
  scale_x_log10(
    limits = c(0.95, 32),
    breaks = c(1, 2, 4, 8, 16, 32),
    labels = c("best", "2x", "4x", "8x", "16x", "32x")
  ) +
  scale_color_manual(values = palette[c("Selected exDQLM", "DQLM", "NWS", "GloFAS")]) +
  scale_shape_manual(values = shape_values[c("Selected exDQLM", "DQLM", "NWS", "GloFAS")]) +
  labs(
    title = "8-day NWS-compatible\ncomparison",
    subtitle = "Days 1-8 only; 1.0 marks the origin-specific winner.",
    x = "Mean CRPS / best 8-day CRPS at cutoff",
    y = NULL,
    caption = "Horizon-matched; separate from the 28-day benchmark."
  ) +
  theme_poster(22)

ggsave(
  filename = file.path(fig_dir, "crps_8d_nws_poster.pdf"),
  plot = p8, device = cairo_pdf, width = 8.8, height = 7.6, units = "in"
)

timeline <- cutoff_map |>
  mutate(cutoff_panel = factor(cutoff_label, levels = rev(cutoff_label)))

history_start <- -18

pt <- ggplot(timeline, aes(y = cutoff_panel)) +
  geom_segment(
    aes(x = history_start, xend = 0, yend = cutoff_panel),
    linewidth = 4.2, color = poster_cols[["rule"]], lineend = "round",
    arrow = grid::arrow(length = grid::unit(0.12, "in"), ends = "first", type = "closed")
  ) +
  geom_segment(aes(x = 0.7, xend = 28, yend = cutoff_panel), linewidth = 4.2, color = poster_cols[["glofas"]], lineend = "round") +
  geom_segment(aes(x = 0.7, xend = 8, yend = cutoff_panel), linewidth = 4.2, color = poster_cols[["nws"]], lineend = "round") +
  geom_vline(xintercept = 0, linewidth = 0.8, linetype = "dashed", color = poster_cols[["title"]]) +
  geom_point(aes(x = 0), size = 4.8, color = poster_cols[["title"]]) +
  annotate("text", x = -9.5, y = 5.45, label = "fit archive\nfrozen", color = poster_cols[["muted"]], size = 5.1, fontface = "bold", lineheight = 0.92) +
  annotate("text", x = 4.4, y = 5.45, label = "NWS\n1-8 d", color = poster_cols[["nws"]], size = 5.1, fontface = "bold", lineheight = 0.92) +
  annotate("text", x = 21.8, y = 5.45, label = "GloFAS\n1-28 d", color = poster_cols[["glofas"]], size = 5.1, fontface = "bold", lineheight = 0.92) +
  scale_x_continuous(
    limits = c(-21, 30),
    breaks = c(history_start, 0, 8, 28),
    labels = c("history", "origin", "+8 d", "+28 d")
  ) +
  labs(
    x = NULL,
    y = NULL
  ) +
  coord_cartesian(ylim = c(0.55, 5.65), clip = "off") +
  theme_poster(22) +
  theme(
    legend.position = "none",
    axis.text.x = element_text(face = "bold", color = poster_cols[["ink"]]),
    plot.margin = margin(12, 18, 10, 18)
  )

ggsave(
  filename = file.path(fig_dir, "rolling_origin_timeline.pdf"),
  plot = pt, device = cairo_pdf, width = 9.2, height = 5.25, units = "in"
)

box_df <- tibble::tribble(
  ~id, ~x, ~y, ~w, ~h, ~label, ~fill, ~border_col, ~text_col,
  "usgs", 0.35, 4.88, 2.85, 0.82, "USGS flow\ny^o_t\nfuture held out", poster_cols[["white"]], poster_cols[["usgs"]], poster_cols[["ink"]],
  "retro", 0.35, 3.86, 2.85, 0.82, "retrospectives\nz^j_t", poster_cols[["white"]], poster_cols[["rule"]], poster_cols[["ink"]],
  "fcst", 0.35, 2.84, 2.85, 0.82, "issued ensembles\ny_cutoff^{j,i}(k)", "#E8F0F4", poster_cols[["rule"]], poster_cols[["title"]],
  "covs", 0.35, 1.72, 2.85, 0.92, "exogenous covariates\nx_t: precip, soil,\nGDPC climate", "#EEF3EE", poster_cols[["sage"]], poster_cols[["title"]],
  "latent", 4.10, 4.70, 3.25, 0.90, "shared USGS quantile\ntheta_t\ntrend + seasonality", "#E8F0F2", poster_cols[["hydro"]], poster_cols[["title"]],
  "disc", 4.10, 3.58, 3.25, 0.90, "source discrepancies\ndelta_t^j\ncorrection states", poster_cols[["panel"]], poster_cols[["rule"]], poster_cols[["title"]],
  "transfer", 4.10, 2.46, 3.25, 0.90, "transfer component\nzeta_t, psi_t\ndriven by x_t", "#F4EAD2", poster_cols[["sage"]], poster_cols[["title"]],
  "synth", 8.25, 3.50, 2.85, 0.95, "synthesized posterior\npredictive distribution", poster_cols[["synth_pink_light"]], poster_cols[["synth_pink_dark"]], poster_cols[["synth_pink_dark"]],
  "verify", 11.70, 4.10, 2.55, 0.82, "held-out USGS\nverification flow", poster_cols[["white"]], poster_cols[["usgs"]], poster_cols[["title"]],
  "score", 11.70, 2.52, 2.55, 1.06, "synthesis predictive\nperformance\nCRPS = integrated\nquantile loss", poster_cols[["white"]], poster_cols[["plum"]], poster_cols[["title"]]
) |>
  mutate(
    border_key = paste0(id, "_border"),
    text_key = paste0(id, "_text"),
    label_y = if_else(id %in% c("retro", "fcst"), y + h * 0.62, y + h / 2)
  )

lane_note <- tibble::tibble(
  x = 3.86,
  y = 1.18,
  label = "repeat over seven quantile lanes: p0 = .05,...,.95"
)

source_marks <- tibble::tribble(
  ~x, ~y, ~label, ~text_col,
  1.18, 4.05, "GloFAS", poster_cols[["glofas"]],
  2.20, 4.05, "NWS", poster_cols[["nws"]],
  1.18, 3.03, "GloFAS", poster_cols[["glofas"]],
  2.20, 3.03, "NWS", poster_cols[["nws"]]
) |>
  mutate(text_key = paste0("source_", row_number()))

arrow_df <- tibble::tribble(
  ~x, ~y, ~xend, ~yend,
  3.20, 5.29, 4.10, 5.15,
  3.20, 4.27, 4.10, 4.03,
  3.20, 3.25, 4.10, 3.92,
  3.20, 2.18, 4.10, 2.91,
  7.35, 5.15, 8.25, 4.10,
  7.35, 4.03, 8.25, 3.98,
  7.35, 2.91, 8.25, 3.62,
  11.10, 3.98, 11.70, 4.51,
  12.98, 4.10, 12.98, 3.58
)

color_values <- c(
  setNames(box_df$border_col, box_df$border_key),
  setNames(box_df$text_col, box_df$text_key),
  setNames(source_marks$text_col, source_marks$text_key)
)

ps <- ggplot() +
  annotate(
    "rect",
    xmin = 0.10, xmax = 7.60, ymin = 0.95, ymax = 5.92,
    fill = poster_cols[["panel"]], color = poster_cols[["rule"]],
    linewidth = 0.6
  ) +
  geom_segment(
    data = arrow_df,
    aes(x = x, y = y, xend = xend, yend = yend),
    linewidth = 0.7, color = "#748187",
    arrow = arrow(length = unit(0.18, "in"), type = "closed")
  ) +
  geom_rect(
    data = box_df,
    aes(xmin = x, xmax = x + w, ymin = y, ymax = y + h, fill = id, color = border_key),
    linewidth = 0.65
  ) +
  geom_text(
    data = box_df,
    aes(x = x + w / 2, y = label_y, label = label, color = text_key),
    size = 4.25, lineheight = 0.91, fontface = "bold"
  ) +
  geom_text(
    data = source_marks,
    aes(x = x, y = y, label = label, color = text_key),
    size = 3.45, lineheight = 0.92, fontface = "bold"
  ) +
  geom_text(
    data = lane_note,
    aes(x = x, y = y, label = label),
    size = 3.8, lineheight = 0.92, fontface = "bold",
    color = poster_cols[["muted"]]
  ) +
  annotate("text", x = 1.78, y = 6.20, label = "available at\nthe cutoff", fontface = "bold", color = poster_cols[["title"]], size = 5.25, lineheight = 0.92) +
  annotate("text", x = 5.72, y = 6.05, label = "exDQLM correction\nfor fixed p0", fontface = "bold", color = poster_cols[["title"]], size = 5.25, lineheight = 0.92) +
  annotate("text", x = 9.68, y = 6.05, label = "posterior\nsynthesis", fontface = "bold", color = poster_cols[["title"]], size = 5.25, lineheight = 0.92) +
  annotate("text", x = 12.98, y = 6.05, label = "forecast-window\nscoring", fontface = "bold", color = poster_cols[["title"]], size = 5.25, lineheight = 0.92) +
  scale_fill_manual(values = setNames(box_df$fill, box_df$id), guide = "none") +
  scale_color_manual(values = color_values, guide = "none") +
  coord_cartesian(xlim = c(0, 14.55), ylim = c(0.75, 6.45), expand = FALSE) +
  labs(
    title = "Source-aware dynamic quantile correction and synthesis",
    subtitle = "Retrospectives estimate source discrepancies before the cutoff; issued ensembles and origin-bundle covariates\npropagate corrected forecast-window quantiles."
  ) +
  theme_void(base_family = "DejaVu Sans") +
  theme(
    plot.title = element_text(face = "bold", color = poster_cols[["title"]], size = 26),
    plot.subtitle = element_text(color = poster_cols[["muted"]], size = 17, margin = margin(b = 10)),
    plot.margin = margin(10, 10, 10, 10)
  )

ggsave(
  filename = file.path(fig_dir, "model_schematic.pdf"),
  plot = ps, device = cairo_pdf, width = 14.8, height = 9.0, units = "in"
)

support_manifest_path <- file.path(
  repo_root,
  "artifacts",
  "representative_selected_model_2022_12_25",
  "authoritative_support",
  "manifest.csv"
)

if (file.exists(support_manifest_path)) {
  support_manifest <- read_csv(support_manifest_path, show_col_types = FALSE)
  component_source_row <- support_manifest |>
    filter(filename == "authoritative_component_summary.csv") |>
    slice_head(n = 1)

  if (nrow(component_source_row) == 1 && file.exists(component_source_row$source_absolute_path)) {
    component_contract <- "raw_state_component"
    component_start <- as.Date("2008-01-01")
    dry_start <- as.Date("2012-01-01")
    dry_end <- as.Date("2016-12-31")
    wet_start <- as.Date("2017-01-01")
    wet_end <- as.Date("2019-12-31")

    component_data <- read_csv(component_source_row$source_absolute_path, show_col_types = FALSE) |>
      filter(
        date >= component_start,
        component == 6,
        component_contract == !!component_contract,
        quantile %in% c("q05", "q50", "q95")
      ) |>
      mutate(
        quantile_label = recode(
          quantile,
          q05 = "5th target quantile",
          q50 = "median target quantile",
          q95 = "95th target quantile"
        ),
        quantile_label = factor(
          quantile_label,
          levels = c("5th target quantile", "median target quantile", "95th target quantile")
        )
      )

    component_ylim <- c(-0.2, 0.3)
    component_y_top <- 0.255

    component_palette <- c(
      "5th target quantile" = "#8E2F2F",
      "median target quantile" = "#1F6B4A",
      "95th target quantile" = "#1E4F7A"
    )

    dry_label <- tibble(
      x = as.Date("2014-07-01"),
      y = component_y_top,
      label = "dry\n2012-2016"
    )

    wet_label <- tibble(
      x = as.Date("2018-07-01"),
      y = component_y_top,
      label = "wet\n2017-2019"
    )

    pc <- ggplot(component_data, aes(x = date, y = median_500, color = quantile_label, fill = quantile_label)) +
      annotate(
        "rect", xmin = dry_start, xmax = dry_end, ymin = -Inf, ymax = Inf,
        fill = "#F4EAD2", alpha = 0.74
      ) +
      annotate(
        "rect", xmin = wet_start, xmax = wet_end, ymin = -Inf, ymax = Inf,
        fill = "#E8F0F4", alpha = 0.78
      ) +
      geom_hline(yintercept = 0, linewidth = 0.55, color = poster_cols[["rule"]]) +
      geom_ribbon(aes(ymin = lower_025, ymax = upper_975), alpha = 0.18, color = NA, show.legend = FALSE) +
      geom_line(linewidth = 0.82, lineend = "round") +
      geom_text(
        data = dry_label,
        aes(x = x, y = y, label = label),
        inherit.aes = FALSE,
        color = poster_cols[["ochre"]],
        fontface = "bold", size = 4.2, lineheight = 0.92
      ) +
      geom_text(
        data = wet_label,
        aes(x = x, y = y, label = label),
        inherit.aes = FALSE,
        color = poster_cols[["hydro"]],
        fontface = "bold", size = 4.2, lineheight = 0.92
      ) +
      scale_color_manual(
        values = component_palette,
        breaks = c("5th target quantile", "median target quantile", "95th target quantile"),
        labels = c("5th", "50th", "95th")
      ) +
      scale_fill_manual(values = component_palette, guide = "none") +
      scale_x_date(
        limits = c(as.Date("2008-01-01"), as.Date("2022-12-31")),
        date_breaks = "2 years",
        date_labels = "%Y",
        expand = expansion(mult = c(0.01, 0.015))
      ) +
      scale_y_continuous(
        breaks = seq(-0.2, 0.3, by = 0.1),
        expand = expansion(mult = c(0, 0.015))
      ) +
      coord_cartesian(ylim = component_ylim, clip = "on") +
      labs(
        title = "80-month harmonic component, 2008-2022",
        subtitle = "Pure component-6 state: posterior medians and light 95% credible bands.",
        x = NULL,
        y = "Component contribution\n(model scale)",
        caption = "Shaded intervals mark dry and wet regimes."
      ) +
      theme_poster(22) +
      guides(color = guide_legend(nrow = 1, byrow = TRUE)) +
      theme(
        legend.position = "bottom",
        legend.title = element_blank(),
        legend.text = element_text(size = 12.8, color = poster_cols[["title"]]),
        legend.key.width = unit(1.15, "cm"),
        legend.margin = margin(t = -3, b = -4),
        axis.title.y = element_text(size = 15.8, lineheight = 0.95),
        axis.text.x = element_text(size = 14.4),
        axis.text.y = element_text(size = 13.8),
        plot.title = element_text(size = 20.5),
        plot.subtitle = element_text(size = 13.8, margin = margin(b = 8)),
        plot.caption = element_text(size = 11.8),
        panel.grid.major.x = element_line(color = "#E1E5E3", linewidth = 0.35),
        panel.grid.minor = element_blank(),
        plot.margin = margin(9, 12, 5, 12)
      )

    ggsave(
      filename = file.path(fig_dir, "component_80month_poster.pdf"),
      plot = pc, device = cairo_pdf, width = 8.8, height = 4.55, units = "in"
    )

    write_csv(
      tibble(
        generated_asset = "isba2026_poster/figures/generated/component_80month_poster.pdf",
        source_manifest = "artifacts/representative_selected_model_2022_12_25/authoritative_support/manifest.csv",
        source_absolute_path = component_source_row$source_absolute_path,
        expected_sha256 = component_source_row$sha256,
        component = 6,
        component_contract = component_contract,
        date_window_start = as.character(component_start),
        date_window_end = as.character(max(component_data$date, na.rm = TRUE)),
        dry_period = "2012-01-01/2016-12-31",
        wet_period = "2017-01-01/2019-12-31",
        interval = "lower_025/upper_975 credible band with median_500 line",
        note = "Poster-specific single-panel rendering of raw state component 6 only; no trend component is added. Runtime CSV is not copied into the article repository."
      ),
      file.path(data_dir, "component_80month_poster_provenance.csv")
    )
  } else {
    warning("Skipping component_80month_poster.pdf because authoritative component summary is unavailable.")
  }
} else {
  warning("Skipping component_80month_poster.pdf because authoritative support manifest is unavailable.")
}

message("Wrote poster figures and derived data to ", poster_dir)
