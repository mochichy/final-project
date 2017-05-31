library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)


data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)
source('./BuildLineChart.R')


shinyServer(function(input, output) {
  
  output$babyNamesPlot <- renderPlot({
    plot.data <- data %>% filter(Name == input$select) %>% group_by(Year) %>% summarise(Count = sum(Count))
    return (ggplot(plot.data, aes(x=Year, y=Count)) + geom_point(color='darkblue'))
  })
  
  output$line <- renderPlotly({ 
    return (BuildLineChart(data, input$var))
  })
  
  output$map <- renderPlotly({
    filtered <- data %>% filter(Name == input$name)
    count <- filtered %>% group_by(State) %>% summarise(sum = sum(Count))
    g <- list(scope = 'usa', projection = list(type = 'albers usa'), lakecolor = toRGB('white'))
    plot_geo(count, locationmode = 'USA-states') %>% add_trace(
      z = ~sum, text = ~State, locations = ~State, color = ~sum, colors = 'Reds') %>%
      colorbar(title = "count") %>%
      layout(title = "Count of name in each state",geo = g) 
  })
  
  output$barplot <- renderPlotly({ 
    new.data <- data %>% filter(State == input$barplot1)
    new.data.plot <- distinct(new.data,Name,.keep_all=TRUE) 
    new.data.plot <- new.data.plot %>% arrange(desc(Count)) %>% filter(row_number() <=5L)
    graph <- plot_ly(new.data.plot,x=~Name,y=~Count,type="bar") %>%
      layout(title = "Name Popularity by State",xaxis=list(title="Names"),yaxis=list(title="Popularity/Millions"))
  })
})