# Initialize Server Code
library(shiny)
source("BlackScholes.R")

# Output table constructor function
Calculator <- function(Spot, Strike, Maturity, Vol, Rate, DivY){
    
    C <- Call(Spot, Strike, Sys.Date(), Maturity, Vol, Rate, DivY)
    P <- Put(Spot, Strike, Sys.Date(), Maturity, Vol, Rate, DivY)
    
    output <- t(rbind(C, P))
    return(output)
}


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