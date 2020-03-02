# Load the necessary packages
library("lintr")
library("dplyr")

## ASSIGNMENT INSTRUCTIONS ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Write a function that takes in a dataset as a parameter, and returns a table
# of aggregate information about it. It must perform a groupby operation to
# show a dimension of the dataset as grouped by a particular feature (column).
# We expect the included table to:
#   - Have well formatted column names
#   - Only contain relevant information
#   - Be intentionally sorted in a meaningful way

get_summary_table <- function(df) {
  grouped <- df %>%
    group_by(State) %>%
    summarise(
      total_co = (sum(CO.Mean) * 1000),
      total_no2 = sum(NO2.Mean),
      total_o3 = (sum(O3.Mean) * 1000),
      total_so2 = (sum(SO2.Mean)),
      total_emm = sum(total_so2 + total_no2 + total_o3 + total_co)
      ) %>%
    arrange(desc(total_emm))
}

names_col <- c("State", "Total CO", "Total NO2",
               "Total O3", "Total SO2", "Total Emmissions")