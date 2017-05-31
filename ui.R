library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)
choices <- data %>% select(Name) %>% unique()

shinyUI(navbarPage(
  tabPanel('Angela',
    titlePanel("Trend of Baby Names"),
    sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h3("Select name"), 
                  choices = choices, 
                  selected = 1))
    ),
    mainPanel(
      plotOutput("babyNamesPlot")
    )
  ),
  
  tabPanel('Line Chart',
           titlePanel('Names'),
           # Create sidebar layout
           sidebarLayout(
             
             # Side panel for controls
             sidebarPanel(
               
               # Input to select variable to the chart
               selectInput('var', label = 'Data to Chart', 
                           choices = list("Zoe, Zoey, Zoie" = 'z', "Eric, Erik, Erick" = 'e', 
                                          "Lucas, Lukas" = 'l', "Zachary, Zackary" = 'zz',
                                          "Nicholas, Nickolas, Nicolas, Nikolas" = 'n'))
               
             ),
             
             # display line chart
             mainPanel(
               plotlyOutput('line')
             )
           )
  )
  )
)