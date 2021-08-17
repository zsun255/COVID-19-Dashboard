library(shiny)
library(shinythemes)
library(shinydashboard)
library(plotly)
library(COVID19)

ui <- fluidPage(
  theme = shinytheme("superhero"),
  h1(id="title", "COVID-19 Dashboard"),
  tags$style(HTML("#title{color: darkorange;}")),
  sidebarLayout(
    sidebarPanel(
      
      p("Here are some options you can select to make and change the plot"),
      br(),
      
      selectInput(
        "country",
        label = "Select the countries you want for the plot (By default, the top 6 countries with the highest confirmed cases 
              are plotted)",
        multiple = TRUE,
        choices = unique(covid19()$administrative_area_level_1),
        selected = c("United States", 
                     "India", 
                     "Brazil", 
                     "Russia",
                     "United Kingdom",
                     "France")
      ),
      
      selectInput(
        "type",
        label = "Select the type of cases - Confirmed, Tests, etc.",
        choices = c(
          "confirmed",
          "tests",
          "recovered",
          "deaths",
          "vaccines"
        )
      ),
      
      selectInput(
        "level",
        label = "Select level - Country, Region or City",
        choices = c(
          "Country" = 1,
          "Region" = 2,
          "City" = 3
        ),
        selected = 1
      ),
      
      dateRangeInput(
        "date",
        label = "Select the range of Date for the data",
        start = "2020-01-01"
      ),
      
      br(),
      submitButton("Search",icon = icon("search"))
    ),
    
    mainPanel(
      h3("COVID-19 Plot"), 
      h4("(Once you have done, remember to press the \'Search\' button before plotting!)"),
      plotlyOutput("covid19plot")
    )
  )
)