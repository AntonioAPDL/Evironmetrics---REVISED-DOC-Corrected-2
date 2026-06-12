#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

parse_args <- function(values) {
  out <- list()
  i <- 1L
  while (i <= length(values)) {
    key <- values[[i]]
    if (!startsWith(key, "--")) stop(sprintf("Unexpected argument: %s", key), call. = FALSE)
    if (i == length(values)) stop(sprintf("Missing value for argument: %s", key), call. = FALSE)
    out[[substring(key, 3L)]] <- values[[i + 1L]]
    i <- i + 2L
  }
  out
}

opt <- parse_args(args)
required <- c("support-dir", "output-dir")
missing <- required[!vapply(required, function(k) !is.null(opt[[k]]) && nzchar(opt[[k]]), logical(1))]
if (length(missing) > 0L) {
  stop(sprintf("Missing required args: %s", paste(missing, collapse = ", ")), call. = FALSE)
}

support_dir <- normalizePath(opt[["support-dir"]], mustWork = TRUE)
out_dir <- normalizePath(opt[["output-dir"]], mustWork = FALSE)
workflow_root <- opt[["workflow-root"]]
display_flow_scale <- opt[["display-flow-scale"]]
if (is.null(display_flow_scale) || !nzchar(display_flow_scale)) display_flow_scale <- "log1p_cms"
metadata_support_dir <- opt[["metadata-support-dir"]]
if (is.null(metadata_support_dir) || !nzchar(metadata_support_dir)) metadata_support_dir <- support_dir

dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

if (!is.null(workflow_root) && nzchar(workflow_root)) {
  style_path <- file.path(normalizePath(workflow_root, mustWork = TRUE), "scripts", "figure_style_contract.R")
  if (file.exists(style_path)) source(style_path)
}

if (!exists("theme_manuscript_standard", mode = "function")) {
  theme_manuscript_standard <- function(...) ggplot2::theme_bw(base_size = 13)
}
if (!exists("figure_flow_axis_label", mode = "function")) {
  figure_flow_axis_label <- function(scale) scale
}

suppressPackageStartupMessages({
  library(ggplot2)
})

FIGURE_A1_COMPONENT_CONTRACT <- "component_6_plus_trend_component_1_samplewise"
COMPONENT_ANALYSIS_LEGACY_EXCLUDED_CONTRACTS <- c(
  "component_6_shifted_by_posterior_mean_trend_component_1"
)

component_analysis_slug <- function(component, contract) {
  contract_slug <- gsub("[^A-Za-z0-9]+", "_", as.character(contract))
  contract_slug <- gsub("^_+|_+$", "", tolower(contract_slug))
  sprintf("component_%02d_%s.png", as.integer(component), contract_slug)
}

component_analysis_label <- function(component, contract) {
  component <- as.integer(component)
  contract <- as.character(contract)
  if (identical(contract, FIGURE_A1_COMPONENT_CONTRACT)) {
    return("Component 6 plus trend component 1 (samplewise)")
  }
  if (identical(contract, "raw_state_component")) {
    return(sprintf("Raw state component %d", component))
  }
  sprintf("Component %d (%s)", component, contract)
}

component_analysis_specs <- function(component_df) {
  if (!is.data.frame(component_df) || nrow(component_df) == 0L) return(data.frame())
  required <- c("component", "component_contract")
  missing <- setdiff(required, names(component_df))
  if (length(missing) > 0L) return(data.frame())

  rows <- list()
  raw_components <- sort(unique(as.integer(component_df$component[component_df$component_contract == "raw_state_component"])))
  raw_components <- raw_components[is.finite(raw_components)]
  for (component in raw_components) {
    rows[[length(rows) + 1L]] <- data.frame(
      component = as.integer(component),
      component_contract = "raw_state_component",
      display_label = component_analysis_label(component, "raw_state_component"),
      filename = component_analysis_slug(component, "raw_state_component"),
      include_in_manuscript = FALSE,
      stringsAsFactors = FALSE
    )
  }

  has_a1_contract <- any(
    component_df$component == 6L &
      component_df$component_contract == FIGURE_A1_COMPONENT_CONTRACT,
    na.rm = TRUE
  )
  if (isTRUE(has_a1_contract)) {
    rows[[length(rows) + 1L]] <- data.frame(
      component = 6L,
      component_contract = FIGURE_A1_COMPONENT_CONTRACT,
      display_label = component_analysis_label(6L, FIGURE_A1_COMPONENT_CONTRACT),
      filename = component_analysis_slug(6L, FIGURE_A1_COMPONENT_CONTRACT),
      include_in_manuscript = FALSE,
      stringsAsFactors = FALSE
    )
  }

  if (length(rows) == 0L) return(data.frame())
  out <- do.call(rbind, rows)
  out <- out[!(out$component_contract %in% COMPONENT_ANALYSIS_LEGACY_EXCLUDED_CONTRACTS), , drop = FALSE]
  out
}

