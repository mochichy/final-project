library(dplyr)
library(shiny)

source('./BuildLineChart.R')

data <- read.csv("../StateNames.csv")

shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map
  output$line <- renderPlotly({ 
    return(BuildLineChart(data, input$var))
  })
})
