library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")

overview <- tabPanel(
  "An overview",
  titlePanel("An Analytical Look at Gas Emission Levels in the US"),
  
  img(src = "image.jpg"),
  
  h2("Questions we want to answer:"),
  p("1. What states are contributing the most to US emissions?"),
  p("2. How has the progression of emissions been from 2000 to 2016?"),
  p("3. What pollutants are the most prevalent?"),
  
  p("To answer these important questions, our group has created 3 data
     visualizations in the second, third, and fourth tabs of this web
     application. Each of the visualizations display values pulled from a
     dataset compiled by the", strong(" U.S. Environmental Protection Agency
     (US EPA)."), "The dataset contains information about", strong("emission
     levels of four different chemical compounds"), "that have contributed to
     the", strong("air pollution in each U.S. state in the years 2000-2016,"),
     "namely: ", em("Carbon Monoxide (CO),"), em("Sulfur Dioxide (SO2),"),
     em("Ozone (O3),"), "and", em("Nitrogen Dioxide (NO2)"), "."),
  
  p("The", strong("\"Mapping the Emissions\" tab"), "contains our first
    visualization: a choropleth map, which is a color-coded map indicating
    the amount of the four air pollutant (individually and in total) that
    each US state is responsible for. Next, the", strong("\"Emissions over
    time\" tab"), "contains a line chart representing the average levels of
    each of the four pollutant compounds recorded in the atmosphere of
    the United States as a whole throughout the years 2000-2016. Lastly, the",
    strong("\"Distribution of Emissions\" tab"),"contains a pie chart that
    presenting the average daily levels of each of the four compounds in
    relation to each other that were recorded in the atmosphere across the
    United States from 2000-2016.")
)

page_one <- tabPanel(
  "Mapping the Emissions",
  titlePanel("A Map of the different types of emissions in the US"),
  
  p("This chart is a mapping of all the total emissions from 2000 to 2016.
    We included a widget that allows you to choose each individual different
    pollutant to see the impact of each one. The data is mapped onto a
    chloropleth map to show each state's differences comparatively. This
    map makes it clearly visual that", strong("California's"), "total emissions
    outpace nearly every other state by a huge factor. From these charts, we
    can see that California is consistantly producing the most emissions for
    almost all of the different types of pollutants, except for SO2, in which
    Pennsylvania is actually higher. We suspect this could be due to
    Pennsylvania's long history of coal mining and burning for energy. What's
    interesting is that there are a few states that don't show up on the map,",
    strong("Montana, Mississippi, Nebraska and West Virginia."), "Looking at
    the table we made earlier, there is no entries for these states either."),
  
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
  
  p("This chart shows the", strong("average yearly emissions levels"), "of each
    of the four air pollutants in the dataset:", em("Carbon Monoxide (CO),"),
    em("Sulfur Dioxide (SO2),"), em("Ozone (O3),"), "and", em("Nitrogen Dioxide
    (NO2)."), "The data shown in this chart summarizes the emission levels of
    these harmful gases from the years", strong("2000-2016"), "and is intended
    to show the gases' emission levels", em("relative to each other."), "More
    importantly, this chart shows the changes in the average emission levels of
    each gas through the years."),
  
  p("As can be seen in the chart, the average", em("CO"), "emissions have
    consistently been the highest by a couple hundred parts per billion
    throughout the years. The average", em("O3, NO2, and SO2"),
    "emission levels have been quite close to each other all throughout and saw
    very slight changes. On the other hand, the line representing the",
    em("CO"), "emissions has clearly been experiencing a downward trend since
    the year 2000, which is great news for the environment. However, a slight
    rise can also be observed towards the end of the", em("CO"), "emission
    graph, which could be an indicator of a shift into an upward trend in the
    following years."),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "year",
        label = "Years",
        min = 2000,
        max = 2016,
        value = c(2000, 2016)
      )
    ),
    
    mainPanel(
      plotOutput("linechart_em")
    )
  )
)

page_three <- tabPanel(
  "Distribution of Emissions",
  titlePanel("A distribution of the different types of Pollutants"),
  
  p("This chart is a pie chart intended to show the relationship between the
    averages of", strong("four major pollutants:"), "Carbon Monoxide",
    strong("(CO)"), "Sulfur Dioxide", strong("(SO2)"), "Ozone", strong("(O3)"),
    "and Nitrogen Dioxide", strong("(NO2)"), "in parts per billion."),
  
  p("When observing the chart below, three observations come into view. The
    first is that", strong("Carbon Monoxide has the largest mean."), "By
    knowing which major pollutant has the highest average out of", em("1.75
    million observations,"), "researchers can focus on what sources and reasons
    are causing such a high number. A second observation is that averages give
    researchers an easier time comparing how the pollutants stack up with each
    other. By doing this, these pollutants can possibly be prioritized based on
    their rank."),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
        inputId = "pollutants",
        label = "Pollutants",
        choices = list(CO = "CO.Mean", SO2 = "SO2.Mean",
                       NO2 = "NO2.Mean", O3 = "O3.Mean"),
        selected = c("CO.Mean", "SO2.Mean", "NO2.Mean", "O3.Mean"),
      )
    ),
    
    mainPanel(
      plotOutput("piechart_em")
    )
  )
)

takeaways <- tabPanel(
  "Takeaways we have",
  titlePanel("What we learned from this data", windowTitle = "Takeaways"),
  
  p("After analyzing the original dataset and creating separate graphs to
    display the data in different ways, we were able to answer the three
    questions we had in the beginning:"),
  p(em("1. What states are contributing the most to US emissions?")),
  p(em("2. How has the progression of emissions been from 2000 to 2016?")),
  p(em("3. What pollutants are the most prevalent?")),
  p("Individually, each graph pertains to one of the aforementioned questions
    and their interactive abilities. Outside of the graphs and dataset, we were
    able to learn some more about which pollutants are most prevelant and the
    states that they tend to be in. By learning this, the U.S. can get a broad
    overview of the most damaging pollutants.")
)

my_ui <- navbarPage(
  "Major U.S. Pollutants",
  overview,
  page_one,
  page_two,
  page_three,
  takeaways
)