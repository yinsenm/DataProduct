library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Car MPG Prediction"),
    sidebarPanel(
        h3("Description"),
        p("This app build a simple linear regression model with mpg dataset.
           It can predict the average mpg values given weight and transimission
           type of the car. Because the model includes the iteraction between 
           weight and transimission, so you can see two lines with 
           different intercepts and slopes."),
        p("You can observe the fitted new values by the corresponding veritical, horizontal lines and 
           label. And see the predicted result below the plot."),
        h3('Input Panel'),
        p("Please input weight and transmission value:"),
        sliderInput('iwt', 'Car Weight (lb/1000)', 0, min = 0, max = 6, step = .2),
        selectInput("iam", "Transmission Type",
                           c("Automatic" = "0",
                             "Manual" = "1"), multiple = F
                    )
    ),
    mainPanel(
        h3('Output Panel'),
        plotOutput("newPlot", width = "700px", height = "600px"),
        h3('Predicted MPG'),
        verbatimTextOutput("ompg")
    )
))

