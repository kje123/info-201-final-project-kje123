# Load the necessary packages
library("lintr")
library("tidyr")
library("dplyr")
library("knitr")
library("ggplot2")
library("leaflet")
library("plotly")

## ASSIGNMENT INSTRUCTIONS ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# For this chart, we expect the following:
#   - Proper labels/titles/legends
#   - Intentional chart type and encoding selection based on the question of
#     interest and data type

# find mean of each big 4 for every state

#my_df <- read.csv("../data/pollution_us_2000_2016.csv", stringsAsFactors = FALSE)

pie_chart <- function(df_values) {
  get_columns <- df_values %>%
    select(NO2.Mean, O3.Mean, SO2.Mean, CO.Mean) %>% # get correct columns
    summarise_each(list(mean)) # Calculate average of each pollutant
  averages <- c(get_columns$NO2.Mean[[1]],
                get_columns$O3.Mean[[1]],
                get_columns$SO2.Mean[[1]],
                get_columns$CO.Mean[[1]]) # Store averages as vector
  big_4 <- colnames(get_columns) # Store column names as vector
  temporary_df <- data.frame(big_4, averages) # Create dataframe w/ averages and names
  create_graph <- ggplot(temporary_df,
                         mapping = aes(x = big_4,
                                       y = averages,
                                       fill = averages)) +
    geom_bar(width = .75, stat = "identity") +
    coord_polar()
  create_graph +
    ggtitle("Four Major Pollutant Averages") +
    xlab("Major Pollutants") + ylab("Averages (ppm)") +
    theme(axis.text.x = element_text(size = 10))
}

#### MY ATTEMPT AT AN INTERACTIVE PLOT WHICH COMPILES BUT DOESN'T SHOW

#   create_graph <- plot_ly(temporary_df,
#                           x = ~big_4, 
#                           y = ~averages,
#                           type = "bar",
#                           hovertext = "y",
#                           color = ~averages,
#                           alpha = 0.5) %>%
#     layout(
#       title = "Four Major Pollutant Averages",
#       xaxis = list(title = "Major Pollutants"),
#       yaxis = list(title = "Averages (ppm)")
#     ) %>%
#     create_graph +
#     theme(axis.text.x = element_text(size = 10)) +
#     coord_polar()
# }



# Testing function
# pie_chart(my_df)

