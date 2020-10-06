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
  titlePanel("Vecteurs Gaussiens"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      div(
        style="display: inline-block;vertical-align:top; width: 49%;",
        numericInput(
          inputId = "espY",
          label = "Espérance de Y",
          value = 0
        )
      ),
      div(
        style="display: inline-block;vertical-align:top; width: 49%;",
        numericInput(
          inputId = "espX",
          label = "Espérance de X",
          value = 0
        )
      ),
      
      div(
        style="display: inline-block;vertical-align:top; width: 49%;",
        numericInput(
          inputId = "varX",
          label = "Variance de X",
          value = 1,
          min = 0
        )
      ),
      div(
        style="display: inline-block;vertical-align:top; width: 49%;",
        numericInput(
          inputId = "varY",
          label = "Variance de Y",
          value = 1,
          min = 0
        )
      ),
      
      numericInput(
        label = "Covariance X-Y",
        inputId = "covxy",
        value = 1
      ),
      HTML("Nous obtenons la matrice de variance-covariance suivante :"),
      uiOutput("matvarcov"),
      uiOutput("coef_correlation"),
      HTML("<br>"),
      actionButton(
        inputId = "afficher_cours",
        label = "Rappels de cours"
      ),
      conditionalPanel(
        condition = "input.afficher_cours % 2 != 0",
        uiOutput("partie_cours")
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot")
    )
  )
))
