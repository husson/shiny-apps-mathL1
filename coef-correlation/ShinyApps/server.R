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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  coefCor <- eventReactive(input$reload,{
    df <- data.frame(x = 1:5, deb = c(0.8,0.4,-0.1,-0.6,-1), fin = c(1,0.6,0.1,-0.4,-0.8))
    
    alea <- sample(1:5,1, replace = T)
    cocor <- round(runif(n = 1, min = df[alea,"deb"], df[alea,"fin"]),2)
    return(cocor)
    
    
    
    
  })
  
  matxy <- reactive({
    
    mat <- as.data.frame(
      mvrnorm(
        n = input$nbIndiv, 
        mu = c(0,0), 
        Sigma = matrix(c(1,coefCor(),coefCor(),1), nrow = 2),
        empirical = T
      )
    )
    colnames(mat) <- c("X","Y")
    
    mat <- mat[mat$X > -2 & mat$X < 2 & mat$Y > -2 & mat$Y < 2,]
    return(mat)
  })
  
  output$distPlot <- renderPlot({
    
    
    
    ggplot(matxy()) +
      aes(x = X, y = Y) +
      geom_point() +
      xlim(-2,2) +
      ylim(-2,2) +
      theme(aspect.ratio = 1)
  }, width = 500, height = 500)
  
  
  text1 <- eventReactive(input$valide, {
    validate(
      need(
        !is.na(input$Reponse),
        "Veuillez saisir une valeur"
      )
    )
    
    reel_cocor <- round(cor(matxy()$X,matxy()$Y),2)
    
    if(abs(input$Reponse - reel_cocor) <= 0.05){
      val <- paste("Félicitations, la valeur du coefficient de corrélation empirique est de",reel_cocor,"!")
    } else {
      if(input$Reponse > reel_cocor){
        val <- paste("Perdu, le coefficient de corrélation empirique est plus petit !")
      } else {
        val <- paste("Perdu, le coefficient de corrélation empirique est plus grand !")
      }
    }
    print(input$Reponse)
    return(val)
    
    
  })
  
  
  output$test_reponse <- renderText({
    text1()
  })
  
  output$Partie_cours <- renderUI({
    withMathJax(
      helpText(
        HTML("<br>"),
        "Le coefficient de corrélation linéaire mesure l'intensité de la liaison linéaire entre deux variables quantitatives. Défini entre -1 et 1, il se calcule ainsi :
        $$ r_{X,Y} = \\frac{Cov(X,Y)}{\\sigma_X \\sigma_Y}$$",
        "Un coefficient de corrélation linéaire de 1 indique que les variables sont parfaitement liées et évoluent dans le même sens.",
        HTML("<br>"),
        "Un coefficient égal à -1 indique que les variables sont parfaitement liées et évoluent dans des sens opposés.",
        HTML("<br>"),
        "Un coefficient de 0 indique que les variables ne semblent pas du tout liées."
      )
    )
    
  })
  
  
  
  
  
})
