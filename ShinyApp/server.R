#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(caret)
data("Sacramento")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$instructions <- renderText({
    "Click the 'Output' tab to see a plot of Housing Prices \n\n - Using the sliders, select the range of values of interest \n - Check the 'Fit a Linear Model' box to show: \n   - A fitted linear regression line\n   - Corresponding model parameters"
  })
   
  output$pricePlot <- renderPlot({
    
    #data("Sacramento")
    
    #col <- Sacramento$baths
    
    showfit <- input$fit
    losf <- input$sqft[1]
    hisf <- input$sqft[2]
    lobe <- input$beds[1]
    hibe <- input$beds[2]
    loba <- input$baths[1]
    hiba <- input$baths[2]
    sac <- filter(Sacramento, ((sqft>=losf&sqft<=hisf)&(beds>=lobe&beds<=hibe)&(baths>=loba&baths<=hiba)))

    x <- sac$sqft
    y <- sac$price
     
    # plot
    g <- ggplot(data=sac, aes(x=x,y=y))
    g <- g + geom_point()
    g <- g + xlab("Square Feet")
    g <- g + ylab("Price")
    if (showfit==TRUE) {
      g <- g + geom_smooth(method="lm")
    }
    g
    
  })
  
  output$fitTable <- renderTable({
    showfit <- input$fit
    if (showfit==TRUE) {
      showfit <- input$fit
      losf <- input$sqft[1]
      hisf <- input$sqft[2]
      lobe <- input$beds[1]
      hibe <- input$beds[2]
      loba <- input$baths[1]
      hiba <- input$baths[2]
      sac <- filter(Sacramento, ((sqft>=losf&sqft<=hisf)&(beds>=lobe&beds<=hibe)&(baths>=loba&baths<=hiba)))
      
      x <- sac$sqft
      y <- sac$price
      
      fit <- lm(y ~ x, data=sac)
      
      summary(fit)$coef
      
    }
  },rownames=TRUE, bordered=TRUE)

})
