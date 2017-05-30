# line chart
library(plotly)
library(dplyr)
library(ggplot2)


list <- list(z = c("Zoey", "Zoe", "Zoie"), e = c("Erik", "Eric", "Erick"),
             l = c("Lucas", "Lukas"), n = c("Nicholas", "Nickolas", "Nicolas", "Nikolas"),
             zz = c("Zachary", "Zackary"))

BuildLineChart <- function(data, names) {
  this.data <- FilterData(data, list[[names]])
  g<- ggplot(this.data) + geom_line(aes(y = Count, x = Year, colour = Name)) +
      ggtitle("Names with Different Spellings")

  return (ggplotly(g))
}

FilterData <- function(data, names) {
  this.data <- data %>% filter(Name %in% names) %>% 
    group_by(Name, Year) %>%  
    summarise(Count = n())
  return (this.data)
}



