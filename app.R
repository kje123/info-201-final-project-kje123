library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")

source("app_ui.R")
source("app_server.R")

shinyApp(ui = my_ui, server = my_server)