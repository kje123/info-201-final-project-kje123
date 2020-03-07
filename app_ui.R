library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")

overview <- tabPanel(
  "An overview"
)
page_one <- tabPanel(
  "Mapping the emissions",
  titlePanel("A Map of the different types of emissions in the US"),
  
  p("Chart 3 is a mapping of all the total emissions from 2000 to 2016.
    We included a widget that allows you to choose each individual different
    pollutant to see the impact of each one. The data is mapped onto a
    chloropleth map to show each state's differences comparatively. This
    map makes it clearly visual that California's total emissions outpace
    nearly every other state by a huge factor. From these charts, we can
    see that California is consistantly producing the most emissions for
    almost all of the different types of pollutants, except for SO2, in which
    Pennsylvania is actually higher. We suspect this could be due to
    Pennsylvania's long history of coal mining and burning for energy. What's interesting
    is that there are a few states that don't show up on the map, Montana,
    Mississippi, Nebraska and West Virginia. Looking at the table we made
    earlier, there is no entries for these states either."),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "var",
        label = "Pollutant",
        choices = list(CO = "total_co", SO2 = "total_so2",
                       O3 = "total_o3", NO2 = "total_no2",
                       Total = "total_emm")
      ),
    ),
    
    mainPanel(
      plotlyOutput("map_em")
    )
  )
)
page_two <- tabPanel(
  "test"
)
page_three <- tabPanel(
  "Test"
)
takeaways <- tabPanel(
  "Takeaways we have"
)

my_ui <- navbarPage(
  "Title",
  overview,
  page_one,
  page_two,
  page_three,
  takeaways
)