component_analysis_axis_label <- function(contract) {
  if (identical(as.character(contract), "raw_state_component")) {
    return(sprintf("State component (%s)", display_flow_scale))
  }
  figure_flow_axis_label(display_flow_scale)
}

hydrologic_regime_periods <- function() {
  data.frame(
    xmin = as.Date(c("2012-01-01", "2017-01-01")),
    xmax = as.Date(c("2016-12-31", "2019-12-31")),
    period = c("Dry", "Wet"),
    fill = c("#fff0b3", "#cfe8f7"),
    stringsAsFactors = FALSE
  )
}

dynamics_path <- file.path(support_dir, "authoritative_usgs_quantile_dynamics_summary.csv")
component_path <- file.path(support_dir, "authoritative_component_summary.csv")
if (!file.exists(dynamics_path)) stop(sprintf("Missing dynamics support CSV: %s", dynamics_path), call. = FALSE)
if (!file.exists(component_path)) stop(sprintf("Missing component support CSV: %s", component_path), call. = FALSE)

dynamics <- utils::read.csv(dynamics_path, stringsAsFactors = FALSE, check.names = FALSE)
components <- utils::read.csv(component_path, stringsAsFactors = FALSE, check.names = FALSE)
dynamics$date <- as.Date(dynamics$date)
components$date <- as.Date(components$date)

render_quantile_window <- function(start_date, end_date, title_text, out_file, ylim = c(0, 7)) {
  dd <- dynamics[
    dynamics$quantile %in% c("q05", "q50", "q95") &
      !is.na(dynamics$date) &
      dynamics$date >= as.Date(start_date) &
      dynamics$date <= as.Date(end_date),
    ,
    drop = FALSE
  ]
  if (nrow(dd) < 1L) stop(sprintf("No dynamics rows for %s to %s", start_date, end_date), call. = FALSE)
  obs <- dd[dd$quantile == "q50", c("date", "observed_usgs"), drop = FALSE]
  obs <- obs[is.finite(obs$observed_usgs), , drop = FALSE]
  col <- c(q05 = "#b2182b", q50 = "#238b45", q95 = "#2171b5")
  fill <- c(q05 = "#fdbba1", q50 = "#b2df8a", q95 = "#a6bddb")
  p <- ggplot() +
    geom_ribbon(
      data = dd,
      aes(x = date, ymin = lower_025, ymax = upper_975, fill = quantile),
      alpha = 0.12
    ) +
    geom_line(
      data = dd,
      aes(x = date, y = median_500, color = quantile),
      linewidth = 0.45
    ) +
    geom_line(
      data = dd,
      aes(x = date, y = lower_025, color = quantile),
      linewidth = 0.12
    ) +
    geom_line(
      data = dd,
      aes(x = date, y = upper_975, color = quantile),
      linewidth = 0.12
    ) +
    geom_line(data = obs, aes(x = date, y = observed_usgs), color = "black", linewidth = 0.22) +
    geom_point(data = obs, aes(x = date, y = observed_usgs), color = "black", size = 0.35) +
    scale_color_manual(values = col, breaks = c("q05", "q50", "q95")) +
    scale_fill_manual(values = fill, breaks = c("q05", "q50", "q95")) +
    coord_cartesian(ylim = ylim) +
    scale_x_date(date_breaks = "1 year", date_labels = "%Y-%m") +
    labs(title = title_text, x = NULL, y = figure_flow_axis_label(display_flow_scale)) +
    theme_manuscript_standard(
      base_size = 14,
      title_size = 15,
      legend_position = "none",
      axis_text_y_size = 12,
      x_angle = 35,
      major_grid_x = TRUE,
      major_grid_y = TRUE,
      plot_margin = margin(12, 12, 12, 12)
    )
  ggsave(out_file, plot = p, width = 12, height = 6, units = "in", dpi = 900)
}

