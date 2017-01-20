#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Sacramento Housing Prices"),
  
  # Sidebar  
  sidebarLayout(
    sidebarPanel(
      sliderInput("baths", "Number of Bathrooms",
                  1,8,c(1,8),step=0.5),
      sliderInput("beds", "Number of Bedrooms",
                  1,8,c(1,8)),
      sliderInput("sqft", "Square Foot Range",
                  0,5000,c(1000,4000)),
      checkboxInput("fit", "Fit a Linear Model")
    ),
    
    
    # Show a plot and table
    mainPanel(
      tabsetPanel(
        tabPanel("Instructions", verbatimTextOutput("instructions")),
        tabPanel("Output", plotOutput("pricePlot"), tableOutput("fitTable"))
      )
    )

  )
))
