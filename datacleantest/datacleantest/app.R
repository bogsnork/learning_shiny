#courtesy of http://www.minchunzhou.com/project/allstate1_descriptive.html
library(shiny)
library(ggplot2)

ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Allstate data Descriptive statistics"),
  
  sidebarLayout(
    sidebarPanel(
      
      # select dataset 
      selectInput("Dataset", "Training/Test", 
                  choices = unique(alldata$type)),
      
      # select variable
      selectInput("Variable", "Column", 
                  choices = colnames(alldata)[-1]),
      
      # select plot type
      selectInput("Plot", "Plot Type", 
                  choices = c("Histogram", "QQplot"))
    ),
    
    mainPanel(
      
      # The plot is called Descriptive and will be created in ShinyServer part
      plotOutput("Descriptive")
    )
  )
))

server <- shinyServer(function(input, output) {
  
  output$Descriptive <- renderPlot({
    
    # subset of data
    plotdata <- alldata[ alldata$type == input$Dataset, input$Variable]
    
    # choose the type of plot
    if (input$Plot == "Histogram"){
      
      # whether the variable is continuous or not
      if (substr(input$Variable, 1,4) == "cont"){ 
        
        # histogram for continuous variable
        ggplot(data.frame(plotdata),aes(x=plotdata))+ geom_histogram()
        
      } else {
        
        # barplot for categorical variable
        ggplot(data.frame(plotdata),aes(x=plotdata))+ geom_bar()
        
      }
      
      # if select the QQplot
    } else if (input$Plot == "QQplot") {
      
      # whether the variable is continuous or not
      if (substr(input$Variable, 1,4) == "cont"){
        
        # QQplot for continuous variables
        ggplot(data.frame(plotdata),aes(sample=plotdata)) + stat_qq()
        
      }}
  }) 
})

# Run the application 
shinyApp(ui = ui, server = server)