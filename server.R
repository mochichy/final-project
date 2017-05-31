library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  output$babyNamesPlot <- renderPlot({
    plot.data <- data %>% filter(Name == input$select) %>% group_by(Year) %>% summarise(Count = sum(Count))
    return (ggplot(plot.data, aes(x=Year, y=Count)) + geom_point(color='darkblue'))
  })
  
  output$line <- renderPlotly({ 
    return(BuildLineChart(data, input$var))
  })
  
})