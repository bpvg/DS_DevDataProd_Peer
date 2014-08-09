# Initialize User Interface Code
library(shiny)
library(markdown)

# Creating page layout
shinyUI( 
    navbarPage(
        "YAOOP! - Yet Another Online Options Pricer", 
        windowTitle = "YAOOP!", 
        collapsable = TRUE, 
        inverse     = TRUE, 
        theme       = "bootstrap.css", 
        
        
        # Homepage
        tabPanel(
            "Home",
            includeMarkdown("Readme.md")
        ),
               
        
        # Pricer
        tabPanel(
            "Pricer",
            sidebarLayout(
                
                # Pricer Inputs
                sidebarPanel(
                    width = 2, 
                    h4("Inputs"), 
                    numericInput("inPrice", 
                                 "Spot price: ",
                                 value=200, min=0.00, max=1000, step=1),
                    numericInput("inStrike", 
                                 "Strike price: ",
                                 value=200, min=0.00, max=1000, step=1),
                    sliderInput("inIntRate", 
                                "Interest Rate: ",
                                value=0.02, min=-0.02, max=0.20, step=0.0025, 
                                format="0.####%"),
                    sliderInput("inDivY", 
                                "Dividend Yield: ",
                                value=0.03, min=0.00, max=0.20, step=0.0025, 
                                format="0.####%"),
                    sliderInput("inVolat", 
                                "Volatility: ",
                                value=0.2, min=0.00, max=1, step=0.001, 
                                format="0.####%"),                
                    dateInput("inMaturity",
                              "Maturity date: ",
                              value=Sys.Date()+60, min=Sys.Date()+1)
                ),
            
                # Pricer Outputs
                mainPanel(
                    br(), 
                    h4("Pricing Results"),
                    tableOutput("outTable")
                )
            )
        )
    )
)


