library(tidyverse)
library(shiny)
library(datasets)

ui <- fluidPage(
  tags$head(
    tags$style(
      HTML("body { background-color: yellow; }")
    )
  ),
  titlePanel(tags$span("Lisa Liubovich", style = "color: blue;")),
  h1("FINAL EXAM Shiny App Iris Data", style = "color: red;"),
  sidebarLayout(
    sidebarPanel(
      selectInput("vars", "Iris Variables", 
                  choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
                  selected = "Sepal.Length")
    ),
    mainPanel(
      plotOutput("plot1"),
      plotOutput("plot2"),
      DT::dataTableOutput("table1")
    )
  )
)

server <- function(input, output) {
  
  output$plot1 <- renderPlot({
    ggplot(iris, aes(x = .data[[input$vars]])) +
      geom_histogram(color = "red", fill = "blue")
  })
  
  output$plot2 <- renderPlot({
    ggplot(iris, aes(y = Sepal.Length, x = .data[[input$vars]])) +  
      geom_boxplot(fill = "red", color = "blue") +
      coord_flip()  
  })
  
  output$table1 <- DT::renderDataTable({
    DT::datatable(iris)
  })
}

shinyApp(ui = ui, server = server)