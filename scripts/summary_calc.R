# Load the necessary packages
library("lintr")
library("tidyr")
library("dplyr")
library("knitr")
library("ggplot2")
library("leaflet")
library("plotly")

## ASSIGNMENT INSTRUCTIONS ## ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Write a generalizable function that works with this particular dataset, just
# wrapped in a function. This will allow you to pass your dataset into this
# function from your index.Rmd file. The file must compute at least 5 different
# values from your data that you believe are pertinent to share. 



# A function that takes in a dataset and returns a list of info about it:
get_summary_info <- function(dataset) {
  ret <- list()
  ret$length <- length(dataset)
  # do some more interesting stuff
  return (ret)
}