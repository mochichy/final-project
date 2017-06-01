# ui.R
# load the packages
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

#import the dataset
data <- read.csv(file='StateNames.csv', header=TRUE, stringsAsFactors = FALSE)
#list of data that will be used later in the code, Tab 3 and Tab 5
choices <- data %>% select(Name) %>% unique()
c <- data %>% select(State) %>% unique


shinyUI(navbarPage('Baby Names',
  
  # Tab 1: Information page
  tabPanel('Information Page',
             # show the information in main panel
             mainPanel(
              h1("Introduction"),
              p("We will be using the “US Baby State Names” dataset released by Data.gov, 
              which contains a lot of different baby names across different states in the US. 
              In this dataset, only names with at least 5 babies born in the same year per state 
              are included for privacy reasons, as mentioned on the website. "),
              div("The original data set is obtained from (https://www.kaggle.com/kaggle/us-baby-names) "
                   ,style="color:blue"),
              p("The dataset includes 6 columnss: Id, Name, Year, Gender, State and Count."),
              p("Some possible target audience will be parents who are deciding on a name for their 
                new baby, people who are curious about the current trends in baby names
                (like us!), and those who are interesting in gaining some interesting
                insights on their names. "),
              
              h1("Questions That We Answer"),
              p("What are the most popular names by state?"),
              p("Does your name happen to be one of the popular names in a certain state in a specific year?"),
              p("Do the popular names have similar spellings?"),
              p("What is the trend of the name over year?"),
              p("Does there seem to be an association between name popularity and location(East and West coast?"),
              p("We have created 4 tabs to answer all the questions above. Please click in each tab to view more."),
              
              h1("Challenges that We Faced"),
              p("Since there are 4 people working on this project together, there were conflicts when 
                we try to push our individual changes back up to github. Resolving the conflicts is challenging,
                however, we managed to overcome the challenge. It is also our first time working with tabs in 
                Shiny, and we had a litttle trouble using the appropriate syntax. The baby-names dataset is fairly 
                large, which contains up to millions of rows. We managed to create a test dataset which is a 
                smaller subset of the baby-names dataset, and tested our code based on it. It is definitely more 
                efficient and less time consuming.")
             
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
               plotlyOutput('line'),
               h1("What is this graph about?"),
               p("There are some names with different spelling! We chose a few example to show the trend of 
                 each different spelling of the name over years.")
               
             )
           )
  ),
  
  # Tab 3: The trend of Baby names by year
  tabPanel('Baby Names by year',
           # title
           titlePanel("Names"),
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
               plotOutput("babyNamesPlot"),
               h1("What is this graph about?"),
               p("This graph shows the changes in the count of a selected baby name over the years in the United States."),
               p("The count in each year represents the total number of babies with the selected baby name across all states in the US.")
             ))
  ),
  
  # Tab 4: The Choropleth map shows the count of name in each state
  tabPanel("Map and Name Popularity",
           # title
           titlePanel('Map'),
           # Create sidebar layout
           sidebarLayout(
             # sidebar panel
             sidebarPanel(
               # Search bar: type the name in the box to see the map
               textInput("name", label = h3("Search the name"), value = "Mary"), 
               helpText("Note: Type the name into the search box to see how many babies get that name in each state. 
                        If there is no such name you want to see, please try another one.")
             ),
             # display the map
             mainPanel(
               plotlyOutput('map'),
               h1("What is this graph about?"),
               p("This graph shows the number of a specific name in each state. With the color bar at the right of the graph 
                 you can see that more people get the chosen name in the state, the color is darker."),
               p("You can hover on each state to see the details.")
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
               plotlyOutput('barplot'),
               h1("What is this graph about?"),
               p("This graph shows the top 5 popular names and their counts, according to each 
                 state. The x-axis shows the names, and the y-axis shows the counts(popularity)
                 in Ks. You can hover on the barplot to view details.")
             )
  )
)))