render_component_80month <- function(out_file) {
  dd <- components[
    components$quantile %in% c("q05", "q50", "q95") &
      components$component == 6 &
      components$component_contract == FIGURE_A1_COMPONENT_CONTRACT &
      !is.na(components$date),
    ,
    drop = FALSE
  ]
  if (nrow(dd) < 1L) {
    stop(
      sprintf("No component-6 rows found for required contract `%s` in authoritative component summary.", FIGURE_A1_COMPONENT_CONTRACT),
      call. = FALSE
    )
  }
  min_time <- ceiling(max(dd$time_index, na.rm = TRUE) / 10)
  dd <- dd[dd$time_index >= min_time, , drop = FALSE]
  obs <- dynamics[dynamics$quantile == "q50", c("date", "observed_usgs"), drop = FALSE]
  obs <- obs[!is.na(obs$date) & is.finite(obs$observed_usgs), , drop = FALSE]
  obs <- obs[obs$date >= min(dd$date, na.rm = TRUE) & obs$date <= max(dd$date, na.rm = TRUE), , drop = FALSE]
  ylim <- range(c(dd$lower_025, dd$upper_975, obs$observed_usgs), na.rm = TRUE)
  if (!all(is.finite(ylim)) || diff(ylim) <= 0) ylim <- c(0, 1)
  ylim <- c(min(0, ylim[[1L]]), ylim[[2L]] + diff(ylim) * 0.08)
  shade_periods <- hydrologic_regime_periods()
  shade_periods <- shade_periods[shade_periods$xmax >= min(dd$date, na.rm = TRUE) & shade_periods$xmin <= max(dd$date, na.rm = TRUE), , drop = FALSE]
  shade_periods$xmin <- pmax(shade_periods$xmin, min(dd$date, na.rm = TRUE))
  shade_periods$xmax <- pmin(shade_periods$xmax, max(dd$date, na.rm = TRUE))
  label_y <- ylim[[1L]] + 0.035 * diff(ylim)
  col <- c(q05 = "#b2182b", q50 = "#238b45", q95 = "#2171b5")
  fill <- c(q05 = "#fdbba1", q50 = "#b2df8a", q95 = "#a6bddb")
  p <- ggplot() +
    geom_rect(
      data = shade_periods,
      aes(xmin = xmin, xmax = xmax, ymin = -Inf, ymax = Inf, fill = period),
      alpha = 0.48,
      inherit.aes = FALSE,
      show.legend = FALSE
    ) +
    geom_ribbon(
      data = dd,
      aes(x = date, ymin = lower_025, ymax = upper_975, fill = quantile),
      alpha = 0.12
    ) +
    geom_line(data = dd, aes(x = date, y = median_500, color = quantile), linewidth = 0.45) +
    geom_line(data = dd, aes(x = date, y = lower_025, color = quantile), linewidth = 0.12) +
    geom_line(data = dd, aes(x = date, y = upper_975, color = quantile), linewidth = 0.12) +
    geom_line(data = obs, aes(x = date, y = observed_usgs), color = "black", linewidth = 0.12) +
    geom_point(data = obs, aes(x = date, y = observed_usgs), color = "black", size = 0.1, alpha = 0.9) +
    scale_color_manual(values = col, breaks = c("q05", "q50", "q95")) +
    scale_fill_manual(values = c(fill, setNames(shade_periods$fill, shade_periods$period))) +
    annotate(
      "text",
      x = shade_periods$xmin + (shade_periods$xmax - shade_periods$xmin) / 2,
      y = label_y,
      label = shade_periods$period,
      size = 3.4,
      color = "#555555",
      fontface = "italic"
    ) +
    coord_cartesian(ylim = ylim) +
    scale_x_date(date_breaks = "24 months", date_labels = "%Y-%m") +
    labs(
      title = "80-month Component Evolution: selected 2022-12-25 model",
      x = NULL,
      y = figure_flow_axis_label(display_flow_scale)
    ) +
    theme_manuscript_standard(
      base_size = 15,
      title_size = 16,
      legend_position = "none",
      axis_text_y_size = 12,
      x_angle = 35,
      major_grid_x = TRUE,
      major_grid_y = TRUE,
      plot_margin = margin(12, 12, 12, 12)
    )
  ggsave(out_file, plot = p, width = 12, height = 6, units = "in", dpi = 350)
}

