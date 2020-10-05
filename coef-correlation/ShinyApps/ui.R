library(shiny)
library(MASS)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Trouver la corrélation"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      width = 4,
      HTML("Le but de cette application est d'arriver à deviner, à l'oeil, la valeur du coefficient de corrélation linéaire entre la variable X et Y, représenté par ce nuage de points.<br><br>"),
      actionButton(
        inputId = "reload",
        label = "Nouvelle corrélation",
        icon = icon("check")
      ),
      HTML("<br><br>"),
      sliderInput("nbIndiv",
                  "Nombre d'observations :",
                  min = 10,
                  max = 1000,
                  value = 500
      ),
      numericInput(
        inputId = "Reponse",
        label = "Saisir une estimation du coefficient de corrélation linéaire :",
        min = -1,
        max = 1,
        value = NA,
        step = 0.1
      ),
      
      actionButton(
        inputId = "valide",
        label = "Valider",
        icon = icon("check")
      ),
      

      HTML("<br><br>"),
      textOutput("test_reponse"),
      HTML("<br><br>"),
      
      actionButton(
        inputId = "cours",
        label = "Rappels de cours"
      ),
      conditionalPanel("input.cours % 2 != 0",
                       uiOutput("Partie_cours")
      )
      
    ),
    
    mainPanel(
      width = 8,
      plotOutput("distPlot", width = "100%")
    )
  )
))
