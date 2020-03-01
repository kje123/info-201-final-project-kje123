# Load the necessary packages
library("lintr")
library("tidyr")
library("dplyr", warn.conflicts = FALSE)
library("knitr")
library("ggplot2", warn.conflicts = FALSE)
library("leaflet")
library("plotly", warn.conflicts = FALSE)

## ASSIGNMENT INSTRUCTIONS ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# For this chart, we expect the following:
#   - Proper labels/titles/legends
#   - Trend of emissions for each type of gas over time

# Averaged by year
line_chart <- function(df) {
  first_chart_data <- df %>%
    mutate(date = as.Date(df$Date.Local, "%Y-%m-%d")) %>%
    arrange(desc(date)) %>%
    mutate(O3_ppb = O3.Mean * 1000) %>%
    mutate(CO_ppb = CO.Mean * 1000) %>%
    group_by(date, City) %>%
    summarize(
      O3_levels = (mean(O3_ppb)), CO_levels = (mean(CO_ppb)),
      NO2_levels = (mean(NO2.Mean)), SO2_levels = (mean(SO2.Mean))
    ) %>%
    mutate(year = format(date, "%Y")) %>%
    group_by(year) %>%
    summarize(
      O3_levels = (mean(O3_levels)), CO_levels = (mean(CO_levels)),
      NO2_levels = (mean(NO2_levels)), SO2_levels = (mean(SO2_levels))
    )

  ggplot(first_chart_data, aes(x = as.numeric(year))) +
    geom_line(aes(y = CO_levels), color = "steelblue2", size = 1.5) +
    annotate(
      geom = "text", x = 2016, y = 300, label = "  CO  ", hjust = "left"
    ) +
    geom_line(aes(y = O3_levels), color = "orchid4", size = 1.5) +
    annotate(
      geom = "text", x = 2016, y = 28, label = "  O3  ", hjust = "left"
    ) +
    geom_line(aes(y = NO2_levels), color = "forestgreen", size = 1.5) +
    annotate(
      geom = "text", x = 2016, y = 12, label = "  NO2  ", hjust = "left"
    ) +
    geom_line(aes(y = SO2_levels), color = "turquoise4", size = 1.5) +
    annotate(
      geom = "text", x = 2016, y = -3, label = "  SO2  ", hjust = "left"
    )
}
