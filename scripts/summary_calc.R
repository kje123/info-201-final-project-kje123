# Load the necessary packages
library("lintr")
library("dplyr")

## ASSIGNMENT INSTRUCTIONS ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Write a generalizable function that works with this particular dataset, just
# wrapped in a function. This will allow you to pass your dataset into this
# function from your index.Rmd file. The file must compute at least 5 different
# values from your data that you believe are pertinent to share.

# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(df) {
  ret <- list()
  ret$columns <- ncol(df)
  ret$rows <- nrow(df)
  ret$city_count <- df %>%
    group_by(City) %>%
    summarise(city_count = n_distinct(City)) %>%
    pull(city_count) %>%
    sum()
  col_remover <- c("NO2 Mean", "NO2 1st Max Value", "NO2 1st Max Hour",
                   "NO2 AQI", "O3 Mean", "O3 1st Max Value", "O3 1st Max Hour",
                   "O3 AQI", "SO2 Mean", "SO2 1st Max Value",
                   "SO2 1st Max Hour", "SO2 AQI", "CO Mean",
                   "CO 1st Max Value", "CO 1st Max Hour", "CO AQI", "X",
                   "State Code", "County Code", "Site Num",
                   "NO2 Units", "O3 Units", "SO2 Units", "CO Units")
  col_gasses <- c("NO2.Mean", "NO2.1st.Max.Value", "NO2.1st.Max.Hour",
                  "NO2.AQI", "O3.Mean", "O3.1st.Max.Value", "O3.1st.Max.Hour",
                  "O3.AQI", "SO2.Mean", "SO2.1st.Max.Value", "SO2.1st.Max.Hour",
                  "SO2.AQI", "CO.Mean", "CO.1st.Max.Value", "CO.1st.Max.Hour",
                  "CO.AQI", "X", "State.Code", "County.Code", "Site.Num",
                  "Address", "State", "County", "City", "Date.Local")
  ret$column_names <- gsub("[.]", " ", colnames(df)) %>%
    setdiff(col_remover)
  ret$gasses <- gsub("\\.Units", "", colnames(df)) %>%
    setdiff(col_gasses)
  return(ret)
}
