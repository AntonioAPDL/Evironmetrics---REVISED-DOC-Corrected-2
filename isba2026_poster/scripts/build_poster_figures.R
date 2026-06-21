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

data_dir <- file.path(poster_dir, "data", "derived")
fig_dir <- file.path(poster_dir, "figures", "generated")
dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

poster_cols <- c(
  paper = "#FBFAF6",
  white = "#FFFFFF",
  ink = "#26323A",
  title = "#263C4C",
  muted = "#606B72",
  rule = "#D5D9D7",
  panel = "#F0F2EF",
  lavender = "#F2EFF6",
  plum = "#6B5B8E",
  hydro = "#2F7C8C",
  glofas = "#3C78A8",
  rust = "#C66743",
  ochre = "#B6892F",
  usgs = "#242A2F",
  sage = "#6E8B70",
  sky = "#6E91B7",
  mauve = "#8A6F84",
  other = "#8A9399"
)

palette <- c(
  "exAL-M-T1" = poster_cols[["plum"]],
  "AL-M-T1" = poster_cols[["ochre"]],
  "RAW-GLOFAS" = poster_cols[["glofas"]],
  "RAW-NWS" = poster_cols[["rust"]],
  "Other Bayesian variants" = poster_cols[["other"]]
)

shape_values <- c(
  "exAL-M-T1" = 16,
  "AL-M-T1" = 18,
  "RAW-GLOFAS" = 15,
  "RAW-NWS" = 17,
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

crps_28d_plot <- crps_28d |>
  group_by(cutoff) |>
  mutate(
    raw_glofas = crps[model == "RAW-GLOFAS"][1],
    ratio_raw_glofas = crps / raw_glofas,
    winner = model[which.min(crps)],
    display_group = case_when(
      model %in% c("exAL-M-T1", "AL-M-T1", "RAW-GLOFAS") ~ model,
      TRUE ~ "Other Bayesian variants"
    )
  ) |>
  ungroup() |>
  mutate(
    cutoff_panel = factor(cutoff_label, levels = rev(cutoff_map$cutoff_label)),
    display_group = factor(display_group, levels = c("exAL-M-T1", "AL-M-T1", "RAW-GLOFAS", "Other Bayesian variants"))
  )

winner_28d <- crps_28d_plot |>
  group_by(cutoff, cutoff_panel) |>
  slice_min(crps, n = 1, with_ties = FALSE) |>
  ungroup() |>
  mutate(winner_text = paste0("lowest: ", model))

p28 <- ggplot(crps_28d_plot, aes(y = cutoff_panel)) +
  geom_vline(xintercept = 1, linewidth = 0.7, linetype = "dashed", color = poster_cols[["muted"]]) +
  geom_point(
    data = filter(crps_28d_plot, display_group == "Other Bayesian variants"),
    aes(x = ratio_raw_glofas, color = display_group),
    position = position_jitter(width = 0, height = 0.07, seed = 25),
    size = 3.3, alpha = 0.42
  ) +
  geom_segment(
    data = filter(crps_28d_plot, model %in% c("exAL-M-T1", "AL-M-T1")) |>
      select(cutoff, cutoff_panel, model, ratio_raw_glofas) |>
      pivot_wider(names_from = model, values_from = ratio_raw_glofas),
    aes(x = `exAL-M-T1`, xend = `AL-M-T1`, y = cutoff_panel, yend = cutoff_panel),
    inherit.aes = FALSE, linewidth = 1.2, color = poster_cols[["rule"]]
  ) +
  geom_point(
    data = filter(crps_28d_plot, display_group != "Other Bayesian variants"),
    aes(x = ratio_raw_glofas, color = display_group, shape = display_group),
    size = 6.5, stroke = 1.15
  ) +
  geom_label(
    data = winner_28d,
    aes(x = 1.16, y = cutoff_panel, label = winner_text),
    inherit.aes = FALSE,
    hjust = 0, size = 5.7, linewidth = 0, fill = poster_cols[["panel"]], color = poster_cols[["title"]],
    label.padding = unit(0.18, "lines")
  ) +
  scale_x_log10(
    limits = c(0.06, 12),
    breaks = c(0.1, 0.25, 0.5, 1, 2, 4, 8),
    labels = c("0.10x", "0.25x", "0.50x", "raw", "2x", "4x", "8x")
  ) +
  scale_color_manual(
    values = palette,
    breaks = c("exAL-M-T1", "AL-M-T1", "RAW-GLOFAS", "Other Bayesian variants")
  ) +
  scale_shape_manual(
    values = shape_values[c("exAL-M-T1", "AL-M-T1", "RAW-GLOFAS", "Other Bayesian variants")],
    breaks = c("exAL-M-T1", "AL-M-T1", "RAW-GLOFAS", "Other Bayesian variants")
  ) +
  labs(
    title = "28-day CRPS: exAL-M-T1 is lowest\nat four of five rolling origins",
    subtitle = "Mean CRPS relative to raw GloFAS at the same cutoff; lower and farther left is better.",
    x = "Mean CRPS / raw GloFAS CRPS",
    y = NULL,
    caption = "Grey points are the remaining Bayesian benchmark variants."
  ) +
  guides(
    shape = "none",
    color = guide_legend(
      override.aes = list(
        alpha = c(1, 1, 1, 0.55),
        size = c(5, 5, 5, 4),
        shape = unname(shape_values[c("exAL-M-T1", "AL-M-T1", "RAW-GLOFAS", "Other Bayesian variants")])
      )
    )
  ) +
  theme_poster(25)

ggsave(
  filename = file.path(fig_dir, "crps_28d_poster.pdf"),
  plot = p28, device = cairo_pdf, width = 13.0, height = 13.0, units = "in"
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
    model = factor(model, levels = c("exAL-M-T1", "AL-M-T1", "RAW-NWS", "RAW-GLOFAS"))
  )

winner_8d <- crps_8d_plot |>
  group_by(cutoff, cutoff_panel) |>
  slice_min(crps, n = 1, with_ties = FALSE) |>
  ungroup() |>
  mutate(winner_text = paste0("lowest: ", model))

p8 <- ggplot(crps_8d_plot, aes(x = ratio_best, y = cutoff_panel, color = model, shape = model)) +
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
  scale_color_manual(values = palette[c("exAL-M-T1", "AL-M-T1", "RAW-NWS", "RAW-GLOFAS")]) +
  scale_shape_manual(values = shape_values[c("exAL-M-T1", "AL-M-T1", "RAW-NWS", "RAW-GLOFAS")]) +
  labs(
    title = "8-day NWS-compatible\ncomparison",
    subtitle = "Days 1--8 only; lower is better.",
    x = "Mean CRPS / best 8-day CRPS at cutoff",
    y = NULL,
    caption = "This is a horizon-matched comparison, not the 28-day medium-range result."
  ) +
  theme_poster(22)

ggsave(
  filename = file.path(fig_dir, "crps_8d_nws_poster.pdf"),
  plot = p8, device = cairo_pdf, width = 8.8, height = 7.6, units = "in"
)

timeline <- cutoff_map |>
  mutate(cutoff_panel = factor(cutoff_label, levels = rev(cutoff_label)))

pt <- ggplot(timeline, aes(y = cutoff_panel)) +
  geom_segment(aes(x = -28, xend = 0, yend = cutoff_panel), linewidth = 4.2, color = poster_cols[["rule"]], lineend = "round") +
  geom_segment(aes(x = 0.7, xend = 28, yend = cutoff_panel), linewidth = 4.2, color = "#D8E8EC", lineend = "round") +
  geom_segment(aes(x = 0.7, xend = 8, yend = cutoff_panel), linewidth = 4.2, color = poster_cols[["rust"]], lineend = "round") +
  geom_vline(xintercept = 0, linewidth = 0.8, linetype = "dashed", color = poster_cols[["title"]]) +
  geom_point(aes(x = 0), size = 4.8, color = poster_cols[["title"]]) +
  annotate("text", x = -14, y = 5.35, label = "fit through cutoff", color = poster_cols[["muted"]], size = 4.9, fontface = "bold") +
  annotate("text", x = 4.2, y = 5.35, label = "8-day NWS", color = poster_cols[["rust"]], size = 4.9, fontface = "bold") +
  annotate("text", x = 20.5, y = 5.35, label = "28-day verification", color = poster_cols[["hydro"]], size = 4.9, fontface = "bold") +
  scale_x_continuous(
    limits = c(-30, 30),
    breaks = c(-28, -14, 0, 8, 28),
    labels = c("-28 d", "-14 d", "cutoff", "+8 d", "+28 d")
  ) +
  labs(
    title = "Five held-out rolling origins",
    subtitle = "Fit through cutoff; score post-cutoff USGS observations only.",
    x = "Days relative to forecast origin",
    y = NULL
  ) +
  theme_poster(22) +
  theme(legend.position = "none")

ggsave(
  filename = file.path(fig_dir, "rolling_origin_timeline.pdf"),
  plot = pt, device = cairo_pdf, width = 8.8, height = 7.6, units = "in"
)

box_df <- tibble::tribble(
  ~id, ~x, ~y, ~w, ~h, ~label, ~fill, ~text_col,
  "usgs", 0.4, 4.75, 2.25, 0.75, "USGS\nobservations", poster_cols[["white"]], poster_cols[["ink"]],
  "retro", 0.4, 3.78, 2.25, 0.75, "retrospective\nproducts", poster_cols[["white"]], poster_cols[["ink"]],
  "fcst", 0.4, 2.81, 2.25, 0.75, "GloFAS / NWS\nforecast products", "#E8F0F4", poster_cols[["title"]],
  "covs", 0.4, 1.84, 2.25, 0.75, "PPT + SOIL\n+ GDPC", "#EEF3EE", poster_cols[["title"]],
  "latent", 3.35, 4.35, 2.75, 0.85, "shared latent\nriver-flow quantile", "#E8F0F2", poster_cols[["title"]],
  "disc", 3.35, 3.18, 2.75, 0.85, "source-specific\ndiscrepancies", poster_cols[["panel"]], poster_cols[["title"]],
  "transfer", 3.35, 2.01, 2.75, 0.85, "retained forecast-window\ntransfer", "#F4EAD2", poster_cols[["title"]],
  "dynamic", 3.35, 0.84, 2.75, 0.85, "trend + seasonal\ndynamics", poster_cols[["panel"]], poster_cols[["title"]],
  "qpred", 6.85, 3.55, 2.85, 0.95, "quantile-specific\nposterior forecasts", "#E8F0F2", poster_cols[["title"]],
  "synth", 6.85, 2.25, 2.85, 0.95, "synthesized predictive\ndistribution", poster_cols[["plum"]], poster_cols[["white"]]
)

arrow_df <- tibble::tribble(
  ~x, ~y, ~xend, ~yend,
  2.65, 5.12, 3.35, 4.78,
  2.65, 4.15, 3.35, 3.60,
  2.65, 3.18, 3.35, 3.60,
  2.65, 2.21, 3.35, 2.43,
  6.10, 4.78, 6.85, 4.03,
  6.10, 3.60, 6.85, 4.03,
  6.10, 2.43, 6.85, 4.03,
  6.10, 1.26, 6.85, 4.03,
  8.28, 3.55, 8.28, 3.20
)

ps <- ggplot() +
  geom_segment(
    data = arrow_df,
    aes(x = x, y = y, xend = xend, yend = yend),
    linewidth = 0.7, color = "#748187",
    arrow = arrow(length = unit(0.18, "in"), type = "closed")
  ) +
  geom_rect(
    data = box_df,
    aes(xmin = x, xmax = x + w, ymin = y, ymax = y + h, fill = id),
    color = poster_cols[["rule"]], linewidth = 0.55
  ) +
  geom_text(
    data = box_df,
    aes(x = x + w / 2, y = y + h / 2, label = label, color = id),
    size = 4.9, lineheight = 0.94, fontface = "bold"
  ) +
  annotate("text", x = 1.5, y = 5.83, label = "available\ninformation", fontface = "bold", color = poster_cols[["title"]], size = 5.8, lineheight = 0.95) +
  annotate("text", x = 4.72, y = 5.83, label = "dynamic Bayesian\nquantile synthesis", fontface = "bold", color = poster_cols[["title"]], size = 5.8, lineheight = 0.95) +
  annotate("text", x = 8.25, y = 5.83, label = "forecast\ndistribution", fontface = "bold", color = poster_cols[["title"]], size = 5.8, lineheight = 0.95) +
  annotate("text", x = 8.28, y = 1.55, label = "scored by held-out\nUSGS observations", color = poster_cols[["muted"]], size = 4.8, lineheight = 0.95) +
  scale_fill_manual(values = setNames(box_df$fill, box_df$id), guide = "none") +
  scale_color_manual(values = setNames(box_df$text_col, box_df$id), guide = "none") +
  coord_cartesian(xlim = c(0, 10.05), ylim = c(0.45, 6.15), expand = FALSE) +
  labs(
    title = "Dynamic quantile synthesis learns source corrections",
    subtitle = "Inputs enter distinct latent blocks before forming one predictive distribution."
  ) +
  theme_void(base_family = "DejaVu Sans") +
  theme(
    plot.title = element_text(face = "bold", color = poster_cols[["title"]], size = 26),
    plot.subtitle = element_text(color = poster_cols[["muted"]], size = 17, margin = margin(b = 10)),
    plot.margin = margin(10, 10, 10, 10)
  )

ggsave(
  filename = file.path(fig_dir, "model_schematic.pdf"),
  plot = ps, device = cairo_pdf, width = 13.0, height = 9.0, units = "in"
)

message("Wrote poster figures and derived data to ", poster_dir)
