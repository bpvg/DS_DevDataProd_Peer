# Initialize Server Code
library(shiny)
source("BlackScholes.R")


# Server Function
shinyServer(
    function(input, output) {
        
        output$outTable <- renderTable({Calculator(input$inPrice, 
                                                   input$inStrike,
                                                   input$inMaturity,
                                                   input$inVolat,
                                                   input$inIntRate,
                                                   input$inDivY)})
        
    }
)