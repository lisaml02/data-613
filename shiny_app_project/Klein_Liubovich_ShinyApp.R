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
  p("This data set contains test data taken (and cleaned) from the COVID-19 surveillance website, which is run by the DC government. These data were downloaded on July 21st, 2021. Variables include:
   day (The day of the measurements),
   cleared (Number of individuals cleared from isolation),
   lost (Total number of COVID deaths),
   dctested (Total number of DC residents tested),
   tested (Total overall number of tests),
    positives (Total number of positive test results)", align = "left", style = "color:black"),
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
    ),
    mainPanel(
      tabsetPanel(type = "tab",
                  tabPanel("Scatterplot", plotOutput("Scatterplot")),
                  tabPanel("Bar Graph", plotOutput("BarGraph")),
                  tabPanel("Table", DT::DTOutput("Table")),
                  tabPanel("Summary" , verbatimTextOutput("summ"))
      ))))

server <- function(input, output) {
  dccovid$day <- as.Date(dccovid$day)
  
  filtered_data <- reactive({
    dccovid %>%
      filter(day >= input$date_range[1] & day <= input$date_range[2])
  })
  
  output$Scatterplot <- renderPlot({
    ggplot(filtered_data(), aes(x = day, y = .data[[input$YVar]])) +
      geom_point(color = "red")
  })
  
  output$BarGraph <- renderPlot({
    ggplot(filtered_data(), aes(x = day, y = .data[[input$YVar]])) +
      geom_bar(stat = "identity", fill = "blue", color = "black")
  })
  
  output$Table <- DT::renderDT({
    DT::datatable(filtered_data())
  })

  output$summ <- renderPrint({
  
   summary(filtered_data())
  })
}

shinyApp(ui = ui, server = server)