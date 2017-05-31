library(shiny)
library(dplyr)
library(ggplot2)

setwd("~/Desktop/")
data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)
choices <- data %>% select(Name) %>% unique()

shinyUI(fluidPage(
  
  titlePanel("Trend of Baby Names"),
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = h3("Select name"), 
                  choices = choices, 
                  selected = 1)
    ),
    mainPanel(
      plotOutput("babyNamesPlot")
    )
  )
))