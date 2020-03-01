# Load the necessary packages
library("lintr")
library("tidyr")
library("dplyr")

## ASSIGNMENT INSTRUCTIONS ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# For this chart, we expect the following:
#   - Proper labels/titles/legends
#   - Intentional chart type and encoding selection based on the question of
#     interest and data type

pie_chart <- function(df_values) {
  get_columns <- df_values %>%
    select(NO2.Mean, O3.Mean, SO2.Mean, CO.Mean) %>% # Select pollutant columns
    summarise_each(list(mean))                       # Pollutant averages
  averages <- c(get_columns$NO2.Mean[[1]],           # 12.82
                get_columns$O3.Mean[[1]] * 1000,     # 26.12
                get_columns$SO2.Mean[[1]],           # 1.87
                get_columns$CO.Mean[[1]] * 1000)     # 368.22
  big_4 <- colnames(get_columns)                     # Column names as vector
  pct <- round(averages, 2)                          # Round pollutant averages
  big_4 <- paste(big_4,
                 paste("(mean:", paste0(pct, ")")))  # Pollutant average labels
  pie(averages,
      labels = big_4,
      col = rainbow(length(big_4)),
      main = "Four Major Pollutant Averages (ppb)")  # Pie chart with labels
                                                     # and title
}