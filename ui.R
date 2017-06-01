# ui.R
# load the packages
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)
choices <- data %>% select(Name) %>% unique()
c <- data %>% select(State) %>% unique


shinyUI(navbarPage('Baby Names',
  
  # Tab 1: Information page
  tabPanel('Information Page',
           # title
           titlePanel("Introduction"),
           # Create sidebar layout
           sidebarLayout(
             sidebarPanel(),
             # show the information in main panel
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
  
  # Tab 2: Name with different spellings                    
  tabPanel('Name with Different Spellings',
           # title
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
  
  # Tab 3: The trend of Baby names by year
  tabPanel('Baby Names by year',
           # title
           titlePanel("Trend of Baby Names"),
           # Create sidebar layout 
           sidebarLayout(
             # sidebar panel
             sidebarPanel(
               # Input to select a name 
               selectInput("select", label = h3("Select name"), 
                           choices = choices, 
                           selected = 1)),
             # display the plot
             mainPanel(
               plotOutput("babyNamesPlot")
             ))
  ),
  
  # Tab 4: The Choropleth map shows the count of name in each state
  tabPanel("Map",
           # title
           titlePanel('Map'),
           # Create sidebar layout
           sidebarLayout(
             # sidebar panel
             sidebarPanel(
               # Search bar: type the name in the box to see the map
               textInput("name", label = h3("Search the name"), value = "Mary"), 
               helpText("Note: Note: Type the name into the search box to see how many babies get that name in each state. 
                        If there is no such name you want to see, please try another one.")
             ),
             # display the map
             mainPanel(
               plotlyOutput('map')
             ))
  ),
  
  # Tab 5: The barplot to show the top 5 popular name by state
  tabPanel("State Popularity",
           # title
          titlePanel("State Popularity Top 5"),
          # Create the sidebar layout 
            sidebarLayout(
             # sidebar panel
             sidebarPanel(
               # Input to select a state
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