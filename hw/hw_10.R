install.packages("shiny")
library(shiny)
library(ggplot2)


# Global variables can go here
n <- 200


# Define the UI
ui <- bootstrapPage(
  tags$h1("Shiny App by Lisa Liubovich"),
  numericInput('n', 'Number of obs', n),
  plotOutput('plot')
)

# Define the server code
server <- function(input, output) {
  output$plot <- renderPlot({
    # Generate random data
    data <- runif(input$n)
    
    # Create a boxplot and color it red
    boxplot(data, col = "red", main = "Boxplot of Random Data")
  })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)
