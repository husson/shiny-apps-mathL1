#library(shiny)
#library(mvtnorm)

shinyUI(fluidPage(
  titlePanel("Exercice sur le Théorème Central Limite"),
  
    sidebarPanel(
      sliderInput("N", "Taille de l'échantillon", min = 2, max = 1000, value = 5, step=1),
      radioButtons("Loi", "Loi de X", choices=c("Normale"="gaussian","Chi2 à 1 ddl"="chi2","Uniforme"="uniform","Log normale"="lognormal","Bimodale"="bimodale"),selected="gaussian"),
      h4(" "),
      tableOutput("tablo")
#      actionButton("goButton","Relancer l'analyse")
    ),
    
    mainPanel(
#      h4("Histogramme de X"),
      plotOutput("histoX"),
#      h4("Histogramme de la moyenne d'un échantillon"),
      plotOutput("histo")
  )
))
