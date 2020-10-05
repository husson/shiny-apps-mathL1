library(shiny)
library(ggplot2)
library(stringr)

shinyServer(function(input, output, session) {
  
  output$densite_normale <- renderPlot({
    
    esp = input$slider_esperance_normale
    var = input$slider_variance_normale
    
    k1 = input$inputk1
    k2 = input$inputk2
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    mini = esp-5*var
    maxi = esp+5*var
    x <- seq(mini,maxi,0.01)
    
    y <- dnorm(x, esp, var)
    xddf <- data.frame(x,y)
    

    qplot(x,y,data=xddf,geom="line")+
      geom_ribbon(data=subset(xddf ,x <= k2 & x>= k1),aes(ymax=y),ymin=0,
                  fill="blue",colour=NA,alpha=0.5) +
      scale_y_continuous(limits=c(0, 0.8)) +
      theme_minimal()

  })
  
  output$repartition_normale <- renderPlot({
    
    esp = input$slider_esperance_normale
    var = input$slider_variance_normale
    
    k1 = input$inputk1
    k2 = input$inputk2
    
    validate(
      need(
        k1 <= k2,"Choisir k1 plus petit que k2"
      )
    )
    
    mini = esp-5*var
    maxi = esp+5*var
    
    x <- seq(mini,maxi,0.01)
    y <- pnorm(x, esp, var)
    xddf <- data.frame(x,y)
    
    pk1 = pnorm(q = k1, esp, var)
    pk2 = pnorm(q = k2, esp, var)
      
    
    

    
    
    
    
    df <- data.frame(x,y)
    ggplot(df) + 
      aes(x = x, y = y) + 
      geom_line() +
      # segments pour k2
      geom_segment(aes(x = k2, y = 0, xend = k2, yend = pk2), color = "red") +
      geom_segment(aes(x = mini, y = pk2, xend = k2, yend = pk2), color = "red") + 
      # segments pour k1
      geom_segment(aes(x = k1, y = 0, xend = k1, yend = pk1), color = "blue") +
      geom_segment(aes(x = mini, y = pk1, xend = k1, yend = pk1), color = "blue") + 
      ylim(-0.2,1) + 
      xlim(min(x),max(x)) + 
      theme_minimal()
    
  })
  
  output$fonction_densite <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         f(x) = \\frac{1}{\\sigma \\sqrt{2 \\pi}} e^{- \\frac{(x-\\mu)^2}{2 \\sigma^2}}
                         $$
                         
                         
                         '))
    
                         })
  
  output$fonction_repartition <- renderUI({
    
    withMathJax(helpText('
                         
                         $$
                         F(x) = \\int_{- \\infty}^{x} \\frac{1}{\\sigma \\sqrt{2 \\pi}} e^{- \\frac{   (t - \\mu)^2    }{2 \\sigma^2} } dt
                         $$
                         
                         
                         '))
  
})

output$def_normale <- renderUI({
  withMathJax(
    helpText("La loi normale, également appelée loi gaussienne ou loi de Gauss, est une loi de probabilité continue qui dépend de deux paramètres : l'espérance et la variance.
             $$
             X \\sim N(\\mu,\\sigma^2)
             $$
$$ aX+b \\sim N(a \\mu +b, a^2 \\sigma^2)$$
Dans le calcul d'une probabilité, lorsque la variable aléatoire X suit une loi normale, on peut se rapporter au calcul d'une loi normale centrée réduite. Si $$ X \\sim N(\\mu, \\sigma^2)$$ alors $$Z = \\frac{X-\\mu}{\\sigma} \\ et \\ Z \\sim N(0,1)$$
             "))
  
  
  
})


output$calcu_proba_1 <- renderUI({
  withMathJax(
    helpText(
      
      "Pour calculer les probabilités, il faut connaître les formules :
      $$ P(X \\leq k) = \\int_{-\\infty}^{k}  f(x) \\mathrm{d}x = F(k)$$
      Également : $$P(k1 < X \\leq k2) = F(k2) - F(k1)$$
(voir graphique - Répartition)
      "


    )
  )
})


output$resu_calcu <- renderUI({
  k1 = input$inputk1
  k2 = input$inputk2

  
  validate(
    need(
      k1 <= k2,"Choisir k1 plus petit que k2"
    )
  )
  
  proba = pnorm(q = k2, input$slider_esperance_normale, input$slider_variance_normale) - pnorm(q = k1, input$slider_esperance_normale, input$slider_variance_normale)

  withMathJax(sprintf("$$P(%g < X \\leq %g) = %g$$", k1,k2,round(proba,3)))
  
  
})

output$question_normale <- renderUI({
  HTML("

Une étude effectuée auprés de jeunes enfants montre que les premiers mots apparaissent, en moyenne, à 11 mois avec un écart type de 3 mois. La distribution des âges étant normale, évaluer la proportion d'enfants ayant acquis leur premiers mots : <br><br>
  1) Avant 10 mois. <br>
  2) Après 18 mois.<br>
  3) Entre 8 et 12 mois. <br> <br> <br>
       ")
  
})

output$correction_normale <- renderUI({
  HTML("
<h1> CORRECTION </h1> <br>


       1) P(X < 10) = 0.369 <br>
       2) P(X > 18) = 0.01 <br>
       3) P(8 < X < 12) = 0.47 <br> <br>

       ")
  
})


output$explication_esp_var <- renderUI({
  "Pour vulgariser, l'espérance 'décale' la courbe sur le plan horizontal alors que modifier l'écart-type modifie l'aplatissement de la courbe"
})

observe({
  
  updateSliderInput(
    session = session,
    inputId = "slider_esperance_normale",
    value = input$numeric_esp
  )
})


observe({
  
  updateSliderInput(
    session = session,
    inputId = "numeric_esp",
    value = input$slider_esperance_normale
  )
})


observe({
  
  updateSliderInput(
    session = session,
    inputId = "slider_variance_normale",
    value = input$numeric_var
  )
})


observe({
  
  updateSliderInput(
    session = session,
    inputId = "numeric_var",
    value = input$slider_variance_normale
  )
})

})