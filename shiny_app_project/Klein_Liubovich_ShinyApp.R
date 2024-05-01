# load packages
library(tidyverse)    
library(shiny)
library(shinyWidgets)

# load data

#dccovid.csv: Test data taken (and cleaned) from the COVID-19 surveillance website run by the DC government. These data were downloaded on 2021-07-21. Variables include:
#day: The day of the measurements.
#cleared: Number of individuals cleared from isolation.
#lost: Total number of COVID deaths.
#dctested: Total number of DC residents tested.
#tested: Total overall number of tests.
#positives: Total number of positive test results.

dccovid <- read_csv("dccovid.csv")
dccovid <- dccovid %>%
  drop_na()

ui <- fluidPage(
  titlePanel("DC Covid Tests in 2021"),
  h3("Melanie Klein and Lisa Liubovich", align = "left", style = "color:black"),
  p("description", align = "left", style = "color:black"),
  setBackgroundColor(
    color = c("red", "white","blue"),
    gradient = "linear",
    direction = "bottom"
  ),
  sidebarLayout(      
    sidebarPanel(
      selectInput("XVar", "X Covid Variables", 
                  choices=colnames(dccovid)),
      selectInput("YVar", "Y Covid Variables", 
                  choices=colnames(dccovid)),
      sliderInput("date_range", label = "Select Date Range:",
                  min = as.Date("2020-05-22"),
                  max = as.Date("2021-07-19"),
                  value = c(as.Date("2020-05-22"), as.Date("2021-07-19")),
                  step = 1),
      sliderInput("bins",
                  label = "Number of Bins:",
                  min = 1,
                  max = 423,
                  value = 14)
    ),
    mainPanel(
      tabsetPanel(type = "tab",
                  tabPanel("Scatterplot", plotOutput("Scatterplot")),
                  tabPanel("Histogram", plotOutput("Histogram")),
                  tabPanel("Table", DT::DTOutput("Table"))
      ))))

server <- function(input, output) {
  dccovid$day <- as.Date(dccovid$day)
  
  filtered_data <- reactive({
    dccovid %>%
      filter(day >= input$date_range[1] & day <= input$date_range[2])
  })
  
  output$Scatterplot <- renderPlot({
    ggplot(filtered_data(), aes(x = .data[[input$XVar]], y = .data[[input$YVar]])) +
      geom_point(color = "red")
  })
  
  output$Histogram <- renderPlot({
    ggplot(filtered_data(), aes(x = .data[[input$XVar]])) +
      geom_histogram(binwidth = 0.5, fill = "blue", color = "black", bins = input$bins) +
      ggtitle("Histogram")
  })
  
  output$Table <- DT::renderDT({
    DT::datatable(filtered_data())
  })
}

shinyApp(ui = ui, server = server)