render_component_analysis_figure <- function(spec, out_file) {
  dd <- components[
    components$quantile %in% c("q05", "q50", "q95") &
      components$component == spec$component[[1L]] &
      components$component_contract == spec$component_contract[[1L]] &
      !is.na(components$date),
    ,
    drop = FALSE
  ]
  if (nrow(dd) < 1L) {
    stop(sprintf("No component rows found for analysis figure `%s`.", spec$display_label[[1L]]), call. = FALSE)
  }
  min_time <- ceiling(max(dd$time_index, na.rm = TRUE) / 10)
  dd <- dd[dd$time_index >= min_time, , drop = FALSE]
  if (nrow(dd) < 1L) {
    stop(sprintf("No component rows remain after warm-history trim for `%s`.", spec$display_label[[1L]]), call. = FALSE)
  }

  obs <- dynamics[dynamics$quantile == "q50", c("date", "observed_usgs"), drop = FALSE]
  obs <- obs[!is.na(obs$date) & is.finite(obs$observed_usgs), , drop = FALSE]
  obs <- obs[obs$date >= min(dd$date, na.rm = TRUE) & obs$date <= max(dd$date, na.rm = TRUE), , drop = FALSE]

  ylim <- range(c(dd$lower_025, dd$upper_975, obs$observed_usgs), na.rm = TRUE)
  if (!all(is.finite(ylim)) || diff(ylim) <= 0) ylim <- c(0, 1)
  ylim <- c(min(0, ylim[[1L]]), ylim[[2L]] + diff(ylim) * 0.08)

  shade_periods <- hydrologic_regime_periods()
  shade_periods <- shade_periods[shade_periods$xmax >= min(dd$date, na.rm = TRUE) & shade_periods$xmin <= max(dd$date, na.rm = TRUE), , drop = FALSE]
  shade_periods$xmin <- pmax(shade_periods$xmin, min(dd$date, na.rm = TRUE))
  shade_periods$xmax <- pmin(shade_periods$xmax, max(dd$date, na.rm = TRUE))
  label_y <- ylim[[1L]] + 0.035 * diff(ylim)
  col <- c(q05 = "#b2182b", q50 = "#238b45", q95 = "#2171b5")
  fill <- c(q05 = "#fdbba1", q50 = "#b2df8a", q95 = "#a6bddb")
  p <- ggplot() +
    geom_rect(
      data = shade_periods,
      aes(xmin = xmin, xmax = xmax, ymin = -Inf, ymax = Inf, fill = period),
      alpha = 0.48,
      inherit.aes = FALSE,
      show.legend = FALSE
    ) +
    geom_ribbon(
      data = dd,
      aes(x = date, ymin = lower_025, ymax = upper_975, fill = quantile),
      alpha = 0.12
    ) +
    geom_line(data = dd, aes(x = date, y = median_500, color = quantile), linewidth = 0.45) +
    geom_line(data = dd, aes(x = date, y = lower_025, color = quantile), linewidth = 0.12) +
    geom_line(data = dd, aes(x = date, y = upper_975, color = quantile), linewidth = 0.12) +
    geom_line(data = obs, aes(x = date, y = observed_usgs), color = "black", linewidth = 0.12) +
    geom_point(data = obs, aes(x = date, y = observed_usgs), color = "black", size = 0.1, alpha = 0.9) +
    scale_color_manual(values = col, breaks = c("q05", "q50", "q95")) +
    scale_fill_manual(values = c(fill, setNames(shade_periods$fill, shade_periods$period))) +
    annotate(
      "text",
      x = shade_periods$xmin + (shade_periods$xmax - shade_periods$xmin) / 2,
      y = label_y,
      label = shade_periods$period,
      size = 3.4,
      color = "#555555",
      fontface = "italic"
    ) +
    coord_cartesian(ylim = ylim) +
    scale_x_date(date_breaks = "24 months", date_labels = "%Y-%m") +
    labs(
      title = sprintf("%s: selected 2022-12-25 model", spec$display_label[[1L]]),
      x = NULL,
      y = component_analysis_axis_label(spec$component_contract[[1L]])
    ) +
    theme_manuscript_standard(
      base_size = 15,
      title_size = 16,
      legend_position = "none",
      axis_text_y_size = 12,
      x_angle = 35,
      major_grid_x = TRUE,
      major_grid_y = TRUE,
      plot_margin = margin(12, 12, 12, 12)
    )
  ggsave(out_file, plot = p, width = 12, height = 6, units = "in", dpi = 350)
  invisible(TRUE)
}

