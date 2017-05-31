library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)
choices <- data %>% select(Name) %>% unique()
c <- data %>% select(State) %>% unique


shinyUI(navbarPage('Baby Names',

  tabPanel('Information Page',
           titlePanel("Introduction"),
           sidebarLayout(
             sidebarPanel(),
             mainPanel(
               h6("Episode IV", align = "center"),
               h6("A NEW HOPE", align = "center"),
               h5("It is a period of civil war.", align = "center"),
               h4("Rebel spaceships, striking", align = "center"),
               h3("from a hidden base, have won", align = "center"),
               h2("their first victory against the", align = "center"),
               h1("evil Galactic Empire.")
             )
           )
           ),
                   
  tabPanel('Name with Different Spellings',
           titlePanel('Names'),
           # Create sidebar layout
           sidebarLayout(
             # Side panel for controls
             sidebarPanel(
               # Input to select variable to the chart
               selectInput('var', label = 'names to chart', 
                           choices = list("Zoe, Zoey, Zoie" = 'z', "Eric, Erik, Erick" = 'e', 
                                          "Lucas, Lukas" = 'l', "Zachary, Zackary" = 'zz',
                                          "Nicholas, Nickolas, Nicolas, Nikolas" = 'n'))
               
             ),
             # display line chart
             mainPanel(
               plotlyOutput('line')
             )
           )
  ),
  
  tabPanel('Baby Names by year',
           titlePanel("Trend of Baby Names"),
           sidebarLayout(
             sidebarPanel(
               selectInput("select", label = h3("Select name"), 
                           choices = choices, 
                           selected = 1)),
             mainPanel(
               plotOutput("babyNamesPlot")
             ))
  ),

  tabPanel("Map",
           titlePanel('Map'),
           sidebarLayout(
             sidebarPanel(
               textInput("name", label = h3("Search the name"), value = "Mary"), 
               helpText("Note: If there is no such name, please try another name.")
             ),
             mainPanel(
               plotlyOutput('map')
             ))
  ),
  
  tabPanel("State Popularity",
          titlePanel("State Popularity Top 5"),
            sidebarLayout(
             sidebarPanel(
               selectInput('barplot1',
                           label ='Select State to View Name Popularity',
                           choices =c ,selected=1)
             ),
             # Show barplot of the generated distribution
             mainPanel(
               plotlyOutput('barplot')
             )
  )
)))