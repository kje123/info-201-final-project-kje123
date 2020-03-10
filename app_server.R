library("shiny")
library("data.table")
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
        z = grouped[[input$var]],
        locations = ~state_abb,
        color = grouped[[input$var]],
        colors = input$color
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
      ) %>%
      filter(year %between% c(min(input$year), max(input$year)))
    
    ggplot(first_chart_data, aes(x = as.numeric(year))) +
      geom_line(aes(y = CO_levels), color = "steelblue2", size = 1.5) +
      annotate(
        geom = "text", x = max(input$year), y = 300, label = "  CO  ", hjust = "left"
      ) +
      geom_line(aes(y = O3_levels), color = "orchid4", size = 1.5) +
      annotate(
        geom = "text", x = max(input$year), y = 28, label = "  O3  ", hjust = "left"
      ) +
      geom_line(aes(y = NO2_levels), color = "forestgreen", size = 1.5) +
      annotate(
        geom = "text", x = max(input$year), y = 12, label = "  NO2  ", hjust = "left"
      ) +
      geom_line(aes(y = SO2_levels), color = "turquoise4", size = 1.5) +
      annotate(
        geom = "text", x = max(input$year), y = -3, label = "  SO2  ", hjust = "left"
      ) +
      ggtitle("Distribution of emissions over the years") + 
      xlab("Year") + 
      ylab("Emissions (PPB)")
  })
  
  output$piechart_em <- renderPlot({                   # Code for pie chart
    get_columns <- df %>%
      select(NO2.Mean, O3.Mean, SO2.Mean, CO.Mean) %>% # Pollutant columns
      summarise_each(list(mean)) %>%
      mutate(O3.Mean = (O3.Mean * 1000)) %>%
      mutate(CO.Mean = (CO.Mean * 1000)) %>%
      select(one_of(input$pollutants))
    
    big_4 <- colnames(get_columns)                     # Column names as vector
    pct <- round(get_columns, 2)                          # Round averages
    big_4 <- paste(big_4,
                   paste("(mean:", paste0(pct, ")")))  # Averages as labels
    
    pie(unlist(get_columns, use.names=FALSE),
        labels = big_4,
        main = "Four Major Pollutant Averages (PPB)",  # Chart w labels & title
        col = c("green", "red", "blue", "orange"))
  })
}