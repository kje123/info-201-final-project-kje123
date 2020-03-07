library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")

overview <- tabPanel(
  "An overview",
  titlePanel("An Analytical Look at Emissions in the US"),
  
  img(src = "image.jpg"),
  
  h2("Questions we want to answer:"),
  p("1. What states are contributing the most to US emissions?"),
  p("2. How has the progression of emissions been from 2000 to 2016?"),
  p("3. What pollutants are the most prevalent?")
)

page_one <- tabPanel(
  "Mapping the Emissions",
  titlePanel("A Map of the different types of emissions in the US"),
  
  p("This chart is a mapping of all the total emissions from 2000 to 2016.
    We included a widget that allows you to choose each individual different
    pollutant to see the impact of each one. The data is mapped onto a
    chloropleth map to show each state's differences comparatively. This
    map makes it clearly visual that California's total emissions outpace
    nearly every other state by a huge factor. From these charts, we can
    see that California is consistantly producing the most emissions for
    almost all of the different types of pollutants, except for SO2, in which
    Pennsylvania is actually higher. We suspect this could be due to
    Pennsylvania's long history of coal mining and burning for energy. What's
    interesting is that there are a few states that don't show up on the map,
    Montana, Mississippi, Nebraska and West Virginia. Looking at the table
    we made earlier, there is no entries for these states either."),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "var",
        label = "Pollutant",
        choices = list(CO = "total_co", SO2 = "total_so2",
                       O3 = "total_o3", NO2 = "total_no2",
                       Total = "total_emm")
      ),
      radioButtons(
        inputId = "color",
        label = "Color Palette",
        choices = c("viridis", "magma", "inferno", "plasma")
      )
    ),
    
    mainPanel(
      plotlyOutput("map_em")
    )
  )
)

page_two <- tabPanel(
  "Emissions over time",
  titlePanel("A Linechart of Emissions over time in the US"),
  
  p(),
  
  sidebarLayout(
    sidebarPanel(),
    
    mainPanel(
      plotOutput("linechart_em")
    )
  )
)

page_three <- tabPanel(
  "Distribution of Emissions",
  titlePanel("A distribution of the different types of Pollutants"),
  
  p(),
  
  sidebarLayout(
    sidebarPanel(),
    
    mainPanel(
      plotOutput("piechart_em")
    )
  )
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