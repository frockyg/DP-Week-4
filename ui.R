#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Vapor Pressure of Mercury as a Function of Temperature"),
  sidebarLayout(
    sidebarPanel(
    #  sliderInput("sliderMPG","What is the MPG of the car?",10, 35, value=20),
      sliderInput("sliderTemp","What is the temperature in degrees celcius?",0, 350, value=250),
      checkboxInput("showModel1","Show/Hide Model 1",value=TRUE),
      checkboxInput("showModel2","Show/Hide Model 2",value=TRUE),
      submitButton("Submit") #New!
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Pressure from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Pressure from Model 2:"),
      textOutput("pred2")
    )
    )
  ))

#   # Define UI for application that draws a histogram
#   fluidPage(

#       # Application title
#       titlePanel("Old Faithful Geyser Data"),

#       # Sidebar with a slider input for number of bins
#       sidebarLayout(
#           sidebarPanel(
#               sliderInput("bins",
#                           "Number of bins:",
#                           min = 1,
#                           max = 100,
#                           value = 40)
#           ),

#           # Show a plot of the generated distribution
#           mainPanel(
#               plotOutput("distPlot")
#           )
#       )
#   )
