# Initialize Server Code
library(shiny)
library(ggplot2)
source("BlackScholes.R")

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
    } else {
        if(xvar=="Strike"){
            v <- Strike * mult
            if(cp=="Call"){
                df <- Call(Spot, v, Sys.Date(), Maturity, Vol, Rate, DivY)
            } else {
                df <- Put(Spot, v, Sys.Date(), Maturity, Vol, Rate, DivY)
            } 
        } else {
            if(xvar=="Volatility"){
                v <- Vol * mult
                if(cp=="Call"){
                    df <- Call(Spot, Strike, Sys.Date(), Maturity, v, Rate, DivY)
                } else {
                    df <- Put(Spot, Strike, Sys.Date(), Maturity, v, Rate, DivY)
                } 
            }
        }
    }
    
    df <- cbind(v, df)
    df <- df[, c("v", yvar)]
    names(df) <- c("X", "Y")
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
                                                   input$inDivY)},digits=3)

        output$outChart <- renderPlot({
            df <- Charter(input$inX, input$inY, input$inType, 
                             input$inPrice, input$inStrike, input$inMaturity,
                             input$inVolat, input$inIntRate, input$inDivY)
            
            p <- ggplot(df, aes(x=X, y=Y))
            p <- p + geom_line(col="#802c59", size=2)
            p <- p + xlab(input$inX) + ylab(input$inY)
            p <- p + theme_bw()
            return(p)
        })
    }
)