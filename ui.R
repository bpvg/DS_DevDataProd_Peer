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
            includeMarkdown("Readme.md"), 
            fluidRow(
                column(4, includeMarkdown("Q1.md")),
                column(4, includeMarkdown("Q2.md")),
                column(4, includeMarkdown("References.md"))
            )
        ),
               
        #Tutorial
        tabPanel(
            "Tutorial",
            includeMarkdown("Tutorial.md")
        
        ),
        
        # Pricer
        tabPanel(
            "Pricer",
            sidebarLayout(
                
                # Pricer Inputs
                sidebarPanel(
                    width = 3, 
                    h4("Black-Sholes Inputs"), 
                    numericInput("inPrice", 
                                 "Spot price: ",
                                 value=200, min=0.00, max=1000, step=1),
                    numericInput("inStrike", 
                                 "Strike price: ",
                                 value=200, min=0.00, max=1000, step=1),
                    dateInput("inMaturity",
                              "Maturity date: ",
                              value=Sys.Date()+60, min=Sys.Date()+1), 
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
                                value=0.2, min=0.00, max=1, step=0.0025, 
                                format="0.####%")
                ),
            
                # Pricer Outputs
                
                mainPanel(
                    
                    tabsetPanel(
                        tabPanel("Pricing Results", 
                            #h5("Pricing Results"), 
                            column(3, br(), tableOutput("outTable")),
                            column(9, includeMarkdown("Q3.md"))
                        ),                    
                        tabPanel("Simulation Chart",
                            fluidRow(
                                column(4, selectInput("inX", 
                                                      "X-Axis",
                                                      c("Spot", "Strike",  "Maturity",
                                                        "Interest Rate", "Dividend Yield", 
                                                        "Volatility"),
                                                      "Spot")), 
                                column(4, selectInput("inY", 
                                                      "Y-Axis",
                                                      c("premium", "intrinsic", 
                                                        "temporal", "delta", "gamma", 
                                                        "theta", "vega", "vanna", 
                                                        "vomma", "rho"),
                                                      "premium")),    
                                column(4, radioButtons("inType", 
                                                       "Type",
                                                       c("Call", "Put"),
                                                       "Call",
                                                       inline=TRUE))
                            ),
                            plotOutput("outChart")
                        )
                    )
                )
            )
        )
    )
)


