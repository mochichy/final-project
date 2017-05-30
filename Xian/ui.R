# ui.R
library(plotly)
# Start shiny ui)
shinyUI(fluidPage(
  sidebarPanel(
    textInput("name", label = h3("Search the name"), value = "Mary"), 
    helpText("Note: If there is no such name, please try another name."),
    submitButton("Update")
  ),
  mainPanel(plotlyOutput('map'))
  
))