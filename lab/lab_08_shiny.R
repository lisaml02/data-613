## 1 
install.packages("shiny")
library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Iris Scatter Plot"),
  selectInput("var1", "Variable 1", choices = names(iris)),
  selectInput("var2", "Variable 2", choices = names(iris)),
  plotOutput("plot")
)

server <- function(input, output){
  output$plot <- renderPlot({
    ggplot(iris, aes(x = .data[[input$var1]], y = .data[[input$var2]])) +
      geom_point(color = "red") +
      ggtitle("Iris Scatterplot")
  })
}

shinyApp(ui = ui, server = server)

## 2
ui <- fluidPage(
  titlePanel("Iris Box Plots"),
  selectInput("var1", "Variables", choices = names(iris)),
  plotOutput("plot")
)

server <- function(input, output){
  output$plot <- renderPlot({
    ggplot(iris, aes(y = .data[[input$var1]])) +
      geom_boxplot(fill = "blue") +
      ggtitle("Iris Box Plots")
  })
}

shinyApp(ui = ui, server = server)


## 3
sports <- c("Football", "Basketball", "Baseball", "Tennis", "Soccer")
ui <- fluidPage(
  titlePanel("Play Ball !"),
  checkboxGroupInput("sports", "What are your favorite sports?", 
                     choices = sports)
)

server <- function(input, output) {
  
}

shinyApp(ui = ui, server = server)