#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(MASS)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$matvarcov <- renderUI({
    validate(
      need(
        input$covxy/(sqrt(input$varX * input$varY)) >= -1 & input$covxy/(sqrt(input$varX * input$varY)) <= 1,"La matrice de variance-covariance n'est pas définie positive"
      )
    )
    withMathJax(
      sprintf("$$
               \\begin{pmatrix} 
               %g & %g \\\\
               %g & %g 
               \\end{pmatrix}
               $$
               
               
               ",input$varX,input$covxy,input$covxy,input$varY)
    )
  })
  
  mat <- reactive({
    matcov <- matrix(data = c(input$varX,input$covxy,input$covxy,input$varY), nrow = 2)
    
    df <- as.data.frame(
      mvrnorm(n = 1000,
              mu = c(input$espX,input$espY),
              Sigma = matcov
      )
    )
    colnames(df) <- c("X","Y")
    return(df)
  })
  
  output$plot <- renderPlot({
    
    validate(
      need(
        input$covxy/(sqrt(input$varX * input$varY)) >= -1 & input$covxy/(sqrt(input$varX * input$varY)) <= 1,"La matrice de variance-covariance n'est pas définie positive"
      )
    )
    

    par(pty = "s")
    ggplot(mat()) +
      aes(x = X,y = Y) +
      geom_point()
    
  }, height = 500, width = 500)
  
  output$coef_correlation <- renderUI({
    validate(
      need(
        input$covxy/(sqrt(input$varX * input$varY)) >= -1 & input$covxy/(sqrt(input$varX * input$varY)) <= 1,""
      )
    )
    sprintf("Le coefficient de corrélation vaut %g", round(cor(mat()$X,mat()$Y),3))
  })
  
  output$partie_cours <- renderUI({
    # Partie cours à saisir ici, je n'ai pas beaucoup de connaissances sur les vecteurs gaussiens.
  })
  
})
