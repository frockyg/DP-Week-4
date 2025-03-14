#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

shinyServer(function(input,output){
  #mtcars$mpgsp<-ifelse(mtcars$mpg-20>0,mtcars$mpg-20,0)
  pressure$temperaturesp<-ifelse( pressure$temperature -250>0,pressure$temperature-250,0)
  model1<-lm(pressure~temperature,data=pressure)
  #model2<-lm(pressure~temperature+temperaturesp,data = pressure)
  model2<-lm(pressure~temperaturesp,data = pressure)
 
  model1pred <-reactive({
    tempInput<-input$sliderTemp
    predict(model1,newdata=data.frame(temperature=tempInput))
  }) 
  
  model2pred<-reactive({
    tempInput<-input$sliderTemp
    predict(model2,newdata=
              data.frame(#temperature=tempInput,
                         temperaturesp=ifelse(tempInput-250>0,
                                      tempInput-250,0)))
  })
  output$plot1<-renderPlot({
    tempInput<-input$sliderTemp
    
    plot(pressure$temperature,pressure$pressure,xlab="temperature in degrees celcius",
         ylab="Vapor pressure of mercury in millimeters (of mercury).",bty="n",pch=16,
         xlim=c(0,350),ylim=c(-200,800))
    if(input$showModel1){
      abline(model1,col="red",lwd=2)
    }
    if(input$showModel2){
      model2lines<-predict(model2,newdata=data.frame(
        temperature=0:350,temperaturesp=ifelse(0:350-250>0,0:350-250,0)
      ))
      lines(0:350,model2lines,col="blue",lwd=2)
    }
    legend(25,250,c("Model 1 Prediction","Model 2 Prediction"),pch=16,
           col=c("red","blue"),bty="n",cex=1.2)
    points(tempInput,model1pred(),col="red",pch=16,cex=2)
    points(tempInput,model2pred(),col="blue",pch=16,cex=2)
    })
    
    output$pred1<-renderText({
      model1pred()
    })
    
    output$pred2<-renderText({
      model2pred()
    })
})



#   # Define server logic required to draw a histogram
#   function(input, output, session) {

#       output$distPlot <- renderPlot({

#           # generate bins based on input$bins from ui.R
#           x    <- faithful[, 2]
#           bins <- seq(min(x), max(x), length.out = input$bins + 1)

#           # draw the histogram with the specified number of bins
#           hist(x, breaks = bins, col = 'darkgray', border = 'white',
#                xlab = 'Waiting time to next eruption (in mins)',
#                main = 'Histogram of waiting times')

#       })

#   }
