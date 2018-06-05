#A Groovy Shiny app 
#CK learning to use Shiny
#July 2017

library("shiny")

ui <- fluidPage(
  sliderInput(inputId = "num",
              label = "Choose a number",
              value = 25, min = 1, max = 100), 
  plotOutput("hist"),
  plotOutput("bar")
)

server <- function(input, output) {
  output$hist <- renderPlot({hist(rnorm(input$num))})
  output$bar <- renderPlot({barplot(rnorm(input$num))})  
}

shinyApp(ui = ui, server = server)
