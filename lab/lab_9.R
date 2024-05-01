## 1
library(tidyverse) 
library(shiny)

diamonds%>%
  select(carat,price,x,y,z) -> diamonds1
diamonds1

ui <- fluidPage(
  titlePanel("Frequency Plots"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("DVvar", "Diamond Variables", 
                  choices = c("carat", "price", "x", "y", "z"),
                  selected = "carat")
    ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(diamonds, mapping = aes(x = .data[[input$DVvar]], color = cut)) +
      geom_freqpoly(binwidth = 0.1) +
      ggtitle("frequency polygons")
  })
}
shinyApp(ui = ui, server = server)
