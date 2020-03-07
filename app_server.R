library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")

df <- read.csv("data/pollution_us_2000_2016.csv")

my_server <- function(input, output) {
  output$map_em <- renderPlotly ({
    # code for map
    g <- list(
      scope = "usa",
      projection = list(type = "albers usa"),
      showland = TRUE,
      landcolor = toRGB("gray95"),
      subunitcolor = toRGB("gray85"),
      countrycolor = toRGB("gray85"),
      countrywidth = 0.5,
      subunitwidth = 0.5
    )
    grouped <- df %>%
      group_by(State) %>%
      summarise(
        total_co = (sum(CO.Mean) * 1000),
        total_no2 = sum(NO2.Mean),
        total_o3 = (sum(O3.Mean) * 1000),
        total_so2 = (sum(SO2.Mean)),
        total_emm = sum(total_so2 + total_no2 + total_o3 + total_co)
      ) %>%
      mutate(state_abb = state.abb[match(State, state.name)])
      
    fig <- plot_geo(grouped, locationmode = "USA-states") %>%
      add_trace(
        z = grouped[[input$var]], locations = ~state_abb, color = grouped[[input$var]]
      ) %>%
      layout(geo = g, title = "US Total Pollution 2000 - 2016") %>%
      colorbar(title = "Total Emissions (PPB)")
      
  })
}