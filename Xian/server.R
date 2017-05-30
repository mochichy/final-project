# Map 
# server.R
library(shiny)
library(dplyr)
library(plotly)

# read in data
data <- read.csv('StateNames.csv', stringsAsFactors = FALSE)


# start shiny server
shinyServer(function(input, output){
  
  #count <- data %>% filter(Name == input$name) %>% group_by(state) %>% summarise(sum = sum(count)) %>% select(sum)
  output$map <- renderPlotly({
    filtered <- data %>% filter(Name == input$name)
    count <- filtered %>% group_by(State) %>% summarise(sum = sum(Count))
    g <- list(scope = 'usa', projection = list(type = 'albers usa'), lakecolor = toRGB('white'))
    plot_geo(count, locationmode = 'USA-states') %>% add_trace(
         z = ~sum, text = ~State, locations = ~State, color = ~sum, colors = 'Reds') %>%
         colorbar(title = "count") %>%
         layout(title = "Count of name in each state",geo = g) 
  })
})