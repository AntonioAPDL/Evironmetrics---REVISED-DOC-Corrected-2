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
  glofas = "#C66743",
  nws = "#6B5B8E",
  ochre = "#B6892F",
  usgs = "#242A2F",
  sage = "#6E8B70",
  sky = "#6E91B7",
  mauve = "#8A6F84",
  other = "#8A9399"
)

model_labels <- c(
  "exAL-M-T1" = "Selected model",
  "AL-M-T1" = "AL synthesis",
  "RAW-GLOFAS" = "GloFAS",
  "RAW-NWS" = "NWS"
)

model_label <- function(x) {
  dplyr::recode(x, !!!as.list(model_labels), .default = x)
}

palette <- c(
  "Selected model" = poster_cols[["title"]],
  "AL synthesis" = poster_cols[["ochre"]],
  "GloFAS" = poster_cols[["glofas"]],
  "NWS" = poster_cols[["nws"]],
  "Other Bayesian variants" = poster_cols[["other"]]
)

shape_values <- c(
  "Selected model" = 16,
  "AL synthesis" = 18,
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

crps_28d_plot <- crps_28d |>
  group_by(cutoff) |>
  mutate(
    raw_glofas = crps[model == "RAW-GLOFAS"][1],
    ratio_raw_glofas = crps / raw_glofas,
    winner = model[which.min(crps)],
    display_group = case_when(
      model %in% c("exAL-M-T1", "AL-M-T1", "RAW-GLOFAS") ~ model_label(model),
      TRUE ~ "Other Bayesian variants"
    )
  ) |>
  ungroup() |>
  mutate(
    cutoff_panel = factor(cutoff_label, levels = rev(cutoff_map$cutoff_label)),
    display_group = factor(display_group, levels = c("Selected model", "AL synthesis", "GloFAS", "Other Bayesian variants"))
  )

winner_28d <- crps_28d_plot |>
  group_by(cutoff, cutoff_panel) |>
  slice_min(crps, n = 1, with_ties = FALSE) |>
  ungroup() |>
  mutate(winner_text = paste0("lowest: ", model_label(model)))

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
    breaks = c("Selected model", "AL synthesis", "GloFAS", "Other Bayesian variants")
  ) +
  scale_shape_manual(
    values = shape_values[c("Selected model", "AL synthesis", "GloFAS", "Other Bayesian variants")],
    breaks = c("Selected model", "AL synthesis", "GloFAS", "Other Bayesian variants")
  ) +
  labs(
    title = "28-day CRPS across five\nheld-out rolling origins",
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
        shape = unname(shape_values[c("Selected model", "AL synthesis", "GloFAS", "Other Bayesian variants")])
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
    model_display = factor(model_label(model), levels = c("Selected model", "AL synthesis", "NWS", "GloFAS"))
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
  scale_color_manual(values = palette[c("Selected model", "AL synthesis", "NWS", "GloFAS")]) +
  scale_shape_manual(values = shape_values[c("Selected model", "AL synthesis", "NWS", "GloFAS")]) +
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
  annotate("text", x = 4.4, y = 5.45, label = "NWS check\n1-8 d", color = poster_cols[["nws"]], size = 5.1, fontface = "bold", lineheight = 0.92) +
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
  ~id, ~x, ~y, ~w, ~h, ~label, ~fill, ~text_col,
  "usgs", 0.4, 4.75, 2.25, 0.75, "USGS\nobservations", poster_cols[["white"]], poster_cols[["ink"]],
  "retro", 0.4, 3.78, 2.25, 0.75, "retrospective\nproducts", poster_cols[["white"]], poster_cols[["ink"]],
  "fcst", 0.4, 2.81, 2.25, 0.75, "GloFAS / NWS\nforecast products", "#E8F0F4", poster_cols[["title"]],
  "covs", 0.4, 1.84, 2.25, 0.75, "precipitation\nsoil moisture\nGDPC climate summary", "#EEF3EE", poster_cols[["title"]],
  "latent", 3.35, 4.35, 2.75, 0.85, "shared latent\nriver-flow quantile", "#E8F0F2", poster_cols[["title"]],
  "disc", 3.35, 3.18, 2.75, 0.85, "source-specific\ncorrections", poster_cols[["panel"]], poster_cols[["title"]],
  "transfer", 3.35, 2.01, 2.75, 0.85, "forecast-window\nexogenous adjustment", "#F4EAD2", poster_cols[["title"]],
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
    title = "Source-aware quantile correction and synthesis",
    subtitle = "Retrospective products identify source corrections before the origin;\nforecast products enter through those corrected channels."
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
    component_contract <- "component_6_plus_trend_component_1_samplewise"
    component_start <- as.Date("2000-01-01")
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

    component_y_range <- range(component_data$median_500, na.rm = TRUE)
    component_y_top <- component_y_range[2] - 0.05 * diff(component_y_range)

    component_palette <- c(
      "5th target quantile" = poster_cols[["sage"]],
      "median target quantile" = poster_cols[["title"]],
      "95th target quantile" = poster_cols[["hydro"]]
    )

    pc <- ggplot(component_data, aes(x = date, y = median_500, color = quantile_label)) +
      annotate(
        "rect", xmin = dry_start, xmax = dry_end, ymin = -Inf, ymax = Inf,
        fill = "#F4EAD2", alpha = 0.74
      ) +
      annotate(
        "rect", xmin = wet_start, xmax = wet_end, ymin = -Inf, ymax = Inf,
        fill = "#E8F0F4", alpha = 0.78
      ) +
      geom_hline(yintercept = 0, linewidth = 0.55, color = poster_cols[["rule"]]) +
      geom_line(
        data = filter(component_data, quantile != "q50"),
        linewidth = 0.78, alpha = 0.82
      ) +
      geom_line(
        data = filter(component_data, quantile == "q50"),
        linewidth = 1.25
      ) +
      annotate(
        "text", x = as.Date("2014-07-01"), y = component_y_top,
        label = "dry\n2012-2016", color = poster_cols[["ochre"]],
        fontface = "bold", size = 5.3, lineheight = 0.92
      ) +
      annotate(
        "text", x = as.Date("2018-07-01"), y = component_y_top,
        label = "wet\n2017-2019", color = poster_cols[["hydro"]],
        fontface = "bold", size = 5.3, lineheight = 0.92
      ) +
      scale_color_manual(
        values = component_palette,
        breaks = c("5th target quantile", "median target quantile", "95th target quantile"),
        labels = c("5th", "median", "95th")
      ) +
      scale_x_date(
        date_breaks = "5 years",
        date_labels = "%Y",
        expand = expansion(mult = c(0.01, 0.015))
      ) +
      labs(
        title = "80-month latent component, 2000-2022",
        subtitle = "Selected exAL-M-T1 fit at the 2022-12-25 origin; posterior medians.",
        x = NULL,
        y = "Component contribution\n(model scale)",
        caption = "Shaded intervals mark dry and wet periods for hydrologic context."
      ) +
      theme_poster(22) +
      guides(color = guide_legend(nrow = 1, byrow = TRUE)) +
      theme(
        legend.position = "bottom",
        legend.text = element_text(size = 13.2),
        axis.title.y = element_text(size = 15, lineheight = 0.95),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 13),
        plot.title = element_text(size = 22.5),
        plot.subtitle = element_text(size = 15.5, margin = margin(b = 8)),
        plot.caption = element_text(size = 11.5),
        panel.grid.major.x = element_line(color = "#E1E5E3", linewidth = 0.35),
        plot.margin = margin(9, 12, 7, 12)
      )

    ggsave(
      filename = file.path(fig_dir, "component_80month_poster.pdf"),
      plot = pc, device = cairo_pdf, width = 8.8, height = 5.8, units = "in"
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
        note = "Poster-specific rendering from authoritative selected-model support data; runtime CSV is not copied into the article repository."
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
