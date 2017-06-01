# server.R
# load the packages 
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

# read in data
data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)
# source the script
source('./BuildLineChart.R')


shinyServer(function(input, output) {
  
  # Render a plot object that returns the scatter plot
  output$babyNamesPlot <- renderPlot({
    # filter to get the data we want 
    plot.data <- data %>% 
                filter(Name == input$select) %>% 
                group_by(Year) %>% 
                summarise(Count = sum(Count))
    return (ggplot(plot.data, aes(x=Year, y=Count)) + geom_point(color='darkblue') + labs(title = "Trend of Baby Names Over Time"))
  })
  
  # Render a plotly object that returns the line plot
  output$line <- renderPlotly({ 
    # using the BuildLineChart script
    return (BuildLineChart(data, input$var))
  })
  
  # Render a plotly object to get the map
  output$map <- renderPlotly({
    # filter to get the data will be used for the plot
    filtered <- data %>% filter(Name == input$name)
    count <- filtered %>% group_by(State) %>% summarise(sum = sum(Count))
    # using plotly to get the Choropleth map
    g <- list(scope = 'usa', projection = list(type = 'albers usa'), lakecolor = toRGB('white'))
    plot_geo(count, locationmode = 'USA-states') %>% add_trace(
      z = ~sum, text = ~State, locations = ~State, color = ~sum, colors = 'Reds') %>%
      colorbar(title = "count") %>%
      layout(title = "Count of babies with the chosen name by state",geo = g) 
  })
  
  # Render a plotly object to get the bar plot
  output$barplot <- renderPlotly({ 
    # filter to get the data will be used for the plot
    new.data <- data %>% filter(State == input$barplot1)
    new.data.plot <- distinct(new.data,Name,.keep_all=TRUE) 
    new.data.plot <- new.data.plot %>% arrange(desc(Count)) %>% filter(row_number() <=5L)
    # using plotly to get the bar plot
    graph <- plot_ly(new.data.plot,x=~Name,y=~Count,type="bar") %>%
      layout(title = "Name Popularity by State",xaxis=list(title="Names"),yaxis=list(title="Popularity/Millions"))
  })
})