write_component_analysis_readme <- function(analysis_dir, manifest) {
  writeLines(
    c(
      "# Component Evolution Analysis Gallery",
      "",
      "These PNG files are rendered from the same compact authoritative selected-model support bundle as Figure A1.",
      "They are analysis-only diagnostics and are intentionally not added to `MANUSCRIPT_ASSET_MANIFEST.json`.",
      "",
      "Included contracts:",
      "",
      "- `raw_state_component` for each retained state component available in the support CSV.",
      sprintf("- `%s`, the audited samplewise construction used by Figure A1.", FIGURE_A1_COMPONENT_CONTRACT),
      "",
      "Excluded by default:",
      "",
      "- `component_6_shifted_by_posterior_mean_trend_component_1`, the older shifted diagnostic contract.",
      "",
      sprintf("Rendered figures: %d", as.integer(nrow(manifest)))
    ),
    con = file.path(analysis_dir, "README.md")
  )
}

render_component_analysis_gallery <- function(analysis_dir) {
  dir.create(analysis_dir, recursive = TRUE, showWarnings = FALSE)
  specs <- component_analysis_specs(components)
  if (!is.data.frame(specs) || nrow(specs) == 0L) {
    stop("No component analysis figure specifications were available.", call. = FALSE)
  }

  rows <- list()
  for (i in seq_len(nrow(specs))) {
    spec <- specs[i, , drop = FALSE]
    out_file <- file.path(analysis_dir, spec$filename[[1L]])
    render_component_analysis_figure(spec, out_file)
    rows[[length(rows) + 1L]] <- data.frame(
      component = as.integer(spec$component[[1L]]),
      component_contract = spec$component_contract[[1L]],
      display_label = spec$display_label[[1L]],
      filename = spec$filename[[1L]],
      relative_path = file.path("analysis_figures", "component_evolution", spec$filename[[1L]]),
      include_in_manuscript = FALSE,
      rendered_at_utc = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"),
      stringsAsFactors = FALSE
    )
  }
  manifest <- do.call(rbind, rows)
  utils::write.csv(manifest, file.path(analysis_dir, "component_analysis_manifest.csv"), row.names = FALSE)
  write_component_analysis_readme(analysis_dir, manifest)
  manifest
}

render_quantile_window(
  "2012-01-01",
  "2016-12-31",
  "Selected-model Quantile Dynamics: 2012-2016",
  file.path(out_dir, "selected_model_quantile_dry_period.png"),
  ylim = c(0, 7)
)
render_quantile_window(
  "2017-01-01",
  "2019-12-31",
  "Selected-model Quantile Dynamics: 2017-2019",
  file.path(out_dir, "selected_model_quantile_wet_period.png"),
  ylim = c(0, 7)
)
render_component_80month(file.path(out_dir, "selected_model_component_80month.png"))
analysis_dir <- file.path(dirname(out_dir), "analysis_figures", "component_evolution")
component_analysis_manifest <- render_component_analysis_gallery(analysis_dir)

meta <- list(
  support_dir = metadata_support_dir,
  render_staging_support_dir = support_dir,
  output_dir = out_dir,
  display_flow_scale = display_flow_scale,
  figure_a1_component_contract = FIGURE_A1_COMPONENT_CONTRACT,
  figure_a1_article_display_label = "80-month seasonal component",
  hydrologic_regime_periods = lapply(seq_len(nrow(hydrologic_regime_periods())), function(i) {
    row <- hydrologic_regime_periods()[i, , drop = FALSE]
    list(
      period = row$period[[1L]],
      start = as.character(row$xmin[[1L]]),
      end = as.character(row$xmax[[1L]]),
      fill = row$fill[[1L]]
    )
  }),
  rendered_files = c(
    "selected_model_quantile_dry_period.png",
    "selected_model_quantile_wet_period.png",
    "selected_model_component_80month.png"
  ),
  component_analysis = list(
    directory = file.path("analysis_figures", "component_evolution"),
    manifest = file.path("analysis_figures", "component_evolution", "component_analysis_manifest.csv"),
    figure_count = as.integer(nrow(component_analysis_manifest)),
    files = as.character(component_analysis_manifest$filename)
  ),
  generated_at_utc = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
)
if (requireNamespace("jsonlite", quietly = TRUE)) {
  jsonlite::write_json(meta, file.path(out_dir, "render_metadata.json"), auto_unbox = TRUE, pretty = TRUE)
}
message("Rendered authoritative selected-model support figures.")
