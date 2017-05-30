# ui.R
library(shiny)
library(plotly)


shinyUI(navbarPage('Names with Different Spelling',
                   # Create a tab panel for the chart
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
                   
))