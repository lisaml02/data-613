## Shiny HW 2

install.packages("shiny")
library(shiny)
library(tidyverse)

diamonds %>% 
  select(carat, price, x, y, z) -> diamonds1

# Convert 'cut' to factor
diamonds1$cut <- as.factor(diamonds$cut)

ui <- fluidPage(
  titlePanel("Frequency Plots, Box Plots, and a Table"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("DVvar", "Diamond Variables", 
                  choices = c("carat", "price", "x", "y", "z"),
                  selected = "carat")
    ),
    
    mainPanel(
      plotOutput("plot1"),
      plotOutput("plot2"),
      tableOutput("table")
    )
  )
)

server <- function(input, output) {
  
  # Frequency Plot
  output$plot1 <- renderPlot({
    ggplot(diamonds, aes_string(x = input$DVvar, color = "cut")) +
      geom_freqpoly(binwidth = 0.1) +
      ggtitle("Frequency Plots")
  })
  
  # Box Plot
  output$plot2 <- renderPlot({
    ggplot(diamonds1, aes_string(x = "cut", y = input$DVvar)) +
      geom_boxplot(fill = "purple", color = "black") +
      ggtitle("Box Plots")
  })
  
  # Table
  output$table <- renderTable({
    diamonds1[, c("carat", "price", "x", "y", "z")]
  })
}

shinyApp(ui = ui, server = server)



## 3

library(shinyWidgets)

diamonds %>% 
  select(carat, price, x, y, z) -> diamonds1

diamonds1$cut <- as.factor(diamonds$cut)

ui <- fluidPage(
  titlePanel("Frequency Plots, Box Plots, and a Table"),
  
  setBackgroundColor(color = "#007BFF"),
  
  tabsetPanel(
    tabPanel("Frequency Plots", 
             sidebarLayout(
               sidebarPanel(
                 selectInput("DVvar1", "Diamond Variables", 
                             choices = c("carat", "price", "x", "y", "z"),
                             selected = "carat")
               ),
               mainPanel(
                 plotOutput("plot1")
               )
             )
    ),
    
    tabPanel("Box Plots", 
             sidebarLayout(
               sidebarPanel(
                 selectInput("DVvar2", "Diamond Variables", 
                             choices = c("carat", "price", "x", "y", "z"),
                             selected = "carat")
               ),
               mainPanel(
                 plotOutput("plot2")
               )
             )
    ),
    
    tabPanel("Table",
             mainPanel(
               tableOutput("table")
             )
    )
  )
)

server <- function(input, output) {
  
  # Frequency Plot
  output$plot1 <- renderPlot({
    ggplot(diamonds, aes_string(x = input$DVvar1, color = "cut")) +
      geom_freqpoly(binwidth = 0.1) +
      ggtitle("Frequency Plots") +
      theme(text = element_text(color = "black"))  
  })
  
  # Box Plot
  output$plot2 <- renderPlot({
    ggplot(diamonds1, aes_string(x = "cut", y = input$DVvar2)) +
      geom_boxplot(fill = "purple", color = "black") +  
      ggtitle("Box Plots") +
      theme(text = element_text(color = "black"))  
  })
  
  # Table
  output$table <- renderTable({
    diamonds1[, c("carat", "price", "x", "y", "z")]
  })
}

shinyApp(ui = ui, server = server)