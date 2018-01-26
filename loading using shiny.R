
getwd()
load("Tree.Rdata")
library(RColorBrewer)
palette <- brewer.pal(3,"Set2")

ui <- fluidPage(titlePanel("Magical Iris Prediction"),
                sidebarLayout(sidebarPanel(sliderInput(inputId = "petal.length",
                                                       min = 1,
                                                       max = 7,
                                                       value = 4,
                                                       label = "Petal Length (cm)"
                                                      ),
                                           sliderInput(inputId = "petal.width",
                                                       label = "Petal Width",
                                                       min = 0.0,
                                                       max = 2.5,
                                                       step = 0.5,
                                                       value = 1.5)),
                                           mainPanel(textOutput(outputId = "text"),
                                                     plotOutput(outputId = "plot"))))

#Server function
server <- function(input,output){
  output$text = renderText({
    predictors <- data.frame(Petal.Length = input$petal.length,
                             Petal.Width = input$petal.width,
                             Sepal.Length = 0,
                             Sepal.Width = 0)
  
    prediction = predict(object = model,
                         newdata = prediction,
                         type = "class")
    
    paste("predicted species is", as.character(prediction))
      
  })
  
  output$plot = renderPlot({
    
    plot(
    x = iris$Petal.Length,
    y = iris$Petal.Width,
    pch = 19,
    col = palette[as.numeric(iris$Species)],
    main = "Iris Data set Details",
    xlab = "Petal Length",
    ylab = "Petal Width")
    
    partition.tree(model,
                   label = "Species",
                   and = TRUE)
    
    points(x = input$petal.length,
           y = input$petal.width,
           col = "Red",
           pch = 4,
           cex = 2,
           lwd = 3)
  })
}
library(shiny)

shinyApp(ui = ui, server = server)
