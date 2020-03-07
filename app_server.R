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
  
  output$linechart_em <- renderPlot({
    # code for line chart
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
  })
  
  output$piechart_em <- renderPlot({
    get_columns <- df %>%
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
  })
}