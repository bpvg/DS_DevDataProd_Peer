# Initialize User Interface Code
library(shiny)

# Creating page layout
shinyUI(
    fluidPage(
        # Page tittle and Introduction
        titlePanel("Page Name","PageTitle"),
        
        sidebarLayout(
            # Sidebar Panel
            sidebarPanel(
                h4("Inputs")
                
            ),
            
            # Results Panel
            mainPanel(
                h4("Pricing Results")
            )
        )
    )
)


