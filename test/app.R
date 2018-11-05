#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(readxl)
library(janitor)
library(shiny)

vietnam <- read_excel("CACCF.xlsx") %>%
  clean_names()


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Vietnam War Casualties by Age"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 2,
                     max = 7,
                     value = 4)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("vietnam")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$vietnam <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- (vietnam$age)
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white', main = "Histogram of Age", xlab = "Age", ylab = "Total Casualties")
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

