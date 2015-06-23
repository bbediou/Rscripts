library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Customize your plot!"),
  
    sidebarLayout(
      sidebarPanel(  
  # drop down menu
        selectInput("PLOT", "STIMULI or FIGURE:", 
                    choices = c("stimuli","figure")),
        selectInput("SD", "Choose a Standard Deviation:", 
                    choices = c(0.2,0.4,0.6,0.8)),
        # drop down menu
        selectInput("bin", "Choose a bin (stimuli only): \n1=fear, 9=surprise", 
                    choices = c("all",c(1:9))),
        # slider
        sliderInput("trialnum",
                    "trial:",
                    min = 1,
                    max = 150,
                    value = 1)
      ),
  
    mainPanel(
       plotOutput("distPlot")
    )
  )
))