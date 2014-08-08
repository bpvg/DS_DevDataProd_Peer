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
                    h4("Inputs")
                ),
            
                # Pricer Outputs
                mainPanel(
                    h4("Pricing Results")
                )
            )
        )
    )
)


