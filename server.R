# Initialize Server Code
library(shiny)
library(rCharts)
source("BlackScholes.R")
options(RCHART_WIDTH = 800)

# Output table constructor function
Calculator <- function(Spot, Strike, Maturity, Vol, Rate, DivY){
    
    C <- Call(Spot, Strike, Sys.Date(), Maturity, Vol, Rate, DivY)
    row.names(C) <- "CALL"
    P <- Put(Spot, Strike, Sys.Date(), Maturity, Vol, Rate, DivY)
    row.names(P) <- "PUT"
    output <- t(rbind(C, P))
    return(output)
}

# Output chart constructor function
Charter <- function(xvar, yvar, cp, Spot, Strike, Maturity, Vol, Rate, DivY){
    mult <- seq(0.25, 1.75, by=0.05)
    
    if(xvar=="Spot"){
        v <- Spot * mult
        if(cp=="Call"){
            df <- Call(v, Strike, Sys.Date(), Maturity, Vol, Rate, DivY)
        } else {
            df <- Put(v, Strike, Sys.Date(), Maturity, Vol, Rate, DivY)
        }        
    }
    if(xvar=="Strike"){
        v <- Strike * mult
        if(cp=="Call"){
            df <- Call(Spot, v, Sys.Date(), Maturity, Vol, Rate, DivY)
        } else {
            df <- Put(Spot, v, Sys.Date(), Maturity, Vol, Rate, DivY)
        }        
    } 
    df$X <- v
    return(df)
}

# Server Function
shinyServer(
    function(input, output) {
        
        output$outTable <- renderTable({Calculator(input$inPrice, 
                                                   input$inStrike,
                                                   input$inMaturity,
                                                   input$inVolat,
                                                   input$inIntRate,
                                                   input$inDivY)},digits=4)

        output$outChart <- renderChart({
            dataF <- Charter(input$inX, input$inY, input$inType, 
                             input$inPrice, input$inStrike, input$inMaturity,
                             input$inVolat, input$inIntRate, input$inDivY)
            c <- rPlot(premium ~ X, type="line", data= dataF)
            c$guides(x = list(title = input$inX))
            c$guides(y = list(title = input$inY))
            c$addParams(height = 290, dom = 'outChart')
            return(c)
        })
    }
)